Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C2AC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA39764E32
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBWBLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBWBLa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:11:30 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA4C06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:49 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w6so3344369qti.6
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruYFxjqcS/4yQR/z2Ny8ID736SH3S4b4FkF5EydICTo=;
        b=aCa/uP7VGSZpz/ikEn/SFveYTVXNw9MVl9aPoFZgDo4r1rTrc2ygXm9CbmKV+31XeV
         6pv22p1IvjoU0F3p5eoHyHa7gLvTGJ+XhZNBAUig0MB2bjPE2Sf3k9fymo9EYw8dngxs
         RGE10t1zn9+CUFk7HIJTuB0NFz/S550FnHymVXqxFAc6X4zYIBmrDZQRlDqwVnuhUqqT
         WNnnftGqJ3qgk1KGkAYvXGy5CKKWdDBx11wnU9PJV6QVhu/uicaxE1LInvzUSX+fvWN5
         bQcV2J+WTUW13OxWm8gUH+Js+oJo7TdjFZXw/CbRylo/0ld1pKkGEPo8FmF/hCLuLT6p
         ucTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruYFxjqcS/4yQR/z2Ny8ID736SH3S4b4FkF5EydICTo=;
        b=Kit8Hoq6dfOzYGHL2XssiploE/O7AWGxtglU1RlddjP1eWlIH1xWww72NOynwKp355
         PXr8ddfwOl1DYyRu/azsEwYzVnlwHwxXbWU73vS1RS73oqYVoGY2C4cdNDHNQo2VefwQ
         KdUMmioQdc12cxEPzBJytAS2v9nrO7OwqYMblcIlLIqxxpIghx+IkSVgG9gwA0LiMmar
         xDJX0+7sJ0rr8GhbfQL5LZPLrz4cLIR+KjbCLmKo5cAaQPzlLEkJjOgUOkSxuJwcfxBZ
         4chDnEsslta6GtJIv36vUutRL5vdBGtwvUVpZAjQKD6DO6MYs92mKFJPX9dWG88U2vOb
         iReQ==
X-Gm-Message-State: AOAM533dnFjU+AgHztX/+TBBJgV57ZOvH/utuAL77XpXnkBEkxI6s38g
        P27kvd0vPEE5OQeXpDQV+PJhTH1eYLO+SA==
X-Google-Smtp-Source: ABdhPJxo9SK7vkNn2FwpDKmLJlQaRRLF4hnQJkbx+YdyCCNnW6mopdyYDce1pG+6C4B5fMUiw5a2bQ==
X-Received: by 2002:ac8:ace:: with SMTP id g14mr22118087qti.156.1614042648513;
        Mon, 22 Feb 2021 17:10:48 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id v75sm13599070qkb.14.2021.02.22.17.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:10:48 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH 1/3] add --chmod: don't update index when --dry-run is used
Date:   Mon, 22 Feb 2021 22:10:33 -0300
Message-Id: <8ca9ba0d7f1e6efb04cae5c2ff00c9c9af50362d.1614037664.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614037664.git.matheus.bernardino@usp.br>
References: <cover.1614037664.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git add --chmod` applies the mode changes even when `--dry-run` is
used. Fix that and add some tests for this option combination.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c  | 12 +++++++++---
 t/t3700-add.sh | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a825887c50..1e33ab81f2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -38,17 +38,23 @@ struct update_callback_data {
 	int add_errors;
 };
 
-static void chmod_pathspec(struct pathspec *pathspec, char flip)
+static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
 	int i;
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
+		int err;
 
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 
-		if (chmod_cache_entry(ce, flip) < 0)
+		if (!show_only)
+			err = chmod_cache_entry(ce, flip);
+		else
+			err = S_ISREG(ce->ce_mode) ? 0 : -1;
+
+		if (err < 0)
 			fprintf(stderr, "cannot chmod %cx '%s'\n", flip, ce->name);
 	}
 }
@@ -609,7 +615,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		exit_status |= add_files(&dir, flags);
 
 	if (chmod_arg && pathspec.nr)
-		chmod_pathspec(&pathspec, chmod_arg[0]);
+		chmod_pathspec(&pathspec, chmod_arg[0], show_only);
 	unplug_bulk_checkin();
 
 finish:
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b7d4ba608c..fc81f2ef00 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -386,6 +386,26 @@ test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working
 	! test -x foo4
 '
 
+test_expect_success 'git add --chmod honors --dry-run' '
+	git reset --hard &&
+	echo foo >foo4 &&
+	git add foo4 &&
+	git add --chmod=+x --dry-run foo4 &&
+	test_mode_in_index 100644 foo4
+'
+
+test_expect_success 'git add --chmod --dry-run reports error for non regular files' '
+	git reset --hard &&
+	test_ln_s_add foo foo4 &&
+	git add --chmod=+x --dry-run foo4 2>stderr &&
+	grep "cannot chmod +x .foo4." stderr
+'
+
+test_expect_success 'git add --chmod --dry-run reports error for unmatched pathspec' '
+	test_must_fail git add --chmod=+x --dry-run nonexistent 2>stderr &&
+	test_i18ngrep "pathspec .nonexistent. did not match any files" stderr
+'
+
 test_expect_success 'no file status change if no pathspec is given' '
 	>foo5 &&
 	>foo6 &&
-- 
2.30.1

