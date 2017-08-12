Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7A71F667
	for <e@80x24.org>; Sat, 12 Aug 2017 07:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdHLHPI (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 03:15:08 -0400
Received: from mout.web.de ([212.227.15.4]:58036 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdHLHPH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 03:15:07 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPY5x-1dl7b93TmL-004mj0; Sat, 12
 Aug 2017 09:14:42 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] tree-walk: convert fill_tree_descriptor() to object_id
Message-ID: <d1e4b270-4f8b-85e4-b6fd-09657720bed2@web.de>
Date:   Sat, 12 Aug 2017 09:14:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:TluA6SXvgoZtnVnK2ggRN9yV316llb3e5/2fkeL+/Gi7laT+Ms+
 mck+oHM4cfpMBkkhssqXt4re7EeBkqd9qS/b1JOh1AK/pIEZhKMZkNZwOmNQR+BVb3m3cgo
 mQgyh5IXGGXMUYZEJosh38n3tj0qNQCKkaa3efVES61LVOkB6nninBt0PWC13gVRdFWSRjg
 gaynyPP5b+ceQYZs+fA4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LT7/sf0wJzo=:khrvP09yK3KKaKFntmSwSN
 A2P/+gUi1lYDWf8z3q7IEWavmTtnknpMbXrp+02Ea7QcgDT2Dwv8rWoyaA34TG3H/TF+uuhS1
 kavMwMH0rWhfoK9mu4J25fL7NBFhqrTy39u7w30h61j1n24i4m5m8iFO4EtBjkW/RQMqxuf/Y
 74CrYJ3UZRd+ROMDMxn1UhZwxAQ0bU0eDYVZQrAWaPwjCiWCvxxJeulzVblO8p7oa143KDUVu
 jWzs1erA3z38kpebXinknJYg2jaaVNxstR0z3XiRB8ffyGRVhAZK4tzafJ46cKGUYBc3Y86BS
 Qz9IUcQwT80Ip8fl9FTCRbLr6DqW/e5sU/UpFj8DCzExFUo8X9SHaRdde2dN7LZpy9FRMK4mE
 ln5zx5AM24ER3IMG5HCSOg6plxyNcae61h5CJdVnVMiO+nrxIWqAd4zWvPx4ZJnhLvmIeMblf
 ANu6ySTf2D+uwGGfR2DRBLMkJitJLqrlBIaOwAPGrxwJBHCi1QRnDy8AlEUSEAmoGTaEyFxeN
 cBKFwy6JRTipC59fXz+gmYi2Z3S3l2l8cH1nHx+Tlf5+G6OggTaWw5xnst8P0A+I2U6ZLA6fH
 TQUGqgzxiD3NxOY3mTbD2dqzAwC/xK0BpM9H5j2YuHq4oj54VBJc0ap4tEeklt6Zq4UKsaAW4
 3SQqUtsd8am87ocY+0A6ykKrJXNmpXUuHAatZSleopyN24Y4FywDrzygu+SkqoJBZdEQPZ4yw
 iFRTl8F5Xtl7baodulDuhv2bHh9GeindsgGjUtpdfqLqz3h0RGbJanmaSJLpEuFdlKZ56OOaM
 Kfnfi7iPs1qtdLJvD+gipZ+LoYgy6LuO5Riyp46B2Fd0E6XH8o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callers of fill_tree_descriptor() have been converted to object_id
already, so convert that function as well.  As a nice side-effect we get
rid of NULL checks in tree-diff.c, as fill_tree_descriptor() already
does them for us.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-tree-walking.txt |  6 +++---
 builtin/merge-tree.c                         | 10 +++++-----
 builtin/reset.c                              |  4 ++--
 notes.c                                      |  2 +-
 tree-diff.c                                  |  5 ++---
 tree-walk.c                                  |  9 +++++----
 tree-walk.h                                  |  2 +-
 unpack-trees.c                               |  6 +++---
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/api-tree-walking.txt b/Documentation/technical/api-tree-walking.txt
index 14af37c3f1..a5334a472e 100644
--- a/Documentation/technical/api-tree-walking.txt
+++ b/Documentation/technical/api-tree-walking.txt
@@ -55,9 +55,9 @@ Initializing
 
 `fill_tree_descriptor`::
 
-	Initialize a `tree_desc` and decode its first entry given the sha1 of
-	a tree. Returns the `buffer` member if the sha1 is a valid tree
-	identifier and NULL otherwise.
+	Initialize a `tree_desc` and decode its first entry given the
+	object ID of a tree. Returns the `buffer` member if the sha1 is
+	a valid tree identifier and NULL otherwise.
 
 `setup_traverse_info`::
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index f12da292cf..6ea246a200 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -213,10 +213,10 @@ static void unresolved_directory(const struct traverse_info *info,
 
 	newbase = traverse_path(info, p);
 
-#define ENTRY_SHA1(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->oid->hash : NULL)
-	buf0 = fill_tree_descriptor(t+0, ENTRY_SHA1(n + 0));
-	buf1 = fill_tree_descriptor(t+1, ENTRY_SHA1(n + 1));
-	buf2 = fill_tree_descriptor(t+2, ENTRY_SHA1(n + 2));
+#define ENTRY_OID(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->oid : NULL)
+	buf0 = fill_tree_descriptor(t + 0, ENTRY_OID(n + 0));
+	buf1 = fill_tree_descriptor(t + 1, ENTRY_OID(n + 1));
+	buf2 = fill_tree_descriptor(t + 2, ENTRY_OID(n + 2));
 #undef ENTRY_SHA1
 
 	merge_trees(t, newbase);
@@ -352,7 +352,7 @@ static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
 
 	if (get_oid(rev, &oid))
 		die("unknown rev %s", rev);
-	buf = fill_tree_descriptor(desc, oid.hash);
+	buf = fill_tree_descriptor(desc, &oid);
 	if (!buf)
 		die("%s is not a tree", rev);
 	return buf;
diff --git a/builtin/reset.c b/builtin/reset.c
index 046403ed68..4a02d74073 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -75,13 +75,13 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		struct object_id head_oid;
 		if (get_oid("HEAD", &head_oid))
 			return error(_("You do not have a valid HEAD."));
-		if (!fill_tree_descriptor(desc, head_oid.hash))
+		if (!fill_tree_descriptor(desc, &head_oid))
 			return error(_("Failed to find tree of HEAD."));
 		nr++;
 		opts.fn = twoway_merge;
 	}
 
-	if (!fill_tree_descriptor(desc + nr - 1, oid->hash))
+	if (!fill_tree_descriptor(desc + nr - 1, oid))
 		return error(_("Failed to find tree of %s."), oid_to_hex(oid));
 	if (unpack_trees(nr, desc, &opts))
 		return -1;
diff --git a/notes.c b/notes.c
index 503754d79e..f090c88363 100644
--- a/notes.c
+++ b/notes.c
@@ -425,7 +425,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	unsigned char type;
 	struct leaf_node *l;
 
-	buf = fill_tree_descriptor(&desc, subtree->val_oid.hash);
+	buf = fill_tree_descriptor(&desc, &subtree->val_oid);
 	if (!buf)
 		die("Could not read %s for notes-index",
 		     oid_to_hex(&subtree->val_oid));
diff --git a/tree-diff.c b/tree-diff.c
index 2357f72899..4bb93155bc 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -421,9 +421,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	 *   diff_tree_oid(parent, commit) )
 	 */
 	for (i = 0; i < nparent; ++i)
-		tptree[i] = fill_tree_descriptor(&tp[i],
-				parents_oid[i] ? parents_oid[i]->hash : NULL);
-	ttree = fill_tree_descriptor(&t, oid ? oid->hash : NULL);
+		tptree[i] = fill_tree_descriptor(&tp[i], parents_oid[i]);
+	ttree = fill_tree_descriptor(&t, oid);
 
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
diff --git a/tree-walk.c b/tree-walk.c
index 6a42e402b0..c99309069a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -78,15 +78,16 @@ int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned l
 	return result;
 }
 
-void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
+void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid)
 {
 	unsigned long size = 0;
 	void *buf = NULL;
 
-	if (sha1) {
-		buf = read_object_with_reference(sha1, tree_type, &size, NULL);
+	if (oid) {
+		buf = read_object_with_reference(oid->hash, tree_type, &size,
+						 NULL);
 		if (!buf)
-			die("unable to read tree %s", sha1_to_hex(sha1));
+			die("unable to read tree %s", oid_to_hex(oid));
 	}
 	init_tree_desc(desc, buf, size);
 	return buf;
diff --git a/tree-walk.h b/tree-walk.h
index 68bb78b928..b6bd1b4ccf 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -42,7 +42,7 @@ int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long
 int tree_entry(struct tree_desc *, struct name_entry *);
 int tree_entry_gently(struct tree_desc *, struct name_entry *);
 
-void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
+void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid);
 
 struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
diff --git a/unpack-trees.c b/unpack-trees.c
index 862cfce661..233ec5eb3d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -662,10 +662,10 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 		else if (i > 1 && are_same_oid(&names[i], &names[i - 2]))
 			t[i] = t[i - 2];
 		else {
-			const unsigned char *sha1 = NULL;
+			const struct object_id *oid = NULL;
 			if (dirmask & 1)
-				sha1 = names[i].oid->hash;
-			buf[nr_buf++] = fill_tree_descriptor(t+i, sha1);
+				oid = names[i].oid;
+			buf[nr_buf++] = fill_tree_descriptor(t + i, oid);
 		}
 	}
 
-- 
2.14.1

