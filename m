Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37940C433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E3960FC1
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhJ1UxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhJ1UxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D1C061243
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k7so12322868wrd.13
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DhwSEccaMqAjCPcvUMPxM2dKEjzMOvtOPxQAoRmPJrM=;
        b=Z57bbonY3EFrT6ep1ITdy7KEvzECGujMlRDQIV2cNDLYMDWyIH21nHXVVyNCssobJO
         K9UMNItfdTEGVuApyGXxErnSl2SpUGslXqFzlrf2pRQhhViQuOwz30nh70/5WMTFc5qS
         F3xHlPi8vP/v/cr5jzVcoPCcQYBFod/dNeEj27JGNglz3i1+X9SlVkxqaIVAkYVCo5YM
         d83vzgckdMLU7o9RHD34ApSsS409KEJQLL5SqyWvvc1F5xFdIWhA9rfoRgPZNRKSgG6Y
         EuXJ5JxdmDfrJrNaa6KYKO+qtkSgTFyGvQs8R4H2g3ayv9/AOTNnurcn/Qgd4spuChDm
         ZgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DhwSEccaMqAjCPcvUMPxM2dKEjzMOvtOPxQAoRmPJrM=;
        b=totrHTSmWnvLTXUTbBrnvRzK7WSzm8BrPRGgyoQ5T3fmCmb8IsQszOFflZ6vzkpAFZ
         TDaH+QKxX11j1WOjlaYN0vXl7x7OsBDXoJtQqGxiLWqMKHXNXMixHMTEXhZbEXwjCMhS
         Mjd/mqLL/R9egP2yG57jaZRlWw33Okf/qdaulUhrBZEd/T9B1zde/KySp1ps4Kn3P2k8
         LqjzrbvxV5tXWrkb+jhuF1TNLNMX2GT0B9pCk4oRgiGvDSCagF5ZaYW0RBiJgmTqABmB
         7St8Tg9myJJcwsuyiFCIvizlY3RxgyE2MTDM1rvgxWaHZPiwpBNNFnc3BhDVkfGuGtmE
         DwOw==
X-Gm-Message-State: AOAM533n1P6bqutPncCB1xUR67R22hVc7E9NloOQ1V2GX8Cz14mDkO9J
        n7t9aPReFYOTT3pZnM6i2q+ppVqE5kA=
X-Google-Smtp-Source: ABdhPJzBSnKCELgDqmpcGnGPsyVM0FNHM8HjZktzYOd7OmgsrcTf1kofcEd/eWv7yMB9VqHyoeVhww==
X-Received: by 2002:a5d:5915:: with SMTP id v21mr8628411wrd.270.1635454242948;
        Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm5284571wrs.5.2021.10.28.13.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
Message-Id: <d87d4229bb4a5ed6903d277d38899b4f8f592c00.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:37 +0000
Subject: [PATCH v2 7/7] clean/smudge: allow clean filters to process extremely
 large files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
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
 t/t1051-large-conversion.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index 5ba03d02682..83d9cf485a3 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -96,4 +96,14 @@ test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output'
 	test "$size" -ge $((5 * 1024 * 1024 * 1024))
 '
 
+# This clean filter writes down the size of input it receives. By checking against
+# the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
+test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on input' '
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
