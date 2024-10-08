Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E7218D8E
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429589; cv=none; b=um8oMla2JM0RtMT2sGMAyAw3AWwtOZMYncliiCloirgQDOOg07sT59q0jG5tjcaSHbWOpfGxyajEE2tN68XiCdDEKWeuZBoQGMxAvompfeFfALSMfPb/EZx2ThB/boJTsWrZebqJVx16+1lT7GBIftoj2NSWh/T/4M/fa7sYArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429589; c=relaxed/simple;
	bh=jcd7xiTm84CXMqpqj19bFFWUqC4qhjdpQJK9IF+6MV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sjhd26BsOWJAy20240AqRAkj/Tsw2c9AXjO97fMVRAfzfL9tkAQOsTXRrE32nUi5Y4DlRmmXJULt+ME55AN+8hqeDefO7YiBfdCdXWSnlaHJ1vcafe7an73hRb48ap9G3mCJy4J98znVJlZwwuOtpqc73F9z0H4KOeOXSGHh/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuYr3V8K; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuYr3V8K"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e294f38bddso96548537b3.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728429585; x=1729034385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAR3tCoa+iaYqvpE61gv8k47B6GsXYN5Tae+Ureei0g=;
        b=NuYr3V8KfRCj7TkTKbZWM8wHePqb3yTQI4Hz74jxNleJq27wfcKlsx07BGWaD/0A0P
         kc7cSBwYvRK/x43oVCjTKhWOrr7Bdq1EqQOUX/LP4WofXhFz5skj0NdTogrRg6qBZS3A
         /B9IJDLdPgOrgyisbYnfATDxWiXL3vzO526mff7sEA6Zj6W3KFcF0bobIGmoKt5Onz4g
         RyLtBGCpECQPWPWTwQq96boWbsracaG+R7aBOMtHUdmj2IgscsqqhOmudtTQqQ5nfwpT
         qc+PxYPTIJShx/dsz7ojWMMLjROhpMr3RRWhqLRdBWqxPPu5yWxoeGwBstlGdvnNAaEP
         D57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429585; x=1729034385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAR3tCoa+iaYqvpE61gv8k47B6GsXYN5Tae+Ureei0g=;
        b=dvKvNv5EtLBog8Zte2v/Y4TfqEtlNevggRVu+FUhg3s1skA90jSnHMJ0mFKw86oZKy
         cwgGERlFmhRCfNK3XKGn1y4m7N7JNXW1TRnNS6eCvMdH1NuNpH3W88+nDhdQgMcxxNKX
         CzdkzNN1izlSW5M+XnUj4ysP2DHLBHn0IowyVfQNKwxQ6aDaSUp8GnzcyW6qrOJejwKW
         NMgNib50x1NMyYGXlnhke1KrikykDHMJxsqFlYRCM+5RJ8LoFODnC2jYB9vD5Cn/pvvO
         OBjZzSv+yGs2/GRF88W2zPvjZxJTPQ+l0V21w+mcNHgaSx3SofxDVibls5q+rzEfE+Rx
         BFFw==
X-Gm-Message-State: AOJu0YzNSARzbx0sn5n+IQPRZ+DZqZtSFhzHJaZZU7QzA53+WdcFuxb3
	hg5vUrx3s95DRoFEn7nyF9BdTfNy8W7qFQGt5LUjh0Ux3lbmGNNgXH5YxGqGe4BvWeAztZla6Q2
	Pbom0FDtozrqu6Icg0GjkQ0zcaoDZWYfqfpf8/0jiyEQQ67/NlTfPZZiJIs+GbRjknXDh05OYJC
	QoNAg5KFizz+5Ln/Nj5JBZAc4b6xATClPHNWK0YyE=
X-Google-Smtp-Source: AGHT+IGvegBGvAd0HtTTczIhVZJA6Gn+H3M2H3UAvUnvaYsEjjfseFQg90U6ckP+1qxEYoVJ+7zN1dIg+bgB8g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:7c00:8752:4498:cc1b])
 (user=steadmon job=sendgmr) by 2002:a25:d04c:0:b0:e05:6532:166 with SMTP id
 3f1490d57ef6-e28fe334f9fmr4007276.1.1728429584750; Tue, 08 Oct 2024 16:19:44
 -0700 (PDT)
Date: Tue,  8 Oct 2024 16:19:34 -0700
In-Reply-To: <cover.1728429158.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1728429158.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <29599e9c7be1737bcf0de0541c9635212a1b691d.1728429158.git.steadmon@google.com>
Subject: [PATCH v4 4/5] libgit: add higher-level libgit crate
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, ps@pks.im, sunshine@sunshineco.com, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Wrap `struct config_set` and a few of its associated functions in
libgit-sys. Also introduce a higher-level "libgit" crate which provides
a more Rust-friendly interface to config_set structs.

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore                              |  1 +
 Makefile                                |  2 +-
 contrib/libgit-rs/Cargo.lock            | 77 ++++++++++++++++++++
 contrib/libgit-rs/Cargo.toml            | 15 ++++
 contrib/libgit-rs/build.rs              |  4 ++
 contrib/libgit-rs/libgit-sys/src/lib.rs |  4 ++
 contrib/libgit-rs/src/lib.rs            | 95 +++++++++++++++++++++++++
 contrib/libgit-rs/testdata/config1      |  2 +
 contrib/libgit-rs/testdata/config2      |  2 +
 contrib/libgit-rs/testdata/config3      |  2 +
 10 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/build.rs
 create mode 100644 contrib/libgit-rs/src/lib.rs
 create mode 100644 contrib/libgit-rs/testdata/config1
 create mode 100644 contrib/libgit-rs/testdata/config2
 create mode 100644 contrib/libgit-rs/testdata/config3

diff --git a/.gitignore b/.gitignore
index dfd72820fb..0a42f27117 100644
--- a/.gitignore
+++ b/.gitignore
@@ -248,4 +248,5 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/contrib/libgit-rs/target
 /contrib/libgit-rs/libgit-sys/target
diff --git a/Makefile b/Makefile
index 0090514e55..abeee01d9e 100644
--- a/Makefile
+++ b/Makefile
@@ -3723,7 +3723,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
-	$(RM) -r contrib/libgit-rs/libgit-sys/target
+	$(RM) -r contrib/libgit-rs/target contrib/libgit-rs/libgit-sys/target
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
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
index 0000000000..6b4387b9e7
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
+libgit-sys = { version = "0.1.0", path = "libgit-sys" }
+
+[build-dependencies]
+autocfg = "1.4.0"
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
diff --git a/contrib/libgit-rs/libgit-sys/src/lib.rs b/contrib/libgit-rs/libgit-sys/src/lib.rs
index dadb4e5f40..4bfc650450 100644
--- a/contrib/libgit-rs/libgit-sys/src/lib.rs
+++ b/contrib/libgit-rs/libgit-sys/src/lib.rs
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
 
diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
new file mode 100644
index 0000000000..d228091f3d
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
+    pub fn get_int(&mut self, key: &str) -> Option<c_int> {
+        let key = CString::new(key).expect("Couldn't convert to CString");
+        let mut val: c_int = 0;
+        unsafe {
+            if libgit_configset_get_int(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
+                return None;
+            }
+        }
+
+        Some(val)
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
-- 
2.47.0.rc0.187.ge670bccf7e-goog

