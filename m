Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A538B
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728692084; cv=none; b=oM13MygzkJF8Bpqn6KYtOziEB+0NveqhlicpYhToOa87gwjiTXEUeWmXeKA8Gc7b9QywOKCCg41U80fbrrgHcLaa87CIvVThETOJngYwRFHBlDwBIZbYToVnqw9JDBd/vFnA3Pw8UIWONH1BsnBPmDpY1J212OkPpOMcZ5ZI/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728692084; c=relaxed/simple;
	bh=fXhZ32jUqVhZR865gVpwQvaaw8GDtOmxzHo2Eoo/nVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7kElkLq2RdOmlAGvNU9BhTlwv/PbCVJWs1x2RntYQFenK4EEgNQ9PBKR095EvDcTGfJtRuR6gHzvYTa/+1gJYkajiVsro2fpPfGXCox880OU8QIL97Aav/Bn2SXUwkbYyqZGh2x8/xdBRcidxAIHgnv050mVzSoKX3pOXlbfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C22XTvjY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OxYjJ+4d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C22XTvjY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OxYjJ+4d"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1422A1140228;
	Fri, 11 Oct 2024 20:14:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 20:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1728692080; x=1728778480; bh=ywXwEpA9deIjZ0wJyU9H1cO0voOTqSbX
	d8ICJBAwgAo=; b=C22XTvjYBMuWcQ8B7hXSJ7+gbJC790OWU8ZiRzV2JJgxB/9i
	yS45jiwVbIUIcFdSgxXI/4TbuGw+AEzQUF3FVklEHOnZ/R17sIcXxtLGV4fTNyxx
	zgIx1AFvXDA9BRpd48Fa7c5YK27cvf2yGUh2ZX/k5AWUkYNkIYbSU6DowG5EBMGu
	PUPC5fJ5X3zcYYymh4itfCgaBlT+FSVJQRSMXu42tfnWMHW4k1IfTgI+PD8j41VL
	NA0FpvAYzEsU3gM5fYDq0qBrE3kTIr8NLZMb8HwaenQS0TkhXxoNvOHQNIVm0DAZ
	jcrtIDVD2Sk59EsY3tgOIiBQbfuDFTrYtWGExA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728692080; x=1728778480; bh=ywXwEpA9deIjZ0wJyU9H1cO0voOTqSbXd8I
	CJBAwgAo=; b=OxYjJ+4dv+rZQqVOONw28JvAp9UlXY+P/6Ir9Mu8bkNDHL0HhXQ
	Mx6eEsPBkd4pPciWAdWKWrvohvXUuQF63qvZOrEqDpIGq+ZQqUgx0fHbfmcPiVml
	G6VzERpn11V4SgSQLpqARDNO1jAxz0KHlOLHw1whQJqIMnxFUcepV3+QLI1BHseb
	wslFh7sHL9Ghpq2WHKTQxQ3qnXATtCp5b8Iq7KBVJaGJj8SaPFaBhu8lbi1H+KZK
	sau8I7HtaXVpkE3gTexUGnVM9BcgLXr4k7HBoWs/xfMnZlp5tV4XF0uL6v3PJYrn
	G3lTh7Xz6nSnerV57JZbyDtqIMu/T7h9ifw==
X-ME-Sender: <xms:b78JZ1fEWpv-C6rD6JyWT6NkNNa_Yb4vTQK-xW0aNHukhosqTaTVbw>
    <xme:b78JZzPfNWyRHJNbLKJq6HpSYi_Tyn-4izSaFkJ97uwSE1YLF-_hQXLM7YZRk8en6
    dDIEoxtJ9c4q-04kw>
X-ME-Received: <xmr:b78JZ-gy3G01cPK8Wb-7Kzu36RSTfojdI6xJDILcmJqu6-3hKfbuQzDUOw2gSDcjGijMtyJUYYlfTaYGQzZtw6mUrMnoOguIrYqnm44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhephfduuedtve
    dvvefgheekleduteettdfhhfdtvdehiedvtdeghfdtffefgeeiffehnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpohhrrdgtiidpghhoohhglhgvshhouhhrtggvrdgtohhmpd
    hgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdhpkhhsrdhimhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifnh
    eslhifnhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b78JZ--IQf9BF7-E_XCOZObZDRSk7UxiLKbgF2G8sCp4l0SmlrtUQQ>
    <xmx:b78JZxvMhUq0ZDEgzmk2NdJRF_0rgeIqiFrj8LAz7kV903OX45mmAQ>
    <xmx:b78JZ9HFIgQbadhedEPUWkHEdhxpCzR-X-hdfRSnRQ8m2WFYwL6H5w>
    <xmx:b78JZ4OR0Q1jXVSynQDbpHTO3VnIixmUczHiqhDvnaPQdS4eCbdfEQ>
    <xmx:cL8JZ5K0NW2qrHoHVMbtaau2eoPF-w0qFE-ZFgXyewEBVfZEoeCHAkSv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 20:14:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #07; Fri, 11)
X-master-at: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
X-next-at: 07ac214952ed4a8d73389044a5d428bf90feeb11
Date: Fri, 11 Oct 2024 17:14:38 -0700
Message-ID: <xmqqset29nyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Git 2.47 (final) has been tagged, the 'maint' branch now points
at v2.47.0, the first batch of topics for 2.48 are now in 'master',
and 'next' has been rewound, directly on top of 2.47.

I'll be offline for a few weeks til the end of the month.  In the
meantime, have fun with yourselves and play nicely with each other
;-).

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
[New Topics]

* bc/drop-ancient-libcurl-and-perl (2024-10-11) 13 commits
 - gitweb: make use of s///r
 - INSTALL: require Perl 5.26.0
 - Require Perl 5.26.0
 - INSTALL: document requirement for libcurl 7.61.0
 - git-curl-compat: remove check for curl 7.56.0
 - git-curl-compat: remove check for curl 7.53.0
 - git-curl-compat: remove check for curl 7.52.0
 - git-curl-compat: remove check for curl 7.44.0
 - git-curl-compat: remove check for curl 7.43.0
 - git-curl-compat: remove check for curl 7.39.0
 - git-curl-compat: remove check for curl 7.34.0
 - git-curl-compat: remove check for curl 7.25.0
 - git-curl-compat: remove check for curl 7.21.5

 Drop support for older libcURL and Perl.

 Under discussion.
 source: <20241010235621.738239-1-sandals@crustytoothpaste.net>


* co/t6050-pipefix (2024-10-11) 1 commit
 - t6050: do not lose exit status of Git to pipes

 Avoid losing exit status by having Git command being tested on the
 upstream side of a pipe.

 Needs review.
 There is at least one known broken conversion.
 cf. <CAPig+cRLdzAEA-G=L81yR9dmm8Y-5VEU7ybyohKmbq9=0bDUaQ@mail.gmail.com>
 source: <20241011154555.584917-1-chizobajames21@gmail.com>


* es/oss-fuzz (2024-10-11) 3 commits
 - fuzz: port fuzz-url-decode-mem from OSS-Fuzz
 - fuzz: port fuzz-parse-attr-line from OSS-Fuzz
 - fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz

 Backport oss-fuzz tests for us to our codebase.

 Needs review.
 source: <cover.1728594659.git.steadmon@google.com>


* tb/cross-pack-delta-reuse (2024-10-11) 11 commits
 . pack-bitmap: enable reusing deltas with base objects in 'haves' bitmap
 . pack-bitmap.c: record whether the result was filtered
 . pack-bitmap: enable cross-pack delta reuse
 . t5332: enable OFS_DELTAs via test_pack_objects_reused
 . write_reused_pack_one(): translate bit positions directly
 . pack-bitmap: drop `from_midx` field from `bitmapped_pack`
 . pack-bitmap.c: extract `find_base_bitmap_pos()`
 . pack-bitmap.c: compare `base_offset` to `delta_obj_offset`
 . pack-bitmap.c: delay calling 'offset_to_pack_pos()'
 . pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
 . pack-bitmap.c: do not pass `pack_pos` to `try_partial_reuse()`

 Allow pack-objects to reuse an existing delta in a packfile, when
 it ends up sending the base object from a different packfile.

 It seems to break the tests when merged to 'seen'.
 source: <cover.1728505840.git.me@ttaylorr.com>


* bf/t-readme-mention-reftable (2024-10-11) 1 commit
 - t/README: add missing value for GIT_TEST_DEFAULT_REF_FORMAT

 Doc update.

 Will merge to 'next'.
 source: <20241011191150.825255-1-bence@ferdinandy.com>

--------------------------------------------------
[Cooking]

* aa/t7300-modernize (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at e3a8d7f6c4)
 + t7300-clean.sh: use test_path_* helper functions for error logging

 Test modernization.

 Will merge to 'master'.
 source: <pull.1811.v4.git.1728498122419.gitgitgadget@gmail.com>


* bf/set-head-symref (2024-10-10) 6 commits
 - fetch: set remote/HEAD if it does not exist
 - refs_update_symref: add create_only option
 - transaction: add TRANSACTION_CREATE_EXISTS error
 - set-head: better output for --auto
 - set-head: add new variable for readability
 - refs_update_symref: atomically record overwritten ref

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Expecting a reroll.
 Needs to shed files backend dependency a bit more.
 cf. <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
 source: <20241010133022.1733542-1-bence@ferdinandy.com>


* db/submodule-fetch-with-remote-name-fix (2024-10-09) 1 commit
 - submodule: correct remote name with fetch

 A "git fetch" from the superproject going down to a submodule used
 a wrong remote when the default remote names are set differently
 between them.

 Will merge to 'next'?
 source: <20241009033257.1316690-1-daniel@mariadb.org>


* jc/doc-refspec-syntax (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at 912ed5fae8)
 + doc: clarify <src> in refspec syntax

 Doc updates.

 Will merge to 'master'.
 source: <xmqqy137wtyz.fsf@gitster.g>


* kh/checkout-ignore-other-docfix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at ed66b60f52)
 + checkout: refer to other-worktree branch, not ref

 Doc updates.

 Will merge to 'master'.
 source: <fcfbcd3868bda75dd0463e04739047e74d239d32.1728585467.git.code@khaugsbakk.name>


* kn/loose-object-layer-wo-global-hash (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at 99252fb6cc)
 + loose: don't rely on repository global state

 Code clean-up.

 Will merge to 'master'.
 source: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>


* ng/rebase-merges-branch-name-as-label (2024-10-09) 3 commits
  (merged to 'next' on 2024-10-11 at a5785fd206)
 + rebase-merges: try and use branch names as labels
 + rebase-update-refs: extract load_branch_decorations
 + load_branch_decorations: fix memory leak with non-static filters

 "git rebase --rebase-merges" now uses branch names as labels when
 able.

 Will merge to 'master'.
 source: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>


* ps/build (2024-10-09) 24 commits
 . Introduce support for the Meson build system
 . Documentation: add comparison of build systems
 . t: allow overriding build dir
 . t: better support for out-of-tree builds
 . Makefile: simplify building of templates
 . Makefile: allow "bin-wrappers/" directory to exist
 . Makefile: consistently use PERL_PATH
 . Makefile: consistently use @PLACEHOLDER@ to substitute
 . Makefile: use common template for GIT-BUILD-OPTIONS
 . Makefile: refactor generators to be PWD-independent
 . Makefile: refactor GIT-VERSION-GEN to be reusable
 . Makefile: extract script to massage Perl scripts
 . Makefile: extract script to generate clar declarations
 . http: fix build error on FreeBSD
 . builtin/credential-cache: fix missing parameter for stub function
 . t/unit-tests: update clar unit test framework
 . t7300: work around platform-specific behaviour with long paths on MinGW
 . t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 . t3404: work around platform-specific behaviour on macOS 10.15
 . t1401: make invocation of tar(1) work with Win32-provided one
 . t/lib-gpg: fix setup of GNUPGHOME in MinGW
 . t/lib-gitweb: test against the build version of gitweb
 . t/test-lib: wire up NO_ICONV prerequisite
 . t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE

 Build procedure update plus introduction of Mason based builds

 Needs review.
 Tentatively dropped from 'seen', for a circular dependency.
 cf. https://github.com/git/git/actions/runs/11299216196
 source: <cover.1728485139.git.ps@pks.im>


* ps/ci-gitlab-windows (2024-10-09) 5 commits
 - gitlab-ci: exercise Git on Windows
 - gitlab-ci: introduce stages and dependencies
 - ci: handle Windows-based CI jobs in GitLab CI
 - ci: create script to set up Git for Windows SDK
 - t7300: work around platform-specific behaviour with long paths on MinGW

 Enable Windows-based CI in GitLab.

 WIll merge to 'next'.
 source: <cover.1728480039.git.ps@pks.im>


* ak/typofixes (2024-10-10) 6 commits
 - t: fix typos
 - t/helper: fix a typo
 - t/perf: fix typos
 - t/unit-tests: fix typos
 - contrib: fix typos
 - compat: fix typos

 Typofixes.

 Will merge to 'next'?
 git-gui part was ejected--it should be routed via git-gui maintainer
 source: <20241010151223.311719-1-algonell@gmail.com>


* tc/bundle-uri-leakfix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at 07ac214952)
 + bundle-uri: plug leak in unbundle_from_file()

 Leakfix.

 Will merge to 'master'.
 source: <20241010091249.1895960-1-toon@iotcl.com>


* xx/protocol-v2-doc-markup-fix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at 37932adca4)
 + Documentation/gitprotocol-v2.txt: fix a slight inconsistency in format

 Docfix.

 Will merge to 'master'.
 source: <pull.1807.git.git.1728566443089.gitgitgadget@gmail.com>


* cw/worktree-relative (2024-10-08) 4 commits
 - worktree: add test for path handling in linked worktrees
 - worktree: link worktrees with relative paths
 - worktree: refactor infer_backlink() to use *strbuf
 - Merge branch 'es/worktree-repair-copied' into cw/worktrees-relative
 (this branch uses es/worktree-repair-copied.)

 An extra worktree attached to a repository points at each other to
 allow finding the repository from the worktree and vice versa
 possible.  Turn this linkage to relative paths.

 Will merge to 'next'?
 source: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>


* ds/path-walk (2024-10-08) 17 commits
 - pack-objects: thread the path-based compression
 - pack-objects: refactor path-walk delta phase
 - scalar: enable path-walk during push via config
 - pack-objects: enable --path-walk via config
 - repack: update usage to match docs
 - repack: add --path-walk option
 - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
 - p5313: add performance tests for --path-walk
 - pack-objects: update usage to match docs
 - pack-objects: add --path-walk option
 - pack-objects: extract should_attempt_deltas()
 - path-walk: add prune_all_uninteresting option
 - revision: create mark_trees_uninteresting_dense()
 - path-walk: allow visiting tags
 - path-walk: allow consumer to specify object types
 - t6601: add helper for testing path-walk API
 - path-walk: introduce an object walk by path

 A new algorithm for object graph traversal to favor visiting the
 objects at the same tree path in succession (as opposed to visiting
 objects that are different between trees as we walk commit
 histories) is introduced to optimize object packing.

 Needs review.
 source: <pull.1813.git.1728396723.gitgitgadget@gmail.com>


* hy/partial-repack-fix (2024-10-08) 3 commits
 . partial-clone: update doc
 . t0410: adapt tests to repack changes
 . repack: pack everything into packfile

 "git repack" avoids losing local objects that are reachable from
 objects in a packfile fetched from a promisor remote.

 Expecting a reroll.
 cf. <xmqqa5faec4x.fsf@gitster.g>
 Breaks CI.
 cf. <xmqqzfnexlku.fsf@gitster.g>
 source: <20241008081350.8950-1-hanyang.tony@bytedance.com>


* jh/config-unset-doc-fix (2024-10-08) 1 commit
  (merged to 'next' on 2024-10-10 at a87ffb09b6)
 + git-config.1: remove value from positional args in unset usage

 Docfix.

 Will merge to 'master'.
 source: <20241008142920.570244-2-joshiheinrichs@gmail.com>


* jk/fsmonitor-event-listener-race-fix (2024-10-08) 2 commits
  (merged to 'next' on 2024-10-10 at 0c40f5c971)
 + fsmonitor: initialize fs event listener before accepting clients
 + simple-ipc: split async server initialization and running

 On macOS, fsmonitor can fall into a race condition that results in
 a client waiting forever to be notified for an event that have
 already happened.  This problem has been corrected.

 Will merge to 'master'.
 source: <20241008083121.GA676391@coredump.intra.peff.net>


* js/doc-platform-support-link-fix (2024-10-07) 1 commit
  (merged to 'next' on 2024-10-10 at 55316158e7)
 + docs: fix the `maintain-git` links in `technical/platform-support`

 Docfix.

 Will merge to 'master'.
 source: <pull.1812.git.1728337764963.gitgitgadget@gmail.com>


* kh/merge-tree-doc (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at b22c213d6c)
 + doc: merge-tree: improve example script

 Docfix.

 Will merge to 'master'.
 cf. <CABPp-BE=JfoZp19Va-1oF60ADBUibGDwDkFX-Zytx7A3uJ__gg@mail.gmail.com>
 source: <c7e0d76e71eef56c6279e0f7e82a2d194f78d2a4.1728492617.git.code@khaugsbakk.name>


* pb/clar-build-fix (2024-10-11) 1 commit
 - Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o

 Build fix.

 Will merge to 'next'.
 source: <pull.1810.v2.git.1728667787227.gitgitgadget@gmail.com>


* ps/cache-tree-w-broken-index-entry (2024-10-07) 3 commits
 - unpack-trees: detect mismatching number of cache-tree/index entries
 - cache-tree: detect mismatching number of index entries
 - cache-tree: refactor verification to return error codes

 Fail gracefully instead of crashing when attempting to write the
 contents of a corrupt in-core index as a tree object.

 Will merge to 'next'?
 source: <cover.1728275640.git.ps@pks.im>


* ps/maintenance-start-crash-fix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at c54df41815)
 + builtin/gc: fix crash when running `git maintenance start`

 "git maintenance start" crashed due to an uninitialized variable
 reference, which has been corrected.

 Will merge to 'master'.
 source: <a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im>


* ua/t3404-cleanup (2024-10-07) 2 commits
 - t3404: employing test_line_count() to replace test
 - t3404: avoid losing exit status with focus on `git show` and `git cat-file`

 Test update.

 Will merge to 'next'?
 source: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>


* xx/remote-server-option-config (2024-10-08) 5 commits
  (merged to 'next' on 2024-10-10 at 0e38c7f8c5)
 + ls-remote: leakfix for not clearing server_options
 + fetch: respect --server-option when fetching multiple remotes
 + transport.c::handshake: make use of server options from remote
 + remote: introduce remote.<name>.serverOption configuration
 + transport: introduce parse_transport_option() method

 A new configuration variable remote.<name>.serverOption makes the
 transport layer act as if the --serverOption=<value> option is
 given from the command line.

 Will merge to 'master'.
 source: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>


* jc/a-commands-without-the-repo (2024-10-11) 3 commits
 - archive: remove the_repository global variable
 - annotate: remove usage of the_repository global
 - git: pass in repo to builtin based on setup_git_directory_gently

 Commands that can also work outside Git have learned to take the
 repository instance "repo" when we know we are in a repository, and
 NULL when we are not, in a parameter.  The uses of the_repository
 variable in a few of them have been removed using the new calling
 convention.

 Will merge to 'next'?
 source: <pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>


* ej/cat-file-remote-object-info (2024-09-27) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Needs review.
 source: <20240926013856.35527-1-eric.peijian@gmail.com>


* es/worktree-repair-copied (2024-09-23) 1 commit
 - worktree: repair copied repository and linked worktrees
 (this branch is used by cw/worktree-relative.)

 The heuristics in "git worktree repair" can be confused when a
 worktree and its repository are copied and break correctly
 configured worktree and repository that point at each other, which
 has been corrected.

 Needs review.
 source: <20240923075416.54289-1-ericsunshine@charter.net>


* cw/fix-reachable-in-repo-with-promisor (2024-09-19) 2 commits
 - fetch-pack.c: do not declare local commits as "have" in partial repos
 - packfile: split promisor objects oidset into two

 "git gc" in a partial clone (i.e. lacking objects that can be
 lazily fetched from promisor remotes) collected more than objects
 that promisor-remote can give.

 Needs review.
 source: <20240802073143.56731-1-hanyang.tony@bytedance.com>


* jc/breaking-changes-early-adopter-option (2024-10-11) 1 commit
 - BreakingChanges: early adopter option

 Describe the policy to introduce breaking changes.

 Needs review.
 source: <xmqq1q0mcnt8.fsf@gitster.g>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 On hold.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?  I got an impression that this is premature without
 finishing the discussion on a larger picture.
 cf. <ZvpZv_fed_su4w2-@pks.im>
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* sj/ref-contents-check (2024-09-30) 9 commits
 - ref: add symlink ref content check for files backend
 - t0602: add ref content checks for worktrees
 - ref: enhance escape situation for worktrees
 - ref: add escape check for the referent of symref
 - ref: add basic symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - builtin/refs: support multiple worktrees check for refs.
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 cf. <xmqqikud6kc0.fsf@gitster.g>
 source: <Zvj-DgHqtC30KjJe@ArchLinux>


* tb/incremental-midx-part-2 (2024-10-04) 17 commits
 - fixup! pack-bitmap.c: open and store incremental bitmap layers
 - fixup! midx: implement writing incremental MIDX bitmaps
 - midx: implement writing incremental MIDX bitmaps
 - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 - pack-bitmap.c: keep track of each layer's type bitmaps
 - ewah: implement `struct ewah_or_iterator`
 - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 - pack-bitmap.c: compute disk-usage with incremental MIDXs
 - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 - pack-bitmap.c: open and store incremental bitmap layers
 - pack-revindex: prepare for incremental MIDX bitmaps
 - Documentation: describe incremental MIDX bitmaps
 - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>
 source: <ZwBsbW5jsFw0mxKk@nand.local>


* js/libgit-rust (2024-10-08) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Needs review.
 source: <cover.1728429158.git.steadmon@google.com>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ew/cat-file-optim (2024-08-25) 10 commits
 - cat-file: use writev(2) if available
 - cat-file: batch_write: use size_t for length
 - cat-file: batch-command uses content_limit
 - object_info: content_limit only applies to blobs
 - packfile: packed_object_info avoids packed_to_object_type
 - cat-file: use delta_base_cache entries directly
 - packfile: inline cache_or_unpack_entry
 - packfile: fix off-by-one in content_limit comparison
 - packfile: allow content-limit for cat-file
 - packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Waiting for review responses.
 source: <20240823224630.1180772-1-e@80x24.org>
