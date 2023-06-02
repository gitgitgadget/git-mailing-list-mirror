Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88490C7EE2D
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjFBOdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjFBOdr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:33:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2801AB
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:33:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so2394855e87.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716424; x=1688308424;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOPFmG2ud4MhTyXusLo7tom0Eas61wAX8f+KLAn6mEA=;
        b=KGu/ecKVPbLdrhCJjrA9PIHbbltWrPqHI6dMCTbVK9M4u0Jrk5TP2jLc5GZEZImMRd
         Y24KfFOLfT6x/2CX6yLmkcW+T4hmhwE8MgzFfTmH0QN9s28eqrzJ9xWGkdeaAyBwsfA6
         adAPeCd4tVffF307iCklvmk/sQKOjCP3VcPJeyIXJH0iO85T5rEm6XhkRqSJ/E9HTDng
         rBo/BI4HQ9R6AEdp3y4CJ378JKrq6WPLdUz0YWXidAu2mAMGYKGoeqCDY7dav9xqBXLz
         B0GtRj2DD0h9cK5HvG7pyiqsJP24ZrER0F0ad0rjdH7TR1I09T4IPua3r9qSZDveN1Bs
         oXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716424; x=1688308424;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOPFmG2ud4MhTyXusLo7tom0Eas61wAX8f+KLAn6mEA=;
        b=aD0ZsIea9U/YO6QA8LgVuypCHLp2Nuhfjqh0lo+T0KbGTBNOVJH6XaMZB/A+kvGvAE
         YIOxCBfhUcwf33J8wWVey/XKjjOIz3U1wFNJtp4HoyLM0rymePZtFER1TeiDiI6C8K3e
         ClHSflmGyUas6no44cKYB9plhPBb6f+fZJdwuOb0EXGgxz3PmCxtFkWsiTXB+HcNn0Bn
         DyMxgm+PmnXB5r/GKI9+he/u4/0aLnQL2hh4dpJcoJ8AbySDaL/86jaqeC+7f+gcQhG8
         gg+LSdnQr0TaYOsyljzt4d+cMnU6CjfU0Okkt5JzE3KVhTMtJfNWWOwjRz7ZrJmQznMh
         3G+g==
X-Gm-Message-State: AC+VfDxoUifynveiESTEl0vZ6yW9wuMzxl3Cgl9BpjYLtIzfNvk+dH6e
        ynqxipNrcv2HTmMA7fvc3JB9doMJ2Yc=
X-Google-Smtp-Source: ACHHUZ5susOiX097sLYLYQJQrQeyNYZOGk6iocQIeOayWtPwIKVaJgSE/0ISnD9gt+HyGPd/Jk1XTg==
X-Received: by 2002:ac2:551e:0:b0:4f3:89da:c374 with SMTP id j30-20020ac2551e000000b004f389dac374mr1717578lfk.1.1685716423555;
        Fri, 02 Jun 2023 07:33:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b0030647449730sm1853978wrs.74.2023.06.02.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:33:43 -0700 (PDT)
Message-Id: <837b5360b40f992351f489a0ae05fedf49884c6e.1685716420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
References: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:33:36 +0000
Subject: [PATCH 2/6] config: add trust_executable_bit to global config
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

The 'trust_executable_bit' global represents the core.filemode config
value. It is loaded when git_default_config() is used to iterate over
the config keys (which includes several other similar iterators) during
the start of a Git process. The timing of this load depends on each
process, and happens even if the global is never used.

Instead, use the new global config system to load it on-demand, if
needed. Since this is the first use of the system, let's describe the
process:

 1. Create an enum value representing the value. This is named based on
    the fact that we expect an 'int' type.

 2. Update the default to 1 to match the existing global.

 3. Update the config name so we can load it from the config set.

 4. Replace uses of the global with get_int_config_global().

 5. Remove the global from environment.(c|h).

The "This needs a better name" comment has been around since 17712991a59
(Add ".git/config" file parser, 2005-10-10), and in that original
context it clearly mentions "core.filemode" as the bad name, not the
containing method. Now that we are removing this global assignment (and
not changing the name any time soon) we delete the comment, too.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache.h         | 7 ++++++-
 config.c        | 5 -----
 environment.c   | 1 -
 environment.h   | 1 -
 global-config.c | 2 ++
 global-config.h | 1 +
 read-cache.c    | 5 +++--
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 71e2fe74c4f..3e737d12ea8 100644
--- a/cache.h
+++ b/cache.h
@@ -9,6 +9,7 @@
 #include "pathspec.h"
 #include "object.h"
 #include "statinfo.h"
+#include "global-config.h"
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
@@ -160,10 +161,14 @@ static inline unsigned create_ce_flags(unsigned stage)
 static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
 					     unsigned int mode)
 {
-	extern int trust_executable_bit, has_symlinks;
+	extern int has_symlinks;
+	int trust_executable_bit;
+
 	if (!has_symlinks && S_ISREG(mode) &&
 	    ce && S_ISLNK(ce->ce_mode))
 		return ce->ce_mode;
+
+	trust_executable_bit = get_int_config_global(INT_CONFIG_TRUST_EXECUTABLE_BIT);
 	if (!trust_executable_bit && S_ISREG(mode)) {
 		if (ce && S_ISREG(ce->ce_mode))
 			return ce->ce_mode;
diff --git a/config.c b/config.c
index d0ce902af39..ffe6bea80a6 100644
--- a/config.c
+++ b/config.c
@@ -1561,11 +1561,6 @@ int git_config_color(char *dest, const char *var, const char *value)
 
 static int git_default_core_config(const char *var, const char *value, void *cb)
 {
-	/* This needs a better name */
-	if (!strcmp(var, "core.filemode")) {
-		trust_executable_bit = git_config_bool(var, value);
-		return 0;
-	}
 	if (!strcmp(var, "core.trustctime")) {
 		trust_ctime = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index e198b48081a..890705f0f69 100644
--- a/environment.c
+++ b/environment.c
@@ -30,7 +30,6 @@
 #include "wrapper.h"
 #include "write-or-die.h"
 
-int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
diff --git a/environment.h b/environment.h
index a63f0c6a24f..66d88612085 100644
--- a/environment.h
+++ b/environment.h
@@ -111,7 +111,6 @@ void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 /* Environment bits from configuration mechanism */
-extern int trust_executable_bit;
 extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
diff --git a/global-config.c b/global-config.c
index db9643afd7a..b6fd16b14f6 100644
--- a/global-config.c
+++ b/global-config.c
@@ -4,6 +4,7 @@
 
 static int global_ints[] = {
 	[INT_CONFIG_NONE] = 0, /* unused*/
+	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = 1,
 };
 
 /* Bitmask for the enum. */
@@ -11,6 +12,7 @@ static uint64_t global_ints_initialized;
 
 static const char *global_int_names[] = {
 	[INT_CONFIG_NONE] = NULL, /* unused*/
+	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = "core.filemode",
 };
 
 static int config_available;
diff --git a/global-config.h b/global-config.h
index 407dff19ee9..e66c3f4ac77 100644
--- a/global-config.h
+++ b/global-config.h
@@ -3,6 +3,7 @@
 
 enum int_config_key {
 	INT_CONFIG_NONE = 0,
+	INT_CONFIG_TRUST_EXECUTABLE_BIT,
 };
 
 /**
diff --git a/read-cache.c b/read-cache.c
index e919af3c77a..8d14a029ce4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -336,7 +336,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 		/* We consider only the owner x bit to be relevant for
 		 * "mode changes"
 		 */
-		if (trust_executable_bit &&
+		if (get_int_config_global(INT_CONFIG_TRUST_EXECUTABLE_BIT) &&
 		    (0100 & (ce->ce_mode ^ st->st_mode)))
 			changed |= MODE_CHANGED;
 		break;
@@ -806,7 +806,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		ce->ce_flags |= CE_INTENT_TO_ADD;
 
 
-	if (trust_executable_bit && has_symlinks) {
+	if (get_int_config_global(INT_CONFIG_TRUST_EXECUTABLE_BIT) &&
+	    has_symlinks) {
 		ce->ce_mode = create_ce_mode(st_mode);
 	} else {
 		/* If there is an existing entry, pick the mode bits and type
-- 
gitgitgadget

