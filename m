Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0359F2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbdG2WYe (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:24:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36002 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbdG2WYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:24:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id y129so26938052pgy.3
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=f/kyDRi7egA1qjAJ0VGA0s+1L3bV7AHOBm/aV5DZD9p9GURLYlkJxeysMLgC0FGdlG
         +XM500HyoTjPinekk+p6FJW2repcEb/8GnsUPgKt5tRcBu7N0wfbRcKRUKEImv1eX9hY
         s7pkz+5Wl/aEO8cbZoPXxtHOWsCJLnMfCsTY4goiHsKHsq43jsqD2SX/AsifGdm2Lyst
         PvVZ3v1tRolB6v21tO0+3GFcgwmvKDUSw1NRQCArPZD9yEhi/wTX6daKo2wX0cx0PV57
         zfi3XkX3dM5Cx9YGMAw27Sti+jeKnCv54heTsVC4FUUqTIdUJS9O7Ix2PtzaA8cKt90u
         jWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=Hs2XOFFlCvI82JcOpPWorHsWpHUeU3HoEUMNvsj82gil+c4zEGKfoBI2Z0CC7n87Wr
         4CirjVTrf62UOBRFqXnLNHmokzRjivfpyi7HnT61cQV0lXn4s6by7xrynOnvHQiQFj1J
         lkTb9vYsG0GKaF6P2qSj+1B4wDkPhg8izI2PVaw8l+Hq3/oGXowaFvf+KvzPo9rDjKcU
         eu5LR9PjMxtWh7Kfp9jxBwZQn7phw1I3USjOEEJK21oLoupBaYHp3SuANRbhXezY+m4b
         BjbmJRAu8Hbp1/8utatzBdY3kv61cdCnuTmZ4BUxQHqa3n7CG9fzzlaTix2BSAuyUBTp
         8Few==
X-Gm-Message-State: AIVw110iCb+jBEm8brtI8qImP2piOkEpwvUmOvd5qdswM3Nh5R4ETjHY
        b0+h4tsHjyK2i+CqE0g=
X-Received: by 10.84.209.231 with SMTP id y94mr12217739plh.392.1501367071343;
        Sat, 29 Jul 2017 15:24:31 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:24:30 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 02/13] submodule--helper: introduce for_each_submodule_list()
Date:   Sun, 30 Jul 2017 03:53:50 +0530
Message-Id: <20170729222401.12381-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_submodule_list() and
replace a loop in module_init() with a call to it.

The new function will also be used in other parts of the
system in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7af4de09b..e41572f7a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -14,6 +14,9 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
+				      void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -352,17 +355,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void init_submodule(const char *path, const char *prefix, int quiet)
+static void for_each_submodule_list(const struct module_list list,
+				    submodule_list_func_t fn, void *cb_data)
 {
+	int i;
+	for (i = 0; i < list.nr; i++)
+		fn(list.entries[i], cb_data);
+}
+
+struct init_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+};
+#define INIT_CB_INIT { NULL, 0 }
+
+static void init_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct init_cb *info = cb_data;
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	/* Only loads from .gitmodules, no overlay with .git/config */
-	gitmodules_config();
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(null_sha1, list_item->name);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -374,7 +390,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_active(the_repository, path)) {
+	if (!is_submodule_active(the_repository, list_item->name)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 	}
@@ -416,7 +432,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!info->quiet)
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -445,10 +461,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -473,8 +489,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+
+	gitmodules_config();
+	for_each_submodule_list(list, init_submodule, &info);
 
 	return 0;
 }
-- 
2.13.0

