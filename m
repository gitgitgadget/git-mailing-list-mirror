Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D71C84D7
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106025; cv=none; b=Z7OkXAzdLn/zq7XvpD7tpF4DMuHudPvcH0Z3iVhVaqdHL8aj9O6eswKBR6GvkeAh+mC144DeVe8vNiJAH1qNgZj2u0rYN7OgFwpnc74B3wyme/tQrMl6m/g2c0tpes+tCE2zG9wA5ebAnTrFdHjT8xlaeyIxauGAtV665RyaFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106025; c=relaxed/simple;
	bh=L+ASDNvXsVVj1hDSVD8gxiHMY32r0OyQ1GX9Qc5cax8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=b7fFOxYAaRz3rCJ/TeuqLn4hiqxBEaABrIPBhf50/Ugw8JrivE1FO1Mw+gQPr679qLv/eY+UHgbfLJ1V33EBc+JE3rCWvnCX3ha8MZzgpnC8XrhLViFioUrNRi9T/ex7danCfOk3Bm6lu1mk7ua3qmh9SIleaTWnfvEJWYddZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FMG2Na25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mVSozDDg; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FMG2Na25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mVSozDDg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF3C325400E2;
	Thu,  5 Jun 2025 02:47:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Jun 2025 02:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106020;
	 x=1749192420; bh=rEi2ZewiKrv3OhbT5Txs8Zk/rmrcROWM5N5pMxAG8YQ=; b=
	FMG2Na25d9/wQjMySz3KckajN5s2PSQWY+1CjuTxlqbFERz9taNgYzVGeDi/i7f/
	BGAJTXqx0ItjH2APi0HjY0q1XBMQVbinbvas2If/yNqGIUifuzomsfludMw2w9uP
	N2rYNYaDp1YIMa9dGIbNpLT8l/o1Y4bmC9cKGzM2F8TLcs2nsrsUoEum/7rYDR8h
	SYRiHIzuA+b0Kagz8rShpHuKndUZ9deg6CPtjRn+3T37FcuTamFfZXYMlS7YKA2p
	pksrAZkIa9/UCHTfOfrOgKJK2MVrlbDHpPlc1ErnnRjxKWtTKsNcJkTtgk+cVyrF
	NF7qaHH0qCg3038aGnlAlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106020; x=
	1749192420; bh=rEi2ZewiKrv3OhbT5Txs8Zk/rmrcROWM5N5pMxAG8YQ=; b=m
	VSozDDgmxjgWboWweRXobEM8SnkN59rSdkxP3SHmkxRP9tl/UYaTVEG8CPkV8ehm
	lsNgJ/bKgsHKBoaWKuHL7dljMJ0Rys5GF1JBY34uDhBZHveqUGiFgFYuEv0K0M/n
	JooaROTh5mFh8DmrIKXQthdKNxVSh0rgLLMIJxaah3LOdFREO+IMcJT2JiJCi8Xw
	6oh7kI1ZrQ5etnBa9hQywVW1yJHm0qOTEqnxkQNigvmF3VgSt+znEivRMJwob02h
	st5W8nneYhpQSPSPNNGQ6aF48TUm0uz3uKTt4d3wD4s/2Lrp5nZr4hRKL9JC/CqR
	2vXcNp8mj8aZIY8lCJsUA==
X-ME-Sender: <xms:ZD1BaC3umUUMer9lw_u3NKFeasLO_QdTOK18QGi3EtZqyQEumHbwxw>
    <xme:ZD1BaFHz-M0kEflMB4GmcKlVYr8vP3p3Uz6vEoZ-5DsVXpPMcPrFrgnG4Ko3ALTrC
    BB1r_NabcBgUAgEfg>
X-ME-Received: <xmr:ZD1BaK63puEenMYRGuLBOLwVxKGdF-rRojBlqxob1VxhDK-3a2Hm3kK5fTKDXx-exY_VFNjGENw9Sj7eGw3a42z66DcwHRxWkv1ysHbjcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZD1BaD31TVpWRP_FMMikHJLw0IzbfQj16vZ--D1GPE60Elm_hbnpUg>
    <xmx:ZD1BaFH9BbTAP1dW1WY6rk-sNC1r3uto6-wWIJv25sgvoeSf_Ncpag>
    <xmx:ZD1BaM89tk1y0gHRYOQ1t-Wv4gLPmL4xYWiUjFWs_EPf0m_WasOa2g>
    <xmx:ZD1BaKnckcEMmlQmp64smMlZS7ajg4bKEfUt1nmSbow1tl5kmbF-wQ>
    <xmx:ZD1BaMrf2IASJzAxn-TKzrIp8d6iF2Ubw2WNLVvDmnLVYhSyxKmT6U8N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:46:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d510bb59 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:46:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/17] object-store: carve out the object database
 subsystem
Date: Thu, 05 Jun 2025 08:46:50 +0200
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFs9QWgC/43NQWrDMBAF0KsErTtFGsuy3FXvUbKwpFGtlkZGM
 m5C8N07DpQkOzOr/+G/uYpKJVEVb4erKLSkmvKJQ/tyEH4cTp8EKXAWKLGVfDB9V8jui/wMdc6
 F4DfDPBIUmnJN3Fyg98a7EG3QTgmGpkIxnW9PPo6cx7QtL7efi9raf97s4RcFErxsnUXqnELzz
 qPX9CM2e8FHr9/lIXtKNrHtXbSE9slrHjyld3kNe7oLUQVNQ0B88vTdMxJ3eZo96q2xUg+dN3d
 vXdc/2CcF+MEBAAA=
X-Change-ID: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series refactors the object store subsystem to become more
self-contained by getting rid of `the_repository`. Instead of passing in
the repository explicitly, we start to pass in the object store itself,
which is in contrast to many other refactorings we did, but in line with
what we did for the ref store, as well.

This series also starts to properly scope functions to the carved out
object database subsystem, which requires a bit of shuffling. This
allows us to have a short-and-sweet `odb_` prefix for functions and
prepares us for a future with pluggable object backends.

The series is structured as follows:

  - Patches 1 to 3 rename `struct object_store` and `struct
    object_directory` as well as the code files.

  - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.

  - Patches 13 to 17 adjust the name of remaining functions so that they
    can be clearly attributed to the ODB. I'm happy to kick these
    patches out of this series and resend them at a later point in case
    they create too much turmoil.

This series is built on top of 6f84262c44a (The eleventh batch,
2025-05-05) with ps/object-store-cleanup at 8a9e27be821 (object-store:
drop `repo_has_object_file()`, 2025-04-29) merged into it. There are a
couple of trivial conflicts when merged with "seen", I have appended the
merge conflict resolution as a patch at the end of this mail.

Changes in v2:
  - Fix for a copy-and-pasted commit message.
  - Rename `struct odb_backend` to `struct odb_alternate`. I'm happy to
    revert to the previous name if we ultimately think it's the better
    suited one.
  - A couple of fixes to move changes into the correct commit. `git
    rebase -x 'meson compile -C build'` is now clean.
  - I _didn't_ back out the rename to "odb.{c,h}". Junio has already
    fixed the fallout, so it's probably more work for him to kick it out
    again than to just leave it in.
  - Link to v1: https://lore.kernel.org/r/20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im

Changes in v3:
  - Polishing for some comments and commit messages.
  - Link to v2: https://lore.kernel.org/r/20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im

Changes in v4:
  - Rebased the patch series on top of 7014b55638d (A bit more topics
    for -rc1, 2025-05-30). This fixes a couple of merge conflicts, most
    importantly with jk/no-funny-object-types.
  - Rename `struct odb_alternate` to `odb_source`.
  - Link to v3: https://lore.kernel.org/r/20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im

Changes in v5:
  - Some polishing to fix leftover terminology from previous rounds.
  - Link to v4: https://lore.kernel.org/r/20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      object-store: rename `raw_object_store` to `object_database`
      object-store: rename `object_directory` to `odb_source`
      object-store: rename files to "odb.{c,h}"
      odb: introduce parent pointers
      odb: get rid of `the_repository` in `find_odb()`
      odb: get rid of `the_repository` in `assert_oid_type()`
      odb: get rid of `the_repository` in `odb_mkstemp()`
      odb: get rid of `the_repository` when handling alternates
      odb: get rid of `the_repository`  in `for_each()` functions
      odb: get rid of `the_repository` when handling the primary source
      odb: get rid of `the_repository` when handling submodule sources
      odb: trivial refactorings to get rid of `the_repository`
      odb: rename `oid_object_info()`
      odb: rename `repo_read_object_file()`
      odb: rename `has_object()`
      odb: rename `pretend_object_file()`
      odb: rename `read_object_with_reference()`

 Documentation/user-manual.adoc          |   4 +-
 Makefile                                |   2 +-
 apply.c                                 |  14 +-
 archive-tar.c                           |   2 +-
 archive-zip.c                           |   2 +-
 archive.c                               |   6 +-
 attr.c                                  |   4 +-
 bisect.c                                |   8 +-
 blame.c                                 |  22 +-
 builtin/backfill.c                      |   6 +-
 builtin/blame.c                         |   6 +-
 builtin/cat-file.c                      |  62 ++---
 builtin/checkout.c                      |   2 +-
 builtin/clone.c                         |  14 +-
 builtin/commit-graph.c                  |  20 +-
 builtin/commit-tree.c                   |   4 +-
 builtin/count-objects.c                 |   6 +-
 builtin/describe.c                      |   5 +-
 builtin/difftool.c                      |   4 +-
 builtin/fast-export.c                   |  10 +-
 builtin/fast-import.c                   |  49 ++--
 builtin/fetch.c                         |  21 +-
 builtin/fsck.c                          |  31 ++-
 builtin/gc.c                            |  16 +-
 builtin/grep.c                          |  26 +-
 builtin/hash-object.c                   |   2 +-
 builtin/index-pack.c                    |  29 +-
 builtin/log.c                           |   4 +-
 builtin/ls-files.c                      |   4 +-
 builtin/ls-tree.c                       |   6 +-
 builtin/merge-file.c                    |   2 +-
 builtin/merge-tree.c                    |  14 +-
 builtin/mktag.c                         |   6 +-
 builtin/mktree.c                        |  10 +-
 builtin/multi-pack-index.c              |   6 +-
 builtin/notes.c                         |   8 +-
 builtin/pack-objects.c                  |  70 ++---
 builtin/pack-redundant.c                |   2 +-
 builtin/prune.c                         |   6 +-
 builtin/receive-pack.c                  |   9 +-
 builtin/remote.c                        |   6 +-
 builtin/repack.c                        |   7 +-
 builtin/replace.c                       |  12 +-
 builtin/rev-list.c                      |   8 +-
 builtin/show-ref.c                      |   6 +-
 builtin/submodule--helper.c             |  11 +-
 builtin/tag.c                           |  10 +-
 builtin/unpack-file.c                   |   4 +-
 builtin/unpack-objects.c                |  12 +-
 bulk-checkin.c                          |   6 +-
 bundle-uri.c                            |   5 +-
 bundle.c                                |   6 +-
 cache-tree.c                            |  17 +-
 combine-diff.c                          |   4 +-
 commit-graph.c                          | 106 +++----
 commit-graph.h                          |  20 +-
 commit.c                                |  15 +-
 config.c                                |   4 +-
 connected.c                             |   2 +-
 contrib/coccinelle/the_repository.cocci |   2 +-
 diagnose.c                              |  12 +-
 diff.c                                  |  20 +-
 dir.c                                   |   2 +-
 entry.c                                 |   6 +-
 fetch-pack.c                            |  17 +-
 fmt-merge-msg.c                         |   6 +-
 fsck.c                                  |   4 +-
 grep.c                                  |   6 +-
 http-backend.c                          |   2 +-
 http-push.c                             |  20 +-
 http-walker.c                           |  12 +-
 http.c                                  |   6 +-
 list-objects-filter.c                   |   4 +-
 list-objects.c                          |   6 +-
 log-tree.c                              |   2 +-
 loose.c                                 |  46 ++--
 mailmap.c                               |   4 +-
 match-trees.c                           |   6 +-
 merge-blobs.c                           |  10 +-
 merge-ort.c                             |   8 +-
 meson.build                             |   2 +-
 midx-write.c                            |   2 +-
 midx.c                                  |   6 +-
 notes-cache.c                           |   4 +-
 notes-merge.c                           |   4 +-
 notes.c                                 |  19 +-
 object-file.c                           |  94 +++----
 object-file.h                           |  12 +-
 object-name.c                           |  24 +-
 object-store.h                          | 338 -----------------------
 object.c                                |   8 +-
 object-store.c => odb.c                 | 413 +++++++++++++++-------------
 odb.h                                   | 473 ++++++++++++++++++++++++++++++++
 oss-fuzz/fuzz-pack-idx.c                |   2 +-
 pack-bitmap-write.c                     |   9 +-
 pack-bitmap.c                           |  10 +-
 pack-check.c                            |   2 +-
 pack-mtimes.c                           |   2 +-
 pack-objects.h                          |   2 +-
 pack-revindex.c                         |   2 +-
 pack-write.c                            |  10 +-
 packfile.c                              |  29 +-
 packfile.h                              |   8 +-
 path.c                                  |   4 +-
 promisor-remote.c                       |   6 +-
 protocol-caps.c                         |   4 +-
 reachable.c                             |   2 +-
 read-cache.c                            |  14 +-
 ref-filter.c                            |   6 +-
 reflog.c                                |   8 +-
 refs.c                                  |   7 +-
 remote.c                                |   9 +-
 replace-object.c                        |   2 +-
 replace-object.h                        |   2 +-
 repository.c                            |  21 +-
 repository.h                            |   4 +-
 rerere.c                                |   7 +-
 revision.c                              |   5 +-
 send-pack.c                             |   4 +-
 sequencer.c                             |   7 +-
 server-info.c                           |   2 +-
 shallow.c                               |  14 +-
 streaming.c                             |  10 +-
 submodule-config.c                      |   9 +-
 submodule.c                             |  32 +--
 submodule.h                             |   9 -
 t/helper/test-find-pack.c               |   2 +-
 t/helper/test-pack-mtimes.c             |   2 +-
 t/helper/test-partial-clone.c           |   4 +-
 t/helper/test-read-graph.c              |   8 +-
 t/helper/test-read-midx.c               |   2 +-
 t/helper/test-ref-store.c               |   4 +-
 tag.c                                   |  10 +-
 tmp-objdir.c                            |  30 +-
 tree-walk.c                             |  18 +-
 tree.c                                  |   6 +-
 unpack-trees.c                          |   2 +-
 upload-pack.c                           |   4 +-
 walker.c                                |   6 +-
 xdiff-interface.c                       |   4 +-
 140 files changed, 1453 insertions(+), 1298 deletions(-)

Range-diff versus v4:

 1:  cb0cee8ca28 =  1:  50bcf60f256 object-store: rename `raw_object_store` to `object_database`
 2:  1886e2d9657 !  2:  5223817ea6e object-store: rename `object_directory` to `odb_source`
    @@ object-store.h: struct cached_object_entry;
      /*
       * The object database encapsulates access to objects in a repository. It
     - * manages one or more backends that store the actual objects which are
    -+ * manages one or more alternates that store the actual objects which are
    ++ * manages one or more sources that store the actual objects which are
       * configured via alternates.
       */
      struct object_database {
 3:  9f879846830 =  3:  b6aefd95bda object-store: rename files to "odb.{c,h}"
 4:  13535610312 =  4:  4b67ce83a83 odb: introduce parent pointers
 5:  c8eb92c2112 =  5:  6fe26d9012a odb: get rid of `the_repository` in `find_odb()`
 6:  a9b75d55df3 =  6:  23b332596e4 odb: get rid of `the_repository` in `assert_oid_type()`
 7:  890cabc3c06 =  7:  95b022aef55 odb: get rid of `the_repository` in `odb_mkstemp()`
 8:  e38e8e2988f =  8:  45f89d7a5b2 odb: get rid of `the_repository` when handling alternates
 9:  bc140fac83f =  9:  671e1d461db odb: get rid of `the_repository`  in `for_each()` functions
10:  94679138925 ! 10:  fa2291c77a3 odb: get rid of `the_repository` when handling the primary source
    @@ odb.h: void odb_clear(struct object_database *o);
     +						    const char *dir, int will_destroy);
     +
     +/*
    -+ * Restore a previous backend replaced by `odb_set_temporary_primary_source()`.
    ++ * Restore the primary source that was previously replaced by
    ++ * `odb_set_temporary_primary_source()`.
     + */
     +void odb_restore_primary_source(struct object_database *odb,
     +				struct odb_source *restore_source,
11:  5bb13b32bb0 ! 11:  282b628fd7c odb: get rid of `the_repository` when handling submodule sources
    @@ odb.c: void disable_obj_read_lock(void)
      
      int fetch_if_missing = 1;
      
    -+static int register_all_submodule_alternates(struct object_database *odb)
    ++static int register_all_submodule_sources(struct object_database *odb)
     +{
     +	int ret = odb->submodule_source_paths.nr;
     +
    @@ odb.c: void disable_obj_read_lock(void)
     +	if (ret) {
     +		string_list_clear(&odb->submodule_source_paths, 0);
     +		trace2_data_intmax("submodule", odb->repo,
    -+				   "register_all_submodule_alternates/registered", ret);
    ++				   "register_all_submodule_sources/registered", ret);
     +		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
    -+			BUG("register_all_submodule_alternates() called");
    ++			BUG("register_all_submodule_sources() called");
     +	}
     +	return ret;
     +}
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
      		 */
     -		if (r == the_repository &&
     -		    register_all_submodule_odb_as_alternates())
    -+		if (register_all_submodule_alternates(r->objects))
    ++		if (register_all_submodule_sources(r->objects))
      			/* We added some alternates; retry */
      			continue;
      
12:  1cb9d97c582 = 12:  9e7172fdb7f odb: trivial refactorings to get rid of `the_repository`
13:  453435c4000 ! 13:  932bf88ac7a odb: rename `oid_object_info()`
    @@ object.c: struct object *parse_object_with_flags(struct repository *r,
      
     
      ## odb.c ##
    -@@ odb.c: static int register_all_submodule_alternates(struct object_database *odb)
    +@@ odb.c: static int register_all_submodule_sources(struct object_database *odb)
      	return ret;
      }
      
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
      		 * `odb_add_submodule_source_by_path()` on that submodule's
      		 * ODB). If any such ODBs exist, register them and try again.
      		 */
    --		if (register_all_submodule_alternates(r->objects))
    -+		if (register_all_submodule_alternates(odb))
    +-		if (register_all_submodule_sources(r->objects))
    ++		if (register_all_submodule_sources(odb))
      			/* We added some alternates; retry */
      			continue;
      
14:  238207c6646 = 14:  345ee62c5f9 odb: rename `repo_read_object_file()`
15:  949dffee2b8 = 15:  6108150e126 odb: rename `has_object()`
16:  aff9d3ae2fa = 16:  c7a5955f376 odb: rename `pretend_object_file()`
17:  6dd67f110fd = 17:  033e5e2173e odb: rename `read_object_with_reference()`

---
base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
change-id: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1

