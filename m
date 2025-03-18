Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B0207667
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340271; cv=none; b=fXtNKQA/0Z5VszNN5cuaomvO+mHyPePgxoMIfVefESaSEd7ZLMcLqd0lMmIKzs0onbm6JKlEZ2uFzIYe/wb2VAxzhChJAGQ66D9g7RlA8WEEaBj8yyTMieZaMV23SfgtwSIm1aBsRDHxUVVksbNIMxrblG3M3NjlUK6TlC2OzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340271; c=relaxed/simple;
	bh=ZkTAo280NRur2dvgypHKKxKOf/t26e/67u0FYiU5pWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VE6I4iuMMgr91CQf2rFkMfYemu7pUG/at4ab757Cjq53nlBtVLurSnCiGnjrPRRogKsvs2CrnJK9E/q7ANupHuDpNGTWTl3vxfs37Ocscv9zHrrzsO7FG66FO06IpCHzXpNTsmOisx6B8KOsp9HPjgDXYBcU4ZjyTb73mFtOUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOjGcIuO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOjGcIuO"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241ae15dcbso135930005ad.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742340268; x=1742945068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAYTvgnQhoL1kiNyyBSrw8pWntmvGFx6Yi/YHaiJ6h4=;
        b=aOjGcIuOzffPR+vKEFEFtcfbvlr85G3/1jrEd3CYBX+MfKjkOJHUQZcCQGhH5e9l7g
         jMzSdpiBc8C4D+TXmLl4YTgd7xF8X+2dwDeUEp599g1cykTgWoMAnGtwKUM5YMPTuAe8
         UV1dc/Js97OZwy7za9CV1qFytEqM/kOaEA6Q3gtTjySShaWpMUK4VbF22W9N2HSRUMDJ
         meAWgC9SeH3phwnZb8pthwZ8y+4is03lNz+YPPqLCMfaJoHmAKD5cKaH99vRQGLCTamO
         ltY4Ez2MEMIGDKZy7wv70ujUGhnuWulyNrAk/NuTW9DDwEMifmnBOVJe6m9294Itb704
         6kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340268; x=1742945068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAYTvgnQhoL1kiNyyBSrw8pWntmvGFx6Yi/YHaiJ6h4=;
        b=eYt5lcIsrYIdZHB1YKqhiNpMi+4UiRcTn9po/ohtAn6zpq5umfMcojFKAvoZtmKhhx
         yERGe5LziHrVdnzFHNuF3SnGugdpn3TxD2DdJNJSwBKAADQgxAGcEh2E4693b+eQfSEF
         G4dJjMuzHSO0uSssIFKOHnRcPlQxFWxwDdWL/HkXepJhTQYI442XQXEhZNUqypo6YarQ
         uKbCJkwrzA35b0NMB4SemNAw7Lx/g7u+6EjAooG6WtatuydrTJ0jZStn23v/2pd+7Iza
         l7aqOb8GP1ARft4Al5kDDSwlEuQBR9j56Y1c8u4A4I2xXy+NbK/9zZ1szEWdXIg1dQFz
         vBCQ==
X-Gm-Message-State: AOJu0YzLg+4Z0MrX6Zn2fbs+XWXlZzqjS3KqTe5ofWPhvrFmL8qvUltw
	zenICjEoVZ2KM8gEvjHl9KUBAqdHKnCICPUPRKnL4zOgIz8fdZkBdOeZJttP0C+c0mjczbKAIMg
	booWU9dQi5wMk+YPy7FV2qvxVbEnBvET+Un3e9/d7SOgJ3oBwQXpvGK6SCHGfk9H9D4pstc+65u
	Tej0gNrJ/3LFXIPDZH8kb/UzbXDEu7hnS6WW1yeNA=
X-Google-Smtp-Source: AGHT+IEEBtdWIIPw4reKpXmqQFqJBzPQ/hM79RgJ5xXa1ZhWcfVxVqUNdmCSso/Apq5hN5VAAPZ4gRJf58D1Gg==
X-Received: from plau2.prod.google.com ([2002:a17:903:3042:b0:223:225b:3d83])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c7:b0:21f:564:80a4 with SMTP id d9443c01a7336-22649a59bb5mr5247815ad.33.1742340268424;
 Tue, 18 Mar 2025 16:24:28 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:20 -0700
In-Reply-To: <cover.1742339107.git.josh@steadmon.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <d592a3c2e3f56aa4f6915a07307a2ed349296272.1742339107.git.josh@steadmon.net>
Subject: [RFC PATCH v1 2/4] libgit-sys: add symlink to git repo root and clean
 after build
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Unlike `cargo build`, `cargo package` does not get access to the entire Git repo
containing a Rust crate. Instead, it prepares a directory starting from the
crate root (potentially excluding files, such as those not under version
control, or explicity excluded in the Cargo.toml file).

This means that the current method of building the libgit-sys crate does not
work with `cargo package`, as it tries to execute the Makefile from "../.."
relative to the crate root.

Fix this by adding a `git-src` symlink in the crate that points to the Git
repository root. `cargo package` will flatten this to a copy of the Git repo,
excluding non-version-controlled files, any explicitly-excluded files, and trees
that contain a Cargo.toml file (this prevents infinite recursion on the
symlink).

We can then execute the Makefile under the flattened git-src directory from our
build.rs script. However, this exposes a second problem; Cargo will check that
the build script does not add, delete, or modify any source files. This means
that after we copy our libgitpub.a dependency to the output directory, we must
run `make clean` to remove the object files we created during the build process.

Unfortunately, there is not a way to determine from the build.rs script whether
we're running `cargo build` vs. `cargo package`, so now any build of the
libgit-sys crate will result in cleaning the Git worktree.

A potential alternative is to make an additional temporary copy of the worktree
and run the Makefile there. This would avoid removing build artifacts in the
worktree at the cost of copying MBs worth of source files to a temporary
directory. Perhaps hardlinking instead of making a full copy would help here,
but that might be less portable.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                    |  6 ++++++
 contrib/libgit-sys/build.rs | 21 ++++++++++++++++++++-
 contrib/libgit-sys/git-src  |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)
 create mode 120000 contrib/libgit-sys/git-src

diff --git a/Makefile b/Makefile
index 52eed88dde..e7d8786e4e 100644
--- a/Makefile
+++ b/Makefile
@@ -420,6 +420,10 @@ include shared.mak
 # Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
 # test the Rust crates in contrib/libgit-sys and contrib/libgit-rs.
 #
+# Define PRESERVE_LIBGIT_TARGET to prevent `make clean` from removing the Cargo
+# output directories for libgit-sys and libgit-rs. This is mainly for use in the
+# Cargo build scripts.
+#
 # === Optional library: libintl ===
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -3761,7 +3765,9 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
+ifndef PRESERVE_LIBGIT_TARGET
 	$(RM) -r contrib/libgit-sys/target contrib/libgit-rs/target
+endif
 	$(RM) contrib/libgitpub/partial_symbol_export.o
 	$(RM) contrib/libgitpub/hidden_symbol_export.o
 	$(RM) contrib/libgitpub/libgitpub.a
diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
index e0d979c196..9d586d272d 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -6,7 +6,7 @@ pub fn main() -> std::io::Result<()> {
     ac.emit_has_path("std::ffi::c_char");
 
     let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
-    let git_root = crate_root.join("../..");
+    let git_root = crate_root.join("git-src");
     let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
 
     let make_output = make_cmd::gnu_make()
@@ -31,5 +31,24 @@ pub fn main() -> std::io::Result<()> {
     println!("cargo:rustc-link-lib=gitpub");
     println!("cargo:rerun-if-changed={}", git_root.display());
 
+    let make_output = make_cmd::gnu_make()
+        .env("DEVELOPER", "1")
+        .env_remove("PROFILE")
+        .current_dir(git_root.clone())
+        .args([
+            "INCLUDE_LIBGIT_RS=YesPlease",
+            "PRESERVE_LIBGIT_TARGET=YesPlease",
+            "clean",
+        ])
+        .output()
+        .expect("`make clean` failed to run");
+    if !make_output.status.success() {
+        panic!(
+            "`make clean` failed:\n  stdout = {}\n  stderr = {}\n",
+            String::from_utf8(make_output.stdout).unwrap(),
+            String::from_utf8(make_output.stderr).unwrap()
+        );
+    }
+
     Ok(())
 }
diff --git a/contrib/libgit-sys/git-src b/contrib/libgit-sys/git-src
new file mode 120000
index 0000000000..c25bddb6dd
--- /dev/null
+++ b/contrib/libgit-sys/git-src
@@ -0,0 +1 @@
+../..
\ No newline at end of file
-- 
2.49.0.rc1.451.g8f38331e32-goog

