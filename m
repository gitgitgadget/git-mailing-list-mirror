Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12325158523
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661288; cv=none; b=hGeNmPzENzdXV90DjH7L56N9FsWRgG0/Xu6U5OuSw0hTXInqF2pdUIz+Fw6fnqWVYkEPML6Aldbm6gIQUPBqEjJtUQNYasve7lN3ZEypntuoG387qON3fKKGAMn96i6GrpQPe5XUalg2r35CKNpsswZr7VNTVuoW29m0xa5D+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661288; c=relaxed/simple;
	bh=Sd8BIE47690g4hh5292UXBSZfJjQxedx1ADOfO0Af+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TPCd2IQulxjoP49V6LrCOYEVngsG4CGySHWBxXZPmXNfUqvJJba0JO7Gp7ZXZHa/ty8AM7Aw66r+hmZEFIVOS6p6XE4WAoVDW2gPp6nJ3eUkNxHR9N8fxZWsEhKMJ49yNKerzD1Qlv4W8QKqCxsU/gE70L9frs1xXMck3u4mgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jL2B96/F; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jL2B96/F"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1d46cee0b0so371518276.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725661285; x=1726266085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/tylS5Bc/umtGWc+gOJ2ik/5pN4MZcbPguwyrqTnFc=;
        b=jL2B96/F6dz5eejtJ3Hmg2q5KHA6HIfUBGjzUKjLLQruHzAfiQkaQr6IBXTBiouoKF
         zXWmDMRBDZlIJNLaYX+GPyNpG8jAptJ7hVXp31Xcod6gaodCyAORT3XHIoHNYILCFai9
         ydz8E87KmlO7XfiJpfXdr7glFvuIwucM9+lEQuqUXfxj7a8velAZ4OTKoBWf/xdZSbwH
         cP0QXPIm90jtTulJzdevb1ceUkrKp/jbtPi53rniVY3a9AWt5Kf4L8oZv/ojaACH0WaF
         B68Y2qrmLJ3qFM4rbbBUf4ZLkyFzWKfBk+DWzSxQhvVTyN6k4lqWn3lX0NBgsJRYhvNa
         XIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661285; x=1726266085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/tylS5Bc/umtGWc+gOJ2ik/5pN4MZcbPguwyrqTnFc=;
        b=AsDGfAgZbq5lNnQxm5Nk+e5fnM0J05A3tUHk+mJEASKqNOk93cOEjJAYDGPsqlwfTz
         1y87/+esJDm+mVgArmB5LKoAtiIcYdbf6JDNnT8xteE3mbav+xVobpu0YHMSoqJb7bUw
         CJFF/SdyI38e90wPp1XFf7ULyxrJRq55EifvYBXAXSMKnnmvXxnNR5LtWADZJjVNlhGm
         DyWutw7GXlzljQpV6FMA6jhYY29Q5H33Z1wmU0sPwTgh85+MULc3xfVJIp2Afu8o+el8
         JijBKtk0zRyudLr1JGQkc0oG3Ps0/F6Mjv6x/hEq3obgkKIU8BHrEDp7Nh9pFRMprD85
         4WRw==
X-Gm-Message-State: AOJu0YwWKZBLt+An2/EyxMtfISFxtfLjNtYnsRLpmfwPiNuK1sb9tXHB
	iU015YNLIvdHQqqYexpUi1a/hN171ifPUKx/1yOL85aiLOe4n89y/xdaHplblO9MusehfxtAVrP
	XMQCC7zOy2dLSteFLbi4DKXN5SlIpZKoSEkQf1l5jxHKPKUNnI041fI4BvMz99B4RZsMGfREWH7
	tAc6URNKofamABColGNU4c/HHrWV0CfPQ04HxNmaVLNV0X
X-Google-Smtp-Source: AGHT+IE77Y6GfusAkPgE0CATljPQ4lPK+HzP42kLZyQV4mhzHG1yUj2mNKbcwNiaKhIRwfv6TNlaAaE1Hbmr8ak=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:d842:0:b0:e16:6d88:b8c2 with SMTP id
 3f1490d57ef6-e1d34890f4fmr8310276.4.1725661284582; Fri, 06 Sep 2024 15:21:24
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:21:12 +0000
In-Reply-To: <20240906221853.257984-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906222116.270196-2-calvinwan@google.com>
Subject: [PATCH v3 2/6] libgit-sys: introduce Rust wrapper for libgit.a
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Steadmon <steadmon@google.com>

Introduce libgit-sys, a Rust wrapper crate that allows Rust code to call
functions in libgit.a. This initial patch defines build rules and an
interface that exposes user agent string getter functions as a proof of
concept. This library can be tested with `cargo test`. In later commits,
a higher-level library containing a more Rust-friendly interface will be
added at `contrib/libgit-rs`.

Symbols in libgit can collide with symbols from other libraries such as
libgit2. We avoid this by first exposing library symbols in
public_symbol_export.[ch]. These symbols are prepended with "libgit_" to
avoid collisions and set to visible using a visibility pragma. In
build.rs, Rust builds contrib/libgit-rs/libgit-sys/libgitpub.a, which also
contains libgit.a and other dependent libraries, with
-fvisibility=hidden to hide all symbols within those libraries that
haven't been exposed with a visibility pragma.

Co-authored-by: Kyle Lippincott <spectral@google.com>
Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Kyle Lippincott <spectral@google.com>
Change-Id: Ibb98a3907e69839231355c098b2488ef06d1ba45
---
 .gitignore                                    |  1 +
 Makefile                                      | 13 +++++
 contrib/libgit-rs/libgit-sys/Cargo.lock       | 55 +++++++++++++++++++
 contrib/libgit-rs/libgit-sys/Cargo.toml       | 12 ++++
 contrib/libgit-rs/libgit-sys/README.md        | 15 +++++
 contrib/libgit-rs/libgit-sys/build.rs         | 31 +++++++++++
 .../libgit-sys/public_symbol_export.c         | 20 +++++++
 .../libgit-sys/public_symbol_export.h         |  8 +++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 42 ++++++++++++++
 9 files changed, 197 insertions(+)
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.lock
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.toml
 create mode 100644 contrib/libgit-rs/libgit-sys/README.md
 create mode 100644 contrib/libgit-rs/libgit-sys/build.rs
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.c
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.h
 create mode 100644 contrib/libgit-rs/libgit-sys/src/lib.rs

diff --git a/.gitignore b/.gitignore
index 8caf3700c2..dfd72820fb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -248,3 +248,4 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/contrib/libgit-rs/libgit-sys/target
diff --git a/Makefile b/Makefile
index 7caeb3c872..0090514e55 100644
--- a/Makefile
+++ b/Makefile
@@ -653,6 +653,8 @@ CURL_CONFIG = curl-config
 GCOV = gcov
 STRIP = strip
 SPATCH = spatch
+LD = ld
+OBJCOPY = objcopy
 
 export TCL_PATH TCLTK_PATH
 
@@ -2713,6 +2715,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += contrib/libgit-rs/libgit-sys/public_symbol_export.o
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3720,6 +3723,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
+	$(RM) -r contrib/libgit-rs/libgit-sys/target
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
@@ -3865,3 +3869,12 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
 build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
+
+contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
+	$(LD) -r $^ -o $@
+
+contrib/libgit-rs/libgit-sys/hidden_symbol_export.o: contrib/libgit-rs/libgit-sys/partial_symbol_export.o
+	$(OBJCOPY) --localize-hidden $^ $@
+
+contrib/libgit-rs/libgit-sys/libgitpub.a: contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
+	$(AR) $(ARFLAGS) $@ $^
diff --git a/contrib/libgit-rs/libgit-sys/Cargo.lock b/contrib/libgit-rs/libgit-sys/Cargo.lock
new file mode 100644
index 0000000000..af8676ab42
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/Cargo.lock
@@ -0,0 +1,55 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "cc"
+version = "1.1.15"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "57b6a275aa2903740dc87da01c62040406b8812552e97129a63ea8850a17c6e6"
+dependencies = [
+ "shlex",
+]
+
+[[package]]
+name = "libc"
+version = "0.2.158"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d8adc4bb1803a324070e64a98ae98f38934d91957a99cfb3a43dcbc01bc56439"
+
+[[package]]
+name = "libgit-sys"
+version = "0.1.0"
+dependencies = [
+ "libz-sys",
+]
+
+[[package]]
+name = "libz-sys"
+version = "1.1.20"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d2d16453e800a8cf6dd2fc3eb4bc99b786a9b90c663b8559a5b1a041bf89e472"
+dependencies = [
+ "cc",
+ "libc",
+ "pkg-config",
+ "vcpkg",
+]
+
+[[package]]
+name = "pkg-config"
+version = "0.3.30"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
+
+[[package]]
+name = "shlex"
+version = "1.3.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
+
+[[package]]
+name = "vcpkg"
+version = "0.2.15"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
diff --git a/contrib/libgit-rs/libgit-sys/Cargo.toml b/contrib/libgit-rs/libgit-sys/Cargo.toml
new file mode 100644
index 0000000000..905fd6774f
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/Cargo.toml
@@ -0,0 +1,12 @@
+[package]
+name = "libgit-sys"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+links = "gitpub"
+
+[lib]
+path = "src/lib.rs"
+
+[dependencies]
+libz-sys = "1.1.19"
\ No newline at end of file
diff --git a/contrib/libgit-rs/libgit-sys/README.md b/contrib/libgit-rs/libgit-sys/README.md
new file mode 100644
index 0000000000..7a59602c30
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/README.md
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
diff --git a/contrib/libgit-rs/libgit-sys/build.rs b/contrib/libgit-rs/libgit-sys/build.rs
new file mode 100644
index 0000000000..c187ab6cd0
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/build.rs
@@ -0,0 +1,31 @@
+use std::env;
+use std::path::PathBuf;
+
+pub fn main() -> std::io::Result<()> {
+    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
+    let git_root = crate_root.join("../../..");
+    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
+
+    let make_output = std::process::Command::new("make")
+        .env_remove("PROFILE")
+        .current_dir(git_root.clone())
+        .args([
+            "CFLAGS=-fvisibility=hidden",
+            "contrib/libgit-rs/libgit-sys/libgitpub.a",
+        ])
+        .output()
+        .expect("Make failed to run");
+    if !make_output.status.success() {
+        panic!(
+            "Make failed:\n  stdout = {}\n  stderr = {}\n",
+            String::from_utf8(make_output.stdout).unwrap(),
+            String::from_utf8(make_output.stderr).unwrap()
+        );
+    }
+    std::fs::copy(crate_root.join("libgitpub.a"), dst.join("libgitpub.a"))?;
+    println!("cargo::rustc-link-search=native={}", dst.display());
+    println!("cargo::rustc-link-lib=gitpub");
+    println!("cargo::rerun-if-changed={}", git_root.display());
+
+    Ok(())
+}
diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
new file mode 100644
index 0000000000..39c27d9c1a
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
@@ -0,0 +1,20 @@
+// Shim to publicly export Git symbols. These must be renamed so that the
+// original symbols can be hidden. Renaming these with a "libgit_" prefix also
+// avoid conflicts with other libraries such as libgit2.
+
+#include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
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
diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.h b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
new file mode 100644
index 0000000000..a3372f93fa
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
@@ -0,0 +1,8 @@
+#ifndef PUBLIC_SYMBOL_EXPORT_H
+#define PUBLIC_SYMBOL_EXPORT_H
+
+const char *libgit_user_agent(void);
+
+const char *libgit_user_agent_sanitized(void);
+
+#endif /* PUBLIC_SYMBOL_EXPORT_H */
diff --git a/contrib/libgit-rs/libgit-sys/src/lib.rs b/contrib/libgit-rs/libgit-sys/src/lib.rs
new file mode 100644
index 0000000000..346b26083d
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/src/lib.rs
@@ -0,0 +1,42 @@
+use std::ffi::c_char;
+
+extern crate libz_sys;
+
+extern "C" {
+    // From version.c
+    pub fn libgit_user_agent() -> *const c_char;
+    pub fn libgit_user_agent_sanitized() -> *const c_char;
+}
+
+#[cfg(test)]
+mod tests {
+    use std::ffi::CStr;
+
+    use super::*;
+
+    #[test]
+    fn user_agent_starts_with_git() {
+        let c_str = unsafe { CStr::from_ptr(libgit_user_agent()) };
+        let agent = c_str
+            .to_str()
+            .expect("User agent contains invalid UTF-8 data");
+        assert!(
+            agent.starts_with("git/"),
+            r#"Expected user agent to start with "git/", got: {}"#,
+            agent
+        );
+    }
+
+    #[test]
+    fn sanitized_user_agent_starts_with_git() {
+        let c_str = unsafe { CStr::from_ptr(libgit_user_agent_sanitized()) };
+        let agent = c_str
+            .to_str()
+            .expect("Sanitized user agent contains invalid UTF-8 data");
+        assert!(
+            agent.starts_with("git/"),
+            r#"Expected user agent to start with "git/", got: {}"#,
+            agent
+        );
+    }
+}
-- 
2.46.0.469.g59c65b2a67-goog

