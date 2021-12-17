Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5762C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhLQEZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhLQEZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:25:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E69C061748
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j18so1687831wrd.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/Rwinuv1HHYSmm9NNuYi0xzr9/xdgU4RDCSf8PMTBg=;
        b=lQ25nmKyIRzVdclDBi2KxNkb1/7/PhVf4e8wT948KxW6+HUEtKTFSmRgDnzKgEngBd
         4lxn3WE/1Vh20v14AElq5yDlPN/JlHFhQiJ8zmsBOs4hdOgVkxkKsxBtZgnkl00Pin5g
         ops0dZzfA1x+0y5ENHL8VcEP1kPoz2DKPhWAEek2e0ZMlnsslT+o6mD8taSBW1FtJh0d
         DGDAKc+QvP7OE8U+6IF5XDdnSqwKogYnfX0uheQ5cv8FbGCYlcLsPZ56WIVMyTJ/zCIH
         dfDw9u4ep1vJbHGWgUZeK+huFNAAV7ownFP2DgPd9rKYGZO/eUOyFq9BI30dSFVn525A
         5XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/Rwinuv1HHYSmm9NNuYi0xzr9/xdgU4RDCSf8PMTBg=;
        b=uEt7ju8dzy57GGpugaqo+WpovQlHfLczl74BgxauG+17koAJwXg+Wdu/EX9oiJRQ3M
         LgidosKUybE6fgQ0hqR/5XiZVTCbPJeRVGvtAvUgA+a+vHCGaLl2e/4Oq0WK/3ux4ZnW
         oHRh81v31hGbsNALDOZRP/9mAcEoY7O59vbA+1smvMBWBERW2fe7dGD+8J0oxLgcLsgX
         K/5iEzsCj2p4lVsGzQZ+LbSmDC9yCc/KJZqgQbpsAPAMRF/+3r9QHddQjtF3TffRoWFj
         AsZ7b/39fPfSiXrpkUbXuuRukf9FQ55K/ahQHLFzsJOB++ZmdTnyu7QONJB+VdlSwkLn
         +jCg==
X-Gm-Message-State: AOAM531VIEZzdh47pXkaecGX/GC8/Pbf4MDqYRBq2wBBo6NDmWdDNcBe
        rP8SU0LpJFcCJ2q9eycFc7E9Nw/eWYbBxg==
X-Google-Smtp-Source: ABdhPJx2/zxqYr1Kkucq6Nv7LKB0xa4A2PfYF07QM2N7wE81OqE2yrbCMxXiFypNmIOZ1cXInlN+NA==
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr817090wrg.571.1639715128556;
        Thu, 16 Dec 2021 20:25:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o64sm6325634wme.28.2021.12.16.20.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:25:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 7/7] various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
Date:   Fri, 17 Dec 2021 05:25:02 +0100
Message-Id: <patch-v7-7.7-0670d1aa5f2-20211217T041945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
and around 10 "isatty(0)", but these used the
{STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
them.

Let's change these for consistency, and because another commit that
would like to be based on top of this one[1] has a recipe to change
all of these for ad-hoc testing, not needing to match these with that
ad-hoc regex will make things easier to explain. Only one of these is
related to the "struct progress" code which it discusses, but let's
change all of these while we're at it.

1. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 builtin/bundle.c         | 2 +-
 compat/mingw.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..21360a4e70b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 	fprintf_ln(stderr, _("You need to start by \"git bisect "
 			  "start\"\n"));
 
-	if (!isatty(STDIN_FILENO))
+	if (!isatty(0))
 		return -1;
 
 	/*
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5a85d7cd0fe..df69c651753 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -56,7 +56,7 @@ static int parse_options_cmd_bundle(int argc,
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	int all_progress_implied = 0;
-	int progress = isatty(STDERR_FILENO);
+	int progress = isatty(2);
 	struct strvec pack_opts;
 	int version = -1;
 	int ret;
diff --git a/compat/mingw.c b/compat/mingw.c
index e14f2d5f77c..7c55d0f0414 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2376,7 +2376,7 @@ int mingw_raise(int sig)
 	switch (sig) {
 	case SIGALRM:
 		if (timer_fn == SIG_DFL) {
-			if (isatty(STDERR_FILENO))
+			if (isatty(2))
 				fputs("Alarm clock\n", stderr);
 			exit(128 + SIGALRM);
 		} else if (timer_fn != SIG_IGN)
-- 
2.34.1.1119.g7a3fc8778ee

