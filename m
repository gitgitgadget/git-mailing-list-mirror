Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518832DAFC7
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057362; cv=none; b=bRHyBiEz8R2AhXCVPc246mDLf0QadtcQKCufpMZczW66ZIM1YMpQHDodMLVKhi6kj1N1otmlg30bvC5FivlY1Ll4QlGzEwuHajmTu1G3ITcqqT/9QFovgMdaoK3U4MD9B9k67XOWE48fn8lkowsEcHQsed/sqItoqdT3EbmkYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057362; c=relaxed/simple;
	bh=eCi5usFku3QqwHAbBVTTs0lijJ9Zd4yCf4QliYCwenA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ThdRHGqrWPPHSMpBTqOa4+i8hKRhwBVusdM8t+VxR5+wg1S43kuSHsQuf4S7koA6Y/iwhG1aMqz7PGtff9ErGxwxh1BGrAPjrERqBWg6FzUioPq3KhVhj1ihwgxo5t3P5V5l6Z6w/rl4QWnZlO8VFR68xmpD3tou8mE52OOimdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RI7TkREk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EBRbb+Bp; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RI7TkREk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EBRbb+Bp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 19AF31D0011E;
	Sun, 24 Aug 2025 13:42:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 24 Aug 2025 13:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057356;
	 x=1756143756; bh=Py9M4Mb1pkF7kkd5xw7ePSxsRdGQwOcgva+5+XH1EU0=; b=
	RI7TkREkbYmCOrN+DEc0Y/qN7MDrlnbc0gohlsPJe3e2lFrGhSarmotvXGGLlBaY
	x8c9wcP0ctjf4EF8VxXZ8DDZrP2Ru09qU6vvUXPEeYRdO+ecUxmBKcwurfr06tDA
	8YljSZrPLbxD6Lqq+veXLunKzAnfqOwrEpFeNUaw5jJK6YNqlT2ZWEYcFn7tORy9
	m7XOeO8ZY1HDtptDsl3unopdjXo7kK8EwfWZzLtrbqbYPypWcYdiCpEhfS0xzN2e
	m6uEYB2hwYqPrBhCEj7NKZVG/gwjCC4Ni1ilrfg496unMs/8FH6FKa0f00XRqDL7
	UE6R5fSkLLDNTeI/IQ9IhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057356; x=
	1756143756; bh=Py9M4Mb1pkF7kkd5xw7ePSxsRdGQwOcgva+5+XH1EU0=; b=E
	BRbb+Bp6jKDEoIINw7mYDxQPlI4rg239WbO9lw9ok1b730chivX471VBvzyIPu/9
	VBZfgof71LPQ6aSO0701zQUEPya8nGLGJd1O5MJpT21q7j5A3OutOh9nVireT6Bz
	SfTh7bp4jAWQ95mMOUsldqKYhZW2hloQwQvu+wvKbW1ZrvmbphXOiUNhMz1YNVeE
	hKmwYMUC8B8KPNqdTOY7QxsBRYScnWJkr/XjNMk90GaJ4VDy58Q2/yszMH3RGHW2
	4KTwsu8Y/O0EVA8dpVblQ9SxekQF5gU+TS99Gf+jhwl0cWPN5yMKCveEyickGr7j
	me/syCGM2zDGtlcXlWZTg==
X-ME-Sender: <xms:DE-raEq3X6zWZugAxPRz4xe2RebmwFSpvJ0U3Rbn3G2wOrMSnHD5EA>
    <xme:DE-raINi6XLUwExX4hKOKfzNHxiCngVUu04FlN5U1LeVOU03WRzg1XZ_2c7AxQ3cu
    6kqON3pX11L251Cjw>
X-ME-Received: <xmr:DE-raPoRVJXCGoZvvkE7fRLYY--Ki11X3fHQdChy-gYVNNxoyVbEgCL_LB_j7rsiM2sGULYsF9udWky4E_jV6d7EzkoDXRSvKdCXUUqt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:DE-raNcXH8Oj85zTIWM7Ncl5c4F29KrsnQTSBlQADr8kUrpJhTzm0g>
    <xmx:DE-raFSwKcIqnNg1v7WgtLVuM7RYphTp-E4Rtr3E_qVtuzEIeaE7kA>
    <xmx:DE-raGbndflQd-H-cAUGuWVC8UWhBm2T-q3cM3zMuLMmXBBVSP3qsg>
    <xmx:DE-raIclink1Gvx3MvPXr_eGQciVNEglk-EJCbXC0WCY_zcPXi7igg>
    <xmx:DE-raOEfaqus7R12rEoBFisI4RCoeCcBO0Dcywmn4AtZwqubxrZGUSJj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:42:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6ddf29e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:42:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v2 00/16] Introduce git-history(1) command for easy
 history editing
Date: Sun, 24 Aug 2025 19:42:13 +0200
Message-Id: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVOq2gC/4WNTQ6CMBCFr0Jm7ZhSRFpXJiYewK1hATiVCVpIi
 0RDenebxr3L9/e9FTw5Jg+HbAVHC3sebRRyk0HXN/ZOyLeoQQpZCpVrbHc4DR579vPoPti++DG
 zRVUUWhndiNIIiOPJkeF3Al/hcj5BHc3fKJ0teYr+cZccBeq2qrpC7pUydIytLT+hDiF8Adi0L
 me+AAAA
X-Change-ID: 20250819-b4-pks-history-builtin-83398f9a05f0
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Hi,

over recent months I've been playing around with Jujutsu quite
frequently. While I still prefer using Git, there's been a couple
features in it that I really like and that I'd like to have in Git, as
well.

A copule of these features relate to history editing. Most importantly,
I really dig the following commands:

  - jj-abandon(1) to drop a specific commit from your history.

  - jj-absorb(1) to take some changes and automatically apply them to
    commits in your history that last modified the respective hunks.

  - jj-split(1) to split a commit into two.

  - jj-new(1) to insert a new commit after or before a specific other
    commit.

Not all of these commands can be ported directly into Git. jj-new(1) for
example doesn't really make a ton of sense for us, I'd claim. But some
of these commands _do_ make sense.

I thus had a look at implementing some of these commands in Git itself,
where the result is this patch series. Specifically, the following
commands are introduced by this patch series:

  - `git history drop` to drop a specific commit. This is basically the
    same as jj-abandon(1).

  - `git history reorder` to reorder a specific commit before or after
    another commit. This is inspired by jj-new(1).

  - `git history split` takes a commit and splits it into two. This is
    basically the same as jj-split(1).

If this is something we want to have I think it'd be just a starting
point. There's other commands that I think are quite common and that
might make sense to introduce eventually:

  - An equivalent to jj-absorb(1) would be awesome to have.

  - `git history reword` to change only the commit message of a specific
    commit.

  - `git history squash` to squash together multiple commits into one.

In the end, I'd like us to learn from what people like about Jujutsu and
apply those learnings to Git. We won't be able to apply all learnings
from Jujutsu, as the workflow is quite different there due to the lack
of the index. But other things we certainly can apply to Git directly.

Note: This patch series currently builds on the cherry-pick infra.
As such, when one hits a merge conflict one needs to `git cherry-pick
--continue`, which is quite suboptimal. I didn't want to overpolish this
series before getting some feedback, but it is something I'll fix in
subsequent versions. Furthermore, the command for now bails out in the
case where there's any merge commits in the history that is being
rewritten. This is another restriction that can be lifted in the future.

Changes in v2:
  - Add a new "reword" subcommand.
  - List git-history(1) in "command-list.txt".
  - Add some missing error handling.
  - Simplify calling convention of `apply_commits()` to handle root
    commits internally instead of requiring every caller to do so.
  - Add tests to verify that git-history(1) refuses to work with changes
    in the worktree or index.
  - Mark git-history(1) as experimental.
  - Introduce commands to manage interrupted history edits.
  - A bunch of improvements to the manpage.
  - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (16):
      sequencer: optionally skip printing commit summary
      sequencer: add option to rewind HEAD after picking commits
      sequencer: introduce new history editing mode
      sequencer: stop using `the_repository` in `sequencer_remove_state()`
      cache-tree: allow writing in-memory index as tree
      builtin: add new "history" command
      builtin/history: introduce subcommands to manage interrupted rewrites
      builtin/history: implement "drop" subcommand
      builtin/history: implement "reorder" subcommand
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      wt-status: provide function to expose status for trees
      builtin/history: implement "split" subcommand
      builtin/history: implement "reword" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc | 188 +++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   1 +
 add-interactive.c              | 151 ++-----
 add-interactive.h              |  43 +-
 add-patch.c                    | 270 ++++++++++--
 add-patch.h                    |  61 +++
 builtin.h                      |   1 +
 builtin/add.c                  |  22 +-
 builtin/checkout.c             |   7 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 932 +++++++++++++++++++++++++++++++++++++++++
 builtin/rebase.c               |   4 +-
 builtin/reset.c                |  16 +-
 builtin/revert.c               |   2 +-
 builtin/stash.c                |  46 +-
 cache-tree.c                   |   5 +-
 cache-tree.h                   |   3 +-
 command-list.txt               |   1 +
 commit.h                       |   2 +-
 git.c                          |   1 +
 meson.build                    |   1 +
 sequencer.c                    | 187 +++++++--
 sequencer.h                    |   9 +-
 t/meson.build                  |   7 +-
 t/t3450-history.sh             |  42 ++
 t/t3451-history-drop.sh        | 174 ++++++++
 t/t3452-history-reorder.sh     | 234 +++++++++++
 t/t3453-history-split.sh       | 387 +++++++++++++++++
 t/t3454-history-reword.sh      | 158 +++++++
 wt-status.c                    |  24 ++
 wt-status.h                    |   3 +
 33 files changed, 2714 insertions(+), 286 deletions(-)

Range-diff versus v1:

 1:  c1ce1b2e20 =  1:  6348d1ff69 sequencer: optionally skip printing commit summary
 2:  969d896da1 !  2:  d70cb727bc sequencer: add option to rewind HEAD after picking commits
    @@ sequencer.c: static int pick_commits(struct repository *r,
      	/*
      	 * Sequence of picks finished successfully; cleanup by
      	 * removing the .git/sequencer directory
    +@@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
    + 	if (opts->revs->cmdline.nr == 1 &&
    + 	    opts->revs->cmdline.rev->whence == REV_CMD_REV &&
    + 	    opts->revs->no_walk &&
    +-	    !opts->revs->cmdline.rev->flags) {
    ++	    !opts->revs->cmdline.rev->flags &&
    ++	    !opts->restore_head_target) {
    + 		struct commit *cmit;
    + 
    + 		if (prepare_revision_walk(opts->revs)) {
     
      ## sequencer.h ##
     @@ sequencer.h: struct replay_opts {
 -:  ---------- >  3:  9717385fba sequencer: introduce new history editing mode
 -:  ---------- >  4:  360e5cf08f sequencer: stop using `the_repository` in `sequencer_remove_state()`
 3:  658cff279e =  5:  74be65b8f6 cache-tree: allow writing in-memory index as tree
 4:  886ea1e088 !  6:  a84728f097 builtin: add new "history" command
    @@ Documentation/git-history.adoc (new)
     +
     +NAME
     +----
    -+git-history - Rewrite history of the current branch
    ++git-history - EXPERIMENTAL: Rewrite history of the current branch
     +
     +SYNOPSIS
     +--------
    @@ Documentation/git-history.adoc (new)
     +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
     +flag instead.
     +
    ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    ++
     +COMMANDS
     +--------
     +
     +This command requires a subcommand. Several subcommands are available to
    -+rewrite history in different ways.
    ++rewrite history in different ways:
     +
     +CONFIGURATION
     +-------------
    @@ builtin/history.c (new)
     +	return 0;
     +}
     
    + ## command-list.txt ##
    +@@ command-list.txt: git-grep                                mainporcelain           info
    + git-gui                                 mainporcelain
    + git-hash-object                         plumbingmanipulators
    + git-help                                ancillaryinterrogators          complete
    ++git-history                             mainporcelain           history
    + git-hook                                purehelpers
    + git-http-backend                        synchingrepositories
    + git-http-fetch                          synchelpers
    +
      ## git.c ##
     @@ git.c: static struct cmd_struct commands[] = {
      	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 -:  ---------- >  7:  234ad69878 builtin/history: introduce subcommands to manage interrupted rewrites
 5:  084312482f !  8:  a81669a4d1 builtin/history: implement "drop" subcommand
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    -@@ Documentation/git-history.adoc: git-history - Rewrite history of the current branch
    - SYNOPSIS
    - --------
    - [synopsis]
    --git history [<options>]
    -+git history drop [<options>] <revision>
    +@@ Documentation/git-history.adoc: SYNOPSIS
    + git history abort
    + git history continue
    + git history quit
    ++git history drop <commit>
      
      DESCRIPTION
      -----------
     @@ Documentation/git-history.adoc: COMMANDS
      This command requires a subcommand. Several subcommands are available to
    - rewrite history in different ways.
    + rewrite history in different ways:
      
    -+drop <revision>::
    ++`drop <commit>`::
     +	Drop a commit from the history and reapply all children of that
     +	commit on top of the commit's parent. The commit that is to be
     +	dropped must be reachable from the current `HEAD` commit.
    @@ Documentation/git-history.adoc: COMMANDS
     +root commit. It is invalid to drop a root commit that does not have any
     +child commits, as that would lead to an empty branch.
     +
    + The following commands are used to manage an interrupted history-rewriting
    + operation:
    + 
    +@@ Documentation/git-history.adoc: operation:
    + 	the original branch. The index and working tree are also left unchanged
    + 	as a result.
    + 
     +EXAMPLES
     +--------
     +
    -+* Drop a commit from history.
    -++
    ++Drop a commit from history
    ++~~~~~~~~~~~~~~~~~~~~~~~~~~
    ++
     +----------
     +$ git log --oneline
     +2d4cd6d third
    @@ Documentation/git-history.adoc: COMMANDS
      ## builtin/history.c ##
     @@
      #include "builtin.h"
    + #include "branch.h"
     +#include "commit.h"
     +#include "commit-reach.h"
     +#include "config.h"
    @@ builtin/history.c
     +#include "refs.h"
     +#include "reset.h"
     +#include "revision.h"
    -+#include "sequencer.h"
    -+
    + #include "sequencer.h"
    + 
    + static int cmd_history_abort(int argc,
    +@@ builtin/history.c: static int cmd_history_quit(int argc,
    + 	return ret;
    + }
    + 
     +static int collect_commits(struct repository *repo,
     +			   struct commit *old_commit,
     +			   struct commit *new_commit,
    @@ builtin/history.c
     +	int ret;
     +
     +	/*
    -+	 * Check that the old actually is an ancestor of HEAD. If not
    ++	 * Check that the old commit actually is an ancestor of HEAD. If not
     +	 * the whole request becomes nonsensical.
     +	*/
     +	if (old_commit) {
    @@ builtin/history.c
     +
     +	/*
     +	 * Revisions are in newest-order-first. We have to reverse the
    -+	 * array though so that we pick the oldest commits first. Note
    -+	 * that we keep the first string untouched, as it is the
    -+	 * equivalent of `argv[0]` to `setup_revisions()`.
    ++	 * array though so that we pick the oldest commits first.
     +	 */
     +	for (size_t i = 0, j = out->nr - 1; i < j; i++, j--)
     +		SWAP(out->v[i], out->v[j]);
    @@ builtin/history.c
     +	 * We have performed all safety checks, so we now prepare
     +	 * replaying the commits.
     +	*/
    -+	replay_opts.action = REPLAY_PICK;
    ++	replay_opts.action = REPLAY_HISTORY_EDIT;
     +	sequencer_init_config(&replay_opts);
     +	replay_opts.quiet = 1;
     +	replay_opts.skip_commit_summary = 1;
    @@ builtin/history.c
     +	 * squash that root commit with the first commit we're picking
     +	 * onto it.
     +	 */
    -+	if (!base) {
    ++	if (!base->parents) {
     +		if (commit_tree("", 0, repo->hash_algo->empty_tree, NULL,
     +				&root_commit, NULL, NULL) < 0) {
     +			ret = error(_("Could not create new root commit"));
    @@ builtin/history.c
     +		replay_opts.have_squash_onto = 1;
     +		reset_opts.oid = &root_commit;
     +	} else {
    -+		reset_opts.oid = &base->object.oid;
    ++		reset_opts.oid = &base->parents->item->object.oid;
     +	}
     +
     +	replay_opts.restore_head_target =
    @@ builtin/history.c
     +			    struct repository *repo)
     +{
     +	const char * const usage[] = {
    -+		N_("git history drop [<options>] <revision>"),
    ++		N_("git history drop <commit>"),
     +		NULL,
     +	};
     +	struct option options[] = {
    @@ builtin/history.c
     +		if (ret < 0)
     +			goto out;
     +
    -+		ret = apply_commits(repo, &commits, head, commit_to_drop->parents ?
    -+				    commit_to_drop->parents->item : NULL, "drop");
    ++		ret = apply_commits(repo, &commits, head, commit_to_drop, "drop");
     +		if (ret < 0)
     +			goto out;
     +	}
    @@ builtin/history.c
     +	strbuf_release(&buf);
     +	return ret;
     +}
    - 
    ++
      int cmd_history(int argc,
      		const char **argv,
      		const char *prefix,
    --		struct repository *repo UNUSED)
    -+		struct repository *repo)
    - {
    - 	const char * const usage[] = {
    --		N_("git history [<options>]"),
    -+		N_("git history drop [<options>] <revision>"),
    +@@ builtin/history.c: int cmd_history(int argc,
    + 		N_("git history abort"),
    + 		N_("git history continue"),
    + 		N_("git history quit"),
    ++		N_("git history drop <commit>"),
      		NULL,
      	};
    -+	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option options[] = {
    + 	parse_opt_subcommand_fn *fn = NULL;
    +@@ builtin/history.c: int cmd_history(int argc,
    + 		OPT_SUBCOMMAND("abort", &fn, cmd_history_abort),
    + 		OPT_SUBCOMMAND("continue", &fn, cmd_history_continue),
    + 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
     +		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
      		OPT_END(),
      	};
      
    - 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    --	return 0;
    -+	return fn(argc, argv, prefix, repo);
    - }
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    -   't3436-rebase-more-options.sh',
        't3437-rebase-fixup-options.sh',
        't3438-rebase-broken-files.sh',
    -+  't3450-history-drop.sh',
    +   't3450-history.sh',
    ++  't3451-history-drop.sh',
        't3500-cherry.sh',
        't3501-revert-cherry-pick.sh',
        't3502-cherry-pick-merge.sh',
    -@@ t/meson.build: if perl.found() and time.found()
    -       timeout: 0,
    -     )
    -   endforeach
    --endif
    - \ No newline at end of file
    -+endif
     
    - ## t/t3450-history-drop.sh (new) ##
    + ## t/t3451-history-drop.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t3450-history-drop.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'refuses to work with changes in the worktree or index' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit initial &&
    ++		test_commit file file &&
    ++		echo foo >file &&
    ++		test_must_fail git history drop HEAD 2>err &&
    ++		test_grep "Your local changes to the following files would be overwritten" err &&
    ++		git add file &&
    ++		test_must_fail git history drop HEAD 2>err &&
    ++		test_grep "Your local changes to the following files would be overwritten" err
    ++	)
    ++'
    ++
     +test_expect_success 'can drop tip of a branch' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3450-history-drop.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'conflicts are detected' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit base &&
    ++		echo original >file &&
    ++		git add . &&
    ++		git commit -m original &&
    ++		echo modified >file &&
    ++		git commit -am modified &&
    ++
    ++		test_must_fail git history drop HEAD~ >err 2>&1 &&
    ++		test_grep CONFLICT err &&
    ++		test_grep "git history continue" err &&
    ++		echo resolved >file &&
    ++		git add file &&
    ++		git history continue &&
    ++
    ++		cat >expect <<-EOF &&
    ++		modified
    ++		base
    ++		EOF
    ++		git log --format=%s >actual &&
    ++		test_cmp expect actual &&
    ++		echo resolved >expect &&
    ++		git cat-file -p HEAD:file >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
     +test_done
 6:  5ba28ca5e5 !  9:  95ce67205d builtin/history: implement "reorder" subcommand
    @@ Commit message
         builtin/history: implement "reorder" subcommand
     
         When working in projects where having nice commits matters it's quite
    -    common that developers end up reordering commits a lot. Tihs is
    +    common that developers end up reordering commits a lot. This is
         typically done via interactive rebases, where they can then rearrange
         commits in the instruction sheet.
     
         Still, this operation is a frequent-enough operation to provide a more
    -    direct of doing this imperatively. As such, introduce a new "reorder"
    -    subcommand where users can reorder a commit A to come after or before
    -    another commit B:
    +    direct way of doing this imperatively. As such, introduce a new
    +    "reorder" subcommand where users can reorder a commit A to come after or
    +    before another commit B:
     
             $ git log --oneline
             a978f73 fifth
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    -@@ Documentation/git-history.adoc: SYNOPSIS
    - --------
    - [synopsis]
    - git history drop [<options>] <revision>
    -+git history reorder [<options>] <revision> --(before|after)=<revision>
    +@@ Documentation/git-history.adoc: git history abort
    + git history continue
    + git history quit
    + git history drop <commit>
    ++git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-history.adoc: Dropping the root commit converts the child of that commit into the new
    +@@ Documentation/git-history.adoc: rewrite history in different ways:
    + `drop <commit>`::
    + 	Drop a commit from the history and reapply all children of that
    + 	commit on top of the commit's parent. The commit that is to be
    +-	dropped must be reachable from the current `HEAD` commit.
    ++	dropped must be reachable from the currently checked-out commit.
    + +
    + Dropping the root commit converts the child of that commit into the new
      root commit. It is invalid to drop a root commit that does not have any
      child commits, as that would lead to an empty branch.
      
    -+reorder <revision> (--before=<revision>|--after=<revision>)::
    -+	Reorder the commit so that it becomes either the parent
    -+	(`--before=`) or child (`--after=`) of the other specified
    -+	commit. The commits must be related to one another and must be
    -+	reachable from the current `HEAD` commit.
    -+
    - EXAMPLES
    - --------
    ++`reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)`::
    ++	Move the commit so that it becomes either the parent of
    ++	<following-commit> or the child of <preceding-commit>. The commits must
    ++	be related to one another and must be reachable from the current `HEAD`
    ++	commit.
    ++
    + The following commands are used to manage an interrupted history-rewriting
    + operation:
      
     @@ Documentation/git-history.adoc: b1bc1bd third
      e098c27 first
      ----------
      
    -+* Reorder a commit.
    -++
    ++Reorder a commit
    ++~~~~~~~~~~~~~~~~
    ++
     +----------
     +$ git log --oneline
     +a978f73 fifth
    @@ builtin/history.c: static int cmd_history_drop(int argc,
     +			       struct repository *repo)
     +{
     +	const char * const usage[] = {
    -+		N_("git history reorder [<options>] <revision> (--before=<commit>|--after=<commit>)"),
    ++		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
     +		NULL,
     +	};
     +	const char *before = NULL, *after = NULL;
    @@ builtin/history.c: static int cmd_history_drop(int argc,
     +	replace_commits(&commits, &commit_to_reorder->object.oid, NULL, 0);
     +	replace_commits(&commits, &anchor->object.oid, replacement, ARRAY_SIZE(replacement));
     +
    -+	/*
    -+	 * And now we pick commits in the new order on top of either the root
    -+	 * commit or on top the old commit's parent.
    -+	 */
    -+	ret = apply_commits(repo, &commits, head,
    -+			    old->parents ? old->parents->item : NULL, "reorder");
    ++	ret = apply_commits(repo, &commits, head, old, "reorder");
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_drop(int argc,
      		const char **argv,
      		const char *prefix,
     @@ builtin/history.c: int cmd_history(int argc,
    - {
    - 	const char * const usage[] = {
    - 		N_("git history drop [<options>] <revision>"),
    -+		N_("git history reorder [<options>] <revision> --(before|after)=<revision>"),
    + 		N_("git history continue"),
    + 		N_("git history quit"),
    + 		N_("git history drop <commit>"),
    ++		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
      		NULL,
      	};
      	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option options[] = {
    +@@ builtin/history.c: int cmd_history(int argc,
    + 		OPT_SUBCOMMAND("continue", &fn, cmd_history_continue),
    + 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
      		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
     +		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
      		OPT_END(),
    @@ builtin/history.c: int cmd_history(int argc,
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    -   't3437-rebase-fixup-options.sh',
        't3438-rebase-broken-files.sh',
    -   't3450-history-drop.sh',
    -+  't3451-history-reorder.sh',
    +   't3450-history.sh',
    +   't3451-history-drop.sh',
    ++  't3452-history-reorder.sh',
        't3500-cherry.sh',
        't3501-revert-cherry-pick.sh',
        't3502-cherry-pick-merge.sh',
     
    - ## t/t3451-history-reorder.sh (new) ##
    + ## t/t3452-history-reorder.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t3451-history-reorder.sh (new)
     +
     +. ./test-lib.sh
     +
    -+test_expect_success 'reorder refuses to work with merge commits' '
    ++test_expect_success 'refuses to work with merge commits' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t3451-history-reorder.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'reorder requires exactly one of --before or --after' '
    ++test_expect_success 'refuses to work with changes in the worktree or index' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit initial &&
    ++		test_commit file file &&
    ++		echo foo >file &&
    ++		test_must_fail git history reorder HEAD --before=HEAD~ 2>err &&
    ++		test_grep "Your local changes to the following files would be overwritten" err &&
    ++		git add file &&
    ++		test_must_fail git history reorder HEAD --before=HEAD~ 2>err &&
    ++		test_grep "Your local changes to the following files would be overwritten" err
    ++	)
    ++'
    ++
    ++test_expect_success 'requires exactly one of --before or --after' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t3451-history-reorder.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'reorder refuses to reorder commit with itself' '
    ++test_expect_success 'refuses to reorder commit with itself' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t3451-history-reorder.sh (new)
     +		test_must_fail git symbolic-ref HEAD &&
     +		echo "second edit" >file &&
     +		git add file &&
    -+		test_must_fail git cherry-pick --continue &&
    ++		test_must_fail git history continue &&
     +		echo "first edit" >file &&
     +		git add file &&
    -+		git cherry-pick --continue &&
    ++		git history continue &&
     +
     +		cat >expect <<-EOF &&
     +		first edit
 7:  91221a3883 = 10:  1bc1d4f06c add-patch: split out header from "add-interactive.h"
 8:  018d7bd8ea = 11:  fed38713fa add-patch: split out `struct interactive_options`
 9:  915376b78a = 12:  d8ba71c015 add-patch: remove dependency on "add-interactive" subsystem
10:  3fa285e5b8 ! 13:  b56722b519 add-patch: add support for in-memory index patching
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      				error(_("'git apply' failed"));
      		}
     -		if (repo_read_index(s->r) >= 0)
    -+		read_index_from(s->index, s->index_file, s->r->gitdir);
     +		if (read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
     +		    s->index == s->r->index) {
      			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
 -:  ---------- > 14:  5a6b18855e wt-status: provide function to expose status for trees
11:  81e16d3c01 ! 15:  4701b4dff2 builtin/history: implement "split" subcommand
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    -@@ Documentation/git-history.adoc: SYNOPSIS
    - [synopsis]
    - git history drop [<options>] <revision>
    - git history reorder [<options>] <revision> --(before|after)=<revision>
    -+git history split [<options>] <revision> [--] [<pathspec>...]
    +@@ Documentation/git-history.adoc: git history continue
    + git history quit
    + git history drop <commit>
    + git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
    ++git history split [<options>] <commit> [--] [<pathspec>...]
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-history.adoc: reorder <revision> (--before=<revision>|--after=<revision>)::
    - 	commit. The commits must be related to one another and must be
    - 	reachable from the current `HEAD` commit.
    +@@ Documentation/git-history.adoc: child commits, as that would lead to an empty branch.
    + 	be related to one another and must be reachable from the current `HEAD`
    + 	commit.
      
    -+split <revision> [--message=<message>] [--] [<pathspec>...]::
    -+	Interactively split up the commit into two commits by choosing
    ++`split [--message=<message>] <commit> [--] [<pathspec>...]`::
    ++	Interactively split up <commit> into two commits by choosing
     +	hunks introduced by it that will be moved into the new split-out
     +	commit. These hunks will then be written into a new commit that
     +	becomes the parent of the previous commit. The original commit
    @@ Documentation/git-history.adoc: reorder <revision> (--before=<revision>|--after=
     +	commit.
     ++
     +The commit message of the new commit will be asked for by launching the
    -+configured editor. Authorship of the commit will be the same as for the
    -+original commit.
    ++configured editor, unless it has been specified with the `-m` option.
    ++Authorship of the commit will be the same as for the original commit.
     ++
     +If passed, _<pathspec>_ can be used to limit which changes shall be split out
     +of the original commit. Files not matching any of the pathspecs will remain
    -+part of the original commit. For more details about the _<pathspec>_ syntax,
    -+see the 'pathspec' entry.
    ++part of the original commit. For more details, see the 'pathspec' entry in
    ++linkgit:gitglossary[7].
     ++
     +It is invalid to select either all or no hunks, as that would lead to
     +one of the commits becoming empty.
     +
    - EXAMPLES
    - --------
    + The following commands are used to manage an interrupted history-rewriting
    + operation:
      
     @@ Documentation/git-history.adoc: f44a46e third
      bf7438d first
      ----------
      
    -+* Split a commit.
    -++
    ++Split a commit
    ++~~~~~~~~~~~~~~
    ++
     +----------
     +$ git log --stat --oneline
     +3f81232 (HEAD -> main) original
    @@ builtin/history.c
     +#define USE_THE_REPOSITORY_VARIABLE
     +
      #include "builtin.h"
    + #include "branch.h"
     +#include "cache-tree.h"
      #include "commit.h"
      #include "commit-reach.h"
    @@ builtin/history.c
      #include "sequencer.h"
     +#include "sparse-index.h"
      
    - static int collect_commits(struct repository *repo,
    - 			   struct commit *old_commit,
    + static int cmd_history_abort(int argc,
    + 			     const char **argv,
     @@ builtin/history.c: static int cmd_history_reorder(int argc,
      	return ret;
      }
      
    ++static void change_data_free(void *util, const char *str UNUSED)
    ++{
    ++	struct wt_status_change_data *d = util;
    ++	free(d->rename_source);
    ++	free(d);
    ++}
    ++
    ++static int fill_commit_message(struct repository *repo,
    ++			       const struct object_id *old_tree,
    ++			       const struct object_id *new_tree,
    ++			       const char *default_message,
    ++			       const char *provided_message,
    ++			       const char *action,
    ++			       struct strbuf *out)
    ++{
    ++	if (!provided_message) {
    ++		struct wt_status s;
    ++		const char *path = git_path_commit_editmsg();
    ++		const char *hint =
    ++			_("Please enter the commit message for the %s changes. Lines starting\n"
    ++			  "with '%s' will be kept; you may remove them yourself if you want to.\n");
    ++
    ++		strbuf_addstr(out, default_message);
    ++		strbuf_addch(out, '\n');
    ++		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
    ++		write_file_buf(path, out->buf, out->len);
    ++
    ++		wt_status_prepare(repo, &s);
    ++		FREE_AND_NULL(s.branch);
    ++		s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
    ++		s.commit_template = 1;
    ++		s.colopts = 0;
    ++		s.display_comment_prefix = 1;
    ++		s.hints = 0;
    ++		s.use_color = 0;
    ++		s.whence = FROM_COMMIT;
    ++		s.committable = 1;
    ++
    ++		s.fp = fopen(git_path_commit_editmsg(), "a");
    ++		if (!s.fp)
    ++			return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
    ++
    ++		wt_status_collect_changes_trees(&s, old_tree, new_tree);
    ++		wt_status_print(&s);
    ++		wt_status_collect_free_buffers(&s);
    ++		string_list_clear_func(&s.change, change_data_free);
    ++
    ++		strbuf_reset(out);
    ++		if (launch_editor(path, out, NULL)) {
    ++			fprintf(stderr, _("Please supply the message using either -m or -F option.\n"));
    ++			return -1;
    ++		}
    ++		strbuf_stripspace(out, comment_line_str);
    ++
    ++	} else {
    ++		strbuf_addstr(out, provided_message);
    ++	}
    ++
    ++	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
    ++
    ++	if (!out->len) {
    ++		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
    ++		return -1;
    ++	}
    ++
    ++	return 0;
    ++}
    ++
     +static int split_commit(struct repository *repo,
     +			struct commit *original_commit,
     +			struct pathspec *pathspec,
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	struct object_id original_commit_tree_oid, parent_tree_oid;
     +	const char *original_message, *original_body, *ptr;
     +	char original_commit_oid[GIT_MAX_HEXSZ + 1];
    -+	char *split_message_path = NULL, *original_author = NULL;
    ++	char *original_author = NULL;
     +	struct commit_list *parents = NULL;
     +	struct commit *first_commit;
     +	struct tree *split_tree;
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	if (ptr)
     +		original_author = xmemdupz(ptr, len);
     +
    -+	/*
    -+	 * But we do ask the user for a new commit message. This is in contrast
    -+	 * to the second commit, where we'll retain the original commit
    -+	 * message.
    -+	 */
    -+	if (!commit_message) {
    -+		split_message_path = repo_git_path(repo, "SPLIT_MSG");
    -+		strbuf_addch(&split_message, '\n');
    -+		strbuf_commented_addf(&split_message, comment_line_str,
    -+				      _("Please enter a commit message for the split-out changes."));
    -+		write_file_buf(split_message_path, split_message.buf, split_message.len);
    -+
    -+		strbuf_reset(&split_message);
    -+		if (launch_editor(split_message_path, &split_message, NULL)) {
    -+			fprintf(stderr, _("Please supply the message using either -m or -F option.\n"));
    -+			ret = -1;
    -+			goto out;
    -+		}
    -+		strbuf_stripspace(&split_message, comment_line_str);
    -+	} else {
    -+		strbuf_addstr(&split_message, commit_message);
    -+	}
    -+	cleanup_message(&split_message, COMMIT_MSG_CLEANUP_ALL, 0);
    ++	ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
    ++				  "", commit_message, "split-out", &split_message);
    ++	if (ret < 0)
    ++		goto out;
     +
     +	ret = commit_tree(split_message.buf, split_message.len, &split_tree->object.oid,
     +			  original_commit->parents, &out[0], original_author, NULL);
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	strbuf_release(&split_message);
     +	strbuf_release(&index_file);
     +	free_commit_list(parents);
    -+	free(split_message_path);
     +	free(original_author);
     +	release_index(&index);
     +	return ret;
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +			     struct repository *repo)
     +{
     +	const char * const usage[] = {
    -+		N_("git history split [<options>] <revision>"),
    ++		N_("git history split [<options>] <commit>"),
     +		NULL,
     +	};
     +	const char *commit_message = NULL;
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, options, usage, 0);
    ++	if (argc < 1) {
    ++		ret = error(_("command expects a revision"));
    ++		goto out;
    ++	}
     +	repo_config(repo, git_default_config, NULL);
     +
     +	original_commit = lookup_commit_reference_by_name(argv[0]);
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	replace_commits(&commits, &original_commit->object.oid,
     +			split_commits, ARRAY_SIZE(split_commits));
     +
    -+	/*
    -+	 * And now we pick commits in the new order on top of either the root
    -+	 * commit or on top the old commit's parent.
    -+	 */
    -+	ret = apply_commits(repo, &commits, head,
    -+			    original_commit->parents ? original_commit->parents->item : NULL,
    -+			    "split");
    ++	ret = apply_commits(repo, &commits, head, original_commit, "split");
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
      		const char **argv,
      		const char *prefix,
     @@ builtin/history.c: int cmd_history(int argc,
    - 	const char * const usage[] = {
    - 		N_("git history drop [<options>] <revision>"),
    - 		N_("git history reorder [<options>] <revision> --(before|after)=<revision>"),
    -+		N_("git history split [<options>] <revision> [--] [<pathspec>...]"),
    + 		N_("git history quit"),
    + 		N_("git history drop <commit>"),
    + 		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
    ++		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
      		NULL,
      	};
      	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option options[] = {
    +@@ builtin/history.c: int cmd_history(int argc,
    + 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
      		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
      		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
     +		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
    @@ builtin/history.c: int cmd_history(int argc,
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    -   't3438-rebase-broken-files.sh',
    -   't3450-history-drop.sh',
    -   't3451-history-reorder.sh',
    -+  't3452-history-split.sh',
    +   't3450-history.sh',
    +   't3451-history-drop.sh',
    +   't3452-history-reorder.sh',
    ++  't3453-history-split.sh',
        't3500-cherry.sh',
        't3501-revert-cherry-pick.sh',
        't3502-cherry-pick-merge.sh',
     
    - ## t/t3452-history-split.sh (new) ##
    + ## t/t3453-history-split.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t3452-history-split.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'refuses to work with changes in the worktree or index' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit initial &&
    ++		touch bar foo &&
    ++		git add . &&
    ++		git commit -m split-me &&
    ++
    ++		echo changed >bar &&
    ++		test_must_fail git history split -m message HEAD 2>err <<-EOF &&
    ++		y
    ++		n
    ++		EOF
    ++		test_grep "Your local changes to the following files would be overwritten" err &&
    ++
    ++		git add bar &&
    ++		test_must_fail git history split -m message HEAD 2>err <<-EOF &&
    ++		y
    ++		n
    ++		EOF
    ++		test_grep "Your local changes to the following files would be overwritten" err
    ++	)
    ++'
    ++
     +test_expect_success 'can split up tip commit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    ++		git symbolic-ref HEAD >expect &&
     +		set_fake_editor &&
     +		git history split HEAD <<-EOF &&
     +		y
     +		n
     +		EOF
    ++		git symbolic-ref HEAD >actual &&
    ++		test_cmp expect actual &&
     +
     +		expect_log <<-EOF &&
     +		split-me
    @@ t/t3452-history-split.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'aborts with empty commit message' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		touch bar foo &&
    ++		git add . &&
    ++		git commit -m split-me &&
    ++
    ++		test_must_fail git history split HEAD -m "" <<-EOF 2>err &&
    ++		y
    ++		n
    ++		EOF
    ++		test_grep "Aborting commit due to empty commit message." err
    ++	)
    ++'
    ++
     +test_expect_success 'can specify message via option' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3452-history-split.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'commit message editor sees split-out changes' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		touch bar foo &&
    ++		git add . &&
    ++		git commit -m split-me &&
    ++
    ++		write_script fake-editor.sh <<-\EOF &&
    ++		cp "$1" . &&
    ++		echo "some commit message" >>"$1"
    ++		EOF
    ++		test_set_editor "$(pwd)"/fake-editor.sh &&
    ++
    ++		git history split HEAD <<-EOF &&
    ++		y
    ++		n
    ++		EOF
    ++
    ++		cat >expect <<-EOF &&
    ++
    ++		# Please enter the commit message for the split-out changes. Lines starting
    ++		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
    ++		# Changes to be committed:
    ++		#	new file:   bar
    ++		#
    ++		EOF
    ++		test_cmp expect COMMIT_EDITMSG &&
    ++
    ++		expect_log <<-EOF
    ++		split-me
    ++		some commit message
    ++		EOF
    ++	)
    ++'
    ++
     +test_expect_success 'can use pathspec to limit what gets split' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
 -:  ---------- > 16:  3e3587d375 builtin/history: implement "reword" subcommand

---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

