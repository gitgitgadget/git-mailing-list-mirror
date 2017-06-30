Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07DA9201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbdF3TsD (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:48:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34201 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbdF3TsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:48:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so16291672pge.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9UeUk0w8E2wX/Lkv/GaOjtG5He4Fr5bdI2BUrcMZdwg=;
        b=jOJygZSvI2noReiOGoJZzMAE5Dt7NmN7nzfAGJqWJFYm11gUWqR5N7eSd+sQj/u4XH
         AVHZo9W4Wh+jIGwwP25OwyW5gYvjglr1Qc7IzAEfVI7VlXwlvMcBV9KV2i7ortGvjAHZ
         Hw5NlzXcIbS28PpzxNxt/LxaZ2zxH2+P6XvJI547JU0LFViEPIiFa22eMih7ch4BCNqt
         AUJdf2rxCeU2Vn8dpRCDnNDSmjQBqW8Gyp0DfqAVdlpK6tYRGlWmN0d4pVDjWcWjhN/8
         5CIROIidumx+x4hPmXx9KIffbfffjdGnnu/LPi2wR2FsJ5J7K17q5IVz83LGhBgw29df
         Br5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9UeUk0w8E2wX/Lkv/GaOjtG5He4Fr5bdI2BUrcMZdwg=;
        b=mf6gYHqIvhkgz1lmH7JPNzdg2BsfIcDadbm3jraEJeLQQw8Y0Nw2km7AwH+sghKSFL
         k0/cUgDkUZbiaiPnahHPEKNxcYMxXGMqTv2quzvS4TuTh4S4FpKw0/59Mg5BdJdpeTok
         031Tx5sa0suhiFABx3+LrLxqnsn4jmp3GUcQozvk1HofAeTFe4YphUgsuqDVYMh9hClD
         JGFN0eM8TqHtyMbqJ6rYXh6X7VYLKly4i8Ax0w0bpfuqxImRVKYakN3qYxjx4xwlWRlj
         fSSnQZHtmuAwT3gkDgfNDzouoer3yTC++qVQy8/smrxBskmdba/MjH0jRg/LJRHLBpFT
         eNDg==
X-Gm-Message-State: AKS2vOw+ZX6vxKiwJhGkDEcVzHkYGFf4g1o6uqquidCha8B12yFczGE7
        sZu6ymj5UlsubO2C
X-Received: by 10.84.229.7 with SMTP id b7mr26505325plk.216.1498852070159;
        Fri, 30 Jun 2017 12:47:50 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id g10sm20972131pfc.38.2017.06.30.12.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:47:49 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 2/5 v3] submodule--helper: introduce for_each_submodule_list()
Date:   Sat,  1 Jul 2017 01:17:24 +0530
Message-Id: <20170630194727.29787-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170630194727.29787-1-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170630194727.29787-1-pc44800@gmail.com>
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

