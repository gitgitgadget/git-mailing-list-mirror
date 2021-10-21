Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED11C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CC561052
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJULow (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJULow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:44:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D566C06161C
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:42:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 193-20020a1c01ca000000b00327775075f7so1030656wmb.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abNkJrXAuy23zLg39gbf4J9JXqhpdmTrmoN5kFo/M8M=;
        b=lo4uzbRC5W0XlfY2lWnOghHMtnL7sXoUKadlfa92SralutnlK7ynjnUr2KYYVJ3uQ/
         kP81a6hQusMnd5IBaMA1l3GBzZyiJhT5MRWuKidj9r1cvjOqFw2mtPinSAlw6H05W1He
         1mneKVbMRRAwNW+8GrbQT6MoDJswciwdMjdYRwGo/MPe8kRdRSrtddkQ/FBtqfyfY/IZ
         5+TUHhP+w0C/uE0+ZH13D3IGVgXO+l2GY702DYGZAboELzsFzAyzUtZbpnapFE8Az/af
         5iyjqptHG9LtKEsaXEYkDFdFu9Qh1dlrwQKyjgNSa5xWKMrOzECrxD+jwvZwDOFw+rmZ
         ojKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abNkJrXAuy23zLg39gbf4J9JXqhpdmTrmoN5kFo/M8M=;
        b=V4i2fdj2xHBIwSRO9BnBMYkNCtJVGfGGhv8LJRraf29rEA+SKKLHx2+BhNvxNooykI
         EgVK4aQmu2D1KRGQHsSKMzDsCMpIC5hkSADwbTDzl5OjmTzbCR+UZwN2FXQejglyGBmA
         KBhb85AxgA5CYvoJGRDllbIPkXZUDopfC9Tl97mBOgWl2tHwcenWACq6Vq0LgxuuPx2F
         B5hw+cUEn4Q6ghVC3i/UfwEwEAtSFAwk06loNkf4Ngh8XH90nAq/a3bIiDLs4PErN6+h
         UkT4nNGfRItj+lABGUjBctTsrbTR3c84nidwRTLr7x1S1ZK1EqQV7ki4P1qpX9Suanw+
         lRdQ==
X-Gm-Message-State: AOAM533DjlQwaGSpYBuCfHvpr6BP2PKnV6Ixcj+E0gfZTEphVEHQAFCl
        ODAUbKj5rwJ5B0H78eZ18zSegyZlS81sQA==
X-Google-Smtp-Source: ABdhPJxLhfYBNvYJphW4d8E+spkFclqvQP9BSiH6VAuuWn5ad6QB3nElrTW5nUyLvo9NxJuo3H0FVQ==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr20576531wmq.82.1634816554445;
        Thu, 21 Oct 2021 04:42:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r5sm7446928wmh.28.2021.10.21.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:42:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] leak tests: free() before die for two API functions
Date:   Thu, 21 Oct 2021 13:42:29 +0200
Message-Id: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1486.gb2bc4955b90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call free() just before die() in two API functions whose tests are
asserted under SANITIZE=leak. Normally this would not be needed due to
how SANITIZE=leak works, but in these cases my GCC version (10.2.1-6)
will fail tests t0001 and t0017 under SANITIZE=leak depending on the
optimization level.

See 956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in
CI, 2021-09-23) for the commit that marked t0017 for testing with
SANITIZE=leak, and c150064dbe2 (leak tests: run various built-in tests
in t00*.sh SANITIZE=leak, 2021-10-12) for t0001 (currently in "next").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 4 +++-
 refs.c   | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 2dcbe901b6b..93979d39b21 100644
--- a/config.c
+++ b/config.c
@@ -159,11 +159,13 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	}
 
 	if (!access_or_die(path, R_OK, 0)) {
-		if (++inc->depth > MAX_INCLUDE_DEPTH)
+		if (++inc->depth > MAX_INCLUDE_DEPTH) {
+			free(expanded);
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
 			    !cf ? "<unknown>" :
 			    cf->name ? cf->name :
 			    "the command line");
+		}
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
 	}
diff --git a/refs.c b/refs.c
index 7f019c2377e..52929286032 100644
--- a/refs.c
+++ b/refs.c
@@ -590,8 +590,11 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
-	if (check_refname_format(full_ref, 0))
+	if (check_refname_format(full_ref, 0)) {
+		free(ret);
+		free(full_ref);
 		die(_("invalid branch name: %s = %s"), config_display_key, ret);
+	}
 	free(full_ref);
 
 	return ret;
-- 
2.33.1.1486.gb2bc4955b90

