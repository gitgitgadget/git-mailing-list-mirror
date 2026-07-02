Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2338D403
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030979; cv=none; b=kwDNukFm7DvOEsdN/jj9/JNEEk1ehGNqd6+leqCN8DQnBqk90L1lBn9Wa7zGEC7C7G1IbyzfWKsZ6yN6Sk2CJEIf+VgT+PgRD/q/wKaSo6oGa+F5hCzXyk4dzY1Mk8geCRTnuJQqGDHkhr8y0VhlffrQnYwmUCkPjEKl5HCOJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030979; c=relaxed/simple;
	bh=SI8CkQ00P0+edBKboprIKXVffsxim5FFbAWvJ3N1iLk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sSeAJKgqKxiSvxBhTUZmDls/v6qNsUyNZRohe26yfjjLkGyjIKburdihR/eMiW1rtQwsNvOUeBiNPPYvtEASgJf1cj2YrXuq5qg3gsYyOFewdSpeoyXc3UziblS5tjA0GTfhGZR+izVc7gZa9gV8Y/096zIJx6kFiDwPq5bOIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD6XJfMC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD6XJfMC"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9217d13c276so122630985a.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783030977; x=1783635777; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4re+4A0BMYRPJXmGaelAInMD/O8Cwli6zWQW4Q+veUI=;
        b=BD6XJfMCEKaaNFJ32HaZWMEGleObObTMMf4bx1QCDl0snejp0jgXewRCe6s0w17T8+
         NiNAl4Ynh1IB4uVJ1RYhnn8jrebexu23BWkxRXMkS0G3JYMYWGxJ6kM3go7k1fnTiwRy
         timcEk3K/dpxe2QSPPrS2AYdhPDMWhoqgKIPsFsoDH5ALlo/PMvWB9mv9h2ARRBMqhfK
         1lRyYkatXrAipLTse1LUYAQ96c2FAmxoafj+/KpiQcpq2SGR5N8ycb6tpsQqXjqBa6S3
         HJjiOKrhwWeN79oCAtNueb5flE+LkLHX6z9MEQWQrAMfY/zMCAPI3aRoRdV9xSuQYTzj
         cO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783030977; x=1783635777;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4re+4A0BMYRPJXmGaelAInMD/O8Cwli6zWQW4Q+veUI=;
        b=GmWTfgssEMJLdZlLGQtAO30cF1f1qHS3hmtBinu6cXdwbJ0bQQ+rnF5oTzmsnBRZ9Z
         Osf2MZGGAq4NG8PeSW/qZ+eI2IGvMOJg30sZOkMp1tx/mN4MlRG/2KiBYEPsjmnmkF0o
         gWagFoLaEGEMfTxGOmDJ60ynmyco3h3IRr2pPfgStq4R63Fu0O8yY7Bw59/aYK1h7agZ
         ImVl/ZZ7iwxq2tEX/iutB5gq09Zxr1r6HgQOhnqtTBcAvxD1Io+9F59yJOvKjz6Cnph5
         FFLfX5XRDIWGIalsHkL/rIdDdFLCuEwGTbnYqmI60NQ1pg/8Etd1gEt1zvleh1eCHBxs
         9BOA==
X-Gm-Message-State: AOJu0YyaMg+6pv+qn7qL26PzPJ4fIdUjs9+/9MNYeD2qCs34XHJ2Y2aW
	hGALSAHAtT8lnaTVOiM7gEihLJsYGUiOVknhwQjp88k6Zm45sBEDk0NyHvy/LaVW
X-Gm-Gg: AfdE7cmb4tFo/RPI54tvB/uetjPJGOOhdjo6UVEv4OtHOJOo5pqrtavnM8f2zdKaLHa
	dL6JjbMkQpZMRFS0fv240FYKS/8SnAh5Af33WRtgDmuOiucP9KcvyADSoG9y4T3uYNKsk9Cx9ZM
	1knQmdxzcNaIWARPwB/kPehnZ09BT0hDhoajcvAeASnsW34cjMLK+QcC3DVIscqxNBxGYkV7vaH
	udEbBeeJUqXlss9GA3Iy66qhA6+EtcN/gXl34S7JGW0j1GC/xq/KPNQe5zIZFhhvTNsIa0ixjkR
	qeN+TbSRhXCPmQLLp89TcF7eeNYkhF1xrrlZzGY1NCoNVHaGEnOUCCZ5mXyPRNQ1sJtytxKOqDk
	iKtbfbjvVFOWuzAojAKQGGV4CjbeRvDMhmXal7ehWWMnkYlA8BvoY3eM1p81QtCaPebl4VIqlnU
	EuwcEp4R+uV6fNuKYD
X-Received: by 2002:a05:620a:8005:b0:915:ab83:6952 with SMTP id af79cd13be357-92e781fe670mr1033053485a.16.1783030977328;
        Thu, 02 Jul 2026 15:22:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.103.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801be828sm319403985a.43.2026.07.02.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:22:56 -0700 (PDT)
Message-Id: <257f5ef42fbb2841036591657e740872635df49b.1783030971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
References: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
	<pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Jul 2026 22:22:51 +0000
Subject: [PATCH v3 2/2] Makefile: support universal macOS builds via
 RUST_TARGETS
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Shnatu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

On macOS, Universal Binaries contain native executable code for
multiple architectures (such as Intel x86_64 and Apple Silicon arm64)
bundled into a single file. This is standard practice for macOS
distribution and CI packaging (such as internal distribution packages
or tooling like Burrito/Homebrew), allowing a single build artifact
to run natively across all Macs without Rosetta emulation or
maintaining separate packages.

When building Git C code for multiple architectures on macOS, the
Apple toolchain (clang) natively supports universal builds via
CFLAGS/LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
automatically compiles and links universal binaries for all C object
files and executables out of the box.

Cargo and rustc, however, do not support multiple "-arch" flags or
emitting universal binaries in a single invocation. Instead, Cargo
requires invoking each target triple independently (e.g., passing
"--target x86_64-apple-darwin" and "--target aarch64-apple-darwin").

To bridge this gap when Rust is enabled:
  1. Allow specifying space-separated target triples in RUST_TARGETS.
  2. Introduce declarative pattern rules (target/%/...) to compile
     each target-specific library slice via Cargo.
  3. On macOS, if multiple targets are specified, use "lipo" (part of
     the mandatory Xcode Command Line Tools) to combine the resulting
     static libraries into target/release/libgitcore.a.
  4. Ensure target directory creation before invoking lipo via
     mkdir_p_parent_template.

Once $(RUST_LIB) is compiled into a universal static archive, the
standard C linker seamlessly links it with the C object files to
produce universal Git executables.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 Makefile | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7db38ecce9..e01f989cd0 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,14 @@ include shared.mak
 #
 # Building Rust code requires Cargo.
 #
+# Define RUST_TARGETS if you want to cross-compile. If left unspecified, it uses
+# the default rust target on the system.
+#
+# On macOS, this supports specifying multiple targets, separated by a space.
+# This will produce a Universal static library using `lipo`.
+#
+# Example: RUST_TARGETS="aarch64-apple-darwin x86_64-apple-darwin"
+#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -941,16 +949,17 @@ LIB_FILE = libgit.a
 
 ifndef NO_RUST
 ifdef DEBUG
-RUST_TARGET_DIR = target/debug
+RUST_BUILD_CONFIG = debug
 else
-RUST_TARGET_DIR = target/release
+RUST_BUILD_CONFIG = release
 endif
 
 ifeq ($(uname_S),Windows)
-RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
+RUST_LIB_NAME = gitcore.lib
 else
-RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
+RUST_LIB_NAME = libgitcore.a
 endif
+RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
@@ -3022,8 +3031,29 @@ $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
 ifndef NO_RUST
+ifeq ($(RUST_TARGETS),)
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+else
+ifneq ($(words $(RUST_TARGETS)),1)
+ifneq ($(uname_S),Darwin)
+$(error Building universal Rust libraries requires macOS (lipo is not available on $(uname_S)))
+endif
+endif
+
+RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
+$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
+	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
+
+$(RUST_LIB): $(RUST_MEMBER_LIBS)
+	@$(call mkdir_p_parent_template)
+	$(QUIET_GEN)\
+	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
+		lipo -create $^ -output $@; \
+	else \
+		cp $< $@; \
+	fi
+endif
 
 .PHONY: rust
 rust: $(RUST_LIB)
-- 
gitgitgadget
