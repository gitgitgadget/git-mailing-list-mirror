Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D5B207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 23:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdFZXLZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 19:11:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33201 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdFZXLX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 19:11:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so2149300pfh.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYBCCwt/7f2Tk2VQ/lRoczqVn1IbERQXywsCzlH/958=;
        b=LA44vSiThecUxCxc8Qwc/55WRL4at+xobfhY0ULR6dS/eiFMKVljcE+CPj6Hspt9D9
         a7GDuZgHQkp9E3vqLuIRvg6VOpB+CUa8rt4ItE5iPkpSj7McJYN8H/dOib9vstYG5Xwu
         AZwXnpCebp1EdwI5Ci5xqbn8x1eXZiIdayN6SWCKRxVEqGjoWaQ/8m3rXy+zrugtsX3z
         8F7qYvpqiaqtnaQj02MGPPIoitSElLS3Sx0rKJSy1iIquyVLDQhYTmD0a2MeeXmRLzxK
         Cq8bE0oHvlcB+aCElaE3cyKXCYar2ipWYll2Y4RUTX8oxoUHvkAhT9nGDzrIORnhANev
         ufLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MYBCCwt/7f2Tk2VQ/lRoczqVn1IbERQXywsCzlH/958=;
        b=mCajytw6CO1XHM3H3fyE5cz9xehi/1vCP/luqOvLZP1tlMGzCdH+3x6I1f7Q+eOOG3
         K+hbQNq6g3rbGiIbP93wt5g0jfQhm6PXRrQ/FuoDcNCAPN6Ly5TDcCnhVmrw7Eh4RCzk
         UEf1vCp2q2Ir8CvDVVCdsmiIJlA4+qiHpQizDOfqc30/hhSugiToh4GRgL3yFpWRhP7E
         SPiVythUkXR3Q78oYRRdl0XAGV2zn9/2zXeQGca4CHS6r4ptqagS/BlvDkm82PgYwGBz
         fezhUkoTH+wR+VPb1TFZK+frbhV21o/GYthNRWLpDplYWRs3eUpw3frEcnwptZu3eo2k
         lcDQ==
X-Gm-Message-State: AKS2vOzL/y9lIw7Q1iCH6P8gkb6naew3oZXR0+GZKzB+npzOJUirYPQa
        1UdPzMEXt3YcWw==
X-Received: by 10.84.231.134 with SMTP id g6mr2609921plk.86.1498518682754;
        Mon, 26 Jun 2017 16:11:22 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id p5sm1701339pgf.50.2017.06.26.16.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 16:11:22 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     pc44800@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: [GSoC][PATCH 1/6 v2] submodule--helper: introduce for_each_submodule_list
Date:   Tue, 27 Jun 2017 04:41:03 +0530
Message-Id: <20170626231108.23640-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_submodule_list for using it
in the later patches, related to porting submodule
subcommands from shell to C.
This new function is also used in ported submodule subcommand
init.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This series of patches is based on the 'next' branch. 

Complete build report of this patch series is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: patch-series
Build #113

 builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1bfc91bca..c4286aac5 100644
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
-	if (!is_submodule_initialized(path)) {
+	if (!is_submodule_initialized(list_item->name)) {
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

