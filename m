Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE081DDC36
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590824; cv=none; b=YwxWjn8MD8VD9aX9hqWdD5ik8Tj9str5X1L5zmXObJuQe2mRaW8DIbCWd3moNa6KqB3NsAj+Pykd8367ednGf6yMlYKKxLgYQx+SspUOrA+b1sbiSqjkYyqsn/R9ehTBCmlgsbotJ5dXzQ5dqNvGLYz1FQysfut8SOfWnDGdliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590824; c=relaxed/simple;
	bh=1dbBC4VQmtQ0XGAJSGlwazsCnNrRxFxMzsBO8UDstq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7Z+Xofcm90Eo2SxY/h4nL8MVVr8j9Vusndct90L/vIjjDiY3Yjxr20b5msVm/fTHCAP9Jezn8uwwhYTZvLwlepK/VcipA0DA73mdv7p0RV0w5zS8PoVQ6H8VQt2tDtxPym3H1XUqDqoeASQYAU+AmIIMauoQ5Y3cMdgBZshqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WRh2iyeX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2Woevyb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WRh2iyeX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2Woevyb"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4566A2540133;
	Mon, 10 Mar 2025 03:13:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 03:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590820;
	 x=1741677220; bh=lnF4MzpygPeRn7/Ev/1fbozH34ekLsSuOJv+pkx+bJg=; b=
	WRh2iyeXvZi6y8MEqen0D+C0xJ8aZhmW0jaDDsjkYpKma4kZK3WmGr2brKy7J1uo
	Ql1Qd3J7s/m7a0QTwpvBuPy5fatWmSjWE9ON1qEe2p0THwwQNYz/29OI4jaxXDut
	BUZ+NcoKiWRF5YY+nQqGa2xkV3jZ1JG3J3pedGm5umQUcODlsmtmCu3ru6iKTHTq
	4h63aAMF8sswLYMuj4FWPf6nMJLku6X0C7zC+MlpKvOIYEN3aIjU1jG5lef56POT
	nd2bKhfQS2C5ZDlDGziY7sYVN+hbPNYlf36oMiemU5dZrHe6FpgUeUFNC01Ec0q2
	qYs0qTjS0GA5YRJUqaz7MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590820; x=
	1741677220; bh=lnF4MzpygPeRn7/Ev/1fbozH34ekLsSuOJv+pkx+bJg=; b=o
	2Woevybgw1HR4Tj6Tv68Rnh/em3A8Rk8SK5iFuSdBlRpmVCGfUnQL8TGZ7n2GRCp
	HD2jJZAvei0wNRUYBgtB4pyg5YO7WFj8o3wffJLTxLAovJ2ZoDfPIBfV0hE9bTAy
	V4orSga1QWzK18oA5FjPscxG0qwaksxJIqAuVWeu6GcvLB6Y8PSVvGo2KDr8kcn5
	dewyjcMHlhNOLqN7U+yHsN2XVa5qR4TCAznAkzl+eJsceMhxLOwvoXtM1hXCIol8
	4T7nPO61iRAToA7hkhWA1jMCwBhjQDVL/haub1WHC24KZrwkwse40d+jpdhES0q7
	u7+Qanp7t/uvmXgjvOaZw==
X-ME-Sender: <xms:I5HOZ_fIky_KAyA81k3PU-ThWon3MEufLZg0OjtMbIffHEaK62hmmQ>
    <xme:I5HOZ1OXJMY7Cu_7F6dt50uWqsUp47v_4XlwEvq4xGw5U7jxsawxw5lU7V-0wL8rM
    wCEK_ZYRvdkifF6pg>
X-ME-Received: <xmr:I5HOZ4hYba9lElsQbFCS75SWB9n9mdBWt_wC74YVNINs1WeaU3wHZ5BvUeKwJgxdF32Ns9TdngsBj7_8sr5bbObyihZb2ylLEs8AJbQ9TM-gSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:I5HOZw9OXMFhd8fuujQgI5BgZbgkGnkhFeuXVCXoCEVZkspe_FyBvg>
    <xmx:JJHOZ7t6hnauMTRrZtgczMQ9930TgKRGZQHJU8yoEUPH2lN4H663EA>
    <xmx:JJHOZ_Hf0Bikz9IGE4aV_EaE2yKViETFa3Tc4_S6CHQnwS0J1xIDYQ>
    <xmx:JJHOZyNx6xwlKSjxhZZfhYv3lnezsrx6UcJxX7tZ0XvNvxv5zbLqgQ>
    <xmx:JJHOZ1LhnmHTFhYbP5RfvYLkMftc0IaRmKA39epX-WXiSnZ64NB7l5YM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7daddcc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:31 +0100
Subject: [PATCH v4 12/12] hash: stop depending on `the_repository` in
 `null_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-12-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

The `null_oid()` function returns the object ID that only consists of
zeroes. Naturally, this ID also depends on the hash algorithm used, as
the number of zeroes is different between SHA1 and SHA256. Consequently,
the function returns the hash-algorithm-specific null object ID.

This is currently done by depending on `the_hash_algo`, which implicitly
makes us depend on `the_repository`. Refactor the function to instead
pass in the hash algorithm for which we want to retrieve the null object
ID. Adapt callsites accordingly by passing in `the_repository`, thus
bubbling up the dependency on that global variable by one layer.

There are a couple of trivial exceptions for subsystems that already got
rid of `the_repository`. These subsystems instead use the repository
that is available via the calling context:

  - "builtin/grep.c"
  - "grep.c"
  - "refs/debug.c"

There are also two non-trivial exceptions:

  - "diff-no-index.c": Here we know that we may not have a repository
    initialized at all, so we cannot rely on `the_repository`. Instead,
    we adapt `diff_no_index()` to get a `struct git_hash_algo` as
    parameter. The only caller is located in "builtin/diff.c", where we
    know to call `repo_set_hash_algo()` in case we're running outside of
    a Git repository. Consequently, it is fine to continue passing
    `the_repository->hash_algo` even in this case.

  - "builtin/ls-files.c": There is an in-flight patch series that drops
    `USE_THE_REPOSITORY_VARIABLE` in this file, which causes a semantic
    conflict because we use `null_oid()` in `show_submodule()`. The
    value is passed to `repo_submodule_init()`, which may use the object
    ID to resolve a tree-ish in the superproject from which we want to
    read the submodule config. As such, the object ID should refer to an
    object in the superproject, and consequently we need to use its hash
    algorithm.

    This means that we could in theory just not bother about this edge
    case at all and just use `the_repository` in "diff-no-index.c". But
    doing so would feel misdesigned.

Remove the `USE_THE_REPOSITORY_VARIABLE` preprocessor define in
"hash.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c                                    |  2 +-
 blame.c                                      |  2 +-
 branch.c                                     |  2 +-
 builtin/checkout.c                           |  6 ++---
 builtin/clone.c                              |  2 +-
 builtin/describe.c                           |  2 +-
 builtin/diff.c                               |  5 ++--
 builtin/fast-export.c                        | 10 ++++----
 builtin/fsck.c                               |  2 +-
 builtin/grep.c                               |  2 +-
 builtin/ls-files.c                           |  3 ++-
 builtin/rebase.c                             |  2 +-
 builtin/receive-pack.c                       |  2 +-
 builtin/submodule--helper.c                  | 36 ++++++++++++++--------------
 builtin/unpack-objects.c                     |  2 +-
 builtin/update-ref.c                         |  2 +-
 builtin/worktree.c                           |  2 +-
 combine-diff.c                               |  2 +-
 diff-lib.c                                   | 10 ++++----
 diff-no-index.c                              | 28 +++++++++++-----------
 diff.c                                       |  8 +++----
 diff.h                                       |  2 +-
 dir.c                                        |  2 +-
 grep.c                                       |  2 +-
 hash.c                                       |  6 ++---
 hash.h                                       |  2 +-
 log-tree.c                                   |  2 +-
 merge-ort.c                                  | 26 ++++++++++----------
 merge-recursive.c                            | 12 +++++-----
 notes-merge.c                                |  2 +-
 notes.c                                      |  2 +-
 object-file.c                                |  2 +-
 parse-options-cb.c                           |  2 +-
 range-diff.c                                 |  2 +-
 read-cache.c                                 |  2 +-
 refs.c                                       | 12 +++++-----
 refs/debug.c                                 |  2 +-
 refs/files-backend.c                         |  2 +-
 reset.c                                      |  2 +-
 sequencer.c                                  | 10 ++++----
 submodule-config.c                           |  2 +-
 submodule.c                                  | 28 +++++++++++-----------
 t/helper/test-ref-store.c                    |  2 +-
 t/helper/test-submodule-nested-repo-config.c |  2 +-
 tree-diff.c                                  |  4 ++--
 upload-pack.c                                |  2 +-
 wt-status.c                                  |  4 ++--
 xdiff-interface.c                            |  2 +-
 48 files changed, 136 insertions(+), 136 deletions(-)

diff --git a/archive.c b/archive.c
index f4331aeb49e..c95e3981524 100644
--- a/archive.c
+++ b/archive.c
@@ -312,7 +312,7 @@ int write_archive_entries(struct archiver_args *args,
 	struct object_id fake_oid;
 	int i;
 
-	oidcpy(&fake_oid, null_oid());
+	oidcpy(&fake_oid, null_oid(the_hash_algo));
 
 	if (args->baselen > 0 && args->base[args->baselen - 1] == '/') {
 		size_t len = args->baselen;
diff --git a/blame.c b/blame.c
index a15ddf93335..703dab43e78 100644
--- a/blame.c
+++ b/blame.c
@@ -255,7 +255,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (opt->flags.allow_textconv &&
-			    textconv_object(r, read_from, mode, null_oid(), 0, &buf_ptr, &buf_len))
+			    textconv_object(r, read_from, mode, null_oid(the_hash_algo), 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
diff --git a/branch.c b/branch.c
index 91297d55ac9..6d01d7d6bdb 100644
--- a/branch.c
+++ b/branch.c
@@ -633,7 +633,7 @@ void create_branch(struct repository *r,
 						  0, &err);
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
-					&oid, forcing ? NULL : null_oid(),
+					&oid, forcing ? NULL : null_oid(the_hash_algo),
 					NULL, NULL, flags, msg, &err) ||
 		ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 01ea9ff8b28..2e7486cf658 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -130,8 +130,8 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 			      int changed)
 {
 	return run_hooks_l(the_repository, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
+			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
+			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
 			   changed ? "1" : "0", NULL);
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
@@ -710,7 +710,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.src_index = the_repository->index;
 	opts.dst_index = the_repository->index;
 	init_checkout_metadata(&opts.meta, info->refname,
-			       info->commit ? &info->commit->object.oid : null_oid(),
+			       info->commit ? &info->commit->object.oid : null_oid(the_hash_algo),
 			       NULL);
 	if (parse_tree(tree) < 0)
 		return 128;
diff --git a/builtin/clone.c b/builtin/clone.c
index f14229abf45..36aba65e06c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -690,7 +690,7 @@ static int checkout(int submodule_progress, int filter_submodules,
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hooks_l(the_repository, "post-checkout", oid_to_hex(null_oid()),
+	err |= run_hooks_l(the_repository, "post-checkout", oid_to_hex(null_oid(the_hash_algo)),
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
diff --git a/builtin/describe.c b/builtin/describe.c
index e2e73f3d757..23df333fd04 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -518,7 +518,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 {
 	struct rev_info revs;
 	struct strvec args = STRVEC_INIT;
-	struct process_commit_data pcd = { *null_oid(), oid, dst, &revs};
+	struct process_commit_data pcd = { *null_oid(the_hash_algo), oid, dst, &revs};
 
 	strvec_pushl(&args, "internal: The first arg is not parsed",
 		     "--objects", "--in-commit-order", "--reverse", "HEAD",
diff --git a/builtin/diff.c b/builtin/diff.c
index a4fffee42c6..fa963808c31 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -104,7 +104,7 @@ static void builtin_diff_b_f(struct rev_info *revs,
 
 	stuff_change(&revs->diffopt,
 		     blob[0]->mode, canon_mode(st.st_mode),
-		     &blob[0]->item->oid, null_oid(),
+		     &blob[0]->item->oid, null_oid(the_hash_algo),
 		     1, 0,
 		     blob[0]->path ? blob[0]->path : path,
 		     path);
@@ -498,7 +498,8 @@ int cmd_diff(int argc,
 
 	/* If this is a no-index diff, just run it and exit there. */
 	if (no_index)
-		exit(diff_no_index(&rev, no_index == DIFF_NO_INDEX_IMPLICIT,
+		exit(diff_no_index(&rev, the_repository->hash_algo,
+				   no_index == DIFF_NO_INDEX_IMPLICIT,
 				   argc, argv));
 
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a5c82eef1de..7a5c2925cd2 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -869,7 +869,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				p = rewrite_commit((struct commit *)tagged);
 				if (!p) {
 					printf("reset %s\nfrom %s\n\n",
-					       name, oid_to_hex(null_oid()));
+					       name, oid_to_hex(null_oid(the_hash_algo)));
 					free(buf);
 					return;
 				}
@@ -883,7 +883,7 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (tagged->type == OBJ_TAG) {
 		printf("reset %s\nfrom %s\n\n",
-		       name, oid_to_hex(null_oid()));
+		       name, oid_to_hex(null_oid(the_hash_algo)));
 	}
 	skip_prefix(name, "refs/tags/", &name);
 	printf("tag %s\n", name);
@@ -1023,7 +1023,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				 * it.
 				 */
 				printf("reset %s\nfrom %s\n\n",
-				       name, oid_to_hex(null_oid()));
+				       name, oid_to_hex(null_oid(the_hash_algo)));
 				continue;
 			}
 
@@ -1042,7 +1042,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				if (!reference_excluded_commits) {
 					/* delete the ref */
 					printf("reset %s\nfrom %s\n\n",
-					       name, oid_to_hex(null_oid()));
+					       name, oid_to_hex(null_oid(the_hash_algo)));
 					continue;
 				}
 				/* set ref to commit using oid, not mark */
@@ -1153,7 +1153,7 @@ static void handle_deletes(void)
 			continue;
 
 		printf("reset %s\nfrom %s\n\n",
-				refspec->dst, oid_to_hex(null_oid()));
+				refspec->dst, oid_to_hex(null_oid(the_hash_algo)));
 	}
 }
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 62c7494bbda..f86ecd8eaa5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -625,7 +625,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	void *contents = NULL;
 	int eaten;
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct object_id real_oid = *null_oid();
+	struct object_id real_oid = *null_oid(the_hash_algo);
 	int err = 0;
 
 	strbuf_reset(&cb_data->obj_type);
diff --git a/builtin/grep.c b/builtin/grep.c
index cbbf6f26439..283d64cab80 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -453,7 +453,7 @@ static int grep_submodule(struct grep_opt *opt,
 		return 0;
 
 	subrepo = xmalloc(sizeof(*subrepo));
-	if (repo_submodule_init(subrepo, superproject, path, null_oid())) {
+	if (repo_submodule_init(subrepo, superproject, path, null_oid(opt->repo->hash_algo))) {
 		free(subrepo);
 		return 0;
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a4431429b7d..7bc418be5d4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -234,7 +234,8 @@ static void show_submodule(struct repository *superproject,
 {
 	struct repository subrepo;
 
-	if (repo_submodule_init(&subrepo, superproject, path, null_oid()))
+	if (repo_submodule_init(&subrepo, superproject, path,
+				null_oid(superproject->hash_algo)))
 		return;
 
 	if (repo_read_index(&subrepo) < 0)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d7..1cd802dd92a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -925,7 +925,7 @@ static void fill_branch_base(struct rebase_options *options,
 				 options->orig_head, &merge_bases) < 0)
 		exit(128);
 	if (!merge_bases || merge_bases->next)
-		oidcpy(branch_base, null_oid());
+		oidcpy(branch_base, null_oid(the_hash_algo));
 	else
 		oidcpy(branch_base, &merge_bases->item->object.oid);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7b28fc9df6e..b3e2a9d0c60 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -363,7 +363,7 @@ static void write_head_info(void)
 	strvec_clear(&excludes_vector);
 
 	if (!sent_capabilities)
-		show_ref("capabilities^{}", null_oid());
+		show_ref("capabilities^{}", null_oid(the_hash_algo));
 
 	advertise_shallow_grafts(1);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c1a8029714b..570226ea166 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -78,7 +78,7 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 	int ret;
 
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
-				null_oid()) < 0)
+				null_oid(the_hash_algo)) < 0)
 		return die_message(_("could not get a repository handle for submodule '%s'"),
 				   module_path);
 	ret = repo_get_default_remote(&subrepo, default_remote);
@@ -308,7 +308,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	displaypath = get_submodule_displaypath(path, info->prefix,
 						info->super_prefix);
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -468,7 +468,7 @@ static void init_submodule(const char *path, const char *prefix,
 
 	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -645,14 +645,14 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	if (validate_submodule_path(path) < 0)
 		exit(128);
 
-	if (!submodule_from_path(the_repository, null_oid(), path))
+	if (!submodule_from_path(the_repository, null_oid(the_hash_algo), path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		      path);
 
 	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
 
 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
-		print_status(flags, 'U', path, null_oid(), displaypath);
+		print_status(flags, 'U', path, null_oid(the_hash_algo), displaypath);
 		goto cleanup;
 	}
 
@@ -912,7 +912,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 	struct strbuf errmsg = STRBUF_INIT;
 	int total_commits = -1;
 
-	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
+	if (!info->cached && oideq(&p->oid_dst, null_oid(the_hash_algo))) {
 		if (S_ISGITLINK(p->mod_dst)) {
 			struct ref_store *refs = repo_get_submodule_ref_store(the_repository,
 									      p->sm_path);
@@ -1051,7 +1051,7 @@ static void prepare_submodule_summary(struct summary_cb *info,
 
 		if (info->for_status && p->status != 'A' &&
 		    (sub = submodule_from_path(the_repository,
-					       null_oid(), p->sm_path))) {
+					       null_oid(the_hash_algo), p->sm_path))) {
 			char *config_key = NULL;
 			const char *value;
 			int ignore_all = 0;
@@ -1259,7 +1259,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (validate_submodule_path(path) < 0)
 		exit(128);
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
@@ -1404,7 +1404,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	if (validate_submodule_path(path) < 0)
 		exit(128);
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (!sub || !sub->name)
 		goto cleanup;
@@ -1929,7 +1929,7 @@ static int determine_submodule_update_strategy(struct repository *r,
 					       enum submodule_update_type update,
 					       struct submodule_update_strategy *out)
 {
-	const struct submodule *sub = submodule_from_path(r, null_oid(), path);
+	const struct submodule *sub = submodule_from_path(r, null_oid(the_hash_algo), path);
 	char *key;
 	const char *val;
 	int ret;
@@ -2089,7 +2089,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
-	sub = submodule_from_path(the_repository, null_oid(), ce->name);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), ce->name);
 
 	if (!sub) {
 		next_submodule_warn_missing(suc, out, displaypath);
@@ -2485,7 +2485,7 @@ static int remote_submodule_branch(const char *path, const char **branch)
 	char *key;
 	*branch = NULL;
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 	if (!sub)
 		return die_message(_("could not initialize submodule at path '%s'"),
 				   path);
@@ -2531,7 +2531,7 @@ static int ensure_core_worktree(const char *path)
 	const char *cw;
 	struct repository subrepo;
 
-	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
+	if (repo_submodule_init(&subrepo, the_repository, path, null_oid(the_hash_algo)))
 		return die_message(_("could not get a repository handle for submodule '%s'"),
 				   path);
 
@@ -2644,7 +2644,7 @@ static int update_submodule(struct update_data *update_data)
 		return ret;
 
 	if (update_data->just_cloned)
-		oidcpy(&update_data->suboid, null_oid());
+		oidcpy(&update_data->suboid, null_oid(the_hash_algo));
 	else if (repo_resolve_gitlink_ref(the_repository, update_data->sm_path,
 					  "HEAD", &update_data->suboid))
 		return die_message(_("Unable to find current revision in submodule path '%s'"),
@@ -2697,8 +2697,8 @@ static int update_submodule(struct update_data *update_data)
 		struct update_data next = *update_data;
 
 		next.prefix = NULL;
-		oidcpy(&next.oid, null_oid());
-		oidcpy(&next.suboid, null_oid());
+		oidcpy(&next.oid, null_oid(the_hash_algo));
+		oidcpy(&next.suboid, null_oid(the_hash_algo));
 
 		cp.dir = update_data->sm_path;
 		cp.git_cmd = 1;
@@ -3057,7 +3057,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix,
 	if (argc != 2 || !(path = argv[0]) || !(newurl = argv[1]))
 		usage_with_options(usage, options);
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -3113,7 +3113,7 @@ static int module_set_branch(int argc, const char **argv, const char *prefix,
 	if (argc != 1 || !(path = argv[0]))
 		usage_with_options(usage, options);
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e20c120913e..73d431a0dde 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -505,7 +505,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			 * has not been resolved yet.
 			 */
 			oidclr(&obj_list[nr].oid, the_repository->hash_algo);
-			add_delta_to_list(nr, null_oid(), base_offset,
+			add_delta_to_list(nr, null_oid(the_hash_algo), base_offset,
 					  delta_data, delta_size);
 			return;
 		}
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4d35bdc4b4b..3796b9844d1 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -500,7 +500,7 @@ static void parse_cmd_symref_verify(struct ref_transaction *transaction,
 	 */
 	old_target = parse_next_refname(&next);
 	if (!old_target)
-		oidcpy(&old_oid, null_oid());
+		oidcpy(&old_oid, null_oid(the_hash_algo));
 
 	if (*next != line_termination)
 		die("symref-verify %s: extra input: %s", refname, next);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 48448a83550..87ccd47794c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -578,7 +578,7 @@ static int add_worktree(const char *path, const char *refname,
 
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
-			     oid_to_hex(null_oid()),
+			     oid_to_hex(null_oid(the_hash_algo)),
 			     oid_to_hex(&commit->object.oid),
 			     "1",
 			     NULL);
diff --git a/combine-diff.c b/combine-diff.c
index 9527f3160d8..553bf59fed6 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1066,7 +1066,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
-			fill_filespec(df, null_oid(), 0, st.st_mode);
+			fill_filespec(df, null_oid(the_hash_algo), 0, st.st_mode);
 			result_size = fill_textconv(opt->repo, textconv, df, &result);
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
diff --git a/diff-lib.c b/diff-lib.c
index 353b473ed52..244468dd1a2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -172,7 +172,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 			 * these from (stage - 2).
 			 */
 			dpath = combine_diff_path_new(ce->name, ce_namelen(ce),
-						      wt_mode, null_oid(), 2);
+						      wt_mode, null_oid(the_hash_algo), 2);
 
 			while (i < entries) {
 				struct cache_entry *nce = istate->cache[i];
@@ -257,7 +257,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 				   ce_intent_to_add(ce)) {
 				newmode = ce_mode_from_stat(ce, st.st_mode);
 				diff_addremove(&revs->diffopt, '+', newmode,
-					       null_oid(), 0, ce->name, 0);
+					       null_oid(the_hash_algo), 0, ce->name, 0);
 				continue;
 			}
 
@@ -274,7 +274,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 		}
 		oldmode = ce->ce_mode;
 		old_oid = &ce->oid;
-		new_oid = changed ? null_oid() : &ce->oid;
+		new_oid = changed ? null_oid(the_hash_algo) : &ce->oid;
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    old_oid, new_oid,
 			    !is_null_oid(old_oid),
@@ -330,7 +330,7 @@ static int get_stat_data(const struct cache_entry *ce,
 						    0, dirty_submodule);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
-			oid = null_oid();
+			oid = null_oid(the_hash_algo);
 		}
 	}
 
@@ -402,7 +402,7 @@ static int show_modified(struct rev_info *revs,
 
 		p = combine_diff_path_new(new_entry->name,
 					  ce_namelen(new_entry),
-					  mode, null_oid(), 2);
+					  mode, null_oid(the_hash_algo), 2);
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
 		p->parent[0].mode = new_entry->ce_mode;
 		oidcpy(&p->parent[0].oid, &new_entry->oid);
diff --git a/diff-no-index.c b/diff-no-index.c
index 6f277892d3a..9739b2b268b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -113,7 +113,8 @@ static void populate_from_stdin(struct diff_filespec *s)
 	populate_common(s, &buf);
 }
 
-static struct diff_filespec *noindex_filespec(const char *name, int mode,
+static struct diff_filespec *noindex_filespec(const struct git_hash_algo *algop,
+					      const char *name, int mode,
 					      enum special special)
 {
 	struct diff_filespec *s;
@@ -121,7 +122,7 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode,
 	if (!name)
 		name = "/dev/null";
 	s = alloc_filespec(name);
-	fill_filespec(s, null_oid(), 0, mode);
+	fill_filespec(s, null_oid(algop), 0, mode);
 	if (special == SPECIAL_STDIN)
 		populate_from_stdin(s);
 	else if (special == SPECIAL_PIPE)
@@ -129,7 +130,7 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode,
 	return s;
 }
 
-static int queue_diff(struct diff_options *o,
+static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 		      const char *name1, const char *name2, int recursing)
 {
 	int mode1 = 0, mode2 = 0;
@@ -145,14 +146,14 @@ static int queue_diff(struct diff_options *o,
 
 		if (S_ISDIR(mode1)) {
 			/* 2 is file that is created */
-			d1 = noindex_filespec(NULL, 0, SPECIAL_NONE);
-			d2 = noindex_filespec(name2, mode2, special2);
+			d1 = noindex_filespec(algop, NULL, 0, SPECIAL_NONE);
+			d2 = noindex_filespec(algop, name2, mode2, special2);
 			name2 = NULL;
 			mode2 = 0;
 		} else {
 			/* 1 is file that is deleted */
-			d1 = noindex_filespec(name1, mode1, special1);
-			d2 = noindex_filespec(NULL, 0, SPECIAL_NONE);
+			d1 = noindex_filespec(algop, name1, mode1, special1);
+			d2 = noindex_filespec(algop, NULL, 0, SPECIAL_NONE);
 			name1 = NULL;
 			mode1 = 0;
 		}
@@ -217,7 +218,7 @@ static int queue_diff(struct diff_options *o,
 				n2 = buffer2.buf;
 			}
 
-			ret = queue_diff(o, n1, n2, 1);
+			ret = queue_diff(o, algop, n1, n2, 1);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -234,8 +235,8 @@ static int queue_diff(struct diff_options *o,
 			SWAP(special1, special2);
 		}
 
-		d1 = noindex_filespec(name1, mode1, special1);
-		d2 = noindex_filespec(name2, mode2, special2);
+		d1 = noindex_filespec(algop, name1, mode1, special1);
+		d2 = noindex_filespec(algop, name2, mode2, special2);
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
 	}
@@ -297,9 +298,8 @@ static const char * const diff_no_index_usage[] = {
 	NULL
 };
 
-int diff_no_index(struct rev_info *revs,
-		  int implicit_no_index,
-		  int argc, const char **argv)
+int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
+		  int implicit_no_index, int argc, const char **argv)
 {
 	int i, no_index;
 	int ret = 1;
@@ -354,7 +354,7 @@ int diff_no_index(struct rev_info *revs,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, paths[0], paths[1], 0))
+	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
diff --git a/diff.c b/diff.c
index 4f802b4251c..4ce5933a442 100644
--- a/diff.c
+++ b/diff.c
@@ -4346,7 +4346,7 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 				die_errno("readlink(%s)", one->path);
 			prep_temp_blob(r->index, one->path, temp, sb.buf, sb.len,
 				       (one->oid_valid ?
-					&one->oid : null_oid()),
+					&one->oid : null_oid(the_hash_algo)),
 				       (one->oid_valid ?
 					one->mode : S_IFLNK));
 			strbuf_release(&sb);
@@ -4355,7 +4355,7 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 			/* we can borrow from the file in the work tree */
 			temp->name = one->path;
 			if (!one->oid_valid)
-				oid_to_hex_r(temp->hex, null_oid());
+				oid_to_hex_r(temp->hex, null_oid(the_hash_algo));
 			else
 				oid_to_hex_r(temp->hex, &one->oid);
 			/* Even though we may sometimes borrow the
@@ -6649,8 +6649,8 @@ static void create_filepairs_for_header_only_notifications(struct diff_options *
 
 			one = alloc_filespec(e->key);
 			two = alloc_filespec(e->key);
-			fill_filespec(one, null_oid(), 0, 0);
-			fill_filespec(two, null_oid(), 0, 0);
+			fill_filespec(one, null_oid(the_hash_algo), 0, 0);
+			fill_filespec(two, null_oid(the_hash_algo), 0, 0);
 			p = diff_queue(q, one, two);
 			p->status = DIFF_STATUS_MODIFIED;
 		}
diff --git a/diff.h b/diff.h
index 0a566f5531a..0822111c62a 100644
--- a/diff.h
+++ b/diff.h
@@ -656,7 +656,7 @@ void flush_one_hunk(struct object_id *result, struct git_hash_ctx *ctx);
 
 int diff_result_code(struct rev_info *);
 
-int diff_no_index(struct rev_info *,
+int diff_no_index(struct rev_info *, const struct git_hash_algo *algop,
 		  int implicit_no_index, int, const char **);
 
 int index_differs_from(struct repository *r, const char *def,
diff --git a/dir.c b/dir.c
index cbd82be6c91..28b0e03feb4 100644
--- a/dir.c
+++ b/dir.c
@@ -4035,7 +4035,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 			 */
 			i++;
 
-		sub = submodule_from_path(&subrepo, null_oid(), ce->name);
+		sub = submodule_from_path(&subrepo, null_oid(the_hash_algo), ce->name);
 		if (!sub || !is_submodule_active(&subrepo, ce->name))
 			/* .gitmodules broken or inactive sub */
 			continue;
diff --git a/grep.c b/grep.c
index 4e155ee9e66..9284b5741f5 100644
--- a/grep.c
+++ b/grep.c
@@ -1517,7 +1517,7 @@ static int fill_textconv_grep(struct repository *r,
 		fill_filespec(df, gs->identifier, 1, 0100644);
 		break;
 	case GREP_SOURCE_FILE:
-		fill_filespec(df, null_oid(), 0, 0100644);
+		fill_filespec(df, null_oid(r->hash_algo), 0, 0100644);
 		break;
 	default:
 		BUG("attempt to textconv something without a path?");
diff --git a/hash.c b/hash.c
index 4d9f98f72c2..4a04ecb50e8 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "hash.h"
 #include "hex.h"
@@ -232,9 +230,9 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	}
 };
 
-const struct object_id *null_oid(void)
+const struct object_id *null_oid(const struct git_hash_algo *algop)
 {
-	return the_hash_algo->null_oid;
+	return algop->null_oid;
 }
 
 const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
diff --git a/hash.h b/hash.h
index 55d67ed83f3..a9ef76fc8e7 100644
--- a/hash.h
+++ b/hash.h
@@ -340,7 +340,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 
 const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop);
 
-const struct object_id *null_oid(void);
+const struct object_id *null_oid(const struct git_hash_algo *algop);
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
 {
diff --git a/log-tree.c b/log-tree.c
index 8b184d67763..5dd1b63076f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -499,7 +499,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 {
 	struct strbuf headers = STRBUF_INIT;
 	const char *name = oid_to_hex(opt->zero_commit ?
-				      null_oid() : &commit->object.oid);
+				      null_oid(the_hash_algo) : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 
diff --git a/merge-ort.c b/merge-ort.c
index 46e78c3ffa6..eb3a834652a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1817,7 +1817,7 @@ static int merge_submodule(struct merge_options *opt,
 		BUG("submodule deleted on one side; this should be handled outside of merge_submodule()");
 
 	if ((sub_not_initialized = repo_submodule_init(&subrepo,
-		opt->repo, path, null_oid()))) {
+		opt->repo, path, null_oid(the_hash_algo)))) {
 		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
 			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s (not checked out)"),
@@ -2199,7 +2199,7 @@ static int handle_content_merge(struct merge_options *opt,
 		two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
 
 		merge_status = merge_3way(opt, path,
-					  two_way ? null_oid() : &o->oid,
+					  two_way ? null_oid(the_hash_algo) : &o->oid,
 					  &a->oid, &b->oid,
 					  pathnames, extra_marker_size,
 					  &result_buf);
@@ -2231,7 +2231,7 @@ static int handle_content_merge(struct merge_options *opt,
 	} else if (S_ISGITLINK(a->mode)) {
 		int two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
 		clean = merge_submodule(opt, pathnames[0],
-					two_way ? null_oid() : &o->oid,
+					two_way ? null_oid(the_hash_algo) : &o->oid,
 					&a->oid, &b->oid, &result->oid);
 		if (clean < 0)
 			return -1;
@@ -2739,7 +2739,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		assert(!new_ci->match_mask);
 		new_ci->dirmask = 0;
 		new_ci->stages[1].mode = 0;
-		oidcpy(&new_ci->stages[1].oid, null_oid());
+		oidcpy(&new_ci->stages[1].oid, null_oid(the_hash_algo));
 
 		/*
 		 * Now that we have the file information in new_ci, make sure
@@ -2752,7 +2752,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 				continue;
 			/* zero out any entries related to files */
 			ci->stages[i].mode = 0;
-			oidcpy(&ci->stages[i].oid, null_oid());
+			oidcpy(&ci->stages[i].oid, null_oid(the_hash_algo));
 		}
 
 		/* Now we want to focus on new_ci, so reassign ci to it. */
@@ -3122,7 +3122,7 @@ static int process_renames(struct merge_options *opt,
 			if (type_changed) {
 				/* rename vs. typechange */
 				/* Mark the original as resolved by removal */
-				memcpy(&oldinfo->stages[0].oid, null_oid(),
+				memcpy(&oldinfo->stages[0].oid, null_oid(the_hash_algo),
 				       sizeof(oldinfo->stages[0].oid));
 				oldinfo->stages[0].mode = 0;
 				oldinfo->filemask &= 0x06;
@@ -3994,7 +3994,7 @@ static int process_entry(struct merge_options *opt,
 			if (ci->filemask & (1 << i))
 				continue;
 			ci->stages[i].mode = 0;
-			oidcpy(&ci->stages[i].oid, null_oid());
+			oidcpy(&ci->stages[i].oid, null_oid(the_hash_algo));
 		}
 	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
 		/*
@@ -4041,7 +4041,7 @@ static int process_entry(struct merge_options *opt,
 				continue;
 			/* zero out any entries related to directories */
 			new_ci->stages[i].mode = 0;
-			oidcpy(&new_ci->stages[i].oid, null_oid());
+			oidcpy(&new_ci->stages[i].oid, null_oid(the_hash_algo));
 		}
 
 		/*
@@ -4163,11 +4163,11 @@ static int process_entry(struct merge_options *opt,
 			new_ci->merged.result.mode = ci->stages[2].mode;
 			oidcpy(&new_ci->merged.result.oid, &ci->stages[2].oid);
 			new_ci->stages[1].mode = 0;
-			oidcpy(&new_ci->stages[1].oid, null_oid());
+			oidcpy(&new_ci->stages[1].oid, null_oid(the_hash_algo));
 			new_ci->filemask = 5;
 			if ((S_IFMT & b_mode) != (S_IFMT & o_mode)) {
 				new_ci->stages[0].mode = 0;
-				oidcpy(&new_ci->stages[0].oid, null_oid());
+				oidcpy(&new_ci->stages[0].oid, null_oid(the_hash_algo));
 				new_ci->filemask = 4;
 			}
 
@@ -4175,11 +4175,11 @@ static int process_entry(struct merge_options *opt,
 			ci->merged.result.mode = ci->stages[1].mode;
 			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
 			ci->stages[2].mode = 0;
-			oidcpy(&ci->stages[2].oid, null_oid());
+			oidcpy(&ci->stages[2].oid, null_oid(the_hash_algo));
 			ci->filemask = 3;
 			if ((S_IFMT & a_mode) != (S_IFMT & o_mode)) {
 				ci->stages[0].mode = 0;
-				oidcpy(&ci->stages[0].oid, null_oid());
+				oidcpy(&ci->stages[0].oid, null_oid(the_hash_algo));
 				ci->filemask = 2;
 			}
 
@@ -4304,7 +4304,7 @@ static int process_entry(struct merge_options *opt,
 		/* Deleted on both sides */
 		ci->merged.is_null = 1;
 		ci->merged.result.mode = 0;
-		oidcpy(&ci->merged.result.oid, null_oid());
+		oidcpy(&ci->merged.result.oid, null_oid(the_hash_algo));
 		assert(!ci->df_conflict);
 		ci->merged.clean = !ci->path_conflict;
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index 5dfaf32b2c1..d88e61b07a9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -502,7 +502,7 @@ static int get_tree_entry_if_blob(struct repository *r,
 
 	ret = get_tree_entry(r, tree, path, &dfs->oid, &dfs->mode);
 	if (S_ISDIR(dfs->mode)) {
-		oidcpy(&dfs->oid, null_oid());
+		oidcpy(&dfs->oid, null_oid(the_hash_algo));
 		dfs->mode = 0;
 	}
 	return ret;
@@ -1238,7 +1238,7 @@ static int merge_submodule(struct merge_options *opt,
 	if (is_null_oid(b))
 		return 0;
 
-	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
+	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid(the_hash_algo))) {
 		output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
 	}
@@ -1698,7 +1698,7 @@ static int handle_file_collision(struct merge_options *opt,
 
 	/* Store things in diff_filespecs for functions that need it */
 	null.path = (char *)collide_path;
-	oidcpy(&null.oid, null_oid());
+	oidcpy(&null.oid, null_oid(the_hash_algo));
 	null.mode = 0;
 
 	if (merge_mode_and_contents(opt, &null, a, b, collide_path,
@@ -2898,14 +2898,14 @@ static int process_renames(struct merge_options *opt,
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
-			if (oideq(&src_other.oid, null_oid()) &&
+			if (oideq(&src_other.oid, null_oid(the_hash_algo)) &&
 			    ren1->dir_rename_original_type == 'A') {
 				setup_rename_conflict_info(RENAME_VIA_DIR,
 							   opt, ren1, NULL);
 			} else if (renamed_to_self) {
 				setup_rename_conflict_info(RENAME_NORMAL,
 							   opt, ren1, NULL);
-			} else if (oideq(&src_other.oid, null_oid())) {
+			} else if (oideq(&src_other.oid, null_oid(the_hash_algo))) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   opt, ren1, NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
@@ -2924,7 +2924,7 @@ static int process_renames(struct merge_options *opt,
 						      1, /* update_cache */
 						      0  /* update_wd    */))
 					clean_merge = -1;
-			} else if (!oideq(&dst_other.oid, null_oid())) {
+			} else if (!oideq(&dst_other.oid, null_oid(the_hash_algo))) {
 				/*
 				 * Probably not a clean merge, but it's
 				 * premature to set clean_merge to 0 here,
diff --git a/notes-merge.c b/notes-merge.c
index 67a472020de..5008faef450 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -617,7 +617,7 @@ int notes_merge(struct notes_merge_options *o,
 	if (repo_get_merge_bases(the_repository, local, remote, &bases) < 0)
 		exit(128);
 	if (!bases) {
-		base_oid = null_oid();
+		base_oid = null_oid(the_hash_algo);
 		base_tree_oid = the_hash_algo->empty_tree;
 		if (o->verbosity >= 4)
 			printf("No merge base found; doing history-less merge\n");
diff --git a/notes.c b/notes.c
index f5344230505..ce5a1006a83 100644
--- a/notes.c
+++ b/notes.c
@@ -1353,7 +1353,7 @@ int copy_note(struct notes_tree *t,
 	if (note)
 		return add_note(t, to_obj, note, combine_notes);
 	else if (existing_note)
-		return add_note(t, to_obj, null_oid(), combine_notes);
+		return add_note(t, to_obj, null_oid(the_hash_algo), combine_notes);
 
 	return 0;
 }
diff --git a/object-file.c b/object-file.c
index de603e2ca8c..772c311f188 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2405,7 +2405,7 @@ static int index_mem(struct index_state *istate,
 
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
-		if (fsck_buffer(null_oid(), type, buf, size, &opts))
+		if (fsck_buffer(null_oid(the_hash_algo), type, buf, size, &opts))
 			die(_("refusing to create malformed object"));
 		fsck_finish(&opts);
 	}
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 166d35e0ebd..50c8afe4121 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -145,7 +145,7 @@ int parse_opt_object_id(const struct option *opt, const char *arg, int unset)
 	struct object_id *target = opt->value;
 
 	if (unset) {
-		oidcpy(target, null_oid());
+		oidcpy(target, null_oid(the_hash_algo));
 		return 0;
 	}
 	if (!arg)
diff --git a/range-diff.c b/range-diff.c
index 9501c358a84..8a2dcbee322 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -467,7 +467,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
-	fill_filespec(spec, null_oid(), 0, 0100644);
+	fill_filespec(spec, null_oid(the_hash_algo), 0, 0100644);
 	spec->data = (char *)p;
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
diff --git a/read-cache.c b/read-cache.c
index a012cb22368..2f9e21c897d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1735,7 +1735,7 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	end = (unsigned char *)hdr + size;
 	start = end - the_hash_algo->rawsz;
 	oidread(&oid, start, the_repository->hash_algo);
-	if (oideq(&oid, null_oid()))
+	if (oideq(&oid, null_oid(the_hash_algo)))
 		return 0;
 
 	the_hash_algo->init_fn(&c);
diff --git a/refs.c b/refs.c
index 118465271d7..215294115b4 100644
--- a/refs.c
+++ b/refs.c
@@ -1377,7 +1377,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), new_target, NULL, flags,
+				      null_oid(the_hash_algo), new_target, NULL, flags,
 				      msg, err);
 }
 
@@ -1396,7 +1396,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (old_target && !(flags & REF_NO_DEREF))
 		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
-				      null_oid(), old_oid,
+				      null_oid(the_hash_algo), old_oid,
 				      NULL, old_target, flags,
 				      msg, err);
 }
@@ -2160,7 +2160,7 @@ struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
 	subrepo = xmalloc(sizeof(*subrepo));
 
 	if (repo_submodule_init(subrepo, repo, submodule,
-				null_oid())) {
+				null_oid(the_hash_algo))) {
 		free(subrepo);
 		goto done;
 	}
@@ -2345,14 +2345,14 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 		strbuf_reset(&buf);
 
 		if (!(update->flags & REF_HAVE_OLD))
-			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
+			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
 		else if (update->old_target)
 			strbuf_addf(&buf, "ref:%s ", update->old_target);
 		else
 			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
 
 		if (!(update->flags & REF_HAVE_NEW))
-			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
+			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
 		else if (update->new_target)
 			strbuf_addf(&buf, "ref:%s ", update->new_target);
 		else
@@ -2794,7 +2794,7 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 		if (ret < 0)
 			goto done;
 
-		ret = ref_transaction_update(data->transaction, refname, NULL, null_oid(),
+		ret = ref_transaction_update(data->transaction, refname, NULL, null_oid(the_hash_algo),
 					     symref_target.buf, NULL,
 					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
 		if (ret < 0)
diff --git a/refs/debug.c b/refs/debug.c
index fbc4df08b43..7c61b775e4e 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -217,7 +217,7 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
 
-	oidcpy(oid, null_oid());
+	oidcpy(oid, null_oid(ref_store->repo->hash_algo));
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
 					    type, failure_errno);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6c6e67dc1c4..ba31cfdb93f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1270,7 +1270,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(), &r->oid, NULL, NULL, NULL, NULL);
+			null_oid(the_hash_algo), &r->oid, NULL, NULL, NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
diff --git a/reset.c b/reset.c
index b22b1be792d..bb590271811 100644
--- a/reset.c
+++ b/reset.c
@@ -80,7 +80,7 @@ static int update_refs(const struct reset_head_opts *opts,
 	}
 	if (!ret && run_hook)
 		run_hooks_l(the_repository, "post-checkout",
-			    oid_to_hex(head ? head : null_oid()),
+			    oid_to_hex(head ? head : null_oid(the_hash_algo)),
 			    oid_to_hex(oid), "1", NULL);
 	strbuf_release(&msg);
 	return ret;
diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..c112d2e1c43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -265,8 +265,8 @@ static struct update_ref_record *init_update_ref_record(const char *ref)
 
 	CALLOC_ARRAY(rec, 1);
 
-	oidcpy(&rec->before, null_oid());
-	oidcpy(&rec->after, null_oid());
+	oidcpy(&rec->before, null_oid(the_hash_algo));
+	oidcpy(&rec->after, null_oid(the_hash_algo));
 
 	/* This may fail, but that's fine, we will keep the null OID. */
 	refs_read_ref(get_main_ref_store(the_repository), ref, &rec->before);
@@ -667,7 +667,7 @@ static int fast_forward_to(struct repository *r,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn && !is_rebase_i(opts) ?
-				   null_oid() : from, NULL, NULL,
+				   null_oid(the_hash_algo) : from, NULL, NULL,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1301,7 +1301,7 @@ int update_head_with_reflog(const struct commit *old_head,
 						  0, err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", new_head,
-				   old_head ? &old_head->object.oid : null_oid(),
+				   old_head ? &old_head->object.oid : null_oid(the_hash_algo),
 				   NULL, NULL, 0, sb.buf, err) ||
 	    ref_transaction_commit(transaction, err)) {
 		ret = -1;
@@ -4683,7 +4683,7 @@ static void create_autostash_internal(struct repository *r,
 			write_file(path, "%s", oid_to_hex(&oid));
 		} else {
 			refs_update_ref(get_main_ref_store(r), "", refname,
-					&oid, null_oid(), 0, UPDATE_REFS_DIE_ON_ERR);
+					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
 		printf(_("Created autostash: %s\n"), buf.buf);
diff --git a/submodule-config.c b/submodule-config.c
index a25059ed7f8..d82b404b73e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -831,7 +831,7 @@ static int gitmodules_cb(const char *var, const char *value,
 
 	parameter.cache = repo->submodule_cache;
 	parameter.treeish_name = NULL;
-	parameter.gitmodules_oid = null_oid();
+	parameter.gitmodules_oid = null_oid(the_hash_algo);
 	parameter.overwrite = 1;
 
 	return parse_config(var, value, ctx, &parameter);
diff --git a/submodule.c b/submodule.c
index 0530e8cf24e..0821507ecaa 100644
--- a/submodule.c
+++ b/submodule.c
@@ -124,7 +124,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(the_repository, null_oid(), oldpath);
+	submodule = submodule_from_path(the_repository, null_oid(the_hash_algo), oldpath);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
@@ -153,7 +153,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(the_repository, null_oid(), path);
+	submodule = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
@@ -204,7 +204,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
 	const struct submodule *submodule = submodule_from_path(the_repository,
-								null_oid(),
+								null_oid(the_hash_algo),
 								path);
 	if (submodule) {
 		const char *ignore;
@@ -312,7 +312,7 @@ int is_tree_submodule_active(struct repository *repo,
 
 int is_submodule_active(struct repository *repo, const char *path)
 {
-	return is_tree_submodule_active(repo, null_oid(), path);
+	return is_tree_submodule_active(repo, null_oid(the_hash_algo), path);
 }
 
 int is_submodule_populated_gently(const char *path, int *return_error_code)
@@ -778,7 +778,7 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	if (!should_update_submodules())
 		return NULL;
 
-	return submodule_from_path(the_repository, null_oid(), ce->name);
+	return submodule_from_path(the_repository, null_oid(the_hash_algo), ce->name);
 }
 
 
@@ -1062,7 +1062,7 @@ static int submodule_needs_pushing(struct repository *r,
 				   const char *path,
 				   struct oid_array *commits)
 {
-	if (!submodule_has_commits(r, path, null_oid(), commits))
+	if (!submodule_has_commits(r, path, null_oid(the_hash_algo), commits))
 		/*
 		 * NOTE: We do consider it safe to return "no" here. The
 		 * correct answer would be "We do not know" instead of
@@ -1126,7 +1126,7 @@ int find_unpushed_submodules(struct repository *r,
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(r, null_oid(), name->string);
+		submodule = submodule_from_name(r, null_oid(the_hash_algo), name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1351,7 +1351,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(r, null_oid(), name->string);
+		submodule = submodule_from_name(r, null_oid(the_hash_algo), name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1360,7 +1360,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, null_oid(), &cs_data->new_commits)) {
+		if (submodule_has_commits(r, path, null_oid(the_hash_algo), &cs_data->new_commits)) {
 			changed_submodule_data_clear(cs_data);
 			*name->string = '\0';
 		}
@@ -1602,7 +1602,7 @@ get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		task = fetch_task_create(spf, ce->name, null_oid());
+		task = fetch_task_create(spf, ce->name, null_oid(the_hash_algo));
 		if (!task)
 			continue;
 
@@ -2166,7 +2166,7 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	if (old_head && !is_submodule_populated_gently(path, error_code_ptr))
 		return 0;
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 
 	if (!sub)
 		BUG("could not get submodule information for '%s'", path);
@@ -2376,7 +2376,7 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
@@ -2462,7 +2462,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		* superproject did not rewrite the git file links yet,
 		* fix it now.
 		*/
-		sub = submodule_from_path(the_repository, null_oid(), path);
+		sub = submodule_from_path(the_repository, null_oid(the_hash_algo), path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		submodule_name_to_gitdir(&sub_gitdir, the_repository, sub->name);
@@ -2594,7 +2594,7 @@ int submodule_to_gitdir(struct repository *repo,
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		sub = submodule_from_path(repo, null_oid(), submodule);
+		sub = submodule_from_path(repo, null_oid(the_hash_algo), submodule);
 		if (!sub) {
 			ret = -1;
 			goto cleanup;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index e00fce592b1..2ff67c067ac 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -179,7 +179,7 @@ static int cmd_for_each_ref__exclude(struct ref_store *refs, const char **argv)
 
 static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 {
-	struct object_id oid = *null_oid();
+	struct object_id oid = *null_oid(the_hash_algo);
 	const char *refname = notnull(*argv++, "refname");
 	int resolve_flags = arg_flags(*argv++, "resolve-flags", empty_flags);
 	int flags;
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index 6dce9571531..2710341cd5d 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -21,7 +21,7 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv)
 
 	setup_git_directory();
 
-	if (repo_submodule_init(&subrepo, the_repository, argv[1], null_oid())) {
+	if (repo_submodule_init(&subrepo, the_repository, argv[1], null_oid(the_hash_algo))) {
 		die_usage(argv, "Submodule not found.");
 	}
 
diff --git a/tree-diff.c b/tree-diff.c
index 60c558c2b56..e00fc2f450d 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -181,7 +181,7 @@ static void emit_path(struct combine_diff_path ***tail,
 
 		strbuf_add(base, path, pathlen);
 		p = combine_diff_path_new(base->buf, base->len, mode,
-					  oid ? oid : null_oid(),
+					  oid ? oid : null_oid(the_hash_algo),
 					  nparent);
 		strbuf_setlen(base, old_baselen);
 
@@ -206,7 +206,7 @@ static void emit_path(struct combine_diff_path ***tail,
 				mode_i = tp[i].entry.mode;
 			}
 			else {
-				oid_i = null_oid();
+				oid_i = null_oid(the_hash_algo);
 				mode_i = 0;
 			}
 
diff --git a/upload-pack.c b/upload-pack.c
index 7412d3c6ce8..0fa8fbdd6de 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1446,7 +1446,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
 			const char *refname = "capabilities^{}";
-			write_v0_ref(&data, refname, refname, null_oid());
+			write_v0_ref(&data, refname, refname, null_oid(the_hash_algo));
 		}
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
diff --git a/wt-status.c b/wt-status.c
index 1da5732f57b..454601afa15 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1824,10 +1824,10 @@ void wt_status_get_state(struct repository *r,
 	if (!sequencer_get_last_command(r, &action)) {
 		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
 			state->cherry_pick_in_progress = 1;
-			oidcpy(&state->cherry_pick_head_oid, null_oid());
+			oidcpy(&state->cherry_pick_head_oid, null_oid(the_hash_algo));
 		} else if (action == REPLAY_REVERT && !state->revert_in_progress) {
 			state->revert_in_progress = 1;
-			oidcpy(&state->revert_head_oid, null_oid());
+			oidcpy(&state->revert_head_oid, null_oid(the_hash_algo));
 		}
 	}
 	if (get_detached_from)
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 3bd61f26e90..77712811ff1 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -181,7 +181,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 	unsigned long size;
 	enum object_type type;
 
-	if (oideq(oid, null_oid())) {
+	if (oideq(oid, null_oid(the_hash_algo))) {
 		ptr->ptr = xstrdup("");
 		ptr->size = 0;
 		return;

-- 
2.49.0.rc1.455.g4cd33545ba.dirty

