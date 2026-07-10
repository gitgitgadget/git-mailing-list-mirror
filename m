Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECE1F0E29
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656798; cv=none; b=WtCkSAZ5DNIzF3d4Sv/pOBtT8gx1lkqOYxSsz5sNCPXffg9X1jVM1hpXlsfss+Qocw1UWbfG53wwY070Btv+vEMnHX9mAbU9aoXfrDNcR6F6IvnQWrVTpcz0s8CVLDpBCUhoPl6+e9Fhth0gz8LQRpaaqoIkLglepJJ9vCoSS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656798; c=relaxed/simple;
	bh=03IRzxiaGn6V61oEabPtr5F3oNVU5D+sVFXrNAhCHhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kuqQVC68KQun0Txp2ve596EN23OabO1ni0F/9VNJcNdUtHdpbKiA4e+e7RXgTmpM2ZoKj8bHSLfqTH4i1EUD32WVncP98bpsWNm7HYotmOphDlggaMr5zUHQT3mnD+ZR80EOMopFCqb4NSw2yvjGkGYnyB5k4l+QXmcMaRP6hZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMIzTNmy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMIzTNmy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso675767a91.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 21:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783656796; x=1784261596; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a0DQ39zTffAcLuW6IySojCJZ/tuTvuTjNesGn96yAj8=;
        b=HMIzTNmyWnD6+3nWFavmVkvIOmhE+NmgtpyCe/xjDKUhFMB9iucpN/DesasRlitqIn
         o/CkwOZdXa2+APXo8TueheWT1G1CEIDISL9Rk9xZ4trIZlqZh6Ye7djixGOhET/h+w1u
         69aaKwZ/m/D7RIKsMLt4PKbYHJcyDFyUWYzaJjQDDVwim7/MZBKg7NHV7fOUmKkdTFy7
         tTP7Es1ANFnZizb6Cmc4XFUTinYuRPNIwgv2yOvFKKrvUcdh04Tvx4VuOeky3GtiD7xh
         y7V78d71Vvs7A8EDA9hBiAarbhCFRMIVl+wXd12sByGj69fMHwzOfSxb+mw5yWCkxmC8
         qaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783656796; x=1784261596;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a0DQ39zTffAcLuW6IySojCJZ/tuTvuTjNesGn96yAj8=;
        b=k3/XYaysbUyvlZHHeR6M9YFybdhRIRjhv36aJpFbwJS+cb0+5WfHbcNh0CVuWkR7c8
         KvVgDmigMryHe9z++DIHKKXlllx7mw/vn/awsYIQjbujRSwQwOJke038NvA8xPyZg5Fq
         DIZAQrskzub+vb3RYHbBT5X9gHehVIZ3XVPNmNZLbk0N6pWY0P+P1HzjvJTWkZJhLaT7
         HpmZRxGxLyF6awKM0SEElltSQ8SNnUtP7JqQB0mijPUUtKPEIqouJfnJA7B26YFS3S7m
         QFukLqZW6T5vsaKs/lgnUDbH+fnrX3CJMmxqNvuSabB8LJZfZdaSg+H+SO8Gj9WPXDRx
         9PVw==
X-Gm-Message-State: AOJu0YycNlsYVr36B6UuQhOPn8oQs+Jf4lWY7Gc98conq5AESoKVagfe
	0HsqzPc1ev6kXkfPj4yryUstgUcgcaNIuPTpwDtMh6w2JeaRnaM6LndB+yiV4N32
X-Gm-Gg: AfdE7cmhYlPsW5AjpmkwYxEEI0DEzy9j9nRrbEvC/r0pyCRFFoz3As2YIkqhs3idBDu
	5NrSAC8mNrByF0CrvxDQoF9myCbuzoyspZxgNS54Wg3doj1MOykZhUin+ce22CBSGdeGlOX43Yx
	CZl/ZhHy63q31XfFNCrM+VFIl2l3QaKqlIMR190QqNxtJgdfFauQ0dx61cBiYGGkkdRFXrXVUs+
	pk/DLIHB+OZzvgZVo/LQV0tgLbh7oJ20hIQWOHJ87vicgu1WHQPiE//ot+Ng2lf5kqOKdqiFCcp
	fN5TMShdzYIndoWGOSjw5bBDGW8STQP22Ezpp/3v3GWW5DslPV26J5bVex3UEOgYibsaBw7hg81
	HwcsbR6nJVKLe5mczKCBgSCDT4QU89BJH4d/E3SvZ2IqQIFVhvVa5ZtfLy3b61dMalhjmridSls
	nJVOKqnOKuwndmeCS5
X-Received: by 2002:a17:90b:1fcd:b0:38d:84db:c5d7 with SMTP id 98e67ed59e1d1-38d84dbcca8mr656837a91.35.1783656796025;
        Thu, 09 Jul 2026 21:13:16 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm38670529eec.30.2026.07.09.21.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:13:15 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Thu, 09 Jul 2026 21:13:11 -0700
Subject: [PATCH] sequencer: honor --empty when a fixup!/squash! empties its
 target
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFZxUGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNL3bQq3cTSkvziwtLE4gzd1NyCkkrdJDMzS6PkNGOzZDMDJaDOgqL
 UtMwKsKnRsbW1ANXwkjBlAAAA
X-Change-ID: 20260709-fz-autosquash-empty-b6692cf36c60
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.14.3

When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
its target, the result can be a commit that no longer changes anything
relative to its parent, for example when the melded change reverts the
target.  Rather than dropping or keeping this empty commit, the rebase
stops with

	You asked to amend the most recent commit, but doing so would
	make it empty. ...

and the "--empty" option has no effect on it.  This makes backing a
change out of a series awkward: reverting a commit as a "fixup!" and
running "git rebase --autosquash --empty=drop" ought to remove both the
commit and its revert, but it halts instead.

The reason is that allow_empty() decides emptiness with
is_index_unchanged(), which compares the index to HEAD.  A "fixup!" is
applied by amending HEAD, so the commit it produces has HEAD's parent as
its parent; it is empty when the index matches the tree of that parent,
not of HEAD.  A meld that cancels out its target is therefore never
recognized as having become empty, and falls through to "git commit
--amend", which refuses to create an empty commit.

Teach is_index_unchanged() to compare against the tree of HEAD's parent
when amending, and teach allow_empty() to classify the result as "became
empty" (and thus subject to --empty) unless the commit being melded into
was itself already empty, in which case it "started empty" and is
governed by allow_empty as before.

When --empty=drop applies, the emptied commit has already been created
by the preceding "pick", so drop it by moving HEAD back to its parent.
Do so before the rewritten-commit list is flushed, so that --update-refs
and the other rewrite consumers map the dropped commit to its parent.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
At Meta we maintain a fork of LLVM that we regularly rebase onto
upstream.  A set of internal patches rides on top, and we keep each one
as a single commit by folding follow-up changes into it with autosquash
"fixup!" commits.  That works well for evolving a patch, but not for
retiring one: to back an internal patch out today we delete it from the
history by hand with an interactive rebase and then force-push, which is
easy to get wrong on a shared branch.

It would be nicer to retire a patch the same way we amend one: commit a
revert of it as a "fixup!" and let autosquash fold the two together.
The net change is empty, so the commit should just drop out of the
series.  Today it does not -- the rebase stops instead.

For example, starting from a commit we want to retire:

    $ git log --oneline
    4d5e6f7 add feature patch
    9a1b2c3 base

    # revert the feature and mark the revert as a fixup of it
    $ git revert --no-edit HEAD
    $ git commit --amend -m "fixup! add feature patch"

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    You asked to amend the most recent commit, but doing so would
    make it empty. You can repeat your command with --allow-empty [...]
    Could not apply 8e9f0a1... # fixup! add feature patch

The "--empty=drop" is ignored.  "--empty" only governs commits that are
picked empty, whereas a "fixup!" is applied by amending, and the
emptiness of an amended commit is measured against the wrong parent.  So
the rebase falls through to "git commit --amend", which refuses to
create an empty commit, and halts.

With this patch the emptied commit is recognized and handled according
to "--empty", the same as any other commit that becomes empty during a
rebase:

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    dropping 8e9f0a1... fixup! add feature patch -- resulting commit is empty
    Successfully rebased and updated refs/heads/main.

    $ git log --oneline
    9a1b2c3 base

"--empty=keep" retains it as an empty commit, and "--empty=stop" (the
default under "-i") halts so the user can decide -- matching how these
options already behave for commits that become empty when picked.

One open question, for a possible follow-up.  A natural next step would
be a "revert!" autosquash directive (and a "git commit --revert" to
create it), mirroring "fixup!"/"squash!", so
that retiring a patch would not require generating the reverse diff by
hand.  I have deliberately left it out of this series, because its
semantics are not obvious: in particular, whether a "revert!" commit
should carry the reverse patch as its own content (and thus be an
ordinary fixup that this patch already drops), or be an empty marker
that instructs the rebase to revert the target commit during the meld.
Opinions on whether such a directive is wanted, and which of those two
shapes is preferred, would be welcome before I attempt it.
---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
---
 Documentation/git-rebase.adoc | 12 ++++++
 sequencer.c                   | 96 +++++++++++++++++++++++++++++++++++++++----
 t/t3415-rebase-autosquash.sh  | 64 +++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..7eb8bbe95f 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -282,6 +282,11 @@ by `git log --cherry-mark ...`) are detected and dropped as a
 preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
 passed).
 +
+A commit can also become empty as a result of `--autosquash`, when a
+`fixup!` or `squash!` commit cancels out all of the changes of the
+commit it is melded into.  Such a commit is treated the same way and is
+dropped, kept, or stopped at according to this option.
++
 See also INCOMPATIBLE OPTIONS below.
 
 --no-keep-empty::
@@ -591,6 +596,13 @@ changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
 are moved right after the commit they modify.  The `--interactive` option can
 be used to review and edit the todo list before proceeding.
 +
+If melding a `fixup!` or `squash!` commit cancels out all of the changes of
+the commit it is applied to, the result is an empty commit.  The handling of
+these empty commits can be configured with the `--empty` option: the emptied
+commit is dropped, kept, or stopped at.  This makes it possible to back a
+change out of a series by committing a revert of it as a `fixup!` and letting
+`--autosquash --empty=drop` remove both.
++
 The recommended way to create commits with squash markers is by using the
 `--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
 linkgit:git-commit[1], which take the target commit as an argument and
diff --git a/sequencer.c b/sequencer.c
index 0fe8fed6c3..435b100e3d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -823,7 +823,7 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
 	return &istate->cache_tree->oid;
 }
 
-static int is_index_unchanged(struct repository *r)
+static int is_index_unchanged(struct repository *r, int amend)
 {
 	struct object_id head_oid, *cache_tree_oid;
 	const struct object_id *head_tree_oid;
@@ -856,7 +856,26 @@ static int is_index_unchanged(struct repository *r)
 		if (repo_parse_commit(r, head_commit))
 			return -1;
 
-		head_tree_oid = get_commit_tree_oid(head_commit);
+		if (amend) {
+			/*
+			 * When amending (e.g. melding a "fixup!" or "squash!"),
+			 * the commit we are about to create replaces HEAD, so
+			 * its parent is HEAD's parent.  It is therefore empty
+			 * when the index matches the tree of HEAD's parent
+			 * rather than the tree of HEAD itself.
+			 */
+			if (head_commit->parents) {
+				struct commit *parent =
+					head_commit->parents->item;
+				if (repo_parse_commit(r, parent))
+					return -1;
+				head_tree_oid = get_commit_tree_oid(parent);
+			} else {
+				head_tree_oid = the_hash_algo->empty_tree;
+			}
+		} else {
+			head_tree_oid = get_commit_tree_oid(head_commit);
+		}
 	}
 
 	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
@@ -1786,7 +1805,7 @@ static int is_original_commit_empty(struct commit *commit)
  */
 static int allow_empty(struct repository *r,
 		       struct replay_opts *opts,
-		       struct commit *commit)
+		       struct commit *commit, int amend)
 {
 	int index_unchanged, originally_empty;
 
@@ -1798,13 +1817,33 @@ static int allow_empty(struct repository *r,
 	 * drop_redundant_commits determine whether the commit should be kept or
 	 * dropped. If neither is specified, halt.
 	 */
-	index_unchanged = is_index_unchanged(r);
+	index_unchanged = is_index_unchanged(r, amend);
 	if (index_unchanged < 0)
 		return index_unchanged;
 	if (!index_unchanged)
 		return 0; /* we do not have to say --allow-empty */
 
-	originally_empty = is_original_commit_empty(commit);
+	/*
+	 * When amending (melding a "fixup!"/"squash!"), the resulting commit
+	 * replaces HEAD, so whether it "started" empty or "became" empty is
+	 * decided by whether the commit being melded into was itself empty: if
+	 * HEAD had content that the fixup cancelled out, the commit became empty
+	 * and is subject to keep/drop_redundant; if HEAD was already empty, the
+	 * commit started empty and is subject to allow_empty as usual.
+	 */
+	if (amend) {
+		struct object_id head_oid;
+		struct commit *head_commit;
+
+		if (repo_get_oid(r, "HEAD", &head_oid))
+			return error(_("could not resolve HEAD commit"));
+		head_commit = lookup_commit_reference(r, &head_oid);
+		if (!head_commit)
+			return -1;
+		originally_empty = is_original_commit_empty(head_commit);
+	} else {
+		originally_empty = is_original_commit_empty(commit);
+	}
 	if (originally_empty < 0)
 		return originally_empty;
 	if (originally_empty)
@@ -2260,6 +2299,30 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+/*
+ * A "fixup!"/"squash!" that melds into HEAD may empty it out.  In that case,
+ * with --empty=drop, we want to drop the commit entirely.  Since the commit
+ * being amended has already been created (by the preceding "pick"), and the
+ * index and worktree already match the tree of its parent, dropping it is a
+ * matter of moving HEAD back to that parent.
+ */
+static int reset_head_to_parent(struct repository *r, struct replay_opts *opts,
+				struct object_id *head)
+{
+	struct commit *head_commit = lookup_commit_reference(r, head);
+
+	if (!head_commit || repo_parse_commit(r, head_commit))
+		return error(_("could not parse HEAD commit"));
+	if (!head_commit->parents)
+		return error(_("cannot drop the root commit"));
+
+	return refs_update_ref(get_main_ref_store(r),
+			       reflog_message(opts, "fixup",
+					      "dropping emptied commit"),
+			       "HEAD", &head_commit->parents->item->object.oid,
+			       head, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 static int do_pick_commit(struct repository *r,
 			  struct todo_item *item,
 			  struct replay_opts *opts,
@@ -2493,7 +2556,7 @@ static int do_pick_commit(struct repository *r,
 	}
 
 	drop_commit = 0;
-	allow = allow_empty(r, opts, commit);
+	allow = allow_empty(r, opts, commit, flags & AMEND_MSG);
 	if (allow < 0) {
 		res = allow;
 		goto leave;
@@ -2506,9 +2569,24 @@ static int do_pick_commit(struct repository *r,
 		unlink(git_path_merge_msg(r));
 		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
 				NULL, REF_NO_DEREF);
-		fprintf(stderr,
-			_("dropping %s %s -- patch contents already upstream\n"),
-			oid_to_hex(&commit->object.oid), msg.subject);
+		if (flags & AMEND_MSG) {
+			/*
+			 * The "fixup!"/"squash!" emptied out the commit it was
+			 * melded into; that commit was already created by the
+			 * preceding "pick", so drop it by moving HEAD back to
+			 * its parent.
+			 */
+			res = reset_head_to_parent(r, opts, &head);
+			if (res)
+				goto leave;
+			fprintf(stderr,
+				_("dropping %s %s -- resulting commit is empty\n"),
+				oid_to_hex(&commit->object.oid), msg.subject);
+		} else {
+			fprintf(stderr,
+				_("dropping %s %s -- patch contents already upstream\n"),
+				oid_to_hex(&commit->object.oid), msg.subject);
+		}
 	} /* else allow == 0 and there's nothing special to do */
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5033411a43..508dcc7527 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -510,4 +510,68 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	test_commit_message HEAD -m "something"
 '
 
+test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addX fileX 1 &&
+	test_commit --no-tag changeX fileX 2 &&
+	test_commit --no-tag later fileW hello &&
+	echo 1 >fileX &&
+	git commit -m "fixup! changeX" fileX &&
+
+	git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	git log --format=%s >actual &&
+	! grep changeX actual &&
+	grep addX actual &&
+	grep later actual &&
+	echo 1 >expect &&
+	test_cmp expect fileX &&
+	echo hello >expect &&
+	test_cmp expect fileW
+'
+
+test_expect_success 'fixup! that empties its target is kept with --empty=keep' '
+	git reset --hard base &&
+	test_commit --no-tag addY fileY 1 &&
+	test_commit --no-tag changeY fileY 2 &&
+	echo 1 >fileY &&
+	git commit -m "fixup! changeY" fileY &&
+
+	git rebase -i --autosquash --empty=keep HEAD~3 &&
+
+	git log --format=%s >actual &&
+	grep changeY actual &&
+	: "the retained commit is empty" &&
+	git diff --exit-code HEAD~1 HEAD &&
+	echo 1 >expect &&
+	test_cmp expect fileY
+'
+
+test_expect_success 'fixup! that empties its target stops with --empty=stop' '
+	git reset --hard base &&
+	test_commit --no-tag addZ fileZ 1 &&
+	test_commit --no-tag changeZ fileZ 2 &&
+	echo 1 >fileZ &&
+	git commit -m "fixup! changeZ" fileZ &&
+
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --autosquash --empty=stop HEAD~3
+'
+
+test_expect_success 'squash! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addS fileS 1 &&
+	test_commit --no-tag changeS fileS 2 &&
+	echo 1 >fileS &&
+	git commit -m "squash! changeS" fileS &&
+
+	git rebase -i --autosquash --empty=drop HEAD~3 &&
+
+	git log --format=%s >actual &&
+	! grep changeS actual &&
+	grep addS actual &&
+	echo 1 >expect &&
+	test_cmp expect fileS
+'
+
 test_done



