Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B1BA3F
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056161; cv=none; b=FaekZQb/t8fWmP2+ccuWeFosJbfzSa9ihOSMvzLlAT967dTVoKtihxa7a+PXtsQF+aZ91rGL1MPxta6t2FjOBwFqbk+QDqWyEjs1Ime943sSrSOCrfM2N8ouLrXbULwjmR6CmTZjAk7oTdgpwS0rLPh3pzW/VnxvT6XQY0kGr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056161; c=relaxed/simple;
	bh=Fdn9a8nMXh5nZ7WTXAH2OidlwQlfmLK7L316FlcIh7E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=mGhA3fNIz6ERNV/4gGeJ4ZN0I+2IjeIH977vXI2gmfsElZmbFqgC2aJoDtkuXZ93JwWvztSX8ZQy5oAfwyeqH/ib5SfV2aAbJB3sjCTnNJfUQ763UNf7MK3P0AqqiDc/iOplR+A2uBxaBWkgK2pXCdX28z28F1oNjDw3azGoFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PmClGbOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6VvRH6e; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PmClGbOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6VvRH6e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 4CAA313802F9;
	Tue, 21 Oct 2025 10:15:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 10:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056158;
	 x=1761063358; bh=mLfS9Nnh5NzGEU7nTy3REu+qTxUV6vh3TRxealk5ym4=; b=
	PmClGbOQ3rQRqkmw+tYLJXIU1P1VQo+PHnlKuIi3MM1115/Y9gUScYmZ38arf+he
	SHM6Eb8ptHV5FwZ0/e+WMHaUnFdHGK8sNNxd0Rcjf9w935R9OGp15tI34AltIhwp
	wFnZZW1UQG62adhBt1TtzEvXI3N/df/UiyH9ysRakd38v8LAbTGxtFPLiIGrrwt0
	WBuG3czVZx6JRnrTwBiVkg8Wp8+9FgrNZHqw4jvmF2ctWSh7y+PdKZl2zMq2yguv
	Lkf9abcGckQTrQ3u97EC4liQ3xj3WXCWAmKE8ypHWVSgNY7VuvWiDPcCtsyMt/Ek
	FWtPczC9gFckMrIz5yPX2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056158; x=
	1761063358; bh=mLfS9Nnh5NzGEU7nTy3REu+qTxUV6vh3TRxealk5ym4=; b=i
	6VvRH6eDBlcuivxb1p0wYblYJviqIO/FQC1qrH2G/b3wDZhP9rgoVJ0BGqgSPQd6
	G6J68zE5rNUrT9J8S+QVUZRibbr/1lz81obrv3EdV/hMuMc5eQmegL77lVjlbVhf
	Ied1mF49TBmO9UNTEN9ZIgeOH7HMINV0gi7IhKrY3K4/XyLPclgvqJRyWw9xXayc
	dzfZY5p42CFN4t50zBe9WOAOsf8lsRnM3lMYUSuQRGXV0OVNinbas18rzXSGBWjd
	8mTSOa6xCiupqflba5dkR/xSwoNfRukZTd9ln2EyoTF8V+R2yF31oGw2LDk1z1n/
	gGWNLThJXDCVWxdk53UZA==
X-ME-Sender: <xms:npX3aNpDBkrK7Bx4bssSRvP2Y7SUs-PY-KcmUUtnR5-eMsosbAhf8w>
    <xme:npX3aCOgTPFEGu0G0GUWf6cdSYo6Niiwc_fs9HnP5_vsVMFV0DbLT87DS9JfPjWwl
    xvcCfHyzj3lQwuP_Do5aTB1fKsZYUk7welyNPpShAjhHwVVUCEYTQ>
X-ME-Received: <xmr:npX3aN114RYWY3z8fRm4ZAnEMD5J-rmerJMhfx6UIPDtvsE-hBKSeIU7xx99uVUiYgXgLASg34mMeK0xACo5L0-OResCzrj2QcvJRkr8bYEYNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeu
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:npX3aJByLKn8qEHIPoAvqdAFWgIFk0oUvNPB7g-qRsZqSM4bgKu55w>
    <xmx:npX3aCJXGvUcrW8E0aMkxxx5kfji77JagwZEeU1vx4Nh6wj4nJv8iQ>
    <xmx:npX3aKlbeefFSyuVy5lhFLix5FiStVNQKne3f81kfA_Kemm44ESUBQ>
    <xmx:npX3aDbZ2G0cBsGEI2GgEDpdhAKyXbSWZbiikX8g9-TF_VImpiU4pw>
    <xmx:npX3aFTQ4guEZ7UdS3t4Rvbr5BhuUSagY_7L226-qI87l2Xhn5a0GaMY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:15:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbd1c493 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:15:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/12] Introduce git-history(1) command for easy history
 editing
Date: Tue, 21 Oct 2025 16:15:48 +0200
Message-Id: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSV92gC/4XNyw6CMBAF0F8hXVvT6YvWlf9hXFBoZaICoUg0h
 n+3GONjQVzeyb1n7iT6Hn0km+xOej9ixLZJQa0yUtZFc/AUq5QJZ1wxA5Y6SbtjpDXGoe1v1F3
 wNGBDjRDWBFswFRhJ4673Aa9PeLdP+dV//hlhvv4lR6CMWpfnpeDamOC3qbXGM5m9kX8ZXC4af
 Da0LErgQStX/RjiY1i2bIhkzA0lFMhcqR9Dvg1gDBYNmQzjNVSVM1pA/jamaXoAJLXO8YUBAAA
 =
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
      replay: parse commits before dereferencing them
      builtin: add new "history" command
      builtin/history: implement "reword" subcommand
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      cache-tree: allow writing in-memory index as tree
      builtin/history: implement "split" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc | 114 ++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   2 +
 add-interactive.c              | 174 +++---------
 add-interactive.h              |  46 +---
 add-patch.c                    | 297 +++++++++++++++++---
 add-patch.h                    |  64 +++++
 builtin.h                      |   1 +
 builtin/add.c                  |  22 +-
 builtin/checkout.c             |   7 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 600 +++++++++++++++++++++++++++++++++++++++++
 builtin/replay.c               | 110 +-------
 builtin/reset.c                |  16 +-
 builtin/stash.c                |  46 ++--
 cache-tree.c                   |   5 +-
 cache-tree.h                   |   3 +-
 command-list.txt               |   1 +
 commit.h                       |   2 +-
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 118 ++++++++
 replay.h                       |  18 ++
 t/meson.build                  |   3 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 217 +++++++++++++++
 t/t3452-history-split.sh       | 447 ++++++++++++++++++++++++++++++
 wt-status.c                    |  24 ++
 wt-status.h                    |   3 +
 30 files changed, 2001 insertions(+), 377 deletions(-)

Range-diff versus v4:

 1:  5073f973555 !  1:  74adad5ad51 wt-status: provide function to expose status for trees
    @@ Commit message
         includes information around whether the working tree or the index have
         any changes.
     
    -    We're about to introduce a new command though where the changes in
    -    neither of them are actually relevant to us. Instead, what we want is to
    -    format the changes between two different trees. While it is a little bit
    -    of a stretch to add this as functionality to _working tree_ status, it
    +    We're about to introduce a new command where the changes in neither of
    +    them are actually relevant to us. Instead, what we want is to format the
    +    changes between two different trees. While it is a little bit of a
    +    stretch to add this as functionality to _working tree_ status, it
         doesn't make any sense to open-code this functionality, either.
     
         Implement a new function `wt_status_collect_changes_trees()` that diffs
 2:  b21049120fa !  2:  e92d28e9033 replay: extract logic to pick commits
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Makefile ##
    -@@ Makefile: LIB_OBJS += refs/ref-cache.o
    - LIB_OBJS += refspec.o
    +@@ Makefile: LIB_OBJS += reftable/tree.o
    + LIB_OBJS += reftable/writer.o
      LIB_OBJS += remote.o
      LIB_OBJS += replace-object.o
     +LIB_OBJS += replay.o
    @@ builtin/replay.c: static void determine_replay_mode(struct repository *repo,
     -	return create_commit(repo, result->tree, pickme, replayed_base);
     -}
     -
    - static int add_ref_to_transaction(struct ref_transaction *transaction,
    - 				  const char *refname,
    - 				  const struct object_id *new_oid,
    + static int handle_ref_update(const char *mode,
    + 			     struct ref_transaction *transaction,
    + 			     const char *refname,
     @@ builtin/replay.c: int cmd_replay(int argc,
      		if (commit->parents->next)
      			die(_("replaying merge commits is not supported yet!"));
 3:  be13cd322df =  3:  652fbddc10e replay: stop using `the_repository`
 4:  7af626c0fbc =  4:  0c9a409eea7 replay: parse commits before dereferencing them
 5:  ac152bca162 !  5:  d568ffc1f65 builtin: add new "history" command
    @@ Commit message
     
           - Multiple commits should be squashed into one.
     
    -    While these operations are all doable, it often feels needlessly cludgy
    +    While these operations are all doable, it often feels needlessly kludgey
         to do so by doing an interactive rebase, using the editor to say what
         one wants, and then perform the actions. Furthermore, some operations
         like splitting up a commit into two are way more involved than that and
    @@ Commit message
     
         Add a new "history" command to plug this gap. This command will have
         several different subcommands to imperatively rewrite history for common
    -    use cases like the above. These commands will be implemented in
    +    use cases like the above. These subcommands will be implemented in
         subsequent commits.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ Documentation/git-history.adoc (new)
     +history.
     +
     +This command is similar to linkgit:git-rebase[1] and uses the same
    -+underlying machinery. You should use rebases if you either want to
    -+reapply a range of commits onto a different base, or interactive rebases
    -+if you want to edit a range of commits.
    ++underlying machinery. You should use rebases if you want to reapply a range of
    ++commits onto a different base, or interactive rebases if you want to edit a
    ++range of commits.
     +
     +Note that this command does not (yet) work with histories that contain
     +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
 6:  8519861bfb0 !  6:  39acd4734c3 builtin/history: implement "reword" subcommand
    @@ builtin/history.c
     +#include "environment.h"
      #include "gettext.h"
     +#include "hex.h"
    -+#include "oidmap.h"
      #include "parse-options.h"
     +#include "refs.h"
     +#include "replay.h"
    @@ builtin/history.c
     +#include "tree.h"
     +#include "wt-status.h"
     +
    ++#define GIT_HISTORY_REWORD_USAGE N_("git history reword [<options>] <commit>")
    ++
     +static int collect_commits(struct repository *repo,
     +			   struct commit *old_commit,
     +			   struct commit *new_commit,
    @@ builtin/history.c
     +		.assume_dashdash = 1,
     +	};
     +	struct strvec revisions = STRVEC_INIT;
    -+	struct commit_list *from_list = NULL;
     +	struct commit *child;
     +	struct rev_info rev = { 0 };
     +	int ret;
     +
    -+	/*
    -+	 * Check that the old commit actually is an ancestor of HEAD. If not
    -+	 * the whole request becomes nonsensical.
    -+	*/
    -+	if (old_commit) {
    -+		commit_list_insert(old_commit, &from_list);
    -+		if (!repo_is_descendant_of(repo, new_commit, from_list)) {
    -+			ret = error(_("commit must be reachable from current HEAD commit"));
    -+			goto out;
    -+		}
    -+	}
    -+
     +	repo_init_revisions(repo, &rev, NULL);
     +	strvec_push(&revisions, "");
     +	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
    @@ builtin/history.c
     +	ret = 0;
     +
     +out:
    -+	free_commit_list(from_list);
     +	strvec_clear(&revisions);
     +	release_revisions(&rev);
     +	reset_revision_walk();
    @@ builtin/history.c
     +	if (!provided_message) {
     +		const char *path = git_path_commit_editmsg();
     +		const char *hint =
    -+			_("Please enter the commit message for the %s changes. Lines starting\n"
    -+     "with '%s' will be kept; you may remove them yourself if you want to.\n");
    ++			_("Please enter the commit message for the %s changes."
    ++			  " Lines starting\nwith '%s' will be ignored.\n");
     +		struct wt_status s;
     +
     +		strbuf_addstr(out, default_message);
    @@ builtin/history.c
     +			      struct repository *repo)
     +{
     +	const char * const usage[] = {
    -+		N_("git history reword [<options>] <commit>"),
    ++		GIT_HISTORY_REWORD_USAGE,
     +		NULL,
     +	};
     +	const char *commit_message = NULL;
    @@ builtin/history.c
     +	struct strvec commits = STRVEC_INIT;
     +	struct object_id parent_tree_oid, original_commit_tree_oid;
     +	struct object_id rewritten_commit;
    ++	struct commit_list *from_list = NULL;
     +	const char *original_message, *original_body, *ptr;
     +	char *original_author = NULL;
     +	size_t len;
    @@ builtin/history.c
     +		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
     +		goto out;
     +	}
    -+	if (repo_parse_commit(repo, original_commit)) {
    -+		ret = error(_("unable to parse commit %s"),
    -+			    oid_to_hex(&original_commit->object.oid));
    -+		goto out;
    -+	}
     +	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
     +
     +	parent = original_commit->parents ? original_commit->parents->item : NULL;
    @@ builtin/history.c
     +		goto out;
     +	}
     +
    ++	commit_list_append(original_commit, &from_list);
    ++	if (!repo_is_descendant_of(repo, head, from_list)) {
    ++		ret = error (_("split commit must be reachable from current HEAD commit"));
    ++		goto out;
    ++	}
    ++
     +	/*
     +	 * Collect the list of commits that we'll have to reapply now already.
     +	 * This ensures that we'll abort early on in case the range of commits
    @@ builtin/history.c
     +	if (ret < 0)
     +		goto out;
     +
    -+	ret = commit_tree(final_message.buf, final_message.len,
    -+			  &repo_get_commit_tree(repo, original_commit)->object.oid,
    ++	ret = commit_tree(final_message.buf, final_message.len, &original_commit_tree_oid,
     +			  original_commit->parents, &rewritten_commit, original_author, NULL);
     +	if (ret < 0) {
     +		ret = error(_("failed writing reworded commit"));
    @@ builtin/history.c
     +
     +out:
     +	strbuf_release(&final_message);
    ++	free_commit_list(from_list);
     +	strvec_clear(&commits);
     +	free(original_author);
     +	return ret;
    @@ builtin/history.c
      {
      	const char * const usage[] = {
      		N_("git history [<options>]"),
    -+		N_("git history reword [<options>] <commit>"),
    ++		GIT_HISTORY_REWORD_USAGE,
      		NULL,
      	};
     +	parse_opt_subcommand_fn *fn = NULL;
    @@ t/t3451-history-reword.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'refuses to work with unrelated commits' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit base &&
    ++		git branch branch &&
    ++		test_commit ours &&
    ++		git switch branch &&
    ++		test_commit theirs &&
    ++		test_must_fail git history reword ours 2>err &&
    ++		test_grep "split commit must be reachable from current HEAD commit" err
    ++	)
    ++'
    ++
     +test_expect_success 'can reword tip of a branch' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3451-history-reword.sh (new)
     +		first
     +
     +		# Please enter the commit message for the reworded changes. Lines starting
    -+		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
    ++		# with ${SQ}#${SQ} will be ignored.
     +		# Changes to be committed:
     +		#	new file:   first.t
     +		#
 7:  89883c85fa3 =  7:  2e4291a3b87 add-patch: split out header from "add-interactive.h"
 8:  f1602b8513c !  8:  715f3a32b82 add-patch: split out `struct interactive_options`
    @@ Metadata
      ## Commit message ##
         add-patch: split out `struct interactive_options`
     
    -    The `struct add_p_opt` is reused both by our the infra for "git add -p"
    -    and "git add -i". Users of `run_add_i()` for example are expected to
    -    pass `struct add_p_opt`. This is somewhat confusing and raises the
    -    question which options apply to what part of the stack.
    +    The `struct add_p_opt` is reused both by our infra for "git add -p" and
    +    "git add -i". Users of `run_add_i()` for example are expected to pass
    +    `struct add_p_opt`. This is somewhat confusing and raises the question
    +    of which options apply to what part of the stack.
     
         But things are even more confusing than that: while callers are expected
         to pass in `struct add_p_opt`, these options ultimately get used to
 9:  8ef83293ae5 =  9:  94ea67db00c add-patch: remove dependency on "add-interactive" subsystem
10:  385c39356dc ! 10:  19c02eb16de add-patch: add support for in-memory index patching
    @@ Commit message
         With `run_add_p()` callers have the ability to apply changes from a
         specific revision to a repository's index. This infra supports several
         different modes, like for example applying changes to the index,
    -    worktree or both.
    +    working tree or both.
     
         One feature that is missing though is the ability to apply changes to an
         in-memory index different from the repository's index. Add a new
    @@ add-patch.c
      #include "object-name.h"
      #include "pager.h"
      #include "read-cache-ll.h"
    +@@ add-patch.c: static struct patch_mode patch_mode_add = {
    + 		N_("Stage mode change [y,n,q,a,d%s,?]? "),
    + 		N_("Stage deletion [y,n,q,a,d%s,?]? "),
    + 		N_("Stage addition [y,n,q,a,d%s,?]? "),
    +-		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
    ++		N_("Stage this hunk [y,n,q,a,d%s,?]? "),
    + 	},
    + 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
    + 			     "will immediately be marked for staging."),
     @@ add-patch.c: struct hunk {
      
      struct add_p_state {
11:  d26e225c854 = 11:  3161d4bad3f cache-tree: allow writing in-memory index as tree
12:  fa878dc362c ! 12:  e7a6537ecfe builtin/history: implement "split" subcommand
    @@ builtin/history.c
      #include "commit.h"
      #include "config.h"
     @@
    + #include "environment.h"
    + #include "gettext.h"
      #include "hex.h"
    - #include "oidmap.h"
    ++#include "oidmap.h"
      #include "parse-options.h"
     +#include "path.h"
     +#include "read-cache.h"
    @@ builtin/history.c
      #include "sequencer.h"
      #include "strvec.h"
      #include "tree.h"
    + #include "wt-status.h"
    + 
    + #define GIT_HISTORY_REWORD_USAGE N_("git history reword [<options>] <commit>")
    ++#define GIT_HISTORY_SPLIT_USAGE  N_("git history split [<options>] <commit> [--] [<pathspec>...]")
    + 
    + static int collect_commits(struct repository *repo,
    + 			   struct commit *old_commit,
     @@ builtin/history.c: static int cmd_history_reword(int argc,
      	return ret;
      }
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +			     struct repository *repo)
     +{
     +	const char * const usage[] = {
    -+		N_("git history split [<options>] <commit>"),
    ++		GIT_HISTORY_SPLIT_USAGE,
     +		NULL,
     +	};
     +	const char *commit_message = NULL;
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +	struct oidmap rewritten_commits = OIDMAP_INIT;
     +	struct commit *original_commit, *parent, *head;
     +	struct strvec commits = STRVEC_INIT;
    -+	struct commit_list *list = NULL;
    ++	struct commit_list *from_list = NULL;
     +	struct object_id split_commits[2];
     +	struct pathspec pathspec = { 0 };
     +	int ret;
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +		goto out;
     +	}
     +
    -+	if (original_commit->parents && original_commit->parents->next) {
    -+		ret = error(_("commit to be split must not be a merge commit"));
    -+		goto out;
    -+	}
    -+
     +	parent = original_commit->parents ? original_commit->parents->item : NULL;
     +	if (parent && repo_parse_commit(repo, parent)) {
     +		ret = error(_("unable to parse commit %s"),
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +		goto out;
     +	}
     +
    -+	commit_list_append(original_commit, &list);
    -+	if (!repo_is_descendant_of(repo, original_commit, list)) {
    -+		ret = error (_("split commit must be reachable from current HEAD commit"));
    ++	commit_list_append(original_commit, &from_list);
    ++	if (!repo_is_descendant_of(repo, head, from_list)) {
    ++		ret = error(_("split commit must be reachable from current HEAD commit"));
     +		goto out;
     +	}
     +
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +		prefix, argv + 1);
     +
     +	/*
    -+	* Collect the list of commits that we'll have to reapply now already.
    -+	* This ensures that we'll abort early on in case the range of commits
    -+	* contains merges, which we do not yet handle.
    -+	*/
    ++	 * Collect the list of commits that we'll have to reapply now already.
    ++	 * This ensures that we'll abort early on in case the range of commits
    ++	 * contains merges, which we do not yet handle.
    ++	 */
     +	ret = collect_commits(repo, parent, head, &commits);
     +	if (ret < 0)
     +		goto out;
     +
     +	/*
     +	 * Then we split up the commit and replace the original commit with the
    -+	 * new new ones.
    ++	 * new ones.
     +	 */
     +	ret = split_commit(repo, original_commit, &pathspec,
     +			   commit_message, split_commits);
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     +
     +out:
     +	oidmap_clear(&rewritten_commits, 0);
    ++	free_commit_list(from_list);
     +	clear_pathspec(&pathspec);
     +	strvec_clear(&commits);
    -+	free_commit_list(list);
     +	return ret;
     +}
     +
    @@ builtin/history.c: static int cmd_history_reword(int argc,
     @@ builtin/history.c: int cmd_history(int argc,
      	const char * const usage[] = {
      		N_("git history [<options>]"),
    - 		N_("git history reword [<options>] <commit>"),
    -+		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
    + 		GIT_HISTORY_REWORD_USAGE,
    ++		GIT_HISTORY_SPLIT_USAGE,
      		NULL,
      	};
      	parse_opt_subcommand_fn *fn = NULL;
    @@ t/t3452-history-split.sh (new)
     +		git switch - &&
     +		git merge theirs &&
     +		test_must_fail git history split HEAD 2>err &&
    -+		test_grep "commit to be split must not be a merge commit" err &&
    ++		test_grep "cannot rearrange commit history with merges" err &&
     +		test_must_fail git history split HEAD~ 2>err &&
     +		test_grep "cannot rearrange commit history with merges" err
     +	)
     +'
     +
    ++test_expect_success 'refuses to work with unrelated commits' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit base &&
    ++		git branch branch &&
    ++		test_commit ours &&
    ++		git switch branch &&
    ++		test_commit theirs &&
    ++		test_must_fail git history split ours 2>err &&
    ++		test_grep "split commit must be reachable from current HEAD commit" err
    ++	)
    ++'
    ++
     +test_expect_success 'can split up tip commit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3452-history-split.sh (new)
     +		cat >expect <<-EOF &&
     +
     +		# Please enter the commit message for the split-out changes. Lines starting
    -+		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
    ++		# with ${SQ}#${SQ} will be ignored.
     +		# Changes to be committed:
     +		#	new file:   bar
     +		#

---
base-commit: eef20e55db9c6590670e245245e207271daea61f
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

