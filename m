Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BE16B736
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243286; cv=none; b=lFb6mVy15yhpiZa+ChCpE265iODRH1xZsDhokDOf0brt8kATkPVt6L8oloK8RWSPoXOa6+jVvTPONJSFNhhoMQb0p7hHlRQnHcVU0MiS5bvVV+W0no9Lbgc+PeaWbq1UKpteVxYhKtaEH2a7fQ9HEHSz1o8fmk5PtQieNsiE/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243286; c=relaxed/simple;
	bh=P9SN01TY9qrYrAXutS0gKDc9Y2uf/Kgt2pipebGiooY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6w/g1EmmXjjhDYcfkElBVWtOaUO/n/Je7zYHTj5zCJHuzvep0syD/2jnsU2UmqUnigPZ/bE0tWy6CnO2UFXwuZD1xrXwNvzU6yCzdnGixjsg+YkPrhnF9jqi8nl9jhk7+s9KrlD6n09hDeEb9Sudkbg3qVxPTlkcKdYZozLtag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lbwmww9Q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lbwmww9Q"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6698f11853aso50534177b3.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723243283; x=1723848083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDAipBjx3OBFPucxd82g5x3Ir4onD690hU+TZ6kUsxM=;
        b=Lbwmww9QMAxPnQlNQi/OZ7EvgOeFeeZYfoKrF76PAK3lJHzJYc3Jy1ZUSOrd4vfSRt
         SqJElS3dcgiOPsjCPP8FxSIKFGOEk3pge92+MXIt1D5CvkR58yItTyF4qC9BDBnGykwR
         0VOu8QvopPVU5nRWJRPmpQGlDwN1S5oPTVGNUV8s1v0fnrEvuQBXaY0xXv+0xvjZQ5uq
         wbMLyGpaA8ZDuUgCU8wIVJ4eV/pYChdscmtc/NwrsLIWrXeUiq6oyUoCX3/i5IeeMefB
         HIBJkJkxLIeR9D+is45GP/NkEDyuV+rOSB5ttc/F6iuEExdizUAbzRnqUDsEUPtenhen
         qAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243283; x=1723848083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDAipBjx3OBFPucxd82g5x3Ir4onD690hU+TZ6kUsxM=;
        b=L6sxOse/VbDs0KoCme6AlFC50+RGZJKThamEQvt05PpFtvXr25lxjfNbnJjMIu99ne
         Jf+PHPLzzEqS2usWgTR3rYLSQRooh0yznEXeqlxa4UzDbA/OtHCfAYfNZ4Tyznmwsszl
         +LhNgIgoNBSav6PxPwDvdNfRMI1KJPjg2SfH+Q8YjcIffUR8uBJrlymIso2HP/jva4Iu
         YRsKKJMZ6nnqZo9mVIr931gcfPf02Yb+FjDYOQtH1S4iQ202e33Oc9E+jD3h2zDfOFhE
         HU4ZC4/j2tTFz/ZfhK7aN9WRDT88yOfO11u0tLVR6WWc08OATGDf90uvdi3RRPt2OsFa
         Sclg==
X-Gm-Message-State: AOJu0YyF2qEa+PyO621aQnEMnJP0BsL1JBpEvZlUWWoDl+Na5poz8Zwj
	SPHU8wgy8egobvD/PcNQUf47avWAb4iPvT38wTHpyuxmP2LR3z2HEkbA8cZmobpluiuYsDhCqhU
	SoYgnD8v4yrUwvlU5x+aEsDUzI+gq7oLIQBeERI2Mns6FtjgJccABjnTTqE+Y+MOTfU7Jgnru4l
	rDKU1L9GRJef/P/22NJkTWqX+pFPemltdsVRCM28k=
X-Google-Smtp-Source: AGHT+IGU4g3AO90ajuNfTJhpKFXQPH8eO4xDqfbTU9SpJCI17s93qWAYq1odI5jN8PQwlRiMG5MK6u4DftuRpA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
 (user=steadmon job=sendgmr) by 2002:a5b:d44:0:b0:e0e:426b:bf6f with SMTP id
 3f1490d57ef6-e0eb99f2ea1mr6167276.7.1723243282469; Fri, 09 Aug 2024 15:41:22
 -0700 (PDT)
Date: Fri,  9 Aug 2024 15:41:14 -0700
In-Reply-To: <cover.1723242556.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <3589d2d6a2a24c2cc558d8e8fd05b56e28627eae.1723242556.git.steadmon@google.com>
Subject: [PATCH v2 2/5] cgit-sys: introduce Rust wrapper for libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

Introduce cgit-sys, a Rust wrapper crate that allows Rust code to call
functions in libgit.a. This initial patch defines build rules and an
interface that exposes user agent string getter functions as a proof of
concept. This library can be tested with `cargo test`. In later commits,
a higher-level library providing a more Rust-friendly interface will be
added at `contrib/cgit-rs`.

Symbols in cgit-sys can collide with symbols from other libraries such
as libgit2. We avoid this by first exposing library symbols in
public_symbol_export.[ch]. These symbols are prepended with "libgit_" to
avoid collisions and set to visible using a visibility pragma. In
build.rs, Rust builds contrib/cgit-rs/cgit-sys/libcgit.a, which also
contains libgit.a and other dependent libraries, with
-fvisibility=hidden to hide all symbols within those libraries that
haven't been exposed with a visibility pragma.

Co-authored-by: Kyle Lippincott <spectral@google.com>
Co-authored-by: Calvin Wan <calvinwan@google.com>
Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore                                    |  1 +
 Makefile                                      | 13 ++++++
 contrib/cgit-rs/cgit-sys/Cargo.lock           |  7 ++++
 contrib/cgit-rs/cgit-sys/Cargo.toml           |  9 +++++
 contrib/cgit-rs/cgit-sys/README.md            | 15 +++++++
 contrib/cgit-rs/cgit-sys/build.rs             | 32 +++++++++++++++
 .../cgit-rs/cgit-sys/public_symbol_export.c   | 20 ++++++++++
 .../cgit-rs/cgit-sys/public_symbol_export.h   |  8 ++++
 contrib/cgit-rs/cgit-sys/src/lib.rs           | 40 +++++++++++++++++++
 9 files changed, 145 insertions(+)
 create mode 100644 contrib/cgit-rs/cgit-sys/Cargo.lock
 create mode 100644 contrib/cgit-rs/cgit-sys/Cargo.toml
 create mode 100644 contrib/cgit-rs/cgit-sys/README.md
 create mode 100644 contrib/cgit-rs/cgit-sys/build.rs
 create mode 100644 contrib/cgit-rs/cgit-sys/public_symbol_export.c
 create mode 100644 contrib/cgit-rs/cgit-sys/public_symbol_export.h
 create mode 100644 contrib/cgit-rs/cgit-sys/src/lib.rs

diff --git a/.gitignore b/.gitignore
index 8caf3700c2..567cc9888f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -248,3 +248,4 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/contrib/cgit-rs/cgit-sys/target
diff --git a/Makefile b/Makefile
index 7caeb3c872..db8af99f20 100644
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
+OBJECTS += contrib/cgit-rs/cgit-sys/public_symbol_export.o
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3720,6 +3723,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
+	$(RM) -r contrib/cgit-rs/cgit-sys/target
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
@@ -3865,3 +3869,12 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
 build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
+
+contrib/cgit-rs/cgit-sys/partial_symbol_export.o: contrib/cgit-rs/cgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
+	$(LD) -r $^ -o $@
+
+contrib/cgit-rs/cgit-sys/hidden_symbol_export.o: contrib/cgit-rs/cgit-sys/partial_symbol_export.o
+	$(OBJCOPY) --localize-hidden $^ $@
+
+contrib/cgit-rs/cgit-sys/libcgit.a: contrib/cgit-rs/cgit-sys/hidden_symbol_export.o
+	$(AR) $(ARFLAGS) $@ $^
diff --git a/contrib/cgit-rs/cgit-sys/Cargo.lock b/contrib/cgit-rs/cgit-sys/Cargo.lock
new file mode 100644
index 0000000000..419a6d42f2
--- /dev/null
+++ b/contrib/cgit-rs/cgit-sys/Cargo.lock
@@ -0,0 +1,7 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "cgit-sys"
+version = "0.1.0"
diff --git a/contrib/cgit-rs/cgit-sys/Cargo.toml b/contrib/cgit-rs/cgit-sys/Cargo.toml
new file mode 100644
index 0000000000..e840f04024
--- /dev/null
+++ b/contrib/cgit-rs/cgit-sys/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "cgit-sys"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+links = "git"
+
+[lib]
+path = "src/lib.rs"
diff --git a/contrib/cgit-rs/cgit-sys/README.md b/contrib/cgit-rs/cgit-sys/README.md
new file mode 100644
index 0000000000..7a59602c30
--- /dev/null
+++ b/contrib/cgit-rs/cgit-sys/README.md
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
diff --git a/contrib/cgit-rs/cgit-sys/build.rs b/contrib/cgit-rs/cgit-sys/build.rs
new file mode 100644
index 0000000000..e29d703870
--- /dev/null
+++ b/contrib/cgit-rs/cgit-sys/build.rs
@@ -0,0 +1,32 @@
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
+            "contrib/cgit-rs/cgit-sys/libcgit.a",
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
+    std::fs::copy(crate_root.join("libcgit.a"), dst.join("libcgit.a"))?;
+    println!("cargo::rustc-link-search=native={}", dst.display());
+    println!("cargo::rustc-link-lib=cgit");
+    println!("cargo::rustc-link-lib=z");
+    println!("cargo::rerun-if-changed={}", git_root.display());
+
+    Ok(())
+}
diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.c b/contrib/cgit-rs/cgit-sys/public_symbol_export.c
new file mode 100644
index 0000000000..deef4488c0
--- /dev/null
+++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.c
@@ -0,0 +1,20 @@
+// Shim to publicly export Git symbols. These must be renamed so that the
+// original symbols can be hidden. Renaming these with a "libgit_" prefix also
+// avoid conflicts with other libraries such as libgit2.
+
+#include "contrib/cgit-rs/cgit-sys/public_symbol_export.h"
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
diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.h b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
new file mode 100644
index 0000000000..a3372f93fa
--- /dev/null
+++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
@@ -0,0 +1,8 @@
+#ifndef PUBLIC_SYMBOL_EXPORT_H
+#define PUBLIC_SYMBOL_EXPORT_H
+
+const char *libgit_user_agent(void);
+
+const char *libgit_user_agent_sanitized(void);
+
+#endif /* PUBLIC_SYMBOL_EXPORT_H */
diff --git a/contrib/cgit-rs/cgit-sys/src/lib.rs b/contrib/cgit-rs/cgit-sys/src/lib.rs
new file mode 100644
index 0000000000..bc33c6c498
--- /dev/null
+++ b/contrib/cgit-rs/cgit-sys/src/lib.rs
@@ -0,0 +1,40 @@
+use std::ffi::c_char;
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
2.46.0.76.ge559c4bf1a-goog

