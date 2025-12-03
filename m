Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CA2F12A3
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758923; cv=none; b=VNgPpqU+MuzpbNVdrnqfSFBJ2jCLv5aWGmUDS/CoteON50KcMar1McbUz0qFzr6RN7cMWsl3Te/gR1XgRRpNdbePvc0aAHjvHdQjB0Dy24FMq9EVhWqDB/AE1COwbFVhM9CH9+RH/+Ya9UCUVfxzUUm3NlJjpz4kEso9aGe+7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758923; c=relaxed/simple;
	bh=jYmW0/q6wVWoOnGJtxXLyKj7DSmTZV28wqbiX6vyyKQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=LGtbnL9Q/l1I3EaYSFuCoJ+kea4nS29rnWtUbORkFbb8dpEPb4Akt54UVBXeVzt97uOWOc8U9DFY/FVZvKKrij8gTfl+owaIvKWZLbit+H7lKl+IIc4lmT5bY4KPQU7amg5rcGQSGHf83g9ODGYye2b+z+1CKspW45BQESDXS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D5h4kubD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YICS6f4p; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D5h4kubD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YICS6f4p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4561814001AE;
	Wed,  3 Dec 2025 05:48:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 05:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758919;
	 x=1764845319; bh=VTECm44HDQpTwRkr+OkAD2V9IWByjAOoVABvcvr+0ac=; b=
	D5h4kubDsllWvZhe5MAwLAv1UUlQOcaf/xhmunX1+yAX1v0yxumY9bxVSfwCJUda
	m2K4eWNN+87Z+FBT0Hx5tESWPM6GJsvWRa8/okuqbTudRjt0zvSu3U7sBd0ie6h+
	FZfi01yRqHFrU80+vTKnRB0aHeH/MYBf8XNAUsP/nHy8y9z2jC+UmaznNR/2u2sR
	fBGNXWvlgix1b1fQ0ERY8IVJG65lGd5XMSGmOBCMMnotoAK3kgVnKrEC/oNAy5Jl
	wvEBp2LwApk+jX/IKdCYkXp5S+w84w2skJ97mLjv1435yURULFwWC/fehYndFvSu
	q7ZIxUJbjWPP2cKhWr23vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758919; x=
	1764845319; bh=VTECm44HDQpTwRkr+OkAD2V9IWByjAOoVABvcvr+0ac=; b=Y
	ICS6f4p9iZRbZsEXhVI9VnM1vzD1XS6yQgh7I+EaAISqJWT3SfLm+4mq7nS4yWDR
	XV742IeTDN33Y6Y9/AspED/jdpFSt3Ceh6NoGpuJi6beAjbrx+VENsa2fMV7JBZ5
	XrvUSHPXOPF9CJInSqUqkDT9PlsW/NKgl+eiPReBA58/JYlcem+WXdPSu0GPAGNa
	pTb/bUB3UtmksVOqtLP79s5KNR+ycNgKO+6rUqrXpT/PsMuyOLNdbqbxfFl+CAVI
	+NggDD0ZD91185Hzesw/kLZf8TOF4AGcmYdv9fTtJoKwBKpSPa7ue2CNqeGQNpoW
	VlZqJriB+5tMrXjTuiVIQ==
X-ME-Sender: <xms:hxUwaYo10QeRdej0XhCXbGTJV3neS8fVcnLx7Krm8VtAugjzCqVemw>
    <xme:hxUwaROoGYQ6B8RC83MSPGO4bXMF6Nm0F7cLF8QR00uOhpmF-5kH4w6AcgiSMW-P2
    zOugNZa9m5h4iDQqPzBptLAu1Qe3Xe-_yTdG7L8PdzapB4oN4BxtQ>
X-ME-Received: <xmr:hxUwaQ13jz79QaRixnQJob0CgLqh6x3JQ7lRQ3cNcQzdz-LHQzwx_XC8yWX22IBX5U8XC7N1KM710ZHOllxHkXc1H1oxd7k8Qxg0ccY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    etueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:hxUwaQAUlJvQTpdwf_UnUtTaj0dNXsEmH5R-4Gm2EOgkXNYAn3QpJg>
    <xmx:hxUwadKzhDnUpiiHoA4p3Ss6HnCnzgCfnG6tWV4MHNEw3RiMoeF_VA>
    <xmx:hxUwaZnySKrFWmvKKpqbqc-qCOzNvJON7wAtaN4Ew8EidUDVBs6Slg>
    <xmx:hxUwaWa9Fydi0hFFqwpOWteMgtpT_NBKseSYhvvhMrLbaeiEQ5qRCA>
    <xmx:hxUwadnd29ysJdqEEoxunTB5Pzmz8MCRJYWbuldw2tx6AKhZ3RGn04VS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 477b0df6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v7 00/12] Introduce git-history(1) command for easy history
 editing
Date: Wed, 03 Dec 2025 11:48:27 +0100
Message-Id: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsVMGkC/4XQy27CMBAF0F9BXtfIr/GDFf+BWMSxXay2AcUQt
 UL5d8aoosnC6vKO7pyR5k5KHHMsZLe5kzFOueTzgMG8bUh/6ob3SHPATAQTwCx31Ct6+Sj0lMv
 1PP5Qf8uf1zxQK6WzyXUMEiO4fBljyt9P+HDE/Nt/3pl4nf5LTpwy6rwxvRTa2hT32NrmL1K9S
 SwMoZqGqIZWXc9F0uDDypB/hmNtQ6JRGyCBKwOwMtTL4IzxpqHQsFHzELzVkpuVAQtDtA1Aw9g
 gZAKD79ArQy8N0zQ0GoqZECrSBfky5nl+AA4sxoMNAgAA
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

Changes in v7:
  - I've rebased the patch series on top of f0ef5b6d9b (The fifth batch,
    2025-11-30) with pw/replay-exclude-gpgsig-fix at 9f3a115087 (replay:
    do not copy "gpgsign-sha256" header, 2025-11-26) merged into it to
    fix some conflicts.
  - I refactored a bunch of code to be shared between split and reword.
  - I am now using "--ancestry-path" and "--reverse" to enumerate
    commits.
  - `git history split` now asks for commit messages for both commits.
  - `git history split` no longer allows the user to edit hunks so that
    conflicts become impossible. This may be reintroduced at a later
    point in time.
  - A bunch of test improvements.
  - Several commit message and documentation improvements.
  - Link to v6: https://lore.kernel.org/r/20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im

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
Patrick Steinhardt (12):
      wt-status: provide function to expose status for trees
      replay: extract logic to pick commits
      replay: stop using `the_repository`
      builtin: add new "history" command
      builtin/history: implement "reword" subcommand
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      add-patch: allow disabling editing of hunks
      cache-tree: allow writing in-memory index as tree
      builtin/history: implement "split" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc | 109 ++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   2 +
 add-interactive.c              | 174 +++----------
 add-interactive.h              |  46 +---
 add-patch.c                    | 335 +++++++++++++++++++++----
 add-patch.h                    |  71 ++++++
 builtin.h                      |   1 +
 builtin/add.c                  |  22 +-
 builtin/checkout.c             |   9 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 558 +++++++++++++++++++++++++++++++++++++++++
 builtin/replay.c               | 110 +-------
 builtin/reset.c                |  16 +-
 builtin/stash.c                |  46 ++--
 cache-tree.c                   |   4 +-
 cache-tree.h                   |   3 +-
 command-list.txt               |   1 +
 commit.h                       |   2 +-
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 115 +++++++++
 replay.h                       |  23 ++
 t/meson.build                  |   3 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 236 +++++++++++++++++
 t/t3452-history-split.sh       | 452 +++++++++++++++++++++++++++++++++
 wt-status.c                    |  24 ++
 wt-status.h                    |   9 +
 30 files changed, 2014 insertions(+), 395 deletions(-)

Range-diff versus v6:

 1:  d59b2ff389 =  1:  ccf19f9067 wt-status: provide function to expose status for trees
 2:  7b80b4d482 !  2:  39c5a05ee1 replay: extract logic to pick commits
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Makefile ##
    -@@ Makefile: LIB_OBJS += reftable/tree.o
    - LIB_OBJS += reftable/writer.o
    - LIB_OBJS += remote.o
    +@@ Makefile: LIB_OBJS += repack-geometry.o
    + LIB_OBJS += repack-midx.o
    + LIB_OBJS += repack-promisor.o
      LIB_OBJS += replace-object.o
     +LIB_OBJS += replay.o
      LIB_OBJS += repo-settings.o
    @@ builtin/replay.c
      #include "strmap.h"
      #include <oidset.h>
     @@ builtin/replay.c: enum ref_action_mode {
    - 	REF_ACTION_PRINT
    + 	REF_ACTION_PRINT,
      };
      
     -static const char *short_commit_name(struct repository *repo,
    @@ builtin/replay.c: static struct commit *peel_committish(struct repository *repo,
     -	const char *message = repo_logmsg_reencode(repo, based_on,
     -						   NULL, out_enc);
     -	const char *orig_message = NULL;
    --	const char *exclude_gpgsig[] = { "gpgsig", NULL };
    +-	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
     -
     -	commit_list_insert(parent, &parents);
     -	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
    @@ builtin/replay.c: static void determine_replay_mode(struct repository *repo,
     -	return create_commit(repo, result->tree, pickme, replayed_base);
     -}
     -
    - static int handle_ref_update(enum ref_action_mode mode,
    - 			     struct ref_transaction *transaction,
    - 			     const char *refname,
    + static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
    + {
    + 	if (!ref_action || !strcmp(ref_action, "update"))
     @@ builtin/replay.c: int cmd_replay(int argc,
      		if (commit->parents->next)
      			die(_("replaying merge commits is not supported yet!"));
    @@ builtin/replay.c: int cmd_replay(int argc,
     
      ## meson.build ##
     @@ meson.build: libgit_sources = [
    -   'reftable/writer.c',
    -   'remote.c',
    +   'repack-midx.c',
    +   'repack-promisor.c',
        'replace-object.c',
     +  'replay.c',
        'repo-settings.c',
    @@ replay.c (new)
     +	const char *message = repo_logmsg_reencode(repo, based_on,
     +						   NULL, out_enc);
     +	const char *orig_message = NULL;
    -+	const char *exclude_gpgsig[] = { "gpgsig", NULL };
    ++	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
     +
     +	commit_list_insert(parent, &parents);
     +	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
 3:  3f66e8423d =  3:  fe73ba4059 replay: stop using `the_repository`
 4:  f64dba0b08 !  4:  c162f407db builtin: add new "history" command
    @@ Metadata
      ## Commit message ##
         builtin: add new "history" command
     
    -    When rewriting history via git-rebase(1) there are a couple of very
    -    common use cases:
    +    When rewriting history via git-rebase(1) there are a few very common use
    +    cases:
     
           - The ordering of two commits should be reversed.
     
    @@ Commit message
     
           - Multiple commits should be squashed into one.
     
    +      - Editing an existing commit that is not the tip of the current
    +        branch.
    +
         While these operations are all doable, it often feels needlessly kludgey
         to do so by doing an interactive rebase, using the editor to say what
         one wants, and then perform the actions. Furthermore, some operations
    @@ Commit message
     
         Add a new "history" command to plug this gap. This command will have
         several different subcommands to imperatively rewrite history for common
    -    use cases like the above. These subcommands will be implemented in
    -    subsequent commits.
    +    use cases like the above. Some of these subcommands will be implemented
    +    in subsequent commits.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ Documentation/git-history.adoc (new)
     +
     +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     +
    -+This command is similar to linkgit:git-rebase[1] and uses the same
    -+underlying machinery. You should use rebases if you want to reapply a range of
    -+commits onto a different base, or interactive rebases if you want to edit a
    ++This command is related to linkgit:git-rebase[1] in that both commands can be
    ++used to rewrite history. You should use rebases if you want to reapply a range
    ++of commits onto a different base, or interactive rebases if you want to edit a
     +range of commits.
     +
     +Note that this command does not (yet) work with histories that contain
    @@ Documentation/git-history.adoc (new)
     +
     +include::includes/cmd-config-section-all.adoc[]
     +
    -+include::config/sequencer.adoc[]
    -+
     +GIT
     +---
     +Part of the linkgit:git[1] suite
 5:  3c1c599e9f !  5:  3ecbe6ec83 builtin/history: implement "reword" subcommand
    @@ Commit message
         builtin/history: implement "reword" subcommand
     
         Implement a new "reword" subcommand for git-history(1). This subcommand
    -    is essentially the same as if a user performed an interactive rebase
    -    with a single commit changed to use the "reword" verb.
    +    is similar to the user performing an interactive rebase with a single
    +    commit changed to use the "reword" instruction.
    +
    +    The major difference is that we do not check out the commit that is to
    +    be reworded. This has the obvious benefit of being significantly faster
    +    compared to git-rebase(1), but even more importantly it allows the user
    +    to rewrite history even if there are local changes in the working tree
    +    or in the index.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ builtin/history.c
     +	int ret;
     +
     +	repo_init_revisions(repo, &rev, NULL);
    ++	rev.reverse = 1;
     +	strvec_push(&revisions, "");
     +	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
    -+	if (old_commit)
    ++	if (old_commit) {
     +		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
    ++		strvec_pushf(&revisions, "--ancestry-path=%s", oid_to_hex(&old_commit->object.oid));
    ++	}
     +
     +	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
     +	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
    @@ builtin/history.c
     +		}
     +
     +		strvec_push(out, oid_to_hex(&child->object.oid));
    -+
    -+		if (child->parents && old_commit &&
    -+		    commit_list_contains(old_commit, child->parents))
    -+			break;
     +	}
     +
    -+	/*
    -+	 * Revisions are in newest-order-first. We have to reverse the
    -+	 * array though so that we pick the oldest commits first.
    -+	 */
    -+	for (size_t i = 0, j = out->nr - 1; i < j; i++, j--)
    -+		SWAP(out->v[i], out->v[j]);
    -+
     +	ret = 0;
     +
     +out:
    @@ builtin/history.c
     +	return ret;
     +}
     +
    ++static int gather_commits_between_head_and_revision(struct repository *repo,
    ++						    const char *revision,
    ++						    struct commit **original_commit,
    ++						    struct commit **parent_commit,
    ++						    struct commit **head,
    ++						    struct strvec *commits)
    ++{
    ++	struct commit_list *from_list = NULL;
    ++	int ret;
    ++
    ++	*original_commit = lookup_commit_reference_by_name(revision);
    ++	if (!*original_commit) {
    ++		ret = error(_("commit cannot be found: %s"), revision);
    ++		goto out;
    ++	}
    ++
    ++	*parent_commit = (*original_commit)->parents ? (*original_commit)->parents->item : NULL;
    ++	if (*parent_commit && repo_parse_commit(repo, *parent_commit)) {
    ++		ret = error(_("unable to parse commit %s"),
    ++			    oid_to_hex(&(*parent_commit)->object.oid));
    ++		goto out;
    ++	}
    ++
    ++	*head = lookup_commit_reference_by_name("HEAD");
    ++	if (!(*head)) {
    ++		ret = error(_("could not resolve HEAD to a commit"));
    ++		goto out;
    ++	}
    ++
    ++	commit_list_append(*original_commit, &from_list);
    ++	if (!repo_is_descendant_of(repo, *head, from_list)) {
    ++		ret = error(_("commit must be reachable from current HEAD commit"));
    ++		goto out;
    ++	}
    ++
    ++	/*
    ++	 * Collect the list of commits that we'll have to reapply now already.
    ++	 * This ensures that we'll abort early on in case the range of commits
    ++	 * contains merges, which we do not yet handle.
    ++	 */
    ++	ret = collect_commits(repo, *parent_commit, *head, commits);
    ++	if (ret < 0)
    ++		goto out;
    ++
    ++out:
    ++	free_commit_list(from_list);
    ++	return ret;
    ++}
    ++
     +static void replace_commits(struct strvec *commits,
     +			    const struct object_id *commit_to_replace,
     +			    const struct object_id *replacements,
    @@ builtin/history.c
     +		} else {
     +			struct tree *tree = repo_get_commit_tree(repo, commit);
     +			onto = replay_create_commit(repo, tree, commit, onto);
    -+			if (!onto)
    -+				break;
    ++			if (!onto) {
    ++				ret = -1;
    ++				goto out;
    ++			}
     +		}
     +	}
     +
    @@ builtin/history.c
     +	const char *path = git_path_commit_editmsg();
     +	const char *hint =
     +		_("Please enter the commit message for the %s changes."
    -+		  " Lines starting\nwith '%s' will be ignored.\n");
    ++		  " Lines starting\nwith '%s' will be ignored, and an"
    ++		  " empty message aborts the commit.\n");
     +	struct wt_status s;
     +
     +	strbuf_addstr(out, default_message);
    @@ builtin/history.c
     +
     +	strbuf_reset(out);
     +	if (launch_editor(path, out, NULL)) {
    -+		fprintf(stderr, _("Please supply the message using the -m option.\n"));
    ++		fprintf(stderr, _("Aborting commit as launching the editor failed.\n"));
     +		return -1;
     +	}
     +	strbuf_stripspace(out, comment_line_str);
    @@ builtin/history.c
     +	return 0;
     +}
     +
    ++static int commit_tree_with_edited_message(struct repository *repo,
    ++					   const char *action,
    ++					   struct commit *original_commit,
    ++					   const struct object_id *new_tree_oid,
    ++					   const struct commit_list *parents,
    ++					   const struct object_id *parent_tree_oid,
    ++					   struct object_id *out)
    ++{
    ++	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
    ++	const char *original_message, *original_body, *ptr;
    ++	struct commit_extra_header *original_extra_headers = NULL;
    ++	struct strbuf commit_message = STRBUF_INIT;
    ++	char *original_author = NULL;
    ++	size_t len;
    ++	int ret;
    ++
    ++	/* We retain authorship of the original commit. */
    ++	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
    ++	ptr = find_commit_header(original_message, "author", &len);
    ++	if (ptr)
    ++		original_author = xmemdupz(ptr, len);
    ++	find_commit_subject(original_message, &original_body);
    ++
    ++	ret = fill_commit_message(repo, parent_tree_oid, new_tree_oid,
    ++				  original_body, action, &commit_message);
    ++	if (ret < 0)
    ++		goto out;
    ++
    ++	original_extra_headers = read_commit_extra_headers(original_commit, exclude_gpgsig);
    ++
    ++	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree_oid,
    ++				   parents, out, original_author, NULL, NULL,
    ++				   original_extra_headers);
    ++	if (ret < 0)
    ++		goto out;
    ++
    ++out:
    ++	free_commit_extra_headers(original_extra_headers);
    ++	strbuf_release(&commit_message);
    ++	free(original_author);
    ++	return ret;
    ++}
    ++
     +static int cmd_history_reword(int argc,
     +			      const char **argv,
     +			      const char *prefix,
    @@ builtin/history.c
     +	struct option options[] = {
     +		OPT_END(),
     +	};
    -+	struct strbuf final_message = STRBUF_INIT;
     +	struct commit *original_commit, *parent, *head;
     +	struct strvec commits = STRVEC_INIT;
     +	struct object_id parent_tree_oid, original_commit_tree_oid;
     +	struct object_id rewritten_commit;
    -+	struct commit_list *from_list = NULL;
    -+	const char *original_message, *original_body, *ptr;
    -+	char *original_author = NULL;
    -+	size_t len;
     +	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, options, usage, 0);
    @@ builtin/history.c
     +	}
     +	repo_config(repo, git_default_config, NULL);
     +
    -+	original_commit = lookup_commit_reference_by_name(argv[0]);
    -+	if (!original_commit) {
    -+		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
    ++	ret = gather_commits_between_head_and_revision(repo, argv[0], &original_commit,
    ++						       &parent, &head, &commits);
    ++	if (ret < 0)
     +		goto out;
    -+	}
    -+	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
     +
    -+	parent = original_commit->parents ? original_commit->parents->item : NULL;
    -+	if (parent) {
    -+		if (repo_parse_commit(repo, parent)) {
    -+			ret = error(_("unable to parse commit %s"),
    -+				    oid_to_hex(&parent->object.oid));
    -+			goto out;
    -+		}
    ++	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
    ++	if (parent)
     +		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
    -+	} else {
    ++	else
     +		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
    -+	}
    -+
    -+	head = lookup_commit_reference_by_name("HEAD");
    -+	if (!head) {
    -+		ret = error(_("could not resolve HEAD to a commit"));
    -+		goto out;
    -+	}
    -+
    -+	commit_list_append(original_commit, &from_list);
    -+	if (!repo_is_descendant_of(repo, head, from_list)) {
    -+		ret = error (_("split commit must be reachable from current HEAD commit"));
    -+		goto out;
    -+	}
    -+
    -+	/*
    -+	 * Collect the list of commits that we'll have to reapply now already.
    -+	 * This ensures that we'll abort early on in case the range of commits
    -+	 * contains merges, which we do not yet handle.
    -+	 */
    -+	ret = collect_commits(repo, parent, head, &commits);
    -+	if (ret < 0)
    -+		goto out;
     +
     +	/* We retain authorship of the original commit. */
    -+	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
    -+	ptr = find_commit_header(original_message, "author", &len);
    -+	if (ptr)
    -+		original_author = xmemdupz(ptr, len);
    -+	find_commit_subject(original_message, &original_body);
    -+
    -+	ret = fill_commit_message(repo, &parent_tree_oid, &original_commit_tree_oid,
    -+				  original_body, "reworded", &final_message);
    -+	if (ret < 0)
    -+		goto out;
    -+
    -+	ret = commit_tree(final_message.buf, final_message.len, &original_commit_tree_oid,
    -+			  original_commit->parents, &rewritten_commit, original_author, NULL);
    ++	ret = commit_tree_with_edited_message(repo, "reworded", original_commit,
    ++					      &original_commit_tree_oid,
    ++					      original_commit->parents, &parent_tree_oid,
    ++					      &rewritten_commit);
     +	if (ret < 0) {
     +		ret = error(_("failed writing reworded commit"));
     +		goto out;
    @@ builtin/history.c
     +	ret = 0;
     +
     +out:
    -+	strbuf_release(&final_message);
    -+	free_commit_list(from_list);
     +	strvec_clear(&commits);
    -+	free(original_author);
     +	return ret;
     +}
      
    @@ t/t3451-history-reword.sh (new)
     +
     +reword_with_message () {
     +	cat >message &&
    -+	write_script fake-editor.sh <<-EOF &&
    -+	cp "$(pwd)/message" "\$1"
    ++	write_script fake-editor.sh <<-\EOF &&
    ++	cp message "$1"
     +	EOF
     +	test_set_editor "$(pwd)"/fake-editor.sh &&
     +	git history reword "$@" &&
    @@ t/t3451-history-reword.sh (new)
     +		git switch branch &&
     +		test_commit theirs &&
     +		test_must_fail git history reword ours 2>err &&
    -+		test_grep "split commit must be reachable from current HEAD commit" err
    ++		test_grep "commit must be reachable from current HEAD commit" err
     +	)
     +'
     +
    @@ t/t3451-history-reword.sh (new)
     +		first
     +		EOF
     +		git log --format=%s >actual &&
    -+		test_cmp expect actual
    ++		test_cmp expect actual &&
    ++
    ++		git reflog >reflog &&
    ++		test_grep "reword: updating HEAD" reflog
     +	)
     +'
     +
    @@ t/t3451-history-reword.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'can use editor to rewrite commit message' '
    ++test_expect_success 'editor shows proper status' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t3451-history-reword.sh (new)
     +		first
     +
     +		# Please enter the commit message for the reworded changes. Lines starting
    -+		# with ${SQ}#${SQ} will be ignored.
    ++		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     +		# Changes to be committed:
     +		#	new file:   first.t
     +		#
     +		EOF
     +		test_cmp expect COMMIT_EDITMSG &&
     +
    -+		cat >expect <<-EOF &&
    ++		test_commit_message HEAD <<-\EOF
     +		first
     +
     +		amend a comment
    -+
     +		EOF
    -+		git log --format=%B >actual &&
    -+		test_cmp expect actual
     +	)
     +'
     +
    @@ t/t3451-history-reword.sh (new)
     +		test_commit second &&
     +		test_commit third &&
     +
    -+		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    -+		touch "$(pwd)/hooks.log
    -+		EOF
    -+		write_script .git/hooks/post-commit <<-EOF &&
    -+		touch "$(pwd)/hooks.log
    -+		EOF
    -+		write_script .git/hooks/post-rewrite <<-EOF &&
    -+		touch "$(pwd)/hooks.log
    -+		EOF
    ++		ORIG_PATH="$(pwd)" &&
    ++		export ORIG_PATH &&
    ++		for hook in prepare-commit-msg pre-commit post-commit post-rewrite commit-msg
    ++		do
    ++			write_script .git/hooks/$hook <<-\EOF || exit 1
    ++			touch "$ORIG_PATH/hooks.log
    ++			EOF
    ++		done &&
     +
     +		reword_with_message HEAD~ <<-EOF &&
     +		second reworded
 6:  7d736c2f8d =  6:  a1c6ad546d add-patch: split out header from "add-interactive.h"
 7:  da50162d06 !  7:  eea2ac7a18 add-patch: split out `struct interactive_options`
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
     +		if (*s->s.cfg.reset_color_interactive)
     +			fputs(s->s.cfg.reset_color_interactive, stdout);
      		fflush(stdout);
    - 		if (read_single_character(s) == EOF)
    - 			break;
    + 		if (read_single_character(s) == EOF) {
    + 			quit = 1;
     @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      				err(s, _("Sorry, cannot split this hunk"));
      			} else if (!split_hunk(s, file_diff,
 8:  a888ae8a29 !  8:  95be396a5a add-patch: remove dependency on "add-interactive" subsystem
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
     +		if (*s->cfg.reset_color_interactive)
     +			fputs(s->cfg.reset_color_interactive, stdout);
      		fflush(stdout);
    - 		if (read_single_character(s) == EOF)
    - 			break;
    + 		if (read_single_character(s) == EOF) {
    + 			quit = 1;
     @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      				err(s, _("Sorry, cannot split this hunk"));
      			} else if (!split_hunk(s, file_diff,
 9:  e84e2e265d !  9:  d114c622a8 add-patch: add support for in-memory index patching
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      	}
      
      	putchar('\n');
    -@@ add-patch.c: int run_add_p(struct repository *r, enum add_p_mode mode,
    + 	return quit;
    + }
    + 
    ++static int run_add_p_common(struct add_p_state *state,
    ++			    const struct pathspec *ps)
    ++{
    ++	size_t binary_count = 0;
    ++
    ++	if (parse_diff(state, ps) < 0)
    ++		return -1;
    ++
    ++	for (size_t i = 0; i < state->file_diff_nr; i++) {
    ++		if (state->file_diff[i].binary && !state->file_diff[i].hunk_nr)
    ++			binary_count++;
    ++		else if (patch_update_file(state, state->file_diff + i))
    ++			break;
    ++	}
    ++
    ++	if (state->file_diff_nr == 0)
    ++		err(state, _("No changes."));
    ++	else if (binary_count == state->file_diff_nr)
    ++		err(state, _("Only binary files changed."));
    ++
    ++	return 0;
    ++}
    ++
    + int run_add_p(struct repository *r, enum add_p_mode mode,
    + 	      struct interactive_options *opts, const char *revision,
    + 	      const struct pathspec *ps)
      {
      	struct add_p_state s = {
      		.r = r,
    @@ add-patch.c: int run_add_p(struct repository *r, enum add_p_mode mode,
      		.answer = STRBUF_INIT,
      		.buf = STRBUF_INIT,
      		.plain = STRBUF_INIT,
    + 		.colored = STRBUF_INIT,
    + 	};
    +-	size_t i, binary_count = 0;
    ++	int ret;
    + 
    + 	interactive_config_init(&s.cfg, r, opts);
    + 
     @@ add-patch.c: int run_add_p(struct repository *r, enum add_p_mode mode,
    + 	if (repo_read_index(r) < 0 ||
    + 	    (!s.mode->index_only &&
    + 	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
    +-					  NULL, NULL, NULL) < 0) ||
    +-	    parse_diff(&s, ps) < 0) {
    +-		add_p_state_clear(&s);
    +-		return -1;
    ++					  NULL, NULL, NULL) < 0)) {
    ++		ret = -1;
    ++		goto out;
    + 	}
    + 
    +-	for (i = 0; i < s.file_diff_nr; i++)
    +-		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
    +-			binary_count++;
    +-		else if (patch_update_file(&s, s.file_diff + i))
    +-			break;
    ++	ret = run_add_p_common(&s, ps);
    ++	if (ret < 0)
    ++		goto out;
    + 
    +-	if (s.file_diff_nr == 0)
    +-		err(&s, _("No changes."));
    +-	else if (binary_count == s.file_diff_nr)
    +-		err(&s, _("Only binary files changed."));
    ++	ret = 0;
    + 
    ++out:
      	add_p_state_clear(&s);
    - 	return 0;
    - }
    +-	return 0;
    ++	return ret;
    ++}
     +
     +int run_add_p_index(struct repository *r,
     +		    struct index_state *index,
    @@ add-patch.c: int run_add_p(struct repository *r, enum add_p_mode mode,
     +	};
     +	struct strbuf parent_revision = STRBUF_INIT;
     +	char parent_tree_oid[GIT_MAX_HEXSZ + 1];
    -+	size_t binary_count = 0;
     +	struct commit *commit;
     +	int ret;
     +
    @@ add-patch.c: int run_add_p(struct repository *r, enum add_p_mode mode,
     +
     +	interactive_config_init(&s.cfg, r, opts);
     +
    -+	if (parse_diff(&s, ps) < 0) {
    -+		ret = -1;
    ++	ret = run_add_p_common(&s, ps);
    ++	if (ret < 0)
     +		goto out;
    -+	}
    -+
    -+	for (size_t i = 0; i < s.file_diff_nr; i++) {
    -+		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
    -+			binary_count++;
    -+		else if (patch_update_file(&s, s.file_diff + i))
    -+			break;
    -+	}
    -+
    -+	if (s.file_diff_nr == 0) {
    -+		err(&s, _("No changes."));
    -+		ret = -1;
    -+		goto out;
    -+	}
    -+
    -+	if (binary_count == s.file_diff_nr) {
    -+		err(&s, _("Only binary files changed."));
    -+		ret = -1;
    -+		goto out;
    -+	}
     +
     +	ret = 0;
     +
    @@ add-patch.c: int run_add_p(struct repository *r, enum add_p_mode mode,
     +	strbuf_release(&parent_revision);
     +	add_p_state_clear(&s);
     +	return ret;
    -+}
    + }
     
      ## add-patch.h ##
     @@
 -:  ---------- > 10:  6f8c443002 add-patch: allow disabling editing of hunks
10:  2a43a306de ! 11:  f5f4ab21bb cache-tree: allow writing in-memory index as tree
    @@ cache-tree.c: static int write_index_as_tree_internal(struct object_id *oid,
      	was_valid = index_state->cache_tree &&
      		    cache_tree_fully_valid(index_state->cache_tree);
      
    -@@ cache-tree.c: struct tree* write_in_core_index_as_tree(struct repository *repo) {
    - 	return lookup_tree(repo, &index_state->cache_tree->oid);
    - }
    - 
    --
    - int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
    - {
    - 	int entries, was_valid;
     
      ## cache-tree.h ##
     @@ cache-tree.h: int cache_tree_verify(struct repository *, struct index_state *);
11:  bbb837e8d6 ! 12:  0d294bf943 builtin/history: implement "split" subcommand
    @@ Documentation/git-history.adoc: Several commands are available to rewrite histor
     +	stays intact, except that its parent will be the newly split-out
     +	commit.
     ++
    -+The commit message of the new commit will be asked for by launching the
    -+configured editor. Authorship of the commit will be the same as for the
    ++The commit messages of the split-up commits will be asked for by launching
    ++the configured editor. Authorship of the commit will be the same as for the
     +original commit.
     ++
     +If passed, _<pathspec>_ can be used to limit which changes shall be split out
    @@ Documentation/git-history.adoc: Several commands are available to rewrite histor
      CONFIGURATION
      -------------
      
    -@@ Documentation/git-history.adoc: include::includes/cmd-config-section-all.adoc[]
    - 
    - include::config/sequencer.adoc[]
    + include::includes/cmd-config-section-all.adoc[]
      
     +EXAMPLES
     +--------
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +			struct object_id *out)
     +{
     +	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
    -+	struct strbuf index_file = STRBUF_INIT, split_message = STRBUF_INIT;
    ++	struct strbuf index_file = STRBUF_INIT;
     +	struct child_process read_tree_cmd = CHILD_PROCESS_INIT;
     +	struct index_state index = INDEX_STATE_INIT(repo);
     +	struct object_id original_commit_tree_oid, parent_tree_oid;
    -+	const char *original_message, *original_body, *ptr;
     +	char original_commit_oid[GIT_MAX_HEXSZ + 1];
    -+	char *original_author = NULL;
     +	struct commit_list *parents = NULL;
     +	struct commit *first_commit;
     +	struct tree *split_tree;
    -+	size_t len;
     +	int ret;
     +
     +	if (original_commit->parents)
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +
     +	oid_to_hex_r(original_commit_oid, &original_commit->object.oid);
     +	ret = run_add_p_index(repo, &index, index_file.buf, &interactive_opts,
    -+			      original_commit_oid, pathspec);
    ++			      original_commit_oid, pathspec, ADD_P_DISALLOW_EDIT);
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +		goto out;
     +	}
     +
    -+	/* We retain authorship of the original commit. */
    -+	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
    -+	ptr = find_commit_header(original_message, "author", &len);
    -+	if (ptr)
    -+		original_author = xmemdupz(ptr, len);
    -+
    -+	ret = fill_commit_message(repo, &parent_tree_oid, &split_tree->object.oid,
    -+				  "", "split-out", &split_message);
    -+	if (ret < 0)
    -+		goto out;
    -+
    -+	ret = commit_tree(split_message.buf, split_message.len, &split_tree->object.oid,
    -+			  original_commit->parents, &out[0], original_author, NULL);
    ++	/*
    ++	 * The first commit is constructed from the split-out tree. The base
    ++	 * that shall be diffed against is the parent of the original commit.
    ++	 */
    ++	ret = commit_tree_with_edited_message(repo, "split-out", original_commit,
    ++					      &split_tree->object.oid,
    ++					      original_commit->parents, &parent_tree_oid, &out[0]);
     +	if (ret < 0) {
     +		ret = error(_("failed writing split-out commit"));
     +		goto out;
     +	}
     +
     +	/*
    -+	* The second commit is much simpler to construct, as we can simply use
    -+	* the original commit details, except that we adjust its parent to be
    -+	* the newly split-out commit.
    ++	* The second commit is constructed from the original tree. The base to
    ++	* diff against and the parent in this case is the first split-out
    ++	* commit.
     +	*/
    -+	find_commit_subject(original_message, &original_body);
     +	first_commit = lookup_commit_reference(repo, &out[0]);
     +	commit_list_append(first_commit, &parents);
     +
    -+	ret = commit_tree(original_body, strlen(original_body), &original_commit_tree_oid,
    -+			  parents, &out[1], original_author, NULL);
    ++	ret = commit_tree_with_edited_message(repo, "split-out", original_commit,
    ++					      &original_commit_tree_oid,
    ++					      parents, get_commit_tree_oid(first_commit), &out[1]);
     +	if (ret < 0) {
    -+		ret = error(_("failed writing second commit"));
    ++		ret = error(_("failed writing split-out commit"));
     +		goto out;
     +	}
     +
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +out:
     +	if (index_file.len)
     +		unlink(index_file.buf);
    -+	strbuf_release(&split_message);
     +	strbuf_release(&index_file);
     +	free_commit_list(parents);
    -+	free(original_author);
     +	release_index(&index);
     +	return ret;
     +}
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +	struct option options[] = {
     +		OPT_END(),
     +	};
    -+	struct oidmap rewritten_commits = OIDMAP_INIT;
     +	struct commit *original_commit, *parent, *head;
     +	struct strvec commits = STRVEC_INIT;
    -+	struct commit_list *from_list = NULL;
     +	struct object_id split_commits[2];
     +	struct pathspec pathspec = { 0 };
     +	int ret;
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +	}
     +	repo_config(repo, git_default_config, NULL);
     +
    -+	original_commit = lookup_commit_reference_by_name(argv[0]);
    -+	if (!original_commit) {
    -+		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
    -+		goto out;
    -+	}
    -+
    -+	parent = original_commit->parents ? original_commit->parents->item : NULL;
    -+	if (parent && repo_parse_commit(repo, parent)) {
    -+		ret = error(_("unable to parse commit %s"),
    -+			    oid_to_hex(&parent->object.oid));
    -+		goto out;
    -+	}
    -+
    -+	head = lookup_commit_reference_by_name("HEAD");
    -+	if (!head) {
    -+		ret = error(_("could not resolve HEAD to a commit"));
    -+		goto out;
    -+	}
    -+
    -+	commit_list_append(original_commit, &from_list);
    -+	if (!repo_is_descendant_of(repo, head, from_list)) {
    -+		ret = error(_("split commit must be reachable from current HEAD commit"));
    -+		goto out;
    -+	}
    -+
     +	parse_pathspec(&pathspec, 0,
     +		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
     +		prefix, argv + 1);
     +
    -+	/*
    -+	 * Collect the list of commits that we'll have to reapply now already.
    -+	 * This ensures that we'll abort early on in case the range of commits
    -+	 * contains merges, which we do not yet handle.
    -+	 */
    -+	ret = collect_commits(repo, parent, head, &commits);
    ++	ret = gather_commits_between_head_and_revision(repo, argv[0], &original_commit,
    ++						       &parent, &head, &commits);
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +	ret = 0;
     +
     +out:
    -+	oidmap_clear(&rewritten_commits, 0);
    -+	free_commit_list(from_list);
     +	clear_pathspec(&pathspec);
     +	strvec_clear(&commits);
     +	return ret;
    @@ t/t3452-history-split.sh (new)
     +
     +. ./test-lib.sh
     +
    ++# The fake editor takes multiple arguments, each of which represents a commit
    ++# message. Subsequent invocations of the editor will then yield those messages
    ++# in order.
    ++#
     +set_fake_editor () {
    -+	write_script fake-editor.sh <<-EOF &&
    -+	echo "$@" >"\$1"
    ++	printf "%s\n" "$@" >fake-input &&
    ++	write_script fake-editor.sh <<-\EOF &&
    ++	head -n1 fake-input >"$1"
    ++	sed 1d fake-input >fake-input.trimmed &&
    ++	mv fake-input.trimmed fake-input
     +	EOF
     +	test_set_editor "$(pwd)"/fake-editor.sh
     +}
    @@ t/t3452-history-split.sh (new)
     +		git switch branch &&
     +		test_commit theirs &&
     +		test_must_fail git history split ours 2>err &&
    -+		test_grep "split commit must be reachable from current HEAD commit" err
    ++		test_grep "commit must be reachable from current HEAD commit" err
     +	)
     +'
     +
    @@ t/t3452-history-split.sh (new)
     +		git commit -m split-me &&
     +
     +		git symbolic-ref HEAD >expect &&
    -+		set_fake_editor "split-out commit" &&
    ++		set_fake_editor "first" "second" &&
     +		git history split HEAD <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +		test_cmp expect actual &&
     +
     +		expect_log <<-EOF &&
    -+		split-me
    -+		split-out commit
    ++		second
    ++		first
     +		initial
     +		EOF
     +
    @@ t/t3452-history-split.sh (new)
     +		initial.t
     +		EOF
     +
    -+		expect_tree_entries HEAD <<-EOF
    ++		expect_tree_entries HEAD <<-EOF &&
     +		bar
     +		foo
     +		initial.t
     +		EOF
    ++
    ++		git reflog >reflog &&
    ++		test_grep "split: updating HEAD" reflog
     +	)
     +'
     +
    @@ t/t3452-history-split.sh (new)
     +		git commit -m root &&
     +		test_commit tip &&
     +
    -+		set_fake_editor "split-out commit" &&
    ++		set_fake_editor "first" "second" &&
     +		git history split HEAD~ <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +
     +		expect_log <<-EOF &&
     +		tip
    -+		root
    -+		split-out commit
    ++		second
    ++		first
     +		EOF
     +
     +		expect_tree_entries HEAD~2 <<-EOF &&
    @@ t/t3452-history-split.sh (new)
     +		git commit -m split-me &&
     +		test_commit tip &&
     +
    -+		set_fake_editor "split-out commit" &&
    ++		set_fake_editor "first" "second" &&
     +		git history split HEAD~ <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +
     +		expect_log <<-EOF &&
     +		tip
    -+		split-me
    -+		split-out commit
    ++		second
    ++		first
     +		initial
     +		EOF
     +
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    -+		set_fake_editor "split-out-commit" &&
    ++		set_fake_editor "first" "second" &&
     +		git history split HEAD <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    -+		set_fake_editor "split-out commit" &&
    ++		set_fake_editor "first" "second" &&
     +		git history split HEAD <<-EOF &&
     +		n
     +		y
     +		EOF
     +
     +		expect_log <<-EOF &&
    -+		split-me
    -+		split-out commit
    ++		second
    ++		first
     +		EOF
     +
     +		expect_tree_entries HEAD~ <<-EOF &&
    @@ t/t3452-history-split.sh (new)
     +		git commit -m split-me &&
     +
     +		write_script fake-editor.sh <<-\EOF &&
    -+		cp "$1" . &&
    -+		echo "some commit message" >>"$1"
    ++		cat "$1" >>MESSAGES &&
    ++		echo "some commit message" >"$1"
     +		EOF
     +		test_set_editor "$(pwd)"/fake-editor.sh &&
     +
    @@ t/t3452-history-split.sh (new)
     +		n
     +		EOF
     +
    ++		# Note that we expect to see the messages twice, once for each
    ++		# of the commits. The committed files are different though.
     +		cat >expect <<-EOF &&
    ++		split-me
     +
     +		# Please enter the commit message for the split-out changes. Lines starting
    -+		# with ${SQ}#${SQ} will be ignored.
    ++		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     +		# Changes to be committed:
     +		#	new file:   bar
     +		#
    ++		split-me
    ++
    ++		# Please enter the commit message for the split-out changes. Lines starting
    ++		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
    ++		# Changes to be committed:
    ++		#	new file:   foo
    ++		#
     +		EOF
    -+		test_cmp expect COMMIT_EDITMSG &&
    ++		test_cmp expect MESSAGES &&
     +
     +		expect_log <<-EOF
    -+		split-me
    ++		some commit message
     +		some commit message
     +		EOF
     +	)
    @@ t/t3452-history-split.sh (new)
     +		git add . &&
     +		git commit -m split-me &&
     +
    -+		set_fake_editor "split-out commit" &&
    ++		set_fake_editor "first" "second" &&
     +		git history split HEAD -- foo <<-EOF &&
     +		y
     +		EOF
    @@ t/t3452-history-split.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'hooks are executed for rewritten commits' '
    ++test_expect_success 'hooks are not executed for rewritten commits' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t3452-history-split.sh (new)
     +		git commit -m split-me &&
     +		old_head=$(git rev-parse HEAD) &&
     +
    -+		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    -+		touch "$(pwd)/hooks.log"
    -+		EOF
    -+		write_script .git/hooks/post-commit <<-EOF &&
    -+		touch "$(pwd)/hooks.log"
    -+		EOF
    -+		write_script .git/hooks/post-rewrite <<-EOF &&
    -+		touch "$(pwd)/hooks.log"
    -+		EOF
    ++		ORIG_PATH="$(pwd)" &&
    ++		export ORIG_PATH &&
    ++		for hook in prepare-commit-msg pre-commit post-commit post-rewrite commit-msg
    ++		do
    ++			write_script .git/hooks/$hook <<-\EOF || exit 1
    ++			touch "$ORIG_PATH/hooks.log
    ++			EOF
    ++		done &&
     +
    -+		set_fake_editor "split-out commit" &&
    ++		set_fake_editor "first" "second" &&
     +		git history split HEAD <<-EOF &&
     +		y
     +		n
     +		EOF
     +
     +		expect_log <<-EOF &&
    -+		split-me
    -+		split-out commit
    ++		second
    ++		first
     +		EOF
     +
     +		test_path_is_missing hooks.log
    @@ t/t3452-history-split.sh (new)
     +		echo a-modified >a &&
     +		echo b-modified >b &&
     +		git add b &&
    -+		set_fake_editor "a-only" &&
    ++		set_fake_editor "a-only" "remainder" &&
     +		git history split HEAD <<-EOF &&
     +		y
     +		n
    @@ t/t3452-history-split.sh (new)
     +		?? actual
     +		?? expect
     +		?? fake-editor.sh
    ++		?? fake-input
     +		EOF
     +		git status --porcelain >actual &&
     +		test_cmp expect actual

---
base-commit: 0d4583b45432bff1cdc7689c648fb51be3d7b321
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

