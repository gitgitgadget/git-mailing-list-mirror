Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B211B6CEE
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032672; cv=none; b=rl/mRq0AEhkzcYWyigrY7UgjVydLJkuBfv1EEEGeIKR5WjkkrvlppCboeEmYvHehJMzlNa9lI56awArqqYviNBTCws34YwYq4/JY8TGjUvPW9de3GiuMWD/nVIMhIFykH3Lrn1ibnpLvl+9CNacAxJ5OZwyp2eSt3rSk1d+16PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032672; c=relaxed/simple;
	bh=5oOdSD4Q1+6jV5rEDdFE+B0q0ZJyFB+3y4Fxjzp9r/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PMY5CIPcLHR8TW5SG+wcdov/tjVqUf/WaF7ybOSvRM1/kzIeyfkb9NHsCe6rE/+9Hicn7rRpW+tv7TDMzBf0PjjruONhfd4k2/VU10N2TxKHzK8rVj7DNkZoeBEOKRXD17v2JDzyZkYFIDz/zbw6QVgAf0OAGts809vwTL+E3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIvRp/1A; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIvRp/1A"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159159528so548714276.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729032669; x=1729637469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OCxwM4M+ooQN/ssD4sIZCmHX2H5Z5zktY4rJthYT9U=;
        b=QIvRp/1AoU21N7v2W3nylhp5xO4qQPl5vAGSemZXWJW/5haDvKMZgvCFR8wSP0rhnc
         27i6MJODiLA96Qv3LNSFBAvbRAErECyulBKl64GI4kJ3A8Kvb/S0kv1k6XbDEnFtKDay
         sLUimcC9KBagvjjwji1fuTGEu5WErgMeK23INcPEFV7cPK4OsKaMmzEe5xqLGA8kS6dN
         fJIe4pJdxzJFmRkxT7JWLP43cxT/9a3S+QX7+3gSmRTe+RNPnSa2WZ2SF0bXq7JnlhgQ
         ZYBG0qylTcFM9YpjrfENooUhTJua1UgVO93fZ5Aa5/BSd2UfFVxaR9Hpm2otqgDgN18Z
         6pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032669; x=1729637469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OCxwM4M+ooQN/ssD4sIZCmHX2H5Z5zktY4rJthYT9U=;
        b=DEhYpUkNPEQqRypx3v1Sb6RYIyam1tQolapiS25AkUr++Uimu2aLHCmXrP9t3lyTR+
         Uv7SSJRThuDXAfZ3pDceYOSFme2+69LTR1wHK8v0nI7aLR7/CjQrpcelHfVNk8Hdt1S8
         oJaXucNW0cyXMdU0FYxloxlKs2QfibFLW8J98zbOPqip5trKF8tkwtIiAaGIqra/aDlP
         e8q/P6b0z1IX1gp6Rh4USyblMYUvDjkRYiSTzH0fjkNY//RdPFblE8UFVBHwznfogO7i
         nB1tf50CwqS5r6Tx1pngIAT2dr8/39/NEPiCkGbyi4Z4ppQHCJ5aXb/S1P732tW4zKUu
         U1mA==
X-Gm-Message-State: AOJu0YxONCp/bKORilUCJAVrNF75Yrr0dXFY5/1OPLFi/D2/RqLvbUWe
	GBVnyhBOOh5E4Aj2Wr8cTuFrULmPIaGG2SxqHreoDuky0Wyrqc4avhV5nL9Do9YnEcXIR8VT7rE
	bYuCbv6owiTlMyh8Ti6rfsDjt2S1w+QFphrKXNWUnHD+zsbwA54RHHLo6GBNCBFM2hx2SdMC61u
	l8HIyxJ8bR8VhNsIx6zqKKqwVY5VfFpxZRxhNgDMw=
X-Google-Smtp-Source: AGHT+IGGspnFbl1YrP4f2VlglnZ2MhgIjkfGP6lq7TtuTf3vhoM6E4M95oftfysUi4/3k8jxFA5IfqPydZAang==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:ddcc:6d3c:e4d6:3076])
 (user=steadmon job=sendgmr) by 2002:a25:eb01:0:b0:e24:b971:c4cb with SMTP id
 3f1490d57ef6-e29772b8abcmr7292276.2.1729032668827; Tue, 15 Oct 2024 15:51:08
 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:50:57 -0700
In-Reply-To: <cover.1729032373.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1729032373.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <15ce989de8bff1080a018fd9dee678856180a45f.1729032373.git.steadmon@google.com>
Subject: [PATCH v5 5/5] Makefile: add option to build and test libgit-rs and libgit-rs-sys
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, emrass@google.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com, 
	rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
to their respective Makefiles so they can be built and tested without
having to run cargo build/test.

Add build variable, INCLUDE_LIBGIT_RS, that when set, automatically
builds and tests libgit-rs and libgit-rs-sys when `make all` is run.

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                              | 26 ++++++++++++++++++++++++++
 contrib/libgit-rs/libgit-sys/build.rs |  2 +-
 t/Makefile                            | 16 ++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1790c737bd..f191ee32bb 100644
--- a/Makefile
+++ b/Makefile
@@ -412,6 +412,9 @@ include shared.mak
 # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
 # programs in oss-fuzz/.
 #
+# Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
+# test the Rust crates in contrib/libgit-rs/ and contrib/libgit-rs/libgit-sys/.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -2181,6 +2184,13 @@ ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
+ifdef INCLUDE_LIBGIT_RS
+	# Enable symbol hiding in contrib/libgit-rs/libgit-sys/libgitpub.a
+	# without making us rebuild the whole tree every time we run a Rust
+	# build.
+	BASIC_CFLAGS += -fvisibility=hidden
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -3873,6 +3883,22 @@ build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
+.PHONY: libgitrs-sys
+libgitrs-sys:
+	$(QUIET)(\
+		cd contrib/libgit-rs/libgit-sys && \
+		cargo build \
+	)
+.PHONY: libgitrs
+libgitrs:
+	$(QUIET)(\
+		cd contrib/libgit-rs && \
+		cargo build \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgitrs
+endif
+
 contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
 	$(LD) -r $^ -o $@
 
diff --git a/contrib/libgit-rs/libgit-sys/build.rs b/contrib/libgit-rs/libgit-sys/build.rs
index 8d74120191..d6d6210ab2 100644
--- a/contrib/libgit-rs/libgit-sys/build.rs
+++ b/contrib/libgit-rs/libgit-sys/build.rs
@@ -14,7 +14,7 @@ pub fn main() -> std::io::Result<()> {
         .env_remove("PROFILE")
         .current_dir(git_root.clone())
         .args([
-            "CFLAGS=-fvisibility=hidden",
+            "INCLUDE_LIBGIT_RS=YesPlease",
             "contrib/libgit-rs/libgit-sys/libgitpub.a",
         ])
         .output()
diff --git a/t/Makefile b/t/Makefile
index b2eb9f770b..066cb5c2b4 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -169,3 +169,19 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
+
+.PHONY: libgitrs-sys-test
+libgitrs-sys-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs/libgit-sys && \
+		cargo test \
+	)
+.PHONY: libgitrs-test
+libgitrs-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs && \
+		cargo test \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgitrs-sys-test libgitrs-test
+endif
-- 
2.47.0.rc1.288.g06298d1525-goog

