Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB311F404
	for <e@80x24.org>; Fri, 30 Mar 2018 16:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeC3QYw (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 12:24:52 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:43365 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeC3QYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 12:24:51 -0400
Received: by mail-wr0-f177.google.com with SMTP id p53so8422937wrc.10
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZaGszbTs8tZnoDweikHYfgG+rMu03IZLvZcQpLyjSTg=;
        b=OoY7ABkE0yHAasyhQCOgEZ0E2o9LDDlB7AaAD2mwxBa8ks2DWMGkWu0l3EagGf52qu
         WmiNCouoT9OB2A0GrA5PBGt9ko7mTAvCCcu1/RVWYWeyyHcQLdPy3fgIxnEtpX1z8wtZ
         bhV+C3XIrjBidJHLNKlld6YCYk2YmSiUCp9qmHKIVFzzs2l/8olqD1Y1XMGnC+DDnMJb
         h/YGxui/cwPOlmgew0ppke62EmYig4Mx1BIObi5ZtlIEVXKw3PpcQk5lM2hkblZ7H27Z
         YeDEAXBJFEExqw2uJA7xpH6BRkK3fD5FGeg2AZIlXg0bBKFGMpsiuwEl3KDPFfHF05Js
         UVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZaGszbTs8tZnoDweikHYfgG+rMu03IZLvZcQpLyjSTg=;
        b=PqfkPTWkGghJ6s2U9zibH76wt5Iyxm+0qJ9N5mSoTdRmRm+cgXHHFP9cM/+2zeMkgO
         hJ58YyT42PaMW9mPwjH+iwJ1Xmso09z1tsYkmRthdGg+PPDquvH4vhtCAZ2tHxJqohc9
         LjNmqLY2k2TD/xy5QEiaHWknojathrtnpXukaKm2nS3wzi1fRAn2RJBlc5p+NCw+KKWf
         sBEurMz+AE2cs2p4vgkq588oVLUv9VGiE8Rt5DiKGEkDIxKbnZ4Yr6+VTsQxl9ZWnApT
         qVby2yBIyo2rTPfMYjliYw3rrWmafAuQGY/7r7+xtdVckUI4e56EUBvXFZjR6XdHpIxz
         3dgQ==
X-Gm-Message-State: AElRT7HWygUsQD5aJ4GmsHuuKdUVyBbD7NxQ6zgrwyGvZq8AtO2VezdS
        45iCxt7dj20jYn0zTPIfMcLz6Ci2
X-Google-Smtp-Source: AIpwx48oGySRTd5gj0dIadSU1EVzk9UVvZ+Qd/2KgJJViffGGPclyKYUq1sJj1Lsqhh+IoqG/YItVQ==
X-Received: by 10.223.182.79 with SMTP id i15mr7370183wre.162.1522427089430;
        Fri, 30 Mar 2018 09:24:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r19sm7483275wmd.48.2018.03.30.09.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 09:24:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
        <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
        <20180329194159.GB2939@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
        <87in9dwsxl.fsf@evledraar.gmail.com>
Date:   Fri, 30 Mar 2018 09:24:48 -0700
In-Reply-To: <87in9dwsxl.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 30 Mar 2018 16:15:34 +0200")
Message-ID: <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think if it's worth fixing it's worth testing for, a future change to
> the config code could easily introduce a regression for this, and
> particularly in this type of code obscure edge cases like this can point
> to bugs elsewhere.

Yup.  "The port to my favourite platform is too slow, and everybody
should learn to live with thin test coverage" would not be a good
strategy in the longer run.

