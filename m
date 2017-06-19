Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA16D1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdFSVuy (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 17:50:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34920 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbdFSVuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 17:50:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so18208686pgc.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hm0cTUVi6RQa3QLBz+pwZ5C7NWvjbO6TzUSMyE8QVc=;
        b=W2DnzvqXAxN8rBLFpNLvDk2AhR0HE9f6LOFipD/Qaras3biBiFQ7lt4l3ghpbbMhnu
         oRfr3yK6OOdv0hksWYcmwOY2JSdvH5hGAGU+r9bIT7PpPi+ldU2NuNorrrVQyq78WXK0
         oDNzymmXcegh/mlBiSVKB26OoLQTCCvLgA9PzpzVWv1YlcMH8PiBEYsQsgQzDQTVz1qs
         V30AvDk+h1+GGqFgySzGACKiGaPtNA5yeuQFakiqZSvlgQLWRQQzCRmM9/ZAr6mzWCHj
         SUCaMylo5OAPcVSD3EmFbD4Ti811H6lxr1pB4MHE6BRk+Ez50SO+8tDjooGWLNcsifxn
         F2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hm0cTUVi6RQa3QLBz+pwZ5C7NWvjbO6TzUSMyE8QVc=;
        b=YP9OsRDuvkGJPvcMVmE96DyQsJ28KqrX1DEpiJVqZqVoYxP428NO31IlB5SC4fdNzv
         +PRxlaWuJvDdQ45mjEb9bzNiCrcWCDSYvjQrlnvLiEh6ngNqnr4iRuD/142LuZOgeSU/
         lureW+VpEJ10rRWYqgbC22gZZPOXH5VMNSMmZnnrjPeMOqMFasfRJkJ6XERmkfdZNmCr
         L9Xq93rMTWxw9i+4Zu8pqwl4v+h/JIBzxzayPjTIYFnYr0GQJXMbCWjRJ6eCN+xtbbWU
         2VpFRiYqc67q9mSyhCo2FWB6oiuK6Z2fTlpu2Uv5qdNdhJRrFIGSHeJbk/ISaXIHR02W
         qYkg==
X-Gm-Message-State: AKS2vOyJ4nu651K4b12XicZ3Gslzy38LN40xq+8wKRKetLj/JLRXewlc
        xnBtKUg+IugjWQFC
X-Received: by 10.99.60.68 with SMTP id i4mr28610647pgn.250.1497909049607;
        Mon, 19 Jun 2017 14:50:49 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id 5sm20744309pfe.60.2017.06.19.14.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 14:50:49 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 2/6] submodule--helper: introduce get_submodule_displaypath and for_each_submodule_list
Date:   Tue, 20 Jun 2017 03:20:21 +0530
Message-Id: <20170619215025.10086-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619215025.10086-1-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions get_submodule_displaypath and for_each_submodule_list
for using them in the later patches, related to porting submodule
subcommands from shell to C.
These new functions are also used in ported submodule subcommand
init

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 69 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8cc648d85..f7adca95b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,6 +13,9 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
+				      void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -219,6 +222,27 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		int len = strlen(super_prefix);
+		const char *format = is_dir_sep(super_prefix[len-1]) ? "%s%s" : "%s/%s";
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -330,26 +354,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
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
-
-	if (prefix && get_super_prefix())
-		die("BUG: cannot have prefix and superprefix");
-	else if (prefix)
-		displaypath = xstrdup(relative_path(path, prefix, &sb));
-	else if (get_super_prefix()) {
-		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
-		displaypath = strbuf_detach(&sb, NULL);
-	} else
-		displaypath = xstrdup(path);
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
 
-	sub = submodule_from_path(null_sha1, path);
+	sub = submodule_from_path(null_sha1, list_item->name);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -361,7 +389,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_initialized(path)) {
+	if (!is_submodule_initialized(list_item->name)) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
@@ -404,7 +432,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!info->quiet)
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -433,10 +461,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -461,8 +489,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
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

