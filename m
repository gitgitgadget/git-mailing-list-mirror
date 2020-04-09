Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C5C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3952084D
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 00:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZDXbNtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDIABu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:01:50 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55913 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgDIABt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 20:01:49 -0400
Received: by mail-wm1-f43.google.com with SMTP id e26so1925868wmk.5
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7R6IKhz7PcPMs00zXt6hHUTS7OtcBZBO7FAf6kDUC58=;
        b=JZDXbNtCQutDKowQ5Bi+N8Z4UIOylX7PJ05J6G1O9gCBvmo/CXfxGvIM7TItk3y5Ko
         /PrIXrXRJU/O+lVEl/cSORqWP4c9Ta159yEF7UU8egLCCL5uSKh49TdDlchC44c3wC7J
         159VjhSFWNiHmn8O0IcntLPRiwKWkGTs7Jbm44og2DgAzeU5SZ6cVSuXV0rzlJQ3f1JL
         fIb0anWZx2L3K67Pio2eSbs/NMA6cf4rc3S1TQHKsGlSkb6SICV8ZFdlyyrdIXzynpL1
         aWskf68cbxReE8lcLUIwTvLT732cvsE1O5x6x3tAFt5HQpG4c4PfjZ/X4DCjEGVKoOYz
         /YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7R6IKhz7PcPMs00zXt6hHUTS7OtcBZBO7FAf6kDUC58=;
        b=SBxwKTBTXSUN/PGlo8Qwjd+y4aA+trnUjFD88k0grgXbXFSFpHQtPUxIvtaRzIaIqu
         fxvcCaauqBPBpv0VS52uM/2gK9O/auN4M95NhbBOjdCnTK2exMF7bEB9fQHE90zjoTN2
         WMxKuq9odeY3MIU8BGM2e7jMcqXT4FtPm/UI35b4D/oEguS8jBywy5zSRaBfgo7qml3S
         ylULsxqwytwcmcXFUJq41s0qEIrzFN4n/5UKQHeJmi9UKDB0BlJlZt9cASsOuQwr15Wr
         59bprNMdZOeM8xbUyJqEZ+zpKw1BVuksTlI6mWuTcenYvfAFi4WIsMNG6P+rsDLoJGIV
         oKJg==
X-Gm-Message-State: AGi0PubSzvcGEu/Z/f3ex0cpfi4OQKAU7usk3fkeeEyS4Fyad904JE03
        0lWIlmWglEsSFEbfdJntRBsq3W3F
X-Google-Smtp-Source: APiQypLhEHFGLDjgKixLaJhDDAyot4nJiUv6PxZRh+4f8PdiTreyivO3hqTPoXv8+e9fXy+8zSmbXQ==
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr6974046wmj.22.1586390502566;
        Wed, 08 Apr 2020 17:01:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm1440198wmn.10.2020.04.08.17.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 17:01:42 -0700 (PDT)
Message-Id: <pull.599.v2.git.1586390501128.gitgitgadget@gmail.com>
In-Reply-To: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 00:01:40 +0000
Subject: [PATCH v2] revision: --include-diversions adds helpful merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The default file history simplification of "git log -- <path>" or
"git rev-list -- <path>" focuses on providing the smallest set of
commits that first contributed a change. The revision walk greatly
restricts the set of walked commits by visiting only the first
TREESAME parent of a merge commit, when one exists. This means
that portions of the commit-graph are not walked, which can be a
performance benefit, but can also "hide" commits that added changes
but were ignored by a merge resolution.

The --full-history option modifies this by walking all commits and
reporting a merge commit as "interesting" if it has _any_ parent
that is not TREESAME. This tends to be an over-representation of
important commits, especially in an environment where most merge
commits are created by pull request completion.

Suppose we have a commit A and we create a commit B on top that
changes our file. When we merge the pull request, we create a merge
commit M. If no one else changed the file in the first-parent
history between M and A, then M will not be TREESAME to its first
parent, but will be TREESAME to B. Thus, the simplified history
will be "B". However, M will appear in the --full-history mode.

However, suppose that a number of topics T1, T2, ..., Tn were
created based on commits C1, C2, ..., Cn between A and M as
follows:

  A----C1----C2--- ... ---Cn----M------P1---P2--- ... ---Pn
   \     \     \            \  /      /    /            /
    \     \__.. \            \/ ..__T1    /           Tn
     \           \__..       /\     ..__T2           /
      \_____________________B  \____________________/

If the commits T1, T2, ... Tn did not change the file, then all of
P1 through Pn will be TREESAME to their first parent, but not
TREESAME to their second. This means that all of those merge commits
appear in the --full-history view, with edges that immediately
collapse into the lower history without introducing interesting
single-parent commits.

The --simplify-merges option was introduced to remove these extra
merge commits. By noticing that the rewritten parents are reachable
from their first parents, those edges can be simplified away. Finally,
the commits now look like single-parent commits that are TREESAME to
their "only" parent. Thus, they are removed and this issue does not
cause issues anymore. However, this also ends up removing the commit
M from the history view! Even worse, the --simplify-merges option
requires walking the entire history before returning a single result.

Many Git users are using Git alongside a Git service that provides
code storage alongside a code review tool commonly called "Pull
Requests" or "Merge Requests" against a target branch.  When these
requests are accepted and merged, they typically create a merge
commit whose first parent is the previous branch tip and the second
parent is the tip of the topic branch used for the request. This
presents a valuable order to the parents, but also makes that merge
commit slightly special. Users may want to see not only which
commits changed a file, but which pull requests merged those commits
into their branch. In the previous example, this would mean the
users want to see the merge commit "M" in addition to the single-
parent commit "C".

Users are even more likely to want these merge commits when they
use pull requests to merge into a feature branch before merging that
feature branch into their trunk.

In some sense, users are asking for the "first" merge commit to
bring in the change to their branch. As long as the parent order is
consistent, this can be handled with the following rule:

  Include a merge commit if it is not TREESAME to its first
  parent, but is TREESAME to a later parent.

I call such merge commits "diversions" because they divert the
history walk away from the first-parent history. As such, this
change adds the "--include-diversions" option to rev-list and log.
To test these options, extend the standard test example to include
a merge commit that is not TREESAME to its first parent. It is
surprising that that option was not already in the example, as it
is instructive.

In particular, this extension demonstrates a common issue with file
history simplification. When a user resolves a merge conflict using
"-Xours" or otherwise ignoring one side of the conflict, they create
a TREESAME edge that probably should not be TREESAME. This leads
users to become frustrated and complain that "my change disappeared!"
In my experience, showing them history with --full-history and
--simplify-merges quickly reveals the problematic merge. As mentioned,
this option is expensive to compute. The --include-diversions option
_might_ show the merge commit (usually titled "resolving conflicts")
more quickly. Of course, this depends on the user having the correct
parent order, which is backwards when using "git pull".

There are some special considerations when combining the
--include-diversions option with --simplify-merges. This requires
adding a new DIVERSION object flag to store the information from
the initial TREESAME comparisons. This helps avoid dropping those
commits in later filters. This is covered by a test, including how
the parents can be simplified. Since "struct object" has already
ruined its 32-bit alignment by using 33 bits across parsed, type,
and flags member, let's not make it worse. DIVERSION is used in
revision.c with the same value (1u<<15) as REACHABLE in
commit-graph.c. The REACHABLE flag is only used when writing a
commit-graph file, and a revision walk using --include-diversions
does not happen in the same process. Care must be taken in the
future to ensure this remains the case.

Update Documentation/rev-list-options.txt with significant details
around this option. This requires updating the example in the
History Simplification section to demonstrate some of the problems
with TREESAME second parents.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    Add a new history mode
    
    This --include-diversions option could use a better name.
    
    An experienced developer in the Windows OS Engineering Systems team
    pointed out how hard it is to find out when a change was "introduced" in
    the Windows OS repo. Due to their multi-leveled, long-lived branch
    organization, a commit could be part of hundreds of pull requests as the
    branches are merged across the organization.
    
    My default answer was "this is complicated not because of Git, but
    because of how you are branching." I then tried to explain how finding
    the "first merge" to include a commit is incredibly difficult and
    requires performing multiple reachability queries. As I was working it
    out on paper, I realized that was true if we relied only on the
    commit-graph shape to inform our qurey.
    
    If we use the TREESAME information, then suddenly we get a much clearer
    picture! Let's simply pick out those merge commits that "introduced a
    change" because they are TREESAME to a non-first-parent (and not
    TREESAME to the first parent).
    
    My name of "diversions" could probably use some work, but I like the
    basic concept of this option.
    
    I welcome any and all feedback. Thanks!
    
    UPDATES in v2:
    
     * The functionality is a bit more complicated to work with
       --simplify-merges.
       
       
     * The documentation is significantly expanded with an example that
       highlights the shortcomings of the default history simplification.
       
       
     * The documented example is used in the test script instead of simply
       extending the previous example.
       
       
    
    -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-599%2Fderrickstolee%2Fnew-history-mode-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-599/derrickstolee/new-history-mode-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/599

Range-diff vs v1:

 1:  8bf93688392 ! 1:  146c443e7f1 revision: --include-diversions adds helpful merges
     @@ Commit message
          more quickly. Of course, this depends on the user having the correct
          parent order, which is backwards when using "git pull".
      
     +    There are some special considerations when combining the
     +    --include-diversions option with --simplify-merges. This requires
     +    adding a new DIVERSION object flag to store the information from
     +    the initial TREESAME comparisons. This helps avoid dropping those
     +    commits in later filters. This is covered by a test, including how
     +    the parents can be simplified. Since "struct object" has already
     +    ruined its 32-bit alignment by using 33 bits across parsed, type,
     +    and flags member, let's not make it worse. DIVERSION is used in
     +    revision.c with the same value (1u<<15) as REACHABLE in
     +    commit-graph.c. The REACHABLE flag is only used when writing a
     +    commit-graph file, and a revision walk using --include-diversions
     +    does not happen in the same process. Care must be taken in the
     +    future to ensure this remains the case.
     +
     +    Update Documentation/rev-list-options.txt with significant details
     +    around this option. This requires updating the example in the
     +    History Simplification section to demonstrate some of the problems
     +    with TREESAME second parents.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/rev-list-options.txt ##
     @@ Documentation/rev-list-options.txt: Default mode::
       --full-history::
       	Same as the default mode, but does not prune some history.
       
     +@@ Documentation/rev-list-options.txt: Note the major differences in `N`, `P`, and `Q` over `--full-history`:
     +   parent and is TREESAME.
     + --
     + 
     +-Finally, there is a fifth simplification mode available:
     ++There is another simplification mode available:
     + 
     + --ancestry-path::
     + 	Limit the displayed commits to those directly on the ancestry
     +@@ Documentation/rev-list-options.txt: option does. Applied to the 'D..M' range, it results in:
     + 				L--M
     + -----------------------------------------------------------------------
     + 
     ++Before discussing another option, `--include-diversions`, we need to
     ++create a new example history.
     +++
     ++A common problem users face when looking at simplified history is that a
     ++commit they know changed a file somehow does not appear in the file's
     ++simplified history. Let's demonstrate a new example and show how options
     ++such as `--full-history` and `--simplify-merges` works in that case:
     +++
     ++-----------------------------------------------------------------------
     ++	  .-A---M-----C--N---O---P
     ++	 /     / \  \  \/   /   /
     ++	I     B   \  R-'`-Z'   /
     ++	 \   /     \/         /
     ++	  \ /      /\        /
     ++	   `---X--'  `---Y--'
     ++-----------------------------------------------------------------------
     +++
     ++For this example, suppose `I` created `file.txt` which was modified by
     ++`A`, `B`, and `X` in different ways. The single-parent commits `C`, `Z`,
     ++and `Y` do not change `file.txt`. The merge commit `M` was created by
     ++resolving the merge conflict to include both changes from `A` and `B`
     ++and hence is not TREESAME to either. The merge commit `R`, however, was
     ++created by ignoring the contents of `file.txt` at `M` and taking only
     ++the contents of `file.txt` at `X`. Hence, `R` is TREESAME to `X` but not
     ++`M`. Finally, the natural merge resolution to create `N` is to take the
     ++contents of `file.txt` at `R`, so `N` is TREESAME to `R` but not `C`.
     ++The merge commits `O` and `P` are TREESAME to their first parents, but
     ++not to their second parents, `Z` and `Y` respectively.
     +++
     ++When using the default mode, `N` and `R` both have a TREESAME parent, so
     ++those edges are walked and the others are ignored. The resulting history
     ++graph is:
     +++
     ++-----------------------------------------------------------------------
     ++	I---X
     ++-----------------------------------------------------------------------
     +++
     ++When using `--full-history`, Git walks every edge. This will discover
     ++the commits `A` and `B` and the merge `M`, but also will reveal the
     ++merge commits `O` and `P`. With parent rewriting, the resulting graph is:
     +++
     ++-----------------------------------------------------------------------
     ++	  .-A---M--------N---O---P
     ++	 /     / \  \  \/   /   /
     ++	I     B   \  R-'`--'   /
     ++	 \   /     \/         /
     ++	  \ /      /\        /
     ++	   `---X--'  `------'
     ++-----------------------------------------------------------------------
     +++
     ++Here, the merge commits `O` and `P` contribute extra noise, as they did
     ++not actually contribute a change to `file.txt`. They only merged a topic
     ++that was based on an older version of `file.txt`. This is a common
     ++issue in repositories using a workflow where many contributors work in
     ++parallel and merge their topic branches along a single trunk: manu
     ++unrelated merges appear in the `--full-history` results.
     +++
     ++When using the `--simplify-merges` option, the commits `O` and `P`
     ++disappear from the results. This is because the rewritten second parents
     ++of `O` and `P` are reachable from their first parents. Those edges are
     ++removed and then the commits look like single-parent commits that are
     ++TREESAME to their parent. This also happens to the commit `N`, resulting
     ++in a history view as follows:
     +++
     ++-----------------------------------------------------------------------
     ++	  .-A---M--.
     ++	 /     /    \
     ++	I     B      R
     ++	 \   /      /
     ++	  \ /      /
     ++	   `---X--'
     ++-----------------------------------------------------------------------
     +++
     ++In this view, we see all of the important single-parent changes from
     ++`A`, `B`, and `X`. We also see the carefully-resolved merge `M` and the
     ++not-so-carefully-resolved merge `R`. This is usually enough information
     ++to determine why the commits `A` and `B` "disappeared" from history in
     ++the default view. However, there are a few issues with this approach.
     +++
     ++The first issue is performance. Unlike any previous option, the
     ++`--simplify-merges` option requires walking the entire commit history
     ++before returning a single result. This can make the option difficult to
     ++use for very large repositories.
     +++
     ++The second issue is one of auditing. When many contributors are working
     ++on the same repository, it is important which merge commits introduced
     ++a change into an important branch. The problematic merge `R` above is
     ++not likely to be the merge commit that was used to merge into an
     ++important branch. Instead, the merge `N` was used to merge `R` and `X`
     ++into the important branch. This commit may have information about why
     ++the change `X` came to override the changes from `A` and `B` in its
     ++commit message.
     +++
     ++The `--include-diversions` option helps with both of these issues. A
     ++merge commit is considered a "diverter" if it is not TREESAME to its
     ++first parent but is TREESAME to a later parent. These merges "divert"
     ++the history walk to a second parent instead of continuing along the
     ++first-parent history as expected. When using `--include-diversions`
     ++on this example (and no other options) the resulting graph is:
     +++
     ++-----------------------------------------------------------------------
     ++	I---X---R---N
     ++-----------------------------------------------------------------------
     +++
     ++Here, the merge commits `R` and `N` are included because they diverted
     ++the walk away from their first-parent history. They are the reason the
     ++commits `A` and `B` do not appear in the history.
     +++
     ++When `--include-diversions` is paired with `--simplify-merges`, the
     ++graph includes all of the necessary information:
     +++
     ++-----------------------------------------------------------------------
     ++	  .-A---M--.   N
     ++	 /     /    \ /
     ++	I     B      R
     ++	 \   /      /
     ++	  \ /      /
     ++	   `---X--'
     ++-----------------------------------------------------------------------
     +++
     ++Notice that since `M` is reachable from `R`, the edge from `N` to `M`
     ++was simplified away. However, `N` still appears in the history as an
     ++important commit because it would divert a simplified history walk.
     ++
     + The `--simplify-by-decoration` option allows you to view only the
     + big picture of the topology of the history, by omitting commits
     + that are not referenced by tags.  Commits are marked as !TREESAME
     +
     + ## object.h ##
     +@@ object.h: struct object_array {
     + 
     + /*
     +  * object flag allocation:
     +- * revision.h:               0---------10                              25----28
     ++ * revision.h:               0---------10         15                   25----28
     +  * fetch-pack.c:             01
     +  * negotiator/default.c:       2--5
     +  * walker.c:                 0-2
      
       ## revision.c ##
      @@ revision.c: static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
     @@ revision.c: static void try_to_simplify_commit(struct rev_info *revs, struct com
       			return;
       
       		case REV_TREE_NEW:
     +@@ revision.c: static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
     + 				relevant_change = 1;
     + 			else
     + 				irrelevant_change = 1;
     ++
     ++			if (!nth_parent)
     ++				commit->object.flags |= DIVERSION;
     ++
     + 			continue;
     + 		}
     + 		die("bad tree compare for commit %s", oid_to_hex(&commit->object.oid));
      @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
       	} else if (!strcmp(arg, "--full-diff")) {
       		revs->diff = 1;
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, cons
       	} else if (!strcmp(arg, "--full-history")) {
       		revs->simplify_history = 0;
       	} else if (!strcmp(arg, "--relative-date")) {
     +@@ revision.c: static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
     + 	if (!cnt ||
     + 	    (commit->object.flags & UNINTERESTING) ||
     + 	    !(commit->object.flags & TREESAME) ||
     +-	    (parent = one_relevant_parent(revs, commit->parents)) == NULL)
     ++	    (parent = one_relevant_parent(revs, commit->parents)) == NULL ||
     ++	    (revs->diversions && (commit->object.flags & DIVERSION)))
     + 		st->simplified = commit;
     + 	else {
     + 		pst = locate_simplify_state(revs, parent);
     +@@ revision.c: enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
     + 			/* drop merges unless we want parenthood */
     + 			if (!want_ancestry(revs))
     + 				return commit_ignore;
     ++
     ++			if (revs->diversions && (commit->object.flags & DIVERSION))
     ++				return commit_show;
     ++
     + 			/*
     + 			 * If we want ancestry, then need to keep any merges
     + 			 * between relevant commits to tie together topology.
      
       ## revision.h ##
     +@@
     + #define SYMMETRIC_LEFT	(1u<<8)
     + #define PATCHSAME	(1u<<9)
     + #define BOTTOM		(1u<<10)
     ++
     ++/* WARNING: This is also used as REACHABLE in commit-graph.c. */
     ++#define DIVERSION	(1u<<15)
     + /*
     +  * Indicates object was reached by traversal. i.e. not given by user on
     +  * command-line or stdin.
     +@@
     +  */
     + #define NOT_USER_GIVEN	(1u<<25)
     + #define TRACK_LINEAR	(1u<<26)
     +-#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
     ++#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | DIVERSION)
     + 
     + #define TOPO_WALK_EXPLORED	(1u<<27)
     + #define TOPO_WALK_INDEGREE	(1u<<28)
      @@ revision.h: struct rev_info {
       			no_walk:2,
       			remove_empty_trees:1,
     @@ t/t6012-rev-list-simplify.sh: test_expect_success '--full-diff is not affected b
       '
       
      +#
     -+# Modify the test repo to add a merge whose first parent is not TREESAME
     -+# but whose second parent is TREESAME
     ++# Create a new history to demonstrate the value of --include-diversions
     ++# with respect to the subtleties of simplified history, --full-history,
     ++# and --simplify-merges.
     ++#
     ++#   .-A---M-----C--N---O---P
     ++#  /     / \  \  \/   /   /
     ++# I     B   \  R-'`-Z'   /
     ++#  \   /     \/         /
     ++#   \ /      /\        /
     ++#    `---X--'  `---Y--'
      +#
     -+# A--B----------G--H--I--K--L--N
     -+#  \  \           /     /     /
     -+#   \  \         /     /     /
     -+#    C------E---F     J     /
     -+#     \  \_/               /
     -+#      \                  /
     -+#       M-----------------
     -+test_expect_success 'expand graph' '
     -+	git switch -c branchM C &&
     -+	echo "new data" >file &&
     ++# This example is explained in Documentation/rev-list-options.txt
     ++
     ++test_expect_success 'rebuild repo' '
     ++	rm -rf .git * &&
     ++	git init &&
     ++	git switch -c main &&
     ++
     ++	echo base >file &&
      +	git add file &&
     -+	test_tick &&
     -+	test_commit M &&
     ++	test_commit I &&
      +
     -+	git checkout master &&
     -+	git merge -Xtheirs branchM -m "N" &&
     -+	note N
     ++	echo A >file &&
     ++	git add file &&
     ++	test_commit A &&
     ++
     ++	git switch -c branchB I &&
     ++	echo B >file &&
     ++	git add file &&
     ++	test_commit B &&
     ++
     ++	git switch main &&
     ++	test_must_fail git merge -m "M" B &&
     ++	echo A >file &&
     ++	echo B >>file &&
     ++	git add file &&
     ++	git merge --continue &&
     ++	note M &&
     ++
     ++	echo C >other &&
     ++	git add other &&
     ++	test_commit C &&
     ++
     ++	git switch -c branchX I &&
     ++	echo X >file &&
     ++	git add file &&
     ++	test_commit X &&
     ++
     ++	git switch -c branchR M &&
     ++	git merge -m R -Xtheirs X &&
     ++	note R &&
     ++
     ++	git switch main &&
     ++	git merge -m N R &&
     ++	note N &&
     ++
     ++	git switch -c branchY M &&
     ++	echo Y >y &&
     ++	git add y &&
     ++	test_commit Y &&
     ++
     ++	git switch -c branchZ C &&
     ++	echo Z >z &&
     ++	git add z &&
     ++	test_commit Z &&
     ++
     ++	git switch main &&
     ++	git merge -m O Z &&
     ++	note O &&
     ++
     ++	git merge -m P Y &&
     ++	note P
      +'
      +
     -+check_result 'M C A' -- file
     -+check_result 'N M C A' --include-diversions -- file
     -+
     -+check_result 'N M L K J I H F E D C G B A' --full-history --topo-order
     -+check_result 'N M L K I H G F E D C B J A' --full-history
     -+check_result 'N M L K I H G F E D C B J A' --full-history --date-order
     -+check_result 'N M L K I H G F E D B C J A' --full-history --author-date-order
     -+check_result 'N M K I H E C B A' --full-history -- file
     -+check_result 'N M K I H E C B A' --full-history --topo-order -- file
     -+check_result 'N M K I H E C B A' --full-history --date-order -- file
     -+check_result 'N M K I H E B C A' --full-history --author-date-order -- file
     -+check_result 'N M I E C B A' --simplify-merges -- file
     -+check_result 'N M I E C B A' --simplify-merges --topo-order -- file
     -+check_result 'N M I E C B A' --simplify-merges --date-order -- file
     -+check_result 'N M I E B C A' --simplify-merges --author-date-order -- file
     -+check_result 'M C A' --topo-order -- file
     -+check_result 'M C A' --date-order -- file
     -+check_result 'M C A' --author-date-order -- file
     -+check_result 'H' --first-parent -- another-file
     -+check_result 'H' --first-parent --topo-order -- another-file
     ++check_result 'X I' -- file
     ++check_result 'N R X I' --include-diversions -- file
     ++
     ++check_result 'P O N R X M B A I' --full-history --topo-order -- file
     ++check_result 'N R X M B A I' --simplify-merges --topo-order --include-diversions -- file
     ++check_result 'R X M B A I' --simplify-merges --topo-order -- file
     ++check_result 'N M A I' --first-parent -- file
     ++check_result 'N M A I' --first-parent --include-diversions -- file
     ++
     ++# --ancestry-path implies --full-history
     ++check_result 'P O N R M' --topo-order \
     ++	--ancestry-path A..HEAD -- file
     ++check_result 'P O N R M' --topo-order \
     ++	--include-diversions \
     ++	--ancestry-path A..HEAD -- file
     ++check_result 'P O N R M' --topo-order \
     ++	--full-history \
     ++	--ancestry-path A..HEAD -- file
     ++check_result 'R M' --topo-order \
     ++	--simplify-merges \
     ++	--ancestry-path A..HEAD -- file
     ++check_result 'N R M' --topo-order \
     ++	--simplify-merges --include-diversions \
     ++	--ancestry-path A..HEAD -- file
     ++
     ++test_expect_success 'log --graph --simplify-merges --include-diversions' '
     ++	cat >expect <<-\EOF &&
     ++	* N
     ++	*   R
     ++	|\  
     ++	| * X
     ++	* |   M
     ++	|\ \  
     ++	| * | B
     ++	| |/  
     ++	* / A
     ++	|/  
     ++	* I
     ++	EOF
     ++	git log --graph --pretty="%s" \
     ++		--simplify-merges --include-diversions \
     ++		-- file >actual &&
     ++	test_cmp expect actual
     ++'
      +
       test_done


 Documentation/rev-list-options.txt | 132 ++++++++++++++++++++++++++++-
 object.h                           |   2 +-
 revision.c                         |  27 +++++-
 revision.h                         |   6 +-
 t/t6012-rev-list-simplify.sh       | 120 ++++++++++++++++++++++++++
 5 files changed, 282 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bfd02ade991..858352bf351 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -342,6 +342,12 @@ Default mode::
 	branches if the end result is the same (i.e. merging branches
 	with the same content)
 
+--include-diversions::
+	Include all commits from the default mode, but also any merge
+	commits that are not TREESAME to the first parent but are
+	TREESAME to a later parent. This mode is helpful for showing
+	the merge commits that "first introduced" a change to a branch.
+
 --full-history::
 	Same as the default mode, but does not prune some history.
 
@@ -534,7 +540,7 @@ Note the major differences in `N`, `P`, and `Q` over `--full-history`:
   parent and is TREESAME.
 --
 
-Finally, there is a fifth simplification mode available:
+There is another simplification mode available:
 
 --ancestry-path::
 	Limit the displayed commits to those directly on the ancestry
@@ -573,6 +579,130 @@ option does. Applied to the 'D..M' range, it results in:
 				L--M
 -----------------------------------------------------------------------
 
+Before discussing another option, `--include-diversions`, we need to
+create a new example history.
++
+A common problem users face when looking at simplified history is that a
+commit they know changed a file somehow does not appear in the file's
+simplified history. Let's demonstrate a new example and show how options
+such as `--full-history` and `--simplify-merges` works in that case:
++
+-----------------------------------------------------------------------
+	  .-A---M-----C--N---O---P
+	 /     / \  \  \/   /   /
+	I     B   \  R-'`-Z'   /
+	 \   /     \/         /
+	  \ /      /\        /
+	   `---X--'  `---Y--'
+-----------------------------------------------------------------------
++
+For this example, suppose `I` created `file.txt` which was modified by
+`A`, `B`, and `X` in different ways. The single-parent commits `C`, `Z`,
+and `Y` do not change `file.txt`. The merge commit `M` was created by
+resolving the merge conflict to include both changes from `A` and `B`
+and hence is not TREESAME to either. The merge commit `R`, however, was
+created by ignoring the contents of `file.txt` at `M` and taking only
+the contents of `file.txt` at `X`. Hence, `R` is TREESAME to `X` but not
+`M`. Finally, the natural merge resolution to create `N` is to take the
+contents of `file.txt` at `R`, so `N` is TREESAME to `R` but not `C`.
+The merge commits `O` and `P` are TREESAME to their first parents, but
+not to their second parents, `Z` and `Y` respectively.
++
+When using the default mode, `N` and `R` both have a TREESAME parent, so
+those edges are walked and the others are ignored. The resulting history
+graph is:
++
+-----------------------------------------------------------------------
+	I---X
+-----------------------------------------------------------------------
++
+When using `--full-history`, Git walks every edge. This will discover
+the commits `A` and `B` and the merge `M`, but also will reveal the
+merge commits `O` and `P`. With parent rewriting, the resulting graph is:
++
+-----------------------------------------------------------------------
+	  .-A---M--------N---O---P
+	 /     / \  \  \/   /   /
+	I     B   \  R-'`--'   /
+	 \   /     \/         /
+	  \ /      /\        /
+	   `---X--'  `------'
+-----------------------------------------------------------------------
++
+Here, the merge commits `O` and `P` contribute extra noise, as they did
+not actually contribute a change to `file.txt`. They only merged a topic
+that was based on an older version of `file.txt`. This is a common
+issue in repositories using a workflow where many contributors work in
+parallel and merge their topic branches along a single trunk: manu
+unrelated merges appear in the `--full-history` results.
++
+When using the `--simplify-merges` option, the commits `O` and `P`
+disappear from the results. This is because the rewritten second parents
+of `O` and `P` are reachable from their first parents. Those edges are
+removed and then the commits look like single-parent commits that are
+TREESAME to their parent. This also happens to the commit `N`, resulting
+in a history view as follows:
++
+-----------------------------------------------------------------------
+	  .-A---M--.
+	 /     /    \
+	I     B      R
+	 \   /      /
+	  \ /      /
+	   `---X--'
+-----------------------------------------------------------------------
++
+In this view, we see all of the important single-parent changes from
+`A`, `B`, and `X`. We also see the carefully-resolved merge `M` and the
+not-so-carefully-resolved merge `R`. This is usually enough information
+to determine why the commits `A` and `B` "disappeared" from history in
+the default view. However, there are a few issues with this approach.
++
+The first issue is performance. Unlike any previous option, the
+`--simplify-merges` option requires walking the entire commit history
+before returning a single result. This can make the option difficult to
+use for very large repositories.
++
+The second issue is one of auditing. When many contributors are working
+on the same repository, it is important which merge commits introduced
+a change into an important branch. The problematic merge `R` above is
+not likely to be the merge commit that was used to merge into an
+important branch. Instead, the merge `N` was used to merge `R` and `X`
+into the important branch. This commit may have information about why
+the change `X` came to override the changes from `A` and `B` in its
+commit message.
++
+The `--include-diversions` option helps with both of these issues. A
+merge commit is considered a "diverter" if it is not TREESAME to its
+first parent but is TREESAME to a later parent. These merges "divert"
+the history walk to a second parent instead of continuing along the
+first-parent history as expected. When using `--include-diversions`
+on this example (and no other options) the resulting graph is:
++
+-----------------------------------------------------------------------
+	I---X---R---N
+-----------------------------------------------------------------------
++
+Here, the merge commits `R` and `N` are included because they diverted
+the walk away from their first-parent history. They are the reason the
+commits `A` and `B` do not appear in the history.
++
+When `--include-diversions` is paired with `--simplify-merges`, the
+graph includes all of the necessary information:
++
+-----------------------------------------------------------------------
+	  .-A---M--.   N
+	 /     /    \ /
+	I     B      R
+	 \   /      /
+	  \ /      /
+	   `---X--'
+-----------------------------------------------------------------------
++
+Notice that since `M` is reachable from `R`, the edge from `N` to `M`
+was simplified away. However, `N` still appears in the history as an
+important commit because it would divert a simplified history walk.
+
 The `--simplify-by-decoration` option allows you to view only the
 big picture of the topology of the history, by omitting commits
 that are not referenced by tags.  Commits are marked as !TREESAME
diff --git a/object.h b/object.h
index 2dbabfca0ab..b22328b8383 100644
--- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object_array {
 
 /*
  * object flag allocation:
- * revision.h:               0---------10                              25----28
+ * revision.h:               0---------10         15                   25----28
  * fetch-pack.c:             01
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
diff --git a/revision.c b/revision.c
index 8136929e236..96f66400659 100644
--- a/revision.c
+++ b/revision.c
@@ -870,7 +870,19 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			}
 			parent->next = NULL;
 			commit->parents = parent;
-			commit->object.flags |= TREESAME;
+
+			/*
+			 * A merge commit is a "diversion" if it is not
+			 * TREESAME to its first parent but is TREESAME
+			 * to a later parent. In the simplified history,
+			 * we "divert" the history walk to the later
+			 * parent. These commits are shown when "diversions"
+			 * is enabled, so do not mark the object as
+			 * TREESAME here.
+			 */
+			if (!revs->diversions || !nth_parent)
+				commit->object.flags |= TREESAME;
+
 			return;
 
 		case REV_TREE_NEW:
@@ -897,6 +909,10 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				relevant_change = 1;
 			else
 				irrelevant_change = 1;
+
+			if (!nth_parent)
+				commit->object.flags |= DIVERSION;
+
 			continue;
 		}
 		die("bad tree compare for commit %s", oid_to_hex(&commit->object.oid));
@@ -2265,6 +2281,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--full-diff")) {
 		revs->diff = 1;
 		revs->full_diff = 1;
+	} else if (!strcmp(arg, "--include-diversions")) {
+		revs->diversions = 1;
 	} else if (!strcmp(arg, "--full-history")) {
 		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--relative-date")) {
@@ -3019,7 +3037,8 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	if (!cnt ||
 	    (commit->object.flags & UNINTERESTING) ||
 	    !(commit->object.flags & TREESAME) ||
-	    (parent = one_relevant_parent(revs, commit->parents)) == NULL)
+	    (parent = one_relevant_parent(revs, commit->parents)) == NULL ||
+	    (revs->diversions && (commit->object.flags & DIVERSION)))
 		st->simplified = commit;
 	else {
 		pst = locate_simplify_state(revs, parent);
@@ -3602,6 +3621,10 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 			/* drop merges unless we want parenthood */
 			if (!want_ancestry(revs))
 				return commit_ignore;
+
+			if (revs->diversions && (commit->object.flags & DIVERSION))
+				return commit_show;
+
 			/*
 			 * If we want ancestry, then need to keep any merges
 			 * between relevant commits to tie together topology.
diff --git a/revision.h b/revision.h
index 475f048fb61..f3c28e5f1c1 100644
--- a/revision.h
+++ b/revision.h
@@ -34,6 +34,9 @@
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
 #define BOTTOM		(1u<<10)
+
+/* WARNING: This is also used as REACHABLE in commit-graph.c. */
+#define DIVERSION	(1u<<15)
 /*
  * Indicates object was reached by traversal. i.e. not given by user on
  * command-line or stdin.
@@ -43,7 +46,7 @@
  */
 #define NOT_USER_GIVEN	(1u<<25)
 #define TRACK_LINEAR	(1u<<26)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | DIVERSION)
 
 #define TOPO_WALK_EXPLORED	(1u<<27)
 #define TOPO_WALK_INDEGREE	(1u<<28)
@@ -129,6 +132,7 @@ struct rev_info {
 			no_walk:2,
 			remove_empty_trees:1,
 			simplify_history:1,
+			diversions:1,
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index a10f0df02b0..23226f2144c 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -154,4 +154,124 @@ test_expect_success '--full-diff is not affected by --parents' '
 	test_cmp expected actual
 '
 
+#
+# Create a new history to demonstrate the value of --include-diversions
+# with respect to the subtleties of simplified history, --full-history,
+# and --simplify-merges.
+#
+#   .-A---M-----C--N---O---P
+#  /     / \  \  \/   /   /
+# I     B   \  R-'`-Z'   /
+#  \   /     \/         /
+#   \ /      /\        /
+#    `---X--'  `---Y--'
+#
+# This example is explained in Documentation/rev-list-options.txt
+
+test_expect_success 'rebuild repo' '
+	rm -rf .git * &&
+	git init &&
+	git switch -c main &&
+
+	echo base >file &&
+	git add file &&
+	test_commit I &&
+
+	echo A >file &&
+	git add file &&
+	test_commit A &&
+
+	git switch -c branchB I &&
+	echo B >file &&
+	git add file &&
+	test_commit B &&
+
+	git switch main &&
+	test_must_fail git merge -m "M" B &&
+	echo A >file &&
+	echo B >>file &&
+	git add file &&
+	git merge --continue &&
+	note M &&
+
+	echo C >other &&
+	git add other &&
+	test_commit C &&
+
+	git switch -c branchX I &&
+	echo X >file &&
+	git add file &&
+	test_commit X &&
+
+	git switch -c branchR M &&
+	git merge -m R -Xtheirs X &&
+	note R &&
+
+	git switch main &&
+	git merge -m N R &&
+	note N &&
+
+	git switch -c branchY M &&
+	echo Y >y &&
+	git add y &&
+	test_commit Y &&
+
+	git switch -c branchZ C &&
+	echo Z >z &&
+	git add z &&
+	test_commit Z &&
+
+	git switch main &&
+	git merge -m O Z &&
+	note O &&
+
+	git merge -m P Y &&
+	note P
+'
+
+check_result 'X I' -- file
+check_result 'N R X I' --include-diversions -- file
+
+check_result 'P O N R X M B A I' --full-history --topo-order -- file
+check_result 'N R X M B A I' --simplify-merges --topo-order --include-diversions -- file
+check_result 'R X M B A I' --simplify-merges --topo-order -- file
+check_result 'N M A I' --first-parent -- file
+check_result 'N M A I' --first-parent --include-diversions -- file
+
+# --ancestry-path implies --full-history
+check_result 'P O N R M' --topo-order \
+	--ancestry-path A..HEAD -- file
+check_result 'P O N R M' --topo-order \
+	--include-diversions \
+	--ancestry-path A..HEAD -- file
+check_result 'P O N R M' --topo-order \
+	--full-history \
+	--ancestry-path A..HEAD -- file
+check_result 'R M' --topo-order \
+	--simplify-merges \
+	--ancestry-path A..HEAD -- file
+check_result 'N R M' --topo-order \
+	--simplify-merges --include-diversions \
+	--ancestry-path A..HEAD -- file
+
+test_expect_success 'log --graph --simplify-merges --include-diversions' '
+	cat >expect <<-\EOF &&
+	* N
+	*   R
+	|\  
+	| * X
+	* |   M
+	|\ \  
+	| * | B
+	| |/  
+	* / A
+	|/  
+	* I
+	EOF
+	git log --graph --pretty="%s" \
+		--simplify-merges --include-diversions \
+		-- file >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
