Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807AEC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6284C61100
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJ2OCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhJ2OCB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:02:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A82C06120E
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o14so16235237wra.12
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=68yNxEpEa4kPiZewgYtxeNWEbIsC/efET42mXCcd9W0=;
        b=CIYKMwJgWrP4Lk+uH9cOlO1RVRY+DMk/Y1IMYZw03+VPdbJomGI9w3/fzWFxAD4Pxb
         yHDdtACxthNajIirZiIBTugDKJqjJu9xEupsavsYlnhIdMfh6xDx6wMTzDf4bmvP4q2z
         PHyxEEUZcu9Ub3WlzrmXbayJkuElBKBTWhy9uyxomL6trv7Ke2WN3RMWBLxtDGVlGc2t
         cf+T7BnLnt/SSOcL4T0d5/EvZcOGPFf1SdFzEu8xiyEob3pxCU3zbRp4nidrrchnxC+R
         i9ir9egYa/vKAl6GILDomMVMIk3TNNkJAIGYmUUUmJuFL22UjT7BTD82rrq1wA4zSzUs
         SJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=68yNxEpEa4kPiZewgYtxeNWEbIsC/efET42mXCcd9W0=;
        b=5dzI/OQ230BGp27blvVxdYtjuq5DzdVj227IFWXaoRg/DRFezCTKvH0umCL+9C7E44
         waNibV1HvnTdjR+tlaw2CGOALOPV5mxG7LjPiY3Pkkpu2nzKFiA6bhC9snR4hY3nsPeV
         PmWesUtkmK4w8sMF31lSfguM9HqbX3s8JEh0I8z3ln0xnCe3wQwDcM1lcGvMAT9gcdKz
         jOlWJiNjE4/A+oKMUfdDjentamwZcvC9yKVNNLo2lsyfW6NwDT3YgwqrI2yeRdBReVZu
         +YQ4b14xCN8plZLKSjFeaqiyDbk54w3jXOswSdwYtvGogIgcKGywDFJ+z0BQF9IoislM
         gbvg==
X-Gm-Message-State: AOAM533mak4YkGUvz3r3oI5yvNPcK++3twyiDj0ITQNPXG9hu94EI7Fd
        sXfveItOc0Fjyh79Q0GjQvyQwJaqqQM=
X-Google-Smtp-Source: ABdhPJzuI2ZE3KZW3LoAYykYwncC3lankfx+M8Jk1qkzCZyAioeF945i/xp9E5DQn1f541cVdulifQ==
X-Received: by 2002:adf:a2d4:: with SMTP id t20mr14490928wra.229.1635515968603;
        Fri, 29 Oct 2021 06:59:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm5499383wms.40.2021.10.29.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:25 -0700 (PDT)
Message-Id: <acc5591517fa519fc45c07c27defb309c891dea0.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:19 +0000
Subject: [PATCH v3 8/8] clean/smudge: allow clean filters to process extremely
 large files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

The filter system allows for alterations to file contents when they're
moved between the database and the worktree. We already made sure that
it is possible for smudge filters to produce contents that are larger
than `unsigned long` can represent (which matters on systems where
`unsigned long` is narrower than `size_t`, most notably 64-bit Windows).
Now we make sure that clean filters can _consume_ contents that are
larger than that.

Note that this commit only allows clean filters' _input_ to be larger
than can be represented by `unsigned long`.

This change makes only a very minute dent into the much larger project
to teach Git to use `size_t` instead of `unsigned long` wherever
appropriate.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c                   |  2 +-
 t/t1051-large-conversion.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index fd9c84b0257..5ad6dfc08a0 100644
--- a/convert.c
+++ b/convert.c
@@ -613,7 +613,7 @@ static int crlf_to_worktree(const char *src, size_t len, struct strbuf *buf,
 
 struct filter_params {
 	const char *src;
-	unsigned long size;
+	size_t size;
 	int fd;
 	const char *cmd;
 	const char *path;
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 8b23d862600..d4cfe8bf5de 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -97,4 +97,15 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 	test "$size" -ge $((5 * 1024 * 1024 * 1024))
 '
 
+# This clean filter writes down the size of input it receives. By checking against
+# the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB convert on input' '
+	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test_config filter.checklarge.clean "wc -c >big.size" &&
+	echo "big filter=checklarge" >.gitattributes &&
+	git add big &&
+	test $(test_file_size big) -eq $(cat big.size)
+'
+
 test_done
-- 
gitgitgadget
