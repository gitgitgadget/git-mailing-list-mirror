Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710721F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHQSmQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40244 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfHQSmO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so452283pls.7
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQ2J8FNN0rIIgDddYStkzeBGjyBYSJZXa0CgsFbbsbM=;
        b=IcK0CxdeTXWBgEd/MEPAOfFteHkc7JZc/ABITkEM0wE49S83XhomOLZsI+Ke07pFeA
         nfSZdO3cFf3OFAwQKmkYMA+hyd4sSmES8EEzWBnYnTIlL9AO/xmgyz6kfAM2beEKp1ej
         n++gTtlmeXWwzLlAcJWVkZ/0TLQIZRQ36JvSd9huApk8a5S+ttPGjRoPvRZNdmvCwtQB
         IV7K859NzrHrqwCxFuBtEP99ld+q2CotY8C+rLc4Nq9Msj58V7Aqpda86rYdwLX9GExP
         zkkf7w3F2MMW3QxvLkBCjctR+RoiOVYskym7GLI1AaML3bED3scnrY2ddK2cYHkGWQg5
         1FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQ2J8FNN0rIIgDddYStkzeBGjyBYSJZXa0CgsFbbsbM=;
        b=GtJH8Vm63cOugTDMx4W51qKIvUWI57cb8kExO149iY56zNexo2BFZUQjkeNiKygA7o
         nYWiGqI2dzZYueJMwVwhzA4U89ArgjUGXtsa0lsdeAnL7cP3hnYpQgS/38fdOBk/88Bm
         eQX+3IKonuRgzevKJpmM+6PyupKKTCDQVDLQESDiZQOK2Z3NOjI5XosIiAtg4u44AgFf
         2smvx6ri+WpoaRPOMKfaOQg6CGY3Wvzv5jlZ1dDpi+7+5+oN5FJLWvxYzLApIPYWB4CX
         Y9I7BJ/2BrAHMj/MdvPd0aDdYccEk2wUbETr1FGLlOmiUQqno1HxgX9oP7SyxT9q6Mu8
         gOVg==
X-Gm-Message-State: APjAAAV8lEk9a27Edcgen0dQLraKzJ4ZsM4HqVf6s4SIb0YxBnOKaHE8
        gnXn6Hk4+afGdeHlV8XeCd4MbpI0
X-Google-Smtp-Source: APXvYqz542kALraEX+iXwy118Np5yofKNgRuPhLKj5j3UOcFkpZVYejDbamlqmkkLeJ9H7yLhdMHzA==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr15119228pls.127.1566067333279;
        Sat, 17 Aug 2019 11:42:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:12 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 13/24] merge-recursive: fix some overly long lines
Date:   Sat, 17 Aug 2019 11:41:33 -0700
Message-Id: <20190817184144.32179-14-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No substantive code change, just add some line breaks to fix lines that
have grown in length due to various refactorings.  Most remaining lines
of excessive length in merge-recursive include error messages and it's
not clear that splitting those improves things.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ae509357f7..720678c21d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -681,7 +681,9 @@ static void add_flattened_path(struct strbuf *out, const char *s)
 			out->buf[i] = '_';
 }
 
-static char *unique_path(struct merge_options *opt, const char *path, const char *branch)
+static char *unique_path(struct merge_options *opt,
+			 const char *path,
+			 const char *branch)
 {
 	struct path_hashmap_entry *entry;
 	struct strbuf newpath = STRBUF_INIT;
@@ -915,7 +917,8 @@ static int update_file_flags(struct merge_options *opt,
 		}
 		if (S_ISREG(contents->mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(opt->repo->index, path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(opt->repo->index,
+						    path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
@@ -3393,7 +3396,8 @@ static int merge_trees_internal(struct merge_options *opt,
 		 * opposed to decaring a local hashmap is for convenience
 		 * so that we don't have to pass it to around.
 		 */
-		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp, NULL, 512);
+		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp,
+			     NULL, 512);
 		get_files_dirs(opt, head);
 		get_files_dirs(opt, merge);
 
@@ -3502,7 +3506,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 		struct tree *tree;
 
 		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(opt->repo, tree, "ancestor");
+		merged_common_ancestors = make_virtual_commit(opt->repo,
+							      tree, "ancestor");
 		ancestor_name = "empty tree";
 	} else if (ca) {
 		ancestor_name = "merged common ancestors";
@@ -3625,7 +3630,8 @@ int merge_recursive(struct merge_options *opt,
 	return clean;
 }
 
-static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
+static struct commit *get_ref(struct repository *repo,
+			      const struct object_id *oid,
 			      const char *name)
 {
 	struct object *object;
@@ -3660,7 +3666,8 @@ int merge_recursive_generic(struct merge_options *opt,
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(opt->repo, base_list[i], oid_to_hex(base_list[i]))))
+			if (!(base = get_ref(opt->repo, base_list[i],
+					     oid_to_hex(base_list[i]))))
 				return err(opt, _("Could not parse object '%s'"),
 					   oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

