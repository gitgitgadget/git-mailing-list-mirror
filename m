Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E472147E6
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221974; cv=none; b=pP8nmgTD7ZM+HHeZRaltcr+AjCoZiKS2rzSccCHMnAy3asqzMJ9WwEECq6My4MXoD40gY+wlz1Ib69JWpiCs+eLpUXAQibK/8cGRn57xnQNQTbV66NaqsS4IVhOm0H85xOv+SLdaSpRpCAyONcX8yjxN3EhJWqY9X3kpJ2TAfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221974; c=relaxed/simple;
	bh=Y67eBuN/m1Z7/jz4tDtvHE5XKRIOapdI3lgGHQcL4QY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D4TMwWpOz/hOkCN5NUEr1ayc6I3psSJQ4bvpeouyMz6E99fTMQrqq69mm1WXm7k+hvtHMAPnHi6bsnn5MXgCYOtvUA/onQ3jt0nsm/vUCW43dnnlKzRhfLRbKYGoNyn8HYssA311iVnoca9ZEF7AZF5sGDYvWqkV87FvyR3x5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI+kU1Ee; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI+kU1Ee"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85e76e886a0so411127085a.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 01:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759221970; x=1759826770; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxLZSRQqYh8M4V0XN3congNyHahqxiai2SMfL+wC1Z8=;
        b=jI+kU1EeBA78b2yykOGCMXsKQKpDlmgqX+toF/6rLN3fWBapEWueV9R0qvIqs9bFw9
         fEXZ7XE9GczkpKLKubZZ/6PwD037xue2hSjXs0X03x4+uouci6sjUe6z2PofcHqkWNQg
         oUQyjeep92CN5Z5szI7hEBS3HdC0APktExn7HIfKdViGkqghdBpOJA9J3XwhPDdCRa0t
         1vygLAk348vx5gS5OJiGfNuQV91K6C+ddxblx2wteUnt20oSX2JKUyNUFhfLplXkJg3+
         ur61JzrGiWfJrwsSzkr9rGBYkKkKxgYc3Ln0sEP20N8sYZKvrABlyGZwMcUQK1g6U0CY
         fxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221970; x=1759826770;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxLZSRQqYh8M4V0XN3congNyHahqxiai2SMfL+wC1Z8=;
        b=jFHhU6CtKx14ZF6pJxgcg/mdCSbJESUwZ/tc2gj3LN60l2eRXGgi3PLCIUP23c097g
         RNQRqlk6uMu18sOincnbD0HppNZReEpJzDIXfMrIYa75SceUxG0S/4Ygb1YYFs97gMR/
         oLR6ZyaafWZuVXMfSoSskJlsR4s3afp6eW7Nem3bj2Oazwbs4JxW3jpv2QRdmcSA2bxJ
         QLYYyHNLR5IFjSu9RT6bqO/0BeDCZfcb672hu/Y05DceL+nRsMAkKPanF1+VsdrdQn9x
         1hX2jkyCHBC+fUk0T3P/+KnZX5gXmn4gg0SyCd7ECp2/NKqQP/eeDRmZNr1/YVhrzSLr
         Aduw==
X-Gm-Message-State: AOJu0YyOm6VPOcuUelXAnZ8LuXLda5wD/ecEN4tzWWMNZ+s8TlYeq6EA
	eaql1jQpNEDvYqYRwqA2g9pzYp2NiFoiaARb/B0eAjr19wNybvbplBPBX7Up6g==
X-Gm-Gg: ASbGnctKgCxvj3uahwlJbIY5GcVqP5uFPXji24TrjMje2rsrdYVJL9dl/jMUj3uieKo
	1ahSiI3a8F53B3RKVN+WbuctrCJci9VBCn4rQqKRP5K2ofjodxVNyIl4XkVxfOq0WL88kW6RH/f
	zNwZEm+rCDtNSM6h03sn7oX1beNhe5G0UbrmK0h2+ZLNdrf+9NGmL+Gl805Q0cqjK2r9AQX76yD
	H/tVGuKFWDgEU9H6Hpjx8O7rhwz/Lj2yB1xL7rj45a+YkGjsSd6BtxLJduGXYVc/rTjqJx6aUkP
	wVSDvlbJ3O8Pqq4SRxuAwFSvNBhMH3kX4j4D3e3pQCbvO02NsUf1EBdYlPhAdcMmwwLAdWe7fRs
	4IRRACO6ht3evcThj3V59REcwKqZ2WW7IleWSEMMizF9lr1mOQ/E=
X-Google-Smtp-Source: AGHT+IFM6kvqsWYr6h2F08jbSxn/B22EDX+1kAQsQ17QgvSkK2q/OVPhWL8uL36bE0uqWEn8ORpEgw==
X-Received: by 2002:a05:620a:4090:b0:864:c43:865d with SMTP id af79cd13be357-8640c4388e2mr1468752585a.54.1759221969500;
        Tue, 30 Sep 2025 01:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.165.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c288a0f7dsm994398385a.17.2025.09.30.01.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:08 -0700 (PDT)
Message-Id: <pull.1977.v4.git.1759221968318.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
References: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
From: "ions via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 08:46:08 +0000
Subject: [PATCH v4] libgit-rs: add get_bool(), get_ulong(), and get_pathname()
 methods
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Expand ConfigSet API with three new configuration value parsers:

- get_bool(): Parse boolean values using git_configset_get_bool()
- get_ulong(): Parse unsigned long values
- get_pathname(): Parse file paths, returning PathBuf

All methods use Git's C functions for consistent behavior and
include wrapper functions in public_symbol_export.[ch] for FFI.

Includes comprehensive tests for all new functionality.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
    libgit-rs: add get_bool(), get_ulong(), and get_pathname() methods to
    ConfigSet
    
    
    libgit-rs: Enhanced ConfigSet API
    =================================
    
    This series expands the ConfigSet API with support for additional
    configuration value types, following Git's established patterns by
    wrapping native C functions.
    
    
    Implementation
    ==============
    
    Adds three new ConfigSet methods:
    
     * get_bool(): Parse boolean values using git_configset_get_bool()
     * get_ulong(): Parse unsigned long integers using
       git_configset_get_ulong()
     * get_pathname(): Parse file paths using git_configset_get_pathname(),
       returning PathBuf
    
    All methods follow the existing pattern of get_int() and get_string(),
    ensuring consistent behavior with Git's native parsing logic.
    
    
    Changes in v4
    =============
    
     * Fixed missing wrapper functions in public_symbol_export.[ch]
       (Philip's feedback)
     * Rebased to correct base commit bb69721404 (Junio's feedback)
     * Squashed into single clean commit as requested
     * Removed unrelated README.md commit
     * Fixed commit message formatting per GitGitGadget requirements
    
    The ConfigSet API now supports 5 configuration value types: int, string,
    bool, ulong, and pathname.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1977%2Fionnss%2Fadd-rust-configset-get-bool-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1977/ionnss/add-rust-configset-get-bool-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1977

Range-diff vs v3:

 1:  d7810781fc < -:  ---------- po: fix escaped underscores in README.md
 2:  479c263bc1 < -:  ---------- libgit-rs: add get_bool() method to ConfigSet
 3:  1ac8d76819 ! 1:  618deca808 libgit-rs: add get_ulong() and get_pathname() methods
     @@ Metadata
      Author: ionnss <zara.leonardo@gmail.com>
      
       ## Commit message ##
     -    libgit-rs: add get_ulong() and get_pathname() methods
     +    libgit-rs: add get_bool(), get_ulong(), and get_pathname() methods
      
     -    Expand the ConfigSet API with additional configuration value types:
     +    Expand ConfigSet API with three new configuration value parsers:
      
     -    - get_ulong(): Parse unsigned long integers for large numeric values
     -    - get_pathname(): Parse file paths, returning PathBuf for type safety
     +    - get_bool(): Parse boolean values using git_configset_get_bool()
     +    - get_ulong(): Parse unsigned long values
     +    - get_pathname(): Parse file paths, returning PathBuf
      
     -    Both functions follow the same pattern as existing get_* methods,
     -    using Git's C functions for consistent parsing behavior.
     +    All methods use Git's C functions for consistent behavior and
     +    include wrapper functions in public_symbol_export.[ch] for FFI.
      
     -    Add comprehensive tests covering normal cases, edge cases, and
     -    error handling for all new functionality.
     +    Includes comprehensive tests for all new functionality.
      
          Signed-off-by: ionnss <zara.leonardo@gmail.com>
      
     @@ contrib/libgit-rs/src/config.rs: type c_char = i8;
       
       /// A ConfigSet is an in-memory cache for config-like files such as `.gitmodules` or `.gitconfig`.
      @@ contrib/libgit-rs/src/config.rs: impl ConfigSet {
     - 
     -         Some(val != 0)
     +             Some(owned_str)
     +         }
           }
      +
     ++    /// Load the value for the given key and attempt to parse it as a boolean. Dies with a fatal error
     ++    /// if the value cannot be parsed. Returns None if the key is not present.
     ++    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
     ++        let key = CString::new(key).expect("config key should be valid CString");
     ++        let mut val: c_int = 0;
     ++        unsafe {
     ++            if libgit_configset_get_bool(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
     ++                return None;
     ++            }
     ++        }
     ++
     ++        Some(val != 0)
     ++    }
     ++
      +    /// Load the value for the given key and attempt to parse it as an unsigned long. Dies with a fatal error
      +    /// if the value cannot be parsed. Returns None if the key is not present.
      +    pub fn get_ulong(&mut self, key: &str) -> Option<u64> {
     @@ contrib/libgit-rs/src/config.rs: impl ConfigSet {
       
       impl Default for ConfigSet {
      @@ contrib/libgit-rs/src/config.rs: mod tests {
     -         assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
     -         // Test missing boolean key
     -         assert_eq!(cs.get_bool("missing.boolean"), None);
     +             Path::new("testdata/config1"),
     +             Path::new("testdata/config2"),
     +             Path::new("testdata/config3"),
     ++            Path::new("testdata/config4"),
     +         ]);
     +         // ConfigSet retrieves correct value
     +         assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
     +@@ contrib/libgit-rs/src/config.rs: mod tests {
     +         assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
     +         // ConfigSet returns None for missing key
     +         assert_eq!(cs.get_string("foo.bar"), None);
     ++        // Test boolean parsing - comprehensive tests
     ++        assert_eq!(cs.get_bool("test.boolTrue"), Some(true));
     ++        assert_eq!(cs.get_bool("test.boolFalse"), Some(false));
     ++        assert_eq!(cs.get_bool("test.boolYes"), Some(true));
     ++        assert_eq!(cs.get_bool("test.boolNo"), Some(false));
     ++        assert_eq!(cs.get_bool("test.boolOne"), Some(true));
     ++        assert_eq!(cs.get_bool("test.boolZero"), Some(false));
     ++        assert_eq!(cs.get_bool("test.boolZeroZero"), Some(false)); // "00" → false
     ++        assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
     ++        // Test missing boolean key
     ++        assert_eq!(cs.get_bool("missing.boolean"), None);
      +        // Test ulong parsing
      +        assert_eq!(cs.get_ulong("test.ulongSmall"), Some(42));
      +        assert_eq!(cs.get_ulong("test.ulongBig"), Some(4294967296)); // > 32-bit int
     @@ contrib/libgit-rs/src/config.rs: mod tests {
           }
       }
      
     - ## contrib/libgit-rs/testdata/config4 ##
     + ## contrib/libgit-rs/testdata/config3 ##
      @@
     - 	boolZero = 0
     - 	boolZeroZero = 00
     - 	boolHundred = 100
     + [trace2]
     +-	eventNesting = 3
     ++	eventNesting = 3
     + \ No newline at end of file
     +
     + ## contrib/libgit-rs/testdata/config4 (new) ##
     +@@
     ++[test]
     ++	boolTrue = true
     ++	boolFalse = false
     ++	boolYes = yes
     ++	boolNo = no
     ++	boolOne = 1
     ++	boolZero = 0
     ++	boolZeroZero = 00
     ++	boolHundred = 100
      +	ulongSmall = 42
      +	ulongBig = 4294967296
      +	pathRelative = ./some/path
      +	pathAbsolute = /usr/bin/git
      
     + ## contrib/libgit-sys/public_symbol_export.c ##
     +@@ contrib/libgit-sys/public_symbol_export.c: int libgit_configset_get_string(struct libgit_config_set *cs, const char *key,
     + 	return git_configset_get_string(&cs->cs, key, dest);
     + }
     + 
     ++int libgit_configset_get_bool(struct libgit_config_set *cs, const char *key,
     ++			      int *dest)
     ++{
     ++	return git_configset_get_bool(&cs->cs, key, dest);
     ++}
     ++
     ++int libgit_configset_get_ulong(struct libgit_config_set *cs, const char *key,
     ++			       unsigned long *dest)
     ++{
     ++	return git_configset_get_ulong(&cs->cs, key, dest);
     ++}
     ++
     ++int libgit_configset_get_pathname(struct libgit_config_set *cs, const char *key,
     ++				  char **dest)
     ++{
     ++	return git_configset_get_pathname(&cs->cs, key, dest);
     ++}
     ++
     + const char *libgit_user_agent(void)
     + {
     + 	return git_user_agent();
     +
     + ## contrib/libgit-sys/public_symbol_export.h ##
     +@@ contrib/libgit-sys/public_symbol_export.h: int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int
     + 
     + int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
     + 
     ++int libgit_configset_get_bool(struct libgit_config_set *cs, const char *key, int *dest);
     ++
     ++int libgit_configset_get_ulong(struct libgit_config_set *cs, const char *key, unsigned long *dest);
     ++
     ++int libgit_configset_get_pathname(struct libgit_config_set *cs, const char *key, char **dest);
     ++
     + const char *libgit_user_agent(void);
     + 
     + const char *libgit_user_agent_sanitized(void);
     +
       ## contrib/libgit-sys/src/lib.rs ##
      @@
       use std::ffi::c_void;
     @@ contrib/libgit-sys/src/lib.rs: pub type c_char = i8;
       
       #[allow(non_camel_case_types)]
      @@ contrib/libgit-sys/src/lib.rs: extern "C" {
     -         dest: *mut c_int,
     +         dest: *mut *mut c_char,
           ) -> c_int;
       
     ++    pub fn libgit_configset_get_bool(
     ++        cs: *mut libgit_config_set,
     ++        key: *const c_char,
     ++        dest: *mut c_int,
     ++    ) -> c_int;
     ++
      +    pub fn libgit_configset_get_ulong(
      +        cs: *mut libgit_config_set,
      +        key: *const c_char,


 contrib/libgit-rs/src/config.rs           | 83 ++++++++++++++++++++++-
 contrib/libgit-rs/testdata/config3        |  2 +-
 contrib/libgit-rs/testdata/config4        | 13 ++++
 contrib/libgit-sys/public_symbol_export.c | 18 +++++
 contrib/libgit-sys/public_symbol_export.h |  6 ++
 contrib/libgit-sys/src/lib.rs             | 24 ++++++-
 6 files changed, 142 insertions(+), 4 deletions(-)
 create mode 100644 contrib/libgit-rs/testdata/config4

diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
index 6bf04845c8..ffd9f311b6 100644
--- a/contrib/libgit-rs/src/config.rs
+++ b/contrib/libgit-rs/src/config.rs
@@ -1,8 +1,8 @@
 use std::ffi::{c_void, CStr, CString};
-use std::path::Path;
+use std::path::{Path, PathBuf};
 
 #[cfg(has_std__ffi__c_char)]
-use std::ffi::{c_char, c_int};
+use std::ffi::{c_char, c_int, c_ulong};
 
 #[cfg(not(has_std__ffi__c_char))]
 #[allow(non_camel_case_types)]
@@ -12,6 +12,10 @@ type c_char = i8;
 #[allow(non_camel_case_types)]
 type c_int = i32;
 
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+type c_ulong = u64;
+
 use libgit_sys::*;
 
 /// A ConfigSet is an in-memory cache for config-like files such as `.gitmodules` or `.gitconfig`.
@@ -68,6 +72,55 @@ impl ConfigSet {
             Some(owned_str)
         }
     }
+
+    /// Load the value for the given key and attempt to parse it as a boolean. Dies with a fatal error
+    /// if the value cannot be parsed. Returns None if the key is not present.
+    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
+        let key = CString::new(key).expect("config key should be valid CString");
+        let mut val: c_int = 0;
+        unsafe {
+            if libgit_configset_get_bool(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
+                return None;
+            }
+        }
+
+        Some(val != 0)
+    }
+
+    /// Load the value for the given key and attempt to parse it as an unsigned long. Dies with a fatal error
+    /// if the value cannot be parsed. Returns None if the key is not present.
+    pub fn get_ulong(&mut self, key: &str) -> Option<u64> {
+        let key = CString::new(key).expect("config key should be valid CString");
+        let mut val: c_ulong = 0;
+        unsafe {
+            if libgit_configset_get_ulong(self.0, key.as_ptr(), &mut val as *mut c_ulong) != 0 {
+                return None;
+            }
+        }
+        Some(val as u64)
+    }
+
+    /// Load the value for the given key and attempt to parse it as a file path. Dies with a fatal error
+    /// if the value cannot be converted to a PathBuf. Returns None if the key is not present.
+    pub fn get_pathname(&mut self, key: &str) -> Option<PathBuf> {
+        let key = CString::new(key).expect("config key should be valid CString");
+        let mut val: *mut c_char = std::ptr::null_mut();
+        unsafe {
+            if libgit_configset_get_pathname(self.0, key.as_ptr(), &mut val as *mut *mut c_char)
+                != 0
+            {
+                return None;
+            }
+            let borrowed_str = CStr::from_ptr(val);
+            let owned_str = String::from(
+                borrowed_str
+                    .to_str()
+                    .expect("config path should be valid UTF-8"),
+            );
+            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
+            Some(PathBuf::from(owned_str))
+        }
+    }
 }
 
 impl Default for ConfigSet {
@@ -95,6 +148,7 @@ mod tests {
             Path::new("testdata/config1"),
             Path::new("testdata/config2"),
             Path::new("testdata/config3"),
+            Path::new("testdata/config4"),
         ]);
         // ConfigSet retrieves correct value
         assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
@@ -102,5 +156,30 @@ mod tests {
         assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
         // ConfigSet returns None for missing key
         assert_eq!(cs.get_string("foo.bar"), None);
+        // Test boolean parsing - comprehensive tests
+        assert_eq!(cs.get_bool("test.boolTrue"), Some(true));
+        assert_eq!(cs.get_bool("test.boolFalse"), Some(false));
+        assert_eq!(cs.get_bool("test.boolYes"), Some(true));
+        assert_eq!(cs.get_bool("test.boolNo"), Some(false));
+        assert_eq!(cs.get_bool("test.boolOne"), Some(true));
+        assert_eq!(cs.get_bool("test.boolZero"), Some(false));
+        assert_eq!(cs.get_bool("test.boolZeroZero"), Some(false)); // "00" → false
+        assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
+        // Test missing boolean key
+        assert_eq!(cs.get_bool("missing.boolean"), None);
+        // Test ulong parsing
+        assert_eq!(cs.get_ulong("test.ulongSmall"), Some(42));
+        assert_eq!(cs.get_ulong("test.ulongBig"), Some(4294967296)); // > 32-bit int
+        assert_eq!(cs.get_ulong("missing.ulong"), None);
+        // Test pathname parsing
+        assert_eq!(
+            cs.get_pathname("test.pathRelative"),
+            Some(PathBuf::from("./some/path"))
+        );
+        assert_eq!(
+            cs.get_pathname("test.pathAbsolute"),
+            Some(PathBuf::from("/usr/bin/git"))
+        );
+        assert_eq!(cs.get_pathname("missing.path"), None);
     }
 }
diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
index ca7b9a7c38..3ea5b96f12 100644
--- a/contrib/libgit-rs/testdata/config3
+++ b/contrib/libgit-rs/testdata/config3
@@ -1,2 +1,2 @@
 [trace2]
-	eventNesting = 3
+	eventNesting = 3
\ No newline at end of file
diff --git a/contrib/libgit-rs/testdata/config4 b/contrib/libgit-rs/testdata/config4
new file mode 100644
index 0000000000..bd621ab480
--- /dev/null
+++ b/contrib/libgit-rs/testdata/config4
@@ -0,0 +1,13 @@
+[test]
+	boolTrue = true
+	boolFalse = false
+	boolYes = yes
+	boolNo = no
+	boolOne = 1
+	boolZero = 0
+	boolZeroZero = 00
+	boolHundred = 100
+	ulongSmall = 42
+	ulongBig = 4294967296
+	pathRelative = ./some/path
+	pathAbsolute = /usr/bin/git
diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
index dfbb257115..8d6a0e1ba5 100644
--- a/contrib/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -46,6 +46,24 @@ int libgit_configset_get_string(struct libgit_config_set *cs, const char *key,
 	return git_configset_get_string(&cs->cs, key, dest);
 }
 
+int libgit_configset_get_bool(struct libgit_config_set *cs, const char *key,
+			      int *dest)
+{
+	return git_configset_get_bool(&cs->cs, key, dest);
+}
+
+int libgit_configset_get_ulong(struct libgit_config_set *cs, const char *key,
+			       unsigned long *dest)
+{
+	return git_configset_get_ulong(&cs->cs, key, dest);
+}
+
+int libgit_configset_get_pathname(struct libgit_config_set *cs, const char *key,
+				  char **dest)
+{
+	return git_configset_get_pathname(&cs->cs, key, dest);
+}
+
 const char *libgit_user_agent(void)
 {
 	return git_user_agent();
diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgit-sys/public_symbol_export.h
index 701db92d53..f9adda6561 100644
--- a/contrib/libgit-sys/public_symbol_export.h
+++ b/contrib/libgit-sys/public_symbol_export.h
@@ -11,6 +11,12 @@ int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int
 
 int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
 
+int libgit_configset_get_bool(struct libgit_config_set *cs, const char *key, int *dest);
+
+int libgit_configset_get_ulong(struct libgit_config_set *cs, const char *key, unsigned long *dest);
+
+int libgit_configset_get_pathname(struct libgit_config_set *cs, const char *key, char **dest);
+
 const char *libgit_user_agent(void);
 
 const char *libgit_user_agent_sanitized(void);
diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
index 4bfc650450..07386572ec 100644
--- a/contrib/libgit-sys/src/lib.rs
+++ b/contrib/libgit-sys/src/lib.rs
@@ -1,7 +1,7 @@
 use std::ffi::c_void;
 
 #[cfg(has_std__ffi__c_char)]
-use std::ffi::{c_char, c_int};
+use std::ffi::{c_char, c_int, c_ulong};
 
 #[cfg(not(has_std__ffi__c_char))]
 #[allow(non_camel_case_types)]
@@ -11,6 +11,10 @@ pub type c_char = i8;
 #[allow(non_camel_case_types)]
 pub type c_int = i32;
 
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+pub type c_ulong = u64;
+
 extern crate libz_sys;
 
 #[allow(non_camel_case_types)]
@@ -43,6 +47,24 @@ extern "C" {
         dest: *mut *mut c_char,
     ) -> c_int;
 
+    pub fn libgit_configset_get_bool(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut c_int,
+    ) -> c_int;
+
+    pub fn libgit_configset_get_ulong(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut c_ulong,
+    ) -> c_int;
+
+    pub fn libgit_configset_get_pathname(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut *mut c_char,
+    ) -> c_int;
+
 }
 
 #[cfg(test)]

base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
-- 
gitgitgadget
