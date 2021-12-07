Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E3EC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbhLGUXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhLGUXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC84C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t18so106224wrg.11
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8baBi+iB5EmUXfaV+i/d7WzegeVzHB95Yq+6OcrJZkE=;
        b=VGQ+1sWMBf9eDJTMjH9e+YA/lKqc8AnauKGzBJy4qWM//mq/OmZbBlnX/4njxarqcF
         XATYB+OKMPTayaJYFW1C0NclyIH6Vl13oqEoelUL7KX06Xx9R0hZr1R+tlRq8qM/QTwx
         z/irCRgGqJBHOnKUw+KGBxCo+/IWj9dzZYeOHMY9xG635+I+MrxEVDMjPW32GbkoMWp8
         lfjX0a5Qy9SYRoYBsQauU+Zkg4XedjolUrFPi6ZS/2q2A4c4oD78scxkU7ronToeZ9nV
         3SGVzdVgIv+Y/OwbHYtvIR1GvqPJYWy5G5SPfA01lWC7nxZr3CPBw5PxDDGg7iMwN3aX
         bysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8baBi+iB5EmUXfaV+i/d7WzegeVzHB95Yq+6OcrJZkE=;
        b=AKLxPn4oZwGlSlCF25/6ayvXnmBYFAIn3VJver8A4Ayb1W0Pj5cDyaPuaqhrdAPbHu
         P56ZpohIFCJ/fVNLDhzNgBJWHZhxvpJUe0UGKe1SITo0OnYKc35AUZup52ywcGV55vzF
         Y3N47Ul22grPiMZ25i+ryBORhXXDPsj6gYdDP+N3XiHkD21mvnWtLrRgge/5ySnsb52t
         hxwxXOl1oi64w3BDu319aY99iZxiYDKFGoRCRFn9wUlJrLvaia8qpj5qEAYfw6K7Kb6H
         Tw3/zbvRnVAwiVyVLok6YiR3cI7q4BcEeqUptCEZaGYirm5zHVmNt0opby5dlfG4LDm3
         yl8g==
X-Gm-Message-State: AOAM532btJLcb6jzSx8PBoGBiEqZDyiT9p13fB33VCMKIYeliFf3Wqsl
        wcFrnczV6XBsP29uPIpJCwQhIAFTLT8=
X-Google-Smtp-Source: ABdhPJwZGUBcXBDMhUzuH5nMbXwLk2stk2c4uu3ZjrbK1SXuoVUxS7TIUf9dZf/L3Hqtc7R93quDYg==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr54016092wrs.108.1638908412808;
        Tue, 07 Dec 2021 12:20:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm662136wrx.83.2021.12.07.12.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:12 -0800 (PST)
Message-Id: <e41cfe3c1bbf4c26202102782631a614a450ac27.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:01 +0000
Subject: [PATCH v2 01/10] sparse-checkout: pass use_stdin as a parameter
 instead of as a global
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

add_patterns_from_input() has relied on a global variable,
set_opts.use_stdin, which has been used by both the `set` and `add`
subcommands of sparse-checkout.  Once we introduce an
add_opts.use_stdin, the hardcoding of set_opts.use_stdin will be
incorrect.  Pass the value as function parameter instead to allow us to
make subsequent changes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..8612328e5dd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -525,7 +525,8 @@ static struct sparse_checkout_set_opts {
 } set_opts;
 
 static void add_patterns_from_input(struct pattern_list *pl,
-				    int argc, const char **argv)
+				    int argc, const char **argv,
+				    int use_stdin)
 {
 	int i;
 	if (core_sparse_checkout_cone) {
@@ -535,7 +536,7 @@ static void add_patterns_from_input(struct pattern_list *pl,
 		hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
 		pl->use_cone_patterns = 1;
 
-		if (set_opts.use_stdin) {
+		if (use_stdin) {
 			struct strbuf unquoted = STRBUF_INIT;
 			while (!strbuf_getline(&line, stdin)) {
 				if (line.buf[0] == '"') {
@@ -559,7 +560,7 @@ static void add_patterns_from_input(struct pattern_list *pl,
 			}
 		}
 	} else {
-		if (set_opts.use_stdin) {
+		if (use_stdin) {
 			struct strbuf line = STRBUF_INIT;
 
 			while (!strbuf_getline(&line, stdin)) {
@@ -580,7 +581,8 @@ enum modify_type {
 };
 
 static void add_patterns_cone_mode(int argc, const char **argv,
-				   struct pattern_list *pl)
+				   struct pattern_list *pl,
+				   int use_stdin)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct pattern_entry *pe;
@@ -588,7 +590,7 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 	struct pattern_list existing;
 	char *sparse_filename = get_sparse_checkout_filename();
 
-	add_patterns_from_input(pl, argc, argv);
+	add_patterns_from_input(pl, argc, argv, use_stdin);
 
 	memset(&existing, 0, sizeof(existing));
 	existing.use_cone_patterns = core_sparse_checkout_cone;
@@ -614,17 +616,19 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 }
 
 static void add_patterns_literal(int argc, const char **argv,
-				 struct pattern_list *pl)
+				 struct pattern_list *pl,
+				 int use_stdin)
 {
 	char *sparse_filename = get_sparse_checkout_filename();
 	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
 					   pl, NULL, 0))
 		die(_("unable to load existing sparse-checkout patterns"));
 	free(sparse_filename);
-	add_patterns_from_input(pl, argc, argv);
+	add_patterns_from_input(pl, argc, argv, use_stdin);
 }
 
-static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
+static int modify_pattern_list(int argc, const char **argv, int use_stdin,
+			       enum modify_type m)
 {
 	int result;
 	int changed_config = 0;
@@ -633,13 +637,13 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 	switch (m) {
 	case ADD:
 		if (core_sparse_checkout_cone)
-			add_patterns_cone_mode(argc, argv, pl);
+			add_patterns_cone_mode(argc, argv, pl, use_stdin);
 		else
-			add_patterns_literal(argc, argv, pl);
+			add_patterns_literal(argc, argv, pl, use_stdin);
 		break;
 
 	case REPLACE:
-		add_patterns_from_input(pl, argc, argv);
+		add_patterns_from_input(pl, argc, argv, use_stdin);
 		break;
 	}
 
@@ -675,7 +679,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	return modify_pattern_list(argc, argv, m);
+	return modify_pattern_list(argc, argv, set_opts.use_stdin, m);
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-- 
gitgitgadget

