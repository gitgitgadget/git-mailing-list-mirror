Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF92989A7
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363799; cv=none; b=UMuJ3rqWEnLJrZm3BmVBVj/rOc8wayyS1YgxTVzJvhmZ6xRsOUe5actVgPn/5yi4eMoAEmHDTy9KIfsqwlKk9c6oGrLbF0zaO8hABIkgIprhbup8P9rGj1jSIw2LYwauizhXHNyDjI4EBHyPdxf/47bvMPUZmS0lCP7B3dPFALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363799; c=relaxed/simple;
	bh=rFvHCqrSY/ZZ9ztv6qkUBpaoMQUO9MXBi7NgcgeQ+po=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=BNV2XFvAOVZTB60TnxuFQOFlwk7LAtQfKZBJAkGmw2B2woqIj7zu1sIZ3kIh6m5NEN1c9nQOchrHW3Qhw8fOzAk3lAX6Gea2yJ5NkEQRxj7qSShuB11mChwR1DPqUxs7iq2yIlejJkFSRtPBOIlZkLe9TinnyWlZfyNcFGHILqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tad3aF4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uCtTBVUP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tad3aF4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uCtTBVUP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 467B41380298;
	Fri, 11 Apr 2025 05:29:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Apr 2025 05:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363796;
	 x=1744450196; bh=j+0qryfbMZY6VcHbcRNqrrFrk9icoTHV7pERwMzsPlw=; b=
	Tad3aF4LcTB37/QAFrkx1co1FG2QZjca5N6sRBAr7Zf9bLK3qS1i7z4a3eB7xZOW
	gfxJO1ZF+YXF+BgqCIShKwqiS5sxeavGEwMkIryFOzjYlNDTn0/9XOVRUk5Bflta
	iC0K7yoORJhyN+uTs5xTPwDSTemNIsSNIud5CBWPdzvl74JJ5ZM/jN5ypLAN6bgm
	zHMxB2i9Bh83sK6UJsxfw6J1O0ZTzHDN874jaRRmSlr37oSqc3tRJX098ugMrCf6
	V+QUyBEEmm6hvGhVrz5Gdga16tfxOQ/qnEtlS6oJ0S2iXGAm7NQII65Fs9ZilPs/
	SJ2ib1gnfGJtLIVi3+Pc7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363796; x=
	1744450196; bh=j+0qryfbMZY6VcHbcRNqrrFrk9icoTHV7pERwMzsPlw=; b=u
	CtTBVUPnTfMabBrKizHvgm5ATGyh+Un5ZRAZsx1mdH/JrVvwGts/B7z5ky9Klgfv
	859S4Qyakf/9/TTjak5IdxEAGmWq7M6GiXlpjL25oRYEQecpx/2OYBUOSpwRX9Cn
	BQoCgLizaFtFHWHCQuUZhMn2MrV6xv+3iJsy8bNUMMY+Dpa9q1VqRaa1POJPdNHa
	Up6DKmnIa5EFOeTlB3MMB108SqvOS6/vbbNM2DVGGj/SKXMny7BJcjZ7irZot07k
	rVk6MZ3c9qz/UoUVy9J9gLHHg27i13GUaeX4sOmXzB7WJWdI7TtkiIIy2JDompNA
	trkGk4H3HIXv0yeDzPWxg==
X-ME-Sender: <xms:FOH4Z1QLfxVwk-4Vo1z6Vjrhn_WnAWVI3I5I7m_xCHKWeNd9CNLZ5A>
    <xme:FOH4Z-xmq9weF0lvBmUuC1Nyj9z_kU8IrQGBOe5lbRX3ebWO1BFvxzGBN706ylMpq
    3dYXwaoH07Knqmt5g>
X-ME-Received: <xmr:FOH4Z60yY3RfB-H66HV-ZC6ul8mSHek4t1Ckcoc_8ZxjFWo4ZOqcZqECPjmLBI-aS4jv3EdWA0Shy2H4ZwiRWGgn2NbWCbWNCG0slqv4ZROCFqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FOH4Z9BtI7CBSTkp34V1DKXMC39Tb_0Xnp1jiCGD5en3G2IJnP55mQ>
    <xmx:FOH4Z-hlwqsKaTojmXyPScQwMRUaJU5nVgb60FID6azUU4MeGdsx-w>
    <xmx:FOH4ZxpwGmxIyEcN6bSorSkOLWDKf7zO5RRJQyGHwLBLRyyoduaYUg>
    <xmx:FOH4Z5iojh4hLR17ZShn5ia0uofltUxZbqi5MrJ7IkwECtRoxtXtrA>
    <xmx:FOH4Z6cxuIlUkvJJPDfSEgJmNL21PH8oUo__fQIZ5G_-nR67QK-ci5tm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:29:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 466e7401 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:29:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/9] Split up "object-file.c"
Date: Fri, 11 Apr 2025 11:29:49 +0200
Message-Id: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3h+GcC/4WNSw7CMAxEr1J5jVEcWn4r7oG6KIlDDaWJkioCV
 b07oRdg+UYzb2ZIHIUTnKsZImdJ4scCelOB6bvxzii2MGilG1WrI4ZnwhQGmdDfHmwmdDIwmj3
 Zg7G60+SgbENkJ+/Ve20L95ImHz/rTaZf+s+YCRU6crZRdCKqd5fS28oL2mVZvlRitKK3AAAA
X-Change-ID: 20250408-pks-split-object-file-c61d7cd2a21f
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

"object-file.c" is quite a grab-bag of all kinds of different functions.
Many of these functions aren't really a good fit though and should be
owned by a different subsystem. This patch series tries to split up
concerns a bit better by splitting out this functionality into other
files:

  - `safe_create_leading_directories()` is moved into "dir.c".
  - `xmmap()` is moved into "wrapper.c".
  - `git_open_cloexec()` is moved into "compat/open.c".
  - Several functions attached to `struct index_state` are moved into
    "read-cache.c".
  - Several functions related to `struct object_store` are moved into a
    new file "object-store.c".

"object-file.c" now mostly contains logic to read and write loose object
files, whereas "object-store.c" contains the higher-level logic to
manage different object directories for a repository. Eventually, these
will become the loose object backend as well as the `struct ref_store`
equivalent for objects, respectively.

The series is built on top of 9d22ac51228 (The third batch, 2025-04-07)
with ps/object-wo-the-repository at 9442b1c919a (Merge remote-tracking
branch 'junio/ps/object-wo-the-repository' into HEAD, 2025-04-08) merged
into it.

Changes in v2:
  - Fix a grammar issue in one of the commit messages.
  - Link to v1: https://lore.kernel.org/r/20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      object-file: move `safe_create_leading_directories()` into "dir.c"
      object-file: move `git_open_cloexec()` to "compat/open.c"
      object-file: move `xmmap()` into "wrapper.c"
      object-file: split out functions relating to object store subsystem
      object-file: split up concerns of `HASH_*` flags
      object-file: split out functions relating to index subsystem
      object: split out functions relating to object store subsystem
      object-store: remove global array of cached objects
      object-store: merge "object-store-ll.h" and "object-store.h"

 Makefile                           |    3 +-
 apply.c                            |    2 +-
 archive-tar.c                      |    2 +-
 archive-zip.c                      |    2 +-
 archive.c                          |    2 +-
 attr.c                             |    2 +-
 bisect.c                           |    2 +-
 blame.c                            |    4 +-
 builtin/backfill.c                 |    2 +-
 builtin/blame.c                    |    2 +-
 builtin/bugreport.c                |    2 +-
 builtin/cat-file.c                 |    2 +-
 builtin/checkout.c                 |    3 +-
 builtin/clone.c                    |    2 +-
 builtin/commit-graph.c             |    2 +-
 builtin/commit-tree.c              |    2 +-
 builtin/count-objects.c            |    2 +-
 builtin/credential-cache--daemon.c |    2 +-
 builtin/describe.c                 |    2 +-
 builtin/diagnose.c                 |    2 +-
 builtin/difftool.c                 |    4 +-
 builtin/fast-export.c              |    2 +-
 builtin/fast-import.c              |    2 +-
 builtin/fetch.c                    |    2 +-
 builtin/fsck.c                     |    3 +-
 builtin/gc.c                       |    4 +-
 builtin/grep.c                     |    2 +-
 builtin/hash-object.c              |   26 +-
 builtin/index-pack.c               |    2 +-
 builtin/init-db.c                  |    2 +-
 builtin/log.c                      |    4 +-
 builtin/ls-tree.c                  |    2 +-
 builtin/merge-file.c               |    1 +
 builtin/merge-tree.c               |    2 +-
 builtin/mktag.c                    |    2 +-
 builtin/mktree.c                   |    3 +-
 builtin/multi-pack-index.c         |    2 +-
 builtin/notes.c                    |    3 +-
 builtin/pack-objects.c             |    2 +-
 builtin/pack-redundant.c           |    2 +-
 builtin/prune.c                    |    2 +-
 builtin/receive-pack.c             |    3 +-
 builtin/remote.c                   |    2 +-
 builtin/repack.c                   |    2 +-
 builtin/replace.c                  |    5 +-
 builtin/rev-list.c                 |    2 +-
 builtin/show-ref.c                 |    2 +-
 builtin/submodule--helper.c        |    2 +-
 builtin/tag.c                      |    3 +-
 builtin/unpack-file.c              |    3 +-
 builtin/unpack-objects.c           |    3 +-
 builtin/update-index.c             |    2 +-
 bulk-checkin.c                     |    9 +-
 bundle-uri.c                       |    2 +-
 bundle.c                           |    2 +-
 cache-tree.c                       |    4 +-
 combine-diff.c                     |    2 +-
 commit-graph.c                     |    4 +-
 commit-graph.h                     |    2 +-
 commit.c                           |    3 +-
 compat/open.c                      |   29 +
 config.c                           |    2 +-
 connected.c                        |    2 +-
 convert.c                          |    2 +-
 diagnose.c                         |    2 +-
 diff.c                             |    4 +-
 diffcore-rename.c                  |    2 +-
 dir.c                              |  109 ++-
 dir.h                              |   35 +
 entry.c                            |    2 +-
 fetch-pack.c                       |    2 +-
 fmt-merge-msg.c                    |    2 +-
 fsck.c                             |    2 +-
 git-compat-util.h                  |    3 +
 grep.c                             |    2 +-
 http-backend.c                     |    2 +-
 http-push.c                        |    3 +-
 http-walker.c                      |    2 +-
 http.c                             |    2 +-
 list-objects-filter.c              |    2 +-
 list-objects.c                     |    2 +-
 log-tree.c                         |    2 +-
 mailmap.c                          |    2 +-
 match-trees.c                      |    3 +-
 merge-blobs.c                      |    2 +-
 merge-ort.c                        |    3 +-
 merge-recursive.c                  |    2 +-
 meson.build                        |    2 +
 midx-write.c                       |    1 +
 midx.c                             |    1 -
 notes-cache.c                      |    3 +-
 notes-merge.c                      |    5 +-
 notes.c                            |    3 +-
 object-file.c                      | 1420 +-----------------------------------
 object-file.h                      |  118 +--
 object-name.c                      |    2 +-
 object-store-ll.h                  |  556 --------------
 object-store.c                     | 1050 ++++++++++++++++++++++++++
 object-store.h                     |  516 ++++++++++++-
 object.c                           |   67 --
 oss-fuzz/fuzz-pack-idx.c           |    2 +-
 pack-bitmap-write.c                |    2 +-
 pack-bitmap.c                      |    3 +-
 pack-check.c                       |    2 +-
 pack-mtimes.c                      |    3 +-
 pack-objects.h                     |    2 +-
 pack-revindex.c                    |    3 +-
 packfile.c                         |    2 +-
 path.c                             |    2 +-
 promisor-remote.c                  |    2 +-
 protocol-caps.c                    |    2 +-
 prune-packed.c                     |    2 +-
 reachable.c                        |    2 +-
 read-cache.c                       |  230 +++++-
 read-cache.h                       |    9 +
 ref-filter.c                       |    2 +-
 reflog.c                           |    2 +-
 refs.c                             |    2 +-
 remote.c                           |    2 +-
 replace-object.c                   |    2 +-
 replace-object.h                   |    2 +-
 repository.c                       |    2 +-
 rerere.c                           |    2 +-
 revision.c                         |    2 +-
 send-pack.c                        |    2 +-
 sequencer.c                        |    2 +-
 server-info.c                      |    2 +-
 shallow.c                          |    2 +-
 streaming.c                        |    2 +-
 submodule-config.c                 |    2 +-
 submodule.c                        |    2 +-
 t/helper/test-pack-mtimes.c        |    2 +-
 t/helper/test-partial-clone.c      |    2 +-
 t/helper/test-read-graph.c         |    2 +-
 t/helper/test-read-midx.c          |    2 +-
 t/helper/test-ref-store.c          |    2 +-
 tag.c                              |    2 +-
 tmp-objdir.c                       |    2 +-
 tree-walk.c                        |    2 +-
 tree.c                             |    2 +-
 unpack-trees.c                     |    2 +-
 upload-pack.c                      |    2 +-
 walker.c                           |    2 +-
 wrapper.c                          |   48 ++
 xdiff-interface.c                  |    2 +-
 145 files changed, 2296 insertions(+), 2224 deletions(-)

Range-diff versus v1:

 1:  f1b7bd0550e =  1:  ad5f2af9380 object-file: move `safe_create_leading_directories()` into "dir.c"
 2:  859e33f9b6e =  2:  2ae1de46a37 object-file: move `git_open_cloexec()` to "compat/open.c"
 3:  f676828ab77 !  3:  18145eb4a7d object-file: move `xmmap()` into "wrapper.c"
    @@ Commit message
         object-file: move `xmmap()` into "wrapper.c"
     
         The `xmmap()` function is provided by "object-file.c" even though its
    -    functionality got nothing to do with the object file subsystem. Move it
    +    functionality has nothing to do with the object file subsystem. Move it
         into "wrapper.c", whose header already declares those functions.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 4:  1ed615206a5 =  4:  944883c3ad0 object-file: split out functions relating to object store subsystem
 5:  2d6354ebb65 =  5:  fed8a395b4f object-file: split up concerns of `HASH_*` flags
 6:  1d97b65731d =  6:  292c4d911ff object-file: split out functions relating to index subsystem
 7:  47fb869121a =  7:  478209b9109 object: split out functions relating to object store subsystem
 8:  bd8ce7dcc57 =  8:  e446ade793b object-store: remove global array of cached objects
 9:  69e337e58f0 =  9:  d2f0e4e52a1 object-store: merge "object-store-ll.h" and "object-store.h"

---
base-commit: 9442b1c919af9aed513eb0a484fe96358a500cf5
change-id: 20250408-pks-split-object-file-c61d7cd2a21f

