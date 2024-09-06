Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1C1B85D9
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661292; cv=none; b=oXMBC0dTRojJsrWcA0bkD4peqmyQLnGYOhqJthqWvH77WvhzTMQSeAk2oM2GIvOB+//vA5hJ4r662XmmDA8Zjwu4t1ZxCO2ezeTsqZmsfQHIPx0wMnqWTL2sFN/SzDq0rhx+afosJYf50eyLOmVqoTu4eVdpQhY+9DmldT0PeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661292; c=relaxed/simple;
	bh=cU8JeOlugnySnSvOa20nP1BVDRB1P/P7GHTttxVpW1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+ifJQDTMUX1UoAayptjNupbBv8TzbeuMozdFkfx21FlxKdDOijVquvSdPBXCExio5zDxA/H8U/uPJ5IGnQ3xAPU2MAtL73hVqDs+YPOpGxfAq9RMVryXT5j3GKQvfRQ3bJ7q30o3X3djX6IQ07Esi66pJPt0nZyGlqrYQchCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7GSwO7n; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7GSwO7n"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4daca4a4bso79538307b3.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725661290; x=1726266090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=236+OPE9lZBsJ7XrTRhPbpOQ8RkJHgGiaDPgxyOr83M=;
        b=Q7GSwO7nLawfiGl7CxKL3eNIhlicxw2fQF0FiLD+4OqhUkVMFOx+BkbLskEJGZP3gH
         K98BPvoULH20s4a+P1vy8kqJHpfMn1T0hwZRATvMURjeahCx+jy3UCfLSU2gsykd4nS6
         3l8kK1tCf4YEJQ+gsYkA3Iz05OwM2yYQhm8df0aIoSukWPdOVHV1Wq8fb/eOJOLnyY26
         YMU09DsByPh99yYSv7RweMa/7NQr1XXFCBjVzkQacuUutyno6tawBFFqXGbb6feAytaM
         ZxWDw/0QqT9IOVblgNkoqYxDiFHC53F3EdNk85nJeupS4wDzUewx4Tw/Kbp7bzOcHFxN
         5zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661290; x=1726266090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=236+OPE9lZBsJ7XrTRhPbpOQ8RkJHgGiaDPgxyOr83M=;
        b=nlp3Dnl1HZ8cB9WdzKCm+w8gZH9vYYz76cIRfF+AvgydxITm3BnnZys3N3JX+3KSmE
         bcNwQP7Im7qRmhOSd3AGON4QwnFXQUBHk8PBczfM6Fs8aJfHRkRRQbieEF9/YGhRzh8f
         AK0dq8tRBHBH3NB9Oc5heKbASLTITQvsHzCR83ucIMAoE1Yxv1p4h4mG5e3nMS1YyL0c
         oSiQQh5BEBPOCm1NstUWH0o0S3mfCAyM1xZoKcmfTF1anYXEeCdALR3ku5G0Nf9Gdlwz
         fiz/LJR2097E2gUEIsPJvualS5LXetKTvWA8m8fyT3EqZD5abgbt8omzuazHwEY1NXRY
         m3tw==
X-Gm-Message-State: AOJu0Yw5qNRalsf/pGlCLkHaMvHjqoOgNBahq/X4oGuoDCInQ48+hNn9
	poycjWlyE3MpqbxcRW4XNZxRE0KRBCD0ixF4xZq+vzkcCHNqABBNHd8RfVk7TPkgvskPH8dxENB
	SU4BvOU0U02OzHnD1DHQtTP3cKOJha7TZ4IAB3zp3kedcWyuxvob5sNtm692O17o4vSK9JcuU6H
	Avqy3FD0kUWOzdQNzzzCI1bxbMZW8tVuYmdo4fOoOqr1f+
X-Google-Smtp-Source: AGHT+IHFz9cB+etVcaChRJXDzzuXpc8JktBbbZbFL9u6656ZiW/iGBJvIz4qh3Ic1Qc57GCpSvzrt5KB/HYfV3c=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:aa88:0:b0:e1a:a114:d35 with SMTP id
 3f1490d57ef6-e1d10aa8eafmr81460276.5.1725661289335; Fri, 06 Sep 2024 15:21:29
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:21:15 +0000
In-Reply-To: <20240906221853.257984-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906222116.270196-5-calvinwan@google.com>
Subject: [PATCH v3 5/6] libgit: add higher-level libgit crate
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, steadmon@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

Wrap `struct config_set` and a few of its associated functions in
libgit-sys. Also introduce a higher-level "libgit" crate which provides
a more Rust-friendly interface to config_set structs.

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Change-Id: If85e77809434f0ef05e2db35132ecf84621e10ef
---
 .gitignore                                    |  1 +
 Makefile                                      |  2 +-
 contrib/libgit-rs/Cargo.lock                  | 62 ++++++++++++++
 contrib/libgit-rs/Cargo.toml                  | 10 +++
 .../libgit-sys/public_symbol_export.c         | 30 +++++++
 .../libgit-sys/public_symbol_export.h         | 12 +++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 31 ++++++-
 contrib/libgit-rs/src/lib.rs                  | 85 +++++++++++++++++++
 contrib/libgit-rs/testdata/config1            |  2 +
 contrib/libgit-rs/testdata/config2            |  2 +
 contrib/libgit-rs/testdata/config3            |  2 +
 11 files changed, 237 insertions(+), 2 deletions(-)
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
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
index 0000000000..187176f5df
--- /dev/null
+++ b/contrib/libgit-rs/Cargo.lock
@@ -0,0 +1,62 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
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
+ "libgit-sys",
+]
+
+[[package]]
+name = "libgit-sys"
+version = "0.1.0"
+dependencies = [
+ "libz-sys",
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
index 0000000000..b8914517e0
--- /dev/null
+++ b/contrib/libgit-rs/Cargo.toml
@@ -0,0 +1,10 @@
+[package]
+name = "libgit"
+version = "0.1.0"
+edition = "2021"
+
+[lib]
+path = "src/lib.rs"
+
+[dependencies]
+libgit-sys = { version = "0.1.0", path = "libgit-sys" }
diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
index 65d1620d28..07d6bfdd84 100644
--- a/contrib/libgit-rs/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
@@ -33,6 +33,36 @@ int libgit_parse_maybe_bool(const char *val)
 	return git_parse_maybe_bool(val);
 }
 
+struct libgit_config_set *libgit_configset_alloc(void)
+{
+	return git_configset_alloc();
+}
+
+void libgit_configset_clear_and_free(struct libgit_config_set *cs)
+{
+	git_configset_clear_and_free(cs);
+}
+
+void libgit_configset_init(struct libgit_config_set *cs)
+{
+	git_configset_init(cs);
+}
+
+int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
+{
+	return git_configset_add_file(cs, filename);
+}
+
+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
+{
+	return git_configset_get_int(cs, key, dest);
+}
+
+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
+{
+	return git_configset_get_string(cs, key, dest);
+}
+
 const char *libgit_user_agent(void)
 {
 	return git_user_agent();
diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.h b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
index 64332f30de..3933698976 100644
--- a/contrib/libgit-rs/libgit-sys/public_symbol_export.h
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
@@ -9,6 +9,18 @@ void libgit_init_git(const char **argv);
 
 int libgit_parse_maybe_bool(const char *val);
 
+struct libgit_config_set *libgit_configset_alloc(void);
+
+void libgit_configset_clear_and_free(struct libgit_config_set *cs);
+
+void libgit_configset_init(struct libgit_config_set *cs);
+
+int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename);
+
+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest);
+
+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
+
 const char *libgit_user_agent(void);
 
 const char *libgit_user_agent_sanitized(void);
diff --git a/contrib/libgit-rs/libgit-sys/src/lib.rs b/contrib/libgit-rs/libgit-sys/src/lib.rs
index 9b2e85dff8..f3eb44a238 100644
--- a/contrib/libgit-rs/libgit-sys/src/lib.rs
+++ b/contrib/libgit-rs/libgit-sys/src/lib.rs
@@ -1,8 +1,17 @@
-use std::ffi::{c_char, c_int};
+use std::ffi::{c_char, c_int, c_void};
+
+#[allow(non_camel_case_types)]
+#[repr(C)]
+pub struct libgit_config_set {
+    _data: [u8; 0],
+    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
+}
 
 extern crate libz_sys;
 
 extern "C" {
+    pub fn free(ptr: *mut c_void);
+
     pub fn libgit_setup_git_directory() -> *const c_char;
 
     // From config.c
@@ -17,6 +26,26 @@ extern "C" {
     // From version.c
     pub fn libgit_user_agent() -> *const c_char;
     pub fn libgit_user_agent_sanitized() -> *const c_char;
+
+    pub fn libgit_configset_alloc() -> *mut libgit_config_set;
+    pub fn libgit_configset_clear_and_free(cs: *mut libgit_config_set);
+
+    pub fn libgit_configset_init(cs: *mut libgit_config_set);
+
+    pub fn libgit_configset_add_file(cs: *mut libgit_config_set, filename: *const c_char) -> c_int;
+
+    pub fn libgit_configset_get_int(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        int: *mut c_int,
+    ) -> c_int;
+
+    pub fn libgit_configset_get_string(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut *mut c_char,
+    ) -> c_int;
+
 }
 
 #[cfg(test)]
diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
new file mode 100644
index 0000000000..43aae09656
--- /dev/null
+++ b/contrib/libgit-rs/src/lib.rs
@@ -0,0 +1,85 @@
+use std::ffi::{c_char, c_int, c_void, CStr, CString};
+use std::path::Path;
+
+use libgit_sys::*;
+
+pub struct ConfigSet(*mut libgit_config_set);
+impl ConfigSet {
+    pub fn new() -> Self {
+        unsafe {
+            let ptr = libgit_configset_alloc();
+            libgit_configset_init(ptr);
+            ConfigSet(ptr)
+        }
+    }
+
+    pub fn add_files(&mut self, files: &[&Path]) {
+        for file in files {
+            let pstr: &str = file.to_str().expect("Invalid UTF-8");
+            let rs = CString::new(&*pstr).expect("Couldn't convert to CString");
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
+    pub fn get_str(&mut self, key: &str) -> Option<CString> {
+        let key = CString::new(key).expect("Couldn't convert to CString");
+        let mut val: *mut c_char = std::ptr::null_mut();
+        unsafe {
+            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
+            {
+                return None;
+            }
+            let borrowed_str = CStr::from_ptr(val);
+            let owned_str = CString::from_vec_with_nul(borrowed_str.to_bytes_with_nul().to_vec());
+            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
+            Some(owned_str.unwrap())
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
+            libgit_configset_clear_and_free(self.0);
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
+        cs.add_files(&[Path::new("testdata/config1"),
+                       Path::new("testdata/config2"),
+                       Path::new("testdata/config3")]);
+        // ConfigSet retrieves correct value 
+        assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
+        // ConfigSet respects last config value set
+        assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
+        // ConfigSet returns None for missing key
+        assert_eq!(cs.get_str("foo.bar"), None);
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
2.46.0.469.g59c65b2a67-goog

