Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D632EC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjFBOdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjFBOdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:33:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68D1B1
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:33:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30aebe2602fso1902416f8f.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716424; x=1688308424;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Bq3TqBEQ9LrUzdrvzplAffpMfRelVgKTuAUnU8BmJk=;
        b=K3BzwS78c7URF12VR0329Tf3xx+BiIZQQ07GEeZaY0bRrmV44TTtAaAuwjl+N8Xiff
         P1bJPP/RqxfYD1EP1zCJ5kpPXeB0E6pNxTOGHRG+plN3TZ0b6y2oe4XhIPmwW0hiyP96
         rOcS6KgCAnsbgsk3HXMUz3GAPqA1Mnu+ob9DewMyP/2+EvqVWuFZhCS7KVNkF4zEOC6q
         eFfWSfQukt8mZYjeyGS4oBAyMpQOAaESlj62UP+MV0nuJDSKWnDKIGne/ubPMmUugJuw
         OfzOS/KaNI7AUHxTXsLAVpU1Q/C+we2Inw9w7d6dgNhIK2WRPrT9y9FSpZihT5B1yw4D
         FCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716424; x=1688308424;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Bq3TqBEQ9LrUzdrvzplAffpMfRelVgKTuAUnU8BmJk=;
        b=MgopHq5OhcYhCKNg3GnvWpYwGIrWBCS8U5GvW7o/Z5OY3rFPjaNdEqqOw/hOBgUODw
         p9f380Cfp3jYKS5lCyUCzCVWpBakdcK1K6DOhEIF8DKp+JADIL0yM+wis8KttYOUlGdz
         qHV95Z2TNQQ4y2SmHBqCznwa+pCOBj9jCFJCoxCo6led49rw3MysUXyyAIHjYCbpTW2V
         tS5TTcYRd4mLU9fZwCjoYke0YmgQNuYExTOYhvzMRwdeGqwYwZJbkSla0jZXRizW+TdI
         dDVWACFXHr2FbMKWp7HqOADJNWfoa6VHS148jNImopF5FNGJQZvHQH+o5FwC0RAL2D9o
         Yucw==
X-Gm-Message-State: AC+VfDw7Ksj7r0B37o+5N/3Tt3xa0vKL3p45QpxeDEsWBpMkoPUUAhga
        wUQ4RKAZjpZI4sq5YKAyG804OKIBmWk=
X-Google-Smtp-Source: ACHHUZ5bdvO99bWpvoZ816VNnnq88R5BQegTe1Fs/EymuIdI2ch2+EMiWHkEy7zGWYBhYJSABndRjA==
X-Received: by 2002:a5d:6b10:0:b0:306:2a1a:d265 with SMTP id v16-20020a5d6b10000000b003062a1ad265mr109208wrw.58.1685716424405;
        Fri, 02 Jun 2023 07:33:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a056000036900b0030c2e3c7fb3sm1830055wrf.101.2023.06.02.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:33:43 -0700 (PDT)
Message-Id: <d03a79f6f65758b8226d64e5d20d94f789f58919.1685716420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
References: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:33:37 +0000
Subject: [PATCH 3/6] config: move trust_ctime to global config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c        | 4 ----
 environment.c   | 1 -
 environment.h   | 1 -
 global-config.c | 2 ++
 global-config.h | 1 +
 read-cache.c    | 6 ++++--
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index ffe6bea80a6..d955a16b372 100644
--- a/config.c
+++ b/config.c
@@ -1561,10 +1561,6 @@ int git_config_color(char *dest, const char *var, const char *value)
 
 static int git_default_core_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
-		return 0;
-	}
 	if (!strcmp(var, "core.checkstat")) {
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
diff --git a/environment.c b/environment.c
index 890705f0f69..f42f79f7f1b 100644
--- a/environment.c
+++ b/environment.c
@@ -30,7 +30,6 @@
 #include "wrapper.h"
 #include "write-or-die.h"
 
-int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
diff --git a/environment.h b/environment.h
index 66d88612085..362681f63e7 100644
--- a/environment.h
+++ b/environment.h
@@ -111,7 +111,6 @@ void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 /* Environment bits from configuration mechanism */
-extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
diff --git a/global-config.c b/global-config.c
index b6fd16b14f6..5bd6bc45418 100644
--- a/global-config.c
+++ b/global-config.c
@@ -5,6 +5,7 @@
 static int global_ints[] = {
 	[INT_CONFIG_NONE] = 0, /* unused*/
 	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = 1,
+	[INT_CONFIG_TRUST_CTIME] = 1,
 };
 
 /* Bitmask for the enum. */
@@ -13,6 +14,7 @@ static uint64_t global_ints_initialized;
 static const char *global_int_names[] = {
 	[INT_CONFIG_NONE] = NULL, /* unused*/
 	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = "core.filemode",
+	[INT_CONFIG_TRUST_CTIME] = "core.trustctime",
 };
 
 static int config_available;
diff --git a/global-config.h b/global-config.h
index e66c3f4ac77..a6d8e5adc4e 100644
--- a/global-config.h
+++ b/global-config.h
@@ -4,6 +4,7 @@
 enum int_config_key {
 	INT_CONFIG_NONE = 0,
 	INT_CONFIG_TRUST_EXECUTABLE_BIT,
+	INT_CONFIG_TRUST_CTIME,
 };
 
 /**
diff --git a/read-cache.c b/read-cache.c
index 8d14a029ce4..9e5a6ba2c76 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -192,14 +192,16 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 
 	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (get_int_config_global(INT_CONFIG_TRUST_CTIME) &&
+	    check_stat &&
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (get_int_config_global(INT_CONFIG_TRUST_CTIME) &&
+	    check_stat &&
 	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
-- 
gitgitgadget

