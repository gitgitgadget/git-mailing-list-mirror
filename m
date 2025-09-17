Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C052B9A5
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071804; cv=none; b=Q8wYegb/NwRU73OVLocQXPnFaBdn9X/Mf3hlzJI3TyJW1a41u0kwbKlZmFPAMHhrPG6lc0l6vmccwBsuZzCPS6Xb3xRyNpYJ3GEpbRAj/JyGCZLvFBuf9p1mQRLgjNKxKz7ziamYv2jyz+ina68zT03AxnSJ8SklVyTILQQjJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071804; c=relaxed/simple;
	bh=NCHbN6AdRTUFVI3Kgip8v2HG0esJ5RomF1QUiggfWHc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PeFY0heChz2KGNOQMxH4EDh5g0HbDKrDhecaABGlV/wWQRyl8murqG+NUhzwb+l1NdJ9htUmDYwSttyhXqoAD8xRESV1PNEy9eCSnUp25wrMCJXqcBRJCmyFiUkcbz/WMT4NdJk0Rs2Tsr8H2usjMo50yQyd4l6+mlJ5VJPSwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAmna/Pv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAmna/Pv"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5488c409d1so4042808a12.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071800; x=1758676600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPFJ7GYgOUuZBXABjD5bAQMPgBRc8pAPYnrx41Qcnbw=;
        b=ZAmna/PvAfPyrqht5QZpe8YNSmV6+odjTcI2cQBiDfpPD1oD3eYbqJUIXiV3vjoEni
         9HN9VrdUhqXa0l7IiU1FMofqjQzBNc1UtV519ytdrko4IVX5Y+zCRXDdWuqkr8f4KXb7
         XkkGKNcGx+aCRQa7m39Qkiz20vzJ0A70nimSm6XiSI5CNVFZFwEuPEX605naAFaPjaU2
         lYwqrC+QPLK89MzSnM/Y4p8EcvoYcUzCBz4Q5payl1AWRTpUgAtXddbb3jjQV+pa1JqY
         cu8GkVe7eAYADiJUrWJ3Mtl/jxsvFz7Jdygj7W+PgRlTmaE+V63TOwMYlLHAKz6A5tYJ
         l9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071800; x=1758676600;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPFJ7GYgOUuZBXABjD5bAQMPgBRc8pAPYnrx41Qcnbw=;
        b=HdJ5yjUmxTOrrqQZoYrMKgKezkfvez1/IY81E86blDOfD8mxC11xQ1cy2SlXpIQUhx
         XnXlRQHUtuBPrg5QGWfTJm77w1pgCcYQhEFyBxZNdF/UDSgQEfSjeoT3ytV2NA+hP6wR
         ibPzkIxCH+3GCcSiuweUQIgws5y75Upd6KaO9EURObqmJ7ypGpmtKxRYJQKQbuWh2xcP
         Giz/iajAv8Pg5ivrOfMhFKcVfyYtlnRpAHge471f4gZnq6yGr7WQt4BngTTDCEHDZAk7
         1wclYsYIlO/AkdDBGOiBpAtZAcNOrskEt/xxNj1pZUSVXfG9K8+P49PENiZygKwnANVU
         xfCg==
X-Gm-Message-State: AOJu0YzaNHeXXa4wkj2WASQzMivJAus9p8L73Rn31ReKtjbdNqeKVvkV
	zjOQ/fI+tr3c5JIbFrgme+C3iZO28++bIY2YVyzJayplmfWhy3rspsNljsR/qg==
X-Gm-Gg: ASbGncuSP/lbSNPwkBhvmRiJC0zPN9bK3KcErySNrwZw75S/kJ8fC0rK1/GVvQx4la5
	yVZsOnx6dberrqJ6QKhl8E8v6uGdHOLUrNTV/Ak+idGhHRNadLpgFz+7BWYhZ+2RzzbwQqnewBw
	CPVcYTfn/FNWNN2KAqz//7cnsdj5UgWMQ/cnBMY9Sl0Ny9tqtwPCNtifhCFrAIYev4Zr+sm+3kd
	6gK1yzqfJ9U5CzyxGZykATOYUqiKiwvr9jdJZF8K8a5eqEg8JSZB6SbPjalGUE/ytDJre8EAz85
	RznICJ319DEHpXX+8rgsUcwpdEAjlsVa8wexqiPUHMRox6xPI9614pu+XHSdZfXyl8yku6QCKit
	3Q9EnEtBdQQFyoKx3PaF9kQoAu30=
X-Google-Smtp-Source: AGHT+IEUhNiCfb5IYUDjN5JnqNYPTPVwa6Jomo2D4fMSo/7M5/piVmPxlhlMp4fsz8odT+WXx4BQ5w==
X-Received: by 2002:a17:903:3888:b0:24c:bdf5:d74b with SMTP id d9443c01a7336-26811e884a0mr4489175ad.19.1758071799900;
        Tue, 16 Sep 2025 18:16:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267e07a7cabsm25306675ad.9.2025.09.16.18.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:39 -0700 (PDT)
Message-Id: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:20 +0000
Subject: [PATCH v2 00/18] Introduce rust: In xdiff
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>

This is a continuation of
https://lore.kernel.org/git/pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com/,
but I am removing the RFC label.

Suggestions on changes that I could make to this series is appreciated.

Changes in v2: High level overview:

 * patch 1: cleanup: rename variables that collide with Rust primitive type
   names
 * patches 2-4: Makefile now produces libgit.a correctly
 * patches 5,6: Documentation from Brian and Patrick
 * patches 7,8: Introduce Rust
 * patches 9-11: github workflows
 * patches 12-14: introduce crates build-helper, and cbindgen
 * patches 15-18: varint test balloon

I would like feed back in two categories: big changes, and little changes.
Is my patch series even going in the right direction, and what are the
little details that I've missed? I know Brian asked for cbindgen and it made
the series several commits longer, but I think it's a great idea to have. I
am not happy with every choice that I made, but I currently don't see a
better way or at least an easier alternative to my approach in bringing Rust
to Git.

Build results for these changes:
https://github.com/git/git/actions/runs/17783386212?pr=2043. Some of these
are failing.

Changes in v1: Changes since the last RFC patch series (range-diff added
below):

 * Addressed feedback:
   * Use self instead of this
   * Update ivec to use Git code style
   * Remove environment variable CI_IS_DOCKER from github workflows
   * Remove PHONY target interop-objs
   * Removed left over asserts in Rust and fix near by code
 * Other changes:
   * Avoid name mangling of ivec if c++ compiler used
   * Fixed a typo in patch 11 commit message

High level overview:

 * patch 1: add a policy for using Rust (brian's patch, with a small tweak)
 * patch 2: introduce Rust to the codebase
 * patches 3-5: adapt CI (github workflows) to build Git with Rust
 * patch 6: introduce the ivec type
 * patches 7-14: xdiff code cleanup in preparation for translating to Rust
 * patch 15: translate a C function into Rust and call it from C

Ezekiel Newren (12):
  cleanup: rename variables that collide with Rust primitive type names
  make: add -fPIE flag
  make: merge xdiff lib into libgit.a
  make: merge reftable lib into libgit.a
  build: introduce rust
  github workflows: install rust
  github workflows: upload Cargo.lock
  build: new crate, build-helper
  build-helper: link against libgit.a and any other required C libraries
  build-helper: cbindgen, let crates generate a header file
  build: new crate, misc
  misc: use BuildHelper

Johannes Schindelin (1):
  win+Meson: do allow linking with the Rust-built xdiff

Patrick Steinhardt (4):
  BreakingChanges: announce Rust becoming mandatory
  help: report on whether or not Rust is enabled
  varint: use explicit width for integers
  misc::varint: reimplement as test balloon for Rust

brian m. carlson (1):
  doc: add a policy for using Rust

 .github/workflows/main.yml                    |  82 +++++++++-
 .gitignore                                    |   4 +
 Documentation/BreakingChanges.adoc            |  35 +++++
 Documentation/Makefile                        |   1 +
 Documentation/technical/platform-support.adoc |   2 +
 Documentation/technical/rust-support.adoc     | 142 +++++++++++++++++
 Makefile                                      | 148 +++++++++++-------
 build_rust.sh                                 |  60 +++++++
 ci/install-dependencies.sh                    |  14 +-
 ci/install-rust-toolchain.sh                  |  30 ++++
 ci/install-rustup.sh                          |  25 +++
 ci/lib.sh                                     |   1 +
 ci/make-test-artifacts.sh                     |   9 ++
 ci/run-build-and-tests.sh                     |  13 ++
 config.mak.uname                              |   4 +
 dir.c                                         |  18 ++-
 help.c                                        |   6 +
 meson.build                                   |  79 ++++++++--
 meson_options.txt                             |   2 +
 odb.c                                         |   8 +-
 read-cache.c                                  |   6 +-
 reftable/record.c                             |   6 +-
 rust/Cargo.toml                               |   6 +
 rust/build-helper/Cargo.toml                  |  11 ++
 rust/build-helper/src/lib.rs                  | 126 +++++++++++++++
 rust/cbindgen-template.toml                   |  16 ++
 rust/misc/Cargo.toml                          |  17 ++
 rust/misc/build.rs                            |   6 +
 rust/misc/src/lib.rs                          |   1 +
 rust/misc/src/varint.rs                       |  92 +++++++++++
 t/helper/test-parse-options.c                 |  12 +-
 varint.c                                      |   6 +-
 varint.h                                      |   4 +-
 xdiff/xtypes.h                                |   2 +-
 xdiff/xutils.c                                |   8 +-
 xdiff/xutils.h                                |   2 +-
 36 files changed, 899 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/technical/rust-support.adoc
 create mode 100755 build_rust.sh
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh
 create mode 100644 rust/Cargo.toml
 create mode 100644 rust/build-helper/Cargo.toml
 create mode 100644 rust/build-helper/src/lib.rs
 create mode 100644 rust/cbindgen-template.toml
 create mode 100644 rust/misc/Cargo.toml
 create mode 100644 rust/misc/build.rs
 create mode 100644 rust/misc/src/lib.rs
 create mode 100644 rust/misc/src/varint.rs


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2043%2Fezekielnewren%2Fintroduce_rust-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2043/ezekielnewren/introduce_rust-v2
Pull-Request: https://github.com/git/git/pull/2043

Range-diff vs v1:

  -:  ---------- >  1:  5f77f1bd5d cleanup: rename variables that collide with Rust primitive type names
  -:  ---------- >  2:  7082e32c59 make: add -fPIE flag
  -:  ---------- >  3:  7fe85f0eac make: merge xdiff lib into libgit.a
 10:  0cd2168512 !  4:  3061cc46c1 xdiff: use one definition for freeing xdfile_t
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: use one definition for freeing xdfile_t
     -
     -    Simplify xdl_prepare_ctx() by using xdl_free_ctx() instead of using
     -    local variables with hand rolled memory management.
     +    make: merge reftable lib into libgit.a
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     - ## xdiff/xprepare.c ##
     -@@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
     - }
     - 
     + ## Makefile ##
     +@@ Makefile: export PYTHON_PATH
     + TEST_SHELL_PATH = $(SHELL_PATH)
       
     -+static void xdl_free_ctx(xdfile_t *xdf) {
     -+	xdl_free(xdf->rindex);
     -+	xdl_free(xdf->rchg - 1);
     -+	xdl_free(xdf->ha);
     -+	xdl_free(xdf->recs);
     -+	xdl_cha_free(&xdf->rcha);
     -+}
     -+
     -+
     - static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
     - 			   xdlclassifier_t *cf, xdfile_t *xdf) {
     --	long nrec, bsize;
     -+	long bsize;
     - 	unsigned long hav;
     - 	char const *blk, *cur, *top, *prev;
     - 	xrecord_t *crec;
     --	xrecord_t **recs;
     --	unsigned long *ha;
     --	char *rchg;
     --	long *rindex;
     + LIB_FILE = libgit.a
     +-REFTABLE_LIB = reftable/libreftable.a
       
     --	ha = NULL;
     --	rindex = NULL;
     --	rchg = NULL;
     --	recs = NULL;
     -+	xdf->ha = NULL;
     -+	xdf->rindex = NULL;
     -+	xdf->rchg = NULL;
     -+	xdf->recs = NULL;
     -+	xdf->nrec = 0;
     + GENERATED_H += command-list.h
     + GENERATED_H += config-list.h
     +@@ Makefile: LIB_OBJS += rebase.o
     + LIB_OBJS += ref-filter.o
     + LIB_OBJS += reflog-walk.o
     + LIB_OBJS += reflog.o
     ++LIB_OBJS += reftable/basics.o
     ++LIB_OBJS += reftable/error.o
     ++LIB_OBJS += reftable/block.o
     ++LIB_OBJS += reftable/blocksource.o
     ++LIB_OBJS += reftable/iter.o
     ++LIB_OBJS += reftable/merged.o
     ++LIB_OBJS += reftable/pq.o
     ++LIB_OBJS += reftable/record.o
     ++LIB_OBJS += reftable/stack.o
     ++LIB_OBJS += reftable/system.o
     ++LIB_OBJS += reftable/table.o
     ++LIB_OBJS += reftable/tree.o
     ++LIB_OBJS += reftable/writer.o
     + LIB_OBJS += refs.o
     + LIB_OBJS += refs/debug.o
     + LIB_OBJS += refs/files-backend.o
     +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
       
     - 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
     - 		goto abort;
     --	if (!XDL_ALLOC_ARRAY(recs, narec))
     -+	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
     - 		goto abort;
     + UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
       
     --	nrec = 0;
     - 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
     - 		for (top = blk + bsize; cur < top; ) {
     - 			prev = cur;
     - 			hav = xdl_hash_record(&cur, top, xpp->flags);
     --			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
     -+			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
     - 				goto abort;
     - 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
     - 				goto abort;
     - 			crec->ptr = (u8 const*) prev;
     - 			crec->size = (long) (cur - prev);
     - 			crec->ha = hav;
     --			recs[nrec++] = crec;
     -+			xdf->recs[xdf->nrec++] = crec;
     - 			if (xdl_classify_record(pass, cf, crec) < 0)
     - 				goto abort;
     - 		}
     - 	}
     +-# reftable lib may depend on what is in libgit.a
     +-GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
     ++GITLIBS = common-main.o $(LIB_FILE)
     + EXTLIBS =
       
     --	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
     -+	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
     - 		goto abort;
     + GIT_USER_AGENT = git/$(GIT_VERSION)
     +@@ Makefile: reconfigure config.mak.autogen: config.status
     + .PHONY: reconfigure # This is a convenience target.
     + endif
       
     - 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
     - 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
     --		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
     -+		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
     - 			goto abort;
     --		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
     -+		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
     - 			goto abort;
     - 	}
     +-REFTABLE_OBJS += reftable/basics.o
     +-REFTABLE_OBJS += reftable/error.o
     +-REFTABLE_OBJS += reftable/block.o
     +-REFTABLE_OBJS += reftable/blocksource.o
     +-REFTABLE_OBJS += reftable/iter.o
     +-REFTABLE_OBJS += reftable/merged.o
     +-REFTABLE_OBJS += reftable/pq.o
     +-REFTABLE_OBJS += reftable/record.o
     +-REFTABLE_OBJS += reftable/stack.o
     +-REFTABLE_OBJS += reftable/system.o
     +-REFTABLE_OBJS += reftable/table.o
     +-REFTABLE_OBJS += reftable/tree.o
     +-REFTABLE_OBJS += reftable/writer.o
     +-
     + TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
       
     --	xdf->nrec = nrec;
     --	xdf->recs = recs;
     --	xdf->rchg = rchg + 1;
     --	xdf->rindex = rindex;
     -+	xdf->rchg += 1;
     - 	xdf->nreff = 0;
     --	xdf->ha = ha;
     - 	xdf->dstart = 0;
     --	xdf->dend = nrec - 1;
     -+	xdf->dend = xdf->nrec - 1;
     + .PHONY: test-objs
     +@@ Makefile: OBJECTS += $(SCALAR_OBJS)
     + OBJECTS += $(PROGRAM_OBJS)
     + OBJECTS += $(TEST_OBJS)
     + OBJECTS += $(FUZZ_OBJS)
     +-OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
     ++OBJECTS += $(REFTABLE_TEST_OBJS)
     + OBJECTS += $(UNIT_TEST_OBJS)
     + OBJECTS += $(CLAR_TEST_OBJS)
     + OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
     +@@ Makefile: scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
     + $(LIB_FILE): $(LIB_OBJS)
     + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
       
     - 	return 0;
     +-$(REFTABLE_LIB): $(REFTABLE_OBJS)
     +-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     +-
     + export DEFAULT_EDITOR DEFAULT_PAGER
       
     - abort:
     --	xdl_free(ha);
     --	xdl_free(rindex);
     --	xdl_free(rchg);
     --	xdl_free(recs);
     --	xdl_cha_free(&xdf->rcha);
     -+	xdl_free_ctx(xdf);
     - 	return -1;
     - }
     + Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
     +@@ Makefile: clean: profile-clean coverage-clean cocciclean
     + 	$(RM) git.rc git.res
     + 	$(RM) $(OBJECTS)
     + 	$(RM) headless-git.o
     +-	$(RM) $(LIB_FILE) $(REFTABLE_LIB)
     ++	$(RM) $(LIB_FILE)
     + 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
     + 	$(RM) $(TEST_PROGRAMS)
     + 	$(RM) $(FUZZ_PROGRAMS)
     +@@ Makefile: endif
       
     + LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
     + LIBGIT_PUB_OBJS += libgit.a
     +-LIBGIT_PUB_OBJS += reftable/libreftable.a
       
     --static void xdl_free_ctx(xdfile_t *xdf) {
     --	xdl_free(xdf->rindex);
     --	xdl_free(xdf->rchg - 1);
     --	xdl_free(xdf->ha);
     --	xdl_free(xdf->recs);
     --	xdl_cha_free(&xdf->rcha);
     --}
     --
     --
     - void xdl_free_env(xdfenv_t *xe) {
     + LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
       
     - 	xdl_free_ctx(&xe->xdf2);
  1:  6d065f550f !  5:  0fc89c3ec3 doc: add a policy for using Rust
     @@ Documentation/technical/rust-support.adoc (new)
      +these crates, but for now we omit them.
      +
      +Tools like bindgen and cbindgen create C-styled unsafe Rust code rather than
     -+idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.  Any
     -+standard C library functions that are needed can be manually wrapped on the
     -+Rust side.
     ++idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.
     ++However, we may use bindgen and cbindgen to share existing Git types as an
     ++interim step.
      +
      +Rust upstream releases every six weeks and only supports the latest stable
      +release.  While it is nice that upstream is active, we would like our software
  -:  ---------- >  6:  8e030170dd BreakingChanges: announce Rust becoming mandatory
  2:  cc9cf87775 !  7:  6032a8740c xdiff: introduce rust
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: introduce rust
     +    build: introduce rust
      
          Upcoming patches will simplify xdiff, while also porting parts of it to
          Rust. In preparation, add some stubs and setup the Rust build. For now,
          it is easier to let cargo build rust and have make or meson merely link
          against the static library that cargo builds. In line with ongoing
          libification efforts, use multiple crates to allow more modularity on
     -    the Rust side. xdiff is the crate that this series will focus on, but
     -    we also introduce the interop crate for future patch series.
     +    the Rust side. The xdiff and ivec crates are the focal point for this
     +    series.
      
     -    In order to facilitate interoperability between C and Rust, introduce C
     -    definitions for Rust primitive types in git-compat-util.h.
     +    cbindgen will be used to generate header files for each Rust crate for
     +    C interoperability.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     @@ .gitignore: Release/
       /contrib/buildsystems/out
       /contrib/libgit-rs/target
       /contrib/libgit-sys/target
     -+/.idea/
     ++.idea/
      +/rust/target/
      +/rust/Cargo.lock
      
       ## Makefile ##
     +@@ Makefile: include shared.mak
     + # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
     + # in /foo/bar/include and /foo/bar/lib directories.
     + #
     ++# == Optional Rust support ==
     ++#
     ++# Define WITH_RUST=false if you don't want to include features and subsystems
     ++# written in Rust into Git. For now, Rust is still an optional feature of the
     ++# build process. With Git 3.0 though, Rust will be mandatory.
     ++#
     ++# Building Rust code requires Cargo.
     ++#
     + # == SHA-1 and SHA-256 defines ==
     + #
     + # === SHA-1 backend ===
      @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
       
       LIB_FILE = libgit.a
     - XDIFF_LIB = xdiff/lib.a
     -+
     + 
      +EXTLIBS =
      +
     ++GIT_BUILD_DIR := $(CURDIR)
     ++export GIT_BUILD_DIR
     ++
     ++RUST_CRATES :=
     ++.PHONY: compile_rust rustclean
     ++
     ++WITH_RUST ?= true
     ++ifeq ($(WITH_RUST),true)
     ++
      +ifeq ($(DEBUG), 1)
     -+  RUST_BUILD_MODE = debug
     ++	RUST_BUILD_MODE := debug
      +else
     -+  RUST_BUILD_MODE = release
     ++	RUST_BUILD_MODE := release
      +endif
      +
     -+RUST_TARGET_DIR = rust/target/$(RUST_BUILD_MODE)
     -+RUST_FLAGS_FOR_C = -L$(RUST_TARGET_DIR)
     ++RUST_TARGET_DIR := $(GIT_BUILD_DIR)/$(RUST_BUILD_MODE)
      +
     -+.PHONY: compile_rust
     -+compile_rust:
     -+	./build_rust.sh . $(RUST_BUILD_MODE) xdiff
     ++RUST_LIBS := $(foreach c,$(RUST_CRATES),$(GIT_BUILD_DIR)/lib$(c).a)
     ++
     ++EXTLIBS += $(RUST_LIBS)
      +
     -+EXTLIBS += ./$(RUST_TARGET_DIR)/libxdiff.a
     ++compile_rust: $(RUST_LIBS)
     ++rustclean:
     ++	$(RM) $(RUST_LIBS)
     ++	cd rust && cargo clean
     ++
     ++$(GIT_BUILD_DIR)/lib%.a:
     ++	./build_rust.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*
      +
      +UNAME_S := $(shell uname -s)
      +ifeq ($(UNAME_S),Linux)
     -+  EXTLIBS += -ldl
     ++	EXTLIBS += -ldl
     ++endif
     ++
     ++else ifeq ($(WITH_RUST),false)
     ++compile_rust:
     ++	:
     ++rustclean:
     ++	:
     ++else
     ++$(error 'WITH_RUST' must be true or false)
      +endif
      +
     - REFTABLE_LIB = reftable/libreftable.a
     - 
       GENERATED_H += command-list.h
     -@@ Makefile: UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
     + GENERATED_H += config-list.h
     + GENERATED_H += hook-list.h
     +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
     + UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
       
     - # xdiff and reftable libs may in turn depend on what is in libgit.a
     - GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
     + GITLIBS = common-main.o $(LIB_FILE)
      -EXTLIBS =
     -+
       
       GIT_USER_AGENT = git/$(GIT_VERSION)
       
     +@@ Makefile: CC_LD_DYNPATH = -Wl,-rpath,
     + BASIC_CFLAGS = -I. -fPIE
     + BASIC_LDFLAGS =
     + 
     ++ifeq ($(WITH_RUST),true)
     ++BASIC_CFLAGS += -DWITH_RUST
     ++endif
     + # library flags
     + ARFLAGS = rcs
     + PTHREAD_CFLAGS =
      @@ Makefile: git.sp git.s git.o: EXTRA_CPPFLAGS = \
       	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
       	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
     @@ Makefile: $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
       		$(filter %.o,$^) $(LIBS)
       
     -@@ Makefile: $(LIB_FILE): $(LIB_OBJS)
     - $(XDIFF_LIB): $(XDIFF_OBJS)
     - 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     - 
     -+
     - $(REFTABLE_LIB): $(REFTABLE_OBJS)
     - 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     - 
      @@ Makefile: perf: all
       
       t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
     @@ Makefile: cocciclean:
       	$(RM) contrib/coccinelle/*.cocci.patch
       
      -clean: profile-clean coverage-clean cocciclean
     -+rustclean:
     -+	cd rust && cargo clean
     -+
      +clean: profile-clean coverage-clean cocciclean rustclean
       	$(RM) -r .build $(UNIT_TEST_BIN)
       	$(RM) GIT-TEST-SUITES
     @@ build_rust.sh (new)
      @@
      +#!/bin/sh
      +
     -+
      +rustc -vV || exit $?
      +cargo --version || exit $?
      +
     @@ build_rust.sh (new)
      +  exit 1
      +fi
      +
     -+cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; cd $dir_git_root
     -+
      +libfile="lib${crate}.a"
      +if rustup show active-toolchain | grep windows-msvc; then
      +  libfile="${crate}.lib"
     ++  PATH="$(echo $PATH | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr/bin)$" | paste -sd: -):/mingw64/bin:/usr/bin"
      +fi
     -+dst=$dir_build/$libfile
      +
     -+if [ "$dir_git_root" != "$dir_build" ]; then
     -+  src=$dir_rust/target/$rust_build_profile/$libfile
     -+  if [ ! -f $src ]; then
     -+    echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
     -+    exit 5
     -+  fi
     ++CARGO_TARGET_DIR=$dir_git_root/.build/rust/$crate
     ++export CARGO_TARGET_DIR
     ++
     ++cd $dir_rust && cargo clean && pwd && USE_LINKING="false" cargo build -p $crate $rust_args; cd $dir_git_root
     ++
     ++src=$CARGO_TARGET_DIR/$rust_build_profile/$libfile
     ++dst=$dir_build/$libfile
      +
     -+  rm $dst 2>/dev/null
     -+  mv $src $dst
     ++if [ ! -f $src ]; then
     ++  echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
     ++  exit 5
      +fi
     -
     - ## git-compat-util.h ##
     -@@ git-compat-util.h: static inline int is_xplatform_dir_sep(int c)
     - #include "compat/msvc.h"
     - #endif
     - 
     -+/* rust types */
     -+typedef uint8_t   u8;
     -+typedef uint16_t  u16;
     -+typedef uint32_t  u32;
     -+typedef uint64_t  u64;
     -+
     -+typedef int8_t    i8;
     -+typedef int16_t   i16;
     -+typedef int32_t   i32;
     -+typedef int64_t   i64;
     -+
     -+typedef float     f32;
     -+typedef double    f64;
     -+
     -+typedef size_t    usize;
     -+typedef ptrdiff_t isize;
     -+
     - /* used on Mac OS X */
     - #ifdef PRECOMPOSE_UNICODE
     - #include "compat/precompose_utf8.h"
     ++
     ++rm $dst 2>/dev/null
     ++echo mv $src $dst
     ++mv $src $dst
      
       ## meson.build ##
      @@ meson.build: version_gen_environment.set('GIT_DATE', get_option('build_date'))
       version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
       version_gen_environment.set('GIT_VERSION', get_option('version'))
       
     -+if get_option('optimization') in ['2', '3', 's', 'z']
     -+  rust_build_profile = 'release'
     -+else
     -+  rust_build_profile = 'debug'
     -+endif
     ++rust_crates = []
      +
     -+# Run `rustup show active-toolchain` and capture output
     -+rustup_out = run_command('rustup', 'show', 'active-toolchain',
     -+                         check: true).stdout().strip()
     -+
     -+rust_crates = ['xdiff']
      +rust_builds = []
     ++with_rust = get_option('with_rust')
     ++if with_rust
     ++  rustc = find_program('rustc', required : false)
     ++  cargo = find_program('cargo', required : false)
      +
     -+foreach crate : rust_crates
     -+  if rustup_out.contains('windows-msvc')
     -+    libfile = crate + '.lib'
     ++  if not rustc.found() or not cargo.found()
     ++    error('Rust toolchain not found. Reconfigure with -Dwith_rust=false')
     ++  endif
     ++
     ++  if get_option('optimization') in ['2', '3', 's', 'z']
     ++    rust_build_profile = 'release'
      +  else
     -+    libfile = 'lib' + crate + '.a'
     ++    rust_build_profile = 'debug'
      +  endif
      +
     -+  rust_builds += custom_target(
     -+    'rust_build_'+crate,
     -+    output: libfile,
     -+    build_by_default: true,
     -+    build_always_stale: true,
     -+    command: [
     -+      meson.project_source_root() / 'build_rust.sh',
     -+      meson.current_build_dir(), rust_build_profile, crate,
     -+    ],
     -+    install: false,
     -+  )
     -+endforeach
     ++  # Run `rustup show active-toolchain` and capture output
     ++  rustup_out = run_command('rustup', 'show', 'active-toolchain',
     ++                           check: true).stdout().strip()
     ++
     ++  rust_environment = script_environment
     ++
     ++  foreach crate : rust_crates
     ++    if rustup_out.contains('windows-msvc')
     ++      libfile = crate + '.lib'
     ++    else
     ++      libfile = 'lib' + crate + '.a'
     ++    endif
     ++
     ++    rust_builds += custom_target(
     ++      'rust_build_'+crate,
     ++      output: libfile,
     ++      build_by_default: true,
     ++      build_always_stale: true,
     ++      command: [
     ++        meson.project_source_root() / 'build_rust.sh',
     ++        meson.current_build_dir(), rust_build_profile, crate,
     ++      ],
     ++      install: false,
     ++      env: rust_environment,
     ++    )
     ++  endforeach
     ++else
     ++  message('Rust components disabled (-Dwith_rust=false)')
     ++endif
      +
      +
       compiler = meson.get_compiler('c')
       
       libgit_sources = [
     +@@ meson.build: libgit_c_args = [
     +   '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
     + ]
     + 
     ++if with_rust
     ++  libgit_c_args += '-DWITH_RUST'
     ++endif
     ++
     + system_attributes = get_option('gitattributes')
     + if system_attributes != ''
     +   libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
     +@@ meson.build: elif host_machine.system() == 'windows'
     +   ]
     + 
     +   libgit_dependencies += compiler.find_library('ntdll')
     ++  libgit_dependencies += compiler.find_library('userenv')
     +   libgit_include_directories += 'compat/win32'
     +   if compiler.get_id() == 'msvc'
     +     libgit_include_directories += 'compat/vcbuild/include'
      @@ meson.build: version_def_h = custom_target(
       libgit_sources += version_def_h
       
     @@ meson.build: version_def_h = custom_target(
         dependencies: libgit_dependencies,
         include_directories: libgit_include_directories,
      
     + ## meson_options.txt ##
     +@@ meson_options.txt: option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], valu
     +   description: 'The backend used for compressing objects and other data.')
     + 
     + # Build tweaks.
     ++option('with_rust', type: 'boolean', value: true,
     ++       description: 'Enable building with Rust, true by default.')
     + option('breaking_changes', type: 'boolean', value: false,
     +   description: 'Enable upcoming breaking changes.')
     + option('macos_use_homebrew_gettext', type: 'boolean', value: true,
     +
       ## rust/Cargo.toml (new) ##
      @@
      +[workspace]
     -+members = [
     -+    "xdiff",
     -+    "interop",
     -+]
     ++members = []
      +resolver = "2"
     -
     - ## rust/interop/Cargo.toml (new) ##
     -@@
     -+[package]
     -+name = "interop"
     -+version = "0.1.0"
     -+edition = "2021"
     -+
     -+[lib]
     -+name = "interop"
     -+path = "src/lib.rs"
     -+## staticlib to generate xdiff.a for use by gcc
     -+## cdylib (optional) to generate xdiff.so for use by gcc
     -+## rlib is required by the rust unit tests
     -+crate-type = ["staticlib", "rlib"]
     -+
     -+[dependencies]
     -
     - ## rust/interop/src/lib.rs (new) ##
     -
     - ## rust/xdiff/Cargo.toml (new) ##
     -@@
     -+[package]
     -+name = "xdiff"
     -+version = "0.1.0"
     -+edition = "2021"
     -+
     -+[lib]
     -+name = "xdiff"
     -+path = "src/lib.rs"
     -+## staticlib to generate xdiff.a for use by gcc
     -+## cdylib (optional) to generate xdiff.so for use by gcc
     -+## rlib is required by the rust unit tests
     -+crate-type = ["staticlib", "rlib"]
     -+
     -+[dependencies]
     -+interop = { path = "../interop" }
     -
     - ## rust/xdiff/src/lib.rs (new) ##
  -:  ---------- >  8:  cd04ed5aa7 help: report on whether or not Rust is enabled
  3:  6c47401ba0 !  9:  fcdfc55fb7 github workflows: install rust
     @@ Commit message
              the Rust toolchain, the Rust target triple must be set to
              x86_64-pc-windows-gnu for make (win build), and
              x86_64-pc-windows-msvc for meson (win+Meson build).
     +      * MSVC builds: Rearrange PATH to look in /mingw64/bin and /usr/bin
     +        last.
            * On musl: libc differences, such as ftruncate64 vs ftruncate, were
              not accounted for until Rust version 1.72.0. No older version of
              Rust will work on musl for our needs.
     @@ .github/workflows/main.yml: jobs:
           outputs:
             enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
             skip_concurrent: ${{ steps.check-ref.outputs.skip_concurrent }}
     -+      rust_version_minimum: 1.61.0
     ++      rust_version_minimum: 1.63.0
      +      rust_version_windows: 1.78.0
      +      rust_version_musl: 1.72.0
      +      ## the rust target is inferred by rustup unless specified
     @@ .github/workflows/main.yml: jobs:
           steps:
           - uses: actions/checkout@v4
           - uses: git-for-windows/setup-git-for-windows-sdk@v1
     ++      with:
     ++        flavor: full
      +    - name: Install rustup via github actions
      +      uses: actions-rs/toolchain@v1
      +      with:
  4:  8e350700bc ! 10:  6eeef4081c win+Meson: do allow linking with the Rust-built xdiff
     @@ Commit message
           handling from an earlier patch]
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     - ## .github/workflows/main.yml ##
     -@@ .github/workflows/main.yml: jobs:
     -     steps:
     -     - uses: actions/checkout@v4
     -     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     -+    - name: ensure that libuserenv.a is present
     -+      shell: bash
     -+      run: |
     -+        cd /mingw64/lib && {
     -+          test -f libuserenv.a ||
     -+          /c/Program\ Files/Git/mingw64/bin/curl -Lo libuserenv.a \
     -+            https://github.com/git-for-windows/git-sdk-64/raw/HEAD/mingw64/lib/libuserenv.a
     -+        }
     -     - name: Install rustup via github actions
     -       uses: actions-rs/toolchain@v1
     -       with:
     -
       ## config.mak.uname ##
      @@ config.mak.uname: ifeq ($(uname_S),MINGW)
       		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
       	CC = gcc
       	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
       		-fstack-protector-strong
     -
     - ## meson.build ##
     -@@ meson.build: elif host_machine.system() == 'windows'
     -   ]
     - 
     -   libgit_dependencies += compiler.find_library('ntdll')
     -+  libgit_dependencies += compiler.find_library('userenv')
     -   libgit_include_directories += 'compat/win32'
     -   if compiler.get_id() == 'msvc'
     -     libgit_include_directories += 'compat/vcbuild/include'
  5:  a00cbf7bcb = 11:  1e13d6c45f github workflows: upload Cargo.lock
  6:  922d506ed6 <  -:  ---------- ivec: create a vector type that is interoperable between C and Rust
  -:  ---------- > 12:  1c923a71f2 build: new crate, build-helper
  7:  3a6f822e2a ! 13:  6a27e07e63 xdiff/xprepare: remove superfluous forward declarations
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff/xprepare: remove superfluous forward declarations
     +    build-helper: link against libgit.a and any other required C libraries
      
     -    Move xdl_prepare_env() later in the file to avoid the need
     -    for forward declarations.
     +    Don't link against the C libraries when building with Make or Meson.
     +    Run cargo tests like this:
     +    cd rust && cargo clean && USE_LINKING=true cargo test
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     - ## xdiff/xprepare.c ##
     -@@ xdiff/xprepare.c: typedef struct s_xdlclassifier {
     + ## rust/build-helper/Cargo.toml ##
     +@@ rust/build-helper/Cargo.toml: version = "0.1.0"
     + edition = "2021"
       
     - 
     - 
     --static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags);
     --static void xdl_free_classifier(xdlclassifier_t *cf);
     --static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
     --			       unsigned int hbits, xrecord_t *rec);
     --static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
     --			   xdlclassifier_t *cf, xdfile_t *xdf);
     --static void xdl_free_ctx(xdfile_t *xdf);
     --static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
     --static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
     --static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
     --static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
     --
     --
     --
     --
     - static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
     - 	cf->flags = flags;
     - 
     -@@ xdiff/xprepare.c: static void xdl_free_ctx(xdfile_t *xdf) {
     - }
     - 
     - 
     --int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
     --		    xdfenv_t *xe) {
     --	long enl1, enl2, sample;
     --	xdlclassifier_t cf;
     --
     --	memset(&cf, 0, sizeof(cf));
     --
     --	/*
     --	 * For histogram diff, we can afford a smaller sample size and
     --	 * thus a poorer estimate of the number of lines, as the hash
     --	 * table (rhash) won't be filled up/grown. The number of lines
     --	 * (nrecs) will be updated correctly anyway by
     --	 * xdl_prepare_ctx().
     --	 */
     --	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
     --		  ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
     --
     --	enl1 = xdl_guess_lines(mf1, sample) + 1;
     --	enl2 = xdl_guess_lines(mf2, sample) + 1;
     --
     --	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
     --		return -1;
     --
     --	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
     --
     --		xdl_free_classifier(&cf);
     --		return -1;
     --	}
     --	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
     --
     --		xdl_free_ctx(&xe->xdf1);
     --		xdl_free_classifier(&cf);
     --		return -1;
     --	}
     + [dependencies]
      -
     --	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
     --	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
     --	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
     --
     --		xdl_free_ctx(&xe->xdf2);
     --		xdl_free_ctx(&xe->xdf1);
     --		xdl_free_classifier(&cf);
     --		return -1;
     --	}
     --
     --	xdl_free_classifier(&cf);
     --
     --	return 0;
     --}
     --
     --
     - void xdl_free_env(xdfenv_t *xe) {
     - 
     - 	xdl_free_ctx(&xe->xdf2);
     -@@ xdiff/xprepare.c: static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2
     - 
     - 	return 0;
     - }
     +
     + ## rust/build-helper/src/lib.rs ##
     +@@
     ++use std::collections::HashMap;
     ++use std::path::PathBuf;
      +
     -+int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
     -+		    xdfenv_t *xe) {
     -+	long enl1, enl2, sample;
     -+	xdlclassifier_t cf;
      +
     -+	memset(&cf, 0, sizeof(cf));
     ++fn parse_bool_from_str(value: &str) -> bool {
     ++    match value {
     ++        "1" | "true"  | "yes" | "on"  => true,
     ++        "0" | "false" | "no"  | "off" => false,
     ++        _ => false
     ++    }
     ++}
     ++
     ++fn parse_bool_from_option(value: Option<&String>, default: bool) -> bool {
     ++    match value {
     ++        Some(v) => {
     ++            parse_bool_from_str(v.as_str())
     ++        },
     ++        None => default,
     ++    }
     ++}
      +
     -+	/*
     -+	 * For histogram diff, we can afford a smaller sample size and
     -+	 * thus a poorer estimate of the number of lines, as the hash
     -+	 * table (rhash) won't be filled up/grown. The number of lines
     -+	 * (nrecs) will be updated correctly anyway by
     -+	 * xdl_prepare_ctx().
     -+	 */
     -+	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
     -+		  ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
     ++/// To build without linking against C libraries run `USE_LINKING=false cargo build`
     ++/// To run tests set GIT_BUILD_DIR and run `USE_LINKING=true cargo test`
     ++pub struct BuildHelper {
     ++    crate_env: HashMap<String, String>,
     ++}
      +
     -+	enl1 = xdl_guess_lines(mf1, sample) + 1;
     -+	enl2 = xdl_guess_lines(mf2, sample) + 1;
      +
     -+	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
     -+		return -1;
     ++impl BuildHelper {
     ++    pub fn new(crate_env: HashMap<String, String>) -> Self {
     ++        let it = Self {crate_env};
      +
     -+	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
     ++        let dir_crate = it.dir_crate();
     ++        let dir_workspace = dir_crate.parent().unwrap();
     ++        let dir_git = dir_workspace.parent().unwrap();
     ++        let dir_interop = dir_git.join("interop");
     ++        if !dir_interop.exists() {
     ++            std::fs::create_dir(dir_interop.clone()).unwrap();
     ++        }
      +
     -+		xdl_free_classifier(&cf);
     -+		return -1;
     -+	}
     -+	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
     ++        it
     ++    }
      +
     -+		xdl_free_ctx(&xe->xdf1);
     -+		xdl_free_classifier(&cf);
     -+		return -1;
     -+	}
     ++    pub fn crate_name(&self) -> String {
     ++        self.crate_env["CARGO_PKG_NAME"].clone()
     ++    }
      +
     -+	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
     -+	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
     -+	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
     ++    pub fn dir_crate(&self) -> PathBuf {
     ++        PathBuf::from(self.crate_env["CARGO_MANIFEST_DIR"].clone())
     ++    }
      +
     -+		xdl_free_ctx(&xe->xdf2);
     -+		xdl_free_ctx(&xe->xdf1);
     -+		xdl_free_classifier(&cf);
     -+		return -1;
     -+	    }
     ++    pub fn build(self) {
     ++        let use_linking = parse_bool_from_option(self.crate_env.get("USE_LINKING"), self.crate_env.get("CARGO_TARGET_DIR").is_none());
     ++        let dir_crate = self.dir_crate();
     ++        let dir_git = dir_crate.parent().unwrap().parent().unwrap();
      +
     -+	xdl_free_classifier(&cf);
     ++        println!("cargo:rerun-if-changed={}", dir_git.display());
      +
     -+	return 0;
     ++        if use_linking {
     ++            if let Some(git_build_dir) = self.crate_env.get("GIT_BUILD_DIR") {
     ++                let mut path_git_build_dir = PathBuf::from(git_build_dir);
     ++                path_git_build_dir = path_git_build_dir.canonicalize().unwrap();
     ++                if !path_git_build_dir.is_dir() {
     ++                    panic!("'GIT_BUILD_DIR' is not a directory: {}", path_git_build_dir.display());
     ++                }
     ++                println!("cargo:rustc-link-search=native={}", git_build_dir);
     ++            } else {
     ++                panic!("environment variable 'GIT_BUILD_DIR' is not set");
     ++            }
     ++
     ++            println!("cargo:rustc-link-lib=static=git");
     ++            println!("cargo:rustc-link-lib=pcre2-8");
     ++            if self.crate_env.get("ZLIB_NG").is_some() {
     ++                println!("cargo:rustc-link-lib=z-ng");
     ++            } else {
     ++                println!("cargo:rustc-link-lib=z");
     ++            }
     ++        } else {
     ++            println!("cargo:warning={} is not linking against C objects, `USE_LINKING=true cargo test`", self.crate_env["CARGO_PKG_NAME"]);
     ++        }
     ++    }
      +}
     ++
     ++
  8:  c7cd71dae0 <  -:  ---------- xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  9:  1096c8f0a4 <  -:  ---------- xdiff: make fields of xrecord_t Rust friendly
 11:  7ea2dccd71 <  -:  ---------- xdiff: replace chastore with an ivec in xdfile_t
 12:  d8f561e173 <  -:  ---------- xdiff: delete nrec field from xdfile_t
 13:  15c2854a32 <  -:  ---------- xdiff: delete recs field from xdfile_t
 14:  3dacb2c09d <  -:  ---------- xdiff: make xdfile_t more rust friendly
 15:  9fdd23acf6 <  -:  ---------- xdiff: implement xdl_trim_ends() in Rust
  -:  ---------- > 14:  fa33440568 build-helper: cbindgen, let crates generate a header file
  -:  ---------- > 15:  df837fdb4d varint: use explicit width for integers
  -:  ---------- > 16:  17143ced6f build: new crate, misc
  -:  ---------- > 17:  89bb7c3613 misc: use BuildHelper
  -:  ---------- > 18:  3c521fa2e4 misc::varint: reimplement as test balloon for Rust

-- 
gitgitgadget
