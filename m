Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2AE20248
	for <e@80x24.org>; Wed, 27 Feb 2019 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfB0LhQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 06:37:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53437 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfB0LhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 06:37:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so5445169wmg.3
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 03:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+deXaZFSGlkasasir4hNvWAMN9e0mmzwHBTLlNtoycM=;
        b=Jhcztn0iggAR+/6/9aVX7s1rGj/J2AxpmfNu2RhXNVT1SM84P/x1zf4ivFu/4+C740
         xpd6xuwKgitn9kKLNOJB+uRtqlA9mJOxMc3yCqVFBdkd3QgPJ/QtcvZwx08RVDmSvpQj
         6WoreiF2IUpa7EIl2q+A/gm4bohc9ha7TRbuyzRiqGurEpYITq2HnXQbhgdx+hjJHTBu
         2Hw7rst/GSgHTeKorPcdbAw66dF2H3PJCZ6PLuK6yoT0CJJX+EaceXLvFAPzJcRnWcVj
         16zWQgq4yBQdJls/IABoZYo42ltcbXXnc2oTXLJsT7icTJipO8jgpoSuWNN6ZRRWN1G9
         4XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+deXaZFSGlkasasir4hNvWAMN9e0mmzwHBTLlNtoycM=;
        b=UzwfpSKSJ4MHO7l20lgJ/RoEcCn5lzXK9UTB9h/qx0kpi2PIfft5npLZSrbBz8RxNY
         4Z0V3E+HERgYG/chaVj4C2+2Val8N61676LOOHVJqX4ziaOw9DwQNwRs7g80BDmjFZRF
         dSomDZU74BH67ZBg6lWQ12FPWd7ioUr3u2hyzDqdk+94uszi+QYBYP+4WZjvDYymO2xX
         w6azowRkqjiGY4Pmcr6OpQWUEM7P7uW61521S7/qo6jY1c3Bb9l8GIip4EOKFQUDtfBd
         jhpubdsQzDnY34FX0bJOs2iGyfINItX4+gVGWDQWht8RDAf8oTo19ORhgePf/McyOykD
         LBSA==
X-Gm-Message-State: AHQUAuZaSbb580R7xBj+m1Reys2k2iSyN3gYpRm5NmeciH2i7aRrInya
        zbjGfuH35vmS3ffEdG6Ta3Y=
X-Google-Smtp-Source: AHgI3IaMDmY90cHCOP8dK7bBl/ZQ4/EXySbeboMK133RRXG/LnTxyIVeAsd1SzjiF2TO26a89RttLQ==
X-Received: by 2002:a1c:670a:: with SMTP id b10mr2071795wmc.82.1551267434327;
        Wed, 27 Feb 2019 03:37:14 -0800 (PST)
Received: from szeder.dev (x4db6969d.dyn.telefonica.de. [77.182.150.157])
        by smtp.gmail.com with ESMTPSA id q135sm3521061wme.43.2019.02.27.03.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 03:37:13 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:37:11 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
Message-ID: <20190227113711.GF19739@szeder.dev>
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 06:07:42PM +0700, Duy Nguyen wrote:
> > It was discovered that the --no-gpg-sign option was documented
> > but not implemented in 55ca3f99, and the existing implementation
> 
> Most people refer to a commit with this format
> 
> 55ca3f99ae (commit-tree: add and document --no-gpg-sign - 2013-12-13)

No, most often we use

  55ca3f99ae (commit-tree: add and document --no-gpg-sign, 2013-12-13)

i.e. with a comma instead of a dash between subject and short date;
and without quotes around the subject.

Truly sorry for nitpicking :)

Gábor

