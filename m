Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBDCA20365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbdGMUFy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:05:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35437 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbdGMUFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:05:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so8312277pfq.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=B/7cP/ujMZrc7q5bRZGJkv4M48tLwV7RDWe66OHWiRkD9+0mZQTzQ5DRqClxThKlO2
         gPE7MmdLhTSvxnaSZb1kEW3r9T9EC7uOYMZBBmblrKAlnbVrnhxuF2T/uA2k0tXI2gR0
         rYmxiOqhfex1nL6fWPTajXC6l0awB2p3zg+3A6QcG1rxfLWX94WwFO80b3UixBb3Eg83
         pyxWA3uKxEm6tgYAliunfUl7lwKtmNx1UNlcXCkkoi8uOPwzRZnkbhLscPlmaW817kJ7
         EWdh5dCpzNf7t9qXEqRND63kQnroObtRWdJwZ61wWOYUn7YjzQXsj+t/lwHhIljmoXGD
         0Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keRH6BHEvKwLuE2Lkig6db25DdaV8ZNSej4AIJa+8R4=;
        b=M5fgQmD+ZboRM6McbNrlaA2+4+1GGsemRKiiAZtBfh4DrqK7I2SVCxSNWa+eM13mqH
         6jxVu6odvebpcBMx812w2T5YY3hp3vaVtmxECUzsehIS/wJkCrp4fxWyn1MWs5kZys+4
         sY9Zue7M86Ry6EaVycJhT+BBqY8Ng6AbWO9WBbapgMYzASt9xlM3MV4EDZXEk050XiGF
         IHJIhYxX6wy1S0HZbxMa9WNVV1SMS+/lxJme6H8sPD/5sJVeG/AuTSynN8B2VKFq+TZb
         hUnsfukMiBLyi6IUoz9t+XkxBvGjbel6vwzv3AraUOUWJYbwqAFmNYAbOJl8TKyn+gST
         7MAw==
X-Gm-Message-State: AIVw112N8DB+pZdAxK4kI6vNIIzToyBasQlC91DXbUihSHuouhV42l/6
        vknRxSyXMaB3Vqwu
X-Received: by 10.98.139.11 with SMTP id j11mr1381572pfe.18.1499976353071;
        Thu, 13 Jul 2017 13:05:53 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id h123sm10914350pgc.36.2017.07.13.13.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:05:52 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 2/5 v4] submodule--helper: introduce for_each_submodule_list()
Date:   Fri, 14 Jul 2017 01:35:35 +0530
Message-Id: <20170713200538.25806-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170713200538.25806-1-pc44800@gmail.com>
References: <20170630194727.29787-1-pc44800@gmail.com>
 <20170713200538.25806-1-pc44800@gmail.com>
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

