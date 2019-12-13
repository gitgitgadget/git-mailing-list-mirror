Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4584C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 01:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3A22527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 01:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbGqCDVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfLMB4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:56:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38046 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfLMB4w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 20:56:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so578101pfc.5
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 17:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Qf2LKDSmmnY8HlBnddBrkUsQOBRBxpAYCIr/MpbekGE=;
        b=HbGqCDVS9N2OApG/NRct0aaiCXYLcVwnCp+TOgoad77jOSylCjsN/6ak4l7Cx2yu0Z
         fra7KkZW0yqcoisKKbZzSqxeMgquF+BwLdTYFsEr9HdKTNV2bv6zrpCSe3pOm0l3JEfo
         Ozr26vWKUtcL9CCABywD4wjizn+ngiez4HU251DEmpqKnKEtO9VHQ4j3yxfnf6bhutlm
         t1HW6t+Y1IvMrJ1ZdpeCCur/0rSs33qtSMt+k3J7J5tRwls4n/q+RRcxwPXybMOERQS1
         Iqr1Qio06gX3a0onU67T+FSxuyFR1jijO1pQErfT0Fvg+giTpBYxvjxmw63C1uqxUEOG
         W9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qf2LKDSmmnY8HlBnddBrkUsQOBRBxpAYCIr/MpbekGE=;
        b=dPhNWICpj4e8uLzVdSbhF2euwzo13TP/I4Ex0hEezKa0RdDPgOGP/72aoLb0xE8T38
         Yfe/4KP1Cc59vlzsosBgul9wbMAPETozZ7wZ+vSHDvSFK7YGGE9UnxrRMxi050XNhpD0
         6+xkaa7t2W0Ty+dx1ObivdPhw54Y+d8/kC6jo/Cgc1mzk4yGolnCTmfV2FrHrAtsF887
         vORCWmorVbt+Ttes/szDbjDOH2phxDzjY3drKSCnnnLSs6fbVcvfJzZR/sdPrRVgsFm3
         xNmz+xRmMWJCdxR347J+ORF5Am8WHcfEZhdCwR4AvDUguN2pnVOK6SDonqi3layf6+Zh
         L/Kw==
X-Gm-Message-State: APjAAAWTxz0WKAHvKuknAr8fPUmAZi00dydi+l38YMSgn0bmeBv0CDlM
        5A7EFc6cl5QiEIXVu5raTEfmcGao
X-Google-Smtp-Source: APXvYqx4otWgKA2dIB1d31zy5PKG7kSJ6Qgk6KMVpmob6nxIz8kANbHFCLYyrSFSeAH1FTcDk4IkYw==
X-Received: by 2002:a63:6f8a:: with SMTP id k132mr14436703pgc.70.1576202211261;
        Thu, 12 Dec 2019 17:56:51 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id z10sm8767779pfa.184.2019.12.12.17.56.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 17:56:50 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:57:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Gmail munges dates?
Message-ID: <20191213015753.GA14249@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It seems like Gmail is munging the dates on patches sent. Before today,
I've been sending patches out with mutt but I decided to switch to
git-send-email today since I was forwarding a patch that wasn't mine and
I wanted to preserve the date as part of the authorship information.

Unfortunately, it seems like mutt wasn't the culprit, it was Gmail
that's been munging the dates. For example, in this patch[1], the date
shows as

	Date: Thu, 12 Dec 2019 16:44:50 -0800

even though locally, the output of the format-patch shows as

	Date: Mon, 9 Dec 2019 19:25:34 +0100

So two questions related to this:

1. Is this something that we care about or is it okay to have fudged
dates? (I know all of my patches in each patchset only differ by a few
seconds and it seems like no one has noticed or cared so far)

2. Do we want to introduce a --in-body-date option or something to
format-patch which would include an in-body Date:, similar to the
in-body From:? (Also, while we're at it, maybe we could include an
--in-body-from to force that to happen since that's been a feature that
was requested in the past[2])

Thanks,

Denton

[1]: https://lore.kernel.org/git/8691ed2b84f7ee6b7c12d04d57a541bf22660333.1576197846.git.liu.denton@gmail.com/
[2]: https://lore.kernel.org/git/20191010225405.GA19475@sigill.intra.peff.net/
