Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851A1E3DF8
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738187454; cv=none; b=aidQMsUD58u0xC1cgcU5yNc93OlbePai9veC2abgQVYz5bG9i26HQyiW08BliiVOUINfS5qWll4D/rFYCtyO5WcD2M8miXnU5IaDZnoqsa0aHjuiKPg4QxqSk79wB6w6Z55zZZTjRChNaV2RWM1qqxRLmY0FsgrNlxEFb+JP3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738187454; c=relaxed/simple;
	bh=yHsBI+i1FPQQf7bZ+tisps2MmeZI3Q0QFMuOzG2X1dE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ozZaNP0lQwjYO+KoVeZXTN4eMKBr2FJCGfPXPtelYs+k2RxVY9W25Oj0hZlRoOlLvWkPuQ4Gj2Zr87B5oBanRmuSAEvgSvKtLnd7pn4yt4p+ZdrHqgdf8DpkdPkGNou08TGQDPGyWTYuasMNis5E1vSgyeCG+PhWX3Ju4ygi53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb+4T+EU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb+4T+EU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso203590a91.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738187452; x=1738792252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gQKPlm1jGTqeOkdgnOcBi2tKU9tT7sK9zntM8j205I=;
        b=Cb+4T+EUtvsntflC0JnAmm9oxD6XHBq0oNx2BEf1XP+wCE3kocHvfjg3cQ9WbnDrw0
         DkOk/JDRHdF/nddwIz9Pt+NBxiNz2ORkU6KJ4Au8JqPGuevvvkxllZ0heKEbmR+wOtZd
         Ka7OOBp4x7k1rISLWa+sPzdBbVFQmFw/cd6Vqh+zu9qVjZdG/qlT5ztWlbwL0qh4xhuH
         Al+X1yWducPrZOmUk9V6FzMIEdnUzaRCqjndKBfSWwGF4TVFN0P/BHmYey2PuCASMX0Y
         fFQOymCwaLgywmY93JHfcGsn8lVbAHSsKdx791lsR2+nSzt50EbVCHUuSLeeQrbBBsu8
         cQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738187452; x=1738792252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gQKPlm1jGTqeOkdgnOcBi2tKU9tT7sK9zntM8j205I=;
        b=R3giZr5PQV5HZUp7C0FDmNHA9DiJEoUaPYnSPrIB3XkPR0h6eXWZFF0wal2vfZjJB1
         VjFfEPDlnBg/zO8V1jYIu5zjIBZPAMsQF6sMShNvZaMpyU4jSVazdVvc/6Jf12mn/j6V
         7HHc5va1d5t/D/a4dDbEyfpHuzDdEpep2Sg7GAGsf/+bzQaNmbjsH21r14WlVrWRRQVf
         bItEBrlS9qY2rhajscEYTURRHLe2sjosRd8zmhCUkh+Ey+5n14gnv77vhWx7j2PpQUCl
         dFqIqFmj4v7xCTAFG/S8YiDGYvvlyizM9cIQd4rVHzxJeqShJLithQDZTo9T25defx4l
         mEFQ==
X-Gm-Message-State: AOJu0YzBHTQiWI4778d8MXNnweyirUU+b0bg14MV6jX4q3srC7kVPGfF
	MFP12PIw3mHPyyE+p/gRpPmc2eJDpm4Y8xNKEX/KZdf8wXL/HSXIf76VX4Jh0VB49vaR3lp5HL3
	S3/8F81uD7IErCQtqzn3wPplwv04vnivepturmQx58MoZbSLDCqRVO+gHgos4+lkYKuzrqUUVga
	yU2ud6uhbKEiS+WSdw/PT637Eg9aZgQd3mG68q0cY=
X-Google-Smtp-Source: AGHT+IHEW1Vzq7cNsKBKj7X9IZUnnm2ooYRtN9LUqCcS9/ww2mJzND4QC01rHoi2pLuTkWzmtbKcemAOJale0g==
X-Received: from pjz15.prod.google.com ([2002:a17:90b:56cf:b0:2ef:6ef8:6567])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5410:b0:2ee:c9b6:c267 with SMTP id 98e67ed59e1d1-2f83abdebb0mr7568068a91.9.1738187452164;
 Wed, 29 Jan 2025 13:50:52 -0800 (PST)
Date: Wed, 29 Jan 2025 13:50:43 -0800
In-Reply-To: <cover.1738187176.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738187176.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <ab32bd1d07fe60a3b8bc94e0867f8ab3252aa6d1.1738187176.git.steadmon@google.com>
Subject: [PATCH v9 3/4] libgit-sys: also export some config_set functions
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

In preparation for implementing a higher-level Rust API for accessing
Git configs, export some of the upstream configset API via libgitpub and
libgit-sys. Since this will be exercised as part of the higher-level API
in the next commit, no tests have been added for libgit-sys.

While we're at it, add git_configset_alloc() and git_configset_free()
functions in libgitpub so that callers can manage config_set structs on
the heap. This also allows non-C external consumers to treat config_sets
as opaque structs.

Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 contrib/libgit-sys/public_symbol_export.c | 36 +++++++++++++++++++++++
 contrib/libgit-sys/public_symbol_export.h | 10 +++++++
 contrib/libgit-sys/src/lib.rs             | 31 ++++++++++++++++++-
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
index 4c153c6f0d..dfbb257115 100644
--- a/contrib/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -5,11 +5,47 @@
  */
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "contrib/libgit-sys/public_symbol_export.h"
 #include "version.h"
 
 #pragma GCC visibility push(default)
 
+struct libgit_config_set {
+	struct config_set cs;
+};
+
+struct libgit_config_set *libgit_configset_alloc(void)
+{
+	struct libgit_config_set *cs =
+			xmalloc(sizeof(struct libgit_config_set));
+	git_configset_init(&cs->cs);
+	return cs;
+}
+
+void libgit_configset_free(struct libgit_config_set *cs)
+{
+	git_configset_clear(&cs->cs);
+	free(cs);
+}
+
+int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
+{
+	return git_configset_add_file(&cs->cs, filename);
+}
+
+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key,
+			     int *dest)
+{
+	return git_configset_get_int(&cs->cs, key, dest);
+}
+
+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key,
+				char **dest)
+{
+	return git_configset_get_string(&cs->cs, key, dest);
+}
+
 const char *libgit_user_agent(void)
 {
 	return git_user_agent();
diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgit-sys/public_symbol_export.h
index a3372f93fa..701db92d53 100644
--- a/contrib/libgit-sys/public_symbol_export.h
+++ b/contrib/libgit-sys/public_symbol_export.h
@@ -1,6 +1,16 @@
 #ifndef PUBLIC_SYMBOL_EXPORT_H
 #define PUBLIC_SYMBOL_EXPORT_H
 
+struct libgit_config_set *libgit_configset_alloc(void);
+
+void libgit_configset_free(struct libgit_config_set *cs);
+
+int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename);
+
+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest);
+
+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
+
 const char *libgit_user_agent(void);
 
 const char *libgit_user_agent_sanitized(void);
diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
index d4853f3074..dadb4e5f40 100644
--- a/contrib/libgit-sys/src/lib.rs
+++ b/contrib/libgit-sys/src/lib.rs
@@ -1,15 +1,44 @@
 #[cfg(has_std__ffi__c_char)]
-use std::ffi::c_char;
+use std::ffi::{c_char, c_int};
 
 #[cfg(not(has_std__ffi__c_char))]
 #[allow(non_camel_case_types)]
 pub type c_char = i8;
 
+#[cfg(not(has_std__ffi__c_char))]
+#[allow(non_camel_case_types)]
+pub type c_int = i32;
+
 extern crate libz_sys;
 
+#[allow(non_camel_case_types)]
+#[repr(C)]
+pub struct libgit_config_set {
+    _data: [u8; 0],
+    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
+}
+
 extern "C" {
     pub fn libgit_user_agent() -> *const c_char;
     pub fn libgit_user_agent_sanitized() -> *const c_char;
+
+    pub fn libgit_configset_alloc() -> *mut libgit_config_set;
+    pub fn libgit_configset_free(cs: *mut libgit_config_set);
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
-- 
2.48.1.362.g079036d154-goog

