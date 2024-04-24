Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EC16D9A9
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982487; cv=none; b=RS103f0cUH452SWiyS8YgoW5DkI9HgqAkyxUEqxoGVtD2dl1DV07XpJDIsKaDk4WxLqjJwpVWugiluYlCIw67AzX9WQaFpDt0pJ5WqSdQS5jLG1Ufp8zklyrzWqAOoI2pLvHgC2v27tEc/YU9jvI6uRXau4CYMwUdpCxO+q05vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982487; c=relaxed/simple;
	bh=TpJPYq5kkPXmVPbQaZJqtAICRxHYQmwB3VlR1QRsbik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FqvwBYT89rZ5GgNq7GxzfjocXppcUcyk5ZJ/+X4tGQI6GU5CnKdqeqp25hILyGNLK0ZuqOTBh31C2TV7Zp5rLXa76C9lBc9ZRGPgxDBr0YweBja6wFAI1Y6eTGuaJ88Yd3h5yvlpwX9knLs3Sqcc8UBupmiRHe+VyVEmJdYDFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGqZ9y/z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGqZ9y/z"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab7fc5651so1787077b3.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713982485; x=1714587285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBcQAdMH6NoHmovwhKFEeF1h0OdXBYsVHIb67y8iJpI=;
        b=ZGqZ9y/zMg5w3hyixjt3iGq4+gkSM/25ydlq9YAxdiuA/qd64fb7EqJOXs7/ou+mTC
         Cfd/6w7IBrgiJGHtFyMgt/eVcdd3xD/xh3FMRue6TRUs271odNYUDngfGlBxKzsq+CCE
         N3Ambb77Yy90lmaCo+IZmeBTHPfcsYSyhp8KLW7ZvePYjDwWHVVXn1ul80A8XIapulmT
         eHBaIHV2oBsX8GBRxNE6+5r9G3TeiMRYlugZv7Gh9WsQyy1p4Qcm02LbLa8iJffz1C5b
         Qc+oVyNPmVbOK7AHyVlOYes++GnB7KQxJ14dVtY15FWqScKoVabk443t/LmC26TTRliN
         cJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713982485; x=1714587285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBcQAdMH6NoHmovwhKFEeF1h0OdXBYsVHIb67y8iJpI=;
        b=um4cnqBDsBXgut32Qu2EXezT7Pit3mkPo9i+0BPRJ0u43/wbNlG2l/uadUIiPmvcPC
         ACebAopMRd2k37UI0E0jwF5/p5uGXHts0D/iDg0WdOhiVUgY1CWuEuIl74eUiMKlWdoS
         OW3MKalzmMaw3E2QUeu56nM+kzQs1FnSCUk9LN2frQaS50bymEwZ1ntMD6kEgUNzZ/7T
         tmDdvMdW67hjuEYSy/AXLn/jPPuw8tUYBBxBiW15oIuIxMfHTOkphjlZgjn825sYi0gF
         fQg4xEb/UKdZ6NA+nmk1mjBeQ9AIwqWvVFAtthINIVwhj6g6Wiz5zdtl5iXUvfDEUdRj
         iHvQ==
X-Gm-Message-State: AOJu0YzuZBesMgHURkHadU19D7tg+fJWU6b6xEgbZp+96zHQdw7FQh6Y
	JoKbU3lb09KpNTcvAF0nMA+ybxcN/+vTu1FM/J3VD7qj1Gpz/MoQ7k5ADMb6vEFXk0S/EkrJPfp
	k5rwk7nK+lPSDrSQ9bKrpFALyS4HcfS6yY4uCHVxo7qs9H/M5c3ae1Z4bGBKWIvm/lgXIOeJrFo
	YhtRAGCtjrKmv8armTwWBFMHRNtB6xyKMMMQBjtuU=
X-Google-Smtp-Source: AGHT+IEnPlkbMQi79AdstPHqdUbh2wWr4MEe94/QjxgU9WNrI6konh4UeJ1+iT711Zf/jLpxksxmY8ErEVjOLw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a05:6902:c0b:b0:de5:2325:72a1 with SMTP
 id fs11-20020a0569020c0b00b00de5232572a1mr1106072ybb.4.1713982484641; Wed, 24
 Apr 2024 11:14:44 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:14:42 -0700
In-Reply-To: <cover.1709673020.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709673020.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <ba9d24c6445de309226bf7c165499f1969807fef.1713982389.git.steadmon@google.com>
Subject: [PATCH v3] fuzz: link fuzz programs with `make all` on Linux
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Since 5e47215080 (fuzz: add basic fuzz testing target., 2018-10-12), we
have compiled object files for the fuzz tests as part of the default
'make all' target. This helps prevent bit-rot in lesser-used parts of
the codebase, by making sure that incompatible changes are caught at
build time.

However, since we never linked the fuzzer executables, this did not
protect us from link-time errors. As of 8b9a42bf48 (fuzz: fix fuzz test
build rules, 2024-01-19), it's now possible to link the fuzzer
executables without using a fuzzing engine and a variety of
compiler-specific (and compiler-version-specific) flags, at least on
Linux. So let's add a platform-specific option in config.mak.uname to
link the executables as part of the default `make all` target.

Since linking the fuzzer executables without a fuzzing engine does not
require a C++ compiler, we can change the FUZZ_PROGRAMS build rule to
use $(CC) by default. This avoids compiler mis-match issues when
overriding $(CC) but not $(CXX). When we *do* want to actually link with
a fuzzing engine, we can set $(FUZZ_CXX). The build instructions in the
CI fuzz-smoke-test job and in the Makefile comment have been updated
accordingly.

While we're at it, we can consolidate some of the fuzzer build
instructions into one location in the Makefile.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Changes in V3:
* Dropped CI config patch; no longer needed since we don't use CXX in
  fuzzer build rules anymore

Changes in V2:
* Rebased onto master
* Fixed compiler mismatch issue when we override CC but not CXX
* Consolidated some of the fuzzer Makefile definitions in one location

Range-diff against v2:
1:  e55b691272 < -:  ---------- ci: also define CXX environment variable
2:  8846a7766a = 1:  ba9d24c644 fuzz: link fuzz programs with `make all` on Linux

 Makefile                            | 51 +++++++++++++++++------------
 ci/run-build-and-minimal-fuzzers.sh |  2 +-
 config.mak.uname                    |  1 +
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index c43c1bd1a0..b9e97ad3b9 100644
--- a/Makefile
+++ b/Makefile
@@ -409,6 +409,9 @@ include shared.mak
 # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
 # that implements the `fsm_os_settings__*()` routines.
 #
+# Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
+# programs in oss-fuzz/.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -752,23 +755,6 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
 
 ETAGS_TARGET = TAGS
 
-# If you add a new fuzzer, please also make sure to run it in
-# ci/run-build-and-minimal-fuzzers.sh so that we make sure it still links and
-# runs in the future.
-FUZZ_OBJS += oss-fuzz/dummy-cmd-main.o
-FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
-FUZZ_OBJS += oss-fuzz/fuzz-config.o
-FUZZ_OBJS += oss-fuzz/fuzz-date.o
-FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
-FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
-.PHONY: fuzz-objs
-fuzz-objs: $(FUZZ_OBJS)
-
-# Always build fuzz objects even if not testing, to prevent bit-rot.
-all:: $(FUZZ_OBJS)
-
-FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
-
 # Empty...
 EXTRA_PROGRAMS =
 
@@ -2372,6 +2358,29 @@ ifndef NO_TCLTK
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 
+# If you add a new fuzzer, please also make sure to run it in
+# ci/run-build-and-minimal-fuzzers.sh so that we make sure it still links and
+# runs in the future.
+FUZZ_OBJS += oss-fuzz/dummy-cmd-main.o
+FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
+FUZZ_OBJS += oss-fuzz/fuzz-config.o
+FUZZ_OBJS += oss-fuzz/fuzz-date.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
+.PHONY: fuzz-objs
+fuzz-objs: $(FUZZ_OBJS)
+
+# Always build fuzz objects even if not testing, to prevent bit-rot.
+all:: $(FUZZ_OBJS)
+
+FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
+
+# Build fuzz programs when possible, even without the necessary fuzzing support,
+# to prevent bit-rot.
+ifdef LINK_FUZZ_PROGRAMS
+all:: $(FUZZ_PROGRAMS)
+endif
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
 
@@ -3857,22 +3866,22 @@ cover_db_html: cover_db
 #
 # An example command to build against libFuzzer from LLVM 11.0.0:
 #
-# make CC=clang CXX=clang++ \
+# make CC=clang FUZZ_CXX=clang++ \
 #      CFLAGS="-fsanitize=fuzzer-no-link,address" \
 #      LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
 #      fuzz-all
 #
+FUZZ_CXX ?= $(CC)
 FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 
 .PHONY: fuzz-all
+fuzz-all: $(FUZZ_PROGRAMS)
 
 $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
-	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
+	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
-fuzz-all: $(FUZZ_PROGRAMS)
-
 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal-fuzzers.sh
index a51076d18d..797d65c661 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -7,7 +7,7 @@
 
 group "Build fuzzers" make \
 	CC=clang \
-	CXX=clang++ \
+	FUZZ_CXX=clang++ \
 	CFLAGS="-fsanitize=fuzzer-no-link,address" \
 	LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
 	fuzz-all
diff --git a/config.mak.uname b/config.mak.uname
index d0dcca2ec5..9107b4ae2b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,7 @@ ifeq ($(uname_S),Linux)
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
 	endif
+	LINK_FUZZ_PROGRAMS = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease

base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
-- 
2.44.0.769.g3c40516874-goog

