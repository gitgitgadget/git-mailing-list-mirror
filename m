Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3B13D52E
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054903; cv=none; b=bylGrl/0Xftj4wEdxVe3zPdUSdFlzB64gPsY13aAeTvjtVu+W1GA9h8sF8EadzECZvRsWfkiN8mYxVTQJEMWTxBMm8xbB5L3Umkk2RCReDBpaEZX7LrWTBBkGywXlpuk8+ca7KVIsYmcYhuvjz3JIWOcCozA2dTAP2Ed5JojfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054903; c=relaxed/simple;
	bh=Y17aJ8/R4RPf1LavwtDwcdDRFr3vPzUlnJ3i2ltEGFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rfi6fJH4oe4qXaVEsdx6qeSEXqhNhotEl2L3u6twYQ0suRYj8mxG+XCaeInbnn1qfOH3LObwdesNtZsJ7Wd/gYfJpMHTWzCsTMmP/1LB8kV4ZgEPXknY0ltXY4uUNTE/SdtUZncC+ztBv0OwrzhQpA2n50/af/RrwxjaxXis5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WR4qwM/T; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WR4qwM/T"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso162902276.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723054900; x=1723659700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+BLo8+jhLu6o6opISMFG79Syv4fDQp+Eph2WfIbqEQ=;
        b=WR4qwM/TZlEtMDeydQQ2zlu8JEsbc5pJf0UncPu2VF2Kh4v50pnYayq8Pph6x1DZQ5
         M7sqlE+L3FQmQjte7/aUYz3FS0uMGF8F8G7h8fNEuaI+AQcuwokyRxPDtxXEKByyIaYI
         7kT2CmhKMMxKa0adJ63k9dAvjRKyFxO9+gfeN4RU+RbBF2if1lfZhubjtwnTUUUl01nd
         sP/vz+QKVFpNhZG0MhAzdYVSofyTqitKBvWA+a21OmP4ZEcmSgGhcAGiYUnlDpU40h0d
         Oo31g01iik2CWXf+KDf1ZUibijd3jaP7J2Ab24Dkfjx+ortfybKlgjh0R+moGdtS9ymy
         hKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054900; x=1723659700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+BLo8+jhLu6o6opISMFG79Syv4fDQp+Eph2WfIbqEQ=;
        b=cp7l8izApW0uNj29FmnfvV6I/pbs4qd66JjfRyLpqieRx20ndaLX4QTNHdfP1k+L4i
         coIki/u8x/wWmrYnZHjThJomYZZp1drVM58WLLbvKIaIjzP0x+7adA/ZcpC8UnKaTJbM
         Ev/wtR2YCmKJYR+hpvan6IPdhdPZAkF5u8u6lToIdygSPV3NJ44UrIez2AJ4tzojfQW7
         uvdf8FRoEqjK96MUOUPoaY33HyF+BPcJQQOEyetohk1yAyjRxCD5lQlqmsh0IdUc+Hzd
         ByiIxKdY1bvCq8X4dGgGXPptTQh1v0lz9cEDLRQUlMnRBU+y/rd8aZ5jIcTblAiRErok
         BCKA==
X-Gm-Message-State: AOJu0YwT06ILuYTb4HFkRQfGfSE3QeWWwX6RnpWzHbb2I5DINw0R3g+f
	nkEbynsDa0uMsSIE/QqaP89+qgfPHvaUJd04FgXa1T2ZpQp7rIgZAnkLuiQbDa3w+pdYSJBd0zf
	CPbxCyDWBZZvYiEHdDNVBVF+MCnmAtrQ/9mRlnUlJhrRforQfI/n3XWQ7ZIeoOIr2JvCPQWg3Il
	g9TDSsClkxyYcw4aA7ZUCyMh8MzYePzKJ7B+SI3xE=
X-Google-Smtp-Source: AGHT+IHk7o2BG194lfcsF4KYdNwJUYDSGK6OYLthSwLsYH0wK85WT5UPFvMz16KUkVUKdSxvhKwpxQ+9U+w5Og==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
 (user=steadmon job=sendgmr) by 2002:a05:6902:c0e:b0:e03:2257:98b8 with SMTP
 id 3f1490d57ef6-e0bde1eacfcmr259177276.1.1723054900376; Wed, 07 Aug 2024
 11:21:40 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:21:28 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
Subject: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

Introduce cgit-rs, a Rust wrapper crate that allows Rust code to call
functions in libgit.a. This initial patch defines build rules and an
interface that exposes user agent string getter functions as a proof of
concept. A proof-of-concept library consumer is provided in
contrib/cgit-rs/src/main.rs. This executable can be run with `cargo run`

Symbols in cgit can collide with symbols from other libraries such as
libgit2. We avoid this by first exposing library symbols in
public_symbol_export.[ch]. These symbols are prepended with "libgit_" to
avoid collisions and set to visible using a visibility pragma. In
build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also contains
libgit.a and other dependent libraries, with -fvisibility=hidden to hide
all symbols within those libraries that haven't been exposed with a
visibility pragma.

Co-authored-by: Kyle Lippincott <spectral@google.com>
Co-authored-by: Calvin Wan <calvinwan@google.com>
Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore                             |  1 +
 Makefile                               | 13 ++++++++++
 contrib/cgit-rs/Cargo.lock             | 16 +++++++++++++
 contrib/cgit-rs/Cargo.toml             | 16 +++++++++++++
 contrib/cgit-rs/README.md              | 15 ++++++++++++
 contrib/cgit-rs/build.rs               | 33 ++++++++++++++++++++++++++
 contrib/cgit-rs/public_symbol_export.c | 20 ++++++++++++++++
 contrib/cgit-rs/public_symbol_export.h |  8 +++++++
 contrib/cgit-rs/src/lib.rs             |  7 ++++++
 contrib/cgit-rs/src/main.rs            | 10 ++++++++
 10 files changed, 139 insertions(+)
 create mode 100644 contrib/cgit-rs/Cargo.lock
 create mode 100644 contrib/cgit-rs/Cargo.toml
 create mode 100644 contrib/cgit-rs/README.md
 create mode 100644 contrib/cgit-rs/build.rs
 create mode 100644 contrib/cgit-rs/public_symbol_export.c
 create mode 100644 contrib/cgit-rs/public_symbol_export.h
 create mode 100644 contrib/cgit-rs/src/lib.rs
 create mode 100644 contrib/cgit-rs/src/main.rs

diff --git a/.gitignore b/.gitignore
index 8caf3700c2..7031012330 100644
--- a/.gitignore
+++ b/.gitignore
@@ -248,3 +248,4 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/contrib/cgit-rs/target
diff --git a/Makefile b/Makefile
index 1cac51a4f7..fcd06af123 100644
--- a/Makefile
+++ b/Makefile
@@ -653,6 +653,8 @@ CURL_CONFIG = curl-config
 GCOV = gcov
 STRIP = strip
 SPATCH = spatch
+LD = ld
+OBJCOPY = objcopy
 
 export TCL_PATH TCLTK_PATH
 
@@ -2712,6 +2714,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += contrib/cgit-rs/public_symbol_export.o
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3719,6 +3722,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
+	$(RM) -r contrib/cgit-rs/target
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
@@ -3864,3 +3868,12 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
 build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
+
+contrib/cgit-rs/partial_symbol_export.o: contrib/cgit-rs/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
+	$(LD) -r $^ -o $@
+
+contrib/cgit-rs/hidden_symbol_export.o: contrib/cgit-rs/partial_symbol_export.o
+	$(OBJCOPY) --localize-hidden $^ $@
+
+contrib/cgit-rs/libcgit.a: contrib/cgit-rs/hidden_symbol_export.o
+	$(AR) $(ARFLAGS) $@ $^
diff --git a/contrib/cgit-rs/Cargo.lock b/contrib/cgit-rs/Cargo.lock
new file mode 100644
index 0000000000..f50c593995
--- /dev/null
+++ b/contrib/cgit-rs/Cargo.lock
@@ -0,0 +1,16 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "cgit"
+version = "0.1.0"
+dependencies = [
+ "libc",
+]
+
+[[package]]
+name = "libc"
+version = "0.2.155"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
diff --git a/contrib/cgit-rs/Cargo.toml b/contrib/cgit-rs/Cargo.toml
new file mode 100644
index 0000000000..7b55e6f3e1
--- /dev/null
+++ b/contrib/cgit-rs/Cargo.toml
@@ -0,0 +1,16 @@
+[package]
+name = "cgit"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+links = "git"
+
+[[bin]]
+name = "cgit-test"
+path = "src/main.rs"
+
+[lib]
+path = "src/lib.rs"
+
+[dependencies]
+libc = "0.2.155"
diff --git a/contrib/cgit-rs/README.md b/contrib/cgit-rs/README.md
new file mode 100644
index 0000000000..7a59602c30
--- /dev/null
+++ b/contrib/cgit-rs/README.md
@@ -0,0 +1,15 @@
+# cgit-info
+
+A small hacky proof-of-concept showing how to provide a Rust FFI for the Git
+library.
+
+## Building
+
+`cargo build` automatically builds and picks up on changes made to both
+the Rust wrapper and git.git code so there is no need to run `make`
+beforehand.
+
+## Running
+
+Assuming you don't make any changes to the Git source, you can just work from
+`contrib/cgit-rs` and use `cargo build` or `cargo run` as usual.
diff --git a/contrib/cgit-rs/build.rs b/contrib/cgit-rs/build.rs
new file mode 100644
index 0000000000..0c1ec06737
--- /dev/null
+++ b/contrib/cgit-rs/build.rs
@@ -0,0 +1,33 @@
+use std::env;
+use std::path::PathBuf;
+
+pub fn main() -> std::io::Result<()> {
+    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
+    let git_root = crate_root.join("../..");
+    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
+
+    let make_output = std::process::Command::new("make")
+        .env_remove("PROFILE")
+        .current_dir(git_root.clone())
+        .args(&[
+            "CC=clang",
+            "CFLAGS=-fvisibility=hidden",
+            "contrib/cgit-rs/libcgit.a"
+        ])
+        .output()
+        .expect("Make failed to run");
+    if !make_output.status.success() {
+        panic!(
+                "Make failed:\n  stdout = {}\n  stderr = {}\n",
+                String::from_utf8(make_output.stdout).unwrap(),
+                String::from_utf8(make_output.stderr).unwrap()
+        );
+    }
+    std::fs::copy(crate_root.join("libcgit.a"), dst.join("libcgit.a"))?;
+    println!("cargo::rustc-link-search=native={}", dst.into_os_string().into_string().unwrap());
+    println!("cargo::rustc-link-lib=cgit");
+    println!("cargo::rustc-link-lib=z");
+    println!("cargo::rerun-if-changed={}", git_root.into_os_string().into_string().unwrap());
+
+    Ok(())
+}
diff --git a/contrib/cgit-rs/public_symbol_export.c b/contrib/cgit-rs/public_symbol_export.c
new file mode 100644
index 0000000000..3d1cd6cc4f
--- /dev/null
+++ b/contrib/cgit-rs/public_symbol_export.c
@@ -0,0 +1,20 @@
+// Shim to publicly export Git symbols. These must be renamed so that the
+// original symbols can be hidden. Renaming these with a "libgit_" prefix also
+// avoid conflicts with other libraries such as libgit2.
+
+#include "contrib/cgit-rs/public_symbol_export.h"
+#include "version.h"
+
+#pragma GCC visibility push(default)
+
+const char *libgit_user_agent(void)
+{
+	return git_user_agent();
+}
+
+const char *libgit_user_agent_sanitized(void)
+{
+	return git_user_agent_sanitized();
+}
+
+#pragma GCC visibility pop
diff --git a/contrib/cgit-rs/public_symbol_export.h b/contrib/cgit-rs/public_symbol_export.h
new file mode 100644
index 0000000000..a3372f93fa
--- /dev/null
+++ b/contrib/cgit-rs/public_symbol_export.h
@@ -0,0 +1,8 @@
+#ifndef PUBLIC_SYMBOL_EXPORT_H
+#define PUBLIC_SYMBOL_EXPORT_H
+
+const char *libgit_user_agent(void);
+
+const char *libgit_user_agent_sanitized(void);
+
+#endif /* PUBLIC_SYMBOL_EXPORT_H */
diff --git a/contrib/cgit-rs/src/lib.rs b/contrib/cgit-rs/src/lib.rs
new file mode 100644
index 0000000000..dc46e7ff42
--- /dev/null
+++ b/contrib/cgit-rs/src/lib.rs
@@ -0,0 +1,7 @@
+use libc::c_char;
+
+extern "C" {
+    // From version.c
+    pub fn libgit_user_agent() -> *const c_char;
+    pub fn libgit_user_agent_sanitized() -> *const c_char;
+}
diff --git a/contrib/cgit-rs/src/main.rs b/contrib/cgit-rs/src/main.rs
new file mode 100644
index 0000000000..1794e3f43e
--- /dev/null
+++ b/contrib/cgit-rs/src/main.rs
@@ -0,0 +1,10 @@
+use std::ffi::CStr;
+
+fn main() {
+    println!("Let's print some strings provided by Git");
+    let c_buf = unsafe { cgit::libgit_user_agent() };
+    let c_str = unsafe { CStr::from_ptr(c_buf) };
+    println!("git_user_agent() = {:?}", c_str);
+    println!("git_user_agent_sanitized() = {:?}",
+        unsafe { CStr::from_ptr(cgit::libgit_user_agent_sanitized()) });
+}
-- 
2.46.0.rc2.264.g509ed76dc8-goog

