Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9016CD06
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243291; cv=none; b=Fd7dKXuCNxQYMbohn6cjfclomlEabFpywEMIyemZ2NiPp4097WOTEkgNrE6luTdCjKTYWXjViFPpjT2zjhFkfizsPr3tNeIn1J4wDo+jY978JypJoXUb/c1JXk/TXmG37HkEEZ4o9KVSXKkYBRS21ujI6aW34VaKamUKgvatDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243291; c=relaxed/simple;
	bh=3Aq3yBvTj/xxtcZcNNZoTbAHdQxIvUpuRe2xhTaBf3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IE4mpX0PiqpBkxU0EhPxkEXF6g/sXRAZZ0EB1L7EyW6zMy5lv92GvQTVOybnJCfIVUgEuWY9U/REdxRfL/otkkoVYZRQChsVakuMnIhcOVO6MKjEzXLGVpv1BPCBhYLo3GzoQ9F1bicocnDa2pydfQaZt/AabQTqjlyvquNrIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XV+6Vobh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XV+6Vobh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-666010fb35cso40563837b3.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723243288; x=1723848088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzuW0RVZGRG+NSz4paECFTkCfuzaDnsPB3YTEfvFEro=;
        b=XV+6VobhGmfildMXS2iocQKqosQu0MEyty29QFaBxjCEtyFCiCY7v175Gumx9VpEUY
         KmRSDl5yZioGpE6NMPpUNARtuX2PD73BjVBP35Xk4wxPaFbNDfPtno6thCnHY0vZVE3V
         l47sQp0fWj4RQDKPZ4OGP1FcCuaPR/M+vMNPZ6a0BTPxf8jA+4SeTIs/5fmsE6umt4G6
         ajSkZHoZc4GhQmoIAnbL6nTpcRLVZAFaORb8JERJo/hENRr0aMGLMb2weUVeyjJWsDSJ
         4EytZ6C+rYStTKToNSc/BMUOfeA3xo1W9lIds1e/GK1h/8q+vxkpC1y48uH3O6iFn7xO
         xbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243288; x=1723848088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzuW0RVZGRG+NSz4paECFTkCfuzaDnsPB3YTEfvFEro=;
        b=OxP0zOgHyILXdiwhddmtjJYEBhnzvzhCXhoIJ44oQ+GPV4PoxCtjVkgWY9/755tvja
         jLmbabj0k+aEi9SEsBO2ZxzqtNUdtASt06S+SUX8c8viHMIrRbyV6WnIMopN4Vvi7Jm5
         TX99+IKSZ2Fl6RzZtUpjFzw7lnlGTumOYfRQavsdRIOZeBe+l1CgpKd8IW4f+2OGYENC
         8iUaYroG8+pby7nP3Ru7wZyitx73MtHp3n5Q923Xzwc2PxjJ4KgcWTt5DbHg/l0yY9dd
         2SPzS20ZOPtdlY7wUSsVtqYP0ETZRIgy8D88vlRKvJ/sp5OMEhp9nNE7AjKuRsj1Joa1
         HtMg==
X-Gm-Message-State: AOJu0YxMY7zVJmR2oDiSIQawaDUCOZ0QzmiJwptk8xbgjdItwBTdpJOa
	bw2qEMcxbh119okHUdVG4h4f/w4XppOPsmidW0LdSwePMSnWg4dlqHHxqhNqE+jhy8hkx1VsV0r
	yfDUN5DuvBneGhiA+tBNMSNM0QqUFAS4gZvaT6QpyT3IUDQQ3/Em4o39kaVgs/SJMBkua0pCGGP
	dAG45MmvQu8bbUaelg9adKJsrx2vMNLVAbnwZz4bM=
X-Google-Smtp-Source: AGHT+IHj5W0PXbkWYOxhNGw5sSq0ab7r4UQZPfUKitHzXzvlK0ORXi0cItBhIcxPPKrihqVgnQzY1Q4DqgkLzA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
 (user=steadmon job=sendgmr) by 2002:a05:690c:4810:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-69ed67fabb5mr508587b3.0.1723243287903; Fri, 09 Aug 2024
 15:41:27 -0700 (PDT)
Date: Fri,  9 Aug 2024 15:41:17 -0700
In-Reply-To: <cover.1723242556.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <514c744ba41cf48c4ffd85640b7ef0c5783cc77d.1723242556.git.steadmon@google.com>
Subject: [PATCH v2 5/5] cgit: add higher-level cgit crate
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Wrap `struct config_set` and a few of its associated functions in
cgit-sys. Also introduce a higher-level "cgit" crate which provides a
more Rust-friendly interface to config_set structs.

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore                                    |  1 +
 Makefile                                      |  2 +-
 contrib/cgit-rs/Cargo.lock                    | 14 ++++
 contrib/cgit-rs/Cargo.toml                    | 10 +++
 .../cgit-rs/cgit-sys/public_symbol_export.c   | 30 +++++++
 .../cgit-rs/cgit-sys/public_symbol_export.h   | 12 +++
 contrib/cgit-rs/cgit-sys/src/lib.rs           | 31 ++++++-
 contrib/cgit-rs/src/lib.rs                    | 82 +++++++++++++++++++
 8 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 contrib/cgit-rs/Cargo.lock
 create mode 100644 contrib/cgit-rs/Cargo.toml
 create mode 100644 contrib/cgit-rs/src/lib.rs

diff --git a/.gitignore b/.gitignore
index 567cc9888f..7f2ee89b8a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -248,4 +248,5 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/contrib/cgit-rs/target
 /contrib/cgit-rs/cgit-sys/target
diff --git a/Makefile b/Makefile
index db8af99f20..3a71d10fbe 100644
--- a/Makefile
+++ b/Makefile
@@ -3723,7 +3723,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
-	$(RM) -r contrib/cgit-rs/cgit-sys/target
+	$(RM) -r contrib/cgit-rs/target contrib/cgit-rs/cgit-sys/target
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
diff --git a/contrib/cgit-rs/Cargo.lock b/contrib/cgit-rs/Cargo.lock
new file mode 100644
index 0000000000..991e775c34
--- /dev/null
+++ b/contrib/cgit-rs/Cargo.lock
@@ -0,0 +1,14 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "cgit"
+version = "0.1.0"
+dependencies = [
+ "cgit-sys",
+]
+
+[[package]]
+name = "cgit-sys"
+version = "0.1.0"
diff --git a/contrib/cgit-rs/Cargo.toml b/contrib/cgit-rs/Cargo.toml
new file mode 100644
index 0000000000..31f4d84522
--- /dev/null
+++ b/contrib/cgit-rs/Cargo.toml
@@ -0,0 +1,10 @@
+[package]
+name = "cgit"
+version = "0.1.0"
+edition = "2021"
+
+[lib]
+path = "src/lib.rs"
+
+[dependencies]
+cgit-sys = { version = "0.1.0", path = "cgit-sys" }
diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.c b/contrib/cgit-rs/cgit-sys/public_symbol_export.c
index 62a91f76d0..adf8b21f11 100644
--- a/contrib/cgit-rs/cgit-sys/public_symbol_export.c
+++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.c
@@ -33,6 +33,36 @@ int libgit_parse_maybe_bool(const char *val)
 	return git_parse_maybe_bool(val);
 }
 
+struct config_set *libgit_configset_alloc(void)
+{
+	return git_configset_alloc();
+}
+
+void libgit_configset_clear_and_free(struct config_set *cs)
+{
+	git_configset_clear_and_free(cs);
+}
+
+void libgit_configset_init(struct config_set *cs)
+{
+	git_configset_init(cs);
+}
+
+int libgit_configset_add_file(struct config_set *cs, const char *filename)
+{
+	return git_configset_add_file(cs, filename);
+}
+
+int libgit_configset_get_int(struct config_set *cs, const char *key, int *dest)
+{
+	return git_configset_get_int(cs, key, dest);
+}
+
+int libgit_configset_get_string(struct config_set *cs, const char *key, char **dest)
+{
+	return git_configset_get_string(cs, key, dest);
+}
+
 const char *libgit_user_agent(void)
 {
 	return git_user_agent();
diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.h b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
index 64332f30de..882c7932e8 100644
--- a/contrib/cgit-rs/cgit-sys/public_symbol_export.h
+++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
@@ -9,6 +9,18 @@ void libgit_init_git(const char **argv);
 
 int libgit_parse_maybe_bool(const char *val);
 
+struct config_set *libgit_configset_alloc(void);
+
+void libgit_configset_clear_and_free(struct config_set *cs);
+
+void libgit_configset_init(struct config_set *cs);
+
+int libgit_configset_add_file(struct config_set *cs, const char *filename);
+
+int libgit_configset_get_int(struct config_set *cs, const char *key, int *dest);
+
+int libgit_configset_get_string(struct config_set *cs, const char *key, char **dest);
+
 const char *libgit_user_agent(void);
 
 const char *libgit_user_agent_sanitized(void);
diff --git a/contrib/cgit-rs/cgit-sys/src/lib.rs b/contrib/cgit-rs/cgit-sys/src/lib.rs
index 8c3ccc2859..d5072ea587 100644
--- a/contrib/cgit-rs/cgit-sys/src/lib.rs
+++ b/contrib/cgit-rs/cgit-sys/src/lib.rs
@@ -1,6 +1,15 @@
-use std::ffi::{c_char, c_int};
+use std::ffi::{c_char, c_int, c_void};
+
+#[allow(non_camel_case_types)]
+#[repr(C)]
+pub struct config_set {
+    _data: [u8; 0],
+    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
+}
 
 extern "C" {
+    pub fn free(ptr: *mut c_void);
+
     pub fn libgit_setup_git_directory() -> *const c_char;
 
     // From config.c
@@ -15,6 +24,26 @@ extern "C" {
     // From version.c
     pub fn libgit_user_agent() -> *const c_char;
     pub fn libgit_user_agent_sanitized() -> *const c_char;
+
+    pub fn libgit_configset_alloc() -> *mut config_set;
+    pub fn libgit_configset_clear_and_free(cs: *mut config_set);
+
+    pub fn libgit_configset_init(cs: *mut config_set);
+
+    pub fn libgit_configset_add_file(cs: *mut config_set, filename: *const c_char) -> c_int;
+
+    pub fn libgit_configset_get_int(
+        cs: *mut config_set,
+        key: *const c_char,
+        int: *mut c_int,
+    ) -> c_int;
+
+    pub fn libgit_configset_get_string(
+        cs: *mut config_set,
+        key: *const c_char,
+        dest: *mut *mut c_char,
+    ) -> c_int;
+
 }
 
 #[cfg(test)]
diff --git a/contrib/cgit-rs/src/lib.rs b/contrib/cgit-rs/src/lib.rs
new file mode 100644
index 0000000000..74c83d161a
--- /dev/null
+++ b/contrib/cgit-rs/src/lib.rs
@@ -0,0 +1,82 @@
+use std::ffi::{c_char, c_int, c_void, CStr, CString};
+
+use cgit_sys::*;
+
+pub struct ConfigSet(*mut config_set);
+impl ConfigSet {
+    pub fn new() -> Self {
+        unsafe {
+            let ptr = libgit_configset_alloc();
+            libgit_configset_init(ptr);
+            ConfigSet(ptr)
+        }
+    }
+
+    // NEEDSWORK: maybe replace &str with &Path
+    pub fn add_files(&mut self, files: &[&str]) {
+        for file in files {
+            let rs = CString::new(*file).expect("Couldn't convert to CString");
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
+        // NEEDSWORK: we need to supply a testdata config
+        let mut cs = ConfigSet::new();
+        let mut path = std::env::home_dir().expect("cannot get home directory path");
+        path.push(".gitconfig");
+        let path: String = path.into_os_string().into_string().unwrap();
+        cs.add_files(&["/etc/gitconfig", ".gitconfig", &path]);
+        assert_eq!(cs.get_int("trace2.eventNesting"), Some(5));
+        assert_eq!(cs.get_str("no_such_config_item"), None);
+    }
+}
-- 
2.46.0.76.ge559c4bf1a-goog

