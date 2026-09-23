Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AE5519B6
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189770; cv=none; b=gEE6tUKfz+wQ1V8gFi9YBx20BGkIZwdmrx6TiLU1cyvF17VMuu7jAzMOp2ft1OUp8AEI2ZkIO+mEUXNH+HWZr+87K9yw3EgWd+gK9CvPXBHEak74dBta9rQNjwOP1nRENw4z7o4WEiK3yqeRV6GBwyWMcSr4a3xo/cIWci39pI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189770; c=relaxed/simple;
	bh=Hrx0x280ipIQRLlf/wbj/pG9vhj8vLeveeNcGFggg6I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nUcm51Fxav9Gs6pmCamBE7qSei2+Pb6sPUaF4rmSnhpjfYDslaP9+FzxAEYtdGyyD+5Exll+UhS8pgYVQ4H2Aqzbsa5kJ0StQNwwWCnvOGIUtjGvP3/KzHuG15fx6cbQ0iIEoQx//QOykDnOf50w2SQlic5u7nFSZhpd0H+NK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJynJMgY; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJynJMgY"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76906adso22015201cf.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790189761; x=1790794561; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CFZ3ySbQGj5cdmtRQVkscUJM+pSImBl7Rl8RjVpGk28=;
        b=RJynJMgYdlbquoiVoU6bh8H7TPvfwxn1vI4vHxglkzIHp47ejONsdBaps7aO8FyL8T
         wIJLgoXSpFxFPP8c3wKvKa808dEi0gcu28mTnzH2yg7hO9dEFdrVatnidhyh7oVqSz/M
         Y0yFuPq6l6W/KSJ77ktDANJC+k+16JdyHWhh+rJgMfSCdoMtV0LLfq3U1Odvo3bCqWH9
         YpD5MmKh8hTe9fFjrQ/aef+UnjVDrI3OZHbg/H7ui2nkhh8io1nA+LVgcuJnojEB+2/f
         xv9dUSVif75FE0RKrOThg0JabbkHLarzRQVsE6VyqIILWBkNdNJfvah742GIPK3mt0eM
         Hyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790189761; x=1790794561;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CFZ3ySbQGj5cdmtRQVkscUJM+pSImBl7Rl8RjVpGk28=;
        b=XAbXc+PrE8+hfy4A7v169n6wqWeMf5ZTPDVLNEM2a/SWywEv1yBZkM2I4j0atxCZ2m
         XH7O8C4fQvHAa0CKnYN8Lt+vJ/Gawxbu8OZXu39XAHRA1g+6Qtglno4G/AMgeKL9sB0j
         zC/eeaILVk5xrr2gHseWynL5o7Fk5KOvli4eiy+2Jf/ctX3SCiiz7YA3aJ1Bv0yi6e/q
         KgVfZoqwkUlf71zqEFZ+qv6z0UZ4aKYQfw8DzrGQSc1xvIoc+iyKClr6FjsGkSPksmDr
         8xstHjClmtoufVgTVCajMduzVHTQ9Hn/RjMaCZ3GVSrsVbfB3jRGXY7pmbsFLt7M1CoQ
         ExhQ==
X-Gm-Message-State: AFuF++nm/TIrdRSqmfqI0lu0CyhEVBk7vL1U4rO6r4dCwBnw3PsLZ/ZK
	I70970lX5fZk9X+FLPQLIzuYFTNQ8rcESKcY78TeIkyJSws1MtbY2AlU82fNS2bM
X-Gm-Gg: AYBFou0Dfc+oInU5y8c2Du7boYR+Hm6jrWFO5hemHsH/Mz44ZMHNoPx296F31jI374z
	RU8q7VCOtqiOC0ZJwLwHU4IZb4IMVrYlCoTC6BCkdhglPPGNLIaugdspiTOgCs69J3oyUkoItNQ
	Tmp3ilqSKFVZ7bTNWYriDWwHZgvl1T7c1wq1uaVecsnKTTlFAVrRo5TRrNKyL9BERHjws+k97gs
	k66y1Jffc0Dmy+AGNJaU7RE5/PI6nvIOzbMn9Mfo4muIJzVdVeO53j8z8yNdkdb9QRgvJJTyKa7
	UMxHQ7FmNIo3eRiR4FuC1+i+W0ngeX2fksW0bT8Gcyx+/H1QrjT/RDhcATAwTDire31SDX1AFdo
	ZzW36EaftGQGfYQ2HhCMmtgEfXs/RnBF8Gm8/96+gYSbDETRaqsNjPybVwTyBmGmb5LrgC21d5/
	qg2fOilKDuw11N3vHByJ0DZ9LILt3Ut/STWVtmEjt6ck9ITzDHzMkQ3E8SXEvUxD436dP0yT6d
X-Received: by 2002:a05:6214:488f:b0:90e:9aa2:5169 with SMTP id 6a1803df08f44-9141e7befd2mr1161306d6.7.1790189760851;
        Wed, 23 Sep 2026 11:56:00 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.55.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e0d9fcbsm1195006d6.5.2026.09.23.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:56:00 -0700 (PDT)
Message-Id: <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
In-Reply-To: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Sep 2026 18:55:59 +0000
Subject: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
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

The advice is threaded through GET_OID_QUIETLY so it is not shown
during the internal re-resolution some commands do while building a
better error message, which would otherwise print it twice for the
same failing argument. A chained <rev>^^^ resolves one parent at a
time, and each step re-resolves everything before it through a fresh,
always non-quiet lookup, so a chained caret landing past a shallow
boundary printed the hint twice instead of once. Thread the quiet bit
through that inner lookup too, so it stays quiet exactly when the
outer resolution asked it to.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    object-name: explain why ~N fails in a shallow clone
    
    Asking for a commit's ancestor with <rev>~N in a shallow clone that
    doesn't have N commits of history locally fails with a "is not a commit"
    error, with no indication that the repository being shallow is the
    reason.
    
    Changes in v3:
    
     * Drop the git log -<n>/--since extension entirely, per feedback that
       last commit shown is an unreliable signal for a shallow boundary.
     * Fix a bug for chained <rev>^^^ where it would print the hint twice.
    
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2413%2FHaraldNordgren%2Fshallow-history-advice-hint-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2413/HaraldNordgren/shallow-history-advice-hint-v3
Pull-Request: https://github.com/git/git/pull/2413

Range-diff vs v2:

 1:  305d22d33e ! 1:  d5f2128258 shallow: advise when a walk stops at a shallow boundary
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    shallow: advise when a walk stops at a shallow boundary
     +    object-name: explain why <rev>~N fails in a shallow clone
      
          Asking for a commit's ancestor with <rev>~N in a shallow clone that
          does not have N commits of history locally fails with a bare "is not
          a commit" error, with no indication that the repository being shallow
          is the reason, or what to do about it.
      
     -    git log -<n> and git log --since=<date> have the opposite problem.
     -    Instead of failing, they silently stop once they reach the shallow
     -    boundary, with no error and nothing to suggest that more history
     -    exists upstream and simply was not fetched.
     -
          Add a hint, shown when a walk runs out of parents exactly at a
          recorded shallow boundary, not merely because the repository happens
          to be shallow elsewhere. When the revision <rev> is given as a
     @@ Commit message
          boundary, and only the remote knows for certain whether deepening
          would fetch anything new.
      
     -    git log -<n> and git log --since only show the hint when the last
     -    commit they printed is that same recorded boundary. A plain git log
     -    running out of history, or a git log -<n> or --since that is satisfied
     -    well before reaching the boundary, stays silent as before. When the
     -    output is paginated, the hint waits for the pager to close before
     -    printing, since a full screen pager like less otherwise wipes it from
     -    the terminal along with the rest of the output the moment it quits.
     -
          The advice is threaded through GET_OID_QUIETLY so it is not shown
          during the internal re-resolution some commands do while building a
          better error message, which would otherwise print it twice for the
     -    same failing argument.
     +    same failing argument. A chained <rev>^^^ resolves one parent at a
     +    time, and each step re-resolves everything before it through a fresh,
     +    always non-quiet lookup, so a chained caret landing past a shallow
     +    boundary printed the hint twice instead of once. Thread the quiet bit
     +    through that inner lookup too, so it stays quiet exactly when the
     +    outer resolution asked it to.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ advice.h: enum advice_type {
       	ADVICE_SPARSE_INDEX_EXPANDED,
       	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
      
     - ## builtin/log.c ##
     -@@
     - #include "commit-reach.h"
     - #include "promisor-remote.h"
     - #include "range-diff.h"
     -+#include "shallow.h"
     - #include "tmp-objdir.h"
     - #include "tree.h"
     - #include "userdiff.h"
     -@@ builtin/log.c: static void cmd_log_init(int argc, const char **argv, const char *prefix,
     - 	cmd_log_init_finish(argc, argv, prefix, rev, opt, cfg);
     - }
     - 
     -+static void advise_if_log_stopped_at_shallow_boundary(struct rev_info *rev,
     -+						       struct commit *last_shown)
     -+{
     -+	if (!last_shown)
     -+		return;
     -+	/* a plain "git log" running out of history is expected */
     -+	if (rev->max_count < 0 && rev->max_age == (timestamp_t)-1)
     -+		return;
     -+	if (!is_repository_shallow(the_repository))
     -+		return;
     -+	if (!commit_is_shallow_boundary(the_repository, &last_shown->object.oid))
     -+		return;
     -+	wait_for_pager();
     -+	advise_if_enabled(ADVICE_SHALLOW_HISTORY,
     -+			   _("'%s' stopped at %s because this repository is a shallow\n"
     -+			     "clone, and might have more history upstream that was never fetched."),
     -+			   "git log",
     -+			   repo_find_unique_abbrev(the_repository,
     -+						    &last_shown->object.oid,
     -+						    DEFAULT_ABBREV));
     -+}
     -+
     - static int cmd_log_walk_no_free(struct rev_info *rev)
     - {
     - 	struct commit *commit;
     -+	struct commit *last_shown = NULL;
     - 	int saved_nrl = 0;
     - 	int saved_dcctc = 0;
     - 	int result;
     -@@ builtin/log.c: static int cmd_log_walk_no_free(struct rev_info *rev)
     - 	 * retain that state information if replacing rev->diffopt in this loop
     - 	 */
     - 	while ((commit = get_revision(rev)) != NULL) {
     -+		last_shown = commit;
     - 		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
     - 			/*
     - 			 * We decremented max_count in get_revision,
     -@@ builtin/log.c: static int cmd_log_walk_no_free(struct rev_info *rev)
     - 		if (rev->diffopt.degraded_cc_to_c)
     - 			saved_dcctc = 1;
     - 	}
     -+	advise_if_log_stopped_at_shallow_boundary(rev, last_shown);
     - 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
     - 	rev->diffopt.needed_rename_limit = saved_nrl;
     - 
     -
       ## object-name.c ##
      @@
       #include "repo-settings.h"
     @@ object-name.c: static int get_oid_basic(struct repository *r, const char *str, i
       {
       	struct object_id oid;
       	enum get_oid_result ret = get_oid_1(r, name, len, &oid,
     +-					    GET_OID_COMMITTISH);
     ++					    GET_OID_COMMITTISH |
     ++					    (lookup_flags & GET_OID_QUIETLY));
     + 	struct commit *commit;
     + 	struct commit_list *p;
     + 
      @@ object-name.c: static enum get_oid_result get_parent(struct repository *r,
       		}
       		p = p->next;
     @@ object-name.c: static enum get_oid_result get_parent(struct repository *r,
       {
       	struct object_id oid;
       	struct commit *commit;
     + 	int ret;
     + 
     +-	ret = get_oid_1(r, name, len, &oid, GET_OID_COMMITTISH);
     ++	ret = get_oid_1(r, name, len, &oid,
     ++			GET_OID_COMMITTISH | (lookup_flags & GET_OID_QUIETLY));
     + 	if (ret)
     + 		return ret;
     + 	commit = lookup_commit_reference(r, &oid);
      @@ object-name.c: static enum get_oid_result get_nth_ancestor(struct repository *r,
       		return MISSING_OBJECT;
       
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
      +		"git fetch --deepen=1 origin main"
      +'
      +
     ++test_expect_success 'shallowHistory advice on chained ^ shows the hint only once' '
     ++	test_commit shallow_chain_1 &&
     ++	git clone --no-local --depth=1 --branch main --single-branch \
     ++		.git shallow-advice-chain &&
     ++	test_when_finished "rm -rf shallow-advice-chain" &&
     ++	oid=$(git -C shallow-advice-chain rev-parse --short origin/main) &&
     ++	test_must_fail git -C shallow-advice-chain rev-parse origin/main^^ 2>err &&
     ++	check_shallow_history_advice origin/main "$oid" \
     ++		"git fetch --deepen=1 origin main"
     ++'
     ++
      +test_expect_success 'shallowHistory advice on ^N suggests deepen=1 even for a merge parent' '
      +	test_commit shallow_merge_base &&
      +	git checkout -q -b shallow-merge-side &&
     @@ t/t1500-rev-parse.sh: test_expect_success 'rev-parse --is-shallow-repository in
       test_expect_success 'rev-parse --show-object-format in repo' '
       	test_oid algo >expect &&
       	git rev-parse --show-object-format >actual &&
     -
     - ## t/t4202-log.sh ##
     -@@ t/t4202-log.sh: test_expect_success 'log --invert-grep --grep --author' '
     - 	test_cmp expect actual
     - '
     - 
     -+check_log_shallow_history_advice () {
     -+	oid=$1 &&
     -+	grep '^hint:' err >actual &&
     -+	cat >expect <<-EOF &&
     -+	hint: 'git log' stopped at $oid because this repository is a shallow
     -+	hint: clone, and might have more history upstream that was never fetched.
     -+	hint: Disable this message with "git config set advice.shallowHistory false"
     -+	EOF
     -+	test_cmp expect actual
     -+}
     -+
     -+test_expect_success 'set up linear history for shallow log advice tests' '
     -+	git checkout --orphan loghist &&
     -+	test_commit loghist_1 &&
     -+	test_commit loghist_2 &&
     -+	test_commit loghist_3 &&
     -+	test_commit loghist_4 &&
     -+	test_commit loghist_5 &&
     -+	git checkout main
     -+'
     -+
     -+test_expect_success 'log -<n> advises when it runs out of history at a shallow boundary' '
     -+	git clone --no-local --depth=2 --branch loghist --single-branch \
     -+		.git shallow-log-advice &&
     -+	test_when_finished "rm -rf shallow-log-advice" &&
     -+	oid=$(git -C shallow-log-advice rev-parse --short origin/loghist~1) &&
     -+	git -C shallow-log-advice log -5 --oneline origin/loghist >out 2>err &&
     -+	check_log_shallow_history_advice "$oid"
     -+'
     -+
     -+test_expect_success 'log --since advises when it runs out of history at a shallow boundary' '
     -+	git clone --no-local --depth=2 --branch loghist --single-branch \
     -+		.git shallow-log-advice-since &&
     -+	test_when_finished "rm -rf shallow-log-advice-since" &&
     -+	oid=$(git -C shallow-log-advice-since rev-parse --short origin/loghist~1) &&
     -+	git -C shallow-log-advice-since log --since=2000-01-01 --oneline \
     -+		origin/loghist >out 2>err &&
     -+	check_log_shallow_history_advice "$oid"
     -+'
     -+
     -+test_expect_success 'log without -<n> or --since does not advise at a shallow boundary' '
     -+	git clone --no-local --depth=1 --branch loghist --single-branch \
     -+		.git shallow-log-plain &&
     -+	test_when_finished "rm -rf shallow-log-plain" &&
     -+	git -C shallow-log-plain log --oneline origin/loghist >out 2>err &&
     -+	test_grep ! "^hint:" err
     -+'
     -+
     -+test_expect_success 'log -<n> does not advise when satisfied within local history' '
     -+	git clone --no-local --depth=5 --branch loghist --single-branch \
     -+		.git shallow-log-satisfied &&
     -+	test_when_finished "rm -rf shallow-log-satisfied" &&
     -+	git -C shallow-log-satisfied log -2 --oneline origin/loghist >out 2>err &&
     -+	test_grep ! "^hint:" err
     -+'
     -+
     -+test_expect_success 'log -<n> shallow history advice can be disabled' '
     -+	git clone --no-local --depth=1 --branch loghist --single-branch \
     -+		.git shallow-log-off &&
     -+	test_when_finished "rm -rf shallow-log-off" &&
     -+	git -C shallow-log-off -c advice.shallowHistory=false \
     -+		log -5 --oneline origin/loghist >out 2>err &&
     -+	test_grep ! "^hint:" err
     -+'
     -+
     -+test_expect_success 'log -<n> does not advise in a non-shallow repository' '
     -+	test_when_finished "rm -rf non-shallow-log" &&
     -+	git init -q non-shallow-log &&
     -+	test_commit -C non-shallow-log only-commit &&
     -+	git -C non-shallow-log log -20 --oneline >out 2>err &&
     -+	test_grep ! "^hint:" err
     -+'
     -+
     - test_done


 Documentation/config/advice.adoc |   4 +
 advice.c                         |   1 +
 advice.h                         |   1 +
 object-name.c                    | 131 +++++++++++++++++++++++++++++--
 shallow.c                        |   8 ++
 shallow.h                        |   8 ++
 t/t1500-rev-parse.sh             | 120 ++++++++++++++++++++++++++++
 7 files changed, 266 insertions(+), 7 deletions(-)

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
diff --git a/object-name.c b/object-name.c
index 4eda8c8eac..7376c24601 100644
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
@@ -824,13 +825,120 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
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
-					    GET_OID_COMMITTISH);
+					    GET_OID_COMMITTISH |
+					    (lookup_flags & GET_OID_QUIETLY));
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -851,19 +959,22 @@ static enum get_oid_result get_parent(struct repository *r,
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
 	int ret;
 
-	ret = get_oid_1(r, name, len, &oid, GET_OID_COMMITTISH);
+	ret = get_oid_1(r, name, len, &oid,
+			GET_OID_COMMITTISH | (lookup_flags & GET_OID_QUIETLY));
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(r, &oid);
@@ -871,8 +982,14 @@ static enum get_oid_result get_nth_ancestor(struct repository *r,
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
@@ -1119,9 +1236,9 @@ static enum get_oid_result get_oid_1(struct repository *r,
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
index 4174ca40c3..fbb6e6e582 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -193,6 +193,126 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
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
+test_expect_success 'shallowHistory advice on chained ^ shows the hint only once' '
+	test_commit shallow_chain_1 &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice-chain &&
+	test_when_finished "rm -rf shallow-advice-chain" &&
+	oid=$(git -C shallow-advice-chain rev-parse --short origin/main) &&
+	test_must_fail git -C shallow-advice-chain rev-parse origin/main^^ 2>err &&
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

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget
