Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFE7C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiDMTyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiDMTy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3656220
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e21so4121259wrc.8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VS0qqJ+MyHkAenOD1VJx9zPTY3FrInp30v7m+6spciM=;
        b=YpSwndtl8jVansfCgpxd7RB1qCBFXoo4CeCfu48UGi4R9ASfUL7/Juzy9ISc/fGvJj
         r1y7zOu6JASHSKMzklQLslVDZJ26BAbtF9XUO6m2otkZJf6WI7GkMHqlIG4arvLcgJph
         8dc7xjzfG0xOyHKT6uPZRi73Qm0i28yww0ec8hpD3G9GEBHHU1rz1VXGWGETj4hMG4Du
         PmI6RLqFl0rbXCjk7x8H++0jDZMYuZv9WfgPGEkRP9dXIqMP5VRs+GokxHg12YigFSC2
         WbdkPbm7HJsxiwxW73o/vPXRVXmF9HKwTC/F2U7oX05MJ9MS+vhXekLR/bEpMYgDrIXY
         wiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VS0qqJ+MyHkAenOD1VJx9zPTY3FrInp30v7m+6spciM=;
        b=SwM//t+zG7Rs5DpRgsXQQG6T37R7jexC0k4bpz9FbsqMjy7qeHSZIuQzqfSDXTEoSq
         t3ZOh9vnV244h5FU7zQ8+gBFxmF7i408p+vlXPJmHFYK30896a5amJqei0fe6i2Nuz40
         AV4jT4alzweddUa4KY1kfqtLNEfbp14V8smsgeA+9x7iLoKtbs3T4H1fttWmnabHqAWL
         e/1phzJsnvl2fEtVJg5FQ0jh85nHpmk92K2pfLV/smvAZSLNLkIHH43XQuJURYPD5x2U
         99rCMap7rCPvJmpYAw/QnETC+ivBqxxuEFdbzBi2eQH0Xg2n3Wh70TV5bKuXICm9KdtN
         97qw==
X-Gm-Message-State: AOAM531+BfUvW79vke7Hz3KBaRFJ2HdMuNlQKdca9abmmFnVBNqFzrex
        BmvpZJAcLg4fTar96dcWTPPzlSB0tEnClw==
X-Google-Smtp-Source: ABdhPJwW6VUYtGm+bO8+EJa5CYZNm6zkhBjr60+coURJO5SuUMIXuhcFbj8fHXTCd5SVO0yS0qX7+g==
X-Received: by 2002:adf:fb4d:0:b0:207:a376:7585 with SMTP id c13-20020adffb4d000000b00207a3767585mr309946wrs.489.1649879522641;
        Wed, 13 Apr 2022 12:52:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/29] CI: have "static-analysis" run "check-builtins", not "documentation"
Date:   Wed, 13 Apr 2022 21:51:22 +0200
Message-Id: <patch-v3-09.29-54a4d79bf8d-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "make check-builtins" check from the "documentation" job to
the "static-analysis" job.

The "check-builtins" target added in c74390e4a1d (cherry is built-in,
do not ship git-cherry.sh, 2006-11-05) is unrelated to the
documentation, so it's odd that b98712b9aa9 (travis-ci: build
documentation, 2016-05-04) added it to the "documentation" job.

Let's just move it to the "ci-static-analysis" target, and while we're
at it improve the output with $(QUIET_CHECK).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 | 3 ++-
 ci/test-documentation.sh | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8717ea7e745..2e1ae6c6067 100644
--- a/Makefile
+++ b/Makefile
@@ -3402,7 +3402,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	$(QUIET_CHECK)./check-builtins.sh
 
 ### Test suite coverage testing
 #
@@ -3492,5 +3492,6 @@ ci-check-directional-formatting:
 
 .PHONY: ci-static-analysis
 ci-static-analysis: ci-check-directional-formatting
+ci-static-analysis: check-builtins
 ci-static-analysis: check-coccicheck
 ci-static-analysis: hdr-check
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 9e0652c30dd..41e2b126311 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -14,7 +14,6 @@ filter_log () {
 	    "$1"
 }
 
-make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-- 
2.36.0.rc2.843.g193535c2aa7

