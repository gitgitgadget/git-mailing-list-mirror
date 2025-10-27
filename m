Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAE284B37
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564845; cv=none; b=VqYrl9K/XET4kymDjYwK5GDdCxMiJQmJO/VmCig/pOrXdvox6IM32cKlFEukL7PWOwK2kUKsUJmbgWBMw9W2Uyiefl4XhJmb5xhAliaqYrEzHZw24YH2af0QlK4mRmINzotIFJuntYIPH8vqfumOGYTR46CEEN0+iOGvyJAGS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564845; c=relaxed/simple;
	bh=8vhdEUUXTrTlEPClXb1B6xKl+qEKMattaEBx0fwNs+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=WqOijtgkUJEKi7p9CyrY2eDgKtOHtbjAefvxZxNf0LBAiGhxo52iNpeurBD4IU5SarqR61k/XseNWWpvhn/0FCnxlRPZ2d17eRe0P/CIBAdViQleKT1YfgxUadb4cAprpzqogEUU5XtTGgNKACKI4sDZjXmp1/T2BmA5ZmATId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HXo+JyIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2Z32PHhA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HXo+JyIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Z32PHhA"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B68CEC0326;
	Mon, 27 Oct 2025 07:34:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Oct 2025 07:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564841;
	 x=1761651241; bh=IvBLR0QshytnEtweGV3+uJ6NZLcLeO7505DQYZ6GSFw=; b=
	HXo+JyIHJTYPDWMwOlquoidAuyYKL912RVKzo1ZfcGysZo56SJLkjF5zsrQwTwpq
	QJu1HUvIt9JZiDufMRCzzDndUjDFA0pRlzoEV/QAspmHMhDOlYoUzMHPRIOfOvys
	XpET5XvtUeTRBmJ5yiuDReB/5EINUCfYhDYPNzhYzW3U69fUnPoP4oERHipbL6jW
	QSHVsQVtAFArH2Bczk6u0aw4vnXbAYzfic1hK/Ma2ckgs+CgV0HVmVVzXgD0LH8o
	Pp70mSrp04EHxIS23TRJS81WwlJQTMoXbCKnX10AOM968xWKHqkz46Of0kuOsNWs
	yVA1R2nA6D+zvVqAwRhmMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564841; x=
	1761651241; bh=IvBLR0QshytnEtweGV3+uJ6NZLcLeO7505DQYZ6GSFw=; b=2
	Z32PHhAPK774A1emWkTnr5RO2o35uDQmqilWN/8yn6dbSGJ8TVE6dHVKafRuvYs4
	tvhk3a0bZ6JKHh5CwUVZMX8rkaZxzkbEURbQPslhAnlV2zuYH1eP8vZ6R59bVQ6A
	tCoEOj+vF2OcRf2qxQpTzofZuiwejSkVB69qhsTyIRGZb2h8oRTkUS9iax9CwAor
	auGjKXW7GTieFVKrVJqgd6DF3OhHvDf9IDxpHZhBwKgt5bUq14BmTzDKVu6k+v4h
	uU02GlGMKuGGYt+eoD5FRSbnx+SqbAcwa5suMZ8g00xtbnzx8+Xasn13F3K1XXPn
	cJvRKRwqKbHWBGgwtFmyA==
X-ME-Sender: <xms:qVj_aIqnOls2kgmKKoxx7n31-uM2LPiURQvf0a_6_H8rM54NzLkziQ>
    <xme:qVj_aBMya9zNurCGdLw_kEOwv5YngM_y2ZG1e6ZP-Pl4gWd3zG-4UYPcmHcqakI5Y
    VRYAGWNnvvSyD7YholxhSC6u6zTNm60e3vGPpFm_eiTwQ97kIO-kA>
X-ME-Received: <xmr:qVj_aA05Q1NO92Cawv6JvowoR-BAohyF1UlK1lPy24So9acazWtlA2Rw35tlxDdgmh6ypjv3WRLNCvCf8wO9KaKRfvQIDYlWoWTNPQF25g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilh
    grsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsohhrghgrnhhovhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qVj_aACuacTobwCL1SkhIsLUMPyNyBMrfUkAwoGfjc8T30PHH7840w>
    <xmx:qVj_aNJF03xpVbnIYPmfhHww_vgpZ2rRwzXo490O_pexPyiSLVo8ZA>
    <xmx:qVj_aJkc6YE9YAwcPs8H1ahXHXd9LsU59HIzbk94Z4OjoXUkLaQN1Q>
    <xmx:qVj_aGafBZQo9f_C8PfLfvrpkx9enIPcMlLbgwQvtxDa8K_JChKiyw>
    <xmx:qVj_aNl3sHctfMJAOJ0avxVhoNiCC2nWLgU9kyG44IWF0OfxX1tOsXuj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:33:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67fd4c68 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:33:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/11] Introduce git-history(1) command for easy history
 editing
Date: Mon, 27 Oct 2025 12:33:48 +0100
Message-Id: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxY/2gC/4XQz07DMAwG8FeZciYoduL82Yn3QByaJmER0E3Nq
 EBT3x13QmM9VBw/6/PPki+i5bHmJva7ixjzVFs9Dhzsw070h254zbImzgIVkvIQZDTy9Nbkobb
 zcfyW8bO+n+sgvdbBl9ApKkrw8mnMpX5d4ecXzr/9650Jlum/5ARSyRCd6zVa70t+4tZj/RCLN
 +GdgWbTwMWwpusBi6WYVob+M4LaNjQbS4M0gXFEK8PcDFAKNg3Dhs8WUoreanArg+4M3DaIDec
 T6kKO32FvxjzPPxHldRzJAQAA
X-Change-ID: 20250819-b4-pks-history-builtin-83398f9a05f0
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

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

This patch series is a starting point for such a command. I've
significantly slimmed it down from the first couple revisions now
following the discussions at the Contributor's Summit yesterday. This
was my intent anyway, as I already mentioned on the last iteration.

Changes in v6:
  - I've rebased the patch series again to pull in the latest updates
    from sa/replay-atomic-ref-updates and fix conflicts. It is now based
    on 4e98b730f1 (The twenty-fourth batch, 2025-10-24) with ab661bb1bb
    (replay: add replay.refAction config option, 2025-10-23) merged into
    it.
  - I've dropped the "-m" options for now, so commit messages are always
    asked for via the editor. These can be introduced in a subsequent
    patch series once discussion around them has settled.
  - We don't use the merge machinery anymore to pick the commits.
  - Drop the commit to parse commits in the replay machinery. It didn't
    seem to be necessary in v5 anymore, and now that we don't use the
    merge machinery at all we don't ever take that code path in the
    first place.
  - Link to v5:
    https://lore.kernel.org/r/20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im

Changes in v5:
  - I've changed the patch series to be based on top of 133d151831 (The
    twenty-first batch, 2025-10-20) with sa/replay-atomic-ref-updates at
    a1c22e627e (SQAUASH??? t0450 band-aid, 2025-10-14) merged into it.
    This is one the one hand to fix a conflict, but also to get some of
    the CI updates to make GitLab CI work again.
  - Some slight commit message improvements.
  - Deduplicate subcommand usage strings by using defines.
  - Fix the desendancy checks to properly verify that HEAD is a
    descendant of the commit to be rewritten. Also add some tests for
    this.
  - Fix the hint that mentions that lines starting with the comment
    character will be tripped after having written the commit message.
  - Move an include to the correct commit.
  - Link to v4: https://lore.kernel.org/r/20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im

Changes in v4:
  - I've rebuilt the patch series. It is now based on 821f583da6 (The
    thirteenth batcn, 2025-09-29) with sa/replay-atomic-ref-updates
    at 665c66a743 (replay: make atomic ref updates the default behavior,
    2025-09-27) merged into it. This should fix all conflicts with seen.
  - I've reworked this patch series to use the same infra as
    git-replay(1), as discussed during the Contributor's Summit.
  - I've slimmed down the patch series to only tackle those commands
    that cannot result in a conflict to keep it simple. I also learned
    that Elijah has been working on a "git replay edit" command, so I
    dropped that command so that we can instead use his version.
  - During the Contributor's Summit we have agreed that for now, we
    won't care about hook execution just yet. This may be backfilled at
    a later point in time.
  - I dropped "commit.verbose" handling for now, as my understanding of
    it was wrong at first. This is something we should backfill.
  - Link to v3: https://lore.kernel.org/r/20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im

Changes in v3:
  - Add logic to drive the "post-rewrite" hook and add tests to verify
    that all hooks are executed as expected.
  - Deduplicate logic to turn a replay action into a todo command.
  - Move the addition of tests for the top-level git-history(1) command
    to the correct commit.
  - Some smaller commit message fixes.
  - Honor "commit.verbose".
  - Fix copy-paste error with an error message.
  - Link to v2: https://lore.kernel.org/r/20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im

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
Patrick Steinhardt (11):
      wt-status: provide function to expose status for trees
      replay: extract logic to pick commits
      replay: stop using `the_repository`
      builtin: add new "history" command
      builtin/history: implement "reword" subcommand
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      cache-tree: allow writing in-memory index as tree
      builtin/history: implement "split" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc | 111 ++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   2 +
 add-interactive.c              | 174 +++----------
 add-interactive.h              |  46 +---
 add-patch.c                    | 297 +++++++++++++++++++---
 add-patch.h                    |  64 +++++
 builtin.h                      |   1 +
 builtin/add.c                  |  22 +-
 builtin/checkout.c             |   7 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 561 +++++++++++++++++++++++++++++++++++++++++
 builtin/replay.c               | 110 +-------
 builtin/reset.c                |  16 +-
 builtin/stash.c                |  46 ++--
 cache-tree.c                   |   5 +-
 cache-tree.h                   |   3 +-
 command-list.txt               |   1 +
 commit.h                       |   2 +-
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 115 +++++++++
 replay.h                       |  23 ++
 t/meson.build                  |   3 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 237 +++++++++++++++++
 t/t3452-history-split.sh       | 432 +++++++++++++++++++++++++++++++
 wt-status.c                    |  24 ++
 wt-status.h                    |   9 +
 30 files changed, 1972 insertions(+), 377 deletions(-)

Range-diff versus v5:

 1:  c351cd9fb34 !  1:  7e32877a47c wt-status: provide function to expose status for trees
    @@ wt-status.h: void wt_status_add_cut_line(struct wt_status *s);
      void wt_status_prepare(struct repository *r, struct wt_status *s);
      void wt_status_print(struct wt_status *s);
      void wt_status_collect(struct wt_status *s);
    ++
    ++/*
    ++ * Collect all changes between the two trees. Changes will be displayed as if
    ++ * they were staged into the index.
    ++ */
     +void wt_status_collect_changes_trees(struct wt_status *s,
     +				     const struct object_id *old_treeish,
     +				     const struct object_id *new_treeish);
    ++
      /*
       * Frees the buffers allocated by wt_status_collect.
       */
 2:  71266f8ed78 !  2:  3688a10ec38 replay: extract logic to pick commits
    @@ builtin/replay.c
      #include "revision.h"
      #include "strmap.h"
      #include <oidset.h>
    - #include <tree.h>
    +@@ builtin/replay.c: enum ref_action_mode {
    + 	REF_ACTION_PRINT
    + };
      
     -static const char *short_commit_name(struct repository *repo,
     -				     struct commit *commit)
    @@ builtin/replay.c: static void determine_replay_mode(struct repository *repo,
     -	return create_commit(repo, result->tree, pickme, replayed_base);
     -}
     -
    - static int handle_ref_update(const char *mode,
    + static int handle_ref_update(enum ref_action_mode mode,
      			     struct ref_transaction *transaction,
      			     const char *refname,
     @@ builtin/replay.c: int cmd_replay(int argc,
    @@ replay.c (new)
     +	return NULL;
     +}
     +
    -+static struct commit *create_commit(struct repository *repo,
    ++struct commit *replay_create_commit(struct repository *repo,
     +				    struct tree *tree,
     +				    struct commit *based_on,
     +				    struct commit *parent)
    @@ replay.c (new)
     +	merge_opt->ancestor = NULL;
     +	if (!result->clean)
     +		return NULL;
    -+	return create_commit(repo, result->tree, pickme, replayed_base);
    ++	return replay_create_commit(repo, result->tree, pickme, replayed_base);
     +}
     
      ## replay.h (new) ##
    @@ replay.h (new)
     +struct commit;
     +struct tree;
     +
    ++struct commit *replay_create_commit(struct repository *repo,
    ++				    struct tree *tree,
    ++				    struct commit *based_on,
    ++				    struct commit *parent);
    ++
     +struct commit *replay_pick_regular_commit(struct repository *repo,
     +					  struct commit *pickme,
     +					  kh_oid_map_t *replayed_commits,
 3:  703fc59d4e1 !  3:  7a5217797a0 replay: stop using `the_repository`
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## replay.c ##
    -@@ replay.c: static struct commit *create_commit(struct repository *repo,
    +@@ replay.c: struct commit *replay_create_commit(struct repository *repo,
      	obj = parse_object(repo, &ret);
      
      out:
 4:  f18a8ac67e0 <  -:  ----------- replay: parse commits before dereferencing them
 5:  65892f7da77 !  4:  bc435f62d87 builtin: add new "history" command
    @@ Documentation/git-history.adoc (new)
     +Rewrite history by rearranging or modifying specific commits in the
     +history.
     +
    ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    ++
     +This command is similar to linkgit:git-rebase[1] and uses the same
     +underlying machinery. You should use rebases if you want to reapply a range of
     +commits onto a different base, or interactive rebases if you want to edit a
    @@ Documentation/git-history.adoc (new)
     +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
     +flag instead.
     +
    -+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    -+
     +COMMANDS
     +--------
     +
    -+This command requires a subcommand. Several subcommands are available to
    -+rewrite history in different ways:
    ++Several commands are available to rewrite history in different ways:
     +
     +CONFIGURATION
     +-------------
 6:  cefe1dbb847 !  5:  39a21dc2bbd builtin/history: implement "reword" subcommand
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    -@@ Documentation/git-history.adoc: SYNOPSIS
    +@@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history of the current branch
    + SYNOPSIS
      --------
      [synopsis]
    - git history [<options>]
    -+git history reword [<options>] <commit>
    +-git history [<options>]
    ++git history reword <commit>
      
      DESCRIPTION
      -----------
     @@ Documentation/git-history.adoc: COMMANDS
    - This command requires a subcommand. Several subcommands are available to
    - rewrite history in different ways:
      
    -+`reword <commit> [--message=<message>]`::
    + Several commands are available to rewrite history in different ways:
    + 
    ++`reword <commit>`::
     +	Rewrite the commit message of the specified commit. All the other
    -+	details of this commit remain unchanged. If no commit message is
    -+	provided, then this command will spawn an editor with the current
    -+	message of that commit.
    ++	details of this commit remain unchanged. This command will spawn an
    ++	editor with the current message of that commit.
     +
      CONFIGURATION
      -------------
    @@ builtin/history.c
     +#include "tree.h"
     +#include "wt-status.h"
     +
    -+#define GIT_HISTORY_REWORD_USAGE N_("git history reword [<options>] <commit>")
    ++#define GIT_HISTORY_REWORD_USAGE N_("git history reword <commit>")
     +
     +static int collect_commits(struct repository *repo,
     +			   struct commit *old_commit,
    @@ builtin/history.c
     +			 const char *action)
     +{
     +	struct reset_head_opts reset_opts = { 0 };
    -+	struct merge_options merge_opts = { 0 };
    -+	struct merge_result result = { 0 };
     +	struct strbuf buf = STRBUF_INIT;
    -+	kh_oid_map_t *replayed_commits;
     +	int ret;
     +
    -+	replayed_commits = kh_init_oid_map();
    -+
    -+	init_basic_merge_options(&merge_opts, repo);
    -+	merge_opts.show_rename_progress = 0;
    -+
     +	for (size_t i = 0; i < commits->nr; i++) {
     +		struct object_id commit_id;
     +		struct commit *commit;
     +		const char *end;
    -+		int hash_result;
    -+		khint_t pos;
     +
     +		if (parse_oid_hex_algop(commits->v[i], &commit_id, &end,
     +					repo->hash_algo)) {
    @@ builtin/history.c
     +
     +		if (!onto) {
     +			onto = commit;
    -+			result.clean = 1;
    -+			result.tree = repo_get_commit_tree(repo, commit);
     +		} else {
    -+			onto = replay_pick_regular_commit(repo, commit, replayed_commits,
    -+							  onto, &merge_opts, &result);
    ++			struct tree *tree = repo_get_commit_tree(repo, commit);
    ++			onto = replay_create_commit(repo, tree, commit, onto);
     +			if (!onto)
     +				break;
     +		}
    -+
    -+		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hash_result);
    -+		if (hash_result == 0) {
    -+			ret = error(_("duplicate rewritten commit: %s\n"),
    -+				    oid_to_hex(&commit->object.oid));
    -+			goto out;
    -+		}
    -+		kh_value(replayed_commits, pos) = onto;
    -+	}
    -+
    -+	if (!result.clean) {
    -+		ret = error(_("could not merge"));
    -+		goto out;
     +	}
     +
     +	reset_opts.oid = &onto->object.oid;
    @@ builtin/history.c
     +	ret = 0;
     +
     +out:
    -+	kh_destroy_oid_map(replayed_commits);
    -+	merge_finalize(&merge_opts, &result);
     +	strbuf_release(&buf);
     +	return ret;
     +}
    @@ builtin/history.c
     +			       const struct object_id *old_tree,
     +			       const struct object_id *new_tree,
     +			       const char *default_message,
    -+			       const char *provided_message,
     +			       const char *action,
     +			       struct strbuf *out)
     +{
    -+	if (!provided_message) {
    -+		const char *path = git_path_commit_editmsg();
    -+		const char *hint =
    -+			_("Please enter the commit message for the %s changes."
    -+			  " Lines starting\nwith '%s' will be ignored.\n");
    -+		struct wt_status s;
    -+
    -+		strbuf_addstr(out, default_message);
    -+		strbuf_addch(out, '\n');
    -+		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
    -+		write_file_buf(path, out->buf, out->len);
    -+
    -+		wt_status_prepare(repo, &s);
    -+		FREE_AND_NULL(s.branch);
    -+		s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
    -+		s.commit_template = 1;
    -+		s.colopts = 0;
    -+		s.display_comment_prefix = 1;
    -+		s.hints = 0;
    -+		s.use_color = 0;
    -+		s.whence = FROM_COMMIT;
    -+		s.committable = 1;
    -+
    -+		s.fp = fopen(git_path_commit_editmsg(), "a");
    -+		if (!s.fp)
    -+			return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
    -+
    -+		wt_status_collect_changes_trees(&s, old_tree, new_tree);
    -+		wt_status_print(&s);
    -+		wt_status_collect_free_buffers(&s);
    -+		string_list_clear_func(&s.change, change_data_free);
    -+
    -+		strbuf_reset(out);
    -+		if (launch_editor(path, out, NULL)) {
    -+			fprintf(stderr, _("Please supply the message using the -m option.\n"));
    -+			return -1;
    -+		}
    -+		strbuf_stripspace(out, comment_line_str);
    -+	} else {
    -+		strbuf_addstr(out, provided_message);
    ++	const char *path = git_path_commit_editmsg();
    ++	const char *hint =
    ++		_("Please enter the commit message for the %s changes."
    ++		  " Lines starting\nwith '%s' will be ignored.\n");
    ++	struct wt_status s;
    ++
    ++	strbuf_addstr(out, default_message);
    ++	strbuf_addch(out, '\n');
    ++	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
    ++	write_file_buf(path, out->buf, out->len);
    ++
    ++	wt_status_prepare(repo, &s);
    ++	FREE_AND_NULL(s.branch);
    ++	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
    ++	s.commit_template = 1;
    ++	s.colopts = 0;
    ++	s.display_comment_prefix = 1;
    ++	s.hints = 0;
    ++	s.use_color = 0;
    ++	s.whence = FROM_COMMIT;
    ++	s.committable = 1;
    ++
    ++	s.fp = fopen(git_path_commit_editmsg(), "a");
    ++	if (!s.fp)
    ++		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
    ++
    ++	wt_status_collect_changes_trees(&s, old_tree, new_tree);
    ++	wt_status_print(&s);
    ++	wt_status_collect_free_buffers(&s);
    ++	string_list_clear_func(&s.change, change_data_free);
    ++
    ++	strbuf_reset(out);
    ++	if (launch_editor(path, out, NULL)) {
    ++		fprintf(stderr, _("Please supply the message using the -m option.\n"));
    ++		return -1;
     +	}
    ++	strbuf_stripspace(out, comment_line_str);
     +
     +	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
     +
    @@ builtin/history.c
     +		GIT_HISTORY_REWORD_USAGE,
     +		NULL,
     +	};
    -+	const char *commit_message = NULL;
     +	struct option options[] = {
    -+		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
     +		OPT_END(),
     +	};
     +	struct strbuf final_message = STRBUF_INIT;
    @@ builtin/history.c
     +	find_commit_subject(original_message, &original_body);
     +
     +	ret = fill_commit_message(repo, &parent_tree_oid, &original_commit_tree_oid,
    -+				  original_body, commit_message, "reworded", &final_message);
    ++				  original_body, "reworded", &final_message);
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c
     +		struct repository *repo)
      {
      	const char * const usage[] = {
    - 		N_("git history [<options>]"),
    +-		N_("git history [<options>]"),
     +		GIT_HISTORY_REWORD_USAGE,
      		NULL,
      	};
    @@ t/t3451-history-reword.sh (new)
     +
     +. ./test-lib.sh
     +
    ++reword_with_message () {
    ++	cat >message &&
    ++	write_script fake-editor.sh <<-EOF &&
    ++	cp "$(pwd)/message" "\$1"
    ++	EOF
    ++	test_set_editor "$(pwd)"/fake-editor.sh &&
    ++	git history reword "$@" &&
    ++	rm fake-editor.sh message
    ++}
    ++
     +test_expect_success 'refuses to work with merge commits' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3451-history-reword.sh (new)
     +		test_commit third &&
     +
     +		git symbolic-ref HEAD >expect &&
    -+		git history reword -m "third reworded" HEAD &&
    ++		reword_with_message HEAD <<-EOF &&
    ++		third reworded
    ++		EOF
     +		git symbolic-ref HEAD >actual &&
     +		test_cmp expect actual &&
     +
    @@ t/t3451-history-reword.sh (new)
     +		test_commit third &&
     +
     +		git symbolic-ref HEAD >expect &&
    -+		git history reword -m "second reworded" HEAD~ &&
    ++		reword_with_message HEAD~ <<-EOF &&
    ++		second reworded
    ++		EOF
     +		git symbolic-ref HEAD >actual &&
     +		test_cmp expect actual &&
     +
    @@ t/t3451-history-reword.sh (new)
     +		test_commit first &&
     +		test_commit second &&
     +		test_commit third &&
    -+		git history reword -m "first reworded" HEAD~2 &&
    ++		reword_with_message HEAD~2 <<-EOF &&
    ++		first reworded
    ++		EOF
     +
     +		cat >expect <<-EOF &&
     +		third
    @@ t/t3451-history-reword.sh (new)
     +# change in the future, and if it does this test here is expected to start
     +# failing. In other words, this test is not an endorsement of the current
     +# status quo.
    -+test_expect_success 'hooks are executed for rewritten commits' '
    ++test_expect_success 'hooks are not executed for rewritten commits' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t3451-history-reword.sh (new)
     +		touch "$(pwd)/hooks.log
     +		EOF
     +
    -+		git history reword -m "second reworded" HEAD~ &&
    ++		reword_with_message HEAD~ <<-EOF &&
    ++		second reworded
    ++		EOF
     +
     +		cat >expect <<-EOF &&
     +		third
    @@ t/t3451-history-reword.sh (new)
     +		cd repo &&
     +		test_commit first &&
     +
    -+		test_must_fail git history reword -m "" HEAD 2>err &&
    ++		! reword_with_message HEAD 2>err </dev/null &&
     +		test_grep "Aborting commit due to empty commit message." err
     +	)
     +'
    @@ t/t3451-history-reword.sh (new)
     +		echo foo >a &&
     +		echo bar >b &&
     +		git add b &&
    -+		git history reword HEAD -m message &&
    ++		reword_with_message HEAD <<-EOF &&
    ++		message
    ++		EOF
     +		cat >expect <<-\EOF &&
     +		 M a
     +		M  b
 7:  a064a8c7eca =  6:  a1b1e5877bc add-patch: split out header from "add-interactive.h"
 8:  39c231e726f =  7:  4262663aa50 add-patch: split out `struct interactive_options`
 9:  104a42a552f =  8:  c285918281f add-patch: remove dependency on "add-interactive" subsystem
10:  2e60b2b6b48 =  9:  3f6e32241df add-patch: add support for in-memory index patching
11:  52bdbb2ac6a = 10:  c25564e1d16 cache-tree: allow writing in-memory index as tree
12:  052ee5bd58b ! 11:  221dd490af1 builtin/history: implement "split" subcommand
    @@ Commit message
     
      ## Documentation/git-history.adoc ##
     @@ Documentation/git-history.adoc: SYNOPSIS
    + --------
      [synopsis]
    - git history [<options>]
    - git history reword [<options>] <commit>
    -+git history split [<options>] <commit> [--] [<pathspec>...]
    + git history reword <commit>
    ++git history split <commit> [--] [<pathspec>...]
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-history.adoc: rewrite history in different ways:
    - 	provided, then this command will spawn an editor with the current
    - 	message of that commit.
    +@@ Documentation/git-history.adoc: Several commands are available to rewrite history in different ways:
    + 	details of this commit remain unchanged. This command will spawn an
    + 	editor with the current message of that commit.
      
    -+`split [--message=<message>] <commit> [--] [<pathspec>...]`::
    ++`split <commit> [--] [<pathspec>...]`::
     +	Interactively split up <commit> into two commits by choosing
     +	hunks introduced by it that will be moved into the new split-out
     +	commit. These hunks will then be written into a new commit that
    @@ Documentation/git-history.adoc: rewrite history in different ways:
     +	commit.
     ++
     +The commit message of the new commit will be asked for by launching the
    -+configured editor, unless it has been specified with the `-m` option.
    -+Authorship of the commit will be the same as for the original commit.
    ++configured editor. Authorship of the commit will be the same as for the
    ++original commit.
     ++
     +If passed, _<pathspec>_ can be used to limit which changes shall be split out
     +of the original commit. Files not matching any of the pathspecs will remain
    @@ Documentation/git-history.adoc: include::includes/cmd-config-section-all.adoc[]
     + foo | 1 +
     + 2 files changed, 2 insertions(+)
     +
    -+$ git history split HEAD --message="split-out commit"
    ++$ git history split HEAD
     +diff --git a/bar b/bar
     +new file mode 100644
     +index 0000000..5716ca5
    @@ builtin/history.c
      #include "tree.h"
      #include "wt-status.h"
      
    - #define GIT_HISTORY_REWORD_USAGE N_("git history reword [<options>] <commit>")
    -+#define GIT_HISTORY_SPLIT_USAGE  N_("git history split [<options>] <commit> [--] [<pathspec>...]")
    + #define GIT_HISTORY_REWORD_USAGE N_("git history reword <commit>")
    ++#define GIT_HISTORY_SPLIT_USAGE  N_("git history split <commit> [--] [<pathspec>...]")
      
      static int collect_commits(struct repository *repo,
      			   struct commit *old_commit,
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +static int split_commit(struct repository *repo,
     +			struct commit *original_commit,
     +			struct pathspec *pathspec,
    -+			const char *commit_message,
     +			struct object_id *out)
     +{
     +	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +		original_author = xmemdupz(ptr, len);
     +
     +	ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
    -+				  "", commit_message, "split-out", &split_message);
    ++				  "", "split-out", &split_message);
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +		GIT_HISTORY_SPLIT_USAGE,
     +		NULL,
     +	};
    -+	const char *commit_message = NULL;
     +	struct option options[] = {
    -+		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
     +		OPT_END(),
     +	};
     +	struct oidmap rewritten_commits = OIDMAP_INIT;
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +	 * Then we split up the commit and replace the original commit with the
     +	 * new ones.
     +	 */
    -+	ret = split_commit(repo, original_commit, &pathspec,
    -+			   commit_message, split_commits);
    ++	ret = split_commit(repo, original_commit, &pathspec, split_commits);
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_reword(int argc,
      		const char **argv,
      		const char *prefix,
     @@ builtin/history.c: int cmd_history(int argc,
    + {
      	const char * const usage[] = {
    - 		N_("git history [<options>]"),
      		GIT_HISTORY_REWORD_USAGE,
     +		GIT_HISTORY_SPLIT_USAGE,
      		NULL,
    @@ t/t3452-history-split.sh (new)
     +. ./test-lib.sh
     +
     +set_fake_editor () {
    -+	write_script fake-editor.sh <<-\EOF &&
    -+	echo "split-out commit" >"$1"
    ++	write_script fake-editor.sh <<-EOF &&
    ++	echo "$@" >"\$1"
     +	EOF
     +	test_set_editor "$(pwd)"/fake-editor.sh
     +}
    @@ t/t3452-history-split.sh (new)
     +		git commit -m split-me &&
     +
     +		git symbolic-ref HEAD >expect &&
    -+		set_fake_editor &&
    ++		set_fake_editor "split-out commit" &&
     +		git history split HEAD <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +		git commit -m root &&
     +		test_commit tip &&
     +
    -+		set_fake_editor &&
    ++		set_fake_editor "split-out commit" &&
     +		git history split HEAD~ <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +		git commit -m split-me &&
     +		test_commit tip &&
     +
    -+		set_fake_editor &&
    ++		set_fake_editor "split-out commit" &&
     +		git history split HEAD~ <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    -+		git history split HEAD -m "split-out commit" <<-EOF &&
    ++		set_fake_editor "split-out-commit" &&
    ++		git history split HEAD <<-EOF &&
     +		y
     +		n
     +		y
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    -+		git history split HEAD -m "split-out commit" <<-EOF &&
    ++		set_fake_editor "split-out commit" &&
    ++		git history split HEAD <<-EOF &&
     +		n
     +		y
     +		EOF
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    -+		test_must_fail git history split HEAD -m "" <<-EOF 2>err &&
    ++		set_fake_editor "" &&
    ++		test_must_fail git history split HEAD <<-EOF 2>err &&
     +		y
     +		n
     +		EOF
    @@ t/t3452-history-split.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'can specify message via option' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		touch bar foo &&
    -+		git add . &&
    -+		git commit -m split-me &&
    -+
    -+		git history split HEAD -m "message option" <<-EOF &&
    -+		y
    -+		n
    -+		EOF
    -+
    -+		expect_log <<-EOF
    -+		split-me
    -+		message option
    -+		EOF
    -+	)
    -+'
    -+
     +test_expect_success 'commit message editor sees split-out changes' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    -+		git history split HEAD -m "message option" -- foo <<-EOF &&
    ++		set_fake_editor "split-out commit" &&
    ++		git history split HEAD -- foo <<-EOF &&
     +		y
     +		EOF
     +
    @@ t/t3452-history-split.sh (new)
     +		touch "$(pwd)/hooks.log"
     +		EOF
     +
    -+		set_fake_editor &&
    ++		set_fake_editor "split-out commit" &&
     +		git history split HEAD <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +		echo a-modified >a &&
     +		echo b-modified >b &&
     +		git add b &&
    -+		git history split HEAD -m a-only <<-EOF &&
    ++		set_fake_editor "a-only" &&
    ++		git history split HEAD <<-EOF &&
     +		y
     +		n
     +		EOF
    @@ t/t3452-history-split.sh (new)
     +		M  b
     +		?? actual
     +		?? expect
    ++		?? fake-editor.sh
     +		EOF
     +		git status --porcelain >actual &&
     +		test_cmp expect actual

---
base-commit: a912335e972768e607159eb74a4c7b62f86ee38e
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

