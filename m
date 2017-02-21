Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86B3201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbdBURCA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 12:02:00 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35453 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdBURB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 12:01:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so11918640pgz.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 09:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bZTAO3Tc284CVBeXrWij/gc7yA+5/p+uAbkg56r/Azc=;
        b=Vb+yD9ceTGn2z/WkM7ztEE6HGssvIDGJhF9dL3QvklFm732ofVCfahEzH5WdhgQD1l
         ceWYHAHoBZZuH33AhhfNQ1NyBgzI4rfcFfn9ZPwwiw65mICsz4mOT0jUdRHIYeV9Q7FG
         s9EmB+IHtYcUi1jyGIURCo3uBwjpttO0l0n9tI9IdovcsGb4UqBvbIjXey6KiPAknV6i
         DgtDo+19eNnq7NwTVaL+xisdCElOf7XXZ4MUKsjoMEj+8gLKuydJ+PRqixw4cpCHzx7i
         DrIgznhTDeYbFd036O5OSvXzSfyj1QFMRe0wwZYREtbiy2marO5KMqB/6iQpdEUWAldq
         nFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bZTAO3Tc284CVBeXrWij/gc7yA+5/p+uAbkg56r/Azc=;
        b=dWDIJVxSbJSw5joagee4izPOYd8VYRFCMvbWzd5RGO9LXu+R5rKkBwswaixGMMzqqG
         674Sj6uRfgWOy+05DPOo/SENQ04fQNpDZNBB8z1wxOEZkg8tEtjGDXPgcffpDRZeEy++
         wQuaBeb/2AXVhS8e0WrGhHnN9BoKhnKk7wnRmzoPzuDH+GbKvOrZ6pTIdNlBZ22CLOaj
         TU0OVUEvhNhVZxwX1ZzwblegGdgAxVlC5nPcyiz2vmkKtVH+tUjq8TWT3it6AIIIj5iE
         fDjaTfCzgPm3WIpHpTwXCAG8or01BQb21YBed4Wq7V6lLKQy9Ju0BGHImty1ZVZCQLsR
         mlTw==
X-Gm-Message-State: AMke39nTN8xUxxOM7Z+ncnkgiCG9EJiVh/lP/JIWllBYg+RYWIYcJG2uW1jQdZ+bkc07cg==
X-Received: by 10.99.7.138 with SMTP id 132mr18641789pgh.121.1487696517950;
        Tue, 21 Feb 2017 09:01:57 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id b67sm42117151pfj.81.2017.02.21.09.01.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 09:01:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config on the command line
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <20170221073813.w4zrkky2d4drnwbs@sigill.intra.peff.net>
Date:   Tue, 21 Feb 2017 09:01:56 -0800
In-Reply-To: <20170221073813.w4zrkky2d4drnwbs@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 21 Feb 2017 02:38:13 -0500")
Message-ID: <xmqqino3h3zv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +. ./test-lib.sh
>
> There are a bunch of other "git -c" tests inside t1300. I don't know if
> it would be better to put them all together.

I considered it, but it is already very long and I suspect it would
be better in the longer term to split the command-line one out into
a separate script, for the reasons you state.

I can move these at the end of 1300 in the meantime, and leave the
split for somebody else to be done later.

> Arguably, those other ones should get pulled out here to the new script.
> More scripts means that the tests have fewer hidden dependencies, and we
> can parallelize the run more. I admit I've shied away from new scripts
> in the past because the number allocation is such a pain.
>
>> +test_expect_success 'last one wins: two level vars' '
>> +	echo VAL >expect &&
>> +
>> +	# sec.var and sec.VAR are the same variable, as the first
>> +	# and the last level of a configuration variable name is
>> +	# case insensitive.  Test both setting and querying.
>
> I assume by "setting and querying" here you mean "setting via -c,
> querying via git-config".

Yes.  Should I update it to be more explicit?

> There are two blocks of tests, each with their own "expect" value.
> Should the top "expect" here be moved down with its block to make that
> more clear?

Perhaps.  Let me try that one.

Thanks.

