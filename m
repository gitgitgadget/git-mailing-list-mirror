Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C455FC433EF
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2046135A
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 21:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhKGVdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 16:33:38 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55979 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231473AbhKGVdh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2021 16:33:37 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 15D375C005E;
        Sun,  7 Nov 2021 16:30:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 07 Nov 2021 16:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birktj.no; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Pn417deuXKdC7NrG3yOKwaZBIX
        3IuZcoikzqN7tvntQ=; b=fDQc3unDmwxSRr76Uy4BzpdwSkbW3VP6yMgzPvu9TO
        r5COYDsvJdjF95RDrCO1SzemZ90tbR9ykrDHX8RxcwsOQsvnCQLdAdzGmJltvVWR
        3WoGWHD+DMAmKuO8nKiVsA+/nYVqEjWHhunTs9nMjkm6L/m2aP7ciSPFltDiL0ZZ
        9zajYJ6pm+q+2AsNx5Bj/qtXfvpoNumLfuS/7wm7zgOWlRipS4qtfoPkqNHSfJc6
        1DdWkg377eT9hpxilh/pHazaemOpPuwtp6nmbCLJiLCpdM91/H6XgpjcNGov2i+F
        uq0v1a11LJi8MfXEukZNPVATdWur+/6zIXTD38jxkKIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Pn417deuXKdC7NrG3
        yOKwaZBIX3IuZcoikzqN7tvntQ=; b=OuSOzV/uxERprPdwBLY2/izxsunh8iFnb
        I6ujVVTMGnFmAggeT+E7dtu2Et0rllRj1znBZGHiOJ2UFOJNQDkHJvdNwp1NTzk1
        0pFmqFNJySGtKsR85Jl9zKG7rDATZlcI/CB5UX+MQQlQkM8J1RHv0ETqPoZ4slqI
        8AEXSmwhlPX8c5nbb1M6R/flzuP6O8HanAs/XIp/1rRAfddkm9j2o8VDxe9BM8qJ
        GQ6mP8ah/5hkFhXOhKUoUGwRKEUTHyydczR/3uL6K5L2nTTHDKeuzJieOeUaiejg
        lnjO1pYIBdMQc4fh2EmquxTjHr56vRmEeSFLDr3wcynG99iwBtxzw==
X-ME-Sender: <xms:jUWIYcYtN26BwWo0bfDoRDGCFRxv347cD8uT80w7YvlIF4hrHnCS1Q>
    <xme:jUWIYXZ9HK8deCLzqNWvt0iTx2dfRoQf_zOJSoFs20MvBuo_ZR37bxxjg786T7Swq
    8skvB7DIYsp0I0JQZw>
X-ME-Received: <xmr:jUWIYW_HARxFB-ej1oNxr9njUuuhQUdHYr2rcqv5ZtOM77yXExt6GizKSQHIFEmDB0x5DDg2unuJCAWvtNqVKQrHc-R0njA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehirhhkucfvjhgvlhhmvghlrghnugcuoehgihhtsegsihhrkhht
    jhdrnhhoqeenucggtffrrghtthgvrhhnpeduffeijeegieekgfeuueevgfevhffghfdvke
    egvefgfeeljeehueetkedttdejhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtsegsihhrkhhtjhdrnhho
X-ME-Proxy: <xmx:jUWIYWoQJ-c2bbAF4QgFP7IAz_h_L2jorlqiNJevk4HaiXTlJgcEaQ>
    <xmx:jUWIYXr9XM5FKj9wTU8k5SqdO5r8bCwQoO5KZ1hvVOKKoyhsfGvh_g>
    <xmx:jUWIYUQlsmLknVQSBR8IGK9ZYSLg2CH3Awme9JYKmYHvFIVSHtR5kg>
    <xmx:jkWIYWTDcKMvthaA-1EN0TVU8DysIix8m7YeZC0sp1UIzb6cFJYXpw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Nov 2021 16:30:52 -0500 (EST)
From:   Birk Tjelmeland <git@birktj.no>
To:     git@vger.kernel.org
Cc:     Birk Tjelmeland <git@birktj.no>
Subject: [PATCH] stash: show error message when lockfile is present
Date:   Sun,  7 Nov 2021 22:30:12 +0100
Message-Id: <20211107213012.6978-1-git@birktj.no>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multiple git-stash commands silently fail when index.lock is present,
including git stash push and git stash apply. This is somewhat confusing
and a better behaviour would probably be to exit with a meaningful error
message like most other git commands do.

This patch updates repo_refresh_and_write_index to accept another
parameter lock_flags and updates some callsites of this function to call
it with LOCK_REPORT_ON_ERROR resulting a suitable error message when the
relevant git-stash commands used on a repo with an index.lock file.

This patch only adds the described error message to git-stash commands,
however the diff highlights other uses of repo_refresh_and_write_index
which could also benefit from the changes. On the other hand these
callsites already have some limited error messages.

Signed-off-by: Birk Tjelmeland <git@birktj.no>
---
 add-interactive.c | 4 ++--
 add-patch.c       | 4 ++--
 builtin/am.c      | 2 +-
 builtin/merge.c   | 4 ++--
 builtin/stash.c   | 6 +++---
 cache.h           | 4 ++--
 read-cache.c      | 3 ++-
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6498ae196f..e51d19e1b5 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -810,7 +810,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 				       COMMIT_LOCK) < 0)
 		res = -1;
 	else
-		res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 1,
+		res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 0, 1,
 						   NULL, NULL, NULL);
 
 	if (!res)
@@ -1150,7 +1150,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 
 	if (discard_index(r->index) < 0 ||
 	    repo_read_index(r) < 0 ||
-	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
+	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 0, 1,
 					 NULL, NULL, NULL) < 0)
 		warning(_("could not refresh index"));
 
diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39..d8000f02d4 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1680,7 +1680,7 @@ static int patch_update_file(struct add_p_state *s,
 				error(_("'git apply' failed"));
 		}
 		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
+			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0, 0,
 						     1, NULL, NULL, NULL);
 	}
 
@@ -1733,7 +1733,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
 	    (!s.mode->index_only &&
-	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
+	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 0, 1,
 					  NULL, NULL, NULL) < 0) ||
 	    parse_diff(&s, ps) < 0) {
 		add_p_state_clear(&s);
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348..a0dead658c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1750,7 +1750,7 @@ static void am_run(struct am_state *state, int resume)
 
 	unlink(am_path(state, "dirtyindex"));
 
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0)
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0, 0) < 0)
 		die(_("unable to write index file"));
 
 	if (repo_index_has_changes(the_repository, NULL, &sb)) {
diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0..9d168ee965 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -714,7 +714,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 {
 	const char *head_arg = "HEAD";
 
-	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0, 0) < 0)
 		return error(_("Unable to write index."));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
@@ -900,7 +900,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	struct object_id result_tree, result_commit;
 	struct commit_list *parents, **pptr = &parents;
 
-	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0, 0) < 0)
 		return error(_("Unable to write index."));
 
 	write_tree_trivial(&result_tree);
diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654d..977fcc4e40 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -501,7 +501,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	const struct object_id *bases[1];
 
 	read_cache_preload(NULL);
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, LOCK_REPORT_ON_ERROR, 0))
 		return -1;
 
 	if (write_cache_as_tree(&c_tree, 0, NULL))
@@ -1277,7 +1277,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	prepare_fallback_ident("git stash", "git@stash");
 
 	read_cache_preload(NULL);
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0) < 0) {
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, LOCK_REPORT_ON_ERROR, 0) < 0) {
 		ret = -1;
 		goto done;
 	}
@@ -1443,7 +1443,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		free(ps_matched);
 	}
 
-	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0)) {
+	if (refresh_and_write_cache(REFRESH_QUIET, 0, LOCK_REPORT_ON_ERROR, 0)) {
 		ret = -1;
 		goto done;
 	}
diff --git a/cache.h b/cache.h
index eba12487b9..fee557f409 100644
--- a/cache.h
+++ b/cache.h
@@ -444,7 +444,7 @@ extern struct index_state the_index;
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
-#define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
+#define refresh_and_write_cache(refresh_flags, write_flags, lock_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (lock_flags), (gentle), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
@@ -933,7 +933,7 @@ int refresh_index(struct index_state *, unsigned int flags, const struct pathspe
  * Note that if refreshing the index returns an error, we still write
  * out the index (unless locking fails).
  */
-int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
+int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int lock_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
 
 struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
diff --git a/read-cache.c b/read-cache.c
index f398659662..01f2a2d470 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1540,6 +1540,7 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 int repo_refresh_and_write_index(struct repository *repo,
 				 unsigned int refresh_flags,
 				 unsigned int write_flags,
+				 int lock_flags,
 				 int gentle,
 				 const struct pathspec *pathspec,
 				 char *seen, const char *header_msg)
@@ -1547,7 +1548,7 @@ int repo_refresh_and_write_index(struct repository *repo,
 	struct lock_file lock_file = LOCK_INIT;
 	int fd, ret = 0;
 
-	fd = repo_hold_locked_index(repo, &lock_file, 0);
+	fd = repo_hold_locked_index(repo, &lock_file, lock_flags);
 	if (!gentle && fd < 0)
 		return -1;
 	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
-- 
2.33.1

