Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81143749FB
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188363; cv=none; b=OhqInHguUVjc1O3trf0dYKk2XRoEGXah3XsjXi5S2H15KLDtgBzKXFWA2XSID+3yN3mmxC42QIhYzXDJTyfbXmR+38tnpupk0i+p/V00W5Fd4jQU44eSht0I1vP1qNX3WwT0bT57LmQ2yF4i7BYeXj6akk/LuQMuFKiicr70g5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188363; c=relaxed/simple;
	bh=VM8BaqBri2H0yRBs6f9/5ih67X1DWHl5SVP/L+AVCiI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nocTnBDJYCKdrFT6dDxihEFNgYucpq1AJeaECn7nMGWPT4kUL9lNH6qUPHV7hG4CaG1tdlo98i7fbo7IgWM6VVq0CvoJryDVfUg2BamzZ0dnFz/dSGXe5DO0BfRgpGLSLHW+DCid4TmSTqCB3sRMCk834ibjH78g+uX7VitXXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO9z0Wtx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO9z0Wtx"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso785551a91.3
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783188361; x=1783793161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DoJjRdfXUWxqjoZP25nCMsJqpD38zElBqiEcVpiqsqg=;
        b=HO9z0Wtxh8hVdLh/4L+RgcEp/qYeU+FZE9+dKO/F8L3Ts4RDwK+jkxfrPHXPVm1gUj
         KvokdfflR3D07eZkbEZWP8w491ZSTqRXCjXGSrIbxUtN/GYQq8Xt/V61q2/PM5hc0MWH
         Qa5wdNmCadrBp5xkeakvkEGCYWDYkOimZURtlox4mWIuHMcJBGijcqdWC3wy03FAmkME
         Twers+Voug9zu5lGgXJ93JuJpsNkSbkpq52oHeXe9kLsIGl1/UPFYOx2gNmy1eRErRdA
         DSyDfYyuSksee3yanW2WrZiiaEOgaoibficiKA3Zq6KzBu1SdVOc5Hbx0p1TGNSkwcJ+
         VcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783188361; x=1783793161;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DoJjRdfXUWxqjoZP25nCMsJqpD38zElBqiEcVpiqsqg=;
        b=J97s/gmaWHXV0TMzGsW/R+NISnCZpl3DNzh4O5zVSRTkQh8lE8P0mN+6JCp9o+wQWi
         iHDtTXkZGzeFwxkLIccQq5E+cR/v1Kkf3AN8Y+QknhOMOF7V6Cx7TC5+kcX/kFvnRPud
         T+qrpD/EcXzCh86H/9QxsunP9qyNI0Qc1fQ6Fv+/RjZ3ymOuP61P+2ENKHgpyCjgnz3Z
         QxjSIXwK0x0HIcQAGV6ykfitfErLjp0wCXJscu9M5DK31iGczNAjoLAgYuTQEa7A880I
         SoGzJTAwYwrrBN2cQFuvD25xLG4K5Ax5Mi9rfcUirr4oZ/9/YiWTjrU+Lt0nRWa29eXa
         qrwg==
X-Gm-Message-State: AOJu0YwjLFpdM7SNDm1IbV+ndJicqrBKeG4QiFGjDSGW2RxSQMOA/SKX
	In9vd04Gkzc14adPGA0EjHgxHmfnBYL2L7QhJWHxnO+4wtl1QbWYLuH68wXghQ==
X-Gm-Gg: AfdE7clCr8WUIwm8XE27nTvUmm3CFC79LYWnXdZ9/BJcvlEwHowFGNJvUDSp0/faYmA
	g1bPrdt40slDfzCAr//5OcYhUgzjvgZSlnvwUdF6zJWKQHTt+7AWuIxLjr2sDx3XcmfB8ckQ8+q
	YwYpEUpFXOJwD81DcFHOE6zCfgz5ZttOziiEByaph+XV2hU4DvzMTGPqfu7IHBCxZw3OW31e8Fl
	IpJWAQVzpeZx1xxCW9nUwH4g9wJWQSBE9QPTeU/Ni3GTjBil8tOxFTa9+p11QCjASDpBBwPHe2Q
	GHzs9MgEl3bDOeT4KqUz329kqjV515nW7qfj7a0NAMcfep2Ue48cpi48cNo0Mz2CyMzd/IR2l7m
	soyYhT5I90/RAXQ1LVIeBg5VBomEOdscL4M24WuDzFsEtchMtvPcUhpqL/6sDKSMBlQjXUQZ1nu
	aS7wJgbVRVXNeOrHWYdw==
X-Received: by 2002:a17:90b:5544:b0:381:bc4c:da74 with SMTP id 98e67ed59e1d1-3829fbd8938mr4389034a91.32.1783188360885;
        Sat, 04 Jul 2026 11:06:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.214.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813c4dsm32152174eec.7.2026.07.04.11.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:06:00 -0700 (PDT)
Message-Id: <88fc2e0bd88756a07467bdaf75f6a344d2e58b41.1783188355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
References: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
	<pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jul 2026 18:05:55 +0000
Subject: [PATCH v4 2/2] Makefile: support universal macOS builds via
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
    Shardul Natu <snatu@google.com>,
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
 Makefile | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7db38ecce9..ecada0acb4 100644
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
@@ -3022,8 +3031,30 @@ $(LIB_FILE): $(LIB_OBJS)
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
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)\
+	if test $(words $(RUST_TARGETS)) -gt 1; \
+	then \
+		lipo -create $^ -output $@; \
+	else \
+		cp $< $@; \
+	fi
+endif
 
 .PHONY: rust
 rust: $(RUST_LIB)
-- 
gitgitgadget
