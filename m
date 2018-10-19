Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A091F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJSW7a (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37317 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeJSW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so25459548lfa.4
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iEbt7bNNLTPd4MO+jWXzC0yX7NMt014yDKrHS/QyBk=;
        b=HvWhwMH78nXjIYNwQ7LDub5QYxzKRVP/vBCgFjpEqTMX0A7OEIzr8iO41pdW7Cn2tN
         B7xz5Wf9jgBZMj6QM4vNflbw7kzDZznj6rhTxXKFnRAIKAYAP/46kfMKGHe7AUpthME8
         S/pfVrRO6csmPj0dgj1pdmQHjAOeyO9m6j3wpWEV39reyQDg08WzfqrghXEE0pG0F1ay
         bimJCZ0CCL6QdliFS9Qnw4rVrxOa9uaX27FWzPh/WfhNwTy1Vt/R2DgYsflIB3XDWLK8
         LPFoZj7i7Cl7V+QEIsEvQOfE5wAJ1K/fQY/S84kkfHlnnzvtvO/MCVe75iE/AruujicX
         CavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iEbt7bNNLTPd4MO+jWXzC0yX7NMt014yDKrHS/QyBk=;
        b=f6efmJEqUNxuMOvdC+B7DkGUPZpzrTiCBMrwo69kJpqE13of1KiYc+harjeRTRnZpd
         6NayDwkfs89nr7zrzg4uB+Q7Wwy5ClejjR0I4BdFcvpKusPedVGP6pSRlnCEwoCWJQzd
         MHRMQKPIaSHAZ4hU1+2t3ILnu4xeNe9qLcolMhBxEu7gp+dJRsi3oneu2AEmdfjPmrCf
         JlzruckLfWhelc8/NRDjgcFmr0izk9op3+g6DuwsegYHOn299wy0mNY1xPSc49s0h1NV
         le8EF7Edq33vNNZLvicY74kJZWUR259S9dLqEZZd7VKZBnFdH/8pxgaPYeCeO0dLZbQZ
         MaEw==
X-Gm-Message-State: ABuFfojNaZ9h3Pqazv3lhtMjs3soe0w1Mq3eD4utRMH3rBrqU8MJDUP7
        L0FUmUgmVLb4oOAKFq3OE+YZ5toj
X-Google-Smtp-Source: ACcGV63SSSEa13rEcnEAbHO/YZ80125tp59jN/Nphqq2Lzm7mqY8eUSe2hlGp/NHer5B0ndn5b1ezg==
X-Received: by 2002:a19:641d:: with SMTP id y29mr993297lfb.14.1539960780885;
        Fri, 19 Oct 2018 07:53:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:53:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/19] merge-recursive.c: remove implicit dependency on the_repository
Date:   Fri, 19 Oct 2018 16:52:34 +0200
Message-Id: <20181019145237.16079-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 merge-recursive.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 184945ae67..ad0a5b0202 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -146,7 +146,8 @@ static int err(struct merge_options *o, const char *err, ...)
 	return -1;
 }
 
-static struct tree *shift_tree_object(struct tree *one, struct tree *two,
+static struct tree *shift_tree_object(struct repository *repo,
+				      struct tree *one, struct tree *two,
 				      const char *subtree_shift)
 {
 	struct object_id shifted;
@@ -159,12 +160,14 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	}
 	if (oideq(&two->object.oid, &shifted))
 		return two;
-	return lookup_tree(the_repository, &shifted);
+	return lookup_tree(repo, &shifted);
 }
 
-static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
+static struct commit *make_virtual_commit(struct repository *repo,
+					  struct tree *tree,
+					  const char *comment)
 {
-	struct commit *commit = alloc_commit_node(the_repository);
+	struct commit *commit = alloc_commit_node(repo);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	commit->maybe_tree = tree;
@@ -420,7 +423,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		return NULL;
 	}
 
-	result = lookup_tree(the_repository, &istate->cache_tree->oid);
+	result = lookup_tree(o->repo, &istate->cache_tree->oid);
 
 	return result;
 }
@@ -1200,9 +1203,9 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(the_repository, base)) ||
-	    !(commit_a = lookup_commit_reference(the_repository, a)) ||
-	    !(commit_b = lookup_commit_reference(the_repository, b))) {
+	if (!(commit_base = lookup_commit_reference(o->repo, base)) ||
+	    !(commit_a = lookup_commit_reference(o->repo, a)) ||
+	    !(commit_b = lookup_commit_reference(o->repo, b))) {
 		output(o, 1, _("Failed to merge submodule %s (commits not present)"), path);
 		return 0;
 	}
@@ -3286,8 +3289,8 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (o->subtree_shift) {
-		merge = shift_tree_object(head, merge, o->subtree_shift);
-		common = shift_tree_object(head, common, o->subtree_shift);
+		merge = shift_tree_object(o->repo, head, merge, o->subtree_shift);
+		common = shift_tree_object(o->repo, head, common, o->subtree_shift);
 	}
 
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
@@ -3423,8 +3426,8 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
+		tree = lookup_tree(o->repo, o->repo->hash_algo->empty_tree);
+		merged_common_ancestors = make_virtual_commit(o->repo, tree, "ancestor");
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
@@ -3468,7 +3471,7 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	if (o->call_depth) {
-		*result = make_virtual_commit(mrtree, "merged tree");
+		*result = make_virtual_commit(o->repo, mrtree, "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
@@ -3481,17 +3484,17 @@ int merge_recursive(struct merge_options *o,
 	return clean;
 }
 
-static struct commit *get_ref(const struct object_id *oid, const char *name)
+static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
+			      const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(the_repository, parse_object(the_repository, oid),
-			   name,
-			   strlen(name));
+	object = deref_tag(repo, parse_object(repo, oid),
+			   name, strlen(name));
 	if (!object)
 		return NULL;
 	if (object->type == OBJ_TREE)
-		return make_virtual_commit((struct tree*)object, name);
+		return make_virtual_commit(repo, (struct tree*)object, name);
 	if (object->type != OBJ_COMMIT)
 		return NULL;
 	if (parse_commit((struct commit *)object))
@@ -3508,15 +3511,15 @@ int merge_recursive_generic(struct merge_options *o,
 {
 	int clean;
 	struct lock_file lock = LOCK_INIT;
-	struct commit *head_commit = get_ref(head, o->branch1);
-	struct commit *next_commit = get_ref(merge, o->branch2);
+	struct commit *head_commit = get_ref(o->repo, head, o->branch1);
+	struct commit *next_commit = get_ref(o->repo, merge, o->branch2);
 	struct commit_list *ca = NULL;
 
 	if (base_list) {
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(base_list[i], oid_to_hex(base_list[i]))))
+			if (!(base = get_ref(o->repo, base_list[i], oid_to_hex(base_list[i]))))
 				return err(o, _("Could not parse object '%s'"),
 					   oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
-- 
2.19.1.647.g708186aaf9

