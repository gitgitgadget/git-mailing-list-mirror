Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48A19ADA2
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101710; cv=none; b=ntRNsoNVHLu7alnR0goRrdekDajkohjbwmP4Cowu/2eW5TUk80m2h/qzcMVzr5f4ORDWCDQIOJOUCa0QzfnuIWLUfgHf8eRQDZnWvdYX4Qfdr1cpGEl/cOATr1E/uFhYVx2ODdsa46Kb0YpBVbIf54xoIDLev7f3a5Z0HazxZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101710; c=relaxed/simple;
	bh=t/NpBUIaToMVT7OgZsBymt71cn9NkJdvdJqA34KDSJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FPCdBCAHa7dZO1FTaimA4jjlvUL+pG7YEwEFojKJzLH6rsMNRcWUAaKGrZo54vf9xjmdqimgUFfsMvolrLPUoF9NJ7GHP4nhhuRkx6TqlUr4U8V4FfoX6lWjLDwXiAeekGe20vtWHn577xlMI3RhrlbzoFSN0dGpvL+1cGLSVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E83yKAu+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E83yKAu+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso12385607a91.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 14:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738101708; x=1738706508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzAFp4YAtbOU6jl9VfN/7dfiX3slc8SYxdEGxReh9zY=;
        b=E83yKAu+I6UF+2ek9w/a3+zJdE02k6bk2oydHgvEoHKuOofY307krW8dUcq9apAjCe
         7mA1V27fyHU8kVoQbne7CpEZJR5+AaNSluN8bjUZ9QcLeVD9uNC3O1fljBRt/TYldkY6
         rblSVB6nTcYzuqfOywSYVOS+dIXmxkcV1mOGIJuE81RzQg6FB7u8ooTbE1ODK1m7nQgK
         upS4VeYZQClQt2D9Nn4tWWZBWDXc6zlVgSuQXTbp0TM1ypEJNCnH2+4/2E5QLnjHsgvQ
         KEyqn7ZrCHfw3nt17piz6slMF40GkjHYK3R0rmlHzGEEyVxmpOBFDCqFkmo14lUjg1G1
         O7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101708; x=1738706508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzAFp4YAtbOU6jl9VfN/7dfiX3slc8SYxdEGxReh9zY=;
        b=uwp+7K7FPmQab3kyRamXE2RzgZGvSKMeMr0KiL5e3tI1NaxvmnNJljGQ6apLKHS3Gr
         fYsplD5lmY4JQvEtHaAi7KNjiL7DwqI7kV0Bey5e0YtnVdyzn3koV2YHTHFGtC6QQiXQ
         K0TgfjQLzCwC5CqPa/PapHArXHIrQPKcxpBCGxQ6MGeyXJv9eP7hBFdKHy3F6hJZtuwi
         eQEuQeS3YDJSxfGEMCVMPF0Fbcowq5JZpqAInulMV1Uz6GWQoNRP3fUBgFjlAomw8XeV
         LAEdtZKOTp5y91c2HBmwwjLsTr/kgLjRWL+glvn1a83A67uSrnlK/omENQs/d7r5jTvj
         3n6g==
X-Gm-Message-State: AOJu0Yx13nwYXi0lZguzypePbw5JojuiGB+IITa+95chaMx31sIeLihM
	L7w22iLdgYuHU04TlB3yDZfjs8veRGbRSl1lgyIQ0WYnbn7BZzweO71lVQnTRCfs0xcuFKULZTj
	spkhxB2KUyRE5/dYr33yLIOisZMJq9bdYILfgo6ZMyVeiCmLSlByMo2AYVnERvMgThakfknNtyw
	Yj6H0upt8EA1/m+x4T9RcGpUxXYzKacpS6Ye6deiQ=
X-Google-Smtp-Source: AGHT+IGtnz7evXRiE4wnwAwMCDg0k/YiEXUmRMB9XTED+JfatnTRdFaH+YXLCWNaflcQzxOnMWyVl02GW57MOQ==
X-Received: from pjvf7.prod.google.com ([2002:a17:90a:da87:b0:2ef:95f4:4619])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b88:b0:2f4:9e8b:6aad with SMTP id 98e67ed59e1d1-2f83aa804cfmr1285329a91.0.1738101707683;
 Tue, 28 Jan 2025 14:01:47 -0800 (PST)
Date: Tue, 28 Jan 2025 14:01:39 -0800
In-Reply-To: <cover.1738101256.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738101256.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <f4452fffe66168dcf410c428c9ab8c52e087603f.1738101256.git.steadmon@google.com>
Subject: [PATCH v8 3/4] libgit-sys: also export some config_set functions
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
index 4c153c6f0d..dbb7948104 100644
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
+	free(&cs->cs);
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
2.48.1.262.g85cc9f2d1e-goog

