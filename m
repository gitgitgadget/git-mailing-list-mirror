Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3206C295509
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799938; cv=none; b=BZJYVOP2b4iKhxWMF/vrYVrCpZofQXjkr+i+Lcnym1L/6jHSF+Kv5iHtZM+EXoCd4PZiAQ6HkherF7Q0PhaFOwYUQtnYwRJPaZ7cchEAD9kSsO0MlE0IWqZ7Htpghx515wES8TkNUOdw2ukdlXHA6hkHjKW0QlL2A3EsG7JH9LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799938; c=relaxed/simple;
	bh=iPkH17chBkNm6Bvr6UpI29D5/PPrPf1tP6ZVmk/gvdE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Pp2hIGsBEa7meW1v35gmetEfSv++m/loBBj0Mr1qKbrAgzCQ8l//hsYCZ9cIarslrgRDouwXX+msMdDZpoCq8cKwz8Ki7jjxb6+bZ8AVIWfmNu9F1RsIltpA4JeRyzXXPHFe0ri97FaRIcGJTPzRf/ZIFVvhY8KD+RUvOfUljJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rpM2ffSZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qmcjkfwq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rpM2ffSZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmcjkfwq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 275D4114016B;
	Fri,  9 May 2025 10:12:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 10:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799934;
	 x=1746886334; bh=IcY8Xzz80nUc61TxJhPEkD+6eCAZP4wMDdHW/AIT2xY=; b=
	rpM2ffSZFPDdCRNDRvtH9b0N/suJ6/k5N9pwTS4EQWhn809mIdXDuRu2oTdX4tvP
	ZclToGktLMi7hhzUhqIQPcnGSgSd/QjjZldoSgQBA6ZXCjyq0VjDzDzKEtA3oakn
	jYnyKJwuSrghYRYb/eEcRHvPX1q0T3yfBXcdsq99++QHxCqaNtNQL24f61TWAK2S
	CrgmcFSUXuf8Zy0AYTd8xzWceMk5OElF5JzJL1m496TdoqP/jeilPQaEjDhWNGbu
	lqovb1USH3GeC9c6vEUs6c4y9bbGLS82r+L0VYLhJRen4SlsgiXfX2NhqTaAz+fd
	yuErRt0/7jxFtN1Z3zyFiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799934; x=
	1746886334; bh=IcY8Xzz80nUc61TxJhPEkD+6eCAZP4wMDdHW/AIT2xY=; b=q
	mcjkfwq0e84MyNmWMqlhiJBX6z8NkGHx9iJl2anmMtTLPhitR8gmdeKV3cre2d5i
	0bgDxlCulE4EJ+UaVys2xHX60slHPRSjUZTX5n125aUYSkYr3wX2VJkOP07Td6SG
	7SufxC1HAayvBxeS3OZzINOdZV/K/gVV/My7FALn+ky1u8j9lUqU/6hQzEDGIgGl
	kI4JkM+1Hf9mSSlQ2UVQYbyIUi+C0yHua8hzlXyoAtXVsPs5vvnbdxvEXn2jVn2Z
	DQ84Ru9hHuRzdrTAkhIeUFBBumq+GyWFNFS66VSZXDu4nhY2dGLh91vZfla19DOt
	cPvEgcgUxb9+oAQz4yENQ==
X-ME-Sender: <xms:PQ0eaDWygwYF2TjejD6XgMKBP60xcbyTTCiCK4IGV5ts5rCsBLMZcQ>
    <xme:PQ0eaLmaAJ8OytYOd45442ZmxiZL4N9yTlr7qZGNvAc6FobM0qeZHZjNScEuuVcyZ
    yympGurVxQRJ7yhQw>
X-ME-Received: <xmr:PQ0eaPZuMEasVTzvlRqm4RZndznhkk9Qdk1k6uC4waVjJVXePJG5Ta6NhkFcErT8hScnErQ71oyhp0UFuRDCMjy_28OTz4deseA9No0NaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PQ0eaOWu-0m8KFPuAJNt0IEeLxZV-rX7ahiVpWxnZ1uqMOU2rlGA7Q>
    <xmx:PQ0eaNn5qqzL7iVWOxot0WyiQKe9SFZkMgTMPItTN0VS_JdLCk6aJQ>
    <xmx:PQ0eaLfzNyQhclOgB61HfJydnM0zvjwtmkqjV6c_zsKrRbp7h_9vJA>
    <xmx:PQ0eaHHAGoJYp9ONNAYT-XWpg3URPZ3n5zA6HJpkEpHzIxQzTbkIUw>
    <xmx:PQ0eaLRHOokN4n00FB9TsIU1DGaw_Zp7tmnwKWv68Vp1Dpz4By5zRoup>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2f1db4f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/17] object-store: carve out the object database
 subsystem
Date: Fri, 09 May 2025 16:12:00 +0200
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADENHmgC/42NwQ6CMBBEf4Xs2TVtIxU9+R+Ggy2LrEZKWoIS0
 n93IfFu5vQmmTcLJIpMCc7FApEmThx6AbMrwHe3/k7IjTAYZUolweGZMLgH+RHTGCLhO+DYEUY
 aQmJpZjx5613TVs3BaRDREKnlz3ZyrYU7Xpfz9jnptf3p7T/6SaNCr0pXGTo6bexFRnt+QZ1z/
 gL5H73t0QAAAA==
X-Change-ID: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

Thanks!

Patrick

---
Patrick Steinhardt (17):
      object-store: rename `raw_object_store` to `object_database`
      object-store: rename `object_directory` to `odb_alternate`
      object-store: rename files to "odb.{c,h}"
      odb: introduce parent pointers
      odb: get rid of `the_repository` in `find_odb()`
      odb: get rid of `the_repository` in `assert_oid_type()`
      odb: get rid of `the_repository` in `odb_mkstemp()`
      odb: get rid of `the_repository` when handling alternates
      odb: get rid of `the_repository`  in `for_each()` functions
      odb: get rid of `the_repository` when handling the primary alternate
      odb: get rid of `the_repository` when handling submodule alternates
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
 builtin/count-objects.c                 |   6 +-
 builtin/describe.c                      |   5 +-
 builtin/difftool.c                      |   4 +-
 builtin/fast-export.c                   |  10 +-
 builtin/fast-import.c                   |  49 ++--
 builtin/fetch.c                         |  21 +-
 builtin/fsck.c                          |  31 +--
 builtin/gc.c                            |  16 +-
 builtin/grep.c                          |  26 +-
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
 builtin/submodule--helper.c             |  11 +-
 builtin/tag.c                           |  10 +-
 builtin/unpack-file.c                   |   4 +-
 builtin/unpack-objects.c                |  12 +-
 bulk-checkin.c                          |   6 +-
 bundle-uri.c                            |   5 +-
 bundle.c                                |   6 +-
 cache-tree.c                            |  17 +-
 combine-diff.c                          |   4 +-
 commit-graph.c                          | 106 ++++----
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
 object-file.c                           |  94 ++++----
 object-file.h                           |  12 +-
 object-name.c                           |  24 +-
 object.c                                |   8 +-
 object-store.c => odb.c                 | 413 +++++++++++++++++---------------
 object-store.h => odb.h                 | 269 +++++++++++++++------
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
 tmp-objdir.c                            |  30 +--
 tree-walk.c                             |  18 +-
 tree.c                                  |   6 +-
 unpack-trees.c                          |   2 +-
 upload-pack.c                           |   4 +-
 walker.c                                |   6 +-
 xdiff-interface.c                       |   4 +-
 139 files changed, 1177 insertions(+), 1032 deletions(-)

Range-diff versus v1:

 1:  83f6482bffd =  1:  683857de5d7 object-store: rename `raw_object_store` to `object_database`
 2:  1009722a206 <  -:  ----------- object-store: rename `object_directory` to `odb_backend`
 -:  ----------- >  2:  5b13164e353 object-store: rename `object_directory` to `odb_alternate`
 3:  fd36b863411 =  3:  abd9ecd1589 object-store: rename files to "odb.{c,h}"
 4:  910ef0beb61 !  4:  25e30b9040b odb: introduce parent pointers
    @@ Commit message
     
         In subsequent commits we'll get rid of our use of `the_repository` in
         "odb.c" in favor of explicitly passing in a `struct object_database` or
    -    a `struct odb_backend`. In some cases though we'll need access to the
    +    a `struct odb_alternate`. In some cases though we'll need access to the
         repository, for example to read a config value from it, but we don't
         have a way to access the repository owning a specific object database.
     
         Introduce parent pointers for `struct object_database` to its owning
    -    repository as well as for `struct odb_backend` to its owning object
    +    repository as well as for `struct odb_alternate` to its owning object
         database, which will allow us to adapt those use cases.
     
         Note that this change requires us to pass through the object database to
         `link_alt_odb_entry()` so that we can set up the parent pointers for any
    -    alternative backends there. The callchain is adapted to pass through the
    -    object database accordingly.
    +    alternate there. The callchain is adapted to pass through the object
    +    database accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ odb.c: static int alt_odb_usable(struct object_database *o,
     +			      int depth,
     +			      const char *normalized_objdir)
      {
    - 	struct odb_backend *backend;
    + 	struct odb_alternate *alternate;
      	struct strbuf pathbuf = STRBUF_INIT;
     @@ odb.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
      	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
    @@ odb.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *
     +	if (!alt_odb_usable(odb, &pathbuf, normalized_objdir, &pos))
      		goto error;
      
    - 	CALLOC_ARRAY(backend, 1);
    -+	backend->odb = odb;
    - 	/* pathbuf.buf is already in r->objects->backend_by_path */
    - 	backend->path = strbuf_detach(&pathbuf, NULL);
    + 	CALLOC_ARRAY(alternate, 1);
    ++	alternate->odb = odb;
    + 	/* pathbuf.buf is already in r->objects->alternate_by_path */
    + 	alternate->path = strbuf_detach(&pathbuf, NULL);
      
      	/* add the alternate entry */
    --	*r->objects->backends_tail = backend;
    --	r->objects->backends_tail = &(backend->next);
    -+	*odb->backends_tail = backend;
    -+	odb->backends_tail = &(backend->next);
    - 	backend->next = NULL;
    --	assert(r->objects->backend_by_path);
    --	kh_value(r->objects->backend_by_path, pos) = backend;
    -+	assert(odb->backend_by_path);
    -+	kh_value(odb->backend_by_path, pos) = backend;
    +-	*r->objects->alternates_tail = alternate;
    +-	r->objects->alternates_tail = &(alternate->next);
    ++	*odb->alternates_tail = alternate;
    ++	odb->alternates_tail = &(alternate->next);
    + 	alternate->next = NULL;
    +-	assert(r->objects->alternate_by_path);
    +-	kh_value(r->objects->alternate_by_path, pos) = alternate;
    ++	assert(odb->alternate_by_path);
    ++	kh_value(odb->alternate_by_path, pos) = alternate;
      
      	/* recursively add alternates */
    --	read_info_alternates(r, backend->path, depth + 1);
    -+	read_info_alternates(odb, backend->path, depth + 1);
    +-	read_info_alternates(r, alternate->path, depth + 1);
    ++	read_info_alternates(odb, alternate->path, depth + 1);
      	ret = 0;
       error:
      	strbuf_release(&tmp);
    @@ odb.c: static void link_alt_odb_entries(struct repository *r, const char *alt,
      		return;
      	}
      
    --	strbuf_realpath(&objdirbuf, r->objects->backends->path, 1);
    -+	strbuf_realpath(&objdirbuf, odb->backends->path, 1);
    +-	strbuf_realpath(&objdirbuf, r->objects->alternates->path, 1);
    ++	strbuf_realpath(&objdirbuf, odb->alternates->path, 1);
      
      	while (*alt) {
      		alt = parse_alt_odb_entry(alt, sep, &entry);
    @@ odb.c: void add_to_alternates_memory(const char *reference)
      			     '\n', NULL, 0);
      }
      
    -@@ odb.c: struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
    +@@ odb.c: struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destro
      	 * alternate
      	 */
    - 	backend = xcalloc(1, sizeof(*backend));
    -+	backend->odb = the_repository->objects;
    - 	backend->path = xstrdup(dir);
    + 	alternate = xcalloc(1, sizeof(*alternate));
    ++	alternate->odb = the_repository->objects;
    + 	alternate->path = xstrdup(dir);
      
      	/*
     @@ odb.c: void prepare_alt_odb(struct repository *r)
    @@ odb.c: void prepare_alt_odb(struct repository *r)
     -	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
     +	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
      
    --	read_info_alternates(r, r->objects->backends->path, 0);
    -+	read_info_alternates(r->objects, r->objects->backends->path, 0);
    +-	read_info_alternates(r, r->objects->alternates->path, 0);
    ++	read_info_alternates(r->objects, r->objects->alternates->path, 0);
      	r->objects->loaded_alternates = 1;
      }
      
    -@@ odb.c: struct object_database *odb_new(struct repository *repo)
    +@@ odb.c: void assert_oid_type(const struct object_id *oid, enum object_type expect)
    + 		    type_name(expect));
    + }
    + 
    +-struct object_database *odb_new(void)
    ++struct object_database *odb_new(struct repository *repo)
    + {
      	struct object_database *o = xmalloc(sizeof(*o));
      
      	memset(o, 0, sizeof(*o));
    @@ odb.c: struct object_database *odb_new(struct repository *repo)
     
      ## odb.h ##
     @@ odb.h: struct repository;
    - struct odb_backend {
    - 	struct odb_backend *next;
    + struct odb_alternate {
    + 	struct odb_alternate *next;
      
    -+	/* Object database that owns this backend. */
    ++	/* Object database that owns this alternate. */
     +	struct object_database *odb;
     +
      	/*
    @@ odb.h: struct cached_object_entry;
      	/*
      	 * Set of all object directories; the main directory is first (and
      	 * cannot be NULL after initialization). Subsequent directories are
    +@@ odb.h: struct object_database {
    + 	unsigned packed_git_initialized : 1;
    + };
    + 
    +-struct object_database *odb_new(void);
    ++struct object_database *odb_new(struct repository *repo);
    + void odb_clear(struct object_database *o);
    + 
    + /*
    +
    + ## repository.c ##
    +@@ repository.c: static void set_default_hash_algo(struct repository *repo)
    + 
    + void initialize_repository(struct repository *repo)
    + {
    +-	repo->objects = odb_new();
    ++	repo->objects = odb_new(repo);
    + 	repo->remote_state = remote_state_new();
    + 	repo->parsed_objects = parsed_object_pool_new(repo);
    + 	ALLOC_ARRAY(repo->index, 1);
    +@@ repository.c: void repo_set_gitdir(struct repository *repo,
    + 
    + 	if (!repo->objects->alternates) {
    + 		CALLOC_ARRAY(repo->objects->alternates, 1);
    ++		repo->objects->alternates->odb = repo->objects;
    + 		repo->objects->alternates_tail = &repo->objects->alternates->next;
    + 	}
    + 	expand_base_dir(&repo->objects->alternates->path, o->object_dir,
 5:  a045ad2f30e <  -:  ----------- odb: get rid of `the_repository` in `find_odb()`
 -:  ----------- >  5:  b642cc5bb8b odb: get rid of `the_repository` in `find_odb()`
 6:  e408fb9a963 =  6:  188240381ce odb: get rid of `the_repository` in `assert_oid_type()`
 7:  f2da8b8d507 !  7:  61a27202f3e odb: get rid of `the_repository` in `assert_oid_type()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    odb: get rid of `the_repository` in `assert_oid_type()`
    +    odb: get rid of `the_repository` in `odb_mkstemp()`
     
    -    Get rid of our dependency on `the_repository` in `assert_oid_type()` by
    +    Get rid of our dependency on `the_repository` in `odb_mkstemp()` by
         passing in the object database as a parameter and adjusting all callers.
     
    -    Rename the function to `odb_assert_oid_type()`.
    -
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/fast-import.c ##
    @@ odb.c: int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
     
      ## odb.h ##
     @@ odb.h: void odb_clear(struct object_database *o);
    - struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir);
    + struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
      
      /*
     - * Create a temporary file rooted in the object database directory, or
     - * die on failure. The filename is taken from "pattern", which should have the
    -- * usual "XXXXXX" trailer, and the resulting filename is written into the
    -- * "template" buffer. Returns the open descriptor.
    -+ * Create a temporary file rooted in the primary object database backend's
    -+ * directory, or die on failure. The filename is taken from "pattern", which
    -+ * should have the usual "XXXXXX" trailer, and the resulting filename is
    -+ * written into the "template" buffer. Returns the open descriptor.
    ++ * Create a temporary file rooted in the primary alternate's directory, or die
    ++ * on failure. The filename is taken from "pattern", which should have the
    +  * usual "XXXXXX" trailer, and the resulting filename is written into the
    +  * "template" buffer. Returns the open descriptor.
       */
     -int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
     +int odb_mkstemp(struct object_database *odb,
 8:  852ff66ec5e !  8:  8b6801ea2dd odb: get rid of `the_repository` when handling alternates
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      	} else {
     -		prepare_alt_odb(the_repository);
     +		odb_prepare_alternates(the_repository->objects);
    - 		for (backend = the_repository->objects->backends; backend; backend = backend->next)
    - 			fsck_object_dir(backend->path);
    + 		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next)
    + 			fsck_object_dir(alternate->path);
      
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      	if (the_repository->settings.core_commit_graph) {
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      
     -		prepare_alt_odb(the_repository);
     +		odb_prepare_alternates(the_repository->objects);
    - 		for (backend = the_repository->objects->backends; backend; backend = backend->next) {
    + 		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
      			child_process_init(&commit_graph_verify);
      			commit_graph_verify.git_cmd = 1;
     @@ builtin/fsck.c: int cmd_fsck(int argc,
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      
     -		prepare_alt_odb(the_repository);
     +		odb_prepare_alternates(the_repository->objects);
    - 		for (backend = the_repository->objects->backends; backend; backend = backend->next) {
    + 		for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
      			child_process_init(&midx_verify);
      			midx_verify.git_cmd = 1;
     
    @@ commit-graph.c: struct commit_graph *load_commit_graph_chain_fd_st(struct reposi
     +	odb_prepare_alternates(r->objects);
      
      	for (i = 0; i < count; i++) {
    - 		struct odb_backend *backend;
    + 		struct odb_alternate *alternate;
     @@ commit-graph.c: static int prepare_commit_graph(struct repository *r)
      	if (!commit_graph_compatible(r))
      		return 0;
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (backend = r->objects->backends;
    - 	     !r->objects->commit_graph && backend;
    - 	     backend = backend->next)
    + 	for (alternate = r->objects->alternates;
    + 	     !r->objects->commit_graph && alternate;
    + 	     alternate = alternate->next)
     
      ## loose.c ##
     @@ loose.c: int repo_read_loose_object_map(struct repository *repo)
    @@ loose.c: int repo_read_loose_object_map(struct repository *repo)
     -	prepare_alt_odb(repo);
     +	odb_prepare_alternates(repo->objects);
      
    - 	for (backend = repo->objects->backends; backend; backend = backend->next) {
    - 		if (load_one_loose_object_map(repo, backend) < 0) {
    + 	for (alternate = repo->objects->alternates; alternate; alternate = alternate->next) {
    + 		if (load_one_loose_object_map(repo, alternate) < 0) {
     
      ## object-file.c ##
     @@ object-file.c: static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
      {
    - 	struct odb_backend *backend;
    + 	struct odb_alternate *alternate;
      
     -	prepare_alt_odb(the_repository);
     +	odb_prepare_alternates(the_repository->objects);
    - 	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
    - 		if (check_and_freshen_odb(backend, oid, freshen))
    + 	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    + 		if (check_and_freshen_odb(alternate, oid, freshen))
      			return 1;
     @@ object-file.c: static int stat_loose_object(struct repository *r, const struct object_id *oid,
    - 	struct odb_backend *backend;
    + 	struct odb_alternate *alternate;
      	static struct strbuf buf = STRBUF_INIT;
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (backend = r->objects->backends; backend; backend = backend->next) {
    - 		*path = odb_loose_path(backend, &buf, oid);
    + 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    + 		*path = odb_loose_path(alternate, &buf, oid);
      		if (!lstat(*path, st))
     @@ object-file.c: static int open_loose_object(struct repository *r,
      	int most_interesting_errno = ENOENT;
    @@ object-file.c: static int open_loose_object(struct repository *r,
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (backend = r->objects->backends; backend; backend = backend->next) {
    - 		*path = odb_loose_path(backend, &buf, oid);
    + 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    + 		*path = odb_loose_path(alternate, &buf, oid);
      		fd = git_open(*path);
     @@ object-file.c: static int quick_has_loose(struct repository *r,
      {
    - 	struct odb_backend *backend;
    + 	struct odb_alternate *alternate;
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (backend = r->objects->backends; backend; backend = backend->next) {
    - 		if (oidtree_contains(odb_loose_cache(backend, oid), oid))
    + 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    + 		if (oidtree_contains(odb_loose_cache(alternate, oid), oid))
      			return 1;
     @@ object-file.c: int for_each_loose_object(each_loose_object_fn cb, void *data,
      {
    - 	struct odb_backend *backend;
    + 	struct odb_alternate *alternate;
      
     -	prepare_alt_odb(the_repository);
     +	odb_prepare_alternates(the_repository->objects);
    - 	for (backend = the_repository->objects->backends; backend; backend = backend->next) {
    - 		int r = for_each_loose_file_in_objdir(backend->path, cb, NULL,
    + 	for (alternate = the_repository->objects->alternates; alternate; alternate = alternate->next) {
    + 		int r = for_each_loose_file_in_objdir(alternate->path, cb, NULL,
      						      NULL, data);
     
      ## object-name.c ##
    @@ odb.c: void add_to_alternates_file(const char *reference)
      			     '\n', NULL, 0);
      }
      
    -@@ odb.c: struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
    +@@ odb.c: struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destro
      	 * Make sure alternates are initialized, or else our entry may be
      	 * overwritten when they are.
      	 */
    @@ odb.c: struct odb_backend *set_temporary_primary_odb(const char *dir, int will_d
      
      	/*
      	 * Make a new primary odb and link the old primary ODB in as an
    -@@ odb.c: void restore_primary_odb(struct odb_backend *restore_odb, const char *old_path)
    - 	free_object_directory(cur_odb);
    +@@ odb.c: void restore_primary_odb(struct odb_alternate *restore_alt, const char *old_path
    + 	free_object_directory(cur_alt);
      }
      
     -/*
    @@ odb.c: void restore_primary_odb(struct odb_backend *restore_odb, const char *old
      char *compute_alternate_path(const char *path, struct strbuf *err)
      {
      	char *ref_git = NULL;
    -@@ odb.c: struct odb_backend *odb_find_backend(struct object_database *odb, const char *ob
    +@@ odb.c: struct odb_alternate *odb_find_alternate(struct object_database *odb, const char
      	char *obj_dir_real = real_pathdup(obj_dir, 1);
      	struct strbuf odb_path_real = STRBUF_INIT;
      
     -	prepare_alt_odb(odb->repo);
     +	odb_prepare_alternates(odb);
    - 	for (backend = odb->backends; backend; backend = backend->next) {
    - 		strbuf_realpath(&odb_path_real, backend->path, 1);
    + 	for (alternate = odb->alternates; alternate; alternate = alternate->next) {
    + 		strbuf_realpath(&odb_path_real, alternate->path, 1);
      		if (!strcmp(obj_dir_real, odb_path_real.buf))
     @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
    - 	struct odb_backend *backend;
    + 	struct odb_alternate *alternate;
      	int r = 0;
      
     -	prepare_alt_odb(the_repository);
     +	odb_prepare_alternates(the_repository->objects);
    - 	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
    - 		r = fn(backend, cb);
    + 	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    + 		r = fn(alternate, cb);
      		if (r)
     @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
      	return r;
    @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
     -	link_alt_odb_entries(r->objects, r->objects->alternate_db, PATH_SEP, NULL, 0);
     +	link_alt_odb_entries(odb, odb->alternate_db, PATH_SEP, NULL, 0);
      
    --	read_info_alternates(r->objects, r->objects->backends->path, 0);
    +-	read_info_alternates(r->objects, r->objects->alternates->path, 0);
     -	r->objects->loaded_alternates = 1;
    -+	read_info_alternates(odb, odb->backends->path, 0);
    ++	read_info_alternates(odb, odb->alternates->path, 0);
     +	odb->loaded_alternates = 1;
      }
      
    @@ odb.c: int foreach_alt_odb(alt_odb_fn fn, void *cb)
     +int odb_has_alternates(struct object_database *odb)
      {
     -	prepare_alt_odb(r);
    --	return !!r->objects->backends->next;
    +-	return !!r->objects->alternates->next;
     +	odb_prepare_alternates(odb);
    -+	return !!odb->backends->next;
    ++	return !!odb->alternates->next;
      }
      
      int obj_read_use_lock = 0;
    @@ odb.h: struct oidtree;
     + */
     +char *compute_alternate_path(const char *path, struct strbuf *err);
     +
    - /* The backend used to access objects in a specific object directory. */
    - struct odb_backend {
    - 	struct odb_backend *next;
    -@@ odb.h: struct odb_backend {
    + /*
    +  * An alternate part of an object database that stores the actual objects.
    +  */
    +@@ odb.h: struct odb_alternate {
      	char *path;
      };
      
     -void prepare_alt_odb(struct repository *r);
     -int has_alt_odb(struct repository *r);
     -char *compute_alternate_path(const char *path, struct strbuf *err);
    - typedef int alt_odb_fn(struct odb_backend *, void *);
    + typedef int alt_odb_fn(struct odb_alternate *, void *);
      int foreach_alt_odb(alt_odb_fn, void*);
      typedef void alternate_ref_fn(const struct object_id *oid, void *);
      void for_each_alternate_ref(alternate_ref_fn, void *);
    @@ odb.h: struct object_database {
      	/*
      	 * A list of alternate object directories loaded from the environment;
      	 * this should not generally need to be accessed directly, but will
    --	 * populate the "backends" list when prepare_alt_odb() is run.
    -+	 * populate the "backends" list when odb_prepare_alternates() is run.
    +-	 * populate the "alternates" list when prepare_alt_odb() is run.
    ++	 * populate the "alternates" list when odb_prepare_alternates() is run.
      	 */
      	char *alternate_db;
      
    -@@ odb.h: struct odb_backend *odb_find_backend(struct object_database *odb, const char *ob
    +@@ odb.h: struct odb_alternate *odb_find_alternate(struct object_database *odb, const char
      int odb_mkstemp(struct object_database *odb,
      		struct strbuf *temp_filename, const char *pattern);
      
     +/*
     + * Prepare alternate object backends for the given database by reading
    -+ * "objects/info/alternates" and opening the respective backends.
    ++ * "objects/info/alternates" and opening the respective alternates.
     + */
     +void odb_prepare_alternates(struct object_database *odb);
     +
     +/*
    -+ * Check whether the object database has any alternate backends. The primary
    -+ * object backend does not count as alternate.
    ++ * Check whether the object database has any alternates. The primary object
    ++ * backend does not count as alternate.
     + */
     +int odb_has_alternates(struct object_database *odb);
     +
    @@ packfile.c: static void prepare_packed_git(struct repository *r)
      
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
    - 	for (backend = r->objects->backends; backend; backend = backend->next) {
    - 		int local = (backend == r->objects->backends);
    - 		prepare_multi_pack_index_one(r, backend->path, local);
    + 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next) {
    + 		int local = (alternate == r->objects->alternates);
    + 		prepare_multi_pack_index_one(r, alternate->path, local);
     @@ packfile.c: void reprepare_packed_git(struct repository *r)
      	 * the lifetime of the process.
      	 */
    @@ packfile.c: void reprepare_packed_git(struct repository *r)
     -	prepare_alt_odb(r);
     +	odb_prepare_alternates(r->objects);
      
    - 	for (backend = r->objects->backends; backend; backend = backend->next)
    - 		odb_clear_loose_cache(backend);
    + 	for (alternate = r->objects->alternates; alternate; alternate = alternate->next)
    + 		odb_clear_loose_cache(alternate);
     
      ## submodule.c ##
     @@ submodule.c: int register_all_submodule_odb_as_alternates(void)
 9:  00c4884c796 !  9:  cfaf09542ca odb: get rid of `the_repository`  in `for_each()` functions
    @@ builtin/count-objects.c: int cmd_count_objects(int argc,
      		printf("garbage: %lu\n", garbage);
      		printf("size-garbage: %s\n", garbage_buf.buf);
     -		foreach_alt_odb(print_alternate, NULL);
    -+		odb_for_each_backend(the_repository->objects, print_alternate, NULL);
    ++		odb_for_each_alternate(the_repository->objects, print_alternate, NULL);
      		strbuf_release(&loose_buf);
      		strbuf_release(&pack_buf);
      		strbuf_release(&garbage_buf);
    @@ builtin/submodule--helper.c: static void prepare_possible_alternates(const char
      
      	if (!strcmp(sm_alternate, "superproject"))
     -		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
    -+		odb_for_each_backend(the_repository->objects,
    -+				     add_possible_reference_from_superproject, &sas);
    ++		odb_for_each_alternate(the_repository->objects,
    ++				       add_possible_reference_from_superproject, &sas);
      	else if (!strcmp(sm_alternate, "no"))
      		; /* do nothing */
      	else
    @@ diagnose.c
     @@ diagnose.c: int create_diagnostics_archive(struct repository *r,
      	strbuf_reset(&buf);
      	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
    - 	dir_file_stats(r->objects->backends, &buf);
    + 	dir_file_stats(r->objects->alternates, &buf);
     -	foreach_alt_odb(dir_file_stats, &buf);
    -+	odb_for_each_backend(r->objects, dir_file_stats, &buf);
    ++	odb_for_each_alternate(r->objects, dir_file_stats, &buf);
      	strvec_push(&archiver_args, buf.buf);
      
      	strbuf_reset(&buf);
    @@ odb.c: static void read_alternate_refs(const char *path,
     +	void *payload;
      };
      
    - static int refs_from_alternate_cb(struct odb_backend *e,
    + static int refs_from_alternate_cb(struct odb_alternate *alternate,
     -				  void *data)
     +				  void *payload)
      {
    @@ odb.c: static void read_alternate_refs(const char *path,
     -	struct alternate_refs_data *cb = data;
     +	struct alternate_refs_data *cb = payload;
      
    - 	if (!strbuf_realpath(&path, e->path, 0))
    + 	if (!strbuf_realpath(&path, alternate->path, 0))
      		goto out;
    -@@ odb.c: static int refs_from_alternate_cb(struct odb_backend *e,
    +@@ odb.c: static int refs_from_alternate_cb(struct odb_alternate *alternate,
      		goto out;
      	strbuf_setlen(&path, base_len);
      
    @@ odb.c: static int refs_from_alternate_cb(struct odb_backend *e,
     +	struct alternate_refs_data data;
     +	data.fn = cb;
     +	data.payload = payload;
    -+	odb_for_each_backend(odb, refs_from_alternate_cb, &data);
    ++	odb_for_each_alternate(odb, refs_from_alternate_cb, &data);
      }
      
     -int foreach_alt_odb(alt_odb_fn fn, void *cb)
    -+int odb_for_each_backend(struct object_database *odb,
    -+			 odb_for_each_backend_fn cb, void *payload)
    ++int odb_for_each_alternate(struct object_database *odb,
    ++			 odb_for_each_alternate_fn cb, void *payload)
      {
    - 	struct odb_backend *backend;
    + 	struct odb_alternate *alternate;
      	int r = 0;
      
     -	odb_prepare_alternates(the_repository->objects);
    --	for (backend = the_repository->objects->backends->next; backend; backend = backend->next) {
    --		r = fn(backend, cb);
    +-	for (alternate = the_repository->objects->alternates->next; alternate; alternate = alternate->next) {
    +-		r = fn(alternate, cb);
     +	odb_prepare_alternates(odb);
    -+	for (backend = odb->backends->next; backend; backend = backend->next) {
    -+		r = cb(backend, payload);
    ++	for (alternate = odb->alternates->next; alternate; alternate = alternate->next) {
    ++		r = cb(alternate, payload);
      		if (r)
      			break;
      	}
     
      ## odb.h ##
    -@@ odb.h: struct odb_backend {
    +@@ odb.h: struct odb_alternate {
      	char *path;
      };
      
    --typedef int alt_odb_fn(struct odb_backend *, void *);
    +-typedef int alt_odb_fn(struct odb_alternate *, void *);
     -int foreach_alt_odb(alt_odb_fn, void*);
     -typedef void alternate_ref_fn(const struct object_id *oid, void *);
     -void for_each_alternate_ref(alternate_ref_fn, void *);
    @@ odb.h: struct odb_backend {
       * object directory; returns the former primary object directory.
     @@ odb.h: void odb_clear(struct object_database *o);
       */
    - struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir);
    + struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
      
     +/*
    -+ * Iterate through all backends of the database and execute the provided
    ++ * Iterate through all alternates of the database and execute the provided
     + * callback function for each of them. Stop iterating once the callback
     + * function returns a non-zero value, in which case the value is bubbled up
     + * from the callback.
     + */
    -+typedef int odb_for_each_backend_fn(struct odb_backend *, void *);
    -+int odb_for_each_backend(struct object_database *odb,
    -+			 odb_for_each_backend_fn cb, void *payload);
    ++typedef int odb_for_each_alternate_fn(struct odb_alternate *, void *);
    ++int odb_for_each_alternate(struct object_database *odb,
    ++			   odb_for_each_alternate_fn cb, void *payload);
     +
     +/*
    -+ * Iterate through all alternative object backends of the database and yield
    -+ * their respective references.
    ++ * Iterate through all alternates of the database and yield their respective
    ++ * references.
     + */
     +typedef void odb_for_each_alternate_ref_fn(const struct object_id *oid, void *);
     +void odb_for_each_alternate_ref(struct object_database *odb,
     +				odb_for_each_alternate_ref_fn cb, void *payload);
     +
      /*
    -  * Create a temporary file rooted in the primary object database backend's
    -  * directory, or die on failure. The filename is taken from "pattern", which
    +  * Create a temporary file rooted in the primary alternate's directory, or die
    +  * on failure. The filename is taken from "pattern", which should have the
     
      ## revision.c ##
     @@ revision.c: static void add_alternate_refs_to_pending(struct rev_info *revs,
10:  758255fd936 <  -:  ----------- odb: get rid of `the_repository` when handling the primary backend
 -:  ----------- > 10:  bc8c73b140d odb: get rid of `the_repository` when handling the primary alternate
11:  d07a78aa858 ! 11:  b0fb9566ae1 odb: get rid of `the_repository` when handling submodule backends
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    odb: get rid of `the_repository` when handling submodule backends
    +    odb: get rid of `the_repository` when handling submodule alternates
     
         The "--recursive" flag for git-grep(1) allows users to grep for a string
         across submodule boundaries. To make this work we add each submodule's
    -    object backend to our own object database so that the objects can be
    +    object alternate to our own object database so that the objects can be
         accessed directly.
     
         The infrastructure for this depends on a global string list of submodule
         paths. The caller is expected to call `add_submodule_odb_by_path()` for
    -    each backend and the object database will then eventually register all
    -    submodule backends via `do_oid_object_info_extended()` in case it isn't
    -    able to look up a specific object.
    +    each alternate and the object database will then eventually register all
    +    submodule alternates via `do_oid_object_info_extended()` in case it
    +    isn't able to look up a specific object.
     
         This reliance on global state is of course suboptimal with regards to
         our libification efforts.
     
    -    Refactor the logic so that the list of submodule backends is instead
    +    Refactor the logic so that the list of submodule alternates is instead
         tracked in the object database itself. This allows us to lose the
    -    condition of `r == the_repository` before registering submodule backends
    -    as we only ever add submodule backends to `the_repository` anyway. As
    -    such, behaviour before and after this refactoring should always be the
    -    same.
    +    condition of `r == the_repository` before registering submodule
    +    alternates as we only ever add submodule alternates to `the_repository`
    +    anyway. As such, behaviour before and after this refactoring should
    +    always be the same.
     
         Rename the functions accordingly.
     
    @@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
      	 * lazily registered as alternates when needed (and except in an
      	 * unexpected code interaction, it won't be needed).
      	 */
    --	add_submodule_odb_by_path(subrepo->objects->backends->path);
    -+	odb_add_submodule_backend_by_path(the_repository->objects,
    -+					  subrepo->objects->backends->path);
    +-	add_submodule_odb_by_path(subrepo->objects->alternates->path);
    ++	odb_add_submodule_alternate_by_path(the_repository->objects,
    ++					    subrepo->objects->alternates->path);
      	obj_read_unlock();
      
      	memcpy(&subopt, opt, sizeof(subopt));
    @@ odb.c
      #include "write-or-die.h"
      
      KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
    -@@ odb.c: struct odb_backend *odb_find_backend(struct object_database *odb, const char *ob
    - 	return backend;
    +@@ odb.c: struct odb_alternate *odb_find_alternate(struct object_database *odb, const char
    + 	return alternate;
      }
      
    -+void odb_add_submodule_backend_by_path(struct object_database *odb,
    -+				       const char *path)
    ++void odb_add_submodule_alternate_by_path(struct object_database *odb,
    ++					 const char *path)
     +{
    -+	string_list_insert(&odb->submodule_backend_paths, path);
    ++	string_list_insert(&odb->submodule_alternate_paths, path);
     +}
     +
      static void fill_alternate_refs_command(struct child_process *cmd,
    @@ odb.c: void disable_obj_read_lock(void)
      
      int fetch_if_missing = 1;
      
    -+static int register_all_submodule_backends(struct object_database *odb)
    ++static int register_all_submodule_alternates(struct object_database *odb)
     +{
    -+	int ret = odb->submodule_backend_paths.nr;
    ++	int ret = odb->submodule_alternate_paths.nr;
     +
    -+	for (size_t i = 0; i < odb->submodule_backend_paths.nr; i++)
    ++	for (size_t i = 0; i < odb->submodule_alternate_paths.nr; i++)
     +		odb_add_to_alternates_memory(odb,
    -+					     odb->submodule_backend_paths.items[i].string);
    ++					     odb->submodule_alternate_paths.items[i].string);
     +	if (ret) {
    -+		string_list_clear(&odb->submodule_backend_paths, 0);
    ++		string_list_clear(&odb->submodule_alternate_paths, 0);
     +		trace2_data_intmax("submodule", odb->repo,
    -+				   "register_all_submodule_backends/registered", ret);
    ++				   "register_all_submodule_alternates/registered", ret);
     +		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
    -+			BUG("register_all_submodule_backends() called");
    ++			BUG("register_all_submodule_alternates() called");
     +	}
     +	return ret;
     +}
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
     -		 * If any such ODBs exist, register them and try again.
     +		 * This might be an attempt at accessing a submodule object as
     +		 * if it were in main object store (having called
    -+		 * `odb_add_submodule_backend_by_path()` on that submodule's
    ++		 * `odb_add_submodule_alternate_by_path()` on that submodule's
     +		 * ODB). If any such ODBs exist, register them and try again.
      		 */
     -		if (r == the_repository &&
     -		    register_all_submodule_odb_as_alternates())
    -+		if (register_all_submodule_backends(r->objects))
    ++		if (register_all_submodule_alternates(r->objects))
      			/* We added some alternates; retry */
      			continue;
      
    @@ odb.c: struct object_database *odb_new(struct repository *repo)
      	INIT_LIST_HEAD(&o->packed_git_mru);
      	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
      	pthread_mutex_init(&o->replace_mutex, NULL);
    -+	string_list_init_dup(&o->submodule_backend_paths);
    ++	string_list_init_dup(&o->submodule_alternate_paths);
      	return o;
      }
      
    @@ odb.c: void odb_clear(struct object_database *o)
      	o->packed_git = NULL;
      
      	hashmap_clear(&o->pack_map);
    -+	string_list_clear(&o->submodule_backend_paths, 0);
    ++	string_list_clear(&o->submodule_alternate_paths, 0);
      }
     
      ## odb.h ##
    @@ odb.h: struct object_database {
      	unsigned packed_git_initialized : 1;
     +
     +	/*
    -+	 * Submodule backend paths that will be added as alternatives to allow
    -+	 * lookup of submodule objects via the main object database.
    ++	 * Submodule alternate paths that will be added as alternatives to
    ++	 * allow lookup of submodule objects via the main object database.
     +	 */
    -+	struct string_list submodule_backend_paths;
    ++	struct string_list submodule_alternate_paths;
      };
      
      struct object_database *odb_new(struct repository *repo);
    -@@ odb.h: void odb_restore_primary_backend(struct object_database *odb,
    - 				 struct odb_backend *restore_odb,
    - 				 const char *old_path);
    +@@ odb.h: void odb_restore_primary_alternate(struct object_database *odb,
    + 				   struct odb_alternate *restore_alt,
    + 				   const char *old_path);
      
     +/*
    -+ * Call odb_add_submodule_backend_by_path() to add the submodule at the given
    ++ * Call odb_add_submodule_alternate_by_path() to add the submodule at the given
     + * path to a list. The object stores of all submodules in that list will be
     + * added as alternates in the object store when looking up objects.
     + */
    -+void odb_add_submodule_backend_by_path(struct object_database *odb,
    -+				       const char *path);
    ++void odb_add_submodule_alternate_by_path(struct object_database *odb,
    ++					  const char *path);
     +
      /*
    -  * Iterate through all backends of the database and execute the provided
    +  * Iterate through all alternates of the database and execute the provided
       * callback function for each of them. Stop iterating once the callback
     
      ## submodule-config.c ##
    @@ submodule-config.c: static void config_from_gitmodules(config_fn_t fn, struct re
      			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
      			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
      			if (repo != the_repository)
    --				add_submodule_odb_by_path(repo->objects->backends->path);
    -+				odb_add_submodule_backend_by_path(the_repository->objects,
    -+								  repo->objects->backends->path);
    +-				add_submodule_odb_by_path(repo->objects->alternates->path);
    ++				odb_add_submodule_alternate_by_path(the_repository->objects,
    ++								    repo->objects->alternates->path);
      		} else {
      			goto out;
      		}
12:  2d431604aa8 ! 12:  193f65f87e6 odb: trivial refactorings to get rid of `the_repository`
    @@ odb.c
      #include "git-compat-util.h"
      #include "abspath.h"
      #include "commit-graph.h"
    -@@ odb.c: void odb_add_submodule_backend_by_path(struct object_database *odb,
    - 	string_list_insert(&odb->submodule_backend_paths, path);
    +@@ odb.c: void odb_add_submodule_alternate_by_path(struct object_database *odb,
    + 	string_list_insert(&odb->submodule_alternate_paths, path);
      }
      
     -static void fill_alternate_refs_command(struct child_process *cmd,
    @@ odb.c: static void read_alternate_refs(const char *path,
      			warning(_("invalid line while parsing alternate refs: %s"),
      				line.buf);
      			break;
    -@@ odb.c: static int refs_from_alternate_cb(struct odb_backend *e,
    +@@ odb.c: static int refs_from_alternate_cb(struct odb_alternate *alternate,
      		goto out;
      	strbuf_setlen(&path, base_len);
      
     -	read_alternate_refs(path.buf, cb->fn, cb->payload);
    -+	read_alternate_refs(e->odb->repo, path.buf, cb->fn, cb->payload);
    ++	read_alternate_refs(alternate->odb->repo, path.buf, cb->fn, cb->payload);
      
      out:
      	strbuf_release(&path);
13:  b1182ab2498 ! 13:  24e46223958 odb: rename `oid_object_info()`
    @@ object.c: struct object *parse_object_with_flags(struct repository *r,
      
     
      ## odb.c ##
    -@@ odb.c: static int register_all_submodule_backends(struct object_database *odb)
    +@@ odb.c: static int register_all_submodule_alternates(struct object_database *odb)
      	return ret;
      }
      
    @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
      		}
      
     @@ odb.c: static int do_oid_object_info_extended(struct repository *r,
    - 		 * `odb_add_submodule_backend_by_path()` on that submodule's
    + 		 * `odb_add_submodule_alternate_by_path()` on that submodule's
      		 * ODB). If any such ODBs exist, register them and try again.
      		 */
    --		if (register_all_submodule_backends(r->objects))
    -+		if (register_all_submodule_backends(odb))
    +-		if (register_all_submodule_alternates(r->objects))
    ++		if (register_all_submodule_alternates(odb))
      			/* We added some alternates; retry */
      			continue;
      
14:  bdbd97d77a9 = 14:  42978727ce8 odb: rename `repo_read_object_file()`
15:  ec2bb725b91 = 15:  a793e6c0768 odb: rename `has_object()`
16:  c576c9d1ccf = 16:  00e0f063635 odb: rename `pretend_object_file()`
17:  d1dd84b5901 = 17:  8888b3320fb odb: rename `read_object_with_reference()`

---
base-commit: 046efb6f2b050efd580e1c1750b77328a1790c0e
change-id: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1

