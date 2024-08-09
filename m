Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013516CD06
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243287; cv=none; b=Ywlc7wBV+l6Sq0SoCLsU2WFmixlCrq5fnhKNcJJpytf9q0MyEot1VmWZEffJOrVua7PO8A9vEI6SuGpIYy8I7R4EJfXw+9eNq5elii96LVDlG9GxkFXyz1ANWD2Lb0a74ON4HbyVs4t6qqeHmpkHjnUztbSdkguwEpyRAXBFAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243287; c=relaxed/simple;
	bh=jIrYBlVw3WJyfjdFlZgC7v0CIMcxDLQpL/rCED5y1fY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Raaew6YCyP1IrTWTIs3qp5SS4y0dPqhEpsyRgTjibBIeJNeiQDLUks0qGGXqO7b5TfnkKylq8z87W3rlvo6wBF3C4MqPyJISSTLd/73UFH6OFpRzr/dak3e9j2icP2W1Nt8SLCWmZS+YIMEk+RT7GE3Qu+tS1+h0uCum9MRptp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+BeeS04; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+BeeS04"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0ba4d19585so4319863276.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723243285; x=1723848085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzmHUEhogeMZwKfl63adstzyZtv39oYc2/8qG5tnYh4=;
        b=3+BeeS043zmDBzAlXax3qsBsS+sfbB5E6LBcjo6plzuqtO118DmrZp5btQ+HlB2ZIL
         B+wUq5ujhWiJxqQuS6kZxkItwPdu/r/3TZ3tSCXf+sTDiaGPudlP8XGUeqav6AnXEHYu
         s1oovaWH2zOL2GXNJPMWF+NSruKsvm7bSl2sPWVm77XSazRxmHJgVAccfzQZHHD5qV2g
         dVfnZyzp1Yna0yibOCx5K/QCXxZWugN+89eXI+pTJVgTyxO/06Rl6JJINE6DEBCW1H5G
         VfoyyXDv8WSx3+muJXXwwjKQ/WUYzI+vZpUUcrJaj0ejy7ldBxgFR+cW7jOeWOhjuIzM
         OV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243285; x=1723848085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzmHUEhogeMZwKfl63adstzyZtv39oYc2/8qG5tnYh4=;
        b=B0zXyIF46zYwAHSLlXAG88jynTircFTWB5Jg4yZ3o1+p+NsyJKIOJrhreydJMPO96Y
         C2Uqc9DDyE54sw/HStx4K0PLOTbPdHwfoK9SfyP66KK+5Bk9/7bKR75LpamDiVtCGYDX
         lFWb0dmyj8mQ4zg2r0e1DtzeUqjEv77O1QaVos9tb27dyp/XbPuse4o18IbH5mCBW8Vb
         UU4GvLBzWVnZp+6B3vxVnflLzhGa/Vi7GPnFwuBEaKCVrR4oLalXnlmcZ/1PWbmvnth0
         6O507xu8p2PR2lqKjcixRVDAsst4Z3FcD3MkEW689kzaEvdgjt+rnWzjvig8QWAyJMA1
         v21g==
X-Gm-Message-State: AOJu0YxwLKacHs8Y+sBvZIx28p5BceeIOPgHXs+fKlAklocJRzvRtet1
	dAJzFfT8kMdKsqu7Yz/FbytNQC53Pp+WDHSe83PjJwwbEkHoXfco2VQnpQA0/r4/Sygi5KwNHX6
	bWkDdu+IW7LitqZo2ZpH8TCYKonQyHXvYS8/lVX6UqBOFQIpbKMpwbspmC8+YArbeRqFo4xQBi3
	mMZk3spa5diOoLt/A55nm84MmQBnHn5wL8TW10ERg=
X-Google-Smtp-Source: AGHT+IHqCdMEu+jEnHfAYAF1bWkPHKCSJ/gdUeUwEJYrBxrWhJJt/XhLSsbTtAJxSFCgAzPyQawbtJUKdZaNhw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
 (user=steadmon job=sendgmr) by 2002:a25:69cd:0:b0:e03:2f8e:9d81 with SMTP id
 3f1490d57ef6-e0eb9790248mr6592276.0.1723243284399; Fri, 09 Aug 2024 15:41:24
 -0700 (PDT)
Date: Fri,  9 Aug 2024 15:41:15 -0700
In-Reply-To: <cover.1723242556.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <527780f816028f4c60db8f51ce06de090cb51286.1723242556.git.steadmon@google.com>
Subject: [PATCH v2 3/5] cgit-sys: add repo initialization and config access
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

From: Calvin Wan <calvinwan@google.com>

Wrap a few repo setup and config access functions in cgit-sys. These
were selected as proof-of-concept items to show that we can access local
config from Rust.

Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .../cgit-rs/cgit-sys/public_symbol_export.c   | 26 ++++++++++
 .../cgit-rs/cgit-sys/public_symbol_export.h   |  8 ++++
 contrib/cgit-rs/cgit-sys/src/lib.rs           | 47 ++++++++++++++++++-
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.c b/contrib/cgit-rs/cgit-sys/public_symbol_export.c
index deef4488c0..62a91f76d0 100644
--- a/contrib/cgit-rs/cgit-sys/public_symbol_export.c
+++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.c
@@ -2,11 +2,37 @@
 // original symbols can be hidden. Renaming these with a "libgit_" prefix also
 // avoid conflicts with other libraries such as libgit2.
 
+#include "git-compat-util.h"
 #include "contrib/cgit-rs/cgit-sys/public_symbol_export.h"
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
diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.h b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
index a3372f93fa..64332f30de 100644
--- a/contrib/cgit-rs/cgit-sys/public_symbol_export.h
+++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
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
diff --git a/contrib/cgit-rs/cgit-sys/src/lib.rs b/contrib/cgit-rs/cgit-sys/src/lib.rs
index bc33c6c498..8c3ccc2859 100644
--- a/contrib/cgit-rs/cgit-sys/src/lib.rs
+++ b/contrib/cgit-rs/cgit-sys/src/lib.rs
@@ -1,6 +1,17 @@
-use std::ffi::c_char;
+use std::ffi::{c_char, c_int};
 
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
@@ -8,7 +19,7 @@ extern "C" {
 
 #[cfg(test)]
 mod tests {
-    use std::ffi::CStr;
+    use std::ffi::{CStr, CString};
 
     use super::*;
 
@@ -37,4 +48,36 @@ mod tests {
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
+        // NEEDSWORK: we need to supply a testdata config
+        let fake_argv = [std::ptr::null::<c_char>()];
+        unsafe {
+            libgit_init_git(fake_argv.as_ptr());
+            libgit_setup_git_directory();
+        }
+        let mut val: c_int = 0;
+        let key = CString::new("trace2.eventNesting").unwrap();
+        unsafe { libgit_config_get_int(key.as_ptr(), &mut val as *mut i32) };
+        assert_eq!(val, 5);
+    }
 }
-- 
2.46.0.76.ge559c4bf1a-goog

