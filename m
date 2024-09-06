Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A81B85D9
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661289; cv=none; b=KieHiaiRDNhZ/c6TlYGmGYs3GgxpkNcbVnpIxOJa7NQWTUtXal84IJzEiBDsKLlYKHX7CF6edjnTc0a80F932g3JMdNCat6UDBTjLtTSHtfCKCx4tmYlEdswM+AJhZZjlnr7PvFIh+x679iSQBf/yyeoQNDXrBTjkxliskCKxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661289; c=relaxed/simple;
	bh=N88vkX129rqZ+DWkQlIs/o/NSbG07lAItLOzzw16+5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qTLDjz7TVtdvMOEgD/n9TuzhPOTR7DekRsQsH2VJOIxoRnMq1+pyyYlLC+weuvD/8VHCIcy6+6eA5ZoJuf1tl5MoaB7LQBIl7n0WjiPigRZ36F8NwiSk0fI1q+PCqxD+PjjTXTO4l/0x3jBLzCqD21YN6pgsItM3QdufYXMdQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sODR6Hsk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sODR6Hsk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d5fccc3548so58637827b3.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725661286; x=1726266086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk1afKTSB6oTJ5sAfEAwQadSx+VjBdujEI5TGPbVZlM=;
        b=sODR6HskevPrw0j5pAXFGN9GaiZebedNu9Om6p0xAg3UO1esaOytLOZe895BAusTRc
         FGdupfLA9ydHd0xjYHLPvVyrDGaTYHByisTSJIgXFElYTN2WQl+cbR7chUoLoyiY/vVd
         ZvEgVdKTp9YdUQBdRoGDzdyuCFV3hNSvqT/uxbwEmlU/ubiG8OjBybST0o9aTWYBexda
         K63s1+mquXQHhm2THgqOhIuGVXE3SmvLoUzYLiwxr8I0l5IxXZQ5X1VoLCWUmEA1y5TE
         Apj/WzRQ4gC1CienGD4pd3Ybg2zvtRWovCNFjPHtkoJxsuh4eWpFsYlKrJXWnQp6HJMf
         5Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661286; x=1726266086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tk1afKTSB6oTJ5sAfEAwQadSx+VjBdujEI5TGPbVZlM=;
        b=pH4DU4G55mqmM55V+7psXXKR6beAYpKmUj6BYWZV0KYQOMo689hJQ+gpEeoR/10bP9
         7gTMSXK4paqnvLYQfYzx2eZrR0ZBc+ZYErbaOufOqfZPnMGX9J6wWolJqhGF+7WgUUK5
         mDt4gxONE4ORclI+lxlkVF8uP5ByNSavkmAIQxicCN9VTdpqbKFnItyfEoBSf3Ov11uZ
         XH/fTZ/LJGH/9ioogPJ1qzLvlqaV4Fg3R2wfTECFyYDtcidbJqczfOGNYV//pLbdMUQd
         J5MGyg9athd/wZx5GrMFGs6b1AJ86wjC8V2uiLxZ7AOVhuQtM9gxkRjuWozvwlUuwXDA
         nfgw==
X-Gm-Message-State: AOJu0YxcoctU00rlduKf2vQCRzyu9cl4BPTx8cZy1duFzK+6+172b3i+
	ZdxagFF/eglgbA900rWUyN25eTC538nfJ1DdFJwd8PMFRG3MA6gaSE/XgFEy+2v0pSuDtBmJFq8
	R6z04KEergw52B1poT728Vpzhsx1ikwDmn0O/0w9GQS0Mr0kvWlCqST7nOy9cJhqGw1cPktYMQ7
	68+SWY87l4ebpL0sQfFMLhuYZTYsUu5+31L9l99WrY96W/
X-Google-Smtp-Source: AGHT+IH0kT3bSJbOkspSxfdqAO5xEBMbwXZCTOkXktl07RCr8IY0/visDqTGC+X6OMWZrOnqGcYS560voMxA0+g=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:690c:460c:b0:6d3:e7e6:8460 with SMTP
 id 00721157ae682-6db4426b0ecmr744197b3.1.1725661285980; Fri, 06 Sep 2024
 15:21:25 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:21:13 +0000
In-Reply-To: <20240906221853.257984-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906222116.270196-3-calvinwan@google.com>
Subject: [PATCH v3 3/6] libgit-sys: add repo initialization and config access
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, steadmon@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

Wrap a few repo setup and config access functions in libgit-sys. These
were selected as proof-of-concept items to show that we can access local
config from Rust.

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Change-Id: I6dd886af8c63e1f0f3251064cd8903aecdf768bb
---
 .../libgit-sys/public_symbol_export.c         | 26 +++++++++
 .../libgit-sys/public_symbol_export.h         |  8 +++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 57 ++++++++++++++++++-
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
index 39c27d9c1a..65d1620d28 100644
--- a/contrib/libgit-rs/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
@@ -2,11 +2,37 @@
 // original symbols can be hidden. Renaming these with a "libgit_" prefix also
 // avoid conflicts with other libraries such as libgit2.
 
+#include "git-compat-util.h"
 #include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
+#include "common-init.h"
+#include "config.h"
+#include "setup.h"
 #include "version.h"
 
+extern struct repository *the_repository;
+
 #pragma GCC visibility push(default)
 
+const char *libgit_setup_git_directory(void)
+{
+	return setup_git_directory();
+}
+
+int libgit_config_get_int(const char *key, int *dest)
+{
+	return repo_config_get_int(the_repository, key, dest);
+}
+
+void libgit_init_git(const char **argv)
+{
+	init_git(argv);
+}
+
+int libgit_parse_maybe_bool(const char *val)
+{
+	return git_parse_maybe_bool(val);
+}
+
 const char *libgit_user_agent(void)
 {
 	return git_user_agent();
diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.h b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
index a3372f93fa..64332f30de 100644
--- a/contrib/libgit-rs/libgit-sys/public_symbol_export.h
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
@@ -1,6 +1,14 @@
 #ifndef PUBLIC_SYMBOL_EXPORT_H
 #define PUBLIC_SYMBOL_EXPORT_H
 
+const char *libgit_setup_git_directory(void);
+
+int libgit_config_get_int(const char *key, int *dest);
+
+void libgit_init_git(const char **argv);
+
+int libgit_parse_maybe_bool(const char *val);
+
 const char *libgit_user_agent(void);
 
 const char *libgit_user_agent_sanitized(void);
diff --git a/contrib/libgit-rs/libgit-sys/src/lib.rs b/contrib/libgit-rs/libgit-sys/src/lib.rs
index 346b26083d..9b2e85dff8 100644
--- a/contrib/libgit-rs/libgit-sys/src/lib.rs
+++ b/contrib/libgit-rs/libgit-sys/src/lib.rs
@@ -1,8 +1,19 @@
-use std::ffi::c_char;
+use std::ffi::{c_char, c_int};
 
 extern crate libz_sys;
 
 extern "C" {
+    pub fn libgit_setup_git_directory() -> *const c_char;
+
+    // From config.c
+    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) -> c_int;
+
+    // From common-init.c
+    pub fn libgit_init_git(argv: *const *const c_char);
+
+    // From parse.c
+    pub fn libgit_parse_maybe_bool(val: *const c_char) -> c_int;
+
     // From version.c
     pub fn libgit_user_agent() -> *const c_char;
     pub fn libgit_user_agent_sanitized() -> *const c_char;
@@ -10,7 +21,7 @@ extern "C" {
 
 #[cfg(test)]
 mod tests {
-    use std::ffi::CStr;
+    use std::ffi::{CStr, CString};
 
     use super::*;
 
@@ -39,4 +50,46 @@ mod tests {
             agent
         );
     }
+
+    #[test]
+    fn parse_bools_from_strings() {
+        let arg = CString::new("true").unwrap();
+        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 1);
+
+        let arg = CString::new("yes").unwrap();
+        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 1);
+
+        let arg = CString::new("false").unwrap();
+        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 0);
+
+        let arg = CString::new("no").unwrap();
+        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 0);
+
+        let arg = CString::new("maybe").unwrap();
+        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, -1);
+    }
+
+    #[test]
+    fn access_configs() {
+        /*
+         * Since we can't easily set a config for the local repo, test
+         * for the existence of a key rather than a specific value 
+         */
+        let fake_argv = [std::ptr::null::<c_char>()];
+        unsafe {
+            libgit_init_git(fake_argv.as_ptr());
+            libgit_setup_git_directory();
+        }
+        let mut dest: c_int = 0;
+        let key = CString::new("core.repositoryformatversion").unwrap();
+        unsafe { 
+            let val = libgit_config_get_int(key.as_ptr(), &mut dest as *mut i32);
+            assert_eq!(val, 0)
+        };
+        let missing_key = CString::new("foo.bar").unwrap();
+        unsafe { 
+            let val = libgit_config_get_int(missing_key.as_ptr(), &mut dest as *mut i32);
+            assert_eq!(val, 1)
+        };
+    }
 }
-- 
2.46.0.469.g59c65b2a67-goog

