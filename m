Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D487B1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeIABso (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:48:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIABso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:48:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so12429432wrc.0
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Awg/snLsYGajW4q76j1Fsmsvba4SlV3NO7quGCERosQ=;
        b=qarvG1/MItuOLObvh3mJdApAIX9XfxtomotvkmkEVcbiooAuLAIZmt62ElPgphM/vZ
         SSfeyRvKEfTkgOwTB+jJeKwMOmk7SaewktRxj75jHLbgksrjYWWYxpgP0OYeMXerWV7L
         9AQQtpGvDQsx4N+l38wMvUMEWj3TAKJaHKk47A5qg3hFPhcqXTWEAspJMjruXeTusP10
         tFjW6Tj38HCzLDto7CMaezvcbpd2cxgkMz6BiD6s2Rz7Kd3bOIHaAWffNZyxcMZ6Mu9s
         zhMlX9EzUCKXRb1j1z7C8gAf5QRiElHX8qowVHskQM3cQkB9UmXxMWRYH5gBbEwdDnMz
         xt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Awg/snLsYGajW4q76j1Fsmsvba4SlV3NO7quGCERosQ=;
        b=OZyszLPmC42CHYJoiWA7Fe25OcwnU5IyY0rqTQhBy7pzM3cV/jxgX1IMLZzAb8y0za
         4EDXSJ9OxhJaUlTsl3xSR+6DG4vk7wSlAcxxw55nNv+BzRQzT5q0yutUexrcuAco0/Q2
         3fYfRKAfkQDEMWcpVW3TQBDtu6euGU3XcsC+0WRzkRNNOytIrQOVhTZScJ1B4XZin2rL
         /sjoDrlOumL7dzW2nFbUISpvNmm2MsWVpvKSsr0VXx19a1dDkw97xgXzqm3dj2CWX0rw
         BoOqzGMP7LO1hXY66L++YCFMFUcADVAFLx3iKai8yUovm8seFFSA3TobQTGVKOD/+ly4
         sBkQ==
X-Gm-Message-State: APzg51Bq+i2cgtgYkpJyxdhVydJ3FbmA9qsS5V+Xk64FPNosIPsr4Qik
        MnjYyyReT7Mi1k7wWnrYRUQ=
X-Google-Smtp-Source: ANB0VdbjTeSdCqbshaN3KCSXgNZuXSSu7RoQja6fbg1AImL/PFBHcPiPEB68CfOik2bJRi4Wug59KQ==
X-Received: by 2002:adf:ed04:: with SMTP id a4-v6mr12519534wro.262.1535751559609;
        Fri, 31 Aug 2018 14:39:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u7-v6sm10284163wmd.46.2018.08.31.14.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 14:39:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jann Horn <jannh@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] t5303: test some corrupt deltas
References: <20180830070548.GA15081@sigill.intra.peff.net>
        <20180830070932.GB15420@sigill.intra.peff.net>
        <xmqq8t4n69gy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808311155410.71@tvgsbejvaqbjf.bet>
        <xmqqh8ja360p.fsf@gitster-ct.c.googlers.com>
        <20180831194727.GA5120@sigill.intra.peff.net>
Date:   Fri, 31 Aug 2018 14:39:18 -0700
In-Reply-To: <20180831194727.GA5120@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 31 Aug 2018 15:47:27 -0400")
Message-ID: <xmqqbm9i1aih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> So instead of typing 3 lines, you can just say "yes we use echo that
>> emulates Unix".
>
> I actually found Dscho's response much more informative than a simple
> yes/no.
>
> At any rate, it sounds like we are probably OK with echo, but I think it
> is still worth doing the defensive patch-on-top that I posted.

Actually, Dscho's footnote was much more informative than the "echo
is from UNIX, dammit" that didn't convey anything useful---yes, we
all know that echo is from UNIX, but what does he do to it?  Does he
want it to be like UNIX, or want to tweak it to suit Windows taste?

Reading the footnote again, from there, you can read that 'echo' may
currently behave like UNIX, but he guarantees that it can change any
time without notice; in his mind, 'echo' in the ideal world in the
fiture on Windows is to use CRLF.

So we must protect the test from his whim by using printf.



