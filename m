Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CA1A704B
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604345; cv=none; b=jV+bANipLAaPvd/qVCLVcFE3K8Q4YYw78ZDatsFIceyiZa7LscLFbm5ThvFe509ppYC8VsLL2/dtma9hSEG4WIywMyVu+pGoO6n0pOyKU2J6nD3yjfVmCesolRiwhXoCdxiHVVpeen5ovEmUBDmVfcpjQDATAQvGfqrkkm0lyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604345; c=relaxed/simple;
	bh=OYyR0SrbD0rBTOPXpctJwr+7JauiiQVrkFr9FFwXtQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dp2e0NSYyOkrOGq40vezMTHDkH33njSxaOz+J111EMBZ9479fFghuZ/Xw+5Xxn45PHkBEVHSEJUMgMvL2oYv7B4v5XfygT43injEGOmZNxg9tLRF360+f8PBBXC8r/GIras17tkCffFLWjVOLPdDpMm+L76BZ1NFP8Ie70oE5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UKElGO0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRaYNdPT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UKElGO0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRaYNdPT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4DF311401B8;
	Thu, 10 Oct 2024 19:52:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 19:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1728604341; x=1728690741; bh=fMs2AYK1nQ7XuHabHLO5rfwPSuFNu/kc
	k9VEK44qvPE=; b=UKElGO0nxRKmTTIpLmfjlVOeqDERPPoJac0RDlgYukwXhZkP
	wCpApoqKDKrUti0l4VAlJvCN+W4AJaF7wtif1HHj24xne0adDIW1+a6NApwcygFw
	N5UHrkQr/6oP+yf0RV/JqRVZKBMsgFjc5iyazJPLSg6j5/+RI0+NuUpiwNhIB2Jd
	tLVSJ44V0lmNwaDaEl3a5pBhOzLBC0Bd4rjYOuidFuFrr2jw6JK5jucZjMKnW2Of
	bZEw8r3XBAQsCdOrWGZgNKI/ZB2Fia/TvlTOFti20ihqHSuWg9fGQefZozzl/ptq
	QTYn+cF0UAri3ect6kviCNuTx8jxRZ8EK5c3ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728604341; x=1728690741; bh=fMs2AYK1nQ7XuHabHLO5rfwPSuFNu/kck9V
	EK44qvPE=; b=aRaYNdPT52UHYPen1YGfVR2lkRoqDj074bGBmOicJmLGV9CRbmr
	8PaHdv0N4c+/pM1z2msVKXnycCxm1odR28Vo7bob3CuQGeIep0M+GRSm0Cyng9ml
	E3kpng+mxybmK8QECxWFS1g7RPsufHoMpKsK6us3NrZTI8i6mbtpG66QM/4wzDsO
	PO6m730+xCmz9it2hqGE1PZtMSI6EefjFojRjS319qJf0h2WySBJVx4ktdXN+C0A
	rThTM0GLxt+lqEfG7pdBurnVi/EAQTpD/QjNDT/EMk/52EUt1FCLrvvI7e7ckV5R
	p37pEjlIjpD3/BeZ/ha8eGBOLognHgB1FDA==
X-ME-Sender: <xms:tWgIZyAqYt7Eo_IH305_qA-z4SHaASK7kxOaGeg7uAz4XACu4izo7A>
    <xme:tWgIZ8jLGr_JOPA826leUaaYvMoWouI_-5ottK3FK7c9s1pDIlOBvbSgPpCQED2lG
    YCaEp7cwvhuXV9KCw>
X-ME-Received: <xmr:tWgIZ1nMPrXRRRwaDu9dTz-wTS3P5qeGgY_zGCCZDEGlfyPINvj0z0ICAw9MGhtOAzID79sF9FxeYNlBYFrVHZUO7Y65jf6PBsbTRyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgvdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:tWgIZwxkRGyZ4fS4NmNvbq0BEmeQIbJ8yNQvOD1HeOQLEGORCIeE1w>
    <xmx:tWgIZ3QlVWoiYQ6USQZeRHYfiyypC7JCF_AoWb6Jvge9jIT8PCRS6w>
    <xmx:tWgIZ7bGvWX-GjbF2qFTdp75F7iPAAD7VzjEdZnk70uGkor70nrPhg>
    <xmx:tWgIZwSxukjcMOkVsMjEqlMb1Yqmnfh-pbvB2jlNLGi9VRu0VWKZ6A>
    <xmx:tWgIZxcN2KMqbCiqdy_3jezD7N-P6ivvuA0zjquaUxpJorLxDB4rC4Sa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 19:52:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #06; Thu, 10)
X-master-at: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
X-next-at: 0c40f5c971f3310010a64ee1c93f32448bf6ba73
Date: Thu, 10 Oct 2024 16:52:19 -0700
Message-ID: <xmqqfrp3iki4.fsf@gitster.g>
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

* ds/line-log-asan-fix (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at ee702f6c95)
 + line-log: protect inner strbuf from free
 (this branch is used by jk/output-prefix-cleanup.)

 Use after free and double freeing at the end in "git log -L... -p"
 had been identified and fixed.
 source: <05c21616c350b5141c17fde1aa5d3aea881c6031.1727956724.git.gitgitgadget@gmail.com>


* ja/doc-synopsis-markup (2024-09-24) 3 commits
  (merged to 'next' on 2024-09-30 at 15ec13edec)
 + doc: apply synopsis simplification on git-clone and git-init
 + doc: update the guidelines to reflect the current formatting rules
 + doc: introduce a synopsis typesetting

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.
 source: <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>


* jk/output-prefix-cleanup (2024-10-03) 5 commits
  (merged to 'next' on 2024-10-04 at 06298d1525)
 + diff: store graph prefix buf in git_graph struct
 + diff: return line_prefix directly when possible
 + diff: return const char from output_prefix callback
 + diff: drop line_prefix_length field
 + line-log: use diff_line_prefix() instead of custom helper
 (this branch uses ds/line-log-asan-fix.)

 Code clean-up.
 source: <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>


* ps/leakfixes-part-8 (2024-09-30) 25 commits
  (merged to 'next' on 2024-10-04 at 3cfb5747d2)
 + builtin/send-pack: fix leaking list of push options
 + remote: fix leaking push reports
 + t/helper: fix leaks in proc-receive helper
 + pack-write: fix return parameter of `write_rev_file_order()`
 + revision: fix leaking saved parents
 + revision: fix memory leaks when rewriting parents
 + midx-write: fix leaking buffer
 + pack-bitmap-write: fix leaking OID array
 + pseudo-merge: fix leaking strmap keys
 + pseudo-merge: fix various memory leaks
 + line-log: fix several memory leaks
 + diff: improve lifecycle management of diff queues
 + builtin/revert: fix leaking `gpg_sign` and `strategy` config
 + t/helper: fix leaking repository in partial-clone helper
 + builtin/clone: fix leaking repo state when cloning with bundle URIs
 + builtin/pack-redundant: fix various memory leaks
 + builtin/stash: fix leaking `pathspec_from_file`
 + submodule: fix leaking submodule entry list
 + wt-status: fix leaking buffer with sparse directories
 + shell: fix leaking strings
 + scalar: fix leaking repositories
 + read-cache: fix leaking hash context in `do_write_index()`
 + builtin/annotate: fix leaking args vector
 + Merge branch 'jk/http-leakfixes' into ps/leakfixes-part-8
 + Merge branch 'ps/leakfixes-part-7' into ps/leakfixes-part-8

 More leakfixes.
 source: <cover.1727687410.git.ps@pks.im>


* ps/reftable-alloc-failures (2024-10-04) 28 commits
  (merged to 'next' on 2024-10-04 at 5649ef3dd7)
 + reftable/basics: fix segfault when growing `names` array fails
  (merged to 'next' on 2024-10-02 at a6d42d51d4)
 + reftable/basics: ban standard allocator functions
 + reftable: introduce `REFTABLE_FREE_AND_NULL()`
 + reftable: fix calls to free(3P)
 + reftable: handle trivial allocation failures
 + reftable/tree: handle allocation failures
 + reftable/pq: handle allocation failures when adding entries
 + reftable/block: handle allocation failures
 + reftable/blocksource: handle allocation failures
 + reftable/iter: handle allocation failures when creating indexed table iter
 + reftable/stack: handle allocation failures in auto compaction
 + reftable/stack: handle allocation failures in `stack_compact_range()`
 + reftable/stack: handle allocation failures in `reftable_new_stack()`
 + reftable/stack: handle allocation failures on reload
 + reftable/reader: handle allocation failures in `reader_init_iter()`
 + reftable/reader: handle allocation failures for unindexed reader
 + reftable/merged: handle allocation failures in `merged_table_init_iter()`
 + reftable/writer: handle allocation failures in `reftable_new_writer()`
 + reftable/writer: handle allocation failures in `writer_index_hash()`
 + reftable/record: handle allocation failures when decoding records
 + reftable/record: handle allocation failures on copy
 + reftable/basics: handle allocation failures in `parse_names()`
 + reftable/basics: handle allocation failures in `reftable_calloc()`
 + reftable: introduce `reftable_strdup()`
 + reftable/basics: merge "publicbasics" into "basics"
 + reftable/error: introduce out-of-memory error code
 + Merge branch 'ps/reftable-exclude' into ps/reftable-alloc-failures
 + Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-alloc-failures

 The reftable library is now prepared to expect that the memory
 allocation function given to it may fail to allocate and to deal
 with such an error.
 source: <CAPig+cT7nni11bGmNyYCQZ0P0QZ_HG-izPtsymq==sUOkOn-Lw@mail.gmail.com>
 source: <cover.1727866394.git.ps@pks.im>


* sk/doc-maintenance-schedule (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at 2d3722c29d)
 + doc: add a note about staggering of maintenance

 Doc update to clarify how periodical maintenance are scheduled,
 spread across time to avoid thundering hurds.
 source: <pull.1794.git.git.1727945877922.gitgitgadget@gmail.com>


* tb/notes-amlog-doc (2024-10-03) 1 commit
  (merged to 'next' on 2024-10-04 at e73c8753e8)
 + Documentation: mention the amlog in howto/maintain-git.txt

 Document "amlog" notes.
 source: <88a13b9f2b6e7fbed517a7e268e4e371d84a9a10.1727917792.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* aa/t7300-modernize (2024-10-09) 1 commit
 - t7300-clean.sh: use test_path_* helper functions for error logging

 Test modernization.

 Will merge to 'next'.
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

 Comments?
 source: <20241010133022.1733542-1-bence@ferdinandy.com>


* db/submodule-fetch-with-remote-name-fix (2024-10-09) 1 commit
 - submodule: correct remote name with fetch

 A "git fetch" from the superproject going down to a submodule used
 a wrong remote when the default remote names are set differently
 between them.

 Comments?
 source: <20241009033257.1316690-1-daniel@mariadb.org>


* jc/doc-refspec-syntax (2024-10-09) 1 commit
 - doc: clarify <src> in refspec syntax

 Doc updates.

 Will merge to 'next'.
 source: <xmqqy137wtyz.fsf@gitster.g>


* kh/checkout-ignore-other-docfix (2024-10-10) 1 commit
 - checkout: refer to other-worktree branch, not ref

 Doc updates.

 Will merge to 'next'.
 source: <fcfbcd3868bda75dd0463e04739047e74d239d32.1728585467.git.code@khaugsbakk.name>


* kn/loose-object-layer-wo-global-hash (2024-10-09) 1 commit
 - loose: don't rely on repository global state

 Code clean-up.

 Will merge to 'next'.
 source: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>


* ng/rebase-merges-branch-name-as-label (2024-10-09) 3 commits
 - rebase-merges: try and use branch names as labels
 - rebase-update-refs: extract load_branch_decorations
 - load_branch_decorations: fix memory leak with non-static filters

 "git rebase --rebase-merges" now uses branch names as labels when
 able.

 Will merge to 'next'.
 source: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>


* ps/build (2024-10-09) 24 commits
 - Introduce support for the Meson build system
 - Documentation: add comparison of build systems
 - t: allow overriding build dir
 - t: better support for out-of-tree builds
 - Makefile: simplify building of templates
 - Makefile: allow "bin-wrappers/" directory to exist
 - Makefile: consistently use PERL_PATH
 - Makefile: consistently use @PLACEHOLDER@ to substitute
 - Makefile: use common template for GIT-BUILD-OPTIONS
 - Makefile: refactor generators to be PWD-independent
 - Makefile: refactor GIT-VERSION-GEN to be reusable
 - Makefile: extract script to massage Perl scripts
 - Makefile: extract script to generate clar declarations
 - http: fix build error on FreeBSD
 - builtin/credential-cache: fix missing parameter for stub function
 - t/unit-tests: update clar unit test framework
 - t7300: work around platform-specific behaviour with long paths on MinGW
 - t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 - t3404: work around platform-specific behaviour on macOS 10.15
 - t1401: make invocation of tar(1) work with Win32-provided one
 - t/lib-gpg: fix setup of GNUPGHOME in MinGW
 - t/lib-gitweb: test against the build version of gitweb
 - t/test-lib: wire up NO_ICONV prerequisite
 - t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE

 Build procedure update plus introduction of Mason based builds

 Needs review.
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

 Comments?
 source: <20241010151223.311719-1-algonell@gmail.com>


* tc/bundle-uri-leakfix (2024-10-10) 1 commit
 - bundle-uri: plug leak in unbundle_from_file()

 Leakfix.

 Will merge to 'next'.
 source: <20241010091249.1895960-1-toon@iotcl.com>


* xx/protocol-v2-doc-markup-fix (2024-10-10) 1 commit
 - Documentation/gitprotocol-v2.txt: fix a slight inconsistency in format

 Docfix.

 Will merge to 'next'.
 source: <pull.1807.git.git.1728566443089.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

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

 Comments?
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
 - doc: merge-tree: improve example script

 Docfix.

 Will merge to 'next'.
 cf. <CABPp-BE=JfoZp19Va-1oF60ADBUibGDwDkFX-Zytx7A3uJ__gg@mail.gmail.com>
 source: <c7e0d76e71eef56c6279e0f7e82a2d194f78d2a4.1728492617.git.code@khaugsbakk.name>


* pb/clar-build-fix (2024-10-07) 1 commit
 - Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o

 Build fix.

 Expecting a reroll.
 cf. <C05B01E0-5007-4FB9-94CD-CBE74E79F9B7@gmail.com>
 source: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>


* ps/cache-tree-w-broken-index-entry (2024-10-07) 3 commits
 - unpack-trees: detect mismatching number of cache-tree/index entries
 - cache-tree: detect mismatching number of index entries
 - cache-tree: refactor verification to return error codes

 Fail gracefully instead of crashing when attempting to write the
 contents of a corrupt in-core index as a tree object.

 Comments?
 source: <cover.1728275640.git.ps@pks.im>


* ps/maintenance-start-crash-fix (2024-10-10) 1 commit
 - builtin/gc: fix crash when running `git maintenance start`

 "git maintenance start" crashed due to an uninitialized variable
 reference, which has been corrected.

 Will merge to 'next'.
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


* jc/a-commands-without-the-repo (2024-10-06) 3 commits
 - archive: remove the_repository global variable
 - annotate: remove usage of the_repository global
 - git: pass in repo to builtin based on setup_git_directory_gently

 Commands that can also work outside Git have learned to take the
 repository instance "repo" when we know we are in a repository, and
 NULL when we are not, in a parameter.  The uses of the_repository
 variable in a few of them have been removed using the new calling
 convention.

 Comments?
 source: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>


* ej/cat-file-remote-object-info (2024-09-27) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Comments?
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


* jc/breaking-changes-early-adopter-option (2024-09-19) 1 commit
 - BreakingChanges: early adopter option

 Describe the policy to introduce breaking changes.

 Comments?
 source: <xmqq7cb77810.fsf@gitster.g>


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

 Comments?
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
