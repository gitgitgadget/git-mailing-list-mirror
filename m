Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80B1B6D07
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032666; cv=none; b=BIQ/9SBWtPmQA2ik9oL07AXyK9qUX1EY8Oa4OQ4TqHeOCgnFxrxUbDwpQ+1IJQcBxOPIo49p89RqORkDazcFQjORSwUL/qtHEh2jaloU0pzo3ecfYHKvz0uR4piTS4Npk/b1KYbHjrHAo37M6IwXITlOY89ew1/TVBnF00W0zvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032666; c=relaxed/simple;
	bh=QyLUGZVKHwBwxRa4BwFWnKoAh34+Tfnch8atxHP7FuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MojBPy8lyYDJusIBJfmgnPJfSYq6hXBJ9Tq9JTFNLdrNNq59TXYd74skrr0q19tH5tKl5z+ZmLLlqJsXPGBYCOgWbr7BcMdSkgL3p29ZLytsKhxrEjsofdx5p5punhRzj4vcU8c1C8ICiwP8RIG3iRt/UdgQEOdGcA1YJ5Iw6sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6Xvhv2D; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6Xvhv2D"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so6626239276.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729032663; x=1729637463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhQqqYPIzzC2MYXnXMmrKAu3jWw8QvhgXPhNzt5Q4+c=;
        b=f6Xvhv2D34+LOgWk57EjschadpzOhdTmjZJ5r7iR6pp0O/T88wBcNzIoh/+tW2+tFw
         GAUeC+ag+27tJP2mpcxM0GvaaXafslmNobEyX5M41UHkdvAgz7670L831LXnvgrZZ7V4
         q2Xo5u4rhM+MfDyJ4JFQNAQ2OMklyDyPwpV0rBtVHM2QVnfAVES9ay63RBfrcy+T1vjD
         CdjyN5PZef9NtGUCz/jqwVK5Duou2rCVr4awH3mLi50QXQYCEOtlw+HpqmHfemQJqV6e
         49tjr27Sf3ZVZRsK5vOaKmqxywEKCR5A0O1ThpE9uGDSp/0W5wlxq4XNDUFEB3OCSYJG
         8DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032663; x=1729637463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhQqqYPIzzC2MYXnXMmrKAu3jWw8QvhgXPhNzt5Q4+c=;
        b=AkbCNwyY4ugwymmBAu6pT1xbNHgv6TF+iQA4EmwKCryFP7g5e5vv8HFohyWHU/QZZR
         dgYgOcZq229gmbs5TJEIyJf58d5SH3z0+PR9GkigUY5djens2KOr/UDB0xXsxBYGwFVd
         Q/+K48RrTrF7b4i4p7gZzYCkLnn8IWzOK3DoXC7Bb61DrIgkalH7qNmclt/jDlYdrEPa
         pHCqJGQ7OMqTTOcw6avsXOT6dAPcxnZqJH8ogUU4HAkOdaf8tpY8B3eJImkrDtMy/mTP
         9W0F8agEZG39t0J5XcxQdXtoo++fybsDCGX+foeXe0OTZmoG0whatX0t+yUBjazl0fyW
         FJOg==
X-Gm-Message-State: AOJu0YzCESS8Cz92W12LX4mYc0yvovWtZo69tK11vcElVEApj3jBfWea
	i9dbxizkncH9tVKq+PzjTEpxb5Y+xmWhFfpAWaamJrh/ZKstdr27FD+D5ic6wXovrUPMrBG7zg+
	xUJUc6s2gqTPkWy1Wy/+5tTv7/vsWnBCVzCKR6348HjBprD7cLyx2zdRJ9NH3bGoKD/NyQGNEKE
	QFVN+qapn5QzdZ1D6h7L82zFpU7eqFS9s8IOqnsCs=
X-Google-Smtp-Source: AGHT+IFv/SUj/nIUPLPZ0s3flsJnx/eBdcNO4JlrTv7rOHQ6ByKUudjne7Kc1/Y2cBdC2cSrpEaMNSNf4U0tDQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:ddcc:6d3c:e4d6:3076])
 (user=steadmon job=sendgmr) by 2002:a25:6b43:0:b0:e1d:2043:da46 with SMTP id
 3f1490d57ef6-e29782f3106mr1560276.3.1729032662888; Tue, 15 Oct 2024 15:51:02
 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:50:54 -0700
In-Reply-To: <cover.1729032373.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1729032373.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <1ed010c37852255e646b6dbb4beeac9c75c4cdde.1729032373.git.steadmon@google.com>
Subject: [PATCH v5 2/5] libgit-sys: introduce Rust wrapper for libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, emrass@google.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com, 
	rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

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
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore                                    |  1 +
 Makefile                                      | 16 +++++
 contrib/libgit-rs/libgit-sys/Cargo.lock       | 69 +++++++++++++++++++
 contrib/libgit-rs/libgit-sys/Cargo.toml       | 17 +++++
 contrib/libgit-rs/libgit-sys/README.md        | 15 ++++
 contrib/libgit-rs/libgit-sys/build.rs         | 35 ++++++++++
 .../libgit-sys/public_symbol_export.c         | 21 ++++++
 .../libgit-sys/public_symbol_export.h         |  8 +++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 46 +++++++++++++
 9 files changed, 228 insertions(+)
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
index 7caeb3c872..4f7467a8c2 100644
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
@@ -3720,6 +3723,10 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
+	$(RM) -r contrib/libgit-rs/libgit-sys/target
+	$(RM) -r contrib/libgit-rs/libgit-sys/partial_symbol_export.o
+	$(RM) -r contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
+	$(RM) -r contrib/libgit-rs/libgit-sys/libgitpub.a
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
@@ -3865,3 +3872,12 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
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
index 0000000000..427a4c66b7
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/Cargo.lock
@@ -0,0 +1,69 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "autocfg"
+version = "1.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
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
+ "autocfg",
+ "libz-sys",
+ "make-cmd",
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
+name = "make-cmd"
+version = "0.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a8ca8afbe8af1785e09636acb5a41e08a765f5f0340568716c18a8700ba3c0d3"
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
index 0000000000..7a230a4437
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/Cargo.toml
@@ -0,0 +1,17 @@
+[package]
+name = "libgit-sys"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+links = "gitpub"
+rust-version = "1.63"
+
+[lib]
+path = "src/lib.rs"
+
+[dependencies]
+libz-sys = "1.1.19"
+
+[build-dependencies]
+autocfg = "1.4.0"
+make-cmd = "0.1.0"
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
index 0000000000..8d74120191
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/build.rs
@@ -0,0 +1,35 @@
+use std::env;
+use std::path::PathBuf;
+
+pub fn main() -> std::io::Result<()> {
+    let ac = autocfg::new();
+    ac.emit_has_path("std::ffi::c_char");
+
+    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
+    let git_root = crate_root.join("../../..");
+    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
+
+    let make_output = make_cmd::gnu_make()
+        .env("DEVELOPER", "1")
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
+    println!("cargo:rustc-link-search=native={}", dst.display());
+    println!("cargo:rustc-link-lib=gitpub");
+    println!("cargo:rerun-if-changed={}", git_root.display());
+
+    Ok(())
+}
diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
new file mode 100644
index 0000000000..8e4b94d821
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
@@ -0,0 +1,21 @@
+// Shim to publicly export Git symbols. These must be renamed so that the
+// original symbols can be hidden. Renaming these with a "libgit_" prefix also
+// avoids conflicts with other libraries such as libgit2.
+
+#include "git-compat-util.h"
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
index 0000000000..d4853f3074
--- /dev/null
+++ b/contrib/libgit-rs/libgit-sys/src/lib.rs
@@ -0,0 +1,46 @@
+#[cfg(has_std__ffi__c_char)]
+use std::ffi::c_char;
+
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+pub type c_char = i8;
+
+extern crate libz_sys;
+
+extern "C" {
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
2.47.0.rc1.288.g06298d1525-goog

