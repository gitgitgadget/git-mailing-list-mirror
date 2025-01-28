Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CB1DFD95
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101712; cv=none; b=NeuHJoiH3ZQ+5diVJ+SDGDwnicCb2NCMn3bgApIXOV5NbN4WOarUTiJtxhCRe6NLm4LDC1E6bCRDhOWDG+yD9lcNDknQrOrImDoJXiTWIXe76zRRdy/DSMBbTPTwEH2xZiMFxXimqlMsm2JEErD2Ai+Z8Qw6cz0mJQ/hx/dkf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101712; c=relaxed/simple;
	bh=p2HJuTxM42BBE9RV+vcPaIdFnhXcuNgrXIEIkkPT53M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dUNmAMAV59WUbGq2ODkOdq1F71XUNUmmEp1BNDoSR3eF4Hdi+e+UlFHg1hrxMzMyqzV4HJwOvSnFFQbPYywfAtuNiWU1N22VCiEl9ak4sBrQFiDito1ChpeFsBXXvRuOAuXiujR5K/nt8rqKN8T3hdaYYFm7amWFDRF3JNvNc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H01Jt/84; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H01Jt/84"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2b268f6e85eso4335407fac.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738101709; x=1738706509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sfzi7vpvvL3sAOj7/y+ktcdyvKqi73B+gJIE5IQt3Ro=;
        b=H01Jt/841Y3rI1+5b/975hAjWWg3oTbRie699ds/QnPq0X7sjyRYxSrPtxoyYP+r/U
         TEy22JDNdXMsmnEKNdJrr6mz66FFopvWuUStikP0l+JoToZapVwwN42Q90Hisnu8t/1Q
         9y2914wQaCBAwNWq8hnCR/H4c7ZDEVHUBksKkdXKj9wlhThKrBXCF5ZJ7OXBz7ealERZ
         jOxjPK+zEOkWxUg4O+QTZvo2khPwxuX8T2DWbmuLiiNQVQDkTnm7XFEaK1kMegNq4lrw
         hjuVo40PNhMABz8J3VmQzkIaPYVDFma4nSpm7qcaQcBz26o+2dy0BIRdYj8lr16Jdpvg
         6mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101709; x=1738706509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfzi7vpvvL3sAOj7/y+ktcdyvKqi73B+gJIE5IQt3Ro=;
        b=uUYELpSWQK+weGn/GOMKaWRAI4fE1Z8oMolntbbso4EBuxpcgP1PhyoT0Lm0Fl9PZO
         mjgJiLZnFVYZmupt0NhSaZDn81qvjJnrYW+R9MVrhWDgY5ImShRFugCrUQJXebkMp5ku
         klqmlO8InkCB80Hk/X+k/4PhV/EYqpdAX0MtBX7PGN38awR4+8+aKD95IqZgr1o5IvTC
         l18tVmEytqk7gGIiCkDc9K3RT4aafrz9PPDom3przJo/QMVlu0eEoK0sIt0ARuiEEPUq
         ti+E+WimqTcH7YXapbRmWkg4bKZTik7r2aXWMNZxZ2EQi+Y3fxEHBSd8hHRoPhxnM3Tr
         Ms0w==
X-Gm-Message-State: AOJu0Yw/fqGjiKQCwjSfxEEqh2ot3rjSOQdFleHpc9nb8CuVdFVYfu6Y
	vJnLFN9AMlxHqTGlBLWbE5FghSvFWy40DcYEy6Fzelfg29PcJNPgOyw47/+lCadn4lHBgX2Jmq+
	1pQdGf5dCUdXaYeBJO+74lPVPmDSpo9Ntj4CgUGLFiDsq20j78sSTMdvoN5WlvZvcDNdRObuE4H
	/ub41ml8lugRQ33Z/82i1eEiVp6bpshK6YQLrgJSY=
X-Google-Smtp-Source: AGHT+IFuW25WYuT6r7jB6EvtXDsiE2/5et8c4hySFIi7MIitPHUPo/cFRjGffXPYRVvunNPF5PfHn380SPfakA==
X-Received: from oabmk6.prod.google.com ([2002:a05:6870:d06:b0:288:e08d:60c9])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:538e:b0:297:2719:deb6 with SMTP id 586e51a60fabf-2b32f0997bamr525407fac.1.1738101709313;
 Tue, 28 Jan 2025 14:01:49 -0800 (PST)
Date: Tue, 28 Jan 2025 14:01:40 -0800
In-Reply-To: <cover.1738101256.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738101256.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <ada9fc0a138287fbb92a7f7da0f5be37e3f56006.1738101256.git.steadmon@google.com>
Subject: [PATCH v8 4/4] libgit: add higher-level libgit crate
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com
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
 Makefile                           |  12 ++--
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
 13 files changed, 242 insertions(+), 8 deletions(-)
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
index f2c08df4cb..f883d310aa 100644
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
@@ -3907,14 +3907,14 @@ build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
 
-.PHONY: libgit-sys
-libgit-sys:
+.PHONY: libgit-sys libgit-rs
+libgit-sys libgit-rs:
 	$(QUIET)(\
-		cd contrib/libgit-sys && \
+		cd contrib/$@ && \
 		cargo build \
 	)
 ifdef INCLUDE_LIBGIT_RS
-all:: libgit-sys
+all:: libgit-sys libgit-rs
 endif
 
 LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
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

