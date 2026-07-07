Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6CE351C20
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443766; cv=none; b=LjUR4bwsIL2soDSdP5wdYRTcax/AP0+rAxGWhQzloXx4KrRnG6ONmqbwxwTBrkFahsYjFUZFu64DsEGvwpec/fvFmUFs4vpZ9KDuZMDw/+gue6i4ki+FdzS8JgS92PmRL28eSdCfFyC+9WsKpXyw9GFGkBoLy5YVxQrwH6IuDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443766; c=relaxed/simple;
	bh=cuU8RC3W9Lk/hrx95nyzvsyc0i49Cy+2TnOdhozT9+g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pTF2gI+pNvnm+OgqQIKKIVzWWM70eM6dpiyN8vsk1uyy/HmV0TsdJ41/LrvNudZ5lDhCV0dtuGrzdAN3DFMUMuMk5cbDQWy89AKvFVPDab11GJaJ2Nv79OjYG5qeUMV2lhtENhIa+DfryFVU9sNhRAGmEPQYhtIOyHzVaiO3O0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g54/q1Us; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g54/q1Us"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ee88fce536so25487256d6.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443764; x=1784048564; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUTcY/V2NbDHBGxFvmbXYYnLSIhm4RzPzbJApRVr2GU=;
        b=g54/q1UsG4CUwI6p4dMNCmS8MfNw+EZ0vo6ypbl+pZZlDszoojkhYHE3mUt84DfulZ
         ONiD6kmV5Px7J/zRer0katA+3i24uedCqUP0WZtHHu0FD6OZ8hXhZWK0I5+gQCXG0JoU
         FH39CVgKjp/gcUQXizrHUKNQ1A4pCmaFpinUkMXLW8V4Myq7X7NDJ0iqXGSOPBD/rcNz
         GKu5RqIANjtrnbqfOojzDxlM2wQXlgP6xBwa+11fQWRDweguspdMDnn7m5gG3esRjqxk
         4klMLdvAJBn5Tvh0hwkdvbo/lYUhtWcp/efWAcjsonAtwJEw/iQAPx5Ufez+nT28Unwy
         /f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443764; x=1784048564;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUTcY/V2NbDHBGxFvmbXYYnLSIhm4RzPzbJApRVr2GU=;
        b=do4XiEpM4ghlSRsOBp51kw+J2P9n0tiSdj002fMBeaUvNzI30Z5A6AdRYJfL/GSf/h
         gOE3UQvYZadfp6m4Yg/WNCPuA0auswdU0qmBytEhhmOYXJSZbxC0zLw/KdbnleNwdubj
         nXmLunr1sYTh/f72+IcXsppktx2BpgYIVxAd0lL6UjuDTrrJQ17xy7nxvccjB7BEw4by
         vhAxDvyftNHseOKjpZ5yU1BM20NiC/sizXhoUfFgM2xvvYrCEHXEZAPsmiNCZCqpBxEg
         WJO8Q5d5I2vF60H/dWFcy/zHPGyLOqzr4RtFrvTllgJguvr9lHaA6f+NhA+rJ86yq/LY
         7n6w==
X-Gm-Message-State: AOJu0Yx7aiw0Lo/5xsjffX7vcOEwn0H+AwPzEYbtiJYn/ZENscx2eUui
	edtKpPpUWdK7AQUABJLZu6+U1pt3yiTHBpqYwr8K4ORKuIc3AhvOqSnlHxAvsA==
X-Gm-Gg: AfdE7cnX6fNsj7SmNqBSG+YGnwg3lgMIhrMujSg5GixcfIBW3dskqrJ34FKY99NYi5l
	xzV4XR7cXAz//ySK27FArYUv4fArw3LTrT9DiIcO5ZGzaEJULPKkC2iyLTufA6Kec8tXguzXGR5
	8eaI9HHlGl0D5egTahIXLe8zO5/vN6SHl5lmFAcaMKBNw6kARIaObxZZm7PWBCzUctzUtlzWIwH
	2G7PXg5/nWmTMyWjn2Eu0uV6+MhGXYdigeTjWAzkaMuulrxniwzoNvoDJP+YfXyHobD5R+zwo+O
	vf5Tj+DKhylYMTq2JoQzjFddMEPLM6Kdg7HVIQzEMimydB4Kq+lhjtOtoj83lZF+Yjq9GMFTVRe
	wPMfuciJruvbvAMNxRW+SvXEMUfxN5mNP2/C1Aqhb2YaJcj+gqj5yz3ih9GKPn/NOclLSqOcPN2
	hb42pEgRJTJnsxKxwmrSgt7h8rMQ==
X-Received: by 2002:ad4:5de4:0:b0:8ce:9cbd:b0ce with SMTP id 6a1803df08f44-8fcb4133967mr71775126d6.34.1783443764098;
        Tue, 07 Jul 2026 10:02:44 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9ad1fsm162484736d6.47.2026.07.07.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:02:43 -0700 (PDT)
Message-Id: <a999be6939284e4fdd9781f01fb9b9214ebc6516.1783443745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
References: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
	<pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 17:02:24 +0000
Subject: [PATCH v7 2/3] Makefile: support universal macOS builds via
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
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
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

Once $(RUST_LIB) is compiled into a universal static archive, the
standard C linker seamlessly links it with the C object files to
produce universal Git executables.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 Makefile | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7db38ecce9..9921af992b 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,14 @@ include shared.mak
 #
 # Building Rust code requires Cargo.
 #
+# Define RUST_TARGETS if you want to cross-compile. If left unspecified, it uses
+# the default Rust target on the system.
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

