Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC24320248
	for <e@80x24.org>; Tue, 26 Mar 2019 07:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfCZHx0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 03:53:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33848 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfCZHxY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 03:53:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so7899406pgq.1
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fRBVO+tdZ0RV4AIHOSBVwKyPeY09NRlNAuC3uTvfO2c=;
        b=TxwXb28KggUhODXsipSiLYTk75wn1qd8U7mqzCEvIzIJK1j62OGFw8MHPtxqlJpgl5
         +jndDhntAtNn2YTD09lh9PR08Ul/fpHRbG6ElwAl+1Hx1eHApSbkSmf9jDqGLYHIM4EZ
         SF2Mf5EpPfNrCrY+QZSPJo20pYeirWIcp6LovYT5bkyAlh8wTL+LY3dJAzLhfIUNsmpf
         Lgu37wam2dRsMuItJKWJZO2lfdwNvT2aVvAoI56T2KOjq4l4oJ8/yuK32YBZ8shI1lV5
         ICnOKacJ0xb60AF/uU0qUtcDzL0eOsF/sPGteaijEVvzNDKjijow+bNlgx6lZHFTa5aW
         fW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fRBVO+tdZ0RV4AIHOSBVwKyPeY09NRlNAuC3uTvfO2c=;
        b=CWIzFhDCS78paBZ8wvcAKnhk2aCzipDRzydfAknTdn2CNwg1iOGletqznEYRcRjzrY
         2HEygzet89+BbOtMxbEwMkqDZt0Z3kJCWN/yB22HUu18HL4IQh2Hj1q8z4bfPrtvdrOE
         jeW0MEsmo1nOJDpZ1ARiuJeaEemoyq0XQ8weL/xorhuvk4svw3nnm6N0ptBTVpe7Ffyn
         hp8iVF6VCFBBc+nC5eTWylwQk7qoJL8duUfUDsM1Zt9DrZ616cEMUSdnkFVB9B6C+g3/
         RYrOnMpe4R0zjAy0nlQleVe0kxaL0rHx6i6tUjoWm88pMpnasTCHJxVgCRH7Cbmy1p60
         P4+w==
X-Gm-Message-State: APjAAAXd/C+u6JlwSgY2rRz494Jy5dIwnf+/zlFJh8wp66eur2GucFVs
        EbV3rJT1xwvEQTE0IW3yfW8RRgXl
X-Google-Smtp-Source: APXvYqxUXPyikWsJOu828v0+LaaOVnGsRwwQFoFK98kolH7BTc4xfMJriJ+TRkA2tZzokeAUXBx9Ag==
X-Received: by 2002:a63:6e8d:: with SMTP id j135mr27224120pgc.160.1553586802916;
        Tue, 26 Mar 2019 00:53:22 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 10sm3920524pfh.14.2019.03.26.00.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 00:53:22 -0700 (PDT)
Date:   Tue, 26 Mar 2019 00:53:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: [PATCH 2/3] t7004: ensure recursive tag behavior is working
Message-ID: <d545bed9d3686b41ba67cfb25e00bb5a8b61c77b.1553586707.git.liu.denton@gmail.com>
References: <20190325233723.GD23728@sigill.intra.peff.net>
 <cover.1553586707.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553586707.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to ensure that recursive tags are disallowed unless the
"--allow-recursive-tag" option is provided.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7004-tag.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 7a7c0ccee9..5297da952d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1700,6 +1700,14 @@ test_expect_success '--points-at finds annotated tags of tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'recursive tagging should fail without --allow-recursive-tag' '
+	test_must_fail git tag -m recursive recursive annotated-v4.0
+'
+
+test_expect_success 'recursive tagging should pass with --allow-recursive-tag' '
+	git tag --allow-recursive-tag -m recursive recursive annotated-v4.0
+'
+
 test_expect_success 'multiple --points-at are OR-ed together' '
 	cat >expect <<-\EOF &&
 	v2.0
-- 
2.21.0.512.g57bf1b23e1

