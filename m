Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785C4CCDF1
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256206; cv=none; b=OvmEs1EE8WIOgOdTvJ56SLV3aklcO9Lwmjjtuh0fkqB3f0QVBD9YH79e2A4xFvSSzzhrhkHtLojR7dBTOoP6WBeAdIMbqasRqnhT7cSlyah0IATxxh8ZpS/luq49TuSkbk8h99WUhRHudc7J9apwuWctlcnTnY/JSSiUehWWKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256206; c=relaxed/simple;
	bh=SCWkN0n+QX3iZXTGp0H7CP5sVVHtWYzSFhlENHUOAPo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uOv1Uf9JF+Q4F2IU3S8QGuenL1oK9ehDvDe0/m6gb+xAmQBq6AMPZwT4PbsYUjJWj+foxtYU8AdL71KGcxeIQOSJYygmUzxhY2OzlOgWD4XrYmtsqCBSA+LXYO2lk25cwbZYvhrcMpFNZ4dIOvN5h3LThXX7eWcB0lVXmou8DAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9BKsYXw; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9BKsYXw"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f4df360cc9so1076546a34.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788256201; x=1788861001; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WoEhqlocjwJRjtx89eRtXCB71xZgjDsARRiYDJOQFGA=;
        b=o9BKsYXw+Ir9Cw1UXuD+t6Q40FqLdA6/ufYtqdvWzxobzTHz52zvGX2UBTVNnrm+s2
         QrnwT46yUMdazvZdoPlvkfJEcP58MOeqHRZEdIaAcHLAmLpUnwvyKz6z5lQMqHCc+Jz/
         MsSVb2iUsbYeEBYIq8S0cLw2VALew4d+t9DM98EnELd0anzGfnQWrSjCkJK6x+qh97TH
         c6HUzO9u9sDrXZumuzICR/EB25PspczLavVpRjtPpaz8d0yBE/Y6XBGe+ACjWnfZYaaR
         FLX0Ni5bQrd1ooj2QaFgbJO2lalsBGGOv45QNBKNbXq8v7g+VIn2t65oWN5MtS7C+NlV
         tEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788256201; x=1788861001;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoEhqlocjwJRjtx89eRtXCB71xZgjDsARRiYDJOQFGA=;
        b=pXPXWmLyNFEVzubg8WfOkJq5vSk/B4k0qlxkpASMlvIYX3HlM5ptGlgy5lOw5i4MyS
         aTGglyHJqnh0B/aSrYRTTvpZngAmdSx8YQAZ+oI2XqJRqlQ1BxE99UDJc7zYVjd0jbDn
         9U6HjTZvFbbKns1i9fP1XdcnQEyNx9viFncoJutHDpIEMmK4rVlrDSTCxit9kydoVcI1
         jNMfA36IGirGya6ZXh+uA1Be8CEOd88U9+VH912oP9ab3PPYVuSnFD05QQWJyuHKZ0v4
         vUW6kYH4ds1LM0DuV/bfZGTGf8Mpj8LN1SEIq4Gx1wx5CeQ5PXvs8giicqzcXAChDhSI
         w3Yw==
X-Gm-Message-State: AFuF++nSEFIUBXCkDTgG5UlqhAQ+rqiGpkix/6Ya4iG8B2b4ttP8CGZ3
	hbcnUacP8ExSZG/BoSkBNamB9vVV+IXXnrowRzaFkUtEo3WySRg1piU2UQE2hQ==
X-Gm-Gg: AR+sD10QlNw5c05rYkRHmiVHgKh60A6HizQYPahB7B+wdoN/4bSCRRYR6GW47PLnno7
	gxkrcfECddv0DD/EscMempW0rUzaQ4/hxY2FsFZpWuPQWfABrcpuyrRmQL3Kciz0G74P1VMDbbu
	vFJ+tLOQXVdS6XQY9GVUG0apdAN4Iwxdb9JUlV2c0cO/GW7Gix7n6u40eedlEe0D9s7gZZYMPs2
	Sm7C4CTlp0FlRhylH8QUI+mcQKCAn21ow2MPFVpyfZoj0wi8h8Frlac/jlDYoeAflYB4vh9dgNE
	bIjKkw6tDjNPW8ia9WV1/vyzWui3HBZg6Q9LeTTbLm1/wG1L2TuO4L5pSFEAIFGVROQ25eUz3Mm
	TfLVFXIr5/qTQ4bEjiUhNxGhWvacYgl3HcYWd7H252bZ2am4dzUcCxcy7nuCy32Z5fzVvsDKlXX
	PZNqlapRVWnxLeGQKYYlQuaLDZ0U4AGaLQGNJIjBNdNXfLbp2BcWjp1JvzbhyNfmDS
X-Received: by 2002:a9d:6e1a:0:b0:7e9:b2cb:26f9 with SMTP id 46e09a7af769-7f68f562384mr3097569a34.3.1788256200995;
        Tue, 01 Sep 2026 02:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.214.26])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa7e92c1sm10338816a34.8.2026.09.01.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:50:00 -0700 (PDT)
Message-Id: <pull.2364.v3.git.git.1788256199679.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 09:49:59 +0000
Subject: [PATCH v3] checkout: separate autostash conflict advice from
 branch-switch message
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git checkout -m" stashes the user's local changes when it cannot
perform the checkout, and then applies the stash.  When applying the
stash results in conflicts, the advice on how to deal with them is
printed directly on top of the branch-switch message ("Switched to
branch ..."), making the two hard to tell apart.  Print a blank line
in between so that the advice and the branch-switch message are
visually distinct.

To make this possible, "git stash apply", "pop" and "branch" now exit
with status 2 when applying the stash entry resulted in conflicts, in
which case the stash entry is left in place; other failures exit with
status 1, as before.  The exit statuses are documented in the "git
stash" documentation.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout -m: refine autostash fallback
    
    Avoiding checkout -m autostash retries when no tracked local changes
    exist and visually separating autostash conflict advice from the
    subsequent branch-switch message. Addresses #leftoverbits from here:
    https://lore.kernel.org/git/cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com/
    
    Changes in v3:
    
     * Use enum for git stash return values, to separate conflict from
       generic error.
    
    Changes in v2:
    
     * Simplify logic and combine to one commit.
     * Test full output with test_cmp.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2364%2FHaraldNordgren%2Fhn%2Fgit-checkout-m-leftoverbits-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2364/HaraldNordgren/hn/git-checkout-m-leftoverbits-v3
Pull-Request: https://github.com/git/git/pull/2364

Range-diff vs v2:

 1:  b44c53fcf2 ! 1:  8e1979dd6c checkout: print blank line after autostash conflict advice
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    checkout: print blank line after autostash conflict advice
     +    checkout: separate autostash conflict advice from branch-switch message
      
     -    When "git checkout -m" stashes the user's local changes and then fails
     -    to re-apply them because of conflicts, the conflict advice is printed
     -    directly on top of the branch-switch message ("Switched to branch ..."),
     -    making the two messages hard to tell apart.  Print a blank line in
     -    between when the stash apply conflicted, so that the advice and the
     -    branch-switch message are visually distinct.
     +    "git checkout -m" stashes the user's local changes when it cannot
     +    perform the checkout, and then applies the stash.  When applying the
     +    stash results in conflicts, the advice on how to deal with them is
     +    printed directly on top of the branch-switch message ("Switched to
     +    branch ..."), making the two hard to tell apart.  Print a blank line
     +    in between so that the advice and the branch-switch message are
     +    visually distinct.
      
     -    To learn whether the stash apply resulted in conflicts, make the
     -    autostash apply functions return 1 when the stash could not be applied
     -    due to conflicts (and was stored back), while success and error remain
     -    0 and -1 respectively.  Checkout can then use the return value to decide
     -    whether to print the blank line.
     +    To make this possible, "git stash apply", "pop" and "branch" now exit
     +    with status 2 when applying the stash entry resulted in conflicts, in
     +    which case the stash entry is left in place; other failures exit with
     +    status 1, as before.  The exit statuses are documented in the "git
     +    stash" documentation.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## Documentation/git-stash.adoc ##
     +@@ Documentation/git-stash.adoc: include::includes/cmd-config-section-all.adoc[]
     + :git-stash: 1
     + include::config/stash.adoc[]
     + 
     ++EXIT STATUS
     ++-----------
     ++
     ++The `git stash` subcommands exit with status 0 on success and non-zero
     ++on failure.  The subcommands that apply a stash entry, i.e. `apply`,
     ++`pop` and `branch`, exit with status 2 when applying the stash entry
     ++resulted in conflicts, in which case the stash entry is left in place.
     ++Other failures exit with status 1 (usage errors exit with status 129).
     ++
     + 
     + SEE ALSO
     + --------
     +
       ## builtin/checkout.c ##
      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	int flag, writeout_error = 0;
       	int do_merge = 1;
       	int created_autostash = 0;
     -+	int autostash_res = 0;
     ++	enum stash_apply_result autostash_res = STASH_APPLY_CLEAN;
       	struct strbuf old_commit_shortname = STRBUF_INIT;
       	struct strbuf autostash_msg = STRBUF_INIT;
       	const char *stash_label_base = NULL;
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
       		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
       
     -+	if (autostash_res == 1 && !opts->quiet)
     ++	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
      +		fputc('\n', stderr);
       	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
       
       	if (created_autostash) {
      
     + ## builtin/stash.c ##
     +@@
     + #include "object-name.h"
     + #include "parse-options.h"
     + #include "refs.h"
     ++#include "stash.h"
     + #include "lockfile.h"
     + #include "cache-tree.h"
     + #include "unpack-trees.h"
     +@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     + 		die(_("could not write index"));
     + }
     + 
     +-static int do_apply_stash(const char *prefix, struct stash_info *info,
     +-			  int index, int quiet,
     ++static enum stash_apply_result do_apply_stash(const char *prefix,
     ++					      struct stash_info *info,
     ++					      int index, int quiet,
     + 			  const char *label_ours, const char *label_theirs,
     + 			  const char *label_base)
     + {
     +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     + 	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);
     + 
     + 	/*
     +-	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
     +-	 * merge was clean, and nonzero if the merge was unclean or encountered
     +-	 * an error.
     ++	 * Translate the value of 'clean' so 'ret' is STASH_APPLY_CLEAN
     ++	 * when the merge was clean, STASH_APPLY_CONFLICT when it was
     ++	 * unclean, and a negative value if it encountered an error.
     + 	 */
     +-	ret = clean >= 0 ? !clean : clean;
     ++	ret = clean >= 0 ? (clean ? STASH_APPLY_CLEAN : STASH_APPLY_CONFLICT)
     ++			 : clean;
     + 
     + 	if (ret < 0)
     + 		rollback_lock_file(&lock);
     +@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     + 
     + 	if (has_index) {
     + 		if (reset_tree(&index_tree, 0, 0))
     +-			ret = -1;
     ++			ret = STASH_APPLY_ERROR;
     + 	} else {
     + 		unstage_changes_unless_new(&c_tree);
     + 	}
     +@@ builtin/stash.c: int cmd_stash(int argc,
     + 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
     + 		    (uintmax_t)pid);
     + 
     +-	if (fn)
     +-		return !!fn(argc, argv, prefix, repo);
     +-	else if (!argc)
     ++	if (fn) {
     ++		ret = fn(argc, argv, prefix, repo);
     ++
     ++		if (ret < 0)
     ++			return 1;
     ++		return ret;
     ++	} else if (!argc)
     + 		return !!push_stash_unassumed(0, NULL, prefix, repo);
     + 
     + 	/* Assume 'stash push' */
     +
       ## sequencer.c ##
     +@@
     + #include "commit.h"
     + #include "sequencer.h"
     + #include "run-command.h"
     ++#include "stash.h"
     + #include "hook.h"
     + #include "utf8.h"
     + #include "cache-tree.h"
     +@@ sequencer.c: void create_autostash_ref(struct repository *r, const char *refname,
     + 	create_autostash_internal(r, NULL, refname, message, silent);
     + }
     + 
     +-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     +-				    const char *label_ours, const char *label_theirs,
     +-				    const char *label_base,
     +-				    const char *stash_msg)
     ++static enum stash_apply_result apply_save_autostash_oid(const char *stash_oid,
     ++							int attempt_apply,
     ++							const char *label_ours,
     ++							const char *label_theirs,
     ++							const char *label_base,
     ++							const char *stash_msg)
     + {
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +-	int ret = 0;
     ++	enum stash_apply_result ret = STASH_APPLY_CLEAN;
     + 
     + 	if (attempt_apply) {
     + 		child.git_cmd = 1;
      @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     - 		if (label_base)
       			strvec_pushf(&child.args, "--label-base=%s", label_base);
       		strvec_push(&child.args, stash_oid);
     --		ret = run_command(&child);
     -+		if (run_command(&child))
     -+			ret = 1;
     + 		ret = run_command(&child);
     ++		if (ret && ret != STASH_APPLY_CONFLICT)
     ++			ret = STASH_APPLY_ERROR;
       	}
       
     - 	if (attempt_apply && !ret)
     +-	if (attempt_apply && !ret)
     ++	if (attempt_apply && ret == STASH_APPLY_CLEAN)
     + 		fprintf(stderr, _("Applied autostash.\n"));
     + 	else {
     + 		struct child_process store = CHILD_PROCESS_INIT;
     +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     + 		strvec_push(&store.args, stash_oid);
     + 		if (run_command(&store))
     + 			ret = error(_("cannot store %s"), stash_oid);
     +-		else if (attempt_apply)
     ++		else if (attempt_apply && ret == STASH_APPLY_CONFLICT)
     + 			fprintf(stderr,
     + 				_("Your local changes are stashed, however applying them\n"
     + 				  "resulted in conflicts.  You can either resolve the conflicts\n"
     + 				  "and then discard the stash with \"git stash drop\", or, if you\n"
     + 				  "do not want to resolve them now, run \"git reset --hard\" and\n"
     + 				  "apply the local changes later by running \"git stash pop\".\n"));
     ++		else if (attempt_apply)
     ++			ret = error(_("could not apply autostash"));
     + 		else
     + 			fprintf(stderr,
     + 				_("Autostash exists; creating a new stash entry.\n"
     +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     + 	return ret;
     + }
     + 
     +-static int apply_save_autostash(const char *path, int attempt_apply)
     ++static enum stash_apply_result apply_save_autostash(const char *path,
     ++						    int attempt_apply)
     + {
     + 	struct strbuf stash_oid = STRBUF_INIT;
     +-	int ret = 0;
     ++	enum stash_apply_result ret = STASH_APPLY_CLEAN;
     + 
     + 	if (!read_oneliner(&stash_oid, path,
     + 			   READ_ONELINER_SKIP_IF_EMPTY)) {
     + 		strbuf_release(&stash_oid);
     +-		return 0;
     ++		return STASH_APPLY_CLEAN;
     + 	}
     + 	strbuf_trim(&stash_oid);
     + 
     +@@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
     + 	return ret;
     + }
     + 
     +-int save_autostash(const char *path)
     ++enum stash_apply_result save_autostash(const char *path)
     + {
     + 	return apply_save_autostash(path, 0);
     + }
     + 
     +-int apply_autostash(const char *path)
     ++enum stash_apply_result apply_autostash(const char *path)
     + {
     + 	return apply_save_autostash(path, 1);
     + }
     + 
     +-int apply_autostash_oid(const char *stash_oid)
     ++enum stash_apply_result apply_autostash_oid(const char *stash_oid)
     + {
     + 	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
     + }
     + 
     +-static int apply_save_autostash_ref(struct repository *r, const char *refname,
     +-				    int attempt_apply,
     +-				    const char *label_ours, const char *label_theirs,
     +-				    const char *label_base,
     +-				    const char *stash_msg)
     ++static enum stash_apply_result apply_save_autostash_ref(struct repository *r,
     ++							const char *refname,
     ++							int attempt_apply,
     ++							const char *label_ours,
     ++							const char *label_theirs,
     ++							const char *label_base,
     ++							const char *stash_msg)
     + {
     + 	struct object_id stash_oid;
     + 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
     +-	int flag, ret;
     ++	int flag;
     ++	enum stash_apply_result ret;
     + 
     + 	if (!refs_ref_exists(get_main_ref_store(r), refname))
     +-		return 0;
     ++		return STASH_APPLY_CLEAN;
     + 
     + 	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname,
     + 				     RESOLVE_REF_READING, &stash_oid, &flag))
     +-		return -1;
     ++		return STASH_APPLY_ERROR;
     + 	if (flag & REF_ISSYMREF)
     + 		return error(_("autostash reference is a symref"));
     + 
     +@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     + 	return ret;
     + }
     + 
     +-int save_autostash_ref(struct repository *r, const char *refname)
     ++enum stash_apply_result save_autostash_ref(struct repository *r,
     ++					   const char *refname)
     + {
     + 	return apply_save_autostash_ref(r, refname, 0,
     + 					NULL, NULL, NULL, NULL);
     + }
     + 
     +-int apply_autostash_ref(struct repository *r, const char *refname,
     +-			const char *label_ours, const char *label_theirs,
     +-			const char *label_base, const char *stash_msg)
     ++enum stash_apply_result apply_autostash_ref(struct repository *r,
     ++					    const char *refname,
     ++					    const char *label_ours,
     ++					    const char *label_theirs,
     ++					    const char *label_base,
     ++					    const char *stash_msg)
     + {
     + 	return apply_save_autostash_ref(r, refname, 1,
     + 					label_ours, label_theirs, label_base,
     +
     + ## sequencer.h ##
     +@@
     + 
     + #include "strbuf.h"
     + #include "strvec.h"
     ++#include "stash.h"
     + #include "wt-status.h"
     + 
     + struct commit;
     +@@ sequencer.h: void commit_post_rewrite(struct repository *r,
     + void create_autostash(struct repository *r, const char *path);
     + void create_autostash_ref(struct repository *r, const char *refname,
     + 			  const char *message, bool silent);
     +-int save_autostash(const char *path);
     +-int save_autostash_ref(struct repository *r, const char *refname);
     +-int apply_autostash(const char *path);
     +-int apply_autostash_oid(const char *stash_oid);
     +-int apply_autostash_ref(struct repository *r, const char *refname,
     +-			const char *label_ours, const char *label_theirs,
     +-			const char *label_base, const char *stash_msg);
     ++enum stash_apply_result save_autostash(const char *path);
     ++enum stash_apply_result save_autostash_ref(struct repository *r,
     ++					   const char *refname);
     ++enum stash_apply_result apply_autostash(const char *path);
     ++enum stash_apply_result apply_autostash_oid(const char *stash_oid);
     ++enum stash_apply_result apply_autostash_ref(struct repository *r,
     ++					    const char *refname,
     ++					    const char *label_ours,
     ++					    const char *label_theirs,
     ++					    const char *label_base,
     ++					    const char *stash_msg);
     + 
     + #define SUMMARY_INITIAL_COMMIT   (1 << 0)
     + #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
     +
     + ## stash.h (new) ##
     +@@
     ++#ifndef STASH_H
     ++#define STASH_H
     ++
     ++enum stash_apply_result {
     ++	/* The stash was applied cleanly, or there was nothing to apply. */
     ++	STASH_APPLY_CLEAN = 0,
     ++
     ++	/*
     ++	 * The stash could not be applied because it resulted in
     ++	 * conflicts.  The stash entry is left in place.  The "git stash
     ++	 * apply", "pop" and "branch" subcommands exit with this status
     ++	 * in this case.
     ++	 */
     ++	STASH_APPLY_CONFLICT = 2,
     ++
     ++	/* Something went wrong. */
     ++	STASH_APPLY_ERROR = -1,
     ++};
     ++
     ++#endif /* STASH_H */
     +
     + ## t/t3903-stash.sh ##
     +@@ t/t3903-stash.sh: test_expect_success 'apply with custom conflict labels' '
     + 	echo stashed >conflict-file &&
     + 	git stash push -m "stashed" &&
     + 	test_commit label-upstream conflict-file upstream-content &&
     +-	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
     ++	test_expect_code 2 git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
     + 	test_grep "^<<<<<<< UP" conflict-file &&
     + 	test_grep "^||||||| Stash base" conflict-file &&
     + 	test_grep "^>>>>>>> STASH" conflict-file
     +@@ t/t3903-stash.sh: test_expect_success 'apply with empty conflict labels' '
     + 	echo stashed >conflict-file &&
     + 	git stash push -m "stashed" &&
     + 	test_commit empty-label-upstream conflict-file upstream-content &&
     +-	test_must_fail git stash apply --label-ours= --label-theirs= &&
     ++	test_expect_code 2 git stash apply --label-ours= --label-theirs= &&
     + 	test_grep "^<<<<<<<$" conflict-file &&
     + 	test_grep "^>>>>>>>$" conflict-file
     + '
     + 
     ++test_expect_success 'apply exits 2 on conflicts and keeps the stash entry' '
     ++	git reset --hard initial &&
     ++	test_commit exit-code-base conflict-file base-content &&
     ++	echo stashed >conflict-file &&
     ++	git stash push -m stashed &&
     ++	test_commit exit-code-upstream conflict-file upstream-content &&
     ++	test_expect_code 2 git stash apply &&
     ++	git stash list >list &&
     ++	test_grep stashed list
     ++'
     ++
     ++test_expect_success 'pop exits 2 on conflicts and keeps the stash entry' '
     ++	git reset --hard initial &&
     ++	test_commit pop-exit-code-base pop-file base-content &&
     ++	echo stashed >pop-file &&
     ++	git stash push -m pop-stashed &&
     ++	test_commit pop-exit-code-upstream pop-file upstream-content &&
     ++	test_expect_code 2 git stash pop &&
     ++	git stash list >list &&
     ++	test_grep pop-stashed list
     ++'
     ++
     + test_expect_success 'stash show --include-untracked includes untracked files' '
     + 	git reset --hard &&
     + 
      
       ## t/t7201-co.sh ##
      @@ t/t7201-co.sh: test_expect_success 'checkout -m creates a recoverable stash on conflict' '


 Documentation/git-stash.adoc |  9 +++++
 builtin/checkout.c           | 15 +++++----
 builtin/stash.c              | 27 +++++++++------
 sequencer.c                  | 65 ++++++++++++++++++++++--------------
 sequencer.h                  | 19 +++++++----
 stash.h                      | 20 +++++++++++
 t/t3903-stash.sh             | 26 +++++++++++++--
 t/t7201-co.sh                | 16 ++++++---
 8 files changed, 143 insertions(+), 54 deletions(-)
 create mode 100644 stash.h

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 50bb89f483..3e41ffcf43 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -426,6 +426,15 @@ include::includes/cmd-config-section-all.adoc[]
 :git-stash: 1
 include::config/stash.adoc[]
 
+EXIT STATUS
+-----------
+
+The `git stash` subcommands exit with status 0 on success and non-zero
+on failure.  The subcommands that apply a stash entry, i.e. `apply`,
+`pop` and `branch`, exit with status 2 when applying the stash entry
+resulted in conflicts, in which case the stash entry is left in place.
+Other failures exit with status 1 (usage errors exit with status 129).
+
 
 SEE ALSO
 --------
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..c960f98287 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1166,6 +1166,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	int flag, writeout_error = 0;
 	int do_merge = 1;
 	int created_autostash = 0;
+	enum stash_apply_result autostash_res = STASH_APPLY_CLEAN;
 	struct strbuf old_commit_shortname = STRBUF_INIT;
 	struct strbuf autostash_msg = STRBUF_INIT;
 	const char *stash_label_base = NULL;
@@ -1237,12 +1238,12 @@ static int switch_branches(const struct checkout_opts *opts,
 				git_config_push_parameter(cfg.buf);
 				strbuf_release(&cfg);
 			}
-			apply_autostash_ref(the_repository,
-					    "CHECKOUT_AUTOSTASH_HEAD",
-					    new_branch_info->name,
-					    "local",
-					    stash_label_base,
-					    autostash_msg.buf);
+			autostash_res = apply_autostash_ref(the_repository,
+				    "CHECKOUT_AUTOSTASH_HEAD",
+				    new_branch_info->name,
+				    "local",
+				    stash_label_base,
+				    autostash_msg.buf);
 		}
 		if (ret) {
 			branch_info_release(&old_branch_info);
@@ -1255,6 +1256,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
 		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
 
+	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
+		fputc('\n', stderr);
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
 	if (created_autostash) {
diff --git a/builtin/stash.c b/builtin/stash.c
index 72c52571f8..86c7ac4ffa 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -10,6 +10,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "stash.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
@@ -640,8 +641,9 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
-static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet,
+static enum stash_apply_result do_apply_stash(const char *prefix,
+					      struct stash_info *info,
+					      int index, int quiet,
 			  const char *label_ours, const char *label_theirs,
 			  const char *label_base)
 {
@@ -716,11 +718,12 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);
 
 	/*
-	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
-	 * merge was clean, and nonzero if the merge was unclean or encountered
-	 * an error.
+	 * Translate the value of 'clean' so 'ret' is STASH_APPLY_CLEAN
+	 * when the merge was clean, STASH_APPLY_CONFLICT when it was
+	 * unclean, and a negative value if it encountered an error.
 	 */
-	ret = clean >= 0 ? !clean : clean;
+	ret = clean >= 0 ? (clean ? STASH_APPLY_CLEAN : STASH_APPLY_CONFLICT)
+			 : clean;
 
 	if (ret < 0)
 		rollback_lock_file(&lock);
@@ -739,7 +742,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	if (has_index) {
 		if (reset_tree(&index_tree, 0, 0))
-			ret = -1;
+			ret = STASH_APPLY_ERROR;
 	} else {
 		unstage_changes_unless_new(&c_tree);
 	}
@@ -2492,9 +2495,13 @@ int cmd_stash(int argc,
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (fn)
-		return !!fn(argc, argv, prefix, repo);
-	else if (!argc)
+	if (fn) {
+		ret = fn(argc, argv, prefix, repo);
+
+		if (ret < 0)
+			return 1;
+		return ret;
+	} else if (!argc)
 		return !!push_stash_unassumed(0, NULL, prefix, repo);
 
 	/* Assume 'stash push' */
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..328fd4262e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -19,6 +19,7 @@
 #include "commit.h"
 #include "sequencer.h"
 #include "run-command.h"
+#include "stash.h"
 #include "hook.h"
 #include "utf8.h"
 #include "cache-tree.h"
@@ -4794,13 +4795,15 @@ void create_autostash_ref(struct repository *r, const char *refname,
 	create_autostash_internal(r, NULL, refname, message, silent);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
-				    const char *label_ours, const char *label_theirs,
-				    const char *label_base,
-				    const char *stash_msg)
+static enum stash_apply_result apply_save_autostash_oid(const char *stash_oid,
+							int attempt_apply,
+							const char *label_ours,
+							const char *label_theirs,
+							const char *label_base,
+							const char *stash_msg)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	int ret = 0;
+	enum stash_apply_result ret = STASH_APPLY_CLEAN;
 
 	if (attempt_apply) {
 		child.git_cmd = 1;
@@ -4816,9 +4819,11 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 			strvec_pushf(&child.args, "--label-base=%s", label_base);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
+		if (ret && ret != STASH_APPLY_CONFLICT)
+			ret = STASH_APPLY_ERROR;
 	}
 
-	if (attempt_apply && !ret)
+	if (attempt_apply && ret == STASH_APPLY_CLEAN)
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
@@ -4832,13 +4837,15 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
-		else if (attempt_apply)
+		else if (attempt_apply && ret == STASH_APPLY_CONFLICT)
 			fprintf(stderr,
 				_("Your local changes are stashed, however applying them\n"
 				  "resulted in conflicts.  You can either resolve the conflicts\n"
 				  "and then discard the stash with \"git stash drop\", or, if you\n"
 				  "do not want to resolve them now, run \"git reset --hard\" and\n"
 				  "apply the local changes later by running \"git stash pop\".\n"));
+		else if (attempt_apply)
+			ret = error(_("could not apply autostash"));
 		else
 			fprintf(stderr,
 				_("Autostash exists; creating a new stash entry.\n"
@@ -4850,15 +4857,16 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 	return ret;
 }
 
-static int apply_save_autostash(const char *path, int attempt_apply)
+static enum stash_apply_result apply_save_autostash(const char *path,
+						    int attempt_apply)
 {
 	struct strbuf stash_oid = STRBUF_INIT;
-	int ret = 0;
+	enum stash_apply_result ret = STASH_APPLY_CLEAN;
 
 	if (!read_oneliner(&stash_oid, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_oid);
-		return 0;
+		return STASH_APPLY_CLEAN;
 	}
 	strbuf_trim(&stash_oid);
 
@@ -4870,37 +4878,40 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	return ret;
 }
 
-int save_autostash(const char *path)
+enum stash_apply_result save_autostash(const char *path)
 {
 	return apply_save_autostash(path, 0);
 }
 
-int apply_autostash(const char *path)
+enum stash_apply_result apply_autostash(const char *path)
 {
 	return apply_save_autostash(path, 1);
 }
 
-int apply_autostash_oid(const char *stash_oid)
+enum stash_apply_result apply_autostash_oid(const char *stash_oid)
 {
 	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
 }
 
-static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply,
-				    const char *label_ours, const char *label_theirs,
-				    const char *label_base,
-				    const char *stash_msg)
+static enum stash_apply_result apply_save_autostash_ref(struct repository *r,
+							const char *refname,
+							int attempt_apply,
+							const char *label_ours,
+							const char *label_theirs,
+							const char *label_base,
+							const char *stash_msg)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
-	int flag, ret;
+	int flag;
+	enum stash_apply_result ret;
 
 	if (!refs_ref_exists(get_main_ref_store(r), refname))
-		return 0;
+		return STASH_APPLY_CLEAN;
 
 	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname,
 				     RESOLVE_REF_READING, &stash_oid, &flag))
-		return -1;
+		return STASH_APPLY_ERROR;
 	if (flag & REF_ISSYMREF)
 		return error(_("autostash reference is a symref"));
 
@@ -4915,15 +4926,19 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 	return ret;
 }
 
-int save_autostash_ref(struct repository *r, const char *refname)
+enum stash_apply_result save_autostash_ref(struct repository *r,
+					   const char *refname)
 {
 	return apply_save_autostash_ref(r, refname, 0,
 					NULL, NULL, NULL, NULL);
 }
 
-int apply_autostash_ref(struct repository *r, const char *refname,
-			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg)
+enum stash_apply_result apply_autostash_ref(struct repository *r,
+					    const char *refname,
+					    const char *label_ours,
+					    const char *label_theirs,
+					    const char *label_base,
+					    const char *stash_msg)
 {
 	return apply_save_autostash_ref(r, refname, 1,
 					label_ours, label_theirs, label_base,
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..804501b64c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 #include "strbuf.h"
 #include "strvec.h"
+#include "stash.h"
 #include "wt-status.h"
 
 struct commit;
@@ -231,13 +232,17 @@ void commit_post_rewrite(struct repository *r,
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname,
 			  const char *message, bool silent);
-int save_autostash(const char *path);
-int save_autostash_ref(struct repository *r, const char *refname);
-int apply_autostash(const char *path);
-int apply_autostash_oid(const char *stash_oid);
-int apply_autostash_ref(struct repository *r, const char *refname,
-			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg);
+enum stash_apply_result save_autostash(const char *path);
+enum stash_apply_result save_autostash_ref(struct repository *r,
+					   const char *refname);
+enum stash_apply_result apply_autostash(const char *path);
+enum stash_apply_result apply_autostash_oid(const char *stash_oid);
+enum stash_apply_result apply_autostash_ref(struct repository *r,
+					    const char *refname,
+					    const char *label_ours,
+					    const char *label_theirs,
+					    const char *label_base,
+					    const char *stash_msg);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
diff --git a/stash.h b/stash.h
new file mode 100644
index 0000000000..bf2f2e1a45
--- /dev/null
+++ b/stash.h
@@ -0,0 +1,20 @@
+#ifndef STASH_H
+#define STASH_H
+
+enum stash_apply_result {
+	/* The stash was applied cleanly, or there was nothing to apply. */
+	STASH_APPLY_CLEAN = 0,
+
+	/*
+	 * The stash could not be applied because it resulted in
+	 * conflicts.  The stash entry is left in place.  The "git stash
+	 * apply", "pop" and "branch" subcommands exit with this status
+	 * in this case.
+	 */
+	STASH_APPLY_CONFLICT = 2,
+
+	/* Something went wrong. */
+	STASH_APPLY_ERROR = -1,
+};
+
+#endif /* STASH_H */
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index da27a6599a..93e8e98216 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1797,7 +1797,7 @@ test_expect_success 'apply with custom conflict labels' '
 	echo stashed >conflict-file &&
 	git stash push -m "stashed" &&
 	test_commit label-upstream conflict-file upstream-content &&
-	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
+	test_expect_code 2 git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
 	test_grep "^<<<<<<< UP" conflict-file &&
 	test_grep "^||||||| Stash base" conflict-file &&
 	test_grep "^>>>>>>> STASH" conflict-file
@@ -1809,11 +1809,33 @@ test_expect_success 'apply with empty conflict labels' '
 	echo stashed >conflict-file &&
 	git stash push -m "stashed" &&
 	test_commit empty-label-upstream conflict-file upstream-content &&
-	test_must_fail git stash apply --label-ours= --label-theirs= &&
+	test_expect_code 2 git stash apply --label-ours= --label-theirs= &&
 	test_grep "^<<<<<<<$" conflict-file &&
 	test_grep "^>>>>>>>$" conflict-file
 '
 
+test_expect_success 'apply exits 2 on conflicts and keeps the stash entry' '
+	git reset --hard initial &&
+	test_commit exit-code-base conflict-file base-content &&
+	echo stashed >conflict-file &&
+	git stash push -m stashed &&
+	test_commit exit-code-upstream conflict-file upstream-content &&
+	test_expect_code 2 git stash apply &&
+	git stash list >list &&
+	test_grep stashed list
+'
+
+test_expect_success 'pop exits 2 on conflicts and keeps the stash entry' '
+	git reset --hard initial &&
+	test_commit pop-exit-code-base pop-file base-content &&
+	echo stashed >pop-file &&
+	git stash push -m pop-stashed &&
+	test_commit pop-exit-code-upstream pop-file upstream-content &&
+	test_expect_code 2 git stash pop &&
+	git stash list >list &&
+	test_grep pop-stashed list
+'
+
 test_expect_success 'stash show --include-untracked includes untracked files' '
 	git reset --hard &&
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0ddd1ad7aa..9ea9462914 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -236,10 +236,18 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
 	test_must_fail git checkout side 2>stderr &&
 	test_grep "Your local changes" stderr &&
 	git checkout -m side >actual 2>&1 &&
-	test_grep "resulted in conflicts" actual &&
-	test_grep "git stash drop" actual &&
-	test_grep "git stash pop" actual &&
-	test_grep "The following paths have local changes" actual &&
+	cat >expect <<-EOF &&
+	Your local changes are stashed, however applying them
+	resulted in conflicts.  You can either resolve the conflicts
+	and then discard the stash with "git stash drop", or, if you
+	do not want to resolve them now, run "git reset --hard" and
+	apply the local changes later by running "git stash pop".
+
+	Switched to branch ${SQ}side${SQ}
+	The following paths have local changes:
+	M	one
+	EOF
+	test_cmp expect actual &&
 	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
 	sed /^index/d actual >actual.trimmed &&
 	cat >expect <<-EOF &&

base-commit: c73e85354c275c9d409b26445089bc16940fc527
-- 
gitgitgadget
