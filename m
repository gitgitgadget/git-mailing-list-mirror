Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7FC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2906661A21
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZPuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCZPt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:49:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81B2C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:49:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so3229074wmf.5
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whQBRnFM8DAxGlmBYCu3ty8XE120ZOVcbxvGYQ5u7LM=;
        b=KKvPUTM9DEFXw3VXgIYLNxKjD1g7HdZc51RavLfzo1k6Mbz2BI3FzcQ+0m6kkq2/d7
         6ozGCnGCR7kg6bQaWHLwphWXickD4OIi9kaZ0EhmZXmvLXzdqBDtPZQipkgw6oFDw5qM
         x56EhYwvKWUY/SFa2npAkHs7vLxcxXD1AytDoyBqJGFhch443X6cKjkOcoMPUpGnDUyt
         4KtKtMBrkjvZb+H6eBmIeea/xoSL+qO2nE7OXgT16gCxVSibXo90TwaQ9f9abO/10IcV
         r7RKjHsoZLuXOuLsdsbJRAFSozKWQy4FjMmVegtvOMYfLugx9ePQ+tmCFzrPuoglnNwC
         7k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whQBRnFM8DAxGlmBYCu3ty8XE120ZOVcbxvGYQ5u7LM=;
        b=lXxSZ4dwR2Vkhs+ZoR8z4yIP4OrQT+J36nJTX1OTO4H8As24JAlRYT0C61XA6nHwM9
         CK7qPx99NCaDhvk/3frG6R/DkBTPVuVRW+DZ4tnwvS4IZ2PBfK1M/9T3x5DG6w3+bcwl
         DlIx0uvfBGkoMiqiI7dtR+HGCfQ88e9r34w1WoZWr/UcjxQzSeNJhgHsl5E/NqC/34ie
         HHfrsr5QcMGZXLNdrDKzYVVlIwkP2LHLhJV8mVdcrXoduC8ZPCVVwbGZxzlE5ZqaV81w
         aB8LBq8TQgkyRRpvfbtGAFg+nhS3nbH2egY9HvUfci1+JXtnHJIMNS4FsheyFVlmbgQz
         5jqw==
X-Gm-Message-State: AOAM5337Byi+1+Wq4fc7pLQfoQ+fgWyd2sz2WpG2qTlNCjXSlJqGh+nx
        HVGM+xjdoaB16I/BqjI5/EDPvVbdqgFi6XMplTo=
X-Google-Smtp-Source: ABdhPJzO8cotoS3BHOeQj5vODkfxd/ScxJzWDV5qKSwJngyL0Xu/xzkdWvfHv1NMgnC/jgYfxxB0Tg==
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr13941317wmi.64.1616773765937;
        Fri, 26 Mar 2021 08:49:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id s3sm11380132wmd.21.2021.03.26.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:49:25 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, peff@peff.net, bagasdotme@gmail.com,
        gitster@pobox.com, pclouds@gmail.com, sunshine@sunshineco.com,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v3 2/2] pathspec: convert no-glob warn to advice
Date:   Fri, 26 Mar 2021 17:48:55 +0200
Message-Id: <20210326154855.19528-2-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326154855.19528-1-133706+stdedos@users.noreply.github.com>
References: <20210325233648.31162-2-stdedos+git@gmail.com>
 <20210326154855.19528-1-133706+stdedos@users.noreply.github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git that, if anyone wants to squelch such warning,
can do so via `git config advice.starStarNoGlobPathspec false`
---
 Documentation/config/advice.txt | 4 ++++
 advice.c                        | 3 +++
 advice.h                        | 2 ++
 pathspec.c                      | 6 ++++--
 t/t6130-pathspec-noglob.sh      | 4 +++-
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index acbd0c09aa..35aa36cfa1 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -119,4 +119,8 @@ advice.*::
 	addEmptyPathspec::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
+	starStarNoGlobPathspec::
+		Advice shown if a user provides a pathspec via the terminal
+		that contains `**`, anticipating that the pattern will be
+		matched using wildmatch (aka `:(glob)` magic).
 --
diff --git a/advice.c b/advice.c
index 164742305f..5703bfba86 100644
--- a/advice.c
+++ b/advice.c
@@ -33,6 +33,7 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 int advice_add_ignored_file = 1;
 int advice_add_empty_pathspec = 1;
+int advice_star_star_no_glob_pathspec = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -95,6 +96,7 @@ static struct {
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 	{ "addIgnoredFile", &advice_add_ignored_file },
 	{ "addEmptyPathspec", &advice_add_empty_pathspec },
+	{ "starStarNoGlobPathspec", &advice_star_star_no_glob_pathspec },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
@@ -137,6 +139,7 @@ static struct {
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
+	[ADVICE_STAR_STAR_NO_GLOB_PATHSPEC]		= { "starStarNoGlobPathspec", 1 },
 };
 
 static const char turn_off_instructions[] =
diff --git a/advice.h b/advice.h
index bc2432980a..c62fb47434 100644
--- a/advice.h
+++ b/advice.h
@@ -33,6 +33,7 @@ extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_submodule_alternate_error_strategy_die;
 extern int advice_add_ignored_file;
 extern int advice_add_empty_pathspec;
+extern int advice_star_star_no_glob_pathspec;
 
 /*
  * To add a new advice, you need to:
@@ -72,6 +73,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_STATUS_U_OPTION,
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
 	ADVICE_WAITING_FOR_EDITOR,
+	ADVICE_STAR_STAR_NO_GLOB_PATHSPEC,
 };
 
 int git_default_advice_config(const char *var, const char *value);
diff --git a/pathspec.c b/pathspec.c
index d5b9c0d792..879d87260d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,4 +1,4 @@
-#include <string.h>
+#include "git-compat-util.h"
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
@@ -744,11 +744,13 @@ int match_pathspec_attrs(const struct index_state *istate,
 }
 
 void check_missing_glob(const char *pathspec_entry, int flags) {
+	const char *advice = NULL;
 	if (flags & (PATHSPEC_GLOB | PATHSPEC_LITERAL)) {
 		return;
 	}
 
+	advice = _("Pathspec provided contains `**`, but no :(glob) magic.\nIt will not match 0 or more directories!");
 	if (strstr(pathspec_entry, "**")) {
-		warning(_("Pathspec provided contains `**`, but no :(glob) magic.\nIt will not match 0 or more directories!"));
+		advise_if_enabled(ADVICE_STAR_STAR_NO_GLOB_PATHSPEC, advice);
 	}
 }
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index af6cd16f76..0482030243 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -158,7 +158,9 @@ test_expect_success '**/ does not work with :(literal) and --glob-pathspecs' '
 '
 
 cat > expected <<"EOF"
-warning: Pathspec provided contains `**`, but no :(glob) magic.
+hint: Pathspec provided contains `**`, but no :(glob) magic.
+hint: It will not match 0 or more directories!
+hint: Disable this message with "git config advice.starStarNoGlobPathspec false"
 EOF
 test_expect_success '** without :(glob) warns of lacking glob magic' '
 	test_might_fail git stash -- "**/bar" 2>warns &&
-- 
2.31.0

