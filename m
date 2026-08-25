Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493F379EF9
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648192; cv=none; b=AaiY1cq5PN3ntQwkTnluwmyLn3QLRcFGSDarVrQuSrG0VKRTzo3Bjw6ArdtBWxUOZzPQsA1XsU98npZ+5cJ/3kklC+W+Jvi/XHxUcRc4ICJQqCVq5649ZgjJhADIE0aVCT6L7UVlxiT1nfpTjEEQdqNdgVUucclyCjpTQYhl3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648192; c=relaxed/simple;
	bh=TMV1xrfysNI10skD2vv7L8cVJwKhRoxrC8zRZ6KkzbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4x7SrK9zo3djVEh/l1BQnqftoGxncRxEVyA8RAUhDnsIB9v6yxyF5Gnsin6TplAdGiFmB1o8zwMGLMOowPkeWfob5sfqh0hDGV4NJMGrukWudw+nJ8AVHCLqx9aSOK/xWJFACRD9Ddol5Ld17BgRM+6CDwXoIszXXX7NVvrT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io; spf=pass smtp.mailfrom=island.io; dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b=YIPaQV9L; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=island.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b="YIPaQV9L"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c4436d02cso23746441cf.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=island.io; s=google; t=1787648189; x=1788252989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H8XMwSXLvrqUiDpzXiN+csjqSrt61bs31HsoqlaY52Q=;
        b=YIPaQV9LjirZVlgL38Gb8r0F2wRDgTal+dcicb5Ajmuqx8lNUegJhmy/1ozjr2jp73
         wMIM1AQXKZIjUOIee5L7vG1Ce5kKqm4ZdC6FaXrcemeou9SqCFN4tVlSx6DNvdmSeX8P
         cZOUtOHpF3TE6RXLWEyIvgV1WJDSFXGG9jRV8Wy8UOfDbaJb6EXYW0yFbDGWUAglZ8vy
         aWPJRy4iCdRFR27wO4gC/9Jqy4uYbPkNhIr8Cm6jBTvfOdyuqhM+GHOATT0bb03rYNzh
         eRsju+OHGPcWA5J3K/UwYo2OqTUX+4A39dbKRjNx7L41GHKG179+9iv8xhiW+tYAEoed
         HXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648189; x=1788252989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H8XMwSXLvrqUiDpzXiN+csjqSrt61bs31HsoqlaY52Q=;
        b=SXVSI6b6PpWc9RVEWGW68kSppjapOwPu7c9k6cJ/KTn9y6H5icrw9/JIp/cKmDE/p5
         /eo9hCwVMwSRkC2LNnulqDUDyB/k3Av8QLQN8X3ViYnVZ9Z/lkGv8QFdUcnxz88ALwtt
         qq3IWfCZgwES3msw0MyCxbKySH7eMB1vU/IpBhPnNJl3FngJhNUPXytE0aEN2FFS0Iwq
         tTogxNJnvcd1EJH550rpCPo9evo9ElPYWU4ouvVl+FkIfxro47B1/YZ3kj+Wn8G7UZSi
         7aVtOiiqukQrwQECjdILH4p5RFUPFE1fSk28w+tF4v++J6u+098gxVvy6TfxPBFJJspT
         PksA==
X-Gm-Message-State: AFuF++miHtUvsX/JNCi5G7X81dKdqoexrckJi9FcHsK3l12/tsyyf/Ab
	Gjz563YLCHm6C2X0WAFcP/Hv514qIE2byk03AveUPFyXavAr2JwnHRu47IXBBuWNGD2fgD9npox
	wD/+ySKWyzA==
X-Gm-Gg: AR+sD12gerHFA+OUA4zT40rkoIQeXZE581iIc6tqXyUMcMblYMoHdsCAEKB4qQES+vJ
	5Y8gYt+MCLshQcDETV/jizJoxsd0NqUzYEbUgx/gM5I/S9RbpaN8/HooXMSVlXaBBiVoXde7CZ5
	qpqsDc1qWM2SUyfb/WkbJ94uCn6t8uNMt5BWaOb6nTR1ch0bFZKarUsnf5RXtyUhazmBLRCA+l2
	csaP0pjqTqEhd4OVGd8zsM/qvISozWZ3a/T9Dvc0euauHfdneaO+zz5lTy7nHbOYhIBtO23CaEi
	k5NnZZxnDvuEcgUXIh2Mnm6H0khNdtMmvpL1e0kjUdGTSVtwFaFjQZZAh6PnoJTejVj0Fj5M6Vp
	rY4ZyJgPXKmRlc4wxWGof7mfKkRSOpArcljz7abEJBHhnSEhEbcE5Fn8l4u+gxGjoMPL37mJiK4
	MQELX62kqOYl0XutMX9QyPve8y+xWiZFOeEoU9XFIAHogFIZj+RVK01x83O0DTfHwUPq+Rv+zJH
	YGT6iBmmLiXx39Xs4OwMrExCMTCyTJG/ORd2M/pMGl2v0xitE7khyKgkIWfwnDe2viP
X-Received: by 2002:a05:622a:420a:b0:52d:f4fb:8baa with SMTP id d75a77b69052e-52e2f1589camr57774391cf.35.1787648188875;
        Tue, 25 Aug 2026 01:56:28 -0700 (PDT)
Received: from brick ([146.185.57.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cbe08b6c9sm6287936d6.35.2026.08.25.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:56:28 -0700 (PDT)
From: Nikita Leshenko <nikita@island.io>
To: git@vger.kernel.org
Cc: Nikita Leshenko <nikita@island.io>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Michael Montalbo <mmontalbo@gmail.com>
Subject: [PATCH] am: record blobs of cleanly applied patches when using --3way
Date: Tue, 25 Aug 2026 11:55:16 +0300
Message-ID: <20260825085516.66088-1-nikita@island.io>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make "git am --3way" succeed in an edge case where it currently fails.

First, some background about the case:

Say we have a patch with two commits, A and B, and both of them change the
same file.  We apply them to a different repo on a different version of the
file using --3way.

If both patches apply cleanly, we are done.

If A does not apply cleanly, git am falls back to 3-way merge.  To merge,
Git uses the preimage hash from the patch:

    A: index 83b2a16..cccad2b 100644
    B: index cccad2b..0ce2f98 100644

git am looks up 83b2a16, applies A to it, and merges that result with the
current version of the file.  As an important side effect, applying A to
83b2a16 also stores A's postimage, cccad2b, in the repository.  This means
that if B also doesn't apply cleanly, cccad2b (which is now B's preimage)
exists in the repository so we can merge against it as well.

Let's assume instead that A applies cleanly and B fails.  Because git am
didn't have to 3-way merge A, nothing created cccad2b this time.  What we
have after applying A is our file plus A's change, which is a different
hash.  When B doesn't apply cleanly, git am fails because it doesn't know
what cccad2b is:

    Applying: A
    Applying: B
    error: sha1 information is lacking or useless (file).
    error: could not build fake ancestor

However, technically we have the information to build the fake ancestor!  We
have 83b2a16 in the repository, and we have A, so if we apply A we'll get
that hash.

So do exactly that: if the user requested --3way, apply the patch on the
fake ancestor even after a patch applies cleanly, in order to produce
intermediate hashes for later commits.  If the preimage is missing, or the
patch does not apply, nothing is recorded and git am behaves as it does
today.

This does not change the behavior of how patches apply, but when the user
requested --3way it does cost one extra "git apply --build-fake-ancestor"
process and one extra apply per clean patch.

Signed-off-by: Nikita Leshenko <nikita@island.io>
---
 builtin/am.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++-------
 t/t4150-am.sh | 28 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..37569fed65 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1488,7 +1488,8 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
  * Applies current patch with git-apply. Returns 0 on success, -1 otherwise. If
  * `index_file` is not NULL, the patch will be applied to that index.
  */
-static int run_apply(const struct am_state *state, const char *index_file)
+static int run_apply(const struct am_state *state, const char *index_file,
+		     int quiet)
 {
 	struct strvec apply_paths = STRVEC_INIT;
 	struct strvec apply_opts = STRVEC_INIT;
@@ -1528,7 +1529,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	 * If we are allowed to fall back on 3-way merge, don't give false
 	 * errors during the initial attempt.
 	 */
-	if (state->threeway && !index_file)
+	if (quiet || (state->threeway && !index_file))
 		apply_state.apply_verbosity = verbosity_silent;
 
 	if (check_apply_state(&apply_state, force_apply))
@@ -1559,11 +1560,13 @@ static int run_apply(const struct am_state *state, const char *index_file)
 /**
  * Builds an index that contains just the blobs needed for a 3way merge.
  */
-static int build_fake_ancestor(const struct am_state *state, const char *index_file)
+static int build_fake_ancestor(const struct am_state *state,
+			       const char *index_file, int quiet)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
 	cp.git_cmd = 1;
+	cp.no_stderr = quiet;
 	strvec_push(&cp.args, "apply");
 	strvec_pushv(&cp.args, state->git_apply_opts.v);
 	strvec_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
@@ -1589,7 +1592,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	if (repo_get_oid(the_repository, "HEAD", &our_tree) < 0)
 		oidcpy(&our_tree, the_hash_algo->empty_tree);
 
-	if (build_fake_ancestor(state, index_path))
+	if (build_fake_ancestor(state, index_path, 0))
 		return error("could not build fake ancestor");
 
 	discard_index(the_repository->index);
@@ -1617,7 +1620,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		release_revisions(&rev_info);
 	}
 
-	if (run_apply(state, index_path))
+	if (run_apply(state, index_path, 0))
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
@@ -1658,6 +1661,39 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	return 0;
 }
 
+/**
+ * Applies the patch on the fake ancestor and stores the postimage in the
+ * repository for future patches to reference.  Best effort, fails quietly.
+ *
+ * Motivation: Say a patch file has two commits, A and B, that both change the
+ * same file.  We apply it with --3way.  If A applies cleanly, nothing stores
+ * A's postimage.  If B then does not apply cleanly, git am cannot 3-way merge
+ * it, because B's preimage is A's postimage.
+ */
+static void try_record_patch_postimage(const struct am_state *state)
+{
+	struct strbuf index_path = STRBUF_INIT;
+
+	strbuf_addstr(&index_path, am_path(state, "patch-postimage-index"));
+
+	if (build_fake_ancestor(state, index_path.buf, 1))
+		goto done;
+
+	/*
+         * Discard index because run_apply() reads `index_path` only if no index
+         * is in core.
+         */
+	discard_index(the_repository->index);
+	run_apply(state, index_path.buf, 1);
+
+	discard_index(the_repository->index);
+	repo_read_index(the_repository);
+
+done:
+	unlink(index_path.buf);
+	strbuf_release(&index_path);
+}
+
 /**
  * Commits the current index with state->msg as the commit message and
  * state->author_name, state->author_email and state->author_date as the author
@@ -1886,9 +1922,17 @@ static void am_run(struct am_state *state, int resume)
 
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-		apply_status = run_apply(state, NULL);
+		apply_status = run_apply(state, NULL, 0);
 
-		if (apply_status && state->threeway) {
+		if (!apply_status && state->threeway && state->cur < state->last) {
+			/*
+			 * The patch applied cleanly, so no 3-way was performed.
+			 * A patch later in the series may reference postimage
+			 * hashes this patch would have produced, so record them
+			 * while we still can.
+			 */
+			try_record_patch_postimage(state);
+		} else if (apply_status && state->threeway) {
 			struct strbuf sb = STRBUF_INIT;
 
 			strbuf_addstr(&sb, am_path(state, "patch-merge-index"));
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index ee96223668..e5ed666c2f 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -641,6 +641,34 @@ test_expect_success 'am with config am.threeWay overridden by --no-3way' '
 	test_path_is_dir .git/rebase-apply
 '
 
+test_expect_success 'am -3 records blobs a later patch needs' '
+	test_when_finished "rm -rf 3way-source 3way-target" &&
+
+	# Two patches touching the same file, the first of which applies
+	# cleanly to the target while the second one does not.
+	git init 3way-source &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >3way-source/file &&
+	git -C 3way-source add file &&
+	git -C 3way-source commit -m base &&
+	test_write_lines 11 2 3 4 5 6 7 8 9 >3way-source/file &&
+	git -C 3way-source commit -am first &&
+	test_write_lines 11 2 3 4 5 66 7 8 9 >3way-source/file &&
+	git -C 3way-source commit -am second &&
+	git -C 3way-source format-patch --stdout -2 >3way-two.patches &&
+
+	git init 3way-target &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >3way-target/file &&
+	git -C 3way-target add file &&
+	git -C 3way-target commit -m base &&
+	test_write_lines 1 2 3 4 5 6 7 8 9XXX >3way-target/file &&
+	git -C 3way-target commit -am "change outside the first patch" &&
+
+	git -C 3way-target am -3 ../3way-two.patches &&
+	test_path_is_missing 3way-target/.git/rebase-apply &&
+	test_write_lines 11 2 3 4 5 66 7 8 9XXX >expect &&
+	test_cmp expect 3way-target/file
+'
+
 test_expect_success 'am can rename a file' '
 	test_grep "^rename from" rename.patch &&
 	rm -fr .git/rebase-apply &&
-- 
2.55.0

