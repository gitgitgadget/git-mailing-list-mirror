Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26CEEC8
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259210; cv=none; b=Nn7xvtDTbRefAZ5W9ZMKUPIl0XKxYs9cVVOnRPn51K/YZbYYni5qx173mJf+Ny09htTnhFhGqvMauoLqC1Q1SCsB4ajUZxcVdzE6xyPYDLq+u76am34GHSV6X1YtjO6HqUp5geH29KwzCS04xVD/YO2ChR09DXDjk3Kv+CPvnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259210; c=relaxed/simple;
	bh=pwcKYUiiO1mbibAzXhCYVUrXITX4KnAkJwAnnlzAve0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6QDfQyBqo+jcI2m0hWlAB47AsG7vwc0BueZ9Vx3RAuafLz31OZlueYQVLJbxLUywDj4/VFPQQnj4VG1BAhVs8fSuxrTfr01yDjCqkuTey/KSkTL5CmOlervAi1vHdTuavqhgNwftB0kYPy9BnkqrAUfQe6J5bfN6uTyscjIOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eTWI1fl8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVZ4qtLB; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eTWI1fl8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVZ4qtLB"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 375AD18000C6;
	Thu, 13 Jun 2024 02:13:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 02:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259206; x=1718345606; bh=4FbPN2AMgY
	YGGNA22ZkQk6XhuEsi7dmCoc4ZQUBkB7I=; b=eTWI1fl81sEkskVvxccUzd/5Xd
	f6IUlOmHsjW5xdvjMG7fj9UWRTBk++zbltWjtwKH1PfO9fywx+YfGqUD+njoPRJR
	1GokpD5oErR6rWqjrr3j3hI0W0Ka2ofFA5Mxdfesjl69Xw6cfNZhbfhzHGLwanl5
	QH7tj7YNNLmSSuG7Enj72EgWKWRzthshOP07cnGp1dTDjADw44CJNwr3D2mvZlyd
	2nlm/BMrDT2Bo0x/TmBiGZX/zm14N8n7jlCMG+sF0GEAQg1ZIhlXL9jpFxW75Q4s
	P+dsIbJood3883qk4zWOe9Hx5ZehVQMJHXYE6lKREx3WdcJZKYurey3NgYAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259206; x=1718345606; bh=4FbPN2AMgYYGGNA22ZkQk6XhuEsi
	7dmCoc4ZQUBkB7I=; b=CVZ4qtLBG247QIYlqbDrt7USrknUCR+/mmIg8jZ5M1M0
	wWu2WDhO1qxQrTU8UNAI42+opefsM0R1uea+VbdcxIkrcDIi1q/JnIcXgUSLtDMA
	pPj9kQGmQvFnR9hudbKq/ecT31M1tlJw5u1TEGpeWgghFdivzC+zDbshuluNgnkE
	eaVylx+11pYGJj/uXVqijDLSGyA5KjZuDYCnHNd+HGhUyblmHHAvry9KEfB9nB8Y
	jW1FgIet/tJUcUDsmnieYXVXnIjd9ZQtZrVkm/gnKbSSycAwDNYVnet3Z+IH2oCE
	4dg2rbXS9FmA3n4MqJd7kl691qI+vh9ajTXr9OEfpg==
X-ME-Sender: <xms:Bo5qZrZXhvbcedONoIbHohpnWbssw6UmjRWNKKhzeAg8mENw7mzMAw>
    <xme:Bo5qZqb4vqFv6LNWMU5v96XnsWTr_CIkJVF1mhEIVXcEy3JwH_UMQss7CJLE8KOAy
    dewcbaX_LW6tozDeg>
X-ME-Received: <xmr:Bo5qZt9aHZa_zZdGN482vNpCJgophcjsn5AxKove1Bi7hx4fpTHd4_XWNMg2AFsk2S0YpKz_ScyWwmSN16cc2ZUmZln0dMkD0JZGcOF-TKI2Xk2dbj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjeeihfekvedtffdvjeegtefgheekgeduteevfedutedvtdfhfeejueejfeekjeeu
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhdprhgvrgguqdgtrg
    gthhgvqdhllhdrhhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Bo5qZhp3m7b5CnDCG4-VyW8AjzKicZ7CFda0GiD1vdR8iHww-taBjg>
    <xmx:Bo5qZmrWbgGbOBztXag6rbIMZJFDthYtOnfEJDxbPuStOWIv0846QA>
    <xmx:Bo5qZnQjc0fGpnyZRsA3uHiF-O8HDX-QeRHvkvUiOzFzsxVi5XNY_A>
    <xmx:Bo5qZurhbZf4577Mflo_qCHxI6hmI4nOFOlS_l9nYHAZXYDQ7wkmhQ>
    <xmx:Bo5qZpUDScpJ3ZI5ZSLPX4RD5G_nd0id4RhcYE_3Z0JJVpopMeH_f4zr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d853d10b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:11 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
Message-ID: <cover.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qbuye+rqo6JNFOYW"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--Qbuye+rqo6JNFOYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduce a new
`USE_THE_REPOSITORY_VARIABLE` macro. If undefined, then declarations
like `the_repository`, `the_hash_algo` and a subset of functions that
implicitly depend on either of these are hidden away. This is a step
towards fully deprecating and getting rid of this global state.

Changes compared to v1:

  - Pull in gt/unit-test-oidtree at ed54840872 (t/: migrate
    helper/test-oidtree.c to unit-tests/t-oidtree.c, 2024-06-08) as a
    new dependency. I mostly did it because it makes commit 19
    redundant, so I've it.

  - As the base commit had to be rebuilt anyway I rebased on top of
    d63586cb31 (The thirteenth batch, 2024-06-12).

  - Rewrote the commit message of patch 16 to explain that this is
    actually a bug that is getting fixed.

Thanks!

Patrick

Patrick Steinhardt (20):
  hash: drop (mostly) unused `is_empty_{blob,tree}_sha1()` functions
  hash: require hash algorithm in `hasheq()`, `hashcmp()` and
    `hashclr()`
  hash: require hash algorithm in `oidread()` and `oidclr()`
  global: ensure that object IDs are always padded
  hash: convert `oidcmp()` and `oideq()` to compare whole hash
  hash: make `is_null_oid()` independent of `the_repository`
  hash: require hash algorithm in `is_empty_{blob,tree}_oid()`
  hash: require hash algorithm in `empty_tree_oid_hex()`
  global: introduce `USE_THE_REPOSITORY_VARIABLE` macro
  refs: avoid include cycle with "repository.h"
  hash-ll: merge with "hash.h"
  http-fetch: don't crash when parsing packfile without a repo
  oidset: pass hash algorithm when parsing file
  protocol-caps: use hash algorithm from passed-in repository
  replace-object: use hash algorithm from passed-in repository
  compat/fsmonitor: fix socket path in networked SHA256 repos
  t/helper: use correct object hash in partial-clone helper
  t/helper: fix segfault in "oid-array" command without repository
  t/helper: remove dependency on `the_repository` in "proc-receive"
  hex: guard declarations with `USE_THE_REPOSITORY_VARIABLE`

 add-interactive.c                            |   4 +-
 add-patch.c                                  |   4 +-
 apply.c                                      |   4 +-
 apply.h                                      |   2 +-
 archive-tar.c                                |   3 +
 archive-zip.c                                |   3 +
 archive.c                                    |   2 +
 attr.c                                       |   2 +
 bisect.c                                     |   2 +
 blame.c                                      |   4 +-
 bloom.c                                      |   1 +
 branch.c                                     |   2 +
 builtin.h                                    |   8 +
 builtin/am.c                                 |   8 +-
 builtin/blame.c                              |   3 +-
 builtin/fast-export.c                        |   2 +-
 builtin/fast-import.c                        |  43 ++-
 builtin/fetch-pack.c                         |   4 +-
 builtin/index-pack.c                         |  11 +-
 builtin/log.c                                |   4 +-
 builtin/merge.c                              |   7 +-
 builtin/notes.c                              |   2 +-
 builtin/pack-objects.c                       |   3 +-
 builtin/pack-redundant.c                     |  10 +-
 builtin/patch-id.c                           |   6 +-
 builtin/pull.c                               |   6 +-
 builtin/receive-pack.c                       |   4 +-
 builtin/replace.c                            |   2 +-
 builtin/rm.c                                 |   2 +-
 builtin/tag.c                                |   2 +-
 builtin/unpack-objects.c                     |   9 +-
 builtin/update-ref.c                         |   8 +-
 bulk-checkin.c                               |   3 +
 bundle-uri.c                                 |   2 +
 bundle.c                                     |   2 +
 cache-tree.c                                 |   7 +-
 checkout.c                                   |   2 +
 checkout.h                                   |   2 +-
 chunk-format.c                               |   2 +
 chunk-format.h                               |   2 +-
 combine-diff.c                               |   2 +
 commit-graph.c                               |  22 +-
 commit-graph.h                               |   2 +
 commit-reach.c                               |   2 +
 commit.c                                     |   2 +
 common-main.c                                |   2 +
 compat/fsmonitor/fsm-ipc-darwin.c            |   7 +-
 compat/sha1-chunked.c                        |   2 +-
 compat/win32/trace2_win32_process_info.c     |   2 +
 config.c                                     |   3 +
 connected.c                                  |   2 +
 convert.c                                    |   2 +
 convert.h                                    |   2 +-
 csum-file.c                                  |   9 +-
 csum-file.h                                  |   2 +-
 delta-islands.c                              |   2 +
 diagnose.c                                   |   2 +
 diff-lib.c                                   |   7 +-
 diff.c                                       |   9 +-
 diff.h                                       |   2 +-
 diffcore-break.c                             |   3 +
 diffcore-rename.c                            |   7 +-
 diffcore.h                                   |   2 +-
 dir.c                                        |   9 +-
 dir.h                                        |   2 +-
 entry.c                                      |   2 +
 environment.c                                |   3 +
 fetch-pack.c                                 |   2 +
 fmt-merge-msg.c                              |   2 +
 fsck.c                                       |   5 +-
 fsmonitor-ipc.c                              |   2 +
 git.c                                        |   2 +
 hash-ll.h                                    | 310 ----------------
 hash-lookup.c                                |   5 +-
 hash.h                                       | 366 ++++++++++++++++---
 help.c                                       |   2 +
 hex.c                                        |   8 +-
 hex.h                                        |  28 +-
 http-backend.c                               |   2 +
 http-fetch.c                                 |   8 +-
 http-push.c                                  |   5 +-
 http-walker.c                                |   6 +-
 http.c                                       |   2 +
 list-objects-filter-options.c                |   2 +
 list-objects-filter.c                        |   2 +
 list-objects.c                               |   2 +
 log-tree.c                                   |   2 +
 loose.c                                      |   2 +
 loose.h                                      |   2 +
 ls-refs.c                                    |   2 +
 mailmap.c                                    |   2 +
 match-trees.c                                |   6 +-
 merge-blobs.c                                |   2 +
 merge-ort.c                                  |   2 +
 merge-ort.h                                  |   2 +-
 merge-recursive.c                            |   3 +
 merge.c                                      |   2 +
 midx-write.c                                 |   2 +
 midx.c                                       |   5 +-
 negotiator/default.c                         |   2 +
 negotiator/skipping.c                        |   2 +
 notes-cache.c                                |   2 +
 notes-merge.c                                |   8 +-
 notes-utils.c                                |   2 +
 notes.c                                      |  14 +-
 object-file-convert.c                        |   6 +-
 object-file.c                                |  19 +-
 object-name.c                                |   2 +
 object.c                                     |   2 +
 object.h                                     |   2 +-
 oid-array.c                                  |   2 +
 oidmap.h                                     |   2 +-
 oidset.c                                     |   8 +-
 oidset.h                                     |   4 +-
 oidtree.c                                    |   4 +-
 oidtree.h                                    |   2 +-
 oss-fuzz/fuzz-commit-graph.c                 |   2 +
 pack-bitmap-write.c                          |   6 +-
 pack-bitmap.c                                |   5 +-
 pack-check.c                                 |   7 +-
 pack-revindex.c                              |   2 +
 pack-write.c                                 |   5 +-
 packfile.c                                   |  20 +-
 packfile.h                                   |   2 +
 parallel-checkout.c                          |   8 +-
 parse-options-cb.c                           |   2 +
 path.c                                       |   3 +
 pathspec.c                                   |   2 +
 pretty.c                                     |   2 +
 progress.c                                   |   2 +
 promisor-remote.c                            |   2 +
 protocol-caps.c                              |   5 +-
 range-diff.c                                 |   2 +
 reachable.c                                  |   2 +
 read-cache-ll.h                              |   2 +-
 read-cache.c                                 |  21 +-
 rebase-interactive.c                         |   2 +
 ref-filter.c                                 |   2 +
 reflog-walk.c                                |   2 +
 reflog.c                                     |   2 +
 refs.c                                       |   8 +-
 refs.h                                       |   8 +-
 refs/files-backend.c                         |   8 +-
 refs/packed-backend.c                        |   8 +-
 refs/ref-cache.h                             |   2 +-
 refs/reftable-backend.c                      |  39 +-
 refspec.c                                    |   2 +
 reftable/dump.c                              |   2 +-
 reftable/reftable-record.h                   |   2 +-
 reftable/system.h                            |   2 +-
 remote-curl.c                                |   2 +
 remote.c                                     |  10 +-
 remote.h                                     |   2 +-
 replace-object.c                             |   2 +-
 repository.h                                 |   9 +-
 rerere.c                                     |   2 +
 reset.c                                      |   2 +
 reset.h                                      |   2 +-
 resolve-undo.c                               |   5 +-
 resolve-undo.h                               |   2 +-
 revision.c                                   |   2 +
 run-command.c                                |   2 +
 scalar.c                                     |   2 +
 send-pack.c                                  |   2 +
 sequencer.c                                  |   8 +-
 serve.c                                      |   4 +-
 server-info.c                                |   2 +
 setup.c                                      |   2 +
 shallow.c                                    |   2 +
 split-index.c                                |   4 +-
 split-index.h                                |   2 +-
 streaming.c                                  |   3 +
 submodule-config.c                           |   4 +-
 submodule.c                                  |   8 +-
 t/helper/test-bitmap.c                       |   2 +
 t/helper/test-bloom.c                        |   2 +
 t/helper/test-cache-tree.c                   |   2 +
 t/helper/test-dump-cache-tree.c              |   2 +
 t/helper/test-dump-fsmonitor.c               |   2 +
 t/helper/test-dump-split-index.c             |   2 +
 t/helper/test-dump-untracked-cache.c         |   2 +
 t/helper/test-find-pack.c                    |   2 +
 t/helper/test-fsmonitor-client.c             |   2 +
 t/helper/test-hash-speed.c                   |   2 +-
 t/helper/test-lazy-init-name-hash.c          |   2 +
 t/helper/test-match-trees.c                  |   2 +
 t/helper/test-oid-array.c                    |   4 +
 t/helper/test-oidmap.c                       |   2 +
 t/helper/test-pack-mtimes.c                  |   2 +
 t/helper/test-partial-clone.c                |   2 +-
 t/helper/test-proc-receive.c                 |   9 +-
 t/helper/test-reach.c                        |   2 +
 t/helper/test-read-cache.c                   |   2 +
 t/helper/test-read-graph.c                   |   2 +
 t/helper/test-read-midx.c                    |   2 +
 t/helper/test-ref-store.c                    |   2 +
 t/helper/test-repository.c                   |   2 +
 t/helper/test-revision-walking.c             |   2 +
 t/helper/test-scrap-cache-tree.c             |   2 +
 t/helper/test-sha1.c                         |   2 +-
 t/helper/test-sha256.c                       |   2 +-
 t/helper/test-submodule-config.c             |   4 +-
 t/helper/test-submodule-nested-repo-config.c |   2 +
 t/helper/test-submodule.c                    |   2 +
 t/helper/test-trace2.c                       |   2 +
 t/helper/test-write-cache.c                  |   2 +
 t/t0064-oid-array.sh                         |  18 +
 t/t5550-http-fetch-dumb.sh                   |   6 +
 t/test-lib-functions.sh                      |   5 +
 t/unit-tests/lib-oid.h                       |   2 +-
 t/unit-tests/t-example-decorate.c            |   2 +
 tag.c                                        |   2 +
 tmp-objdir.c                                 |   2 +
 transport-helper.c                           |   2 +
 transport.c                                  |   2 +
 tree-diff.c                                  |   1 +
 tree-walk.c                                  |   6 +-
 tree-walk.h                                  |   2 +-
 tree.c                                       |   2 +
 unpack-trees.c                               |   2 +
 upload-pack.c                                |   2 +
 walker.c                                     |   2 +
 worktree.c                                   |   2 +
 wt-status.c                                  |   6 +-
 xdiff-interface.c                            |   2 +
 xdiff-interface.h                            |   2 +-
 226 files changed, 994 insertions(+), 617 deletions(-)
 delete mode 100644 hash-ll.h

Range-diff against v1:
 1:  f839013744 =3D  1:  d2154e8c45 hash: drop (mostly) unused `is_empty_{b=
lob,tree}_sha1()` functions
 2:  687ad9fc02 =3D  2:  aa468c3d88 hash: require hash algorithm in `hasheq=
()`, `hashcmp()` and `hashclr()`
 3:  346ca76a7c =3D  3:  403ea4485b hash: require hash algorithm in `oidrea=
d()` and `oidclr()`
 4:  3ff28f313b =3D  4:  fa263d6b07 global: ensure that object IDs are alwa=
ys padded
 5:  e2a0f2125d =3D  5:  a7df209bda hash: convert `oidcmp()` and `oideq()` =
to compare whole hash
 6:  3b6ce3b26c =3D  6:  9058837c93 hash: make `is_null_oid()` independent =
of `the_repository`
 7:  82a391acac =3D  7:  d26584dc8f hash: require hash algorithm in `is_emp=
ty_{blob,tree}_oid()`
 8:  3f091dd94a =3D  8:  4858cca25f hash: require hash algorithm in `empty_=
tree_oid_hex()`
 9:  479bebdf53 !  9:  cb3694ad0e global: introduce `USE_THE_REPOSITORY_VAR=
IABLE` macro
    @@ t/helper/test-dump-untracked-cache.c
      #include "dir.h"
      #include "hex.h"
    =20
    - ## t/helper/test-example-decorate.c ##
    -@@
    -+#define USE_THE_REPOSITORY_VARIABLE
    -+
    - #include "test-tool.h"
    - #include "git-compat-util.h"
    - #include "object.h"
    -
      ## t/helper/test-find-pack.c ##
     @@
     +#define USE_THE_REPOSITORY_VARIABLE
    @@ t/helper/test-write-cache.c
      #include "lockfile.h"
      #include "read-cache-ll.h"
    =20
    + ## t/unit-tests/t-example-decorate.c ##
    +@@
    ++#define USE_THE_REPOSITORY_VARIABLE
    ++
    + #include "test-lib.h"
    + #include "object.h"
    + #include "decorate.h"
    +
      ## tag.c ##
     @@
     +#define USE_THE_REPOSITORY_VARIABLE
10:  7e718c967a =3D 10:  4492548209 refs: avoid include cycle with "reposit=
ory.h"
11:  fb7544181a ! 11:  f3cbc4b9f9 hash-ll: merge with "hash.h"
    @@ t/helper/test-sha256.c
      int cmd__sha256(int ac, const char **av)
      {
    =20
    + ## t/unit-tests/lib-oid.h ##
    +@@
    + #ifndef LIB_OID_H
    + #define LIB_OID_H
    +=20
    +-#include "hash-ll.h"
    ++#include "hash.h"
    +=20
    + /*
    +  * Convert arbitrary hex string to object_id.
    +
      ## tree-diff.c ##
     @@
      #include "tree.h"
12:  b47fa99f3d =3D 12:  9178098dd7 http-fetch: don't crash when parsing pa=
ckfile without a repo
13:  95d9b5fa3e =3D 13:  0b4436c32b oidset: pass hash algorithm when parsin=
g file
14:  c877d48f7d =3D 14:  c7abfbc489 protocol-caps: use hash algorithm from =
passed-in repository
15:  ca5f4056fb =3D 15:  9ae4fdb8f1 replace-object: use hash algorithm from=
 passed-in repository
16:  d4e87f9d6b ! 16:  3ceb726655 compat/fsmonitor: remove dependency on `t=
he_repository` in Darwin IPC
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    compat/fsmonitor: remove dependency on `the_repository` in Darwin =
IPC
    +    compat/fsmonitor: fix socket path in networked SHA256 repos
    =20
         The IPC socket used by the fsmonitor on Darwin is usually containe=
d in
         the Git repository itself. When the repository is hosted on a netw=
orked
    @@ Commit message
         directory or the socket directory. In that case, we derive the pat=
h by
         hashing the repository path.
    =20
    -    The hashing implicitly depends on `the_repository` though via
    -    `hash_to_hex()`. For one, this is wrong because we really should be
    -    using the passed-in repository. But arguably, it is not sensible to
    -    derive the path hash from the repository's object hash in the first
    -    place -- they don't have anything to do with each other, and a
    -    repository that is hosted in the same path should always derive th=
e same
    -    IPC socket path.
    +    But while we always use SHA1 to hash the repository path, we then =
end up
    +    using `hash_to_hex()` to append the computed hash to the socket pa=
th.
    +    This is wrong because `hash_to_hex()` uses the hash algorithm conf=
igured
    +    in `the_repository`, which may not be SHA1. The consequence is tha=
t we
    +    may append uninitialized bytes to the path when operating in a SHA=
256
    +    repository.
    =20
    -    Fix this by unconditionally using SHA1 to derive the path.
    +    Fix this bug by using `hash_to_hex_algop()` with SHA1.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## compat/fsmonitor/fsm-ipc-darwin.c ##
    +@@ compat/fsmonitor/fsm-ipc-darwin.c: const char *fsmonitor_ipc__get_p=
ath(struct repository *r)
    + 	git_SHA_CTX sha1ctx;
    + 	char *sock_dir =3D NULL;
    + 	struct strbuf ipc_file =3D STRBUF_INIT;
    +-	unsigned char hash[GIT_MAX_RAWSZ];
    ++	unsigned char hash[GIT_SHA1_RAWSZ];
    +=20
    + 	if (!r)
    + 		BUG("No repository passed into fsmonitor_ipc__get_path");
     @@ compat/fsmonitor/fsm-ipc-darwin.c: const char *fsmonitor_ipc__get_p=
ath(struct repository *r)
      	/* Create the socket file in either socketDir or $HOME */
      	if (sock_dir && *sock_dir) {
17:  5310883469 =3D 17:  74e5489bd0 t/helper: use correct object hash in pa=
rtial-clone helper
18:  2774b8500f =3D 18:  470aea1fc8 t/helper: fix segfault in "oid-array" c=
ommand without repository
19:  339d668da8 <  -:  ---------- t/helper: remove dependency on `the_repos=
itory` in "oidtree"
20:  97fa3051fa =3D 19:  1f0682fc7d t/helper: remove dependency on `the_rep=
ository` in "proc-receive"
21:  92c7f542d2 =3D 20:  16fb86c2b2 hex: guard declarations with `USE_THE_R=
EPOSITORY_VARIABLE`
--=20
2.45.2.457.g8d94cfb545.dirty


--Qbuye+rqo6JNFOYW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjgAACgkQVbJhu7ck
PpQ2PQ/6AjM/ZUsqB09TjsLNKXRRi0j2/wO57823fGgmCq9aUosN6ErFkbvezfj7
CqvGXX2y0fK6go7WreQY2fj2Qi9IwCTdazX6isxmYgmrn5uStvvJXXAg9LoO3E1S
FzU3qiyRIYpAOyhiqroVqjbQbTH9PmroCgQFR1/Rt9dHq1YwGIqz+xtu3aqeRDFh
Dttl2GP40jhK1b0A4pZCrdiJklUOGq72KTRXn0+lbe8l1c6e7Gba8lQ8iLSqF94v
Gh661qC9U4y/V1g0zTklHvXgCHKFDCn26XCmo0QGYFRJeS3EA/Sn1KJysV9Iozh2
6dvOCkW5sVo39ogvdUhdzX31oJH4xnoJ9947Vlxz7j9YZ829wkhh4Blu/y+55hht
fpLbywsnolLYLu75ikxh8/63we39/839A+krYcmafIkDrEL/+qe0l7J5h4PzEopy
pA9gRUmBQCUKo+zBIJf5vBEq5oenei+bkOvIgp4/GCLUIG4zzyoyvfk7p/QmfOhc
TV66BAPZM545Y8u6kf+p5ZRIeUIx/U7uQFd2eOxXzMa1skC/PpSzaJEOnnx6PRBu
tN++vVAL11ct4wlwHQWxTvbMVXpEjUEaAyId3PTuabrmsRP2+uiXgnOZkgE6b7TX
o0I0pYfchMa9m6kAee9eo18/1THrYJEEX/sxOCWM/RMHVdkDzWs=
=L7XF
-----END PGP SIGNATURE-----

--Qbuye+rqo6JNFOYW--
