Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03638199E80
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101709; cv=none; b=SUlbRJFm+f8s4B8k8aNf5naa8W1kIsHffEmYoLuxrx29p4jUppqOF37jGqjCX9Ks2BtvLU+VSnRqY8mieJQbpw+QUEw4DravVDd7xhdvt+qWxnDvpfVcUbdnmPHGMqsByMw5p6dP2wm0rfxvIcKkLgVceh0E3QYD1pjf/WOraN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101709; c=relaxed/simple;
	bh=eNeB+tuLk2FzHqXYwTCMKBbzSInL1J6u84OI2BZD0S8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wc5LZcQcGDVETrIyK+kFYqIxvokttj7Sqboe31YJ6tM/N+DV2FHHWFKahzB4cKindzL96oRcZ2CkvSa3J+lrC/zhOuhOFxGX4rPVBIXqcnpf+jCl/v2pk/dCvHG6c4B4wy5bIqfCU+Is74lxpd+VwsCrHKXc+z/X9LQutqyxiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19baYYLU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19baYYLU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so11390690a91.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 14:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738101706; x=1738706506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zw9QD1gRHffuFJdR4ZUNdm8WM427E4xqRUBni93vz6k=;
        b=19baYYLUaXSAzcTn1CtP/n2qxBFCACUv4ngYeG2bzKlD+xOfQIEuBXEC0zdDre4Iaa
         ImXmZ4epNb19FHnqD62ZyqoxtDEirKUXIr1e0AE3Ag0gn64g4B4LtCnd1i9ENH1A9rw2
         7g0JQbz3PAw/cVm1n3r/vBbAy+8XYB94ndq84xfDtar13wRNX51XRcm/IiT+6jh/H+TS
         b5wXm6o4/dbssWUUnHLOdOoOqy3PMjjDn8MLkBP/v8dQlSSenEtblk/FUUvX63NzLVqu
         dNDUPBIFUsJ4pnI+AlBApf73/nBK2ZvdpksYcNJV7/mD1h1GhRYOwf1+Zi6NO8uREvXP
         wSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101706; x=1738706506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw9QD1gRHffuFJdR4ZUNdm8WM427E4xqRUBni93vz6k=;
        b=S0Szi+IXC9AJZusaBzGjUt3kiKoiaTUMd2701wO+wysXCg7fSHAyPtCzkioNebradP
         SKSLsSpd8055XlXd76HopF6+8G6zh1ubYifU4rTDs/D5QmXvez9xodTUYSfH4nUHdL23
         SAQgjg1ewBtfDbDvbA4p0PCagVSIBvfFle18/DBSOBcpdJpbV4W/56SRC9Q9rwhRJnuI
         C5291uY6hIwFi20MoNPlmwb0KfzANfXv8OODc03oe9sZtJND6tNeWWCxCjLae3seSqeM
         x6IjbuAB+x4JUePQ3tVBCkz/hw6c9SzqpjobkWd2Brk2b2N7ROSTUXXV1Qmjp9R9+16w
         eO8w==
X-Gm-Message-State: AOJu0YwfsCkRUNkRGVGRoxkPsiKegqD9sk+5xbrk/QjrjkF5hvs9K1is
	1UeSj4GxYohAW2409n4771A5Vym08hpsAfKkcZ6ynT7Zr8GvU6UzV1SN0ScAq2IUbCKFRNDeOIx
	M5FRcWriowxWvrkHRosgODYu2Nr35B0zs0ZP8Fp5lplbqsRPL7lMJu6yYF+rwUKYc1NxMVDCMfP
	hutJShu1PUChtKhymncg5jN6BSvzw+TjDSDbvdoVE=
X-Google-Smtp-Source: AGHT+IEFa28gEPlVczaKEK7lDKNsqemIQFBLcuZwd9nfuq22EhMYYxRqAf0pTtECw1C5CHh2sfoHMA70f4Mm/Q==
X-Received: from pjb14.prod.google.com ([2002:a17:90b:2f0e:b0:2ea:931d:7ced])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:280c:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2f83abb8dd5mr997486a91.11.1738101706041;
 Tue, 28 Jan 2025 14:01:46 -0800 (PST)
Date: Tue, 28 Jan 2025 14:01:38 -0800
In-Reply-To: <cover.1738101256.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738101256.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <3588a3c3fc76fd2a98b89e837dae07fd97fb88af.1738101256.git.steadmon@google.com>
Subject: [PATCH v8 2/4] libgit-sys: introduce Rust wrapper for libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com
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
 Makefile                                  | 47 +++++++++++++++
 contrib/libgit-sys/Cargo.lock             | 69 +++++++++++++++++++++++
 contrib/libgit-sys/Cargo.toml             | 19 +++++++
 contrib/libgit-sys/README.md              |  4 ++
 contrib/libgit-sys/build.rs               | 35 ++++++++++++
 contrib/libgit-sys/public_symbol_export.c | 23 ++++++++
 contrib/libgit-sys/public_symbol_export.h |  8 +++
 contrib/libgit-sys/src/lib.rs             | 46 +++++++++++++++
 t/Makefile                                | 10 ++++
 10 files changed, 262 insertions(+)
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
index 27e68ac039..f2c08df4cb 100644
--- a/Makefile
+++ b/Makefile
@@ -416,6 +416,9 @@ include shared.mak
 # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
 # programs in oss-fuzz/.
 #
+# Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
+# test the Rust crate in contrib/libgit-sys.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -657,6 +660,8 @@ CURL_CONFIG = curl-config
 GCOV = gcov
 STRIP = strip
 SPATCH = spatch
+LD = ld
+OBJCOPY = objcopy
 
 export TCL_PATH TCLTK_PATH
 
@@ -2236,6 +2241,12 @@ ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
+ifdef INCLUDE_LIBGIT_RS
+	# Enable symbol hiding in contrib/libgit-sys/libgitpub.a without making
+	# us rebuild the whole tree every time we run a Rust build.
+	BASIC_CFLAGS += -fvisibility=hidden
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2732,6 +2743,10 @@ OBJECTS += $(UNIT_TEST_OBJS)
 OBJECTS += $(CLAR_TEST_OBJS)
 OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 
+ifdef INCLUDE_LIBGIT_RS
+	OBJECTS += contrib/libgit-sys/public_symbol_export.o
+endif
+
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
@@ -3726,6 +3741,10 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
+	$(RM) -r contrib/libgit-sys/target
+	$(RM) contrib/libgit-sys/partial_symbol_export.o
+	$(RM) contrib/libgit-sys/hidden_symbol_export.o
+	$(RM) contrib/libgit-sys/libgitpub.a
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
@@ -3887,3 +3906,31 @@ $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-
 build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
+
+.PHONY: libgit-sys
+libgit-sys:
+	$(QUIET)(\
+		cd contrib/libgit-sys && \
+		cargo build \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgit-sys
+endif
+
+LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
+LIBGIT_PUB_OBJS += libgit.a
+LIBGIT_PUB_OBJS += reftable/libreftable.a
+LIBGIT_PUB_OBJS += xdiff/lib.a
+
+LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
+
+LIBGIT_HIDDEN_EXPORT = contrib/libgit-sys/hidden_symbol_export.o
+
+$(LIBGIT_PARTIAL_EXPORT): $(LIBGIT_PUB_OBJS)
+	$(LD) -r $^ -o $@
+
+$(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
+	$(OBJCOPY) --localize-hidden $^ $@
+
+contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
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
index 0000000000..e0623022c3
--- /dev/null
+++ b/contrib/libgit-sys/Cargo.toml
@@ -0,0 +1,19 @@
+[package]
+name = "libgit-sys"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+links = "gitpub"
+rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
+                      # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
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
index 0000000000..3ffd80ad91
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
+            "INCLUDE_LIBGIT_RS=YesPlease",
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
index 0000000000..4c153c6f0d
--- /dev/null
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -0,0 +1,23 @@
+/*
+ * Shim to publicly export Git symbols. These must be renamed so that the
+ * original symbols can be hidden. Renaming these with a "libgit_" prefix also
+ * avoids conflicts with other libraries such as libgit2.
+ */
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
diff --git a/t/Makefile b/t/Makefile
index daa5fcae86..53ba01c21b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -177,3 +177,13 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
+
+.PHONY: libgit-sys-test
+libgit-sys-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-sys && \
+		cargo test \
+	)
+ifdef INCLUDE_LIBGIT_RS
+all:: libgit-sys-test
+endif
-- 
2.48.1.262.g85cc9f2d1e-goog

