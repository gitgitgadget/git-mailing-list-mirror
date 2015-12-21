From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 1/2] traverse_info: make mostly const
Date: Mon, 21 Dec 2015 17:34:19 -0500
Message-ID: <1450737260-15965-2-git-send-email-dturner@twopensource.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 23:34:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB92R-00019w-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 23:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbbLUWek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 17:34:40 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33601 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbLUWej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 17:34:39 -0500
Received: by mail-qg0-f44.google.com with SMTP id k90so119135672qge.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ve0OWF/dn2ShMYFVHmXvuLUcMmGDSzWVhslKVjPlFR8=;
        b=vYenhLT0cbm5qkPKpmqb3TDvi3cKQos+xxIdzqEP1J0aLIu4FRuSZgxfZBq0Hmq7DD
         Wr9kyjQE7z/n3LaNqxRU65i6vlRKz7IIDxBszBaTz5g20uZmpv9u0r0dbyKjCZxYPnfy
         0mZOujkxZnTqLaSLcormHEoR+6d4xqmPhBPqqLR2d+FXC50HAS1gYWCPP0sCQJnJFEuy
         qDvh7UOGoEJDs3PfV5+Nomn42C9kG6YSYQ5EVJiX8nVdgAUxAxsd66mWCSwAys3JlWy8
         2xHPn2TnnjIGefa3oberrSUKNn/tFF9s8lIZqAKFvpsUYrMXC6fZIa83hnVOLW2YEhWC
         j8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ve0OWF/dn2ShMYFVHmXvuLUcMmGDSzWVhslKVjPlFR8=;
        b=kc0znZ4cDcFDz6XW2nMbMxFZu5EOvHu9PP8i0qLgoOGgDUbWuKg2UFx4GptCD652uV
         2BdyKyrUVP3bVl9nOMu1LTZuXK84XKWtfXBQ3s15U71174+EOg2ST+hysSFYKmzMJrGd
         +SK4+YlZSWP4wlKwRpxEWD4iXw6rJKiJHadhj9z5PMN+NiLGRFM09tDlS2O96sq/ALzj
         O84klHv3kWcNxqxVs85SL3gMDHU/4fAg3JknO0OLeQ0gOxpXEh6OZLyseWfbK7wO5p44
         Qf4aLLPAp2OggnkiprGgECtCWpzmztaJ1vHOMf8aS3e6ZNQUia++qHUVzGfU8rZtnRRS
         6GdA==
X-Gm-Message-State: ALoCoQnh5Jx5ozlTfuSWiajrCTdU9OQkE1QjiNqNacSBtXRY4datXtVtJh8n1zP7utAZ76ExQ+pTqp8m3t0B5RzkgQ7CkQW6tQ==
X-Received: by 10.140.142.207 with SMTP id 198mr20570168qho.77.1450737278496;
        Mon, 21 Dec 2015 14:34:38 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z21sm12643373qge.18.2015.12.21.14.34.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Dec 2015 14:34:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282820>

We don't usually modify traverse_info, so make it const across a wide
range of functions.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/merge-tree.c     |  2 +-
 cache-tree.c             |  4 ++--
 cache-tree.h             |  2 +-
 t/t4010-diff-pathspec.sh |  2 +-
 tree-walk.c              |  2 +-
 tree-walk.h              |  4 ++--
 unpack-trees.c           | 14 +++++++-------
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d4f0cbd..6de2da9 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -304,7 +304,7 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
  * The successful merge rules are the same as for the three-way merge
  * in git-read-tree.
  */
-static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *info)
+static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, const struct traverse_info *info)
 {
 	/* Same in both? */
 	if (same_entry(entry+1, entry+2) || both_empty(entry+1, entry+2)) {
diff --git a/cache-tree.c b/cache-tree.c
index a59e6f1..0fd2ab5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -694,7 +694,7 @@ void prime_cache_tree(struct index_state *istate, struct tree *tree)
  *     above us, and find ourselves in there.
  */
 static struct cache_tree *find_cache_tree_from_traversal(struct cache_tree *root,
-							 struct traverse_info *info)
+							 const struct traverse_info *info)
 {
 	struct cache_tree *our_parent;
 
@@ -706,7 +706,7 @@ static struct cache_tree *find_cache_tree_from_traversal(struct cache_tree *root
 
 int cache_tree_matches_traversal(struct cache_tree *root,
 				 struct name_entry *ent,
-				 struct traverse_info *info)
+				 const struct traverse_info *info)
 {
 	struct cache_tree *it;
 
diff --git a/cache-tree.h b/cache-tree.h
index 41c5746..7f99cc8 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -50,6 +50,6 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix);
 void prime_cache_tree(struct index_state *, struct tree *);
 
-extern int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
+extern int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, const struct traverse_info *info);
 
 #endif
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 43c488b..ad91130 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -52,7 +52,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     '"*file1" should show path1/file1' \
-    'git diff-index --cached $tree -- "*file1" >current &&
+    'echo "$tree" && git diff-index --cached $tree -- "*file1" >current &&
      compare_diff_raw current expected'
 
 cat >expected <<\EOF
diff --git a/tree-walk.c b/tree-walk.c
index 6dccd2d..5eee262 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -301,7 +301,7 @@ static void free_extended_entry(struct tree_desc_x *t)
 }
 
 static inline int prune_traversal(struct name_entry *e,
-				  struct traverse_info *info,
+				  const struct traverse_info *info,
 				  struct strbuf *base,
 				  int still_interesting)
 {
diff --git a/tree-walk.h b/tree-walk.h
index 3b2f7bf..f0a457b 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -37,7 +37,7 @@ int tree_entry(struct tree_desc *, struct name_entry *);
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
 
 struct traverse_info;
-typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
+typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, const struct traverse_info *);
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
 
 enum follow_symlinks_result {
@@ -59,7 +59,7 @@ enum follow_symlinks_result {
 enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode);
 
 struct traverse_info {
-	struct traverse_info *prev;
+	const struct traverse_info *prev;
 	struct name_entry name;
 	int pathlen;
 	struct pathspec *pathspec;
diff --git a/unpack-trees.c b/unpack-trees.c
index 8e2032f..d4bedac 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -422,7 +422,7 @@ static int unpack_index_entry(struct cache_entry *ce,
 	return ret;
 }
 
-static int find_cache_pos(struct traverse_info *, const struct name_entry *);
+static int find_cache_pos(const struct traverse_info *, const struct name_entry *);
 
 static void restore_cache_bottom(struct traverse_info *info, int bottom)
 {
@@ -453,7 +453,7 @@ static int switch_cache_bottom(struct traverse_info *info)
 static int traverse_trees_recursive(int n, unsigned long dirmask,
 				    unsigned long df_conflicts,
 				    struct name_entry *names,
-				    struct traverse_info *info)
+				    const struct traverse_info *info)
 {
 	int i, ret, bottom;
 	struct tree_desc t[MAX_UNPACK_TREES];
@@ -637,7 +637,7 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
  * anything, as we will want to match it when the traversal descends into
  * the directory.
  */
-static int find_cache_pos(struct traverse_info *info,
+static int find_cache_pos(const struct traverse_info *info,
 			  const struct name_entry *p)
 {
 	int pos;
@@ -692,7 +692,7 @@ static int find_cache_pos(struct traverse_info *info,
 	return -1;
 }
 
-static struct cache_entry *find_cache_entry(struct traverse_info *info,
+static struct cache_entry *find_cache_entry(const struct traverse_info *info,
 					    const struct name_entry *p)
 {
 	int pos = find_cache_pos(info, p);
@@ -704,7 +704,7 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 		return NULL;
 }
 
-static void debug_path(struct traverse_info *info)
+static void debug_path(const struct traverse_info *info)
 {
 	if (info->prev) {
 		debug_path(info->prev);
@@ -725,7 +725,7 @@ static void debug_unpack_callback(int n,
 				  unsigned long mask,
 				  unsigned long dirmask,
 				  struct name_entry *names,
-				  struct traverse_info *info)
+				  const struct traverse_info *info)
 {
 	int i;
 	printf("* unpack mask %lu, dirmask %lu, cnt %d ",
@@ -736,7 +736,7 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
 
-static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
+static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, const struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
-- 
2.4.2.749.g730654d-twtrsrc
