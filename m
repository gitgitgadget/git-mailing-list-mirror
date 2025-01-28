Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEEF9F8
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023559; cv=none; b=ctaWUC7TeEKRwM4JMVgR26IdDsq+L26WUxmIdCu5c1ApHq6/Cb7pUPnvovzg3VXFcAmj/SFSXSMgnlTNunbfaUpajCQ7bARuXpARi17A4eTCt9zo1SBllFipYQAXCjDfrl6OsDPJTLxuY05CxYSZb8FmRT1p5Z8S5M1DWkz/Aj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023559; c=relaxed/simple;
	bh=C4prngDzo+YZtEUjDYEQ0QXTYEN+dptBKqb6lsscX9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VxCqP/kH+V3CbFEcCsvOPCw2tVsDNmT4zcL2UVbIpQffo04SNSNA4KJAiDfaP5wIZOid8XVR2kDCrpMH/i1Ps6I+ZOHML23ExjSxA6uafcOzBlkgIQIl+NTa6RKg7WJS3Gg/09t64vuj6kRE+2ySLU/r0fIX3r63MkNFiyxk1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHJa4Nm7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHJa4Nm7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so3539452a91.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738023555; x=1738628355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMpvGQqX3m0EsIbNw7ZzudTz8bDSttxLLYcodOeK5hg=;
        b=GHJa4Nm7Zvys/jeY5IK84NjK1VNVrt2/wMhVS6MbvF/nAeKWF6YgEycsMeK21za3ST
         un1JnS5ZwfSZClwhda63/LMd7LhOYcnbG9Re8zwY+huzSN5KmtB7aaSecUHHZASQieD3
         AWSoVkKI45DvYEI9JkE3AB1+45YUHNM4u40Bp97hTWMob7SzvwzxTcoeaBRuMDyQZ0G9
         e5HtQ2BSmsPtieqCqR7azxZQQ3gyVcHezJsBy5QNrTQ2PKGaGNONSOoGP5pwzh11VjBq
         xnoZUOU3BqpYyioLVO4aoEhERaHG97cY9pRv1Xb8EdBkoS+QZg0tsLky8AtUl31+4odL
         AAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738023555; x=1738628355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMpvGQqX3m0EsIbNw7ZzudTz8bDSttxLLYcodOeK5hg=;
        b=p9eHJfEh+Zg9LUk+7pSwR6+6d6Fzj5A/asBlhkHVB2CAkOMBDvryntdJlOS7qShv4y
         Cl5/Omjtxb0uVKzI8zTEhKqrxGYyn8EcE++Hbr/vMlzEcVHNgtg7DVHMeUR3/TB7kIdr
         htfdPtIn0mbEurCug01BFqQRAGocyf8LwEbKLfhw+pTrQYawy4IXW/WyMUGYwHf9uCFz
         i/qQQQb+ZtlUixNWlkhiQ+h6s+MQZSSeWIQ3hdWaQ3/RnZWThxdhb/3MC/DZurQkPzTK
         xQrVPU49nx6Ff2mDdLP57ClDaW1+VzL51MvfIEODFo2tXvuMwqrRnJblDLK7jhcl71a1
         RqEg==
X-Gm-Message-State: AOJu0Yxw41GpfuxCZ3i16iPRQEuRYWjtcvWCa1LW0KcYI61Hm6uBBtes
	oLrx7aUYzBbBnxfI7NaKz8gOe8ZA6dVgCgDazH58AcqrEwSl4JrMETiabAr08HyzQwauQTAOFly
	HfERgiRvJ3xWKJoRDB6sBgwcev3eQpvx4w47QooACR65558d1F9t9JU3cCpjlXSLNUh90CSExgv
	3hbfOxog4x07nqCCLeyllmlGPsxDHXUVtPoqUvsAI=
X-Google-Smtp-Source: AGHT+IGZhmYujqWWvjal5wvxjS2HhzUUYXHLzkCbWup63XizILfsWEX0kNjItAX+OdFsGnXmJUaC8Uc94LucFQ==
X-Received: from pja7.prod.google.com ([2002:a17:90b:5487:b0:2f5:63a:4513])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f81:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2f782d9a170mr56396838a91.32.1738023555544;
 Mon, 27 Jan 2025 16:19:15 -0800 (PST)
Date: Mon, 27 Jan 2025 16:19:05 -0800
In-Reply-To: <cover.1738023208.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738023208.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <88425bb0b1b90cf6b3d2d5a1af57e46c7a03ad39.1738023208.git.steadmon@google.com>
Subject: [PATCH v7 4/4] libgit: add higher-level libgit crate
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

The C functions exported by libgit-sys do not provide an idiomatic Rust
interface. To make it easier to use these functions via Rust, add a
higher-level "libgit" crate, that wraps the lower-level configset API
with an interface that is more Rust-y.

This combination of $X and $X-sys crates is a common pattern for FFI in
Rust, as documented in "The Cargo Book" [1].

[1] https://doc.rust-lang.org/cargo/reference/build-scripts.html#-sys-packages

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 .gitignore                         |   1 +
 Makefile                           |  13 ++--
 contrib/libgit-rs/Cargo.lock       |  77 +++++++++++++++++++++
 contrib/libgit-rs/Cargo.toml       |  17 +++++
 contrib/libgit-rs/README.md        |  13 ++++
 contrib/libgit-rs/build.rs         |   4 ++
 contrib/libgit-rs/src/config.rs    | 106 +++++++++++++++++++++++++++++
 contrib/libgit-rs/src/lib.rs       |   1 +
 contrib/libgit-rs/testdata/config1 |   2 +
 contrib/libgit-rs/testdata/config2 |   2 +
 contrib/libgit-rs/testdata/config3 |   2 +
 contrib/libgit-sys/src/lib.rs      |   4 ++
 t/Makefile                         |   9 ++-
 13 files changed, 245 insertions(+), 6 deletions(-)
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/README.md
 create mode 100644 contrib/libgit-rs/build.rs
 create mode 100644 contrib/libgit-rs/src/config.rs
 create mode 100644 contrib/libgit-rs/src/lib.rs
 create mode 100644 contrib/libgit-rs/testdata/config1
 create mode 100644 contrib/libgit-rs/testdata/config2
 create mode 100644 contrib/libgit-rs/testdata/config3

diff --git a/.gitignore b/.gitignore
index 31d7e64287..acdd8ce7c7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -250,4 +250,5 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/contrib/libgit-rs/target
 /contrib/libgit-sys/target
diff --git a/Makefile b/Makefile
index 92989d3311..37b63de079 100644
--- a/Makefile
+++ b/Makefile
@@ -417,7 +417,7 @@ include shared.mak
 # programs in oss-fuzz/.
 #
 # Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
-# test the Rust crate in contrib/libgit-sys.
+# test the Rust crates in contrib/libgit-sys and contrib/libgit-rs.
 #
 # === Optional library: libintl ===
 #
@@ -3741,7 +3741,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
-	$(RM) -r contrib/libgit-sys/target
+	$(RM) -r contrib/libgit-sys/target contrib/libgit-rs/target
 	$(RM) contrib/libgit-sys/partial_symbol_export.o
 	$(RM) contrib/libgit-sys/hidden_symbol_export.o
 	$(RM) contrib/libgit-sys/libgitpub.a
@@ -3907,14 +3907,19 @@ build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
-.PHONY: libgit-sys
+.PHONY: libgit-sys libgit-rs
 libgit-sys:
 	$(QUIET)(\
 		cd contrib/libgit-sys && \
 		cargo build \
 	)
+libgit-rs:
+	$(QUIET)(\
+		cd contrib/libgit-rs && \
+		cargo build \
+	)
 ifdef INCLUDE_LIBGIT_RS
-all:: libgit-sys
+all:: libgit-sys libgit-rs
 endif
 
 contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
diff --git a/contrib/libgit-rs/Cargo.lock b/contrib/libgit-rs/Cargo.lock
new file mode 100644
index 0000000000..a30c7c8d33
--- /dev/null
+++ b/contrib/libgit-rs/Cargo.lock
@@ -0,0 +1,77 @@
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
+name = "libgit"
+version = "0.1.0"
+dependencies = [
+ "autocfg",
+ "libgit-sys",
+]
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
diff --git a/contrib/libgit-rs/Cargo.toml b/contrib/libgit-rs/Cargo.toml
new file mode 100644
index 0000000000..c3289e69db
--- /dev/null
+++ b/contrib/libgit-rs/Cargo.toml
@@ -0,0 +1,17 @@
+[package]
+name = "libgit"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
+                      # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
+
+
+[lib]
+path = "src/lib.rs"
+
+[dependencies]
+libgit-sys = { version = "0.1.0", path = "../libgit-sys" }
+
+[build-dependencies]
+autocfg = "1.4.0"
diff --git a/contrib/libgit-rs/README.md b/contrib/libgit-rs/README.md
new file mode 100644
index 0000000000..ff945e1ce2
--- /dev/null
+++ b/contrib/libgit-rs/README.md
@@ -0,0 +1,13 @@
+# libgit-rs
+
+Proof-of-concept Git bindings for Rust.
+
+```toml
+[dependencies]
+libgit = "0.1.0"
+```
+
+## Rust version requirements
+
+libgit-rs should support Rust versions at least as old as the version included
+in Debian stable (currently 1.63).
diff --git a/contrib/libgit-rs/build.rs b/contrib/libgit-rs/build.rs
new file mode 100644
index 0000000000..f8bd01a690
--- /dev/null
+++ b/contrib/libgit-rs/build.rs
@@ -0,0 +1,4 @@
+pub fn main() {
+    let ac = autocfg::new();
+    ac.emit_has_path("std::ffi::c_char");
+}
diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
new file mode 100644
index 0000000000..6bf04845c8
--- /dev/null
+++ b/contrib/libgit-rs/src/config.rs
@@ -0,0 +1,106 @@
+use std::ffi::{c_void, CStr, CString};
+use std::path::Path;
+
+#[cfg(has_std__ffi__c_char)]
+use std::ffi::{c_char, c_int};
+
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+type c_char = i8;
+
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+type c_int = i32;
+
+use libgit_sys::*;
+
+/// A ConfigSet is an in-memory cache for config-like files such as `.gitmodules` or `.gitconfig`.
+/// It does not support all config directives; notably, it will not process `include` or
+/// `includeIf` directives (but it will store them so that callers can choose whether and how to
+/// handle them).
+pub struct ConfigSet(*mut libgit_config_set);
+impl ConfigSet {
+    /// Allocate a new ConfigSet
+    pub fn new() -> Self {
+        unsafe { ConfigSet(libgit_configset_alloc()) }
+    }
+
+    /// Load the given files into the ConfigSet; conflicting directives in later files will
+    /// override those given in earlier files.
+    pub fn add_files(&mut self, files: &[&Path]) {
+        for file in files {
+            let pstr = file.to_str().expect("Invalid UTF-8");
+            let rs = CString::new(pstr).expect("Couldn't convert to CString");
+            unsafe {
+                libgit_configset_add_file(self.0, rs.as_ptr());
+            }
+        }
+    }
+
+    /// Load the value for the given key and attempt to parse it as an i32. Dies with a fatal error
+    /// if the value cannot be parsed. Returns None if the key is not present.
+    pub fn get_int(&mut self, key: &str) -> Option<i32> {
+        let key = CString::new(key).expect("Couldn't convert to CString");
+        let mut val: c_int = 0;
+        unsafe {
+            if libgit_configset_get_int(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
+                return None;
+            }
+        }
+
+        Some(val.into())
+    }
+
+    /// Clones the value for the given key. Dies with a fatal error if the value cannot be
+    /// converted to a String. Returns None if the key is not present.
+    pub fn get_string(&mut self, key: &str) -> Option<String> {
+        let key = CString::new(key).expect("Couldn't convert key to CString");
+        let mut val: *mut c_char = std::ptr::null_mut();
+        unsafe {
+            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
+            {
+                return None;
+            }
+            let borrowed_str = CStr::from_ptr(val);
+            let owned_str =
+                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
+            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
+            Some(owned_str)
+        }
+    }
+}
+
+impl Default for ConfigSet {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl Drop for ConfigSet {
+    fn drop(&mut self) {
+        unsafe {
+            libgit_configset_free(self.0);
+        }
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn load_configs_via_configset() {
+        let mut cs = ConfigSet::new();
+        cs.add_files(&[
+            Path::new("testdata/config1"),
+            Path::new("testdata/config2"),
+            Path::new("testdata/config3"),
+        ]);
+        // ConfigSet retrieves correct value
+        assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
+        // ConfigSet respects last config value set
+        assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
+        // ConfigSet returns None for missing key
+        assert_eq!(cs.get_string("foo.bar"), None);
+    }
+}
diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
new file mode 100644
index 0000000000..ef68c36943
--- /dev/null
+++ b/contrib/libgit-rs/src/lib.rs
@@ -0,0 +1 @@
+pub mod config;
diff --git a/contrib/libgit-rs/testdata/config1 b/contrib/libgit-rs/testdata/config1
new file mode 100644
index 0000000000..4e9a9d25d1
--- /dev/null
+++ b/contrib/libgit-rs/testdata/config1
@@ -0,0 +1,2 @@
+[trace2]
+	eventNesting = 1
diff --git a/contrib/libgit-rs/testdata/config2 b/contrib/libgit-rs/testdata/config2
new file mode 100644
index 0000000000..b8d1eca423
--- /dev/null
+++ b/contrib/libgit-rs/testdata/config2
@@ -0,0 +1,2 @@
+[trace2]
+	eventTarget = 1
diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
new file mode 100644
index 0000000000..ca7b9a7c38
--- /dev/null
+++ b/contrib/libgit-rs/testdata/config3
@@ -0,0 +1,2 @@
+[trace2]
+	eventNesting = 3
diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
index dadb4e5f40..4bfc650450 100644
--- a/contrib/libgit-sys/src/lib.rs
+++ b/contrib/libgit-sys/src/lib.rs
@@ -1,3 +1,5 @@
+use std::ffi::c_void;
+
 #[cfg(has_std__ffi__c_char)]
 use std::ffi::{c_char, c_int};
 
@@ -19,6 +21,8 @@ pub struct libgit_config_set {
 }
 
 extern "C" {
+    pub fn free(ptr: *mut c_void);
+
     pub fn libgit_user_agent() -> *const c_char;
     pub fn libgit_user_agent_sanitized() -> *const c_char;
 
diff --git a/t/Makefile b/t/Makefile
index 53ba01c21b..2994eb5fa9 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -178,12 +178,17 @@ perf:
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
 
-.PHONY: libgit-sys-test
+.PHONY: libgit-sys-test libgit-rs-test
 libgit-sys-test:
 	$(QUIET)(\
 		cd ../contrib/libgit-sys && \
 		cargo test \
 	)
+libgit-rs-test:
+	$(QUIET)(\
+		cd ../contrib/libgit-rs && \
+		cargo test \
+	)
 ifdef INCLUDE_LIBGIT_RS
-all:: libgit-sys-test
+all:: libgit-sys-test libgit-rs-test
 endif
-- 
2.48.1.262.g85cc9f2d1e-goog

