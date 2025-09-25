Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01414A8E
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838015; cv=none; b=Ffl3YxvXX3wkmYPSai7opfYnHDVQagHEAV66qLt7Hsac+TCoGl2nBmFuqsMjh9zbhwyKBT6cW2exZuaClFrann8ENckWCP7/lK+CIFqleDgEOeJ+fKqV9CoO6isteNVaC/0pUDiFIcp3SzTXzQnbQRQG7nKo6mP5CIIteVJzq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838015; c=relaxed/simple;
	bh=8t3XNOiBJz7LvIv5vsrBOZdugSJMrU2PpvK8EY7c3AY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gOnzhDtcblzpOMOoVSjlUX6SCe8UHizJHCkLrw9eD02H+4YBSfF7V4LlOCpO9GvhqNTGYbMCQrKsdHIv6Z/ad/Jw4SADItztZYCLhNHX1oVJ4DoVeB4ixy4pjTZlm9Ydl6ZxvOTJY0HOyUS1saeN5eC+TN2hhl2OFrwh59weMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=si/EoHDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdIa+247; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="si/EoHDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdIa+247"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C0601400054;
	Thu, 25 Sep 2025 18:06:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 25 Sep 2025 18:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1758838011; x=1758924411; bh=F5WCn0G/S8
	Kdk+yBnmEbNAGTMUPMVsBcAkmlh7ziX5s=; b=si/EoHDR9xjsM6NJXFbMeOtn0+
	yHtYLs9FzY1tdDy3xa8jq4wj+h0FeTaw5COLwta4pWzW/yy6/wnFssBnmIy5hXSC
	GkXD0cYIwZK3Ylt1eCdAVqMA4hqnPQCb4fa+cwLhD1hZC7f5eKrTxFdODgZxGXd6
	jDMddWDuw1okWC+A86Yo8z/EZ3ZvBE7gBu0F/fOJp7Wz9nmFryR6s4kyF3PK6imn
	MmBPvjZU7RawakrnE6pmsz4u47TxwPRif7DZnFl8wCnFb1hpQAfY6rgA/iHXGtil
	89ss1hiFOqWGMV/8aXf5VV5tZxQo8HCeOrQo0ICdcMbNphdhWsUhu945/Qcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758838011; x=1758924411; bh=F5WCn0G/S8Kdk+yBnmEbNAGTMUPMVsBcAkm
	lh7ziX5s=; b=YdIa+247gwUClfCeo25DzDnCr6egPsiKWy3rzruhoIU69grpZo5
	pJ0McvC834V2xbZQml9lYQjemhzJT2VCI+rWpSnZMeKXyu0IHQ1duaIYLCviBIpx
	yormzeDLKeyymieH2GBth5HmReeQFMyI/UXkgnHh1WvLrquYe3mpy204QZsOP7Vl
	5UD4Oecd25JLkMN2ukiciUm6jybc0Nt6lZY7MKE+kUw3UvY79d6dOCgi5KHK3Gbj
	2ed4daQ8veajLdth3IOz4Y5ZYSkv3XWEun3vGlgvVTmf55MQaw79hdxoe9irmAxd
	/69JnuPWiLZ9LqpL+OkLQ7qdsrl1TfRiyRg==
X-ME-Sender: <xms:-7zVaF-SVJbMJPKekyoo0RmXpgrKaOdDsY4rsTxDvbgcd-LaYYcL1Q>
    <xme:-7zVaBKk6QCV3rsPKvKyDteh1hTUkrjTYBpRM16M7KWDLUac2zrzEsqDnrmfEVjIc
    aciegrq7Qh2STXNOVN0kN0aYi-sud_jj4VFVLaa-E8Y_viCSaR8>
X-ME-Received: <xmr:-7zVaAYQ-V1QOvHNiM6htyAM4DUNt1v9t2mpCxREewMIzkkhS_NMWtn_Xbh4hxHdYhrA7y3gLXRZnCzgffgneUHewTREg1aZFjbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtgfesthekredttderje
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepvdejffevgfefieffhfektdejuedtjeeigf
    elieeugeeifefhteeifeeujeelueeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    ohhrrdgtiidpghhoohhglhgvshhouhhrtggvrdgtohhmpdhgihhthhhusgdrtghomhdpgh
    hithhlrggsrdgtohhmpdhmrghsthgvrhdrlhgtpdhlohgtkhdrfihinhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifnh
    eslhifnhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-7zVaDK6w6k7Y_SMEzFL89KilyXCqfHFnVpO68pkzlGCz-eX-8nuwg>
    <xmx:-7zVaOCuGI6scFUogosdkiVp5wUGuWFYQ5tXCccW7GQx6WmIOW0n-Q>
    <xmx:-7zVaIo2sS71A1FfKeNcRFdkVuVaYLwzzUxZ99VRdqvz_GhWufYmXA>
    <xmx:-7zVaJg-f3nX2Gnl6Pxc92e0IqpU5J2QNSPMQ2NpiBDk86L-2q4uKQ>
    <xmx:-7zVaD2MKNtBRs0E-rA_J7aEI0SjDrGvLTRNoUlvYNkhiEnFlUldr-mU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 18:06:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2025, #10; Thu, 25)
X-master-at: bb69721404348ea2db0a081c41ab6ebfe75bdec8
X-next-at: de9c8c526cb441e136815397089584f539713c71
Date: Thu, 25 Sep 2025 15:06:49 -0700
Message-ID: <xmqqbjmydw5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* cc/promisor-remote-capability (2025-09-07) 7 commits
  (merged to 'next' on 2025-09-15 at 367d83c08c)
 + promisor-remote: use string_list_split() in mark_remotes_as_accepted()
 + promisor-remote: allow a client to check fields
 + promisor-remote: use string_list_split() in filter_promisor_remote()
 + promisor-remote: refactor how we parse advertised fields
 + promisor-remote: use string constants for 'name' and 'url' too
 + promisor-remote: allow a server to advertise more fields
 + promisor-remote: refactor to get rid of 'struct strvec'

 The "promisor-remote" capability mechanism has been updated to
 allow the "partialCloneFilter" settings and the "token" value to be
 communicated from the server side.
 source: <20250908053056.956907-1-christian.couder@gmail.com>


* cs/subtree-squash-split-fix (2025-09-09) 1 commit
  (merged to 'next' on 2025-09-15 at 4206316342)
 + contrib/subtree: fix split with squashed subtrees

 "git subtree" (in contrib/) did not work correctly when splitting
 squashed subtrees, which has been improved.
 source: <20250910031124.1807856-1-ask+git@howdoi.land>


* jk/add-i-color (2025-09-08) 4 commits
  (merged to 'next' on 2025-09-15 at 48aae5184a)
 + contrib/diff-highlight: mention interactive.diffFilter
 + add-interactive: manually fall back color config to color.ui
 + add-interactive: respect color.diff for diff coloring
 + stash: pass --no-color to diff plumbing child processes
 (this branch is used by jk/color-variable-fixes.)

 Some among "git add -p" and friends ignored color.diff and/or
 color.ui configuration variables, which is an old regression, which
 has been corrected.
 source: <20250908164157.GA1323487@coredump.intra.peff.net>


* rs/get-oid-with-flags-cleanup (2025-09-10) 1 commit
  (merged to 'next' on 2025-09-15 at ff8d1faae9)
 + use repo_get_oid_with_flags()

 Code clean-up.
 source: <906196ac-2fd7-4c07-9e8f-22d67b0b64f9@web.de>

--------------------------------------------------
[New Topics]

* kh/format-patch-range-diff-notes (2025-09-25) 3 commits
 - format-patch: handle range-diff on notes correctly for single patches
 - revision: add rdiff_log_arg to rev_info
 - range-diff: rename other_arg to log_arg

 "git format-patch --range-diff=... --notes=..." did not drive the
 underlying range-diff with correct --notes parameter, ending up
 comparing with different set of notes from its main patch output
 you would get from "git format-patch --notes=..." for a singleton
 patch.

 Will merge to 'next'?
 source: <v2-cover.1758819879.git.code@khaugsbakk.name>


* je/doc-pull (2025-09-23) 4 commits
 - doc: git-pull: clarify how to exit a conflicted merge
 - doc: git-pull: delete the example
 - doc: git-pull: clarify options for integrating remote branch
 - doc: git-pull: move <repository> and <refspec> params

 Documentation updates.
 source: <pull.1976.git.1758656702.gitgitgadget@gmail.com>


* je/doc-push-upstream (2025-09-23) 4 commits
 - doc: git-push: clarify "what to push"
 - doc: git-push: clarify "where to push"
 - doc: add an UPSTREAM BRANCHES section to pull/push/fetch
 - doc: git-push: clarify intro

 Documentation updates.
 source: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>


* jk/diff-no-index-with-pathspec-fix (2025-09-24) 1 commit
 - diff --no-index: fix logic for paths ending in '/'

 An earlier addition to "git diff --no-index A B" to limit the
 output with pathspec after the two directories misbehaved when
 these directories were given with a trailing slash, which has been
 corrected.
 source: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>


* jt/repo-stats (2025-09-24) 6 commits
 - builtin/repo: add progress meter for stats
 - builtin/repo: add keyvalue and nul format for stats
 - builtin/repo: add object counts in stats output
 - builtin/repo: introduce stats subcommand
 - ref-filter: allow NULL filter pattern
 - builtin/repo: rename repo_info() to cmd_repo_info()

 "git repo stats", a new command.
 source: <20250924212426.2930029-1-jltobler@gmail.com>

--------------------------------------------------
[Stalled]

These topics have been expecting updates for quite some time.  I'll
eject any of them when they start to conflict with other topics in
'seen' and may drop them from my tree when they are dormant for too
long (let's say 8 weeks is way too long, for now).  After that, they
can be proposed again by rerolling them in a shape that would work
well with other topics in 'seen' (and of course 'next' and
"master').

* lc/rebase-trailer (2025-08-03) 2 commits
 - rebase: support --trailer
 - trailer: append trailers in-process and drop the fork to `interpret-trailers`

 Expecting a reroll.
 cf. <198826af571.62b85cb31711042.2415806544948206668@linux.beauty>
 cf. <xmqqiki7qasu.fsf@gitster.g>
 source: <20250803150059.402017-1-me@linux.beauty>


* ac/deglobal-sparse-variables (2025-07-18) 3 commits
 . environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
 . environment: move access to "core.sparsecheckoutcone" into repo_settings
 . environment: move access to "core.sparsecheckout" into repo_settings

 Two global variables related to sparse checkout have been moved to
 the repository settings structure.

 Expecting a reroll.
 cf. <CAE7as+bnG6KgA8X_n36pqP15bmyM6re+xEb1MOXKvZSUdJ8Arg@mail.gmail.com>
 Ejected out of 'seen' for now.
 source: <cover.1752882401.git.ayu.chandekar@gmail.com>

--------------------------------------------------
[Cooking]

* jk/setup-revisions-freefix (2025-09-19) 6 commits
  (merged to 'next' on 2025-09-23 at e30036fad0)
 + revision: retain argv NULL invariant in setup_revisions()
 + treewide: pass strvecs around for setup_revisions_from_strvec()
 + treewide: use setup_revisions_from_strvec() when we have a strvec
 + revision: add wrapper to setup_revisions() from a strvec
 + revision: manage memory ownership of argv in setup_revisions()
 + stash: tell setup_revisions() to free our allocated strings

 There are double frees and leaks around setup_revisions() API used
 in "git stash show", which has been fixed, and setup_revisions()
 API gained a wrapper to make it more ergonomic when using it with
 strvec-manged argc/argv pairs.

 Will merge to 'master'.
 source: <20250919223351.GA3906184@coredump.intra.peff.net>


* js/curl-off-t-fixes (2025-09-21) 3 commits
 - http-push: avoid new compile error
 - imap-send: be more careful when casting to `curl_off_t`
 - http: offer to cast `size_t` to `curl_off_t` safely

 A few places where an size_t value was cast to curl_off_t without
 checking has been updated to use the existing helper function.

 Expecting a (hopefully small) reroll to clarify log message.
 cf. <pull.1974.git.1758457356.gitgitgadget@gmail.com>
 source: <pull.1974.git.1758457356.gitgitgadget@gmail.com>


* kn/reftable-consistency-checks (2025-09-18) 9 commits
 - fixup! reftable: check for trailing newline in 'tables.list'
 - refs/reftable: add fsck check for checking the table name
 - reftable: add code to facilitate consistency checks
 - fsck: order 'fsck_msg_type' alphabetically
 - Documentation/fsck-msgids: remove duplicate msg id
 - reftable: ensure tables in a stack use sequential update indices
 - reftable: check for trailing newline in 'tables.list'
 - refs: move consistency check msg to generic layer
 - refs: remove unused headers

 The reftable backend learned to sanity check its on-disk data more
 carefully.

 Expecting a reroll.
 cf. <CAOLa=ZQMDjpMLeyHxeePY3VQjD1GhotXA6-GDhTNY_BDu4zSVQ@mail.gmail.com>
 source: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>


* pw/rebase-i-cleanup-fix (2025-09-18) 2 commits
  (merged to 'next' on 2025-09-22 at 2d0aec7821)
 + sequencer: remove VERBATIM_MSG flag
 + rebase -i: respect commit.cleanup when picking fixups

 "git rebase -i" failed to clean-up the commit log message when the
 command commits the final one in a chain of "fixup" commands, which
 has been corrected.

 Will merge to 'master'.
 source: <cover.1758186038.git.phillip.wood@dunelm.org.uk>


* tc/last-modified-recursive-fix (2025-09-18) 1 commit
  (merged to 'next' on 2025-09-23 at 3be2b08060)
 + last-modified: fix bug when some paths remain unhandled

 "git last-modified" operating in non-recursive mode used to trigger
 a BUG(), which has been corrected.

 Will merge to 'master'.
 source: <20250918-toon-fix-last-modified-v3-1-0c3910e224f6@iotcl.com>


* en/rust-wip (2025-09-16) 18 commits
 . misc::varint: reimplement as test balloon for Rust
 . misc: use BuildHelper
 . build: new crate, misc
 . varint: use explicit width for integers
 . build-helper: cbindgen, let crates generate a header file
 . build-helper: link against libgit.a and any other required C libraries
 . build: new crate, build-helper
 . github workflows: upload Cargo.lock
 . win+Meson: do allow linking with the Rust-built xdiff
 . github workflows: install rust
 . help: report on whether or not Rust is enabled
 . build: introduce rust
 . BreakingChanges: announce Rust becoming mandatory
 . doc: add a policy for using Rust
 . make: merge reftable lib into libgit.a
 . make: merge xdiff lib into libgit.a
 . make: add -fPIE flag
 . cleanup: rename variables that collide with Rust primitive type names

 Expecting a reroll, but probably xdiff stuff comes first?
 source: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>


* bc/sha1-256-interop-01 (2025-09-19) 10 commits
 - fixup! docs: add documentation for loose objects
 - t: add a prerequisite for a compatibility hash
 - Allow specifying compatibility hash
 - fsck: consider gpgsig headers expected in tags
 - rev-parse: allow printing compatibility hash
 - docs: add documentation for loose objects
 - docs: improve ambiguous areas of pack format documentation
 - docs: reflect actual double signature for tags
 - docs: update offset order for pack index v3
 - docs: update pack index v3 format

 The beginning of SHA1-SHA256 interoperability work.

 Expecting a reroll.
 cf. <aNHB4V7figj9lmfk@fruit.crustytoothpaste.net>
 source: <20250919010911.649831-1-sandals@crustytoothpaste.net>


* pw/add-p-hunk-splitting-fix (2025-09-25) 2 commits
 - add-patch: update hunk splitability after editing
 - add -p: mark split hunks as undecided

 Marking a hunk 'selected' in "git add -p" and then splitting made
 all the split pieces 'selected'; this has been changed to make them
 all 'undecided', which gives better end-user experience.

 Will merge to 'next'?
 source: <pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>


* dk/stash-apply-index (2025-09-21) 4 commits
  (merged to 'next' on 2025-09-23 at 04e76cf5be)
 + stash: honor stash.index in apply, pop modes
 + stash: refactor private config globals
 + t3905: remove unneeded blank line
 + t3903: reduce dependencies on previous tests

 The stash.index configuration variable can be set to make "git stash
 pop/apply" pretend that it was invoked with "--index".

 Will merge to 'master'.
 source: <cover.1758505011.git.ben.knoble+github@gmail.com>


* jk/color-variable-fixes (2025-09-16) 13 commits
  (merged to 'next' on 2025-09-23 at 8aa3006a1e)
 + config: store want_color() result in a separate bool
 + add-interactive: retain colorbool values longer
 + color: return bool from want_color()
 + color: use git_colorbool enum type to store colorbools
 + pretty: use format_commit_context.auto_color as colorbool
 + diff: stop passing ecbdata->use_color as boolean
 + diff: pass o->use_color directly to fill_metainfo()
 + diff: don't use diff_options.use_color as a strict bool
 + diff: simplify color_moved check when flushing
 + grep: don't treat grep_opt.color as a strict bool
 + color: return enum from git_config_colorbool()
 + color: use GIT_COLOR_* instead of numeric constants
 + Merge branch 'jk/add-i-color' into jk/color-variable-fixes

 Some places in the code confused a variable that is *not* a boolean
 to enable color but is an enum that records what the user requested
 to do about color.  A couple of bugs of this sort have been fixed,
 while the code has been cleaned up to prevent similar bugs in the
 future.

 Will merge to 'master'.
 source: <20250916201036.GA612463@coredump.intra.peff.net>
 source: <20250916202408.GI612873@coredump.intra.peff.net>


* en/xdiff-cleanup (2025-09-23) 13 commits
 - xdiff: change type of xdfile_t.changed from char to bool
 - xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
 - xdiff: rename rchg -> changed in xdfile_t
 - xdiff: delete rchg aliasing
 - xdiff: delete chastore from xdfile_t
 - xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
 - xdiff: delete redundant array xdfile_t.ha
 - xdiff: delete struct diffdata_t
 - xdiff: delete superfluous local variables that alias fields in xrecord_t
 - xdiff: delete superfluous function xdl_get_rec() in xemit
 - xdiff: delete unnecessary fields from xrecord_t and xdfile_t
 - xdiff: delete local variables and initialize/free xdfile_t directly
 - xdiff: delete static forward declarations in xprepare

 A lot of code clean-up of xdiff.
 Split out of a larger topic.

 Expecting a reroll with better log messages.
 cf. <CAH=ZcbC-cB35AGmiKgEQdFa5ee+DftwOQ_dUe4=T+Vq-dxR+qQ@mail.gmail.com>
 source: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>


* jc/3.0-default-initial-branch-to-main-addendum (2025-09-17) 1 commit
  (merged to 'next' on 2025-09-22 at dc4168c337)
 + initial branch: give hints after switching the default name
 (this branch uses pw/3.0-default-initial-branch-to-main.)

 Keep giving hint about the default initial branch name for users
 who may be surprised after Git 3.0 switchover.

 Will merge to 'master'.
 source: <cover.1757518141.git.phillip.wood@dunelm.org.uk>


* nb/send-email-no-dup-reply-to (2025-09-16) 1 commit
  (merged to 'next' on 2025-09-18 at d7081e00ec)
 + send-email: don't duplicate Reply-to: in intro message

 "git send-email --compose --reply-to=<address>" used to add
 duplicated Reply-To: header, which made mailservers unhappy.  This
 has been corrected.

 Will merge to 'master'.
 source: <175809074627.1696783.67425889158412786@noble.neil.brown.name>


* ar/submodule-gitdir-tweak (2025-09-08) 10 commits
 - t7425: add gitdir encoding tests
 - t7450: move nested gitdir tests to t7425
 - submodule: remove validate_submodule_git_dir()
 - submodule: error out if gitdir name is too long
 - submodule: encode gitdir paths to avoid conflicts
 - strbuf: bring back is_rfc3986_unreserved
 - t7425: add basic mixed submodule gitdir path tests
 - submodule: add gitdir path config override
 - submodule: create new gitdirs under submodules path
 - submodule--helper: use submodule_name_to_gitdir in add_submodule

 Avoid local submodule repository directory paths overlapping with
 each other by encoding submodule names before using them as path
 components.

 Expecting a reroll.
 cf. <87ecsf7g84.fsf@collabora.com> etc.
 source: <20250908140117.262205-1-adrian.ratiu@collabora.com>


* je/doc-push (2025-09-23) 2 commits
 - doc: git-push: rewrite refspec specification
 - doc: git-push: create PUSH RULES section

 Doc updates.

 Will merge to 'next'.
 source: <pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>


* ps/clar-updates (2025-09-22) 2 commits
  (merged to 'next' on 2025-09-22 at c811e8c172)
 + t/unit-tests: update to 10e96bc
  (merged to 'next' on 2025-09-15 at 73402f7652)
 + t/unit-tests: update clar to fcbed04

 Import a newer version of the clar unit testing framework.

 Will merge to 'master'.
 source: <20250910-b4-pks-clar-update-v1-1-26a196237e0a@pks.im>
 source: <20250922-pks-clar-update-v1-1-9154e7d1b7a1@pks.im>


* ps/config-get-color-fixes (2025-09-22) 5 commits
  (merged to 'next' on 2025-09-25 at 7b69f57ef6)
 + builtin/config: do not spawn pager when printing color codes
 + builtin/config: special-case retrieving colors without a key
 + builtin/config: do not die in `get_color()`
 + t1300: small style fixups
 + t1300: write test expectations in the test's body

 The use of "git config get" command to learn how ANSI color
 sequence is for a particular type, e.g., "git config get
 --type=color --default=reset no.such.thing", isn't very ergonomic.

 Will merge to 'master'.
 source: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>


* ps/meson-build-docs (2025-09-11) 3 commits
  (merged to 'next' on 2025-09-25 at d531b1afdc)
 + ci: don't compile whole project when testing docs with Meson
 + meson: print docs backend as part of the summary
 + meson: introduce a "docs" alias to compile documentation only

 The build procedure based on meson learned a target to only build
 documentation, similar to "make doc".

 Will merge to 'master'.
 source: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>


* ps/odb-clean-stale-wrappers (2025-09-10) 1 commit
 - odb: drop deprecated wrapper functions

 Code clean-up.

 Will merge to 'next'.
 source: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>


* jt/odb-transaction (2025-09-16) 7 commits
  (merged to 'next' on 2025-09-25 at 1a5c704fb9)
 + odb: add transaction interface
 + object-file: update naming from bulk-checkin
 + object-file: relocate ODB transaction code
 + bulk-checkin: drop flush_odb_transaction()
 + builtin/update-index: end ODB transaction when --verbose is specified
 + bulk-checkin: remove ODB transaction nesting
 + Merge branch 'jt/de-global-bulk-checkin' into jt/odb-transaction

 Continue the work to build on the bulk-checkin infrastructure to
 create many objects at once in a transaction and abstract it into
 the generic object layer.

 Will merge to 'master'.
 source: <20250916182938.2193476-1-jltobler@gmail.com>


* cc/fast-import-strip-signed-commits (2025-09-17) 2 commits
  (merged to 'next' on 2025-09-25 at 6c9a275f43)
 + fast-import: add '--signed-commits=<mode>' option
 + gpg-interface: refactor 'enum sign_mode' parsing

 "git fast-import" learned that "--signed-commits=<how>" option that
 corresponds to that of "git fast-export".

 Will merge to 'master'.
 source: <20250917181427.3193500-1-christian.couder@gmail.com>


* pw/3.0-default-initial-branch-to-main (2025-09-10) 4 commits
  (merged to 'next' on 2025-09-22 at 01bbebdab6)
 + t0613: stop setting default initial branch
 + t9902: switch default branch name to main
 + t4013: switch default branch name to main
 + breaking-changes: switch default branch to main
 (this branch is used by jc/3.0-default-initial-branch-to-main-addendum.)

 Declare that "git init" that is not otherwise configured uses
 'main' as the initial branch, not 'master', starting Git 3.0.

 Will merge to 'master'.
 source: <cover.1757518141.git.phillip.wood@dunelm.org.uk>


* ps/commit-graph-per-object-source (2025-09-04) 6 commits
 - odb: move commit-graph into the object sources
 - commit-graph: pass graphs that are to be merged as parameter
 - commit-graph: return commit graph from `repo_find_commit_pos_in_graph()`
 - commit-graph: return the prepared commit graph from `prepare_commit_graph()`
 - revision: drop explicit check for commit graph
 - blame: drop explicit check for commit graph

 Declare commit-graph is per object_source, which may not be a good idea.

 Comments?
 cf. <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 source: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>


* ps/rust-balloon (2025-09-24) 9 commits
 - ci: enable Rust for breaking-changes jobs
 - ci: convert "pedantic" job into full build with breaking changes
 - BreakingChanges: announce Rust becoming mandatory
 - varint: reimplement as test balloon for Rust
 - varint: use explicit width for integers
 - help: report on whether or not Rust is enabled
 - Makefile: introduce infrastructure to build internal Rust library
 - Makefile: reorder sources after includes
 - meson: add infrastructure to build internal Rust library

 Dip our toes a bit to (optionally) use Rust implemented helper
 called from our C code.

 Comments?
 source: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>


* ms/refs-optimize (2025-09-19) 9 commits
  (merged to 'next' on 2025-09-25 at 5fd0825882)
 + t: add test for git refs optimize subcommand
 + t0601: refactor tests to be shareable
 + builtin/refs: add optimize subcommand
 + doc: pack-refs: factor out common options
 + builtin/pack-refs: factor out core logic into a shared library
 + builtin/pack-refs: convert to use the generic refs_optimize() API
 + reftable-backend: implement 'optimize' action
 + files-backend: implement 'optimize' action
 + refs: add a generic 'optimize' API

 "git refs optimize" is added for not very well explained reason
 despite it does the same thing as "git pack-refs"...

 Will merge to 'master'.
 source: <20250919082647.535213-1-meetsoni3017@gmail.com>


* sj/string-list (2025-09-17) 4 commits
 - refs: enable sign compare warnings check
 - string-list: change "string_list_find_insert_index" return type to "size_t"
 - string-list: replace negative index encoding with "exact_match" parameter
 - string-list: use bool instead of int for "exact_match"

 The "string-list" API function to find where a given string would
 be inserted got updated so that it can use unrealistically huge
 array index that would only fit in size_t but not int or ssize_t
 to achieve unstated goal.

 Expecting a reroll.
 cf. <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
 source: <aMp8yNFiXDyk2hP4@ArchLinux>


* ps/packfile-store (2025-09-23) 16 commits
 - packfile: refactor `get_packed_git_mru()` to work on packfile store
 - packfile: refactor `get_all_packs()` to work on packfile store
 - packfile: refactor `get_packed_git()` to work on packfile store
 - packfile: move `get_multi_pack_index()` into "midx.c"
 - packfile: introduce function to load and add packfiles
 - packfile: refactor `install_packed_git()` to work on packfile store
 - packfile: split up responsibilities of `reprepare_packed_git()`
 - packfile: refactor `prepare_packed_git()` to work on packfile store
 - packfile: reorder functions to avoid function declaration
 - odb: move kept cache into `struct packfile_store`
 - odb: move MRU list of packfiles into `struct packfile_store`
 - odb: move packfile map into `struct packfile_store`
 - odb: move initialization bit into `struct packfile_store`
 - odb: move list of packfiles into `struct packfile_store`
 - packfile: introduce a new `struct packfile_store`
 - Merge branch 'ps/object-store-midx-dedup-info' into ps/packfile-store

 Code clean-up around the in-core list of all the pack files and
 object database(s).

 Will merge to 'next'.
 source: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>


* kn/refs-files-case-insensitive (2025-09-17) 4 commits
  (merged to 'next' on 2025-09-23 at 51c2a665f0)
 + refs/files: handle D/F conflicts during locking
 + refs/files: handle F/D conflicts in case-insensitive FS
 + refs/files: use correct error type when lock exists
 + refs/files: catch conflicts on case-insensitive file-systems

 Deal more gracefully with directory / file conflicts when the files
 backend is used for ref storage, by failing only the ones that are
 involved in the conflict while allowing others.

 Will merge to 'master'.
 source: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>


* en/rust-xdiff (2025-09-07) 8 commits
 . xdiff: change the types of dstart, dend, rchg, and rindex in xdfile_t
 . xdiff: make xdfile_t.nreff a usize instead of long
 . xdiff: make xdfile_t.nrec a usize instead of long
 . xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
 . xdiff: make xrecord_t.size a usize instead of long
 . xdiff: make xrecord_t.ptr a u8 instead of char
 . xdiff: include compat/rust_types.h
 . compat/rust_types.h: define rust primitive types
 . Merge branch 'en/xdiff-cleanup' into en/rust-xdiff

 Use Rust-friendly types in xdiff code.

 Expecting a reroll based on the updated base topic, but the base
 topic may further be updated first?
 cf. <CAH=ZcbA5hAM9kmO410KzVW7RXWWiwX2oJk6GGPP+6oVYatRVOw@mail.gmail.com>
 source: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>


* je/doc-checkout (2025-09-10) 7 commits
  (merged to 'next' on 2025-09-23 at b776ac7a24)
 + doc: git-checkout: clarify restoring files section
 + doc: git-checkout: split up restoring files section
 + doc: git-checkout: deduplicate --detach explanation
 + doc: git-checkout: clarify `-b` and `-B`
 + doc: git-checkout: clarify `git checkout <branch>`
 + doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
 + doc: git-checkout: clarify intro sentence

 Doc updates.

 Will merge to 'master'.
 cf. <236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
 source: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>


* kh/you-still-use-whatchanged-fix (2025-09-17) 9 commits
  (merged to 'next' on 2025-09-25 at de9c8c526c)
 + BreakingChanges: remove claim about whatchanged reports
 + whatchanged: remove not-even-shorter clause
 + whatchanged: hint about git-log(1) and aliasing
 + you-still-use-that??: help the user help themselves
 + t0014: test shadowing of aliases for a sample of builtins
 + git: allow alias-shadowing deprecated builtins
 + git: move seen-alias bookkeeping into handle_alias(...)
 + git: add `deprecated` category to --list-cmds
 + Makefile: don’t add whatchanged after it has been removed

 Update "do you still use it?" message given by a command that is
 deeply deprecated and allow us to suggest alternatives.

 Will merge to 'master'.
 source: <cover.1758139856.short.code@khaugsbakk.name>


* ds/sparse-checkout-clean (2025-09-12) 7 commits
  (merged to 'next' on 2025-09-25 at 00b296f153)
 + t: expand tests around sparse merges and clean
 + sparse-index: point users to new 'clean' action
 + sparse-checkout: add --verbose option to 'clean'
 + dir: add generic "walk all files" helper
 + sparse-checkout: match some 'clean' behavior
 + sparse-checkout: add basics of 'clean' command
 + sparse-checkout: remove use of the_repository

 "git sparse-checkout" subcommand learned a new "clean" action to
 prune otherwise unused working-tree files that are outside the
 areas of interest.

 Will merge to 'master'.
 source: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
