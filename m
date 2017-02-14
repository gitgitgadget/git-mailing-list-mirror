Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457AD1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbdBNSst (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:48:49 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33879 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752814AbdBNSsr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:48:47 -0500
Received: by mail-ot0-f196.google.com with SMTP id 73so18418588otj.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dKq2MTEdUXhosyJFc1GRIFrsA4ll9ZAXNIXr6NJ0AOo=;
        b=obpnALsqY2FftpO+FxtC2a3I9JYMGSKpiYTrYwukY2FIAAnTy5N+VHc2WOFWPMyWH6
         jIqvBDHscDa9Q4pMaVihNjPygd7qJNBPFRb5pOaz5tckTopRUF0CR865Ch7liqqs/PjG
         H1UV7iaVRaKgA49dEQC6rTWGW/KKymVzAt8/2SYqUnvUA8oUTeW6AYIceultjAp4GhHS
         BZBCQM0mXOiP0r3ulT9gBKV7EBoFjsLfbJPLq6Z84KRi5afCbf4bMju+zVV0tI8s/ZVj
         C76trPvkClPY7/zz3Gb7X6nbz94tz1q83vGUmXdjt8gUkWSJ0Az0NnHrvuFZELyjTg66
         f5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dKq2MTEdUXhosyJFc1GRIFrsA4ll9ZAXNIXr6NJ0AOo=;
        b=FbBddrlcOfBpgbdV0afcOuCOd0KTX0ql2Bi2tw1B1b8XYCCNDY/WY7P4/vfRoP0HpZ
         V+tSYdbPUl6kSnBT1gCWVg73YHtnvTcZXy3V0HCM3CqBKFyWxPlAeJngEWjtpqUcJyFY
         +k2Ii5vFPvqQCZwgx70D6QwIipBSpXocn9HCopFRXHeDD1WzrAg5xAupvr14B/yxG/aT
         P4VrruagKp9MsUZHqrq2qmdFHFxl6SQnJLraOjiy96RhMyxO5trCcnsNfwTDwA0b7ISS
         VAHP8nC0ksNkvLNjA+VOUPo9HUPmjO0xS7wDeCf20pOJRCiOgxbIP0YtRMR/4VtV+dtk
         XVYw==
X-Gm-Message-State: AMke39nAvXyJj+kagMeu8IH3o3vlO2a6bbvV2+cjuENlQIhWZ15d0ZeynttCMbqFbTzJrA==
X-Received: by 10.99.152.65 with SMTP id l1mr34760117pgo.28.1487098126595;
        Tue, 14 Feb 2017 10:48:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id y201sm2730091pfb.16.2017.02.14.10.48.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 10:48:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
        <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702141545380.3496@virtualbox>
Date:   Tue, 14 Feb 2017 10:48:44 -0800
In-Reply-To: <alpine.DEB.2.20.1702141545380.3496@virtualbox> (Johannes
        Schindelin's message of "Tue, 14 Feb 2017 15:47:05 +0100 (CET)")
Message-ID: <xmqq37fga9rn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> OK.  Should this go directly to 'master', as the isatty thing is
>> already in?
>
> From my point of view, it is not crucial. The next Git for Windows version
> will have it, of course, and Hannes is always running with his set of
> patches, he can easily cherry-pick this one, too.

What hat were you wearing when you said the above "From my point of
view"?  Were you the "Git for Windows" maintainer, or were you a
contributor and a member of the Git development community that works
to improve the upstream?  If it was not clear, I was asking the
question to you wearing the latter hat.

To put it differently, what is our position, as the upstream
developers, toward those who are on Windows and wants to build from
the source?  It's not just Hannes.

Is our position "unless you are extremely competent and are willing
to cherry-pick missing things from Git for Windows tree as needed,
we recommend you to build Git for Windows source instead"?

It is inevitable that the upstream lags behind in Windows specific
changes.  Even though you have been trickling Windows specific
changes (both things in compat/ and also changes to the generic
parts, updating "c == '/'" to "is_dir_sep(c)") in, and I have been
accepting them for the past few years, in order to reduce the size
of the patch pile Git for Windows needs on top of the upstream,
until the patch pile becomes empty, it will always be the case.

So I won't object if that were our position.  I just need to know
what it is to adjust my expectations, and as far as I am concerned,
you and Hannes are the two people whose thinking I'd trust regarding
what to do with/to Windows users; even though I keep saying "our"
position, I am asking yours and Hannes's.

Thanks.

