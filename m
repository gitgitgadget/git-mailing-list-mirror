Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88721F463
	for <e@80x24.org>; Tue, 10 Sep 2019 07:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfIJHo3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 03:44:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37846 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIJHo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 03:44:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so8295918pfo.4
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D0dNEkv5lwR4INSA0XiYWRJ7dSvbi79p6oQmSoEZF/0=;
        b=QU6oH0ZvhqIoesJNpyA6M5t6cIi0Tj6qBaHvjYu8cxiXXrdVtwiiy5aQIFb8RkkyeS
         j0xSznuCoCj4Km92nGspA5NZca8krGiabGPf4jJTEY5y+F2Q1wKf3ObdAKs9DtiVB3SI
         dj2cg5yYA4w3cd0U8p+pG1REP6eo62JESlTg91D3y1dgmoSBJopxytSOjTW1TdmVIU0r
         yuHS2Y1caWkWdNQGxbDIdcNSEFwAhqf/MUg05noNP+f3N8uQ2G9MHwQ332PrsaB6Toq6
         qRjPHXQsQpl2ztYgQDwLdDBDeadX5fCsIiGIc/hG3q+P2M2uGQnQJnsoFDGRZ7b14ViZ
         le1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D0dNEkv5lwR4INSA0XiYWRJ7dSvbi79p6oQmSoEZF/0=;
        b=K4zfoW5LLXmuemVMqKjkWov/XvS/NzTr31BjDtL/4b1gyuTH57auV7vSl9OVIIc+Hy
         hbCoxOYcyirQMKt4C3cMSAcDZLy74FiV/b7oVbmfWVhgbcsl15K6jZ/m9c4+tyMp3brI
         k/A+xv9kjmUDls7sTo2kKpy6TkT+H4tJa2kfEXQP8KsVACixWqw2Va5ik77giVSzGg3k
         vuG6/fYNVPtpgor9u74RE+HLaQnLPzDW75+oxonEZ3MTN4d7T2c02K0Oox+V5TDxbVyU
         px3Oz6Niwugh1UEIs/ggws6OeXCw+rjQOJpQwOiOIH00Qyu0Ps9vursm3bte69oz73Ia
         fT9g==
X-Gm-Message-State: APjAAAV7MBVuHYi6gQ4kskZ99Doxl99WH3biwJqOnvQLXjrN61RmJPXn
        UUL0o0i2CvOxXaQq1X2mg4eJA+p3kBM=
X-Google-Smtp-Source: APXvYqxbQsTZAubpSBaSkvYoxrQKfNVnPHjqsXfiM6lGr1JHeZXBDsNiB9EWqvCG4oNaZzcK1iUE8A==
X-Received: by 2002:a63:2887:: with SMTP id o129mr25894304pgo.179.1568101468444;
        Tue, 10 Sep 2019 00:44:28 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id a18sm15011729pgl.44.2019.09.10.00.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 00:44:27 -0700 (PDT)
Date:   Tue, 10 Sep 2019 00:44:25 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Makefile: run coccicheck on all non-upstream sources
Message-ID: <cover.1568101393.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when we ran coccicheck, it would only run on files that are
currently being compiled. However, this leaves us with a blindspot where
Windows-only sources are not checked since Coccinelle does not run on
Windows.

This patchset addresses this by making the "coccicheck" target run
against all source files in the repository, except for source files that
are pulled from some upstream source.

This patchset should serve as a continuation of the original discussion
about running coccicheck on all sources[1].

These patches depend on "ds/midx-expire-repack" and "dl/compat-cleanup".

[1]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet/


Denton Liu (2):
  Makefile: define UPSTREAM_SOURCES
  Makefile: run coccicheck on more source files

 Makefile | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.23.0.248.g3a9dd8fb08

