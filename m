Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B6BC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiGLNHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiGLNHN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733DB4BD6
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so11096580wra.5
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2DW4FEw35RCXSXNAC89JibW0N760IGGeNP2Por30yPM=;
        b=D3nYxxd6iPhyb0GyA4UPLI0c4w6lIKChgI/Pk9GgANS4dzWRsBiX6hHwS7QhPgzP8m
         ePf5RDauVVGYuKPR+MlZwQxv/wKA8AkkuQrp2UHwaipOr9NEwBxD/tfn+IJvnSQCZ8lo
         HeLdAh8Oh5aY5hI1UE+7ZB7ZGyUUvijcu5W+pp21DpSoPk10LqaRYSwWV01STLl7QfOE
         reJ+HQfoO4lO5b8Gs9E6Pm2F/8p4Y70qn3Z34sFTrV4qvtewoIdGxZmSmyDTLbekEJ79
         jqKrWu/hfFCbddqMsGU9ZL6cTUbM+jGuURkYdu6DtEg3q2fZiETGh+PNKAG2/yb0G9Z/
         J2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2DW4FEw35RCXSXNAC89JibW0N760IGGeNP2Por30yPM=;
        b=hJchPlpwHzif6zALRVPduYwKV+wjsue9lM9/f1O3AuB1Nuglh9oQ52ZAKLih7J2smY
         s2ocnEN5lV8h6w8Wqt8ahTX9rEbrwaXpcdyg6B2VIdvwS5XRmyhvTuqXaWKGrVGdnhVx
         jBQNvervCxs5hYpFV9C1JVYPrsH3IcjXRxCJKzZYHV+OREpX3n3UPb47WiYQmcV3709i
         QqZR59Te9qPhtVxgCYn9lrqPGsNGc5HRzmLhy9sMUCEZjhuwH05DEsgtmsbcoZCWkzQE
         6ES1z+5Ab3MyDrxjUd8EptmxnZlhRCBHOX8PslEgxDhQtoR3ej+GKJhLFYje2OJ++5av
         mSZQ==
X-Gm-Message-State: AJIora9qb+6mifffYw5ALsiRrgoUcmw+3VDmleAwouLysuhb1wbX6Tbh
        J/SS2nHsXuZgbcJjejlTTrJ9viJmtkc=
X-Google-Smtp-Source: AGRyM1u/R9n7w59wY9/aWSyET3rqtpkTWYfuDvqP8j7nhdcKmO9YWn5tb7JSOdb39lIrp8S1DDW1Yg==
X-Received: by 2002:adf:f705:0:b0:21d:74fa:c043 with SMTP id r5-20020adff705000000b0021d74fac043mr22696845wrp.77.1657631228497;
        Tue, 12 Jul 2022 06:07:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b0021d77625d90sm8220718wrx.79.2022.07.12.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:07 -0700 (PDT)
Message-Id: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:06:53 +0000
Subject: [PATCH v4 00/12] rebase: update branches in multi-part topic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/branch-checked-out.

This is a feature I've wanted for quite a while. When working on the sparse
index topic, I created a long RFC that actually broke into three topics for
full review upstream. These topics were sequential, so any feedback on an
earlier one required updates to the later ones. I would work on the full
feature and use interactive rebase to update the full list of commits.
However, I would need to update the branches pointing to those sub-topics.

This series adds a new --update-refs option to 'git rebase' (along with a
rebase.updateRefs config option) that adds 'update-ref' commands into the
TODO list. This is powered by the commit decoration machinery.

As an example, here is my in-progress bundle URI RFC split into subtopics as
they appear during the TODO list of a git rebase -i --update-refs:

pick 2d966282ff3 docs: document bundle URI standard
pick 31396e9171a remote-curl: add 'get' capability
pick 54c6ab70f67 bundle-uri: create basic file-copy logic
pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
pick 6adaf842684 fetch: add --bundle-uri option
pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
update-ref refs/heads/bundle-redo/fetch

pick 1e3f6546632 clone: add --bundle-uri option
pick 9e4a6fe9b68 clone: --bundle-uri cannot be combined with --depth
update-ref refs/heads/bundle-redo/clone

pick 5451cb6599c bundle-uri: create bundle_list struct and helpers
pick 3029c3aca15 bundle-uri: create base key-value pair parsing
pick a8b2de79ce8 bundle-uri: create "key=value" line parsing
pick 92625a47673 bundle-uri: unit test "key=value" parsing
pick a8616af4dc2 bundle-uri: limit recursion depth for bundle lists
pick 9d6809a8d53 bundle-uri: parse bundle list in config format
pick 287a732b54c bundle-uri: fetch a list of bundles
update-ref refs/heads/bundle-redo/list

pick b09f8226185 protocol v2: add server-side "bundle-uri" skeleton
pick 520204dcd1c bundle-uri client: add minimal NOOP client
pick 62e8b457b48 bundle-uri client: add "git ls-remote-bundle-uri"
pick 00eae925043 bundle-uri: serve URI advertisement from bundle.* config
pick 4277440a250 bundle-uri client: add boolean transfer.bundleURI setting
pick caf4599a81d bundle-uri: allow relative URLs in bundle lists
pick df255000b7e bundle-uri: download bundles from an advertised list
pick d71beabf199 clone: unbundle the advertised bundles
pick c9578391976 t5601: basic bundle URI tests
# Ref refs/heads/bundle-redo/rfc-3 checked out at '/home/stolee/_git/git-bundles'

update-ref refs/heads/bundle-redo/advertise


Here is an outline of the series:

 * Patch 1 updates some tests for branch_checked_out() to use 'git bisect'
   and 'git rebase' as black-boxes instead of manually editing files inside
   $GIT_DIR. (Thanks, Junio!)
 * Patch 2 updates some tests for branch_checked_out() for the 'apply'
   backend.
 * Patch 3 updates branch_checked_out() to parse the
   rebase-merge/update-refs file to block concurrent ref updates and
   checkouts on branches selected by --update-refs.
 * Patch 4 updates the todo list documentation to remove some unnecessary
   dots in the 'merge' command. This makes it consistent with the 'fixup'
   command before we document the 'update-ref' command.
 * Patch 5 updates the definition of todo_command_info to use enum values as
   array indices.
 * Patches 6-8 implement the --update-refs logic itself.
 * Patch 9 specifically updates the update-refs file every time the user
   edits the todo-list (Thanks Phillip!)
 * Patch 10 adds the rebase.updateRefs config option similar to
   rebase.autoSquash.
 * Patch 11 ignores the HEAD ref when creating the todo list instead of
   making a comment (Thanks Elijah!)
 * Patch 12 adds messaging to the end of the rebase stating which refs were
   updated (Thanks Elijah!)


Updates in v4
=============

This version took longer than I'd hoped (I had less time to work on it than
anticipated) but it also has some major updates. These major updates are
direct responses to the significant review this series has received. Thank
you!

 * The update-refs file now stores "ref/before/after" triples (still
   separated by lines). This allows us to store the "before" OID of a ref in
   addition to the "after" that we will write to that ref at the end of the
   rebase. This allows us to do a "force-with-lease" update. The
   branch_checked_out() updates should prevent Git from updating those refs
   while under the rebase, but older versions and third-party tools don't
   have that protection.
 * The update-refs file is updated with every update to the todo-list file.
   This allows for some advanced changes to the file, including removing,
   adding, and duplicating 'update-ref' commands.
 * The message at the end of the rebase process now lists which refs were
   updated with the update-ref steps. This includes any ref updates that
   fail.
 * The branch_checked_out() tests now use 'git bisect' and 'git rebase' as
   black-boxes instead of testing their internals directly.

Here are the more minor updates:

 * Dropped an unnecessary stat() call.
 * Updated commit messages to include extra details, based on confusion in
   last round.
 * The HEAD branch no longer appears as a comment line in the initial todo
   list.
 * The update-refs file is now written using a lockfile.
 * Tests now use test_cmp_rev.
 * A memory leak ('path' variable) is resolved.


Updates in v3
=============

 * The branch_checked_out() API was extracted to its own topic and is now
   the ds/branch-checked-out branch. This series is now based on that one.
 * The for_each_decoration() API was removed, since it became trivial once
   it did not take a commit directly.
 * The branch_checked_out() tests did not verify the rebase-apply data (for
   the apply backend), so that is fixed.
 * Instead of using the 'label' command and a final 'update-refs' command in
   the todo list, use a new 'update-ref ' command. This command updates the
   rebase-merge/update-refs file with the OID of HEAD at these steps. At the
   very end of the rebase sequence, those refs are updated to the stored OID
   values (assuming that they were not removed by the user, in which case we
   notice that the OID is the null OID and we do nothing).
 * New tests are added.
 * The todo-list comment documentation has some new formatting updates, but
   also includes a description of 'update-refs' in this version.


Updates in v2
=============

As recommended by the excellent feedback, I have removed the 'exec' commands
in favor of the 'label' commands and a new 'update-refs' command at the very
end. This way, there is only one step that updates all of the refs at the
end instead of updating refs during the rebase. If a user runs 'git rebase
--abort' in the middle, then their refs are still where they need to be.

Based on some of the discussion, it seemed like one way to do this would be
to have an 'update-ref ' command that would take the place of these 'label'
commands. However, this would require two things that make it a bit awkward:

 1. We would need to replicate the storage of those positions during the
    rebase. 'label' already does this pretty well. I've added the
    "for-update-refs/" label to help here.
 2. If we want to close out all of the refs as the rebase is finishing, then
    that "step" becomes invisible to the user (and a bit more complicated to
    insert). Thus, the 'update-refs' step performs this action. If the user
    wants to do things after that step, then they can do so by editing the
    TODO list.

Other updates:

 * The 'keep_decorations' parameter was renamed to 'update_refs'.
 * I added tests for --rebase-merges=rebase-cousins to show how these labels
   interact with other labels and merge commands.
 * I changed the order of the insertion of these update-refs labels to be
   before the fixups are rearranged. This fixes a bug where the tip commit
   is a fixup! so its decorations are never inspected (and they would be in
   the wrong place even if they were). The fixup! commands are properly
   inserted between a pick and its following label command. Tests
   demonstrate this is correct.
 * Numerous style choices are updated based on feedback.

Thank you for all of the detailed review and ideas in this space. I
appreciate any more ideas that can make this feature as effective as it can
be.

Thanks, -Stolee

Derrick Stolee (12):
  t2407: test bisect and rebase as black-boxes
  t2407: test branches currently using apply backend
  branch: consider refs under 'update-refs'
  rebase-interactive: update 'merge' description
  sequencer: define array with enum values
  sequencer: add update-ref command
  rebase: add --update-refs option
  rebase: update refs from 'update-ref' commands
  sequencer: rewrite update-refs as user edits todo list
  rebase: add rebase.updateRefs config option
  sequencer: ignore HEAD ref under --update-refs
  sequencer: notify user of --update-refs activity

 Documentation/config/rebase.txt |   3 +
 Documentation/git-rebase.txt    |  11 +
 branch.c                        |  13 +
 builtin/rebase.c                |  10 +
 rebase-interactive.c            |  15 +-
 sequencer.c                     | 469 +++++++++++++++++++++++++++++++-
 sequencer.h                     |  23 ++
 t/lib-rebase.sh                 |  15 +
 t/t2407-worktree-heads.sh       | 103 +++++--
 t/t3404-rebase-interactive.sh   | 269 ++++++++++++++++++
 10 files changed, 887 insertions(+), 44 deletions(-)


base-commit: 9bef0b1e6ec371e786c2fba3edcc06ad040a536c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1247%2Fderrickstolee%2Frebase-keep-decorations-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1247/derrickstolee/rebase-keep-decorations-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1247

Range-diff vs v3:

  -:  ----------- >  1:  9e53a27017a t2407: test bisect and rebase as black-boxes
  1:  fbaedc7f1f0 !  2:  540a3be256f t2407: test branches currently using apply backend
     @@ Commit message
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## t/t2407-worktree-heads.sh ##
     -@@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: worktree in bisect' '
     - 	grep "cannot force update the branch '\''fake-2'\'' checked out at.*wt-4" err
     +@@ t/t2407-worktree-heads.sh: test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
     + 	grep "cannot force update the branch '\''wt-4'\'' checked out at.*wt-4" err
       '
       
     --test_expect_success 'refuse to overwrite: worktree in rebase' '
     -+test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
     -+	test_when_finished rm -rf .git/worktrees/wt-*/rebase-apply &&
     +-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase' '
     ++test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (apply)' '
     ++	test_when_finished git -C wt-2 rebase --abort &&
      +
     -+	mkdir -p .git/worktrees/wt-3/rebase-apply &&
     -+	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-apply/head-name &&
     -+	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-apply/onto &&
     ++	# This will fail part-way through due to a conflict.
     ++	test_must_fail git -C wt-2 rebase --apply conflict-2 &&
      +
     -+	test_must_fail git branch -f fake-1 HEAD 2>err &&
     -+	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
     ++	test_must_fail git branch -f wt-2 HEAD 2>err &&
     ++	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
      +'
      +
     -+test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
     - 	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
     ++test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (merge)' '
     + 	test_when_finished git -C wt-2 rebase --abort &&
       
     - 	mkdir -p .git/worktrees/wt-3/rebase-merge &&
     + 	# This will fail part-way through due to a conflict.
  2:  2bc647b6fcd !  3:  bf301a054e3 branch: consider refs under 'update-refs'
     @@ Commit message
          branch_checked_out().
      
          The data store is a plaintext file inside the 'rebase-merge' directory
     -    for that worktree. The file alternates refnames and OIDs. The OIDs will
     -    be used to store the to-be-written values as the rebase progresses, but
     -    can be ignored at the moment.
     +    for that worktree. The file lists refnames followed by two OIDs, each on
     +    separate lines. The OIDs will be used to store the original values of
     +    the refs and the to-be-written values as the rebase progresses, but can
     +    be ignored at the moment.
      
          Create a new sequencer_get_update_refs_state() method that parses this
          file and populates a struct string_list with the ref-OID pairs. We can
     @@ Commit message
          method.
      
          We can test that this works without having Git write this file by
     -    artificially creating one in our test script.
     +    artificially creating one in our test script, at least until 'git rebase
     +    --update-refs' is implemented and we can use it directly.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ branch.c: static void prepare_checked_out_branches(void)
       	free_worktrees(worktrees);
      
       ## sequencer.c ##
     +@@ sequencer.c: static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
     +  */
     + static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
     + 
     ++/*
     ++ * The update-refs file stores a list of refs that will be updated at the end
     ++ * of the rebase sequence. The 'update-ref <ref>' commands in the todo file
     ++ * update the OIDs for the refs in this file, but the refs are not updated
     ++ * until the end of the rebase sequence.
     ++ *
     ++ * rebase_path_update_refs() returns the path to this file for a given
     ++ * worktree directory. For the current worktree, pass the_repository->gitdir.
     ++ */
     ++static char *rebase_path_update_refs(const char *wt_dir)
     ++{
     ++	return xstrfmt("%s/rebase-merge/update-refs", wt_dir);
     ++}
     ++
     + /*
     +  * The following files are written by git-rebase just after parsing the
     +  * command-line.
     +@@ sequencer.c: static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-res
     + static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
     + static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
     + 
     ++/**
     ++ * A 'struct update_refs_record' represents a value in the update-refs
     ++ * list. We use a string_list to map refs to these (before, after) pairs.
     ++ */
     ++struct update_ref_record {
     ++	struct object_id before;
     ++	struct object_id after;
     ++};
     ++
     + static int git_sequencer_config(const char *k, const char *v, void *cb)
     + {
     + 	struct replay_opts *opts = cb;
      @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
       
       	return 0;
     @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
      +				    struct string_list *refs)
      +{
      +	int result = 0;
     -+	struct stat st;
      +	FILE *fp = NULL;
      +	struct strbuf ref = STRBUF_INIT;
      +	struct strbuf hash = STRBUF_INIT;
     -+	char *path = xstrfmt("%s/rebase-merge/update-refs", wt_dir);
     ++	struct update_ref_record *rec = NULL;
      +
     -+	if (stat(path, &st))
     -+		goto cleanup;
     ++	char *path = rebase_path_update_refs(wt_dir);
      +
      +	fp = fopen(path, "r");
      +	if (!fp)
      +		goto cleanup;
      +
      +	while (strbuf_getline(&ref, fp) != EOF) {
     -+		struct object_id oid;
      +		struct string_list_item *item;
      +
     ++		CALLOC_ARRAY(rec, 1);
     ++
      +		if (strbuf_getline(&hash, fp) == EOF ||
     -+		    get_oid_hex(hash.buf, &oid)) {
     ++		    get_oid_hex(hash.buf, &rec->before)) {
      +			warning(_("update-refs file at '%s' is invalid"),
      +				  path);
      +			result = -1;
      +			goto cleanup;
      +		}
      +
     -+		item = string_list_append(refs, ref.buf);
     -+		item->util = oiddup(&oid);
     ++		if (strbuf_getline(&hash, fp) == EOF ||
     ++		    get_oid_hex(hash.buf, &rec->after)) {
     ++			warning(_("update-refs file at '%s' is invalid"),
     ++				  path);
     ++			result = -1;
     ++			goto cleanup;
     ++		}
     ++
     ++		item = string_list_insert(refs, ref.buf);
     ++		item->util = rec;
     ++		rec = NULL;
      +	}
      +
      +cleanup:
      +	if (fp)
      +		fclose(fp);
      +	free(path);
     ++	free(rec);
      +	strbuf_release(&ref);
      +	strbuf_release(&hash);
      +	return result;
     @@ sequencer.h: void sequencer_post_commit_cleanup(struct repository *r, int verbos
       #endif /* SEQUENCER_H */
      
       ## t/t2407-worktree-heads.sh ##
     -@@ t/t2407-worktree-heads.sh: TEST_PASSES_SANITIZE_LEAK=true
     +@@ t/t2407-worktree-heads.sh: test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
     + 	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
     + '
       
     - test_expect_success 'setup' '
     - 	test_commit init &&
     --	git branch -f fake-1 &&
     --	git branch -f fake-2 &&
     ++test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
     ++	test_when_finished rm -rf .git/worktrees/wt-3/rebase-merge &&
     ++
     ++	mkdir -p .git/worktrees/wt-3/rebase-merge &&
     ++	touch .git/worktrees/wt-3/rebase-merge/interactive &&
      +
     -+	for i in 1 2 3 4
     -+	do
     -+		git branch -f fake-$i || return 1
     -+	done &&
     - 
     - 	for i in 1 2 3 4
     - 	do
     -@@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
     - 	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
     - 	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
     - 
     --	test_must_fail git branch -f fake-1 HEAD 2>err &&
     --	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
      +	cat >.git/worktrees/wt-3/rebase-merge/update-refs <<-EOF &&
      +	refs/heads/fake-3
      +	$(git rev-parse HEAD~1)
     ++	$(git rev-parse HEAD)
      +	refs/heads/fake-4
      +	$(git rev-parse HEAD)
     ++	$(git rev-parse HEAD)
      +	EOF
      +
     -+	for i in 1 3 4
     ++	for i in 3 4
      +	do
      +		test_must_fail git branch -f fake-$i HEAD 2>err &&
      +		grep "cannot force update the branch '\''fake-$i'\'' checked out at.*wt-3" err ||
      +			return 1
      +	done
     - '
     - 
     ++'
     ++
       test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
     + 	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
     + 	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
  3:  669f4abd59e !  4:  dec95681d2b rebase-interactive: update 'merge' description
     @@ Commit message
          The 'merge' command description for the todo list documentation in an
          interactive rebase has multiple lines. The lines other than the first
          one start with dots ('.') while the similar multi-line documentation for
     -    'fixup' does not.
     +    'fixup' does not. This description only appears in the comment text of
     +    the todo file during an interactive rebase.
      
          The 'merge' command was documented when interactive rebase was first
          ported to C in 145e05ac44b (rebase -i: rewrite append_todo_help() in C,
  4:  6528a50343f =  5:  b2c09600918 sequencer: define array with enum values
  5:  e95ad41d355 =  6:  fa7ecb718cf sequencer: add update-ref command
  6:  918b398d6a2 !  7:  3ec2cc922f9 rebase: add --update-refs option
     @@ Commit message
          'update-ref' commands. Tests are added to ensure that these todo
          commands are added in the correct locations.
      
     -    A future change will update the behavior to actually update the refs
     -    at the end of the rebase sequence.
     +    This change does _not_ include the actual behavior of tracking the
     +    updated refs and writing the new ref values at the end of the rebase
     +    process. That is deferred to a later change.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
      +			item->command = TODO_UPDATE_REF;
      +			strbuf_addf(ctx->buf, "%s\n", decoration->name);
      +
     -+			sti = string_list_append(&ctx->refs_to_oids,
     ++			sti = string_list_insert(&ctx->refs_to_oids,
      +						 decoration->name);
      +			sti->util = oiddup(the_hash_algo->null_oid);
      +		}
     @@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite when in erro
      +		grep "update-ref refs/heads/allow-update" todo
      +	)
      +'
     ++
     ++# This must be the last test in this file
     ++test_expect_success '$EDITOR and friends are unchanged' '
     ++	test_editor_unchanged
     ++'
      +
       test_done
      
  7:  72e0481b643 !  8:  fb5f64c5201 rebase: update refs from 'update-ref' commands
     @@ Commit message
          interactive rebase.
      
          Teach Git to record the HEAD position when reaching these 'update-ref'
     -    commands. The ref/OID pair is stored in the
     +    commands. The ref/before/after triple is stored in the
          $GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
          file to avoid having other processes updating the refs in that file
          while the rebase is in progress.
     @@ Commit message
          Not only do we update the file when the sequencer reaches these
          'update-ref' commands, we then update the refs themselves at the end of
          the rebase sequence. If the rebase is aborted before this final step,
     -    then the refs are not updated.
     +    then the refs are not updated. The 'before' value is used to ensure that
     +    we do not accidentally obliterate a ref that was updated concurrently
     +    (say, by an older version of Git or a third-party tool).
     +
     +    Now that the 'git rebase --update-refs' command is implemented to write
     +    to the update-refs file, we can remove the fake construction of the
     +    update-refs file from a test in t2407-worktree-heads.sh.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ sequencer.c
       
       #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
       
     -@@ sequencer.c: static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
     -  */
     - static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
     +@@ sequencer.c: struct update_ref_record {
     + 	struct object_id after;
     + };
       
     -+/*
     -+ * The update-refs file stores a list of refs that will be updated at the end
     -+ * of the rebase sequence. The 'update-ref <ref>' commands in the todo file
     -+ * update the OIDs for the refs in this file, but the refs are not updated
     -+ * until the end of the rebase sequence.
     -+ */
     -+static GIT_PATH_FUNC(rebase_path_update_refs, "rebase-merge/update-refs")
     -+
     - /*
     -  * The following files are written by git-rebase just after parsing the
     -  * command-line.
     ++static struct update_ref_record *init_update_ref_record(const char *ref)
     ++{
     ++	struct update_ref_record *rec = xmalloc(sizeof(*rec));
     ++
     ++	oidcpy(&rec->before, null_oid());
     ++	oidcpy(&rec->after, null_oid());
     ++
     ++	/* This may fail, but that's fine, we will keep the null OID. */
     ++	read_ref(ref, &rec->before);
     ++
     ++	return rec;
     ++}
     ++
     + static int git_sequencer_config(const char *k, const char *v, void *cb)
     + {
     + 	struct replay_opts *opts = cb;
      @@ sequencer.c: leave_merge:
       	return ret;
       }
       
      -static int do_update_ref(struct repository *r, const char *ref_name)
      +static int write_update_refs_state(struct string_list *refs_to_oids)
     -+{
     + {
      +	int result = 0;
     ++	struct lock_file lock = LOCK_INIT;
      +	FILE *fp = NULL;
      +	struct string_list_item *item;
     -+	char *path = xstrdup(rebase_path_update_refs());
     ++	char *path;
     ++
     ++	if (!refs_to_oids->nr)
     ++		return 0;
     ++
     ++	path = rebase_path_update_refs(the_repository->gitdir);
      +
      +	if (safe_create_leading_directories(path)) {
      +		result = error(_("unable to create leading directories of %s"),
     @@ sequencer.c: leave_merge:
      +		goto cleanup;
      +	}
      +
     -+	fp = fopen(path, "w");
     ++	if (hold_lock_file_for_update(&lock, path, 0) < 0) {
     ++		result = error(_("another 'rebase' process appears to be running; "
     ++				 "'%s.lock' already exists"),
     ++			       path);
     ++		goto cleanup;
     ++	}
     ++
     ++	fp = fdopen_lock_file(&lock, "w");
      +	if (!fp) {
      +		result = error_errno(_("could not open '%s' for writing"), path);
     ++		rollback_lock_file(&lock);
      +		goto cleanup;
      +	}
      +
     -+	for_each_string_list_item(item, refs_to_oids)
     -+		fprintf(fp, "%s\n%s\n", item->string, oid_to_hex(item->util));
     ++	for_each_string_list_item(item, refs_to_oids) {
     ++		struct update_ref_record *rec = item->util;
     ++		fprintf(fp, "%s\n%s\n%s\n", item->string,
     ++			oid_to_hex(&rec->before), oid_to_hex(&rec->after));
     ++	}
     ++
     ++	result = commit_lock_file(&lock);
      +
      +cleanup:
     -+	if (fp)
     -+		fclose(fp);
     ++	free(path);
      +	return result;
      +}
      +
      +static int do_update_ref(struct repository *r, const char *refname)
     - {
     ++{
      +	struct string_list_item *item;
      +	struct string_list list = STRING_LIST_INIT_DUP;
     -+	int found = 0;
      +
      +	sequencer_get_update_refs_state(r->gitdir, &list);
      +
      +	for_each_string_list_item(item, &list) {
      +		if (!strcmp(item->string, refname)) {
     -+			struct object_id oid;
     -+			free(item->util);
     -+			found = 1;
     -+
     -+			if (!read_ref("HEAD", &oid)) {
     -+				item->util = oiddup(&oid);
     -+				break;
     -+			}
     ++			struct update_ref_record *rec = item->util;
     ++			read_ref("HEAD", &rec->after);
     ++			break;
      +		}
      +	}
      +
     -+	if (!found) {
     -+		struct object_id oid;
     -+		item = string_list_append(&list, refname);
     -+
     -+		if (!read_ref("HEAD", &oid))
     -+			item->util = oiddup(&oid);
     -+		else
     -+			item->util = oiddup(the_hash_algo->null_oid);
     -+	}
     -+
      +	write_update_refs_state(&list);
      +	string_list_clear(&list, 1);
       	return 0;
     @@ sequencer.c: leave_merge:
      +	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
      +
      +	for_each_string_list_item(item, &refs_to_oids) {
     -+		struct object_id *oid_to = item->util;
     -+		struct object_id oid_from;
     ++		struct update_ref_record *rec = item->util;
      +
     -+		if (oideq(oid_to, the_hash_algo->null_oid)) {
     ++		if (oideq(&rec->after, the_hash_algo->null_oid)) {
      +			/*
      +			 * Ref was not updated. User may have deleted the
      +			 * 'update-ref' step.
     @@ sequencer.c: leave_merge:
      +			continue;
      +		}
      +
     -+		if (read_ref(item->string, &oid_from)) {
     -+			/*
     -+			 * The ref does not exist. The user probably
     -+			 * inserted a new 'update-ref' step with a new
     -+			 * branch name.
     -+			 */
     -+			oidcpy(&oid_from, the_hash_algo->null_oid);
     -+		}
     -+
      +		res |= refs_update_ref(refs, "rewritten during rebase",
     -+				item->string,
     -+				oid_to, &oid_from,
     -+				0, UPDATE_REFS_MSG_ON_ERR);
     ++				       item->string,
     ++				       &rec->after, &rec->before,
     ++				       0, UPDATE_REFS_MSG_ON_ERR);
      +	}
      +
      +	string_list_clear(&refs_to_oids, 1);
     @@ sequencer.c: cleanup_head_ref:
       	/*
       	 * Sequence of picks finished successfully; cleanup by
       	 * removing the .git/sequencer directory
     +@@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
     + 
     + 			sti = string_list_insert(&ctx->refs_to_oids,
     + 						 decoration->name);
     +-			sti->util = oiddup(the_hash_algo->null_oid);
     ++			sti->util = init_update_ref_record(decoration->name);
     + 		}
     + 
     + 		item->offset_in_buf = base_offset;
      @@ sequencer.c: static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
       		}
       	}
     @@ sequencer.c: static int todo_list_add_update_ref_commands(struct todo_list *todo
       	free(todo_list->items);
       	todo_list->items = ctx.items;
      
     + ## t/t2407-worktree-heads.sh ##
     +@@ t/t2407-worktree-heads.sh: test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
     + 	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
     + '
     + 
     +-test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
     +-	test_when_finished rm -rf .git/worktrees/wt-3/rebase-merge &&
     +-
     +-	mkdir -p .git/worktrees/wt-3/rebase-merge &&
     +-	touch .git/worktrees/wt-3/rebase-merge/interactive &&
     ++test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase with --update-refs' '
     ++	test_when_finished git -C wt-3 rebase --abort &&
     + 
     +-	cat >.git/worktrees/wt-3/rebase-merge/update-refs <<-EOF &&
     +-	refs/heads/fake-3
     +-	$(git rev-parse HEAD~1)
     +-	$(git rev-parse HEAD)
     +-	refs/heads/fake-4
     +-	$(git rev-parse HEAD)
     +-	$(git rev-parse HEAD)
     +-	EOF
     ++	git branch -f can-be-updated wt-3 &&
     ++	test_must_fail git -C wt-3 rebase --update-refs conflict-3 &&
     + 
     + 	for i in 3 4
     + 	do
     +-		test_must_fail git branch -f fake-$i HEAD 2>err &&
     +-		grep "cannot force update the branch '\''fake-$i'\'' checked out at.*wt-3" err ||
     ++		test_must_fail git branch -f can-be-updated HEAD 2>err &&
     ++		grep "cannot force update the branch '\''can-be-updated'\'' checked out at.*wt-3" err ||
     + 			return 1
     + 	done
     + '
     +
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs adds commands with --rebase-merges' '
       	)
       '
       
     -+compare_two_refs () {
     -+	git rev-parse $1 >expect &&
     -+	git rev-parse $2 >actual &&
     -+	test_cmp expect actual
     -+}
     -+
      +test_expect_success '--update-refs updates refs correctly' '
      +	git checkout -B update-refs no-conflict-branch &&
      +	git branch -f base HEAD~4 &&
     @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs adds commands
      +
      +	git rebase -i --autosquash --update-refs primary &&
      +
     -+	compare_two_refs HEAD~3 refs/heads/first &&
     -+	compare_two_refs HEAD~3 refs/heads/second &&
     -+	compare_two_refs HEAD~1 refs/heads/third &&
     -+	compare_two_refs HEAD refs/heads/no-conflict-branch
     ++	test_cmp_rev HEAD~3 refs/heads/first &&
     ++	test_cmp_rev HEAD~3 refs/heads/second &&
     ++	test_cmp_rev HEAD~1 refs/heads/third &&
     ++	test_cmp_rev HEAD refs/heads/no-conflict-branch
      +'
      +
       # This must be the last test in this file
  -:  ----------- >  9:  29c7c76805a sequencer: rewrite update-refs as user edits todo list
  8:  d2cfdbfc431 = 10:  c0022d07579 rebase: add rebase.updateRefs config option
  -:  ----------- > 11:  d53b4ff2cee sequencer: ignore HEAD ref under --update-refs
  -:  ----------- > 12:  d5cd4b49e46 sequencer: notify user of --update-refs activity

-- 
gitgitgadget
