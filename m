Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B84201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbdBVRHK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:07:10 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35050 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753983AbdBVRHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 12:07:09 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so1240026pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PzbxgypuzSpwhU2vhLmsGlBbcWMUiZs/SUbj0/S9Yto=;
        b=hQ3YqNzPAcbN18SfmELY6Cofy3WBfLStWFRD/pUfpnBDBmuBUjYLydHjJ1DAyeMuF5
         3VBeQtF0j1lhkx0wdXvk6MZuqkumu2OWohsFky1JVxUdTHudXbYSbxTUgnzaSQGT8WJT
         CdSKAaDCRo4RebaTSlAHLzpVtNRL7lOURSfY5oXYsNgpqQidOpl2p+mduV22CXy6Y5w1
         ckHAQDe39AJbPUHdkC0BTYJnlzioqA5Wq4B2UxWjyP9Z3Qjm4iO9w8LNEpdjY3Va/q1L
         DoLpfAYkyJPPrcZEtcE+1QthCXSkB60psmh4Ae8mguP9zD5guwu7q9tiMruo/inA1Lkj
         B/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PzbxgypuzSpwhU2vhLmsGlBbcWMUiZs/SUbj0/S9Yto=;
        b=duCPN9Hhk47e9KRchHqk2MGzIQ53F3cXjSJb4cgHuhImYDQzeB/cjpT+410Zpj3UWD
         H3RI11nr4KW5Sh+4wkJ0MOoIO7V2ALGr1A2va2CWrIqqlBO6b+2QZPfNfOc9ViQJ6dgo
         pF+oXQ80gI0t/gtTM7PP5/ftUrbX9voLv1W0oBctkWPxT4gYMUIvsvf1afzVyDUDcZI/
         3FtTYJlXuh8i+0V6l79vBCDcaGbskdfCD553DW7yRy6TaeJdttK86MYJdbFKWrjCiZqi
         63JcmCw8I9nCKTjoOtRTvzrS9aLtyQsMD+vw/gvuaXQyPe5g/YSc3UG+fTre7MS4egu8
         wT3Q==
X-Gm-Message-State: AMke39mOdWU0g09u/FeTn7Om9kusBa9iQkpwU26dpmLZXgPh6qTRDe05OL11opevI6ySZw==
X-Received: by 10.99.238.5 with SMTP id e5mr42977648pgi.49.1487783228578;
        Wed, 22 Feb 2017 09:07:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id m3sm4785459pfc.66.2017.02.22.09.07.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 09:07:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: print an error when declining to request an unadvertised object
References: <xmqq60kfezr9.fsf@gitster.mtv.corp.google.com>
        <1487470080.3570.8.camel@mattmccutchen.net>
        <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
        <1487780254.3016.1.camel@mattmccutchen.net>
Date:   Wed, 22 Feb 2017 09:07:05 -0800
In-Reply-To: <1487780254.3016.1.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Wed, 22 Feb 2017 11:17:34 -0500")
Message-ID: <xmqqwpcicfye.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> Anyway, I made a split series and will send it in a moment.  I don't
> know if all the commit messages include exactly the information you
> want; hopefully you're happy to edit them as desired.  Compared to the
> previous patch, there is one fix in the net result: fixing t5500-fetch-
> pack.sh to deal with the internationalized "no such remote ref"
> message.

Thanks for going an extra mile.  I think many developers in the
future who reads "git log" will thank you, too.  The changes,
especially the one in the last one, are very much more
understandable compared to the original, even if the end result is
the same.


