Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509F2737F2
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372544; cv=none; b=HwHIu/ujBcTmDl2LpE5bhjkA89xk/i2ZhTJdVgxCtpRjlSBls7tmpPLI2HuPSiPug7aN55Pz2paKchOWUfyUYDswGWGYFSNbn/Y11fNkbxWGPD4OgfvuD6gaXxs7JZ5YfCoMH3H5WohLETSFQGR2oXuXlXnRFYzezOc4r+g4ZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372544; c=relaxed/simple;
	bh=PteynBdZs/ZT5OOr7xBRwMRVD6HOCtQ0nwSVT203hkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=q+qsBqV9FARQW9hhTmTgNHmjwkC+ryNhP4o+OVTD4zvzefxDKEQUfZqRL/Ck5+m4GgELvdiv/HqtlO0WZyqtcWaDpHr8nBqA//00e4TEzrrHCxvwwgyxPPng4HcgrtpJ4TaWKHebsvKcT5kJQKlNITHPdsjrwrCdC28n+Cr7zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XdcXFyNy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iyO/hiqr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XdcXFyNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyO/hiqr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 00949EC04DA;
	Tue,  1 Jul 2025 08:22:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 08:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372541;
	 x=1751458941; bh=yb+B7+ttomcPoWFUmIbcgNngS/Dwcdr+3h54q0n7YMw=; b=
	XdcXFyNyBhl1qebufSAIiQi7pQALAcdJAf8rxiUJBwqw0Mk67LEM38wIuQNjslzs
	H5XZwjNEskGT9jgbVVPDOYKSSRpBz8NneNzdtHe3PRjFIlpLJs2+LawxDPsz7TcR
	T81FZuN87r/Qc1842TnOSeGOvnU4s1uqZFR7kUQJqYUKYNg3wUxZgTjIgNrrcUKD
	/KlTLED8l4wETMClx+/03o7ag1hagJSa0ExP0DR8nVwjMyLYPruKSWZABoImKz1v
	esjbB6aLF52llEg0QE6egx03ALRW7pSAbPPU+R2xo481ze3V3K0mT45BHqFcJdO6
	sEdYGsn+9mHAedbhJDXKIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372541; x=
	1751458941; bh=yb+B7+ttomcPoWFUmIbcgNngS/Dwcdr+3h54q0n7YMw=; b=i
	yO/hiqrPH3XfnTdy1E5mRBz96AXATLb/CAhzVpNTDHTwy5J41Jd5+uLyxTCY+lJR
	DcFApKxGCBcpZBJtnD67xp4rI3/usvVHEyoZ7wUBedGt8MymNflv6Exo63wVuHjl
	ZwdpJ624TtnBJr4GSr8M3tvJHVRdHGh6kzKI5H5pNcKzzlEQsqWSHRvyTcdf2ZAQ
	Q2PvfTEUhsM6MMFqlcD2jKBITb4i0gwirK5QOlF2U1W1C/ZrIQx4lhTpUutd5FN1
	lHyKbOGJlzukzyWSVpQ/MuprolPpf5f3O25eAGv1G6iZXmdAO65MLtKrBTDSkAMk
	ddIMdGhvsc/j6IzHW16Eg==
X-ME-Sender: <xms:_dJjaLHCbEJIpRu_MwusMwEIiZioSSZPQy-yzJgU4jnoobLcx7sE2w>
    <xme:_dJjaIUHXECz2VqSpqooEjWPsSR0EkfQPHCXC3bEKHht4jUxXb7ySVHP1uXCxTx2K
    X5KVqYG3y2FfjsTpQ>
X-ME-Received: <xmr:_dJjaNIJ7VFM2fAJ9F1wabeLnJ0J9fJ4RZcRUYGdgoit_UgksgmSDOy7mK2EbwjaDkaXPHfLgIaRnX8WKHSpuyiUZwm7oHcKYWTDYTCZPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:_dJjaJFGO0euJFrqFlpr1WCiTsQVCAGHJIK8T03kLJB_cLQI1-Uhrw>
    <xmx:_dJjaBUWk53zFf-WEZ4YqfBT0P94f4pb3DGecPSetAmtUIpuXkTE8w>
    <xmx:_dJjaEPhuU8G2WWcMj45_a6hohCLEaFeJZpB79rcE09MlN3e7rhUTg>
    <xmx:_dJjaA2t6CgmXVxlLfQORVJhbfasjAMZXP0Ym1P3LiwOTgsVDCMpbw>
    <xmx:_dJjaIstexMZmG4yF-8KzJRmSzMANFGRtDmNdozxeMtyHSTaIbTaCbvY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:22:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9086e5fe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:22:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/17] object-store: carve out the object database
 subsystem
Date: Tue, 01 Jul 2025 14:22:12 +0200
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXSY2gC/43RTU7EMAwF4KuMsiYocfNXVtwDzaJJXBoQk6qpy
 oxGvTvuSEC7i7x6lt7nhe+s4JSwsJfTnU24pJLyhYJ5OrEwdJd35ClSZiBACxo+fhae/QeGmZc
 5T8i/M58H5BOOuSTa3HgbTPCxd1F5yQgaJ+zT9XHk7Ux5SFvz9ri5yG37y5safpFc8CC0d4DWS
 zCvVHpOX2yzF9h7bZUH5EnR9Lr1vUNwB6/ZeVJVeQ15ysZeRoVdBDh46t8zAqo8RR62zjihOhv
 M0dN7r+o9iybP2jbKAM5a5f+8dV1/AHn/vvURAgAA
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

Changes in v6:
  - Fix a mis-merged comment.
  - A couple of commit message improvements.
  - Link to v5: https://lore.kernel.org/r/20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im

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

Range-diff versus v5:

 1:  9df738c135b =  1:  55efa04c9b5 object-store: rename `raw_object_store` to `object_database`
 2:  85ee1dd80f0 =  2:  9e259ec9129 object-store: rename `object_directory` to `odb_source`
 3:  8a9e759fcfa =  3:  4bef9e8ca2e object-store: rename files to "odb.{c,h}"
 4:  872828f8061 !  4:  4a82e103b22 odb: introduce parent pointers
    @@ odb.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *
      		goto error;
      
      	CALLOC_ARRAY(alternate, 1);
    --	/* pathbuf.buf is already in r->objects->source_by_path */
     +	alternate->odb = odb;
    -+	/* pathbuf.buf is already in r->objects->alternate_by_path */
    + 	/* pathbuf.buf is already in r->objects->source_by_path */
      	alternate->path = strbuf_detach(&pathbuf, NULL);
      
      	/* add the alternate entry */
 5:  bf292f80e6a =  5:  d1096993665 odb: get rid of `the_repository` in `find_odb()`
 6:  03f57d8efbc =  6:  8bd70f6e303 odb: get rid of `the_repository` in `assert_oid_type()`
 7:  2aafcbaf706 =  7:  97cd748c462 odb: get rid of `the_repository` in `odb_mkstemp()`
 8:  9a9eaa9fe0f !  8:  bfc550d81e6 odb: get rid of `the_repository` when handling alternates
    @@ Commit message
         odb: get rid of `the_repository` when handling alternates
     
         The functions to manage alternates all depend on `the_repository`.
    -    Refactor them to accept an object database as parameter and adjusting
    -    all callers. The functions are renamed accordingly.
    +    Refactor them to accept an object database as a parameter and adjust all
    +    callers. The functions are renamed accordingly.
     
         Note that right now the situation is still somewhat weird because we end
    -    up using the path provided by the object store's repository anyway. This
    -    will be adapted over time though so that we instead store the path to
    -    the primary object directory in the object database itself.
    +    up using the object store path provided by the object store's repository
    +    anyway. Consequently, we could have instead passed in a pointer to the
    +    repository instead of passing in the pointer to the object store. This
    +    will be addressed in subsequent commits though, where we will start to
    +    use the path owned by the object store itself.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 9:  1618716a75f =  9:  34649c4cbe1 odb: get rid of `the_repository`  in `for_each()` functions
10:  9c282be2a37 = 10:  5954680f7be odb: get rid of `the_repository` when handling the primary source
11:  eb31130c720 = 11:  25b07546210 odb: get rid of `the_repository` when handling submodule sources
12:  a5d6a5fb8a1 = 12:  945c95ba26c odb: trivial refactorings to get rid of `the_repository`
13:  61e3cb25aa2 = 13:  624c80b44cb odb: rename `oid_object_info()`
14:  1ab82f81ff5 = 14:  366c2733c69 odb: rename `repo_read_object_file()`
15:  427eb9893b9 = 15:  cf287279010 odb: rename `has_object()`
16:  bdf62e5cf47 ! 16:  42c14c70181 odb: rename `pretend_object_file()`
    @@ Commit message
         functions related to the object database and our modern coding
         guidelines.
     
    -    No compatibility wrapper is introduces as the function is not used a lot
    +    No compatibility wrapper is introduced as the function is not used a lot
         throughout our codebase.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
17:  550d4a75562 ! 17:  ad0b56350b0 odb: rename `read_object_with_reference()`
    @@ Commit message
         been found. This is generally referred to as "peeling", so the new name
         should be way more descriptive.
     
    -    No compatibility wrapper is introduces as the function is not used a lot
    +    No compatibility wrapper is introduced as the function is not used a lot
         throughout our codebase.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>

---
base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
change-id: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1

