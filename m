Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67AC3201A8
	for <e@80x24.org>; Tue, 21 Feb 2017 06:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdBUGhS (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 01:37:18 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35912 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdBUGgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 01:36:16 -0500
Received: by mail-pg0-f66.google.com with SMTP id a123so13842320pgc.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 22:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YFkBnFSmcb6BMFHcRAC3Qs+hPopMbJz5Bu9KmPi8pZk=;
        b=pXqqph0TqOPTdYvox1w5k/LuIcAT62CjLWWGCh8jmXvJ07BHOCrljyWId5GlDG4OmL
         /bqNOvXigXt4JjagO9gBMM8Hut7/heH8XV+cJNHJNA3od6pKUjEnY0qU1RePDEi3LsGJ
         uBdQpYd/IoUPDMA55vQIA83P/Y77isDhyNCYVd5sJ485AEEEfj2AGZeRbaJ393Xsocqc
         LKVD+sSFxL+qr4OgyrUkcKrAZ2p3Yijb4M2YLcAyMNieKdA6OV6G8grgeCLEHPpO5NBn
         Hv1BRnIT6aoNPwkdDYmtn2zpc0imPSymiyYkapEQsS5SfyvBkpob+Z1Xs13Zd9BMMpR7
         10zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YFkBnFSmcb6BMFHcRAC3Qs+hPopMbJz5Bu9KmPi8pZk=;
        b=uGbGTQAgxa24Gx8T1Bg/0+A+RjZVCJDirhXkNlux+7Wat7rEyChoL1vENGLtc4vD4t
         rHl8eySRY9VKbeJb1u6VfUMEwj8guDnAnm7mrTneiLpclsmo0IhUbqNzeDMLIJ1pU/ld
         DFcfXw2VCdq94T6CYe6SrANnItSZ2awSVnLoqXwH7baXhbf8e2gT7r3QyRO5AAmeWB6e
         behC8UDMSse4O0wWC/drtM9O7/2p55xfzRB6lvnocfAUcBI6FOpkDmFO+aLB68wHZlF5
         OqYjHwERM0xg2+GnRlVc52a5qIVesRFUx2rHXbYbCInLzc32SacDwhDlk3rCaDRYw6hw
         9YlA==
X-Gm-Message-State: AMke39lNG7uIFLXleoBISHBaj3gju/WKIne737jgXY/6ZwVEwYLLHZKUGMcafGh/AQ3nYg==
X-Received: by 10.98.196.202 with SMTP id h71mr30736638pfk.66.1487658975864;
        Mon, 20 Feb 2017 22:36:15 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id l22sm38714805pgc.43.2017.02.20.22.36.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 22:36:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: print an error when declining to request an unadvertised object
References: <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
        <1487470080.3570.8.camel@mattmccutchen.net>
Date:   Mon, 20 Feb 2017 22:36:14 -0800
In-Reply-To: <1487470080.3570.8.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Sat, 18 Feb 2017 20:55:08 -0500")
Message-ID: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> Currently "git fetch REMOTE SHA1" silently exits 1 if the server doesn't
> allow requests for unadvertised objects by sha1.  The more common case
> of requesting a nonexistent ref normally triggers a die() in
> get_fetch_map, so "git fetch" wasn't bothering to check after the fetch
> that it got all the refs it sought, like "git fetch-pack" does near the
> end of cmd_fetch_pack.
>
> Move the code from cmd_fetch_pack to a new function,
> report_unmatched_refs, that is called by fetch_refs_via_pack as part of
> "git fetch".  Also, change filter_refs (which checks whether a request
> for an unadvertised object should be sent to the server) to set a new
> match status on the "struct ref" when the request is not allowed, and
> have report_unmatched_refs check for this status and print a special
> error message, "Server does not allow request for unadvertised object".
>
> Finally, add a simple test case for "git fetch REMOTE SHA1".
>
> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> ---

Hmph, I would have expected this to be done as a three-patch series,

 * move the loop at the end of cmd_fetch_pack() to a separate helper
   function report_unmatched_refs() and call it;

 * add a call to report_unmatched_refs() to the transport layer;

 * enhance report_unmatched_refs() by introducing match_status
   field and adding new code to filter_refs() to diagnose other
   kinds of errors.

The result looks reasonable from a cursory read, though.

Thanks for following it up to the completion.
