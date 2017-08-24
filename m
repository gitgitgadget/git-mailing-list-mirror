Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B327320285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdHXTvl (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:51:41 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34720 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbdHXTvl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:51:41 -0400
Received: by mail-pg0-f67.google.com with SMTP id 63so683231pgc.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A04Gg+iwKQyWI7M3o8oga3Cwa8k00CZWMRK7BWEAvZA=;
        b=jSmqoLFpvL5ly0b5+kqSyFtgw3hkiPzQ/hGPHuYRoas5lGf7v3+0q4N2pZu/1gahXs
         Lq1pQHJKpOCv2D0dv43IFviy1kzGdT+GiHeLttFCm5A3drnuwk3MAGd6dcPiXHTlyxHG
         7kh4mSyrLpHimwsd5cxev02+FElHwBMSolHVSNQW+kG+daNAYXY470wwvgBrI0me+3MV
         9eCBpUQF0mviXNpktsZGmB8fn5jtsrHNmQNFFkOoLV3L7w/g2Tx7xHDbu/rq/Wg4hjZF
         K/1Eczs2pJVqh6PDHdev8xUqufAotHpgroUB9DLvWzDGJWG1OnQ/IrBcOF2JWxKFQ03w
         FjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A04Gg+iwKQyWI7M3o8oga3Cwa8k00CZWMRK7BWEAvZA=;
        b=iefBZRsgp3MjQRWkIhDlCq/LxLNIxRjlGa5X/GK9MFh9RtdZEny737q0mLDtKgZiiq
         R6yaCLKzScdvJZbDFdZmzmMm4dWszQVIKW6YtXlXNiSRHMdrLJm+wERc0DPXPo62tPjU
         GmpJ5jSn952NeIX24BjrR2W2dR8PI8eOe4WkQDNqCOczmxybtizSYv8pY8/tvBBTBiwb
         LbB2p1KDvoaqsF6EwoEBioBhxgT1U6Uc30jQCcC1LKMSVK8B+wPD5cr5vUt7sh87pPZZ
         ZvzxVB9S1x3BeYZgKBK+1/1JB2Mn4KDzfwGbSsEvHSJtp8POkXoT+g77jmbPHMMbc3xm
         GxZQ==
X-Gm-Message-State: AHYfb5h1dJGB3QjG6BZwpxCwnXEn+bdvHqvj/padmIQLyvtHna//Kohi
        5DU/62m8Yte0sg==
X-Received: by 10.84.196.164 with SMTP id l33mr8030107pld.198.1503604300268;
        Thu, 24 Aug 2017 12:51:40 -0700 (PDT)
Received: from localhost.localdomain ([27.63.191.1])
        by smtp.gmail.com with ESMTPSA id v2sm9074270pfl.21.2017.08.24.12.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 12:51:39 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v3 2/4] submodule--helper: introduce for_each_listed_submodule()
Date:   Fri, 25 Aug 2017 01:20:49 +0530
Message-Id: <20170824195051.30900-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170824195051.30900-1-pc44800@gmail.com>
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
 <20170824195051.30900-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function for_each_listed_submodule() and replace a loop
in module_init() with a call to it.

The new function will also be used in other parts of the
system in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e666f84ba..8cd81b144 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -14,6 +14,9 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
+				  void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -353,17 +356,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void init_submodule(const char *path, const char *prefix, int quiet)
+static void for_each_listed_submodule(const struct module_list *list,
+				      each_submodule_fn fn, void *cb_data)
+{
+	int i;
+	for (i = 0; i < list->nr; i++)
+		fn(list->entries[i], cb_data);
+}
+
+struct init_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+};
+#define INIT_CB_INIT { NULL, 0 }
+
+static void init_submodule(const struct cache_entry *list_item, void *cb_data)
 {
+	struct init_cb *info = cb_data;
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	/* Only loads from .gitmodules, no overlay with .git/config */
-	gitmodules_config();
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(&null_oid, list_item->name);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -375,7 +391,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 *
 	 * Set active flag for the submodule being initialized
 	 */
-	if (!is_submodule_active(the_repository, path)) {
+	if (!is_submodule_active(the_repository, list_item->name)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 		strbuf_reset(&sb);
@@ -417,7 +433,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (git_config_set_gently(sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
-		if (!quiet)
+		if (!info->quiet)
 			fprintf(stderr,
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
@@ -446,10 +462,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
+	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-	int i;
 
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
@@ -474,8 +490,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	if (!argc && git_config_get_value_multi("submodule.active"))
 		module_list_active(&list);
 
-	for (i = 0; i < list.nr; i++)
-		init_submodule(list.entries[i]->name, prefix, quiet);
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+
+	gitmodules_config();
+	for_each_listed_submodule(&list, init_submodule, &info);
 
 	return 0;
 }
-- 
2.13.0

