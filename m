Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E613F426
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054909; cv=none; b=YO0xNfiVe6aU4GgkSAoNj4AKrcX+jN+PF/KEiuEJ67HyJ0oA3/LKJ4FJxVg1kDOQJ4f3t5rO5i55b0lhyCqVF/GbxrH4ANAIzVrr9jWKpb4kJWAm5eMLQP6n9swosZBn+PxUGI9OT7Jzu4VG44vHG68nxRlU73jTXsb5ffuDlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054909; c=relaxed/simple;
	bh=oSxAUUkXMkYhSI+noWqO7LdnyP7CFWgPfuCPKOF2ZEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHLsjpCvIUfFlAS1dJBfURJ/WUcSZM7vbw18yRY76Zq7kIWy1550BU/ctNxgP4rHGv2Gpy+VVtl2lML6AFqUX90MgeX/WFdFBUu6VysyIZXCSeY2mCHGHJ82Rvy0CO50LsoHiIjunAlGsO/zokOPipeA6FIWnJGRUsL6XVCVSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDUFyxKY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDUFyxKY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690d5456d8aso2936577b3.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723054906; x=1723659706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4NJbGmeNmuO3sNGFjFwxaYltFnOYBNux8hbi98MDCY=;
        b=ZDUFyxKYNupGhPHV7s1NwL53AsquoRU5Vt53zuPU8z1KBvsZKdzuHPBS8ev3IgWabE
         /k0JHTq8TWwGWDKZiaU3wmGpvHCGUX4hSuAMqfpGzCf5XMjahpXG/KwzyO9x4MEpaiL0
         /woqhAUJZxR4eNeQRMrcM0E1todB35S2fgXNp9P1iMhx4n1gLkHU+2r36X6dAojNTTDc
         YwmhzfbEjQRRObOIkGlwF/IZ1VIFIUpLq1S4zScQcIrc6qU1WB6wiOIoRlcJ27GRaXRB
         y/+2IiAnsANAHU4hd/AUobfTHzwuKe/BW9DzWL+7i22XMJRj4r8k/rPxe/uAfGEDmi3X
         F3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054906; x=1723659706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4NJbGmeNmuO3sNGFjFwxaYltFnOYBNux8hbi98MDCY=;
        b=dq7F2510CYNYoxCQ0no0ybbJJz39srmd0u2MlAeyBFNfOAT7iySK1IoOXALnatsFvo
         cB/OJWvwXrlTAEeU/i4YB0ZsQUQat33FuSOcXEzz8HJqbAijxXoux97OfC1FPDswI164
         q18OatomYDY+JWhvAVkU5HonMyPNQKx4FHd/tEY2iniwGvy/YmdRROE1FkXygKscRil7
         5ecIjFXZfjenJ280Y5YLbMINX0nLa1OBZfN/TB5Mdg4ws8OXOSkVpZK5AVufYpRwrfoe
         HsI7I2t2dBw0oUwA+p9+rwV2MzVckFVeWhmB9/ziwaD0hBSrmjJqj6S1hen0zvI3Y4bU
         DUzg==
X-Gm-Message-State: AOJu0YwqfOJ/Qh4BVKYnBKpiAT/b6fz57b23TTPlK9/5MmMjeTa7tBqF
	DJRtFc1HDenfae0Qw/46znGKX0Ckp5lYmod4HU/668Ocw9jFi+pBKNT+M+f1AC7yMB09r1QaCrd
	o0+oEVIj79Y+2vyPd16q9LlE7HUG7nV4f05QV6WWUQlgEuRR/fuVk9wnzW59hdXKWcDuvSd0GFd
	KZlPhh3PlfnblSW2BfiVjB08R9FuCkaHhYdSeGex8=
X-Google-Smtp-Source: AGHT+IGAdopuhY9EEtsbCBp407T1amYiVUCYs+EOx7nzVPKITdwmaiObnKTbj/q8NzBUyA4zPyJgPiWKfWsFVA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
 (user=steadmon job=sendgmr) by 2002:a05:6902:2b84:b0:e0b:bafe:a7ff with SMTP
 id 3f1490d57ef6-e0bde264493mr37549276.6.1723054906236; Wed, 07 Aug 2024
 11:21:46 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:21:31 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <1e981a68802ac5aa7538381eb9469e524265ee40.1723054623.git.steadmon@google.com>
Subject: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset wrappers
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 contrib/cgit-rs/Cargo.lock             | 83 ++++++++++++++++++++++++++
 contrib/cgit-rs/Cargo.toml             |  1 +
 contrib/cgit-rs/public_symbol_export.c | 25 ++++++++
 contrib/cgit-rs/public_symbol_export.h | 10 ++++
 contrib/cgit-rs/src/lib.rs             | 65 +++++++++++++++++++-
 contrib/cgit-rs/src/main.rs            | 13 ++++
 6 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/contrib/cgit-rs/Cargo.lock b/contrib/cgit-rs/Cargo.lock
index f50c593995..1d40ac5faa 100644
--- a/contrib/cgit-rs/Cargo.lock
+++ b/contrib/cgit-rs/Cargo.lock
@@ -6,11 +6,94 @@ version = 3
 name = "cgit"
 version = "0.1.0"
 dependencies = [
+ "home",
  "libc",
 ]
 
+[[package]]
+name = "home"
+version = "0.5.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e3d1354bf6b7235cb4a0576c2619fd4ed18183f689b12b006a0ee7329eeff9a5"
+dependencies = [
+ "windows-sys",
+]
+
 [[package]]
 name = "libc"
 version = "0.2.155"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
+
+[[package]]
+name = "windows-sys"
+version = "0.52.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+dependencies = [
+ "windows-targets",
+]
+
+[[package]]
+name = "windows-targets"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+dependencies = [
+ "windows_aarch64_gnullvm",
+ "windows_aarch64_msvc",
+ "windows_i686_gnu",
+ "windows_i686_gnullvm",
+ "windows_i686_msvc",
+ "windows_x86_64_gnu",
+ "windows_x86_64_gnullvm",
+ "windows_x86_64_msvc",
+]
+
+[[package]]
+name = "windows_aarch64_gnullvm"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+
+[[package]]
+name = "windows_aarch64_msvc"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+
+[[package]]
+name = "windows_i686_gnu"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+
+[[package]]
+name = "windows_i686_gnullvm"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+
+[[package]]
+name = "windows_i686_msvc"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+
+[[package]]
+name = "windows_x86_64_gnu"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+
+[[package]]
+name = "windows_x86_64_gnullvm"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+
+[[package]]
+name = "windows_x86_64_msvc"
+version = "0.52.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
diff --git a/contrib/cgit-rs/Cargo.toml b/contrib/cgit-rs/Cargo.toml
index 7b55e6f3e1..5768fce9e5 100644
--- a/contrib/cgit-rs/Cargo.toml
+++ b/contrib/cgit-rs/Cargo.toml
@@ -14,3 +14,4 @@ path = "src/lib.rs"
 
 [dependencies]
 libc = "0.2.155"
+home = "0.5.9"
diff --git a/contrib/cgit-rs/public_symbol_export.c b/contrib/cgit-rs/public_symbol_export.c
index ab3401ac40..9641afca89 100644
--- a/contrib/cgit-rs/public_symbol_export.c
+++ b/contrib/cgit-rs/public_symbol_export.c
@@ -31,6 +31,31 @@ int libgit_parse_maybe_bool(const char *val)
 	return git_parse_maybe_bool(val);
 }
 
+struct config_set *libgit_configset_alloc(void)
+{
+	return git_configset_alloc();
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
diff --git a/contrib/cgit-rs/public_symbol_export.h b/contrib/cgit-rs/public_symbol_export.h
index 97e8e871ba..f22937202a 100644
--- a/contrib/cgit-rs/public_symbol_export.h
+++ b/contrib/cgit-rs/public_symbol_export.h
@@ -9,6 +9,16 @@ void libgit_initialize_the_repository(void);
 
 int libgit_parse_maybe_bool(const char *val);
 
+struct config_set *libgit_configset_alloc(void);
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
diff --git a/contrib/cgit-rs/src/lib.rs b/contrib/cgit-rs/src/lib.rs
index df350e758f..acfd3659e8 100644
--- a/contrib/cgit-rs/src/lib.rs
+++ b/contrib/cgit-rs/src/lib.rs
@@ -1,4 +1,57 @@
-use libc::{c_char, c_int};
+use std::ffi::{CStr, CString};
+
+use libc::{c_char, c_int, c_void};
+
+pub enum GitConfigSet {}
+
+pub struct ConfigSet(*mut GitConfigSet);
+impl ConfigSet {
+
+    pub fn new() -> Self {
+        unsafe {
+            // TODO: we need to handle freeing this when the ConfigSet is dropped
+            // git_configset_clear(ptr) and then libc::free(ptr)
+            let ptr = libgit_configset_alloc();
+            libgit_configset_init(ptr);
+            ConfigSet(ptr)
+        }
+    }
+
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
+            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0 {
+                return None;
+            }
+            let borrowed_str = CStr::from_ptr(val);
+            let owned_str = CString::from_vec_with_nul(borrowed_str.to_bytes_with_nul().to_vec());
+            libc::free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
+            Some(owned_str.unwrap())
+        }
+    }
+}
 
 extern "C" {
     pub fn libgit_setup_git_directory() -> *const c_char;
@@ -15,4 +68,14 @@ extern "C" {
     // From version.c
     pub fn libgit_user_agent() -> *const c_char;
     pub fn libgit_user_agent_sanitized() -> *const c_char;
+
+    fn libgit_configset_alloc() -> *mut GitConfigSet;
+
+    fn libgit_configset_init(cs: *mut GitConfigSet);
+
+    fn libgit_configset_add_file(cs: *mut GitConfigSet, filename: *const c_char) -> c_int;
+
+    pub fn libgit_configset_get_int(cs: *mut GitConfigSet, key: *const c_char, int: *mut c_int) -> c_int;
+    pub fn libgit_configset_get_string(cs: *mut GitConfigSet, key: *const c_char, dest: *mut *mut c_char) -> c_int;
+
 }
diff --git a/contrib/cgit-rs/src/main.rs b/contrib/cgit-rs/src/main.rs
index c5f8644fca..07c8a71a13 100644
--- a/contrib/cgit-rs/src/main.rs
+++ b/contrib/cgit-rs/src/main.rs
@@ -1,4 +1,5 @@
 use std::ffi::{CStr, CString};
+use home::home_dir;
 
 fn main() {
     println!("Let's print some strings provided by Git");
@@ -28,4 +29,16 @@ fn main() {
             val
         );
     };
+
+    println!("\nTry out our configset wrappers");
+    let mut cs = cgit::ConfigSet::new();
+    let mut path = home_dir().expect("cannot get home directory path");
+    path.push(".gitconfig");
+    let path:String = path.into_os_string().into_string().unwrap();
+    cs.add_files(&["/etc/gitconfig", ".gitconfig", &path]);
+    /*
+     * Returns Some(x) if defined in local config, otherwise None
+     */
+    println!("get_configset_get_int = {:?}", cs.get_int("trace2.eventNesting"));
+    println!("cs.get_str(\"garbage\") = {:?}", cs.get_str("this_string_does_not_exist"));
 }
-- 
2.46.0.rc2.264.g509ed76dc8-goog

