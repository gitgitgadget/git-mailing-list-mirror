Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A2142658
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347788; cv=none; b=bQNXkwzqRNc701vC2L9rcd9fEtm5HoXslGJwwuIyembAkNgJd/4iU5Re/VBNdBlsinx6p/F9e9mpxQILSTuL9QQ6tPebYhCBZ6+mPvRb/y9E/LcV/8M/jCT3Dg1KsDdyvaXqYNa+kqqjsI3+2kKBR1dTeXuv76XWez5jufe/VNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347788; c=relaxed/simple;
	bh=KiCUrd5I7/8jhGx/EbNfa7c6nOkde9dbU6g04CXoRfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTHf3kt4rvb2++gwAwf4Bkw1AkuALOvpYtanqwU93bZdKBiicbiCYICnK2UNJzi3UZLRIlZ4KdnpGOOjMxQtonDQPHZb6XGaB59P/gqKutypWYGVeUDZNZdj2QDadbrTPeRc9eDXB/FVE/Wq8X1D1bzGbfbcjibNQmpIGIG3fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jzT3Q7CR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C7FEaznO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jzT3Q7CR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C7FEaznO"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8410A11400CD;
	Fri, 14 Jun 2024 02:49:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347785; x=1718434185; bh=2wMz1dTE3J
	kCSDbjBJ5K0KFjEug7n6Vq0qAd0Sb8tR8=; b=jzT3Q7CRW1pE+eV+HVKqIi8HmD
	yE5W5B9fOFTZtLtUmFY7Yp+PKBi8WjqtaxLnk8X3KQIn+mW5VgXIEfMTKxo0eBBP
	1zQZ64hEHLAlpPGVyTwP2Vx3AUDnt+by3C0AqfliydyGufqSjCjw25prKnT+fdMV
	HnInucQX2ftA8PzVnwSLI6p7BJopjmZ7NeX//J1cGk2s2OZPm9znIZze05JIulPW
	4JUXU8OjkHn02IEbNzGay9PDIm25fSOQIzc3lzNlU57oJ8SBoZb2GemycwPvKhpS
	ZFpLljOdy+ApcrT4Natd+RtRy9GisAyHX8MNg31sa7cPZMmGRDYQgIAZPZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347785; x=1718434185; bh=2wMz1dTE3JkCSDbjBJ5K0KFjEug7
	n6Vq0qAd0Sb8tR8=; b=C7FEaznO0n8N2paj/p2F72S0R+0NMdmvMXxK7YyKthxa
	YjnZmYEkKbbeyVdbzsfucZ86iiZWn6XP/2yFPyCiNVAqngxxV/rgQfhZNuw31qKb
	Us1SMPMVXh7j5Hg4x/KEWCykXp42ve/rmW+drTVjY7zox6vCihY3LQZUbYy0DQVl
	4dsW+jIvX7vNqUufBQxhntxLPP7wyVldoxaoSZSuYbXcbz7uV/Bic4HYWkvoeleh
	I/g9B6trqsKz69awABuBTLhjxQO1rWt4SHkBvBSC+eLI+H8SR0Gu9OlS6iicFqoQ
	YkbszDlEn1Yxw1XLFyECW1K+3ySoVJBAmnSz1gmnbg==
X-ME-Sender: <xms:CehrZp-q-M0MlhDmPIE3-rcdwvv_qvhNEw-1fQ9ZsDwFhYj_VYQjbg>
    <xme:CehrZtubtZBAeF3gcaGnB5zMn6oV9u_0tPLu-_8HKraI5cKvG7DsL1COcgF5Dq8Qu
    _mMYou5qYHtCrO-5w>
X-ME-Received: <xmr:CehrZnB2nlYH0E60TZPBvJZ-iDnRo1I2_MFSuXUqhzNcOAj86B5_G9qlof9wkUtWA_rswsYiBrqvTYOY-hDvmyi31mcl7s86QXa6LjOlLpXkLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevieegvddtueefteffkeekjeeuheffudejhfetueeuffehteevtddvjeevkeef
    vdenucffohhmrghinhephhhtthhpqdhfvghttghhqdguuhhmsgdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CehrZtd5BNTXYWtZQgsGx4lzIYYvU3xmp-4bYeeN7zeewUTqY0u-Cg>
    <xmx:CehrZuPO1kuGsHJLiuZmI3Kr0Zs56GDMuv5VoH6LZFURwTWVYTXrnw>
    <xmx:CehrZvmkgFwuxGVi7FEJqkqtDgWwegF_6A89BwV4RiFwz-a7LJKBjQ>
    <xmx:CehrZouFJ22ugWI1XF07jS3XKqfJCbwc3XERwVS9BQTLHAHfI1eTPw>
    <xmx:CehrZl1zeeBpWKgrWdTfCjfh1A4iW8MJg3IY96tVq9AHe0d1BFpFSxIn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:49:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 73cc3e0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:49:28 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:49:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
Message-ID: <cover.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kAYEYKTiyu3ZPliQ"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--kAYEYKTiyu3ZPliQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that introduces the
`USE_THE_REPOSITORY_VARIABLE` macro. When unset, this will cause us to
hide `the_repository`, `the_hash_algo` and several other functions that
implicitly rely on those global variables from our headers. This is a
first step towards fully getting rid of this global state in favor of
passing it down explicitly via function parameters.

Changes compared to v2:

  - Note in a commit message that we aim to have a faithful conversion
    when introducing a `struct git_hash_algo` parameter to functions. So
    even in case the calling context has a `struct git_hash_algo`
    available via a local repository, we still use `the_repository` such
    that there cannot be a change in behaviour here. Fixing those sites
    will be left for a future patch series such that we can avoid any
    kind of regressions caused by this comparatively large refactoring.
    I also adapted some conversions to fully follow through with this
    intent.

  - Fix an issue with sparse by adding another `extern` declaration of
    `the_repository` to "repository.c".

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
 repository.c                                 |   8 +
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
 227 files changed, 1002 insertions(+), 617 deletions(-)
 delete mode 100644 hash-ll.h

Range-diff against v2:
 1:  d2154e8c45 =3D  1:  d2154e8c45 hash: drop (mostly) unused `is_empty_{b=
lob,tree}_sha1()` functions
 2:  aa468c3d88 !  2:  c481479598 hash: require hash algorithm in `hasheq()=
`, `hashcmp()` and `hashclr()`
    @@ Commit message
         As those functions are now independent of `the_repository`, we can=
 move
         them from "hash.h" to "hash-ll.h".
    =20
    +    Note that both in this and subsequent commits in this series we al=
ways
    +    just pass `the_repository->hash_algo` as input even if it is obvio=
us
    +    that there is a repository in the context that we should be using =
the
    +    hash from instead. This is done to be on the safe side and not int=
roduce
    +    any regressions. All callsites should eventually be amended to use=
 a
    +    repo passed via parameters, but this is outside the scope of this =
patch
    +    series.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/index-pack.c ##
    @@ pack-check.c: static int verify_packfile(struct repository *r,
      	r->hash_algo->final_fn(hash, &ctx);
      	pack_sig =3D use_pack(p, w_curs, pack_sig_ofs, NULL);
     -	if (!hasheq(hash, pack_sig))
    -+	if (!hasheq(hash, pack_sig, r->hash_algo))
    ++	if (!hasheq(hash, pack_sig, the_repository->hash_algo))
      		err =3D error("%s pack checksum mismatch",
      			    p->pack_name);
     -	if (!hasheq(index_base + index_size - r->hash_algo->hexsz, pack_sig))
     +	if (!hasheq(index_base + index_size - r->hash_algo->hexsz, pack_sig,
    -+		    r->hash_algo))
    ++		    the_repository->hash_algo))
      		err =3D error("%s pack checksum does not match its index",
      			    p->pack_name);
      	unuse_pack(w_curs);
 3:  403ea4485b !  3:  226173a92b hash: require hash algorithm in `oidread(=
)` and `oidclr()`
    @@ commit-graph.c: static struct tree *load_tree_for_commit(struct repo=
sitory *r,
      			st_mult(GRAPH_DATA_WIDTH, graph_pos - g->num_commits_in_base);
     =20
     -	oidread(&oid, commit_data);
    -+	oidread(&oid, commit_data, r->hash_algo);
    ++	oidread(&oid, commit_data, the_repository->hash_algo);
      	set_commit_tree(c, lookup_tree(r, &oid));
     =20
      	return c->maybe_tree;
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      			struct object_id oid;
     -			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
     +			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
    -+				r->hash_algo);
    ++				the_repository->hash_algo);
      			oid_array_append(&ctx->oids, &oid);
      		}
      	}
    @@ commit-graph.c: static int verify_one_commit_graph(struct repository=
 *r,
     =20
     -		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
     +		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i),
    -+			r->hash_algo);
    ++			the_repository->hash_algo);
     =20
      		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
      			graph_report(_("commit-graph has incorrect OID order: %s then %s"),
 4:  fa263d6b07 =3D  4:  3947c0c04d global: ensure that object IDs are alwa=
ys padded
 5:  a7df209bda =3D  5:  91eb94bc0b hash: convert `oidcmp()` and `oideq()` =
to compare whole hash
 6:  9058837c93 =3D  6:  9ae29e1912 hash: make `is_null_oid()` independent =
of `the_repository`
 7:  d26584dc8f =3D  7:  da48d5fdea hash: require hash algorithm in `is_emp=
ty_{blob,tree}_oid()`
 8:  4858cca25f =3D  8:  1cf25bec3e hash: require hash algorithm in `empty_=
tree_oid_hex()`
 9:  cb3694ad0e !  9:  7e023a335f global: introduce `USE_THE_REPOSITORY_VAR=
IABLE` macro
    @@ remote.c
      #include "abspath.h"
      #include "config.h"
    =20
    + ## repository.c ##
    +@@
    + #include "promisor-remote.h"
    + #include "refs.h"
    +=20
    ++/*
    ++ * We do not define `USE_THE_REPOSITORY_VARIABLE` in this file becaus=
e we do
    ++ * not want to rely on functions that implicitly use `the_repository`=
=2E This
    ++ * means that the `extern` declaration of `the_repository` isn't visi=
ble here,
    ++ * which makes sparse unhappy. We thus declare it here.
    ++ */
    ++extern struct repository *the_repository;
    ++
    + /* The main repository */
    + static struct repository the_repo;
    + struct repository *the_repository =3D &the_repo;
    +
      ## repository.h ##
     @@ repository.h: struct repository {
      	unsigned different_commondir:1;
10:  4492548209 =3D 10:  74c88ebc39 refs: avoid include cycle with "reposit=
ory.h"
11:  f3cbc4b9f9 =3D 11:  fe4550ba0c hash-ll: merge with "hash.h"
12:  9178098dd7 =3D 12:  30babd8a67 http-fetch: don't crash when parsing pa=
ckfile without a repo
13:  0b4436c32b =3D 13:  fa41a85c7e oidset: pass hash algorithm when parsin=
g file
14:  c7abfbc489 =3D 14:  0b42208e2f protocol-caps: use hash algorithm from =
passed-in repository
15:  9ae4fdb8f1 =3D 15:  e1f4bffea1 replace-object: use hash algorithm from=
 passed-in repository
16:  3ceb726655 =3D 16:  5b8f981ea2 compat/fsmonitor: fix socket path in ne=
tworked SHA256 repos
17:  74e5489bd0 =3D 17:  ad83b17ad0 t/helper: use correct object hash in pa=
rtial-clone helper
18:  470aea1fc8 =3D 18:  a488363bcb t/helper: fix segfault in "oid-array" c=
ommand without repository
19:  1f0682fc7d =3D 19:  5de7a01af5 t/helper: remove dependency on `the_rep=
ository` in "proc-receive"
20:  16fb86c2b2 =3D 20:  436ffc0570 hex: guard declarations with `USE_THE_R=
EPOSITORY_VARIABLE`
--=20
2.45.2.457.g8d94cfb545.dirty


--kAYEYKTiyu3ZPliQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6AMACgkQVbJhu7ck
PpQ0XxAAlLNP2Lqi7MM0Gb83m3yAAMFm7kFOd2rSc5mRYzSIMHseJc6/c5ACp1tR
u5BRehmN9eHbP6Ur8iXNW7ObzSKpXkR0UzICKJ/yrZswDGSmWBZ6+tCCm519miFX
uA49AbQEOMVNJxSP7r2Mpk/l5Z3Qtnwls8syBw2L3grm32XM+XLZUkl0tUesoBTz
ThS8x8H3zp7GJmAFD17HulqoaB9cvP370FwA1FoRtnK15MmeXW165ht382aOvuvM
4qVlnSBcSnqEmMOFcctK8a0YjTL/4bm6Jaq+GcEqneI7UU75UnsvjEWG+A5hXoKC
2D5hKvkqaURJ8X6z2mj+Eakb8xoFvn5wSC5VhdclXvvjWHqiXARmXVz3Sc69S7nM
GnrvntG5R0EXNh6k2kRztMEnJXXv3T9uIaTnrxw7LV1LciRgHEOLZMQZ3mHHJ9FY
S+QCh69Ij+miqrZmw0gIvdHkUOYnwI4NqdF9av59hFBXwAi25hDGUGE9h99bSQYm
7pwT0FjfHBfNrP70l4Gn1GX0zebhkO1J+3hsctRuJ5iWcvniUyXJWYmnxkcu2Jfn
lmZzLc4EMWEKSOBa3GxrI1CZ/i+6cZSvbIgI/P/PFH3QXZUNW6T+X1RsBnG3royJ
5Qje7KET5Ysa6n/T7JBOiyJFdryHq1SxbdNVCQpkwgWGgaoSL7I=
=gZ8k
-----END PGP SIGNATURE-----

--kAYEYKTiyu3ZPliQ--
