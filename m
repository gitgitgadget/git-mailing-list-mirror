Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CFCD13D2
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIRUyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjIRUyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:54:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3B910D
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405082a8c77so16870715e9.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695070470; x=1695675270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcNCEV02FNopnwM40T1pAoRlxIYH68QM3v1pI2RK28c=;
        b=c5CN+nx5D3TZl0XyYWY/295L/T7XD5pzSk5ytrmQWAIz9VgeaFdtZaRMTKzmgzVh+y
         fsvL9zK/Fvlf6FZHzr9oPQ15LBLTuCHlSP3lnGR5/SlvF1NenJfUjEYFBA7bO8b8BD70
         h/Uoyso4dGKtg9gsBEDCQoeSPomGyGEgxjj0384CKgkZsKPyRDrlR4wXVhJgy/oZKl4v
         s1JBrtCTyJhWQNrnDlsi7XRpup6o5x9hdJ3ct5XTa6S2q3EdEn2WT0EsvB6vhQRiZl/x
         WrKuEO0JsIm/7GTEXcNxwZZTN7FRSoi/1oV6VXodm5KCJpgLPO90oAmkeEAlZkCUN9MY
         UAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070470; x=1695675270;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcNCEV02FNopnwM40T1pAoRlxIYH68QM3v1pI2RK28c=;
        b=aBhSMCg+lMJWGwRoCfXFZwpcnS2Lwy4LROivYLWaxpP6U/m0qwEhQtTBFqIFdhL0rH
         FDnlyYKQ6j39SLtkueaxRZ2B5krdoPc8t4dDyIXfjdeDIuTErjVGASevZ1dTOLdqvt+Q
         1L2NHPYxFlDpsMot4I4OB+NnwWVqH2GCvUWBlVhP91rJXdkpDVkBoDvT6Xy6NyLrDJXC
         ai3OQzYOypocIBNFRGV6GHkus/PNovV0cCJ3D62wysm4gewvth1fn33jC5eTaFxFQYIc
         I7lrfofGDiFL719yogVexg/9i7hDSaaSMawqomENUhMVClJYObiYx7bMWojmG/WQIUKW
         PYpw==
X-Gm-Message-State: AOJu0YwsVnI5wOWU9DHsylPYyHjAu92JkfF/5O70gO6qnrj3M6D335WN
        +HyBGMFYxWyVn8TebqiESHupiLXacig=
X-Google-Smtp-Source: AGHT+IE5esK0mnRJcb2Ut5edzQkpgsfppndm1NmZmgZkprbFZ7oHqwvl8jKZdHxX/iwVuNHiHF7elw==
X-Received: by 2002:a7b:c8d0:0:b0:401:b0f2:88cf with SMTP id f16-20020a7bc8d0000000b00401b0f288cfmr7731397wml.40.1695070470472;
        Mon, 18 Sep 2023 13:54:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b00403038d7652sm13393606wml.39.2023.09.18.13.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:54:30 -0700 (PDT)
Message-ID: <90db3d5d41f8042a28cce02f910e7b6d5904308d.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
        <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:54:23 +0000
Subject: [PATCH v2 2/7] unit-tests: do not mistake `.pdb` files for being
 executable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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

