Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DBC83F2E
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbjHaGPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHaGPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:15:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB071E0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c479ede21so304824f8f.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693462536; x=1694067336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcNCEV02FNopnwM40T1pAoRlxIYH68QM3v1pI2RK28c=;
        b=cOgAr59gGpvULUGdD6/iQhyKPh9ozoLTPA6L2WGlP7FUN81fQxgISEztqZz64XukzK
         1hn7RjTcgc4bG4c1XAXYgOT6srpajJNSC+RAkolL5eXQ4dPrhqCKd1cYrOiu3Vqzy11J
         QicvumErb+3tRt4QJVa8GUNFleQ7l2f77VQB+G/NL1ZAH50uYaDyBB30DcqgWZvjnifu
         Pqq/iSRHswSUONRrs77+rUm19sm482h650pKEmX+3fjtjyzZqeT9zEti4/0hGTtS5pFe
         9Xor7d2/6toehJRfDeiZ9wt86Cll+36S3HreZwjx7emoHStRPeLPjxiX31A14UVA1nOf
         cSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693462536; x=1694067336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcNCEV02FNopnwM40T1pAoRlxIYH68QM3v1pI2RK28c=;
        b=akxM18mTjWRmuRtjiKPEnNd/ojfpWNXyY/kG4KgDUmuAzvS2ZGgAUIeQnJiHB2BhFJ
         I0E4wHvao2YF16CdNujcCRDinOVctB9hjyhaq7x+FD3zZfqKBYnw+/pv/puSZSENTe2P
         WA1/RKB5G6AwNuBz/SqrOQ4L8yekWtJUx9cNkYgMZa1JfwB9u6SyBEg+q2zZCpBjlbU1
         9pKY+JaerP91V7T8B33yujHThWcIIkpWJ2eUADdfFJ55gXTaUXvtre98iU7jTQHcAs02
         MYqHJDjXSU1+7y6jpW5Hc61IVDwRkxtPjM8gNf2V6gAPtT3sNovpv8WZxprt0k1WcDtr
         dHrg==
X-Gm-Message-State: AOJu0YxAtYRp7ZV/tE0hdZhwfFoMmHPL/XSC3oGWYBCH6D1w3vgMkh5n
        Syla4J9ZA2OVpHBFv9qBymelCYA9FD4=
X-Google-Smtp-Source: AGHT+IH9cosZxwGfuaKG4/IshI8X6pHqa8NAMKx8LYPd0BVWruLN04C/E4beljz/BBlItFdp1emNUA==
X-Received: by 2002:a5d:5946:0:b0:313:f0d7:a43 with SMTP id e6-20020a5d5946000000b00313f0d70a43mr3187820wri.23.1693462536100;
        Wed, 30 Aug 2023 23:15:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020adfe7c4000000b0031c6581d55esm1004141wrn.91.2023.08.30.23.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 23:15:35 -0700 (PDT)
Message-ID: <90db3d5d41f8042a28cce02f910e7b6d5904308d.1693462532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Aug 2023 06:15:30 +0000
Subject: [PATCH 2/4] unit-tests: do not mistake `.pdb` files for being
 executable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When building the unit tests via CMake, the `.pdb` files are built.
Those are, essentially, files containing the debug information
separately from the executables.

Let's not confuse them with the executables we actually want to run.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 095334bfdec..38fe0ded5bd 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -42,7 +42,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
-UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/t-*)))
+UNIT_TESTS = $(sort $(filter-out %.h %.c %.o %.pdb unit-tests/t-basic%,$(wildcard unit-tests/t-*)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
-- 
gitgitgadget

