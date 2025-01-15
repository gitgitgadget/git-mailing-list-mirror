Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077D1D90CB
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971557; cv=none; b=XC5TiFxjDnRh26YMYn2UmBcLboCVHS2zBaeN004V7wd866gFPVsWdNctYp8lLadmEXkbLTfw0k8JIEoLbB2/7JOtTpKYa1k81uUu2DKTeJs2rVGN98OrVC2tvTI99+PlYHHzOiZV58SQwD/R6BUVzVFknhHs4KmNn1jt2eyvJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971557; c=relaxed/simple;
	bh=LkjLM1nhHFTIApOga4w99yTF7A/SkxaG9yva1Kjwshc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R5k1Ojb7vB5wVxfx6idorZ54VDIMjGSTgDCRjGPVJvZim5CQg5hsC6aPp0ZKt8tHtLf/475T1KA+fLY23UxJI5xeUOSG/fe2J6FTKYwXJwuyObyhxEmg5mzGy2r5cLYpvLZ/ljc5GdKnT911ubDjicA7LEB4RmZUVt6ZvJSQDmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABNIY6S3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABNIY6S3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so382571a91.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736971555; x=1737576355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gE6L9R62t9MR0B3GyekEy3HsUzsDN79NYogjhUajJew=;
        b=ABNIY6S3539/mVbExW9aG1fjbqFJrkE9gJnXIpnTOSz/5LJkwqp3rSzS0oLRqfon2A
         ht6vqV1sXWjb9qZohJe1Q3X1y0Cl+cnK/06wOTmf+a2fJPEinpcWYzql/N9DZW5NGtsE
         aeekuVPdsikpuDLSXoYDzAPQpzWKzCyIwRKBnpuke2I5O7NRTk55xArsJcrWuupJja3H
         DZS63SWITWJSTWNf4sm8w5av4Ae3OEuLOIpwTPIKi81/UnxrWMJsOfh4D2DH5exhcrkG
         XVZiLU6Xzqf5clU8Qh1bIv5cHstd7w8ozB5v2wBRdrdD6U9foH6uGQVmrZdUVbSX5wzN
         DbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971555; x=1737576355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE6L9R62t9MR0B3GyekEy3HsUzsDN79NYogjhUajJew=;
        b=WBwuyeFW15oY4qYJhl0CVOzVxd8R2CBr442z85bcrHim0Lwr+nrJfrr3LkP9VkA/7T
         t1cj8TJhOZ1DhqDVieSAkA2YY4kUSn9h3M9Fn3D9oNF+bRhpF84/I2DnuvRyJwaFY6Es
         AL67dD+kZ6EVmmlX0VVY2hoa3mhVHO56FZY8gcjLXLXtMXSOuXogkZMAgGWjHroFR+20
         SY4u3t0lYZvCqlLmBKdIwPd0CS2s0R42U3582YgKUAHWHB4Zl55PcNib7+4OkmizoHnW
         VrP2X3PdWXj7V3rKmU2e0avbno8L+qwmdEd+x6HubJeEhpvJf0/2SODX7YpGwC4/4/Q/
         zsVw==
X-Gm-Message-State: AOJu0Yy/LGGx7P7csNhx4VIG9LtM4McijQHCA3Aaz/H678NfeX2K0bQQ
	l0LnH+rIAcNZQFnPeH3x+7aLxjY6WEAO2ZeZljKbjgWWwb8rE945iOSwhDZoPSdS7rX39xebVJY
	bZDc6Zsfs5SUL8ftfegng9mUd116jU10TqmfHAEj1HG9UrUr+Wt2mJYcx3Bv5lQoVJNHrLOSClI
	r/DhDJAlCphksfKosJNhO4NfnQPcfGNq592T+fj9I=
X-Google-Smtp-Source: AGHT+IGKLr1d3yc1oi9nzXcVxuX7eoRGJUYOdOtc3fLb0SlR4nqFlaIjzDVpAslw0l5VIpniW1T3C2kc37BrkQ==
X-Received: from pjz13.prod.google.com ([2002:a17:90b:56cd:b0:2f4:3eb4:f8bf])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:270d:b0:2ef:31a9:95c6 with SMTP id 98e67ed59e1d1-2f548ebf526mr47083883a91.14.1736971554844;
 Wed, 15 Jan 2025 12:05:54 -0800 (PST)
Date: Wed, 15 Jan 2025 12:05:43 -0800
In-Reply-To: <cover.1736971328.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1736971328.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <65166ea0c077665c350a1a7b00dc3175be889d55.1736971328.git.steadmon@google.com>
Subject: [PATCH v6 4/5] libgit: add higher-level libgit crate
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
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
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore                         |  1 +
 Makefile                           |  2 +-
 contrib/libgit-rs/Cargo.lock       | 77 ++++++++++++++++++++++++
 contrib/libgit-rs/Cargo.toml       | 15 +++++
 contrib/libgit-rs/README.md        | 13 ++++
 contrib/libgit-rs/build.rs         |  4 ++
 contrib/libgit-rs/src/lib.rs       | 95 ++++++++++++++++++++++++++++++
 contrib/libgit-rs/testdata/config1 |  2 +
 contrib/libgit-rs/testdata/config2 |  2 +
 contrib/libgit-rs/testdata/config3 |  2 +
 contrib/libgit-sys/src/lib.rs      |  4 ++
 11 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/README.md
 create mode 100644 contrib/libgit-rs/build.rs
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
index 47e864a861..230d366457 100644
--- a/Makefile
+++ b/Makefile
@@ -3729,7 +3729,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
-	$(RM) -r contrib/libgit-sys/target
+	$(RM) -r contrib/libgit-rs/target contrib/libgit-sys/target
 	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
 	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
 	$(RM) -r contrib/libgit-sys/libgitpub.a
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
index 0000000000..634435cd6c
--- /dev/null
+++ b/contrib/libgit-rs/Cargo.toml
@@ -0,0 +1,15 @@
+[package]
+name = "libgit"
+version = "0.1.0"
+edition = "2021"
+build = "build.rs"
+rust-version = "1.63"
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
diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
new file mode 100644
index 0000000000..27b6fd63f1
--- /dev/null
+++ b/contrib/libgit-rs/src/lib.rs
@@ -0,0 +1,95 @@
+use std::ffi::{c_void, CStr, CString};
+use std::path::Path;
+
+#[cfg(has_std__ffi__c_char)]
+use std::ffi::{c_char, c_int};
+
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+pub type c_char = i8;
+
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+pub type c_int = i32;
+
+use libgit_sys::*;
+
+pub struct ConfigSet(*mut libgit_config_set);
+impl ConfigSet {
+    pub fn new() -> Self {
+        unsafe { ConfigSet(libgit_configset_alloc()) }
+    }
+
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
 
-- 
2.48.0.rc2.279.g1de40edade-goog

