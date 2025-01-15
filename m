Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C71D8DE4
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971553; cv=none; b=IQpu8W4bQLyB5W/RRb4pYqJIrSrckIY9OdDoaRemBLsVWFiNXKiNVtuNGMyw46e5Kwoin+CQ2aENFRXKjfXHmygkXWIeCxWlLH7farfng+DFzi4pEbSyd3rFehL2C1zm4EmyDz23G8emV8MplxsFDMLSjkGQLJi8jpHBaif8HcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971553; c=relaxed/simple;
	bh=sGTADG9QTrb+M1YWf4tvEvBckxHxHHl4lg9yd3IOEAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTZD/WAIk3PdctNZkqhd7crqTf1AkSeFNwdwc5lW79Y0nB5xKUDThpy1if8+3xcOv7NHCE9cKt0rBDs4UqCaXtVh2mtL/0Qnpoi7djogZxZVQz2AMf8odPhTaYmvo6EshsvYVOlGeC1l1QaoodCMl9dnfqJiW/XGQwlCxtiqAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5/RCyvT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5/RCyvT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so747577a91.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736971551; x=1737576351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRpAiykl0uo6UbbhyapmCVMFDJg4ZKJUM8ctcuv/0TU=;
        b=W5/RCyvTN3b757jXe34Jn4Ts3LsmNBginpzFZ/g6RZHD2zFk5FFItHMM1tkoe+s3IB
         hKaXGBrm1dJjTWTEgvUkM9eLtoHFNlyCPVuIWlaHck8TF7pB9nypVMmWKPilUVCYKJoL
         udZUidgQ7BbQ6CJum9zJmqssRDHLnUso6mcVTJYwqtzdxVzn9AC05YM9MnUjRQ8u7Je/
         tp5AhDbAxEfFYm23cCr0ZJjN/pfkxZ1VGsKPDV+bx5oSZ2nQeGHE60uCp0S/5j+/Sv9r
         id1a7vkxiyiEJV3QJhVGocS4e+1eujlaQ4Xu1Wk+pgxl61vtDJ4ZUX3Q2n7acEWrc+rA
         2XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971551; x=1737576351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRpAiykl0uo6UbbhyapmCVMFDJg4ZKJUM8ctcuv/0TU=;
        b=qXtZKNntbUoAu87lYCZDvYOYxnFt3Y9WlmW1Nkglswl08vfK7hTnjx9Zl1b0gJEXuV
         Y2uvDJbpAYqHUN/v4IrHe8vQ/6aRnRCwTY+AUpfOPO92Weq29Ycv5ZN9De7DsG5Wcrrv
         juPR9j6r2mxOY7jHQ1hRp2WbDZxRjOHIN0BsJ3pRwHQORsgRIunbjVHCnEmobbP+sxYW
         qqPCyXnn1HAfXaMjKCW2OZjeDXp/XI+AJs8XxiAjTXSz11FmW3IODITMyb1jxmFQEk2Q
         Be3ZSU6SzT7PCWhlakv4909HZIEymR74z4dzYrDD5Rr1cdwt8dzyVLZk9GNq7DgxoPq6
         fVFg==
X-Gm-Message-State: AOJu0YwBP+S1cGnuC1jrR/UyomdH00Uw/bZI8v2sx+7V0ZvHxlBpNJMs
	hgVT6bpiZosEvxz48meIc0ZOUiMGJM7nOE3lVtiri8Uh7Y2wB14RVZT18Dl/La9hQBNuZDsyqLf
	1bnKYelasIj6DfhIb2EB4NLeGv3sBHJbx9AMTfbbvkoz44SNcT3dfNcQPWqw0swxLPA378IOkn4
	M0zkHuUHr7EhfBZPwRyoR9iy78g8IOI0EIjZUOATY=
X-Google-Smtp-Source: AGHT+IHp6makelyMwZRMw/n+OBQgGjRTo7OP/h3gVFK/XPnugWmNrnKTdBETFgmlrNc9INty3iq8m1WBfpmS0A==
X-Received: from pja13.prod.google.com ([2002:a17:90b:548d:b0:2ef:9ef2:8790])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2747:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-2f548e9c9bcmr45775878a91.2.1736971550686;
 Wed, 15 Jan 2025 12:05:50 -0800 (PST)
Date: Wed, 15 Jan 2025 12:05:41 -0800
In-Reply-To: <cover.1736971328.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1736971328.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <5fc66cdb1628e0c9e420f3f0455779d7471f46ee.1736971328.git.steadmon@google.com>
Subject: [PATCH v6 2/5] libgit-sys: introduce Rust wrapper for libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
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
 .gitignore                                |  1 +
 Makefile                                  | 16 ++++++
 contrib/libgit-sys/Cargo.lock             | 69 +++++++++++++++++++++++
 contrib/libgit-sys/Cargo.toml             | 18 ++++++
 contrib/libgit-sys/README.md              |  4 ++
 contrib/libgit-sys/build.rs               | 35 ++++++++++++
 contrib/libgit-sys/public_symbol_export.c | 21 +++++++
 contrib/libgit-sys/public_symbol_export.h |  8 +++
 contrib/libgit-sys/src/lib.rs             | 46 +++++++++++++++
 9 files changed, 218 insertions(+)
 create mode 100644 contrib/libgit-sys/Cargo.lock
 create mode 100644 contrib/libgit-sys/Cargo.toml
 create mode 100644 contrib/libgit-sys/README.md
 create mode 100644 contrib/libgit-sys/build.rs
 create mode 100644 contrib/libgit-sys/public_symbol_export.c
 create mode 100644 contrib/libgit-sys/public_symbol_export.h
 create mode 100644 contrib/libgit-sys/src/lib.rs

diff --git a/.gitignore b/.gitignore
index e82aa19df0..31d7e64287 100644
--- a/.gitignore
+++ b/.gitignore
@@ -250,3 +250,4 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/contrib/libgit-sys/target
diff --git a/Makefile b/Makefile
index 27e68ac039..47e864a861 100644
--- a/Makefile
+++ b/Makefile
@@ -657,6 +657,8 @@ CURL_CONFIG = curl-config
 GCOV = gcov
 STRIP = strip
 SPATCH = spatch
+LD = ld
+OBJCOPY = objcopy
 
 export TCL_PATH TCLTK_PATH
 
@@ -2731,6 +2733,7 @@ OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
 OBJECTS += $(CLAR_TEST_OBJS)
 OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
+OBJECTS += contrib/libgit-sys/public_symbol_export.o
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3726,6 +3729,10 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
+	$(RM) -r contrib/libgit-sys/target
+	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
+	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
+	$(RM) -r contrib/libgit-sys/libgitpub.a
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
@@ -3887,3 +3894,12 @@ $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-
 build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
+
+contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
+	$(LD) -r $^ -o $@
+
+contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
+	$(OBJCOPY) --localize-hidden $^ $@
+
+contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
+	$(AR) $(ARFLAGS) $@ $^
diff --git a/contrib/libgit-sys/Cargo.lock b/contrib/libgit-sys/Cargo.lock
new file mode 100644
index 0000000000..427a4c66b7
--- /dev/null
+++ b/contrib/libgit-sys/Cargo.lock
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
diff --git a/contrib/libgit-sys/Cargo.toml b/contrib/libgit-sys/Cargo.toml
new file mode 100644
index 0000000000..15b28c3585
--- /dev/null
+++ b/contrib/libgit-sys/Cargo.toml
@@ -0,0 +1,18 @@
+[package]
+name = "libgit-sys"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+links = "gitpub"
+rust-version = "1.63"
+description = "Native bindings to a portion of libgit"
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
diff --git a/contrib/libgit-sys/README.md b/contrib/libgit-sys/README.md
new file mode 100644
index 0000000000..c061cfcaf5
--- /dev/null
+++ b/contrib/libgit-sys/README.md
@@ -0,0 +1,4 @@
+# libgit-sys
+
+A small proof-of-concept crate showing how to provide a Rust FFI to Git
+internals.
diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
new file mode 100644
index 0000000000..b6c65193bc
--- /dev/null
+++ b/contrib/libgit-sys/build.rs
@@ -0,0 +1,35 @@
+use std::env;
+use std::path::PathBuf;
+
+pub fn main() -> std::io::Result<()> {
+    let ac = autocfg::new();
+    ac.emit_has_path("std::ffi::c_char");
+
+    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
+    let git_root = crate_root.join("../..");
+    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
+
+    let make_output = make_cmd::gnu_make()
+        .env("DEVELOPER", "1")
+        .env_remove("PROFILE")
+        .current_dir(git_root.clone())
+        .args([
+            "CFLAGS=-fvisibility=hidden",
+            "contrib/libgit-sys/libgitpub.a",
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
diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
new file mode 100644
index 0000000000..7cd5007902
--- /dev/null
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -0,0 +1,21 @@
+// Shim to publicly export Git symbols. These must be renamed so that the
+// original symbols can be hidden. Renaming these with a "libgit_" prefix also
+// avoids conflicts with other libraries such as libgit2.
+
+#include "git-compat-util.h"
+#include "contrib/libgit-sys/public_symbol_export.h"
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
diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgit-sys/public_symbol_export.h
new file mode 100644
index 0000000000..a3372f93fa
--- /dev/null
+++ b/contrib/libgit-sys/public_symbol_export.h
@@ -0,0 +1,8 @@
+#ifndef PUBLIC_SYMBOL_EXPORT_H
+#define PUBLIC_SYMBOL_EXPORT_H
+
+const char *libgit_user_agent(void);
+
+const char *libgit_user_agent_sanitized(void);
+
+#endif /* PUBLIC_SYMBOL_EXPORT_H */
diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
new file mode 100644
index 0000000000..d4853f3074
--- /dev/null
+++ b/contrib/libgit-sys/src/lib.rs
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
2.48.0.rc2.279.g1de40edade-goog

