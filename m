Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63131202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbdGKPby (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 11:31:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35436 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932598AbdGKPbx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 11:31:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so326873pgc.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PwFPmF83yTCndtzJc5sookmzWM1xCe3K2btfLhG/S40=;
        b=JRJI+Be/+bPM+uft9AVvo4N5GgvfmcxDY/7s26V9QUB9HM8nAHTFr2c8hkXd8g6HpB
         aegMa2zadruGRsSLiSVmbkjUrrcH9gOFk9oyR31l5JQEafNDXyFHH9KSkYIusaUWva1S
         KmAM3lGKT2pDlZ2X6lCjVecnAkdOpCpK74/TfwoUwIGZG6WO3GeLjo/QsmObw3vbzmaM
         fcUTJLFwJuzAXs2d0rZjO4FEh/nqF/ZMhAOYr7w1OjCHMgMXx4F7ndIxWM+zh/nzm0kN
         Dmm+4r5QjXs6lNB/RSYBTeHifsdULQPDmLkftUJrU6wGJTAd8sTj3j8raYSIv/PzGeS2
         GlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PwFPmF83yTCndtzJc5sookmzWM1xCe3K2btfLhG/S40=;
        b=hNGh1m3RJ9RTkkhd7uaJR1dgrsmvHhCSMejsDXx9CyFAWh1vH/FmGsUFzuLxCzu0in
         eo9Xn1Lomxs/zEmuf2L2SCTVuhJdLFnadAW79qeW+RcWLzlM4LYRuPJl1oHj1EAuhb2a
         gao88pU5S/WjOSuVT6jG39h85sOGxLGr4yTfkqhSWzH5EULr1xebBQewAgXtCoYHI7fY
         ROZ9KeT1q+NA8+gzP4jxD2wB9VmpMSPQzze2s21qZlHiA93/e2v+T0pFuSsGKmgGSLcj
         WvujJFJgw0TxJMfYaxShlevxw8/1Rv51cbvNt9O9O/m2nblDaalrolv1xg3dkTh1U/kQ
         g4CA==
X-Gm-Message-State: AIVw113xWHMsxcfF+c5CCcx5nROq5RavD+3DB56vAz7rDZARPXRnTUm8
        EYnqesaJHPJVIQ==
X-Received: by 10.84.129.111 with SMTP id 102mr505602plb.221.1499787112436;
        Tue, 11 Jul 2017 08:31:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id w190sm436945pgb.30.2017.07.11.08.31.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 08:31:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
Date:   Tue, 11 Jul 2017 08:31:50 -0700
In-Reply-To: <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com> (Ben Peart's
        message of "Mon, 10 Jul 2017 10:57:57 -0400")
Message-ID: <xmqqeftn3s7t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> If this patch can survive a few releases without complaint,
>> then we can feel more confident that designated initializers
>> are widely supported by our user base.  It also is an
>> indication that other C99 features may be supported, but not
>> a guarantee (e.g., gcc had designated initializers before
>> C99 existed).
>
> Correct.  MSVC also supports designated initializers but does not
> fully support C99.

Thanks for a datapoint.

Just so that people do not misunderstand, it is not our goal to
declare that now you need a fully C99 compiler to build Git.

When deciding what shell scripting tools with what options in our
scripted Porcelains and tests, we use POSIX.1 as a rough guideline.
We say "let's not use this, as it is not even in POSIX" but we never
say "use of it is OK because it is in POSIX", and we sometimes even
say "even it is in POSIX, various implementation of it is buggy and
it does not work properly in practice" to certain things [*1*].

C89 has been the base of such a guideline for our C programs, and
people must not to view this patch as an attempt to raise the base
to C99.  It is rather an attempt to see how far we can safely raise
the base by checking some selected useful new features [*2*] that we
have had occasions to wish that they were available, and designated
initializer for structure fields is one of them.

We may find out that, after starting with "C89, plus this and that
feature that are known to be commonly supported", the guideline may
become more succinct to say "C99, minus this and that feature that
are not usable on some platforms", if it turns out that majority of
the systems that are not fully C99 have all of the things we care
about.  We do not know yet, and we are only at the beginning of the
journey to find it out.


[Footnote]

*1* Like `backtick` command substitutions that is very hard to make
    them nest properly and impossible to mix portably with quoting.

*2* New, relative to our current practice, that is.
