Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274A1422DD
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054905; cv=none; b=PulKViEZxqiOU+s3/WECZ0ohGEBl6ng2bGEr1aG8XzWHkU0ht8aUBMzpvGb7s/l3jLk3DSIOYsWb9EuI6Pawz2N0jPxcAL0Ak3k0uZB7jEgBCjhMNyt+wQ48uomyyZhoKuAy6JueFWGQMHoW2CgF4FhLzU/EWMkWmeP4/6Ez7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054905; c=relaxed/simple;
	bh=WuJUOZ+NIkaWJQOqSKaDaQ/zwm1Q8BFdBjlhth6OAyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hV7Io1GpG72D5TeMUzIAmVnCgRsYYnMagmVb694MX3h3cAztCMboq7uHRkwuxMYnfltHS0+ZPqAA5o+N6X0Yah743eoAxHGNYBsDXi8B2Dyzkxea0kdbQPv4ROTb0fyrSnb2+cSiWoX9VR/rE67zFcBwwDBZ2taJrrdrgnoq3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZ7Yi336; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZ7Yi336"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66628e9ec89so2641947b3.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 11:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723054903; x=1723659703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rk1iovIPdivophnoqxUPwNRc4SYTsh44XZockca6a/w=;
        b=cZ7Yi336rvoMYh1QlHPTuexGX36EN0Jctm55df1/2rgx6459B+8zRiKTeHYr4pwf3d
         NOE+A5P26waJnQ5xKlgzAUUwyyzDWNWZUgc/EOy3GQXml9JrrX+fs4ZGy4qmM0zMSmHW
         VthAvX+G53C99ovdx3jqLKyvqUziYjgvhZ7aQuIhYwAjC1uQjpc4TJVKK/FXyXiqe+Rr
         Hk1V3rXTNkcvsxrjcpZ6OLGbrfi9NN6EjF5xc50YjGqfwGnPvAx15c3JFQCzbWq0y6Jp
         +6/ScXitcep5E2RCnR/L1vLkKOpTbdkDLBKinb4QAr5sD8DrQ+pHqNU1Ov4OyqDNLjEY
         37iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054903; x=1723659703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rk1iovIPdivophnoqxUPwNRc4SYTsh44XZockca6a/w=;
        b=q/mQjpuNfnCony2+YA26agHev3cn0UUAqrQYuCmTOWTjbyQNzxlTbzppJWrQveib0R
         PE3xRscAW8LZtvLov3dD6X5HtocZt7/RQtBjbzZSYQ8jbOoRH+6hJv6k12N9T3r9uJze
         H49STij7FG4/Qcydol0j5xot6pBcsMVfBnf5C/Oto0H5FeGTaaCoAUVTov7MSAFRnq1H
         2K3gZJUF48dB+Hsz1exw4A1UhLxKw+Z2IfTQ/TMA80bWmzUSsKq0dteHcRyTWUQlOe1C
         zNwLfL7A4BNv2N2cIr8KuF8n3VNJlgn/fl+hFpSj2u5KwvuK5D1SfNenmJlxyYYEgXaP
         vz1Q==
X-Gm-Message-State: AOJu0Yzo1RMW6Lo7mIJeM3XDBjCtrGrH3GCsri7p18ZRNQ5Zmy9L+3qF
	UNpYyr1UjhqQ/JxSDRJUcJkXs2TdBqR7ilB2mT2Hx8kUrOQ9a+HXgRxghG46dAjJHgCa9nc3ONS
	qVpkIRdCv4VdYwW/BUNYAyKTFcpNXxoHBuUWMEhkRZEL3txKk4z+tuapyfZl2oFsKzjrZFkDp72
	ixk43pHclpLJy8JdDMh5KPTJBaLhaLBhD2oQXoxAI=
X-Google-Smtp-Source: AGHT+IEsbTVJFB0r55ZwkDhdLx8oV9o/DGx6Kiw8+3R/BngdNQUluCZhx+hfBv2QgekvbnJqAFbAZCiq3BfLOA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
 (user=steadmon job=sendgmr) by 2002:a25:8601:0:b0:e05:f1ad:a139 with SMTP id
 3f1490d57ef6-e0bde435653mr29377276.11.1723054902377; Wed, 07 Aug 2024
 11:21:42 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:21:29 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <b84a8210a05c2358dc29f24a56adcbeaa90c8654.1723054623.git.steadmon@google.com>
Subject: [RFC PATCH 4/6] contrib/cgit-rs: add repo initialization and config access
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 contrib/cgit-rs/public_symbol_export.c | 27 ++++++++++++++++++++++++++
 contrib/cgit-rs/public_symbol_export.h |  8 ++++++++
 contrib/cgit-rs/src/lib.rs             | 13 ++++++++++++-
 contrib/cgit-rs/src/main.rs            | 23 +++++++++++++++++++++-
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/contrib/cgit-rs/public_symbol_export.c b/contrib/cgit-rs/public_symbol_export.c
index 3d1cd6cc4f..ab3401ac40 100644
--- a/contrib/cgit-rs/public_symbol_export.c
+++ b/contrib/cgit-rs/public_symbol_export.c
@@ -2,11 +2,35 @@
 // original symbols can be hidden. Renaming these with a "libgit_" prefix also
 // avoid conflicts with other libraries such as libgit2.
 
+#include "git-compat-util.h"
 #include "contrib/cgit-rs/public_symbol_export.h"
+#include "attr.h"
+#include "config.h"
+#include "setup.h"
 #include "version.h"
 
 #pragma GCC visibility push(default)
 
+const char *libgit_setup_git_directory(void)
+{
+	return setup_git_directory();
+}
+
+int libgit_config_get_int(const char *key, int *dest)
+{
+	return git_config_get_int(key, dest);
+}
+
+void libgit_initialize_the_repository(void)
+{
+	initialize_the_repository();
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
@@ -17,4 +41,7 @@ const char *libgit_user_agent_sanitized(void)
 	return git_user_agent_sanitized();
 }
 
+const char *libgit_attr__true = git_attr__true;
+const char *libgit_attr__false = git_attr__false;
+
 #pragma GCC visibility pop
diff --git a/contrib/cgit-rs/public_symbol_export.h b/contrib/cgit-rs/public_symbol_export.h
index a3372f93fa..97e8e871ba 100644
--- a/contrib/cgit-rs/public_symbol_export.h
+++ b/contrib/cgit-rs/public_symbol_export.h
@@ -1,6 +1,14 @@
 #ifndef PUBLIC_SYMBOL_EXPORT_H
 #define PUBLIC_SYMBOL_EXPORT_H
 
+const char *libgit_setup_git_directory(void);
+
+int libgit_config_get_int(const char *key, int *dest);
+
+void libgit_initialize_the_repository(void);
+
+int libgit_parse_maybe_bool(const char *val);
+
 const char *libgit_user_agent(void);
 
 const char *libgit_user_agent_sanitized(void);
diff --git a/contrib/cgit-rs/src/lib.rs b/contrib/cgit-rs/src/lib.rs
index dc46e7ff42..df350e758f 100644
--- a/contrib/cgit-rs/src/lib.rs
+++ b/contrib/cgit-rs/src/lib.rs
@@ -1,6 +1,17 @@
-use libc::c_char;
+use libc::{c_char, c_int};
 
 extern "C" {
+    pub fn libgit_setup_git_directory() -> *const c_char;
+
+    // From config.c
+    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) ->c_int;
+
+    // From repository.c
+    pub fn libgit_initialize_the_repository();
+
+    // From parse.c
+    pub fn libgit_parse_maybe_bool(val: *const c_char) -> c_int;
+
     // From version.c
     pub fn libgit_user_agent() -> *const c_char;
     pub fn libgit_user_agent_sanitized() -> *const c_char;
diff --git a/contrib/cgit-rs/src/main.rs b/contrib/cgit-rs/src/main.rs
index 1794e3f43e..c5f8644fca 100644
--- a/contrib/cgit-rs/src/main.rs
+++ b/contrib/cgit-rs/src/main.rs
@@ -1,4 +1,4 @@
-use std::ffi::CStr;
+use std::ffi::{CStr, CString};
 
 fn main() {
     println!("Let's print some strings provided by Git");
@@ -7,4 +7,25 @@ fn main() {
     println!("git_user_agent() = {:?}", c_str);
     println!("git_user_agent_sanitized() = {:?}",
         unsafe { CStr::from_ptr(cgit::libgit_user_agent_sanitized()) });
+
+    println!("\nNow try passing args");
+    let test_arg = CString::new("test_arg").unwrap();
+    println!("git_parse_maybe_bool(...) = {:?}",
+        unsafe { cgit::libgit_parse_maybe_bool(test_arg.as_ptr()) });
+
+    println!("\nCan we get an int out of our config??");
+    unsafe {
+        cgit::libgit_initialize_the_repository();
+        cgit::libgit_setup_git_directory();
+        let mut val: libc::c_int = 0;
+        let key = CString::new("trace2.eventNesting").unwrap();
+        cgit::libgit_config_get_int(
+            key.as_ptr(),
+            &mut val as *mut i32
+        );
+        println!(
+            "git_config_get_int(\"trace2.eventNesting\") -> {:?}",
+            val
+        );
+    };
 }
-- 
2.46.0.rc2.264.g509ed76dc8-goog

