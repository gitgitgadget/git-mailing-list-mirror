Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863D27990D
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529763; cv=none; b=heeMLaxNYBoM3/arUNnlG/pVHFTHVZFderkx6GfeL6tqGO2T2vFJAGFwB6bH6I8gVzDTsv6H4cjts0QBgiAOqfxEtVy8/ZhkNb1AzBwoaioxO2X19OkFPByeQROGW/sBKKOsSziVkolDd8mFmrEg9Phr0qIDuwsI/Yrs1MC5tMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529763; c=relaxed/simple;
	bh=cjQbjk5ezEJaU3F59PPuo7K+PZD62VrFezcBRrbwrcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MnQdZ/oMhYigBZ4EZU6MBTACZBJyYlrwOIVpoMzWUxW4Z/CVjS+TCaxHl5ro+q3TcVTkaOzFCAWxk9NwfdXUAL1wwL+PxFdL3KCFRpUNh3Wcs5oIqx+gb0EQKSB1IbfgY7K1XgOBAtoY/6iW/vy3vKQaS7iwLs4wP8TYgLTLRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yNntqYzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADofN0lR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yNntqYzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADofN0lR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 10BCC138146A
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1746529760; x=1746616160; bh=ukJjLHk9du
	dSulybo2SG3j39gVKcZoi0bx7JlnxAx/M=; b=yNntqYzhXfE8AoVDSup0VPzgDE
	Vu+GGtSkN4fVxLIe/amIWEsganc2zAWRChFWHNf+20NsKRwLFB+bR9NNcaBJ5KPr
	BbuenLW2l9ZsNXJbjAokyXO2mgnz6EmZ/VSfa5bWrkHxcyhd9KNLlSMdZx2hz6QU
	CLUPJmOVdrst7XTCDu9lmipeBPHSxzCTJGhS/RS1Q9wMBKtUrtJIi0VZnsSxN4pc
	phJm1nSG6bMVDoeZTbrXGQsD5H8DE37S8t7tAtChNJSV4yvIvT82G/PIekak6e5C
	dUKOPrXAKEYlw9MU2zcYJvTW/ywA1NajYT/vWZrEal6hZYIBm1n/zglRwtWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746529760; x=1746616160; bh=ukJjLHk9dudSulybo2SG3j39gVKc
	Zoi0bx7JlnxAx/M=; b=ADofN0lRoBCPM1dVKTDkz5vqKnZlm5Ox5bcKHuGpCuQa
	BIzLHudHgzc2ppRUIPsCUp4yTSh44s574qr8V1IJsjzSSSlok82x+0R1527aizX1
	Xkyp54/IaVFfnzvueDv2Z60+4CeAamMplZvpgQX17fztox9QMhFzQ3055YcN44Pq
	Z4Dh43/R4nFoUN7+S8QYjb/HN7ExkERkCDqqtEnHEC1emJXD0UGPi+fDuWW4FKA4
	chWaBOPW4BhRXjJEoqjb+qShzBKc0/js8beHtQtt0hW4rN7OgqmIohhLEFEKLKiv
	PMOcEKK1tErHgwzFgM7ihJ6OrqyJwdaSvaH15gQyiA==
X-ME-Sender: <xms:3-0ZaJBjilkKBXJADB-p3jf_LRHVk9cWAth9bz04AxX_AQSfeWX9GA>
    <xme:3-0ZaHjgFWZYth_JhjO53SaM3P2I9TFl-jAARmnjoFlrvW61R1pJqB3gyECJxa0Lk
    cpqH5TW1JDBa8Ng6w>
X-ME-Received: <xmr:3-0ZaEm7_BSXh3aNTmh0voA-kCodQ986cCLqZlf3vid52u_Lfq4_TKCArzmB2zLD_hv9sN57DKzJ4pbuh8qneC5avyfG6I-vhtaWnPSv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektd
    etieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3-0ZaDzADjpSXHHt9ebWoaz1RHTpsbtr-LxmpzjYvHB-qtdRrsQKdA>
    <xmx:3-0ZaOSFkXSQ92NFgDU4WSBl8gszTyMbGzNov54srBelnnq5fIxtLg>
    <xmx:3-0ZaGZ2Vwe5Y3BniroiKcCm63JbnBuui72Gfvx3Io-526YiZqx-oA>
    <xmx:3-0ZaPSeQsEdnext8KyTkcnoXJVPgwHoFQzWghvrqTQt11cFd245tw>
    <xmx:4O0ZaP9nhJOGO5NY_IB5vobZCTLIpW3Ld9b3DFME_YCu7StTn_IdhotB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6de26ae8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/17] object-store: carve out the object database
 subsystem
Date: Tue, 06 May 2025 13:09:13 +0200
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANntGWgC/x2NQQqDQAxFryJZN6DSltarSBfOTKxpwQzJoBXx7
 obyVu8t/t/BSJkMumoHpYWNZXZpLhXEaZjfhJzcoa3bW+1g/hpK+FAsaEWUcBUsE6FSFmMvGz7
 jPYY0PtI1NOBDWWnk3/+kfx3HCTR0Udp0AAAA
X-Change-ID: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1
To: git@vger.kernel.org
Cc: 
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

Thanks!

Patrick

-- >8 --

diff --cc builtin/pack-objects.c
index e88a13dbb9f,2936a08e130..00000000000
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@@ -4063,9 -4318,10 +4320,10 @@@ static void add_objects_in_unpacked_pac
  }
  
  static int add_loose_object(const struct object_id *oid, const char *path,
- 			    void *data UNUSED)
+ 			    void *data)
  {
+ 	struct rev_info *revs = data;
 -	enum object_type type = oid_object_info(the_repository, oid, NULL);
 +	enum object_type type = odb_read_object_info(the_repository->objects, oid, NULL);
  
  	if (type < 0) {
  		warning(_("loose object at %s could not be examined"), path);
diff --cc odb.h
index 03f269c4e82,af0b3d856f5..00000000000
--- a/odb.h
+++ b/odb.h
@@@ -338,25 -258,10 +338,28 @@@ struct object_info 
  /* Die if object corruption (not just an object being missing) was detected. */
  #define OBJECT_INFO_DIE_IF_CORRUPT 32
  
 -int oid_object_info_extended(struct repository *r,
 -			     const struct object_id *,
 -			     struct object_info *, unsigned flags);
 +/*
 + * Read object info from the object database and populate the `object_info`
 + * structure. Returns 0 on success, a negative error code otherwise.
 + */
 +int odb_read_object_info_extended(struct object_database *odb,
 +				  const struct object_id *oid,
 +				  struct object_info *oi,
 +				  unsigned flags);
 +
 +/*
 + * Read a subset of object info for the given object ID. Returns an `enum
 + * object_type` on success, a negative error code otherwise. If successful and
 + * `sizep` is non-NULL, then the size of the object will be written to the
 + * pointer.
 + */
 +int odb_read_object_info(struct object_database *odb,
 +			 const struct object_id *oid,
 +			 unsigned long *sizep);
 +
++/* Free pointers inside of object_info, but not object_info itself */
++void free_object_info_contents(struct object_info *object_info);
+ 
  enum {
  	/* Retry packed storage after checking packed and loose storage */
  	HAS_OBJECT_RECHECK_PACKED = (1 << 0),
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 1b2c6c4d27c..6c2abb78055 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -4,7 +4,7 @@
 #include "pkt-line.h"
 #include "connect.h"
 #include "oid-array.h"
-#include "object-store.h"
+#include "odb.h"
 #include "fetch-object-info.h"
 #include "string-list.h"
 
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 7910d7f1532..d35284bd6bc 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -3,7 +3,7 @@
 
 #include "pkt-line.h"
 #include "protocol.h"
-#include "object-store.h"
+#include "odb.h"
 
 struct object_info_args {
 	struct string_list *object_info_options;
diff --git a/transport.h b/transport.h
index 5a4f27451ae..3ef3acf8650 100644
--- a/transport.h
+++ b/transport.h
@@ -5,7 +5,7 @@
 #include "remote.h"
 #include "list-objects-filter-options.h"
 #include "string-list.h"
-#include "object-store.h"
+#include "odb.h"
 
 struct git_transport_options {
 	unsigned thin : 1;

---
Patrick Steinhardt (17):
      object-store: rename `raw_object_store` to `object_database`
      object-store: rename `object_directory` to `odb_backend`
      object-store: rename files to "odb.{c,h}"
      odb: introduce parent pointers
      odb: get rid of `the_repository` in `find_odb()`
      odb: get rid of `the_repository` in `assert_oid_type()`
      odb: get rid of `the_repository` in `assert_oid_type()`
      odb: get rid of `the_repository` when handling alternates
      odb: get rid of `the_repository`  in `for_each()` functions
      odb: get rid of `the_repository` when handling the primary backend
      odb: get rid of `the_repository` when handling submodule backends
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
 builtin/cat-file.c                      |  62 +++--
 builtin/checkout.c                      |   2 +-
 builtin/clone.c                         |  14 +-
 builtin/commit-graph.c                  |  20 +-
 builtin/commit-tree.c                   |   4 +-
 builtin/count-objects.c                 |   4 +-
 builtin/describe.c                      |   5 +-
 builtin/difftool.c                      |   4 +-
 builtin/fast-export.c                   |  10 +-
 builtin/fast-import.c                   |  49 ++--
 builtin/fetch.c                         |  21 +-
 builtin/fsck.c                          |  31 +--
 builtin/gc.c                            |  16 +-
 builtin/grep.c                          |  26 +--
 builtin/hash-object.c                   |   2 +-
 builtin/index-pack.c                    |  29 +--
 builtin/log.c                           |   4 +-
 builtin/ls-files.c                      |   4 +-
 builtin/ls-tree.c                       |   6 +-
 builtin/merge-file.c                    |   2 +-
 builtin/merge-tree.c                    |  14 +-
 builtin/mktag.c                         |   6 +-
 builtin/mktree.c                        |  10 +-
 builtin/multi-pack-index.c              |   6 +-
 builtin/notes.c                         |   8 +-
 builtin/pack-objects.c                  |  70 +++---
 builtin/pack-redundant.c                |   2 +-
 builtin/prune.c                         |   6 +-
 builtin/receive-pack.c                  |   9 +-
 builtin/remote.c                        |   6 +-
 builtin/repack.c                        |   7 +-
 builtin/replace.c                       |  12 +-
 builtin/rev-list.c                      |   8 +-
 builtin/show-ref.c                      |   6 +-
 builtin/submodule--helper.c             |   7 +-
 builtin/tag.c                           |  10 +-
 builtin/unpack-file.c                   |   4 +-
 builtin/unpack-objects.c                |  12 +-
 bulk-checkin.c                          |   6 +-
 bundle-uri.c                            |   5 +-
 bundle.c                                |   6 +-
 cache-tree.c                            |  17 +-
 combine-diff.c                          |   4 +-
 commit-graph.c                          |  56 ++---
 commit-graph.h                          |  20 +-
 commit.c                                |  15 +-
 config.c                                |   4 +-
 connected.c                             |   2 +-
 contrib/coccinelle/the_repository.cocci |   2 +-
 diagnose.c                              |   8 +-
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
 loose.c                                 |  24 +-
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
 object-file.c                           |  60 ++---
 object-file.h                           |  12 +-
 object-name.c                           |  24 +-
 object.c                                |   8 +-
 object-store.c => odb.c                 | 395 +++++++++++++++++---------------
 object-store.h => odb.h                 | 271 ++++++++++++++++------
 oss-fuzz/fuzz-pack-idx.c                |   2 +-
 pack-bitmap-write.c                     |   9 +-
 pack-bitmap.c                           |  10 +-
 pack-check.c                            |   2 +-
 pack-mtimes.c                           |   2 +-
 pack-objects.h                          |   2 +-
 pack-revindex.c                         |   2 +-
 pack-write.c                            |  10 +-
 packfile.c                              |  29 +--
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
 tmp-objdir.c                            |  18 +-
 tree-walk.c                             |  18 +-
 tree.c                                  |   6 +-
 unpack-trees.c                          |   2 +-
 upload-pack.c                           |   4 +-
 walker.c                                |   6 +-
 xdiff-interface.c                       |   4 +-
 139 files changed, 1104 insertions(+), 961 deletions(-)


---
base-commit: 046efb6f2b050efd580e1c1750b77328a1790c0e
change-id: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1

