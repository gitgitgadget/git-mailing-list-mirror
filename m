Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BB4C8E
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023554; cv=none; b=HkJEK8hu9r8aguaSGis26ObUttTw5tHYxItZ0yUzaWSFc0imvL3bb86CWEph//KXjvHbVxHYISf/A+1+Bm2Ocx8VRbVwa0OAvEpdPQNR0BsWmzTHMY9pL7VDgRXrssw1tBwxBs+KUyFufTQKVpMNwMpSKWXlXTVRM8TeOWkeYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023554; c=relaxed/simple;
	bh=Hjn0sUqM3eS2WRGHajrGTpbQyzCbMEzn3aM3q6Y+Jfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OB8B0dZiNh+rXTmtDvUs9fo/KTc1g4j5/kFxjRA9iD7u6ObdQlgjipjUQ8oqbYhQY0LXpztgF75HEzaHVcsuLitzUNMdzh88cKO8KTSPp/H+Ug+QwDWcdbyORG5bSyLGVxZYEw/hT2FVY8BesB4qRgeJCtGSSVMgP1SyxDYQf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsFNPTJY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsFNPTJY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2162259a5dcso156748825ad.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738023552; x=1738628352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyWNhxH6MX4PSnLrusFQ6xLkdCKVe99tiY8VrHD30o8=;
        b=vsFNPTJYytpV5mlajIby3FnKmuDhYJ0+caHHX55JEOn1bk5R/Phvn58GjschL4tXxv
         n4xKp/yRraox7tbIxhV10C8+SGO8HB21BZgyJKCURurt22i+bQ8uj/BEt2ObQn/W/ViR
         rE5pSQJZxVw0HHjOpNF1u6MchPSGobIgDJvuUXxOcvch2wc8Rbd0IEBBoJN9/LijMfjH
         9r8qq9lW4eob2vLLd32b1NCBr+Kq5cb4M0Q+fY+Myc27amDVDWd1ayFWcfCAomNwbkjb
         7+H6rtcpwo3c/P3l6llPas+grU1kI/E0Rb4mAV2ihQU+wcTpnXFmRNrTmsvT+hvmq6kL
         GqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738023552; x=1738628352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyWNhxH6MX4PSnLrusFQ6xLkdCKVe99tiY8VrHD30o8=;
        b=d2Kq7X9PZWPixVtDDVoPLIPnUh1hUhdlyYX0pyjntJpJazFIQSQljmSpN57m0lqn5n
         lXWq1skHPA6Ihp1WAzKoOQyAq3Y+6iAUlmFXPk24n7RHhyWem3b4zbo1RmMwUXMfq2gA
         vAs0c1CZL2MYTllziHE67ooscuuCHYzfPUiIQJKAm462TNuhfd7lHuLW+lxwXxS9dQMc
         UUooXCX0QxCuvBizXliyD7AND9kg/iy8KYlJATqUr7L0Xw3Z6hq0SUpnfP1nP2hehyCH
         cv3OhbzRCQD4XP2OfMzrER1ALlKWZHm3lv63kkOe9WCUtBseEz98jsQRnmrlq+HHr1Tl
         o5Gw==
X-Gm-Message-State: AOJu0YxsDWAm42m2Up81v5zXWnsDjbI6HwLXxiHGq4oXxbC3Gn+AdykT
	FyMpZJKfgwgpfu/cNcuHxczK/5namCqziZ4G987fU4QQIQuEGfhNmPSegrJmDLUvecy7R6rTzM0
	dZHN7aNANko+EEHG3yCZyHGBHxaDoM4hx55wkpOYZvRFCSz+Xc2GYs42W8uHgOXrZ9fB6jP9Q13
	g8giKadQnRltDxo1WCyYEM04cbb2BDtP4+vEkYink=
X-Google-Smtp-Source: AGHT+IFQ0k3vbcGgjJiFO+J21/D2vyau3B+J8kPOZBCb/gJiTCjGbZeXHjHZMdzoBTq6EzhdYkv1HmyqXn9kjQ==
X-Received: from pfav8.prod.google.com ([2002:a05:6a00:ab08:b0:728:b8e3:993f])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3385:b0:1e1:f281:8cf5 with SMTP id adf61e73a8af0-1eb2114c60amr70590470637.0.1738023551753;
 Mon, 27 Jan 2025 16:19:11 -0800 (PST)
Date: Mon, 27 Jan 2025 16:19:03 -0800
In-Reply-To: <cover.1738023208.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738023208.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <f1502b85901d81889d86597f31eca40e1965d56f.1738023208.git.steadmon@google.com>
Subject: [PATCH v7 2/4] libgit-sys: introduce Rust wrapper for libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
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
 Makefile                                  | 38 +++++++++++++
 contrib/libgit-sys/Cargo.lock             | 69 +++++++++++++++++++++++
 contrib/libgit-sys/Cargo.toml             | 19 +++++++
 contrib/libgit-sys/README.md              |  4 ++
 contrib/libgit-sys/build.rs               | 35 ++++++++++++
 contrib/libgit-sys/public_symbol_export.c | 22 ++++++++
 contrib/libgit-sys/public_symbol_export.h |  8 +++
 contrib/libgit-sys/src/lib.rs             | 46 +++++++++++++++
 t/Makefile                                | 10 ++++
 10 files changed, 252 insertions(+)
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
index 27e68ac039..92989d3311 100644
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
@@ -3887,3 +3906,22 @@ $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-
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
index 0000000000..cd1602206e
--- /dev/null
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -0,0 +1,22 @@
+/* Shim to publicly export Git symbols. These must be renamed so that the
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

