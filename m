Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF213AA3C
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859273; cv=none; b=s0oAyE0Rortw/kxxI056I8ZdT3Uuyzu3VciVjIq3zp9gPdrDoJva0YMs+zia68OK3wrRpLbIK6IG6gH4jf50800G4ujYIu5ew1c4sOIMvxA8qWj//lWZ+7v9QYEuBgFcyHpKPUl3G45vbzQ1oUO/Sq0JNx54IxitzHuZZRWna/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859273; c=relaxed/simple;
	bh=D5szERKR40zHZ46Nmeg14E7DtGJyF3tOTnqMDsn6H1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAkiw1PsKT+ktIT96NqSIKD5oTz2ZwueOeNpuRjxHSfwlonb4s1LMntGgNGgntfJZfTpO3123ke4xDYWhZIt2b5mvyfkvOjjM4sfP0/XHl5YBjUvMdFAueL8veqKX8FynIXad6L3DPVqXkOHWRS65/lcw/AQ48CY4c71jNf4Vng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKzQPPOM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKzQPPOM"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6156cef8098so900117b3.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712859271; x=1713464071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ed++p66JXGPUWfHXQT3Hlh+XY93+I+hwqpUniCBguNI=;
        b=ZKzQPPOMiXKxHy6Zq37h2vjXTw1NVO3dX2X6Te7XVZxV624kygWwxqNhKJFUeFXmR9
         0iS0JevIwkhJBTYg2D6A/fmo+3QUH/QRESw1ZhyyxlkpJB2qGQwn85I0jyBTbU36ZTYS
         ssdB29c5sSmSuqwSBlSpi/WCkQsiW+9cm7oXYh9aNQlLJWujtj6AUaHj95WQ/Jbcptj9
         xETGSHnbkBhgRsXp4O3nVouUhsSllYRXEWKX3KL/Zq8fK+6eJRqPJWEgC9IDOEaUEIt/
         WvbvglLQ6hST3+G5UFdCU4bJQpmy4NfYVrDLFu8fzNw+Y2fjk1e9FAdtwlNWabjEvhjd
         Waiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859271; x=1713464071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ed++p66JXGPUWfHXQT3Hlh+XY93+I+hwqpUniCBguNI=;
        b=XYi0yZojw46QCxTb2ip63uFTEN4FvbL8g3C8Dp+RpTjvWoH4uwYgLfybnr+fFq3RGa
         LsZv2/qXQxpb2OoRYjPdHWQ/YtZV00sl8cP5wspeD3W59Wx8/SzTyUcIyd8xGuvzmaGV
         1y1wRYou7y8rSQyTh7roNWJSqq+C20qdKVY9RynEwEg/iixV7CottkOC7eOkJuSVWZCH
         5LWq6OjDNMFMFTZx6OxQd18YdF7h7vCgeEcbAbc0jGYse+eFir6XBUQZc8tegNRDYjCD
         yCIP8VqJV0PNzdPoZ2llrHKf7BMbPnJdZTJ64KZJeuDpzKvPrhWt4VCAJeK/Eaycuptb
         DY+A==
X-Gm-Message-State: AOJu0YwxZc1HRK8PFDoUEKUrtMy8B4furnv5O6ACkBW3fIANT6PbL+vL
	B+VvNjAbT3+RJzLO05cVkTUggr92TndSCE6gH+sXLSqwWIyfg6PrmEy1kPDDQgmFxGy2yZSo5rl
	0GTd5Q+SrYbQIfHusWStE1/29ydPH+a7EuEneocca0KiJCRP9xblUzLNeDvPjcN86s5dGCUWUgI
	U5ABKtcW5ZXJ0dqN9EaBMyKEDbJPVAZgLRmUQIkFA=
X-Google-Smtp-Source: AGHT+IErsG50RNwftoiOnHbuFVDZ2A+pD6hFe+erfIr3EBccJf/pTUtoyU157viuQApjv+cxnV1HE0wR8TGZkA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5d8a:5a85:8673:4f76])
 (user=steadmon job=sendgmr) by 2002:a05:6902:114b:b0:dcc:c57c:8873 with SMTP
 id p11-20020a056902114b00b00dccc57c8873mr81167ybu.9.1712859270770; Thu, 11
 Apr 2024 11:14:30 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:14:25 -0700
In-Reply-To: <cover.1712858920.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709673020.git.steadmon@google.com> <cover.1712858920.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <8846a7766a1e14373272f7115d37a3b774f51a71.1712858920.git.steadmon@google.com>
Subject: [PATCH v2 2/2] fuzz: link fuzz programs with `make all` on Linux
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
-- 
2.44.0.683.g7961c838ac-goog

