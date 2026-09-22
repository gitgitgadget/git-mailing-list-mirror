Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B143D4EF
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084335; cv=none; b=kfQG1c7ajg3p67k9QHRlCVWJXPIQXTtOxQcjpvSSTnzCjJymdHjyveFPG2rVMLGbef34f9vFPUp1ZaI39NMwCNFfhZ68njEF5N0vYddci9wtj9Jn8KRlYKtU7In7yp2xKov5CAypb8JBUDfivso0Ni0ldUgG3xEA/NNh/TgW0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084335; c=relaxed/simple;
	bh=IvPiK8ZqytVzvHF4vYsXUmRXRUledgpvfQcHIVqBhOo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gmVNMQCpr8XBaTQtYGzw37nj8JcHRxCiixIWRh02X3m6XFZNtv2y4LTtPQBRZY7ZQ9ifMqnc/21Oa+hfrtzD/s8C9FftAvOahqOKCdq8FUc5pWOTRi9znQKK+j5iIwlZiQuHx29VbJ9aAdPi5NSOfhnWSHbcXYtMrFCWki2TOsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VImPL7bS; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VImPL7bS"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8d47b5987so577082e87.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790084329; x=1790689129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j+sYG8uP9TtpSK4lHCejBa6M2wt3vE22gLmup9LBKvY=;
        b=VImPL7bSIaTZ1saxxHQFUjTH24pb2gPnx8bi6IkCZY6+gHMj+Qhb80s3NRoSurXPcw
         DgcG6Nb6vwyxyYLcESM4JQ3i8q8QUjH7vbJ+P+pIhcd0ZBh92mMp9NTfFNQQxDPdpIZi
         SgC1/l+IPNzbYLbJ+LYRiqmeRa/phZKb3Mek5brHXCtEdMj1M4B3DHtWY5amg87fwQB3
         C9czrnDNRci1ParkfUVW8WUGTL02pYSp0cR6X1S2kdKu17KF7K1TIEgF4jgchbtPDMeR
         pWn3UAnqnybZ3DnmFNTSw/HFvvZhaM00o9O7kxuuo0VAS1e+2Dt6VNtc/L5ah7hhTZMM
         8oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084329; x=1790689129;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+sYG8uP9TtpSK4lHCejBa6M2wt3vE22gLmup9LBKvY=;
        b=C9OonJapZKNRBEaSNhV14f/R7kiWOa6ysvdnx5jJ7J6mJ5D3sEgCJ2FxD8ukY/48Y6
         ssehtd48Sg+IDkf6mNSKxCdXcN12pc3WAImGl5ah/SXlLeodbE08Yig9EASVHMVHOwXp
         7ARdPKkNLV/IcRUsLZmIc8zzOhkWEfbdKqYh19WpZMjzFl1bvMLYF9Bz08NXynYwFmxY
         MTU+fLx+oonClBzz8eCISk9qMqaubetrOS3Teie+vmLo2NNGAUB5ZogHQb1fpnZAlnhQ
         XCAdXC2Ibf+8CstkhBsKtQ+Zl9hKkJSl0ZsLxfsPdBRvOonn/bpAX+zGcPmry5h0IPki
         7wAw==
X-Gm-Message-State: AFuF++nYTE7ETyGQ0AlZ8wq9MP+AJImJF0ELXTbfFxS7crEzzauP8g+e
	7uYbZ2Qmal8kPnQKp8ro9c6ZxwPSx+8Hrj3bq0VW1LKJpsIXKETvVAZLs6M0VuGP
X-Gm-Gg: AYBFou0JM016HQEcmwm9mZ8PAZO3Ns/9YIWQbq//97GZmEomdTHVF5sQLUx2r6e4Hgx
	3H2U3EQvmRjqroRTvn04/bas4zeLMQJd4l/4rAJz4JK+V4N3ROemK2M+XxkXJyPnlJW4IL0cXIe
	wjYveBoFaKUI8qVib+rLpIxz4SJK/KuEeb4YAwM3qhffvokeWpERSbkNCCeJxWs0q2EZOo5VQ4h
	3U0eKfpwg1VUJk+3m8o65xcjrKlw0JSmOo1MTLzBDYqdqmi9T6ejgU+C6ckKmMXYYN4Y6NsSB3A
	hfF/CiG0iT6li6U/GFIVmvC009ZPVCZhUd61W1hFGds+3yD6MeJRyzxyvIQXRPrR3yCRLVKsgrQ
	dfsyRbbEiCRrEZgrnRdxi84weQDOf9vy8iuZOGj/PhYuCGG4ovFGgH0jNZqUHLga8wUT11+2Ze/
	J1ciazVVeq3M9XnPSdL6BuWwVAayFTGDvpnmINgSJbyUO6epUsO7G/TbYJI8fi4K9rsrcBXW4IU
	ys=
X-Received: by 2002:a05:6512:620d:b0:5b6:1a7c:aa0f with SMTP id 2adb3069b0e04-5b8c197407bmr3923223e87.39.1790084328771;
        Tue, 22 Sep 2026 06:38:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.206.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d4cd4608sm459285e87.4.2026.09.22.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:38:48 -0700 (PDT)
Message-Id: <pull.2413.v2.git.git.1790084326913.gitgitgadget@gmail.com>
In-Reply-To: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Sep 2026 13:38:46 +0000
Subject: [PATCH v2] shallow: advise when a walk stops at a shallow boundary
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Asking for a commit's ancestor with <rev>~N in a shallow clone that
does not have N commits of history locally fails with a bare "is not
a commit" error, with no indication that the repository being shallow
is the reason, or what to do about it.

git log -<n> and git log --since=<date> have the opposite problem.
Instead of failing, they silently stop once they reach the shallow
boundary, with no error and nothing to suggest that more history
exists upstream and simply was not fetched.

Add a hint, shown when a walk runs out of parents exactly at a
recorded shallow boundary, not merely because the repository happens
to be shallow elsewhere. When the revision <rev> is given as a
remote-tracking branch, the remote and branch are exactly named in the
suggested command, found by reverse mapping through the remote's real
refspec instead of assuming a refs/remotes/<remote>/ layout, since a
refspec can put branches anywhere. For <rev>~N it suggests the exact
--deepen needed, accounting for history already present. For <rev>^N
it always suggests --deepen=1: a shallow boundary commit has no
parents recorded at all, so one more generation reveals its complete
real parent list regardless of which index was asked for.

The hint only suggests that older history might exist. A recorded
shallow boundary does not distinguish a depth cutoff from a commit
that is the true root: cloning with a depth that happens to exactly
match the available history still records that root commit as a
boundary, and only the remote knows for certain whether deepening
would fetch anything new.

git log -<n> and git log --since only show the hint when the last
commit they printed is that same recorded boundary. A plain git log
running out of history, or a git log -<n> or --since that is satisfied
well before reaching the boundary, stays silent as before. When the
output is paginated, the hint waits for the pager to close before
printing, since a full screen pager like less otherwise wipes it from
the terminal along with the rest of the output the moment it quits.

The advice is threaded through GET_OID_QUIETLY so it is not shown
during the internal re-resolution some commands do while building a
better error message, which would otherwise print it twice for the
same failing argument.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    object-name: explain why ~N fails in a shallow clone
    
    Asking for a commit's ancestor with <rev>~N in a shallow clone that
    doesn't have N commits of history locally fails with a "is not a commit"
    error, with no indication that the repository being shallow is the
    reason.
    
    Changes in v2:
    
     * <ref> renamed to <rev> throughout. Restrict the commit message and
       advice.shallowHistory documentation to <rev>~N, since <rev>^N doesn't
       get deeper with a higher index the way <rev>~N does.
     * Bare <remote>/<branch> names are now resolved by reverse mapping
       through the remote's configured refspec (remote_find_tracking),
       instead of assuming branches live at refs/remotes/<remote>/<branch>.
     * Extend the shallow history hint to git log -<n> and git log
       --since=<date>, which previously stopped early at a shallow boundary
       with no indication anything was missing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2413%2FHaraldNordgren%2Fshallow-history-advice-hint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2413/HaraldNordgren/shallow-history-advice-hint-v2
Pull-Request: https://github.com/git/git/pull/2413

Range-diff vs v1:

 1:  ba481667c9 ! 1:  305d22d33e object-name: explain why <ref>~N fails in a shallow clone
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    object-name: explain why <ref>~N fails in a shallow clone
     +    shallow: advise when a walk stops at a shallow boundary
      
     -    Asking for a commit's ancestor with <ref>~N or <ref>^N in a shallow
     -    clone that does not have N commits of history locally fails with a
     -    bare "is not a commit" error, with no indication that the repository
     -    being shallow is the reason, or what to do about it.
     +    Asking for a commit's ancestor with <rev>~N in a shallow clone that
     +    does not have N commits of history locally fails with a bare "is not
     +    a commit" error, with no indication that the repository being shallow
     +    is the reason, or what to do about it.
      
     -    Add a hint, shown when the walk runs out of parents exactly at a
     -    recorded shallow boundary, explaining that history was intentionally
     -    truncated there. When <ref> looks like <remote>/<branch> and <remote>
     -    is configured, the suggested command names that remote and branch
     -    directly. For <ref>~N it suggests the exact --deepen needed,
     -    accounting for any history already present instead of just N. For
     -    <ref>^N the suggestion is always --deepen=1, regardless of N: a
     -    shallow boundary commit has no parents recorded locally at all, so
     -    deepening by one generation fetches its complete real parent list in
     -    one step, whether that commit turns out to have one parent or several.
     -    The hint only fires when the search stops at an actual shallow
     -    boundary, not merely because the repository happens to be shallow
     -    elsewhere, so it does not misfire on a short history that is not
     -    shallow-truncated.
     +    git log -<n> and git log --since=<date> have the opposite problem.
     +    Instead of failing, they silently stop once they reach the shallow
     +    boundary, with no error and nothing to suggest that more history
     +    exists upstream and simply was not fetched.
     +
     +    Add a hint, shown when a walk runs out of parents exactly at a
     +    recorded shallow boundary, not merely because the repository happens
     +    to be shallow elsewhere. When the revision <rev> is given as a
     +    remote-tracking branch, the remote and branch are exactly named in the
     +    suggested command, found by reverse mapping through the remote's real
     +    refspec instead of assuming a refs/remotes/<remote>/ layout, since a
     +    refspec can put branches anywhere. For <rev>~N it suggests the exact
     +    --deepen needed, accounting for history already present. For <rev>^N
     +    it always suggests --deepen=1: a shallow boundary commit has no
     +    parents recorded at all, so one more generation reveals its complete
     +    real parent list regardless of which index was asked for.
     +
     +    The hint only suggests that older history might exist. A recorded
     +    shallow boundary does not distinguish a depth cutoff from a commit
     +    that is the true root: cloning with a depth that happens to exactly
     +    match the available history still records that root commit as a
     +    boundary, and only the remote knows for certain whether deepening
     +    would fetch anything new.
     +
     +    git log -<n> and git log --since only show the hint when the last
     +    commit they printed is that same recorded boundary. A plain git log
     +    running out of history, or a git log -<n> or --since that is satisfied
     +    well before reaching the boundary, stays silent as before. When the
     +    output is paginated, the hint waits for the pager to close before
     +    printing, since a full screen pager like less otherwise wipes it from
     +    the terminal along with the rest of the output the moment it quits.
      
          The advice is threaded through GET_OID_QUIETLY so it is not shown
          during the internal re-resolution some commands do while building a
     @@ Documentation/config/advice.adoc: all advice messages.
       	sequencerInUse::
       		Shown when a sequencer command is already in progress.
      +	shallowHistory::
     -+		Shown when `~<n>` or `^<n>` cannot resolve enough ancestors
     -+		because history stops at a shallow boundary, to suggest
     -+		fetching more history.
     ++		Shown when `<rev>~<n>` cannot resolve enough ancestors of
     ++		`<rev>` because history stops at a shallow boundary, to
     ++		suggest fetching more history.
       	skippedCherryPicks::
       		Shown when linkgit:git-rebase[1] skips a commit that has already
       		been cherry-picked onto the upstream branch.
     @@ advice.h: enum advice_type {
       	ADVICE_SPARSE_INDEX_EXPANDED,
       	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
      
     + ## builtin/log.c ##
     +@@
     + #include "commit-reach.h"
     + #include "promisor-remote.h"
     + #include "range-diff.h"
     ++#include "shallow.h"
     + #include "tmp-objdir.h"
     + #include "tree.h"
     + #include "userdiff.h"
     +@@ builtin/log.c: static void cmd_log_init(int argc, const char **argv, const char *prefix,
     + 	cmd_log_init_finish(argc, argv, prefix, rev, opt, cfg);
     + }
     + 
     ++static void advise_if_log_stopped_at_shallow_boundary(struct rev_info *rev,
     ++						       struct commit *last_shown)
     ++{
     ++	if (!last_shown)
     ++		return;
     ++	/* a plain "git log" running out of history is expected */
     ++	if (rev->max_count < 0 && rev->max_age == (timestamp_t)-1)
     ++		return;
     ++	if (!is_repository_shallow(the_repository))
     ++		return;
     ++	if (!commit_is_shallow_boundary(the_repository, &last_shown->object.oid))
     ++		return;
     ++	wait_for_pager();
     ++	advise_if_enabled(ADVICE_SHALLOW_HISTORY,
     ++			   _("'%s' stopped at %s because this repository is a shallow\n"
     ++			     "clone, and might have more history upstream that was never fetched."),
     ++			   "git log",
     ++			   repo_find_unique_abbrev(the_repository,
     ++						    &last_shown->object.oid,
     ++						    DEFAULT_ABBREV));
     ++}
     ++
     + static int cmd_log_walk_no_free(struct rev_info *rev)
     + {
     + 	struct commit *commit;
     ++	struct commit *last_shown = NULL;
     + 	int saved_nrl = 0;
     + 	int saved_dcctc = 0;
     + 	int result;
     +@@ builtin/log.c: static int cmd_log_walk_no_free(struct rev_info *rev)
     + 	 * retain that state information if replacing rev->diffopt in this loop
     + 	 */
     + 	while ((commit = get_revision(rev)) != NULL) {
     ++		last_shown = commit;
     + 		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
     + 			/*
     + 			 * We decremented max_count in get_revision,
     +@@ builtin/log.c: static int cmd_log_walk_no_free(struct rev_info *rev)
     + 		if (rev->diffopt.degraded_cc_to_c)
     + 			saved_dcctc = 1;
     + 	}
     ++	advise_if_log_stopped_at_shallow_boundary(rev, last_shown);
     + 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
     + 	rev->diffopt.needed_rename_limit = saved_nrl;
     + 
     +
       ## object-name.c ##
      @@
       #include "repo-settings.h"
     @@ object-name.c: static int get_oid_basic(struct repository *r, const char *str, i
       	return 0;
       }
       
     ++struct remote_tracking_search {
     ++	char *dst;
     ++	char *remote_name;
     ++	char *branch_name;
     ++};
     ++
     ++static int search_remote_tracking(struct remote *remote, void *cb_data)
     ++{
     ++	struct remote_tracking_search *search = cb_data;
     ++	struct refspec_item query;
     ++
     ++	memset(&query, 0, sizeof(query));
     ++	query.dst = search->dst;
     ++	if (remote_find_tracking(remote, &query))
     ++		return 0;
     ++	search->remote_name = xstrdup(remote->name);
     ++	search->branch_name = query.src;
     ++	return 1;
     ++}
     ++
     ++/*
     ++ * If "name" resolves to a remote-tracking ref, find which configured
     ++ * remote it actually belongs to and what branch of that remote's it is,
     ++ * by reverse mapping through each remote's real fetch refspec instead
     ++ * of assuming the common "refs/remotes/<remote>/<branch>" layout,
     ++ * since a remote's refspec need not put its branches there at all. On a
     ++ * match, fill "remote_out" and "branch_out" with newly allocated copies
     ++ * and return true. Otherwise leave them untouched and return false.
     ++ */
     ++static bool parse_remote_tracking_name(struct repository *r,
     ++				       const char *name, int namelen,
     ++				       char **remote_out, char **branch_out)
     ++{
     ++	struct object_id oid;
     ++	char *real_ref = NULL;
     ++	struct remote_tracking_search search = { 0 };
     ++	const char *branch_name;
     ++
     ++	if (!repo_dwim_ref(r, name, namelen, &oid, &real_ref, 0) || !real_ref)
     ++		return false;
     ++
     ++	search.dst = real_ref;
     ++	if (!for_each_remote(search_remote_tracking, &search)) {
     ++		free(real_ref);
     ++		return false;
     ++	}
     ++	free(real_ref);
     ++
     ++	branch_name = search.branch_name;
     ++	skip_prefix(branch_name, "refs/heads/", &branch_name);
     ++	*remote_out = search.remote_name;
     ++	*branch_out = xstrdup(branch_name);
     ++	free(search.branch_name);
     ++	return true;
     ++}
     ++
      +/*
      + * When a "name~<n>" or "name^<n>" walk runs out of parents at "commit",
      + * and that is because "commit" is where this shallow repository's history
     -+ * was cut off (rather than commit genuinely being a root commit), let the
     ++ * was cut off (rather than commit being a real root commit), let the
      + * user know that fetching more history might be what they are after.
      + *
      + * "suggested_depth" is the --deepen value to recommend. For "name^<n>"
      + * this is always 1: deepening by one generation fetches "commit"'s real
      + * parent list in full, whatever it turns out to contain, regardless of
     -+ * which parent index <n> asked for. If "name" looks like
     -+ * "<remote>/<branch>" and <remote> is a configured remote, the suggested
     -+ * command names that remote and branch instead of leaving them as
     -+ * placeholders.
     ++ * which parent index <n> asked for.
      + */
      +static void advise_if_shallow_cutoff(struct repository *r,
      +				     const char *name, int namelen,
     @@ object-name.c: static int get_oid_basic(struct repository *r, const char *str, i
      +				     unsigned lookup_flags,
      +				     int suggested_depth)
      +{
     -+	struct commit_graft *graft;
     -+	const char *slash;
     ++	char *remote = NULL, *branch = NULL;
      +	struct strbuf cmd = STRBUF_INIT;
      +
      +	if (lookup_flags & GET_OID_QUIETLY)
      +		return;
      +	if (!is_repository_shallow(r))
      +		return;
     -+	graft = lookup_commit_graft(r, &commit->object.oid);
     -+	if (!graft || graft->nr_parent != -1)
     ++	if (!commit_is_shallow_boundary(r, &commit->object.oid))
      +		return;
      +
     -+	slash = memchr(name, '/', namelen);
     -+	if (slash) {
     -+		char *remote_candidate = xstrndup(name, slash - name);
     -+		if (remote_is_configured(remote_get(remote_candidate), 0))
     -+			strbuf_addf(&cmd, "git fetch --deepen=%d %s %.*s",
     -+				    suggested_depth, remote_candidate,
     -+				    (int)(name + namelen - (slash + 1)), slash + 1);
     -+		free(remote_candidate);
     -+	}
     -+	if (!cmd.len)
     ++	if (parse_remote_tracking_name(r, name, namelen, &remote, &branch))
     ++		strbuf_addf(&cmd, "git fetch --deepen=%d %s %s",
     ++			    suggested_depth, remote, branch);
     ++	else
      +		strbuf_addf(&cmd, "git fetch --deepen=%d <remote> <branch>",
      +			    suggested_depth);
     ++	free(remote);
     ++	free(branch);
      +
      +	advise_if_enabled(ADVICE_SHALLOW_HISTORY,
      +			   _("'%.*s' does not have that many ancestors locally.\n"
      +			     "History stops at %s because this repository is a\n"
     -+			     "shallow clone. To fetch more of it, try:\n"
     ++			     "shallow clone, and might have more history upstream.\n"
     ++			     "To check, try:\n"
      +			     "\n"
      +			     "  %s"),
     -+			   namelen, name, oid_to_hex(&commit->object.oid), cmd.buf);
     ++			   namelen, name,
     ++			   repo_find_unique_abbrev(r, &commit->object.oid, DEFAULT_ABBREV),
     ++			   cmd.buf);
      +	strbuf_release(&cmd);
      +}
      +
     @@ object-name.c: static enum get_oid_result get_nth_ancestor(struct repository *r,
       	while (generation--) {
      -		if (repo_parse_commit(r, commit) || !commit->parents)
      +		if (repo_parse_commit(r, commit))
     - 			return MISSING_OBJECT;
     ++			return MISSING_OBJECT;
      +		if (!commit->parents) {
      +			/* Remaining "generation" plus this failed step is the actual gap. */
      +			advise_if_shallow_cutoff(r, name, len, commit,
      +						 lookup_flags, generation + 1);
     -+			return MISSING_OBJECT;
     + 			return MISSING_OBJECT;
      +		}
       		commit = commit->parents->item;
       	}
     @@ object-name.c: static enum get_oid_result get_oid_1(struct repository *r,
       
       	ret = peel_onion(r, name, len, oid, lookup_flags);
      
     + ## shallow.c ##
     +@@ shallow.c: int is_repository_shallow(struct repository *r)
     + 	return r->parsed_objects->is_shallow;
     + }
     + 
     ++int commit_is_shallow_boundary(struct repository *r,
     ++			       const struct object_id *oid)
     ++{
     ++	struct commit_graft *graft = lookup_commit_graft(r, oid);
     ++
     ++	return graft && graft->nr_parent == -1;
     ++}
     ++
     + static void reset_repository_shallow(struct repository *r)
     + {
     + 	r->parsed_objects->is_shallow = -1;
     +
     + ## shallow.h ##
     +@@ shallow.h: int register_shallow(struct repository *r, const struct object_id *oid);
     + int unregister_shallow(const struct object_id *oid);
     + int is_repository_shallow(struct repository *r);
     + 
     ++/*
     ++ * True if "oid" is where this shallow repository's history was cut off,
     ++ * i.e. a shallow-graft commit with no parents recorded locally, as
     ++ * opposed to a commit that is actually a root.
     ++ */
     ++int commit_is_shallow_boundary(struct repository *r,
     ++			       const struct object_id *oid);
     ++
     + /*
     +  * Lock for updating the $GIT_DIR/shallow file.
     +  *
     +
       ## t/t1500-rev-parse.sh ##
      @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
       	test_cmp expect actual
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
      +	cat >expect <<-EOF &&
      +	hint: '$name' does not have that many ancestors locally.
      +	hint: History stops at $oid because this repository is a
     -+	hint: shallow clone. To fetch more of it, try:
     ++	hint: shallow clone, and might have more history upstream.
     ++	hint: To check, try:
      +	hint:
      +	hint:   $cmd
      +	hint: Disable this message with "git config set advice.shallowHistory false"
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
      +	git clone --no-local --depth=1 --branch main --single-branch \
      +		.git shallow-advice &&
      +	test_when_finished "rm -rf shallow-advice" &&
     -+	oid=$(git -C shallow-advice rev-parse origin/main) &&
     ++	oid=$(git -C shallow-advice rev-parse --short origin/main) &&
      +	test_must_fail git -C shallow-advice rev-parse origin/main~1 2>err &&
      +	check_shallow_history_advice origin/main "$oid" \
      +		"git fetch --deepen=1 origin main"
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
      +	test_when_finished "rm -rf shallow-advice-partial" &&
      +	(
      +		cd shallow-advice-partial &&
     -+		oid=$(git rev-parse origin/main~2) &&
     ++		oid=$(git rev-parse --short origin/main~2) &&
      +		test_must_fail git rev-parse origin/main~5 2>err &&
      +		check_shallow_history_advice origin/main "$oid" \
      +			"git fetch --deepen=3 origin main" &&
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
      +	git clone --no-local --depth=1 --branch main --single-branch \
      +		.git shallow-advice-caret &&
      +	test_when_finished "rm -rf shallow-advice-caret" &&
     -+	oid=$(git -C shallow-advice-caret rev-parse origin/main) &&
     ++	oid=$(git -C shallow-advice-caret rev-parse --short origin/main) &&
      +	test_must_fail git -C shallow-advice-caret rev-parse origin/main^1 2>err &&
      +	check_shallow_history_advice origin/main "$oid" \
      +		"git fetch --deepen=1 origin main"
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
      +	test_when_finished "rm -rf shallow-advice-merge" &&
      +	(
      +		cd shallow-advice-merge &&
     -+		oid=$(git rev-parse origin/main) &&
     ++		oid=$(git rev-parse --short origin/main) &&
      +		test_must_fail git rev-parse origin/main^2 2>err &&
      +		check_shallow_history_advice origin/main "$oid" \
      +			"git fetch --deepen=1 origin main" &&
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
       test_expect_success 'rev-parse --show-object-format in repo' '
       	test_oid algo >expect &&
       	git rev-parse --show-object-format >actual &&
     +
     + ## t/t4202-log.sh ##
     +@@ t/t4202-log.sh: test_expect_success 'log --invert-grep --grep --author' '
     + 	test_cmp expect actual
     + '
     + 
     ++check_log_shallow_history_advice () {
     ++	oid=$1 &&
     ++	grep '^hint:' err >actual &&
     ++	cat >expect <<-EOF &&
     ++	hint: 'git log' stopped at $oid because this repository is a shallow
     ++	hint: clone, and might have more history upstream that was never fetched.
     ++	hint: Disable this message with "git config set advice.shallowHistory false"
     ++	EOF
     ++	test_cmp expect actual
     ++}
     ++
     ++test_expect_success 'set up linear history for shallow log advice tests' '
     ++	git checkout --orphan loghist &&
     ++	test_commit loghist_1 &&
     ++	test_commit loghist_2 &&
     ++	test_commit loghist_3 &&
     ++	test_commit loghist_4 &&
     ++	test_commit loghist_5 &&
     ++	git checkout main
     ++'
     ++
     ++test_expect_success 'log -<n> advises when it runs out of history at a shallow boundary' '
     ++	git clone --no-local --depth=2 --branch loghist --single-branch \
     ++		.git shallow-log-advice &&
     ++	test_when_finished "rm -rf shallow-log-advice" &&
     ++	oid=$(git -C shallow-log-advice rev-parse --short origin/loghist~1) &&
     ++	git -C shallow-log-advice log -5 --oneline origin/loghist >out 2>err &&
     ++	check_log_shallow_history_advice "$oid"
     ++'
     ++
     ++test_expect_success 'log --since advises when it runs out of history at a shallow boundary' '
     ++	git clone --no-local --depth=2 --branch loghist --single-branch \
     ++		.git shallow-log-advice-since &&
     ++	test_when_finished "rm -rf shallow-log-advice-since" &&
     ++	oid=$(git -C shallow-log-advice-since rev-parse --short origin/loghist~1) &&
     ++	git -C shallow-log-advice-since log --since=2000-01-01 --oneline \
     ++		origin/loghist >out 2>err &&
     ++	check_log_shallow_history_advice "$oid"
     ++'
     ++
     ++test_expect_success 'log without -<n> or --since does not advise at a shallow boundary' '
     ++	git clone --no-local --depth=1 --branch loghist --single-branch \
     ++		.git shallow-log-plain &&
     ++	test_when_finished "rm -rf shallow-log-plain" &&
     ++	git -C shallow-log-plain log --oneline origin/loghist >out 2>err &&
     ++	test_grep ! "^hint:" err
     ++'
     ++
     ++test_expect_success 'log -<n> does not advise when satisfied within local history' '
     ++	git clone --no-local --depth=5 --branch loghist --single-branch \
     ++		.git shallow-log-satisfied &&
     ++	test_when_finished "rm -rf shallow-log-satisfied" &&
     ++	git -C shallow-log-satisfied log -2 --oneline origin/loghist >out 2>err &&
     ++	test_grep ! "^hint:" err
     ++'
     ++
     ++test_expect_success 'log -<n> shallow history advice can be disabled' '
     ++	git clone --no-local --depth=1 --branch loghist --single-branch \
     ++		.git shallow-log-off &&
     ++	test_when_finished "rm -rf shallow-log-off" &&
     ++	git -C shallow-log-off -c advice.shallowHistory=false \
     ++		log -5 --oneline origin/loghist >out 2>err &&
     ++	test_grep ! "^hint:" err
     ++'
     ++
     ++test_expect_success 'log -<n> does not advise in a non-shallow repository' '
     ++	test_when_finished "rm -rf non-shallow-log" &&
     ++	git init -q non-shallow-log &&
     ++	test_commit -C non-shallow-log only-commit &&
     ++	git -C non-shallow-log log -20 --oneline >out 2>err &&
     ++	test_grep ! "^hint:" err
     ++'
     ++
     + test_done


 Documentation/config/advice.adoc |   4 +
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/log.c                    |  26 +++++++
 object-name.c                    | 125 +++++++++++++++++++++++++++++--
 shallow.c                        |   8 ++
 shallow.h                        |   8 ++
 t/t1500-rev-parse.sh             | 109 +++++++++++++++++++++++++++
 t/t4202-log.sh                   |  73 ++++++++++++++++++
 9 files changed, 350 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..bb1e508bb6 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -128,6 +128,10 @@ all advice messages.
 		give directions on how to proceed from the current state.
 	sequencerInUse::
 		Shown when a sequencer command is already in progress.
+	shallowHistory::
+		Shown when `<rev>~<n>` cannot resolve enough ancestors of
+		`<rev>` because history stops at a shallow boundary, to
+		suggest fetching more history.
 	skippedCherryPicks::
 		Shown when linkgit:git-rebase[1] skips a commit that has already
 		been cherry-picked onto the upstream branch.
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..e22706ead5 100644
--- a/advice.c
+++ b/advice.c
@@ -80,6 +80,7 @@ static struct {
 	[ADVICE_RM_HINTS]				= { "rmHints" },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
+	[ADVICE_SHALLOW_HISTORY]			= { "shallowHistory" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
diff --git a/advice.h b/advice.h
index 66f6cd6a77..e80e3e82cc 100644
--- a/advice.h
+++ b/advice.h
@@ -47,6 +47,7 @@ enum advice_type {
 	ADVICE_RM_HINTS,
 	ADVICE_SEQUENCER_IN_USE,
 	ADVICE_SET_UPSTREAM_FAILURE,
+	ADVICE_SHALLOW_HISTORY,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
diff --git a/builtin/log.c b/builtin/log.c
index 350b35c556..22a40c7d28 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -47,6 +47,7 @@
 #include "commit-reach.h"
 #include "promisor-remote.h"
 #include "range-diff.h"
+#include "shallow.h"
 #include "tmp-objdir.h"
 #include "tree.h"
 #include "userdiff.h"
@@ -396,9 +397,32 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	cmd_log_init_finish(argc, argv, prefix, rev, opt, cfg);
 }
 
+static void advise_if_log_stopped_at_shallow_boundary(struct rev_info *rev,
+						       struct commit *last_shown)
+{
+	if (!last_shown)
+		return;
+	/* a plain "git log" running out of history is expected */
+	if (rev->max_count < 0 && rev->max_age == (timestamp_t)-1)
+		return;
+	if (!is_repository_shallow(the_repository))
+		return;
+	if (!commit_is_shallow_boundary(the_repository, &last_shown->object.oid))
+		return;
+	wait_for_pager();
+	advise_if_enabled(ADVICE_SHALLOW_HISTORY,
+			   _("'%s' stopped at %s because this repository is a shallow\n"
+			     "clone, and might have more history upstream that was never fetched."),
+			   "git log",
+			   repo_find_unique_abbrev(the_repository,
+						    &last_shown->object.oid,
+						    DEFAULT_ABBREV));
+}
+
 static int cmd_log_walk_no_free(struct rev_info *rev)
 {
 	struct commit *commit;
+	struct commit *last_shown = NULL;
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
 	int result;
@@ -412,6 +436,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
 	while ((commit = get_revision(rev)) != NULL) {
+		last_shown = commit;
 		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
 			/*
 			 * We decremented max_count in get_revision,
@@ -437,6 +462,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 		if (rev->diffopt.degraded_cc_to_c)
 			saved_dcctc = 1;
 	}
+	advise_if_log_stopped_at_shallow_boundary(rev, last_shown);
 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
 	rev->diffopt.needed_rename_limit = saved_nrl;
 
diff --git a/object-name.c b/object-name.c
index 4eda8c8eac..cb601e1532 100644
--- a/object-name.c
+++ b/object-name.c
@@ -22,6 +22,7 @@
 #include "repo-settings.h"
 #include "repository.h"
 #include "setup.h"
+#include "shallow.h"
 #include "midx.h"
 #include "commit-reach.h"
 #include "date.h"
@@ -824,9 +825,115 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	return 0;
 }
 
+struct remote_tracking_search {
+	char *dst;
+	char *remote_name;
+	char *branch_name;
+};
+
+static int search_remote_tracking(struct remote *remote, void *cb_data)
+{
+	struct remote_tracking_search *search = cb_data;
+	struct refspec_item query;
+
+	memset(&query, 0, sizeof(query));
+	query.dst = search->dst;
+	if (remote_find_tracking(remote, &query))
+		return 0;
+	search->remote_name = xstrdup(remote->name);
+	search->branch_name = query.src;
+	return 1;
+}
+
+/*
+ * If "name" resolves to a remote-tracking ref, find which configured
+ * remote it actually belongs to and what branch of that remote's it is,
+ * by reverse mapping through each remote's real fetch refspec instead
+ * of assuming the common "refs/remotes/<remote>/<branch>" layout,
+ * since a remote's refspec need not put its branches there at all. On a
+ * match, fill "remote_out" and "branch_out" with newly allocated copies
+ * and return true. Otherwise leave them untouched and return false.
+ */
+static bool parse_remote_tracking_name(struct repository *r,
+				       const char *name, int namelen,
+				       char **remote_out, char **branch_out)
+{
+	struct object_id oid;
+	char *real_ref = NULL;
+	struct remote_tracking_search search = { 0 };
+	const char *branch_name;
+
+	if (!repo_dwim_ref(r, name, namelen, &oid, &real_ref, 0) || !real_ref)
+		return false;
+
+	search.dst = real_ref;
+	if (!for_each_remote(search_remote_tracking, &search)) {
+		free(real_ref);
+		return false;
+	}
+	free(real_ref);
+
+	branch_name = search.branch_name;
+	skip_prefix(branch_name, "refs/heads/", &branch_name);
+	*remote_out = search.remote_name;
+	*branch_out = xstrdup(branch_name);
+	free(search.branch_name);
+	return true;
+}
+
+/*
+ * When a "name~<n>" or "name^<n>" walk runs out of parents at "commit",
+ * and that is because "commit" is where this shallow repository's history
+ * was cut off (rather than commit being a real root commit), let the
+ * user know that fetching more history might be what they are after.
+ *
+ * "suggested_depth" is the --deepen value to recommend. For "name^<n>"
+ * this is always 1: deepening by one generation fetches "commit"'s real
+ * parent list in full, whatever it turns out to contain, regardless of
+ * which parent index <n> asked for.
+ */
+static void advise_if_shallow_cutoff(struct repository *r,
+				     const char *name, int namelen,
+				     struct commit *commit,
+				     unsigned lookup_flags,
+				     int suggested_depth)
+{
+	char *remote = NULL, *branch = NULL;
+	struct strbuf cmd = STRBUF_INIT;
+
+	if (lookup_flags & GET_OID_QUIETLY)
+		return;
+	if (!is_repository_shallow(r))
+		return;
+	if (!commit_is_shallow_boundary(r, &commit->object.oid))
+		return;
+
+	if (parse_remote_tracking_name(r, name, namelen, &remote, &branch))
+		strbuf_addf(&cmd, "git fetch --deepen=%d %s %s",
+			    suggested_depth, remote, branch);
+	else
+		strbuf_addf(&cmd, "git fetch --deepen=%d <remote> <branch>",
+			    suggested_depth);
+	free(remote);
+	free(branch);
+
+	advise_if_enabled(ADVICE_SHALLOW_HISTORY,
+			   _("'%.*s' does not have that many ancestors locally.\n"
+			     "History stops at %s because this repository is a\n"
+			     "shallow clone, and might have more history upstream.\n"
+			     "To check, try:\n"
+			     "\n"
+			     "  %s"),
+			   namelen, name,
+			   repo_find_unique_abbrev(r, &commit->object.oid, DEFAULT_ABBREV),
+			   cmd.buf);
+	strbuf_release(&cmd);
+}
+
 static enum get_oid_result get_parent(struct repository *r,
 				      const char *name, int len,
-				      struct object_id *result, int idx)
+				      struct object_id *result, int idx,
+				      unsigned lookup_flags)
 {
 	struct object_id oid;
 	enum get_oid_result ret = get_oid_1(r, name, len, &oid,
@@ -851,13 +958,15 @@ static enum get_oid_result get_parent(struct repository *r,
 		}
 		p = p->next;
 	}
+	advise_if_shallow_cutoff(r, name, len, commit, lookup_flags, 1);
 	return MISSING_OBJECT;
 }
 
 static enum get_oid_result get_nth_ancestor(struct repository *r,
 					    const char *name, int len,
 					    struct object_id *result,
-					    int generation)
+					    int generation,
+					    unsigned lookup_flags)
 {
 	struct object_id oid;
 	struct commit *commit;
@@ -871,8 +980,14 @@ static enum get_oid_result get_nth_ancestor(struct repository *r,
 		return MISSING_OBJECT;
 
 	while (generation--) {
-		if (repo_parse_commit(r, commit) || !commit->parents)
+		if (repo_parse_commit(r, commit))
+			return MISSING_OBJECT;
+		if (!commit->parents) {
+			/* Remaining "generation" plus this failed step is the actual gap. */
+			advise_if_shallow_cutoff(r, name, len, commit,
+						 lookup_flags, generation + 1);
 			return MISSING_OBJECT;
+		}
 		commit = commit->parents->item;
 	}
 	oidcpy(result, &commit->object.oid);
@@ -1119,9 +1234,9 @@ static enum get_oid_result get_oid_1(struct repository *r,
 		else if (num > INT_MAX)
 			return MISSING_OBJECT;
 		if (has_suffix == '^')
-			return get_parent(r, name, len1, oid, num);
+			return get_parent(r, name, len1, oid, num, lookup_flags);
 		/* else if (has_suffix == '~') -- goes without saying */
-		return get_nth_ancestor(r, name, len1, oid, num);
+		return get_nth_ancestor(r, name, len1, oid, num, lookup_flags);
 	}
 
 	ret = peel_onion(r, name, len, oid, lookup_flags);
diff --git a/shallow.c b/shallow.c
index 8e244a5669..2e0cf09f32 100644
--- a/shallow.c
+++ b/shallow.c
@@ -92,6 +92,14 @@ int is_repository_shallow(struct repository *r)
 	return r->parsed_objects->is_shallow;
 }
 
+int commit_is_shallow_boundary(struct repository *r,
+			       const struct object_id *oid)
+{
+	struct commit_graft *graft = lookup_commit_graft(r, oid);
+
+	return graft && graft->nr_parent == -1;
+}
+
 static void reset_repository_shallow(struct repository *r)
 {
 	r->parsed_objects->is_shallow = -1;
diff --git a/shallow.h b/shallow.h
index 6a64db42c9..66c9e723f7 100644
--- a/shallow.h
+++ b/shallow.h
@@ -15,6 +15,14 @@ int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int is_repository_shallow(struct repository *r);
 
+/*
+ * True if "oid" is where this shallow repository's history was cut off,
+ * i.e. a shallow-graft commit with no parents recorded locally, as
+ * opposed to a commit that is actually a root.
+ */
+int commit_is_shallow_boundary(struct repository *r,
+			       const struct object_id *oid);
+
 /*
  * Lock for updating the $GIT_DIR/shallow file.
  *
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 4174ca40c3..ecadeddcdb 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -193,6 +193,115 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
 	test_cmp expect actual
 '
 
+check_shallow_history_advice () {
+	name=$1 oid=$2 cmd=$3 &&
+	grep '^hint:' err >actual &&
+	cat >expect <<-EOF &&
+	hint: '$name' does not have that many ancestors locally.
+	hint: History stops at $oid because this repository is a
+	hint: shallow clone, and might have more history upstream.
+	hint: To check, try:
+	hint:
+	hint:   $cmd
+	hint: Disable this message with "git config set advice.shallowHistory false"
+	EOF
+	test_cmp expect actual
+}
+
+test_expect_success 'shallowHistory advice on ~N beyond shallow boundary' '
+	test_commit shallow_advice_1 &&
+	test_commit shallow_advice_2 &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice &&
+	test_when_finished "rm -rf shallow-advice" &&
+	oid=$(git -C shallow-advice rev-parse --short origin/main) &&
+	test_must_fail git -C shallow-advice rev-parse origin/main~1 2>err &&
+	check_shallow_history_advice origin/main "$oid" \
+		"git fetch --deepen=1 origin main"
+'
+
+test_expect_success 'shallowHistory advice accounts for depth already present' '
+	test_commit shallow_partial_1 &&
+	test_commit shallow_partial_2 &&
+	test_commit shallow_partial_3 &&
+	test_commit shallow_partial_4 &&
+	test_commit shallow_partial_5 &&
+	test_commit shallow_partial_6 &&
+	git clone --no-local --depth=3 --branch main --single-branch \
+		.git shallow-advice-partial &&
+	test_when_finished "rm -rf shallow-advice-partial" &&
+	(
+		cd shallow-advice-partial &&
+		oid=$(git rev-parse --short origin/main~2) &&
+		test_must_fail git rev-parse origin/main~5 2>err &&
+		check_shallow_history_advice origin/main "$oid" \
+			"git fetch --deepen=3 origin main" &&
+		git fetch --deepen=3 origin &&
+		git rev-parse origin/main~5 &&
+		test_must_fail git rev-parse origin/main~6
+	)
+'
+
+test_expect_success 'shallowHistory advice on ^N (first parent) beyond shallow boundary' '
+	test_commit shallow_caret_1 &&
+	test_commit shallow_caret_2 &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice-caret &&
+	test_when_finished "rm -rf shallow-advice-caret" &&
+	oid=$(git -C shallow-advice-caret rev-parse --short origin/main) &&
+	test_must_fail git -C shallow-advice-caret rev-parse origin/main^1 2>err &&
+	check_shallow_history_advice origin/main "$oid" \
+		"git fetch --deepen=1 origin main"
+'
+
+test_expect_success 'shallowHistory advice on ^N suggests deepen=1 even for a merge parent' '
+	test_commit shallow_merge_base &&
+	git checkout -q -b shallow-merge-side &&
+	test_commit shallow_merge_side1 &&
+	git checkout -q main &&
+	test_commit shallow_merge_main1 &&
+	git merge -q --no-ff shallow-merge-side -m "shallow merge commit" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice-merge &&
+	test_when_finished "rm -rf shallow-advice-merge" &&
+	(
+		cd shallow-advice-merge &&
+		oid=$(git rev-parse --short origin/main) &&
+		test_must_fail git rev-parse origin/main^2 2>err &&
+		check_shallow_history_advice origin/main "$oid" \
+			"git fetch --deepen=1 origin main" &&
+		git fetch -q --deepen=1 origin &&
+		git rev-parse origin/main^1 &&
+		git rev-parse origin/main^2
+	)
+'
+
+test_expect_success 'shallowHistory advice can be disabled' '
+	test_commit shallow_off_1 &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice-off &&
+	test_when_finished "rm -rf shallow-advice-off" &&
+	test_must_fail git -C shallow-advice-off \
+		-c advice.shallowHistory=false rev-parse origin/main~1 2>err &&
+	test_grep ! "^hint:" err
+'
+
+test_expect_success 'shallowHistory advice not shown for a non-shallow repository' '
+	test_must_fail git rev-parse HEAD~100000 2>err &&
+	test_grep ! "^hint:" err
+'
+
+test_expect_success 'shallowHistory advice not shown when resolution succeeds' '
+	test_commit shallow_ok_1 &&
+	test_commit shallow_ok_2 &&
+	test_commit shallow_ok_3 &&
+	git clone --no-local --depth=3 --branch main --single-branch \
+		.git shallow-advice-ok &&
+	test_when_finished "rm -rf shallow-advice-ok" &&
+	git -C shallow-advice-ok rev-parse origin/main~1 >actual 2>err &&
+	test_grep ! "^hint:" err
+'
+
 test_expect_success 'rev-parse --show-object-format in repo' '
 	test_oid algo >expect &&
 	git rev-parse --show-object-format >actual &&
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 06552a6271..ad22934c9d 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2452,4 +2452,77 @@ test_expect_success 'log --invert-grep --grep --author' '
 	test_cmp expect actual
 '
 
+check_log_shallow_history_advice () {
+	oid=$1 &&
+	grep '^hint:' err >actual &&
+	cat >expect <<-EOF &&
+	hint: 'git log' stopped at $oid because this repository is a shallow
+	hint: clone, and might have more history upstream that was never fetched.
+	hint: Disable this message with "git config set advice.shallowHistory false"
+	EOF
+	test_cmp expect actual
+}
+
+test_expect_success 'set up linear history for shallow log advice tests' '
+	git checkout --orphan loghist &&
+	test_commit loghist_1 &&
+	test_commit loghist_2 &&
+	test_commit loghist_3 &&
+	test_commit loghist_4 &&
+	test_commit loghist_5 &&
+	git checkout main
+'
+
+test_expect_success 'log -<n> advises when it runs out of history at a shallow boundary' '
+	git clone --no-local --depth=2 --branch loghist --single-branch \
+		.git shallow-log-advice &&
+	test_when_finished "rm -rf shallow-log-advice" &&
+	oid=$(git -C shallow-log-advice rev-parse --short origin/loghist~1) &&
+	git -C shallow-log-advice log -5 --oneline origin/loghist >out 2>err &&
+	check_log_shallow_history_advice "$oid"
+'
+
+test_expect_success 'log --since advises when it runs out of history at a shallow boundary' '
+	git clone --no-local --depth=2 --branch loghist --single-branch \
+		.git shallow-log-advice-since &&
+	test_when_finished "rm -rf shallow-log-advice-since" &&
+	oid=$(git -C shallow-log-advice-since rev-parse --short origin/loghist~1) &&
+	git -C shallow-log-advice-since log --since=2000-01-01 --oneline \
+		origin/loghist >out 2>err &&
+	check_log_shallow_history_advice "$oid"
+'
+
+test_expect_success 'log without -<n> or --since does not advise at a shallow boundary' '
+	git clone --no-local --depth=1 --branch loghist --single-branch \
+		.git shallow-log-plain &&
+	test_when_finished "rm -rf shallow-log-plain" &&
+	git -C shallow-log-plain log --oneline origin/loghist >out 2>err &&
+	test_grep ! "^hint:" err
+'
+
+test_expect_success 'log -<n> does not advise when satisfied within local history' '
+	git clone --no-local --depth=5 --branch loghist --single-branch \
+		.git shallow-log-satisfied &&
+	test_when_finished "rm -rf shallow-log-satisfied" &&
+	git -C shallow-log-satisfied log -2 --oneline origin/loghist >out 2>err &&
+	test_grep ! "^hint:" err
+'
+
+test_expect_success 'log -<n> shallow history advice can be disabled' '
+	git clone --no-local --depth=1 --branch loghist --single-branch \
+		.git shallow-log-off &&
+	test_when_finished "rm -rf shallow-log-off" &&
+	git -C shallow-log-off -c advice.shallowHistory=false \
+		log -5 --oneline origin/loghist >out 2>err &&
+	test_grep ! "^hint:" err
+'
+
+test_expect_success 'log -<n> does not advise in a non-shallow repository' '
+	test_when_finished "rm -rf non-shallow-log" &&
+	git init -q non-shallow-log &&
+	test_commit -C non-shallow-log only-commit &&
+	git -C non-shallow-log log -20 --oneline >out 2>err &&
+	test_grep ! "^hint:" err
+'
+
 test_done

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
gitgitgadget
