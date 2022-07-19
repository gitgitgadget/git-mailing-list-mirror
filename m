Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E977C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiGSSdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGSSdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:33:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2065A2DD
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d8so2943489wrp.6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ylXpipMXDbL+SVwfRZyJsFz1yK9QF6Qt56DmviEPiAU=;
        b=ErL4uDGoRo8TM1ITPCdf3/80e4wyCc47cr67Hck7YFgDqbxzm9uY3VcGb+F3314TP6
         u2Mj3Fit8VxGKkn2xS8qYB+r5tP6pmcE+hbNo+9yiwBuKXqorxyNipII4KGzPD+3BKHj
         BZ3oNUMnwKstHPgR/hE3tTk/WM6VQFJvNsYdpQlC1ySdB9U1UZ1sfrAHLAd4yzFHPQur
         rF01zeubJRZvATuUeWQtT1StL8eICHN4wxCcmoLBBUlqKWdDxOhYx9igLU4jRHhezL8D
         usFu1vRkGfpISzsXvrpKx78CwBKP00X3GClnqH0RcVo0sxNcnSZCDoOXT9E3f/oO+n3F
         LueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ylXpipMXDbL+SVwfRZyJsFz1yK9QF6Qt56DmviEPiAU=;
        b=Nm+YTZkv9sgBGdy+6vR56w/vkK0eAXsEfSol6wP0VkeU7GhtBwnw+qu9rlL1MUZY0d
         PgtJB52Yh8L6Wadz81wsQCnK7KAJdnJu2VQANIDTy62FzNagetMh+6yMeVkgVDtGMbzx
         dUuz4/0ZDgXxnhbzqvFMOcDMhv12tEAfMNPjwMZ/ircpiOIu7XvCT6iFE1HU2m25pF45
         jDJAFUl434Bp0GMFyY3bkCQKfMHrULS0MxySgUI83qiRnrRSz+3LWN7281On8O0gcfff
         DUySV4pbb+Dk4ejfiArxiYzEaBvYgEduR0Ec1bIWqY368Mmk7HiN3rXrC0JMsHzcgGkd
         g35Q==
X-Gm-Message-State: AJIora/JhjG/LzjsFp+yJHQlLANvx8B8d43FXSQVxHzG6Me8tXcP3Fhx
        pXGiEt8iEM2HkPjkOb9RBmoFOMc+6DM=
X-Google-Smtp-Source: AGRyM1uMzJQaO7TiQ0raG1h1FvNQuvL1L7h/TC/KW0w+N4D0Q+cFNVrFXDNZ0M8SSJlAw0kUdWvWmQ==
X-Received: by 2002:adf:f043:0:b0:21d:6a90:f3e6 with SMTP id t3-20020adff043000000b0021d6a90f3e6mr27998379wro.277.1658255626181;
        Tue, 19 Jul 2022 11:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0560001f8300b0021d70a871cbsm13599003wrb.32.2022.07.19.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:45 -0700 (PDT)
Message-Id: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:32 +0000
Subject: [PATCH v5 00/12] rebase: update branches in multi-part topic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
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

During review, we have identified some areas that would be good for
#leftoverbits:

 * Warn the user when they add an 'update-ref ' command but is checked out
   in another worktree.
 * The checks in patch 9 are quadratic. They could be sped up using
   hashtables.
 * Consider whether we should include an 'update-ref ' command for the HEAD
   ref, so that all refs are updated in the same way. This might help
   confused users.
 * The error message for failed ref updates could include information on the
   commit IDs that would have been used. This can help the user fix the
   situation by updating the refs manually.
 * Modify the --update-refs option from a boolean to an
   optionally-string-parameter that specifies refspecs for the 'update-ref'
   commands.


Updates in v5
=============

 * Rename 'wt_dir' to 'wt_git_dir' for clarity.
 * The documented behavior around 'fixup!' and 'squash!' commits was
   incorrect, so update the commit message, documentation, and test to
   demonstrate the actual behavior.
 * Use CALLOC_ARRAY() to be more idiomatic.
 * Be much more careful about propagating errors.
 * Commit message typo: "We an" to "We can"
 * Remove unnecessary null OID check when writing refs, since those would
   already be removed by a previous step.


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
 Documentation/git-rebase.txt    |  10 +
 branch.c                        |  13 +
 builtin/rebase.c                |  10 +
 rebase-interactive.c            |  15 +-
 sequencer.c                     | 474 +++++++++++++++++++++++++++++++-
 sequencer.h                     |  23 ++
 t/lib-rebase.sh                 |  15 +
 t/t2407-worktree-heads.sh       | 103 +++++--
 t/t3404-rebase-interactive.sh   | 273 ++++++++++++++++++
 10 files changed, 895 insertions(+), 44 deletions(-)


base-commit: 9bef0b1e6ec371e786c2fba3edcc06ad040a536c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1247%2Fderrickstolee%2Frebase-keep-decorations-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1247/derrickstolee/rebase-keep-decorations-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1247

Range-diff vs v4:

  1:  9e53a27017a =  1:  9e53a27017a t2407: test bisect and rebase as black-boxes
  2:  540a3be256f =  2:  540a3be256f t2407: test branches currently using apply backend
  3:  bf301a054e3 !  3:  1089a0edb73 branch: consider refs under 'update-refs'
     @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-
      + * rebase_path_update_refs() returns the path to this file for a given
      + * worktree directory. For the current worktree, pass the_repository->gitdir.
      + */
     -+static char *rebase_path_update_refs(const char *wt_dir)
     ++static char *rebase_path_update_refs(const char *wt_git_dir)
      +{
     -+	return xstrfmt("%s/rebase-merge/update-refs", wt_dir);
     ++	return xstrfmt("%s/rebase-merge/update-refs", wt_git_dir);
      +}
      +
       /*
  4:  dec95681d2b =  4:  d1cce4f06aa rebase-interactive: update 'merge' description
  5:  b2c09600918 =  5:  4c086d477f0 sequencer: define array with enum values
  6:  fa7ecb718cf =  6:  7b3d6601960 sequencer: add update-ref command
  7:  3ec2cc922f9 !  7:  7efb55e4f14 rebase: add --update-refs option
     @@ Commit message
          --fixup commit at the tip of the feature to apply correctly to the sub
          branch, even if it is fixing up the most-recent commit in that part.
      
     -    One potential problem here is that refs decorating commits that are
     -    already marked as "fixup!" or "squash!" will not be included in this
     -    list. Generally, the reordering of the "fixup!" and "squash!" is likely
     -    to change the relative order of these refs, so it is not recommended.
     -    The workflow here is intended to allow these kinds of commits at the tip
     -    of the rebased branch while the other sub branches come along for the
     -    ride without intervention.
     -
          This change update the documentation and builtin to accept the
          --update-refs option as well as updating the todo file with the
          'update-ref' commands. Tests are added to ensure that these todo
     @@ Documentation/git-rebase.txt: provided. Otherwise an explicit `--no-reschedule-f
      +--no-update-refs::
      +	Automatically force-update any branches that point to commits that
      +	are being rebased. Any branches that are checked out in a worktree
     -+	or point to a `squash! ...` or `fixup! ...` commit are not updated
     -+	in this way.
     ++	are not updated in this way.
      +
       INCOMPATIBLE OPTIONS
       --------------------
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       			 N_("move commits that begin with "
       			    "squash!/fixup! under -i")),
      +		OPT_BOOL(0, "update-refs", &options.update_refs,
     -+			 N_("update local refs that point to commits "
     ++			 N_("update branches that point to commits "
      +			    "that are being rebased")),
       		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
       			N_("GPG-sign commits"),
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'ORIG_HEAD is updated correct
      +	git branch -f second HEAD~3 &&
      +	git branch -f third HEAD~1 &&
      +	git commit --allow-empty --fixup=third &&
     ++	git branch -f is-not-reordered &&
     ++	git commit --allow-empty --fixup=HEAD~4 &&
      +	git branch -f shared-tip &&
      +	(
      +		set_cat_todo_editor &&
      +
      +		cat >expect <<-EOF &&
      +		pick $(git log -1 --format=%h J) J
     ++		fixup $(git log -1 --format=%h update-refs) fixup! J # empty
      +		update-ref refs/heads/second
      +		update-ref refs/heads/first
      +		pick $(git log -1 --format=%h K) K
      +		pick $(git log -1 --format=%h L) L
     -+		fixup $(git log -1 --format=%h update-refs) fixup! L # empty
     ++		fixup $(git log -1 --format=%h is-not-reordered) fixup! L # empty
      +		update-ref refs/heads/third
      +		pick $(git log -1 --format=%h M) M
      +		update-ref refs/heads/no-conflict-branch
     ++		update-ref refs/heads/is-not-reordered
      +		update-ref refs/heads/shared-tip
      +		EOF
      +
  8:  fb5f64c5201 !  8:  e7a91bdffbd rebase: update refs from 'update-ref' commands
     @@ sequencer.c: struct update_ref_record {
       
      +static struct update_ref_record *init_update_ref_record(const char *ref)
      +{
     -+	struct update_ref_record *rec = xmalloc(sizeof(*rec));
     ++	struct update_ref_record *rec;
     ++
     ++	CALLOC_ARRAY(rec, 1);
      +
      +	oidcpy(&rec->before, null_oid());
      +	oidcpy(&rec->after, null_oid());
     @@ sequencer.c: leave_merge:
       
      -static int do_update_ref(struct repository *r, const char *ref_name)
      +static int write_update_refs_state(struct string_list *refs_to_oids)
     - {
     ++{
      +	int result = 0;
      +	struct lock_file lock = LOCK_INIT;
      +	FILE *fp = NULL;
     @@ sequencer.c: leave_merge:
      +}
      +
      +static int do_update_ref(struct repository *r, const char *refname)
     -+{
     + {
      +	struct string_list_item *item;
      +	struct string_list list = STRING_LIST_INIT_DUP;
      +
     -+	sequencer_get_update_refs_state(r->gitdir, &list);
     ++	if (sequencer_get_update_refs_state(r->gitdir, &list))
     ++		return -1;
      +
      +	for_each_string_list_item(item, &list) {
      +		if (!strcmp(item->string, refname)) {
      +			struct update_ref_record *rec = item->util;
     -+			read_ref("HEAD", &rec->after);
     ++			if (read_ref("HEAD", &rec->after))
     ++				return -1;
      +			break;
      +		}
      +	}
     @@ sequencer.c: leave_merge:
      +	struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
      +	struct ref_store *refs = get_main_ref_store(r);
      +
     -+	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
     ++	if ((res = sequencer_get_update_refs_state(r->gitdir, &refs_to_oids)))
     ++		return res;
      +
      +	for_each_string_list_item(item, &refs_to_oids) {
      +		struct update_ref_record *rec = item->util;
      +
     -+		if (oideq(&rec->after, the_hash_algo->null_oid)) {
     -+			/*
     -+			 * Ref was not updated. User may have deleted the
     -+			 * 'update-ref' step.
     -+			 */
     -+			continue;
     -+		}
     -+
      +		res |= refs_update_ref(refs, "rewritten during rebase",
      +				       item->string,
      +				       &rec->after, &rec->before,
     @@ sequencer.c: leave_merge:
       {
       	int i = todo_list->current;
      @@ sequencer.c: cleanup_head_ref:
     + 
     + 		strbuf_release(&buf);
       		strbuf_release(&head_ref);
     ++
     ++		if (do_update_refs(r))
     ++			return -1;
       	}
       
     -+	do_update_refs(r);
     -+
       	/*
     - 	 * Sequence of picks finished successfully; cleanup by
     - 	 * removing the .git/sequencer directory
      @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       
       			sti = string_list_insert(&ctx->refs_to_oids,
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       		}
       
       		item->offset_in_buf = base_offset;
     +@@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
     +  */
     + static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
     + {
     +-	int i;
     ++	int i, res;
     + 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
     + 	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
     + 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
      @@ sequencer.c: static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
       		}
       	}
       
     -+	write_update_refs_state(&ctx.refs_to_oids);
     ++	res = write_update_refs_state(&ctx.refs_to_oids);
      +
       	string_list_clear(&ctx.refs_to_oids, 1);
     ++
     ++	if (res) {
     ++		/* we failed, so clean up the new list. */
     ++		free(ctx.items);
     ++		return res;
     ++	}
     ++
       	free(todo_list->items);
       	todo_list->items = ctx.items;
     + 	todo_list->nr = ctx.items_nr;
      
       ## t/t2407-worktree-heads.sh ##
      @@ t/t2407-worktree-heads.sh: test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (mer
  9:  29c7c76805a !  9:  95e2bbcedb1 sequencer: rewrite update-refs as user edits todo list
     @@ Commit message
      
          We can test that this works by rewriting the todo-list several times in
          the course of a rebase. Check that each ref is locked or unlocked for
     -    updates after each todo-list update. We an also verify that the ref
     +    updates after each todo-list update. We can also verify that the ref
          update fails if a concurrent process updates one of the refs after the
          rebase process records the "locked" ref location.
      
 10:  c0022d07579 ! 10:  a73b02568f3 rebase: add rebase.updateRefs config option
     @@ Documentation/config/rebase.txt: rebase.autoStash::
      
       ## Documentation/git-rebase.txt ##
      @@ Documentation/git-rebase.txt: start would be overridden by the presence of
     + 	Automatically force-update any branches that point to commits that
       	are being rebased. Any branches that are checked out in a worktree
     - 	or point to a `squash! ...` or `fixup! ...` commit are not updated
     - 	in this way.
     + 	are not updated in this way.
      ++
      +If the configuration variable `rebase.updateRefs` is set, then this option
      +can be used to override and disable this setting.
 11:  d53b4ff2cee = 11:  2a6577974c7 sequencer: ignore HEAD ref under --update-refs
 12:  d5cd4b49e46 ! 12:  ec080ce1e90 sequencer: notify user of --update-refs activity
     @@ sequencer.c: static int do_update_ref(struct repository *r, const char *refname)
      +	struct strbuf update_msg = STRBUF_INIT;
      +	struct strbuf error_msg = STRBUF_INIT;
       
     - 	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
     + 	if ((res = sequencer_get_update_refs_state(r->gitdir, &refs_to_oids)))
     + 		return res;
       
       	for_each_string_list_item(item, &refs_to_oids) {
       		struct update_ref_record *rec = item->util;
      +		int loop_res;
       
     - 		if (oideq(&rec->after, the_hash_algo->null_oid)) {
     - 			/*
     -@@ sequencer.c: static int do_update_refs(struct repository *r)
     - 			continue;
     - 		}
     - 
      -		res |= refs_update_ref(refs, "rewritten during rebase",
      -				       item->string,
      -				       &rec->after, &rec->before,
     @@ sequencer.c: static int do_update_refs(struct repository *r)
       }
       
      @@ sequencer.c: cleanup_head_ref:
     + 		strbuf_release(&buf);
       		strbuf_release(&head_ref);
     - 	}
       
     --	do_update_refs(r);
     -+	do_update_refs(r, opts->quiet);
     +-		if (do_update_refs(r))
     ++		if (do_update_refs(r, opts->quiet))
     + 			return -1;
     + 	}
       
     - 	/*
     - 	 * Sequence of picks finished successfully; cleanup by
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs updates refs correctly' '
     @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs updates refs c
       
       test_expect_success 'respect user edits to update-ref steps' '
      @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs: check failed ref update' '
     + 	# the lock in the update-refs file.
       	git rev-parse third >.git/refs/heads/second &&
       
     - 	git rebase --continue 2>err &&
     +-	git rebase --continue 2>err &&
      -	grep "update_ref failed for ref '\''refs/heads/second'\''" err
     ++	test_must_fail git rebase --continue 2>err &&
      +	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
      +
      +	cat >expect <<-\EOF &&

-- 
gitgitgadget
