Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16A3A1E7B
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176397; cv=none; b=sIF4d/tugrvL7KAG6+l4fdA91p7AEhCG87ooJi0yyR1bf3fa2lQwUlZKDFklaHHH0HVEkOtBa6qqlejXL3dfSJIQa65YObK/hLE5/Go9elXCuKpdjXQmbiBuF/y1O29u3g0JG4+4pK3Tuu5Hb2gNvSirjpm50fada/Tg71wJ2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176397; c=relaxed/simple;
	bh=cHeXrmVoEPzlV7i1/LWfH4QBd31bo8w0T6zUOSBh8Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP4tJlOZ1G42UaHV0qpn1mGI8tc525w1dc9ZmjTpRo1mLD7kdy6AEzqVIFxT+Xz3QffxzPYtwI69/Ysnu8Dn/t689GHnF5puMGvXzEXhW6UUxqQnwnHucFGc4LyOOa7WMTun4Otz2e02Y5R5M31sxIDt8UEwA/PBGkBCPQdMbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeXZ58Ds; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeXZ58Ds"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso716999a34.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176394; x=1787781194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VSEfFjalHpoa3D5ZGi6OefYoHm1lbrVTzJzHah/UBU=;
        b=OeXZ58Dsa8cV1T8KN1+Mgel4SBOKLJJvs1vLFofc57oaoI+ei8/KjXpmb5grAFl8mB
         FRU+TkW8ZorweEUgibI6RI/jFS0Pk2MK8ojits6h9BtgfrVENph48+QZb4e6beB6p/zo
         1RTuQr4wugBd+QKb+kHoKo6JK9i6mhB+1oT+sQtiPG4PArqbqlFjTyMyPuOhtJ3ZO+j6
         6h254+Ueu0D33+d1EE06qx2aUIvBQ80xquCO6YXsiAjmejvvFeBMryG+hgTxVYl0IS3a
         ZHnyDFQhFCfHFLrqFmuI9yiyfbopUdNY7x30TczF3SAKSEhNnpmJSdJYI5SDKJ74Bjyh
         Tgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176394; x=1787781194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VSEfFjalHpoa3D5ZGi6OefYoHm1lbrVTzJzHah/UBU=;
        b=gWP6gDgOspL85F8d1e6+lmuJuLPwnxrtaYqC0f90QQVwAEF8fEtBp4b1iCCjo55cZg
         4T0+yO/zJrrDPPwvBatunZKlGYopHDwfzQhXZk2B2ptQgFbw/6LopusOBpjLm9aA223n
         RH9inQH2d6nrFD4swcgfqpCo9ydvYJZ2FyVINHu+SX9lyxUuyG2DB9WPCaxB47+6PxJw
         QBE/CHrFxHswtiky7S1HD39CPhWdXXaKyHsfHCJWLmQ42tvT1VoQsV/GMPj3UtiRQefZ
         j1YAYvOi+nE/yij4IknvrCy0jlcKoH1Lyrg1XJ34W3i5l4jI03HjvkLXei6NSnxfcB+a
         qlHw==
X-Gm-Message-State: AOJu0Yyne/JpslceEFCyz9dP2l2ndWArvlwIlFXUpV46oBt9RWaNNXfl
	OEVVkO168a+RtDIa0RKUDbwPBsqDehseYx7QY+7vyd7oS3TI2IP49DzopmrHfg==
X-Gm-Gg: AR+sD11oV2CAm7IH3IBwblGuDLY/Fw3noArbMCM8u+E2EaVv5HNaNLswseIMig1wRaF
	RFuGVqOPy4CqvkWPFkWn/nmxt44R2yG7d4SiJ6fxRAmLjmykf0UZCLW1O3ZE2gQJEprvkTnfhzi
	XIyumADLte5rrwTXfVBuL8uQ6oIqrGZbAJ4bzpe45HO+GAxH88XT+NxdhILwlLseJ6qyRMBmicP
	xhQOnhXDiKeeMAdx4EU+vslEM1dWMlUG0cr/abEUpWZzZqnCi4UdLmLswgfIIkfCtkDb2OThqeV
	SbNgHI3F3eclWRqP2T136dMpEtKXGNAaSHzLSuCNBiDzSSc6EzivjHD9lsaFqUdEOtwygxqtNkp
	61GYq6UGQYZ9PHywaaicjVP3X8sLmGp8PlNSLzMuBk2/73FrilUSYrpDEKK2H6MA4On29KKOmZB
	GCK2EtgrhH9Hgb7cHas3X5fQG2qVxMi4NAxcEGLeJfnxSZdkwlyIotfbPsBBysZPQ9pn9mxRPrG
	7bq3b0=
X-Received: by 2002:a05:6830:25c1:b0:7dc:e336:c828 with SMTP id 46e09a7af769-7f43fa0cb4dmr7811630a34.10.1787176394212;
        Wed, 19 Aug 2026 14:53:14 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:13 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/9] builtin/receive-pack: support pluggable packfile writes
Date: Wed, 19 Aug 2026 16:53:02 -0500
Message-ID: <20260819215311.3880274-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10), git-receive-pack(1) started using the ODB
transaction interfaces to stage incoming objects. While this brought the
command closer to being ODB backend agnostic, the underlying
git-index-pack(1) and git-unpack-objects(1) processes used to actually
write the objects to the transaction are still fundamentally tied to the
"files" backend.

This series aims to address this by introducing a generic
`odb_transaction_write_pack()` transaction interface to handle writing
the incoming packfile to the transaction. The existing logic in
git-receive-pack(1) that spawns the child processes to write the
packfile becomes the "files" backend implementation of this interface.

Chances since V3:
- In preparation for future `odb_transaction_write_pack()` users, the
  unpack limit takes into consideration odb_transaction_flags to augment
  configutation.
- Added additional test assertion in first patch to ensure keep file is
  generated and placed in quarantine directory.
- Removed an include statement in favor of just forward declaring a
  struct.
- Updated some commit messages.

Changes since V2:
- Added a patch to address a bug causing ".keep" files from not being
  removed.
- Started handling errors at transaction commit and finalize call sites
  instead of ignoring them. We also make sure
  `odb_transaction_finalize()` runs after every successful commit
  callsite to ensure proper cleanup.
- Updated the code handling lazy loading of unpack limit configuration
  to not longer cache the value.
- Added a patch to begin explictly tracking the ODB source used by the
  "files" transaction to avoid relying on the ordering of the ODB source
  list.
- Updated some commit messages to improve clarity.

Changes since V1:
- Changed the "release" interface name to "finalize" and updated it to
  return error codes.
- Marked some function parameters as const.
- Unpack limit configuration is now resolved in the ODB transaction
  backend instead of wiring it through the interface.
- When writing a packfile to the transaction, now only the transaction
  source is prepared.
- Updated some commit messages.
- Updated some code formatting.

Thanks for the review,
-Justin

Justin Tobler (9):
  builtin/receive-pack: properly clean up keep files
  odb/transaction: add transaction finalize interface
  builtin/receive-pack: pass shallow file explicitly
  builtin/receive-pack: read unpack limit config lazily
  builtin/receive-pack: lift global state out of unpack()
  builtin/receive-pack: report unpack errors via strbuf
  builtin/receive-pack: explicitly pass packfile fd
  odb: return temporary ODB source when set
  odb/transaction: add transaction interface to write packfiles

 builtin/add.c              |   4 +-
 builtin/receive-pack.c     | 211 ++++++++-----------------------------
 builtin/unpack-objects.c   |   2 +-
 builtin/update-index.c     |   4 +-
 cache-tree.c               |   2 +-
 fetch-pack.c               |   2 +-
 object-file.c              | 183 +++++++++++++++++++++++++++++++-
 odb.c                      |   9 +-
 odb.h                      |   6 +-
 odb/transaction.c          |  21 ++++
 odb/transaction.h          |  85 +++++++++++++++
 pack-write.c               |   7 +-
 pack.h                     |   4 +-
 read-cache.c               |   2 +-
 t/t5547-push-quarantine.sh |  22 ++++
 tmp-objdir.c               |   8 +-
 tmp-objdir.h               |   6 +-
 17 files changed, 390 insertions(+), 188 deletions(-)

Range-diff against v3:
 1:  58569303f9 !  1:  13a57feea7 builtin/receive-pack: properly clean up keep files
    @@ Commit message
         builtin/receive-pack: properly clean up keep files
     
         When git-receive-pack(1) stores an incoming packfile with
    -    git-index-pack(1), a ".keep" file is written alongside it to hold the
    -    pack in place until the references have been updated, and is removed
    -    afterwards. The path used to remove it is derived via
    +    git-index-pack(1), a ".keep" file is written alongside it in the
    +    transaction quarantine directory and also gets migrated to the main ODB
    +    when the ODB transaction is committed. This keep lockfile ensures the
    +    packfile remains in place until the references have been updated and is
    +    removed afterwards. The path used to remove it is derived via
         `index_pack_lockfile()` from the repository's primary object directory.
     
         In bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
    @@ Commit message
         parent process would set the temporary directory set as an alternate
         only. By using ODB transactions, the ODB source list is also reordered
         for the parent process which results in `index_pack_lockfile()` deriving
    -    the ".keep" path relative to the temporary directory instead the actual
    -    main ODB source path. Consequently, this prevents the ".keep" file from
    -    being properly removed after being migrated into the main ODB source
    -    post-commit.
    +    the ".keep" path relative to the temporary directory instead of the
    +    actual main ODB source path. Consequently, this prevents the ".keep"
    +    file from being properly removed after being migrated into the main ODB
    +    source post-commit.
     
         Update `index_pack_lockfile()` to operate on an ODB source explicitly
         provided to it and update call sites accordingly to pass the expected
    @@ pack-write.c: char *index_pack_lockfile(struct repository *r, int ip_out, int *i
     
      ## pack.h ##
     @@
    - 
    - #include "object.h"
    - #include "csum-file.h"
    -+#include "odb/source.h"
    - 
      struct packed_git;
      struct pack_window;
    + struct repository;
    ++struct odb_source;
    + 
    + /*
    +  * Packed object header
     @@ pack.h: off_t write_pack_header(struct hashfile *f, uint32_t);
      void fixup_pack_header_footer(const struct git_hash_algo *, int,
      			      unsigned char *, const char *, uint32_t,
    @@ t/t5547-push-quarantine.sh: test_expect_success 'updating a ref from quarantine
     +	git init --bare keep.git &&
     +
     +	git -C keep.git config set receive.unpackLimit 0 &&
    ++
    ++	# While incoming objects are still quarantined, validate that the keep
    ++	# lockfile does indeed exist.
    ++	test_hook -C keep.git pre-receive <<-\EOF &&
    ++	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
    ++	test -f "$keep"
    ++	EOF
    ++
     +	test_commit foo &&
     +	git push keep.git HEAD &&
     +	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
 2:  dba9696866 !  2:  49254af71c odb/transaction: add transaction finalize interface
    @@ Commit message
         after the reference updates are finished.
     
         All other callers commit a transaction and immediately finalize it with
    -    no work in between and cannot meaningfully recover should either step
    -    fail, so introduce an `odb_transaction_commit_and_finalize_or_die()`
    -    helper that performs both and dies on error. Call sites are updated
    +    no work in between and cannot meaningfully recover should either fail,
    +    so introduce an `odb_transaction_commit_and_finalize_or_die()` helper
    +    that performs both and dies on error. Call sites are updated
         accordingly.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
 3:  09bc00a070 =  3:  882cf06bc3 builtin/receive-pack: pass shallow file explicitly
 4:  2586ea4041 =  4:  8deec37a09 builtin/receive-pack: read unpack limit config lazily
 5:  adf325095e =  5:  92d56134f0 builtin/receive-pack: lift global state out of unpack()
 6:  29f407bf36 =  6:  d614b10715 builtin/receive-pack: report unpack errors via strbuf
 7:  b85f5e868c =  7:  bc5839ad8e builtin/receive-pack: explicitly pass packfile fd
 8:  620eafe035 =  8:  13540b91b8 odb: return temporary ODB source when set
 9:  2e75a8bd6c !  9:  62d46d5c07 odb/transaction: add transaction interface to write packfiles
    @@ object-file.c
      #include "setup.h"
      #include "strvec.h"
      #include "tempfile.h"
    -@@ object-file.c: struct odb_transaction_files {
    +@@ object-file.c: struct transaction_packfile {
    + 
    + struct odb_transaction_files {
    + 	struct odb_transaction base;
    ++	enum odb_transaction_flags flags;
    + 
    + 	struct tmp_objdir *objdir;
      	struct odb_source *quarantine;
      	struct transaction_packfile packfile;
      	const char *prefix;
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
     +}
     +
    -+static unsigned int get_unpack_limit(struct repository *repo)
    ++static unsigned int get_unpack_limit(struct repository *repo,
    ++				     enum odb_transaction_flags flags)
     +{
    -+	unsigned int limit = 100;
    ++	unsigned int limit = 0;
     +
    -+	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
    -+	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
    ++	if (flags & ODB_TRANSACTION_RECEIVE) {
    ++		limit = 100;
    ++		repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
    ++		repo_config_get_uint(repo, "receive.unpacklimit", &limit);
    ++	}
     +
     +	return limit;
     +}
    @@ object-file.c: static int odb_transaction_files_commit(struct odb_transaction *b
     +
     +	odb_transaction_env(base, &child.env);
     +
    -+	if (ntohl(hdr.hdr_entries) < get_unpack_limit(repo)) {
    ++	if (ntohl(hdr.hdr_entries) < get_unpack_limit(repo, transaction->flags)) {
     +		strvec_push(&child.args, "unpack-objects");
     +		push_header_arg(&child.args, &hdr);
     +		if (opts->quiet)
    @@ object-file.c: int odb_transaction_files_begin(struct odb_source *source,
      	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
     +	transaction->base.write_pack = odb_transaction_files_write_pack;
      	transaction->base.env = odb_transaction_files_env;
    ++	transaction->flags = flags;
      
      	transaction->prefix = "bulk-fsync";
    + 	if (flags & ODB_TRANSACTION_RECEIVE) {
     
      ## odb/transaction.c ##
     @@ odb/transaction.c: int odb_transaction_write_object_stream(struct odb_transaction *transaction,

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.424.g13c7afec21

