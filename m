Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCE4477FD
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385499; cv=none; b=Z6eGaKgGiCASXS3lsHYa6Pi5MW7FpbrUe6cdBRub3LThhegyYUdGRnAeBZu50r0pASb4SAuAWV6CiGHReY3P2gSHsVPjY70G6soWm3+L3xARG2hzf1J2qQVAM211xoHAl0BBWjlNrUqkTwNEPxw9Ytne9siYZpgzkaiY0K60GqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385499; c=relaxed/simple;
	bh=OGrv+8Ic8AQ3sL0FmySEPvYJwjETY2cvzcPnTxZMn2c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bqx3qHXO3O8J0xg+4ZHbDWvyyGwME01Kk1LnIt3q91hJBBk7SqS+UeaB6dY5Egy0x5YJiW1ZA6TJ53Sf+ijNLdGLqAd5UKRZ/aY1prJ2bKCORE87X7XLLGPyE9usBd5+iF6DlSzjMiw1xDREcFy6GIwviB3aZ8ldRpM/QHUV1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRhklQHt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRhklQHt"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed6d6eso11900955ad.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385497; x=1789990297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8l9CGjNaP1uUchG/zgQfgsJtCPkExDJYB2RN3owJXJg=;
        b=fRhklQHtdKoQTd9qn81rbaZQJ80V/NJqDOGw6iC21cCUW31Ua1xAjBNK2i+zNC86wG
         hLNplFHQZ90T9DkCqDYOnc4pj37kgQ1UUz4YsRtCIgugELAUd1A+onhJgGeyQu6lILPd
         k34xC/E57Vyb3P93ul7AZ73sCnfoBq3GXIdPTFug3UgKNQ0+Q5Jwznu6Bz7mYxEpKovz
         nksPipOl1YOKuSdcLq2YGmw5GP6an2hDvz08TGT66lZQbdbqXiPJuCYSlYnWkmuKR5ol
         9fat/fddj0MDr8uXa/8a21uB0OUwQWrHnyKyWaWJbdPEJFkDt8dssqWJ3oEak26hTp2l
         /uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385497; x=1789990297;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8l9CGjNaP1uUchG/zgQfgsJtCPkExDJYB2RN3owJXJg=;
        b=ZLex3HnKn0rmyRQRkcjVOC9QEvOZF2woQltvgDYNbhr7jX9WUarpUAXd6g+LdKFNRS
         EkXTpUysC4sLIDAzmU4rSExncA6huvh+mcpqjxkpBzazd/AC78qmuuMNGK07OEnO4bvP
         /AWGt1yTHqDxewW7y8qdbi7VXpcyh6Xp17zRIXQzrXZIhh6u06pCwB93wvo6laRNi6Tw
         iy8ZhFo7tajMEJkc4naRwb/3ag/2PaQfTpRvzkz8Jq3r2uRWPP3uNDs4qdyxYUXn+6VM
         H9Imsi6yerMw8AOdyc1f3pfHj/uYR2kD1j2nN9NZEvwbzzhb3DgmnEDeba6s7p6txIG8
         mRwA==
X-Gm-Message-State: AFuF++lSL3tjGLJ376hF6ZkvC94t24pDnhyTqzcARckIRzYIjdx/m9mC
	oW1SQwUhdRPyEn5cmMGqaK8q/fpQWQB3iKnt22aOokHcLA/xUlGtZvjD1NdEEA==
X-Gm-Gg: AYBFou1QAwr8+Qy30vyE/Z5E1m9ixMQc7Bu8fWFBCmYaXiVAkGmRWJd5RQyV9dEB8Sq
	H1eywuD6xmAqXuVi6fzp/xJph4vnPapesmgzYkWzhh8QfKkPeHoFAKMc8ci8s2nT/GOGssj3QFN
	tJUDaGKj6GGQgi98w6Florv/cRk1x3XqGdLx1AhFzllWx7wSpSkma68/tpKP5a+OlpS/YYN2mzW
	0xpK4vSJyQpbVI6L1UpBtTCuC3Clk5qQ0CcVDiNrVqm9n8frDdlhPexUeedq5nz2VsI+8eoB0Di
	31z0coH13DRSJhf8KSuDajpiQi2GYdz4sWfCK3nhXJAskEjg8jjbvCHKKSxar3En2sQO4zrsVq3
	a8Id7ve+A/6453xuAXQA81ufoKy8BhgWbVGmh0ABZPvyqn5nB7SZQNyqlKwgoLm20at8T+AEHrl
	xPL3mXG9aMggDB3MYcgfrznDOyNIig0AYPWjVAmAVAtceTCCeGTmojwwntqgzzQ9l4c78iUBLJ1
	PPC
X-Received: by 2002:a17:903:2312:b0:2d8:d4d3:3fbc with SMTP id d9443c01a7336-2dd6c741b20mr45798785ad.16.1789385496907;
        Mon, 14 Sep 2026 04:31:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce9c8besm45856955ad.18.2026.09.14.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:31:35 -0700 (PDT)
Message-Id: <a18e354e73ade433e3b9854f1662338488a5e672.1789385483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 11:31:23 +0000
Subject: [PATCH 6/6] repack: tell pack-objects which packs are kept
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

repack works out which packs are redundant by looking for ".keep"
files when it starts, then passes "--honor-pack-keep" to the
pack-objects it spawns, which looks for them all over again. Two scans
of the same directory, seconds apart, with nothing holding them
together.

A ".keep" that turns up in between loses objects. The parent did not
see it, so the pack is on its list to delete. The child does see it,
so it leaves that pack's objects out of the replacement. The parent
deletes the pack regardless: repack_remove_redundant_pack() passes
force_delete, which skips the ".keep" check in unlink_pack_path(). The
objects are gone and repack exits successfully.

The gap is easy to land in. index-pack writes its ".keep" before it
renames the packfile into place, so a "git fetch" or a push being
migrated out of its quarantine will do it. Checking for the ".keep"
once more right before deleting would not help: a push holds it for a
fraction of a second, and it may well be gone again by the time
pack-objects has finished.

Hand pack-objects the kept packs we collected at startup and drop
"--honor-pack-keep". Both processes then work from one snapshot, and a
".keep" appearing or disappearing while we run cannot make them
disagree. An earlier commit made sure a pack kept this way is no more
of a boundary to the traversal than a ".keep" file was.

The list goes into a file next to the refs snapshot we already write
for "git multi-pack-index write", and is passed with
"--keep-pack-from-file" to every pack-objects we spawn when
"--pack-kept-objects" is not in effect, which is when
"--honor-pack-keep" used to be. The cruft pack-objects already has the
kept packs on its stdin; the file is redundant there, but it sees the
same list as everybody else. With nothing to keep, no file is written
and nothing is passed, which is what "--honor-pack-keep" came down to
when it found no ".keep".

The names go one per line, so a name with a newline in it cannot be
passed. "--stdin-packs" and "--cruft" have the same limit and die on a
name they cannot find, but "--keep-pack" ignores such a name, and the
two halves of a garbled one could go on to exclude some other pack;
refuse it up front instead.

The user's own "--keep-pack" arguments keep being forwarded, since
they apply either way. write_filtered_pack() had a loop passing the
kept packs too, but without the ".pack" suffix pack-objects compares
against; it goes. Kept packs borrowed from an alternate object
directory were covered by "--honor-pack-keep" and are not by the
snapshot, which only ever held local packs; repack never deletes
those, so their objects now get packed rather than skipped, which
costs room but cannot lose anything.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/repack.c            | 15 ++++++++
 repack-filtered.c           |  3 --
 repack.c                    | 34 ++++++++++++++++--
 repack.h                    | 17 +++++++--
 t/t7700-repack.sh           | 43 ++++++++++++++++++++++
 t/t7703-repack-geometric.sh | 72 +++++++++++++++++++++++++++++++++++++
 6 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..78bc98c4f1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -167,6 +167,7 @@ int cmd_repack(int argc,
 	struct oidset drop_oids = OIDSET_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
+	struct tempfile *kept_packs_snapshot = NULL;
 	int i, ret;
 	int show_progress;
 
@@ -456,6 +457,19 @@ int cmd_repack(int argc,
 
 	existing.repo = repo;
 	existing_packs_collect(&existing, &keep_pack_list);
+	if (existing.kept_packs.nr) {
+		struct strbuf path = STRBUF_INIT;
+
+		strbuf_addf(&path, "%s/%s_XXXXXX",
+			    repo_get_object_directory(repo), "kept-packs");
+
+		kept_packs_snapshot = xmks_tempfile(path.buf);
+		existing_packs_snapshot_kept(&existing, kept_packs_snapshot);
+		po_args.kept_packs_snapshot =
+			get_tempfile_path(kept_packs_snapshot);
+
+		strbuf_release(&path);
+	}
 
 	if (geometry.split_factor) {
 		if (pack_everything)
@@ -644,6 +658,7 @@ int cmd_repack(int argc,
 		cruft_po_args.quiet = po_args.quiet;
 		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
 		cruft_po_args.pack_kept_objects = 0;
+		cruft_po_args.kept_packs_snapshot = po_args.kept_packs_snapshot;
 
 		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
diff --git a/repack-filtered.c b/repack-filtered.c
index 869b9fc6e3..db8de9f633 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -25,9 +25,6 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 
 	strvec_push(&cmd.args, "--stdin-packs");
 
-	for_each_string_list_item(item, &existing->kept_packs)
-		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
-
 	cmd.in = -1;
 
 	ret = start_command(&cmd);
diff --git a/repack.c b/repack.c
index d2aa58e134..a794486035 100644
--- a/repack.c
+++ b/repack.c
@@ -38,8 +38,9 @@ void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--quiet");
 	if (args->delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
-	if (!args->pack_kept_objects)
-		strvec_push(&cmd->args,  "--honor-pack-keep");
+	if (!args->pack_kept_objects && args->kept_packs_snapshot)
+		strvec_pushf(&cmd->args, "--keep-pack-from-file=%s",
+			     args->kept_packs_snapshot);
 	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
@@ -167,6 +168,35 @@ void existing_packs_collect(struct existing_packs *existing,
 	strbuf_release(&buf);
 }
 
+void existing_packs_snapshot_kept(const struct existing_packs *existing,
+				  struct tempfile *f)
+{
+	struct string_list_item *item;
+	FILE *out = fdopen_tempfile(f, "w");
+
+	if (!out)
+		die(_("could not open tempfile %s for writing"),
+		    get_tempfile_path(f));
+
+	for_each_string_list_item(item, &existing->kept_packs) {
+		/*
+		 * A newline would split the name in two, and pack-objects
+		 * quietly keeps whichever packs the halves happen to name.
+		 */
+		if (strchr(item->string, '\n'))
+			die(_("cannot keep pack '%s': its name contains a newline"),
+			    item->string);
+		fprintf(out, "%s.pack\n", item->string);
+	}
+
+	if (close_tempfile_gently(f)) {
+		int save_errno = errno;
+		delete_tempfile(&f);
+		errno = save_errno;
+		die_errno(_("could not close kept packs snapshot tempfile"));
+	}
+}
+
 int existing_packs_has_non_kept(const struct existing_packs *existing)
 {
 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
diff --git a/repack.h b/repack.h
index 61e554e4ed..1c0aeca3e8 100644
--- a/repack.h
+++ b/repack.h
@@ -19,6 +19,14 @@ struct pack_objects_args {
 	int path_walk;
 	int delta_base_offset;
 	int pack_kept_objects;
+	/*
+	 * File naming the packs to leave alone, one "<name>.pack" per line;
+	 * NULL when there are none. pack-objects reads it rather than
+	 * looking for ".keep" files itself, so that a ".keep" created or
+	 * removed while we run cannot make the two of us disagree over
+	 * which packs are being repacked.
+	 */
+	const char *kept_packs_snapshot;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -28,6 +36,7 @@ struct pack_objects_args {
 }
 
 struct child_process;
+struct tempfile;
 
 void prepare_pack_objects(struct child_process *cmd,
 			  const struct pack_objects_args *args,
@@ -79,6 +88,12 @@ struct existing_packs {
  */
 void existing_packs_collect(struct existing_packs *existing,
 			    const struct string_list *extra_keep);
+/*
+ * Writes the names of the kept packs, one "<name>.pack" per line, into
+ * the given tempfile, for pack-objects to read with --keep-pack-from-file.
+ */
+void existing_packs_snapshot_kept(const struct existing_packs *existing,
+				  struct tempfile *f);
 int existing_packs_has_non_kept(const struct existing_packs *existing);
 int existing_pack_is_marked_for_deletion(struct string_list_item *item);
 void existing_packs_retain_cruft(struct existing_packs *existing,
@@ -138,8 +153,6 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    bool wrote_incremental_midx);
 void pack_geometry_release(struct pack_geometry *geometry);
 
-struct tempfile;
-
 enum repack_write_midx_mode {
 	REPACK_WRITE_MIDX_NONE,
 	REPACK_WRITE_MIDX_DEFAULT,
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f0a390e3c6..845f032bea 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -254,6 +254,49 @@ test_expect_success 'repack --keep-pack' '
 	)
 '
 
+test_expect_success 'repack --keep-pack with --pack-kept-objects' '
+	test_create_repo keep-pack-kept-objects &&
+	(
+		cd keep-pack-kept-objects &&
+		git config pack.window 0 &&
+		git config maintenance.auto false &&
+		P1=$(commit_and_pack 1) &&
+		P2=$(commit_and_pack 2) &&
+
+		# "--pack-kept-objects" is about packs that have a ".keep"
+		# file. A pack named with "--keep-pack" stays out of the
+		# result regardless, objects included.
+		git repack -a -d --pack-kept-objects --keep-pack $P1 &&
+		ls .git/objects/pack/*.pack >counts &&
+		test_line_count = 2 counts &&
+		test-tool find-pack -c 1 HEAD~1 &&
+		test-tool find-pack -c 1 HEAD~1: &&
+		git fsck
+	)
+'
+
+test_expect_success FUNNYNAMES 'a kept pack whose name has a newline is refused' '
+	test_create_repo keep-pack-newline &&
+	(
+		cd keep-pack-newline &&
+		git config maintenance.auto false &&
+		test_commit base &&
+		git repack -ad &&
+
+		# The names pack-objects is told to keep go one per line, so
+		# this one would come out as two, and the first of them is
+		# the name of the pack holding everything else.
+		victim="$(basename "$(ls .git/objects/pack/pack-*.pack)")" &&
+		name="$(printf "%s\nother" "$victim")" &&
+		P=$(git rev-parse HEAD | git pack-objects ".git/objects/pack/$name") &&
+		>".git/objects/pack/$name-$P.keep" &&
+
+		test_must_fail git repack -ad 2>err &&
+		test_grep "contains a newline" err &&
+		git fsck
+	)
+'
+
 test_expect_success 'repacking fails when missing .pack actually means missing objects' '
 	test_create_repo idx-without-pack &&
 	(
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index f3a0650cfe..6b914a2a80 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -541,4 +541,76 @@ test_expect_success 'geometric repack works with promisor packs' '
 	)
 '
 
+test_expect_success 'a ".keep" that shows up mid-repack does not lose objects' '
+	test_when_finished "rm -fr race" &&
+	git init race &&
+	(
+		cd race &&
+
+		test_commit kept &&
+		test_commit pack &&
+
+		KEPT=$(git pack-objects --revs $packdir/pack <<-EOF
+		refs/tags/kept
+		EOF
+		) &&
+		git pack-objects --revs $packdir/pack <<-EOF &&
+		refs/tags/pack
+		^refs/tags/kept
+		EOF
+		git prune-packed &&
+
+		# Neither pack is twice the size of the other, so both are
+		# redundant and get deleted. Have a ".keep" appear on one of
+		# them as pack-objects starts, after the repack has decided
+		# to delete it: pack-objects used to notice the ".keep" and
+		# leave those objects out of the replacement pack.
+		mkdir shim &&
+		write_script shim/git <<-EOF &&
+		test "\$1" = "pack-objects" && >"$(pwd)/$packdir/pack-$KEPT.keep"
+		GIT_EXEC_PATH="$GIT_EXEC_PATH" exec "$GIT_EXEC_PATH/git" "\$@"
+		EOF
+
+		git --exec-path="$(pwd)/shim" repack --geometric 2 -d &&
+
+		git fsck
+	)
+'
+
+test_expect_success 'a kept pack does not stop the traversal from rescuing objects' '
+	test_when_finished "rm -fr kept-open" &&
+	git init kept-open &&
+	(
+		cd kept-open &&
+		git config repack.midxMustContainCruft false &&
+
+		test_commit a &&
+		test_commit b &&
+		b=$(git rev-parse b) &&
+		git repack -ad &&
+
+		# Make "b" unreachable and sweep it, together with its tree
+		# and blob, into a cruft pack.
+		git tag -d b &&
+		git reset --hard a &&
+		git reflog expire --all --expire=all &&
+		git repack -ad --cruft &&
+
+		# Bring the commit back on its own, in a pack marked as kept.
+		# Its tree and blob are still only in the cruft pack.
+		kept=$(echo $b | git pack-objects $packdir/pack) &&
+		>$packdir/pack-$kept.keep &&
+
+		# Build on top of it, so that the repack has to look through
+		# the kept pack to find out what the new commit depends on.
+		git update-ref refs/heads/master \
+			$(git commit-tree a^{tree} -p $b -m c) &&
+
+		git repack --geometric 2 -d --write-midx --write-bitmap-index &&
+		test_path_is_file $packdir/multi-pack-index &&
+		ls $packdir/multi-pack-index-*.bitmap >bitmaps &&
+		test_line_count = 1 bitmaps
+	)
+'
+
 test_done
-- 
gitgitgadget
