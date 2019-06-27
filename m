Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2ED1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfF0J3d (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:29:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33136 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0J3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so982521plo.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9mGdhv2v0qujNsvnqHbl1mq0YvjF0iVUfBlPX2oqnQ=;
        b=tOf9kgL7u9Yz00R6UN3olaewDiSC2mSbnzjD3NQ6IMb/etVYGl+UgYwCkMSlAtMOKc
         hJwgF6c5DNHQrNLp3vBg6//47sulPYhWPk9PKDglamMOWKlyt8yAsonlxXkYpEYi44qy
         kSRdI4g8wvEgg5UAFz5jDsGs735g8WrV82zXlw532OYV6sLcCmj5vHXFlgbSY4UDCVcC
         aq0IA8uvDRIf46ebDNTeWCH3NI4xOLeQeTXAv8NOH08hnnYe9xMWlCXqLGdqbQZOLVpR
         DOF13/5HFy8w9JbbZVjXePFVZF83J+aFOhdup0s2G4rtbsxW+OcXlEZo6W2DRiuQ49kH
         G4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9mGdhv2v0qujNsvnqHbl1mq0YvjF0iVUfBlPX2oqnQ=;
        b=ImX62se8VzKOuos+x6JUGPJIjIygMUvtbLf2fwAkCsHramI8oTyPDxykI1SHTg2q8b
         t6zNor9W916e63IpkYAWoPkd++pRA7j60fEE+XKJJLMpUau+dRhSPzHPlJwlqxgXdW6O
         7zhXXdn83Hk4wynRp7gnDEF6Nqn9iFboIi2D/xwuL6CjmkBxVl0ukp+i0IW+7BYaIqSF
         7XK4Nx7U3TOOSBj74jBZTtERqtVURrNqKqZmBcYusJRHI1CLAb6swxmokSTuQKQC4CW2
         h9QHM1d4A7yLT+eE0e2ND6W0iGo1pUmPVCwlKnyDKKBl4VSI2Uxku0BviZ31lEpQfpeU
         Kukw==
X-Gm-Message-State: APjAAAUGAlXr63CutmedNA/9zQ8hEofE15CVR0CKeneJwXoZ+riwtYhG
        U9kM/Ym92TpLAk3U3kHKdXI=
X-Google-Smtp-Source: APXvYqw4tbghBk65ht7FIKVtoqu9DiwPWwVOCzFULI+6D74Ujchc/YKSJS76N0qKeQs2pQxF7+J3fw==
X-Received: by 2002:a17:902:708c:: with SMTP id z12mr3482509plk.205.1561627772178;
        Thu, 27 Jun 2019 02:29:32 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id i14sm4248695pfk.0.2019.06.27.02.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:29:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 27 Jun 2019 16:29:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/6] tree-walk.c: remove the_repo from fill_tree_descriptor()
Date:   Thu, 27 Jun 2019 16:28:48 +0700
Message-Id: <20190627092852.11326-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190627092852.11326-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
 <20190627092852.11326-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at there, clean up the_repo usage in builtin/merge-tree.c a tiny
bit.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c | 22 +++++++++++++---------
 builtin/rebase.c     |  4 ++--
 builtin/reset.c      |  4 ++--
 notes.c              |  2 +-
 sequencer.c          |  2 +-
 tree-diff.c          |  4 ++--
 tree-walk.c          |  6 ++++--
 tree-walk.h          |  4 +++-
 unpack-trees.c       |  2 +-
 9 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 34ca0258b1..97b54caeb9 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -205,6 +205,7 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 static void unresolved_directory(const struct traverse_info *info,
 				 struct name_entry n[3])
 {
+	struct repository *r = the_repository;
 	char *newbase;
 	struct name_entry *p;
 	struct tree_desc t[3];
@@ -220,9 +221,9 @@ static void unresolved_directory(const struct traverse_info *info,
 	newbase = traverse_path(info, p);
 
 #define ENTRY_OID(e) (((e)->mode && S_ISDIR((e)->mode)) ? &(e)->oid : NULL)
-	buf0 = fill_tree_descriptor(t + 0, ENTRY_OID(n + 0));
-	buf1 = fill_tree_descriptor(t + 1, ENTRY_OID(n + 1));
-	buf2 = fill_tree_descriptor(t + 2, ENTRY_OID(n + 2));
+	buf0 = fill_tree_descriptor(r, t + 0, ENTRY_OID(n + 0));
+	buf1 = fill_tree_descriptor(r, t + 1, ENTRY_OID(n + 1));
+	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
 #undef ENTRY_OID
 
 	merge_trees(t, newbase);
@@ -351,14 +352,16 @@ static void merge_trees(struct tree_desc t[3], const char *base)
 	traverse_trees(&the_index, 3, t, &info);
 }
 
-static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
+static void *get_tree_descriptor(struct repository *r,
+				 struct tree_desc *desc,
+				 const char *rev)
 {
 	struct object_id oid;
 	void *buf;
 
-	if (get_oid(rev, &oid))
+	if (repo_get_oid(r, rev, &oid))
 		die("unknown rev %s", rev);
-	buf = fill_tree_descriptor(desc, &oid);
+	buf = fill_tree_descriptor(r, desc, &oid);
 	if (!buf)
 		die("%s is not a tree", rev);
 	return buf;
@@ -366,15 +369,16 @@ static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
+	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
 	if (argc != 4)
 		usage(merge_tree_usage);
 
-	buf1 = get_tree_descriptor(t+0, argv[1]);
-	buf2 = get_tree_descriptor(t+1, argv[2]);
-	buf3 = get_tree_descriptor(t+2, argv[3]);
+	buf1 = get_tree_descriptor(r, t+0, argv[1]);
+	buf2 = get_tree_descriptor(r, t+1, argv[2]);
+	buf3 = get_tree_descriptor(r, t+2, argv[3]);
 	merge_trees(t, "");
 	free(buf1);
 	free(buf2);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b8116db487..28490f5f88 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -840,13 +840,13 @@ static int reset_head(struct object_id *oid, const char *action,
 		goto leave_reset_head;
 	}
 
-	if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
+	if (!reset_hard && !fill_tree_descriptor(the_repository, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
 			    oid_to_hex(&head_oid));
 		goto leave_reset_head;
 	}
 
-	if (!fill_tree_descriptor(&desc[nr++], oid)) {
+	if (!fill_tree_descriptor(the_repository, &desc[nr++], oid)) {
 		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
 		goto leave_reset_head;
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 26ef9a7bd0..77c38f28c2 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -79,13 +79,13 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		struct object_id head_oid;
 		if (get_oid("HEAD", &head_oid))
 			return error(_("You do not have a valid HEAD."));
-		if (!fill_tree_descriptor(desc + nr, &head_oid))
+		if (!fill_tree_descriptor(the_repository, desc + nr, &head_oid))
 			return error(_("Failed to find tree of HEAD."));
 		nr++;
 		opts.fn = twoway_merge;
 	}
 
-	if (!fill_tree_descriptor(desc + nr, oid)) {
+	if (!fill_tree_descriptor(the_repository, desc + nr, oid)) {
 		error(_("Failed to find tree of %s."), oid_to_hex(oid));
 		goto out;
 	}
diff --git a/notes.c b/notes.c
index 532ec37865..2522b87d77 100644
--- a/notes.c
+++ b/notes.c
@@ -397,7 +397,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	struct name_entry entry;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
-	buf = fill_tree_descriptor(&desc, &subtree->val_oid);
+	buf = fill_tree_descriptor(the_repository, &desc, &subtree->val_oid);
 	if (!buf)
 		die("Could not read %s for notes-index",
 		     oid_to_hex(&subtree->val_oid));
diff --git a/sequencer.c b/sequencer.c
index ab74b6baf1..d565fcf2b1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3194,7 +3194,7 @@ static int do_reset(struct repository *r,
 		return error_resolve_conflict(_(action_name(opts)));
 	}
 
-	if (!fill_tree_descriptor(&desc, &oid)) {
+	if (!fill_tree_descriptor(r, &desc, &oid)) {
 		error(_("failed to find tree of %s"), oid_to_hex(&oid));
 		rollback_lock_file(&lock);
 		free((void *)desc.buffer);
diff --git a/tree-diff.c b/tree-diff.c
index f1f641eb6a..33ded7f8b3 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -422,8 +422,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	 *   diff_tree_oid(parent, commit) )
 	 */
 	for (i = 0; i < nparent; ++i)
-		tptree[i] = fill_tree_descriptor(&tp[i], parents_oid[i]);
-	ttree = fill_tree_descriptor(&t, oid);
+		tptree[i] = fill_tree_descriptor(opt->repo, &tp[i], parents_oid[i]);
+	ttree = fill_tree_descriptor(opt->repo, &t, oid);
 
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = opt->flags.recursive;
diff --git a/tree-walk.c b/tree-walk.c
index 0c7722b220..c5569b3e9f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -81,13 +81,15 @@ int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned l
 	return result;
 }
 
-void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid)
+void *fill_tree_descriptor(struct repository *r,
+			   struct tree_desc *desc,
+			   const struct object_id *oid)
 {
 	unsigned long size = 0;
 	void *buf = NULL;
 
 	if (oid) {
-		buf = read_object_with_reference(the_repository, oid, tree_type, &size, NULL);
+		buf = read_object_with_reference(r, oid, tree_type, &size, NULL);
 		if (!buf)
 			die("unable to read tree %s", oid_to_hex(oid));
 	}
diff --git a/tree-walk.h b/tree-walk.h
index 161e2400f4..9aa1042642 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -45,7 +45,9 @@ int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long
 int tree_entry(struct tree_desc *, struct name_entry *);
 int tree_entry_gently(struct tree_desc *, struct name_entry *);
 
-void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid);
+void *fill_tree_descriptor(struct repository *r,
+			   struct tree_desc *desc,
+			   const struct object_id *oid);
 
 struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
diff --git a/unpack-trees.c b/unpack-trees.c
index 50189909b8..cfe1c5ec6f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -840,7 +840,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 			const struct object_id *oid = NULL;
 			if (dirmask & 1)
 				oid = &names[i].oid;
-			buf[nr_buf++] = fill_tree_descriptor(t + i, oid);
+			buf[nr_buf++] = fill_tree_descriptor(the_repository, t + i, oid);
 		}
 	}
 
-- 
2.22.0.rc0.322.g2b0371e29a

