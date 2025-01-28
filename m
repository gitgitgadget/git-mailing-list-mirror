Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A96BA33
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023555; cv=none; b=UpH5ueRE+6Ihn+sicTTRVv5G5ddNLhQyCs4Z3xltf+0APrJ3Z7wTPosrjZ3SHhOXR/qWM4Jwtaot7vGTpf88I19hNQIDJgSR1dp2uXDRAUOn7ZKw+sZbge4dFqwhs1dXqJ019Kg5lDbBCaC7/oFUef9a4lg/8Lnz3St9t8q4Z/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023555; c=relaxed/simple;
	bh=sL6cLlp0qCOm3gz/6UgONc3eP3aFZ0Ax78YoiBPnd+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y8N06RhAjNwKLtyigN6TYQeOvN3JmrhQV/h/xS3u76awpSL09z/KHmoetIqm7p45s/cbMT3WIsbFJmk4SnFFtJc4B2C+0pm1alk/n3mCTzl2GEo08n7zDHpLpnTERlUu67e2NjOv4cbQhMyPNfufNOzZzbE8BQlPWzSFGD0OMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ea8OqiZr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ea8OqiZr"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so14165436a91.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738023554; x=1738628354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MLS6F2JhyFTcyx9hLtjX6V7cimjJMFhQptIdN5aZzs=;
        b=Ea8OqiZr8Kbbf441sdH/Bj5KcLLCYFD+rVWnAomZoHUQ/1+kwEThjQJV5HJ8iljjRk
         maFQR2kBEaOeAXn0GUmfSu2ATsUptD0Fkbs8G4G9XpCqh73q3m6BcnjpkY9+F+bpvGq/
         g7/mnd0Oi8Au2hZIKX6TWK1wFktanmrQmGFJ1dTcwG7VaMpvY2V8DMgTOyW6fHj566Fx
         Yyao7GFLz5x3t+tdteTAsxuF+aLAnG7t7xr2NyhIbXvwjqNFn6cBlBNWgJid/OEMhOMC
         6Na6PRr/2UqXuryDqKi/PGomlaD4gmNkGSETAFD0wXUht8u3U1e9/ZOQ2Zjh72n4s51L
         elwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738023554; x=1738628354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MLS6F2JhyFTcyx9hLtjX6V7cimjJMFhQptIdN5aZzs=;
        b=ZQPz1fGgzLzpxtMkGNgTruCZ82m2v37Mhqb1qFsQFSMFT2WZiM2w5Xgzg+ubFKOG1z
         BnIvL6HUVNzsWL6dCDw/375T80Tnwh3jgwqKT4klCG7cM5joOGkHx+hdpoVD6Pe7axGJ
         pPdQvtf6OhuveB6l/1m0X4j1/Sp7k4KZipv5muEEaycleNTh8uFzplIvvGweikxvbNi2
         zlhWbiTPZN/p4V3h8sTGVMKEwKVtH9Ec2ARCCT1nHDjZf8x2oTuLVw6upYgY/3OW2N/2
         RzOCPMYo816D6H6QUqVAS8DqM9JgYsjNwWM3sk2Qn6+Jd3KBWCRm0AlDg60SEjo2toX0
         4t0g==
X-Gm-Message-State: AOJu0YyGriHjKSXXub5c28qvsVihkapgdwjQJobbj54SowqqSfsHwDdB
	IJMmb5DMaKN3BYRWyagz8LPrpH4ETHVmcrudaeGJZmQwR+JDiVVWY1FG2A97WZSoyzWDawnPrPc
	GwGOZ03LQFTBkDn8iYQQrBglhbLQFK4yDYowj4hbfTko32vdqz9x1SmlJwSYUkx1h1S8TzUhueg
	Rd40TWFUF496jOLBN5ZLq2kkz1C+FOK/vwXwLbyaY=
X-Google-Smtp-Source: AGHT+IH1DNYdCklmT5/KihdKFw/9sveIIiUQ5xS1X8qPC3QyoB0s8m7JI837QdlwKor54CSawJJlEhALtIoJMg==
X-Received: from pjwx5.prod.google.com ([2002:a17:90a:c2c5:b0:2f5:4762:e778])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c888:b0:2f6:f32e:90ac with SMTP id 98e67ed59e1d1-2f782c90095mr65016909a91.11.1738023553678;
 Mon, 27 Jan 2025 16:19:13 -0800 (PST)
Date: Mon, 27 Jan 2025 16:19:04 -0800
In-Reply-To: <cover.1738023208.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1738023208.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <d67d3648d1bdb7dde5e475f3a8eba834cc0ea891.1738023208.git.steadmon@google.com>
Subject: [PATCH v7 3/4] libgit-sys: also export some config_set functions
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
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
 contrib/libgit-sys/public_symbol_export.c | 29 +++++++++++++++++++++
 contrib/libgit-sys/public_symbol_export.h | 10 ++++++++
 contrib/libgit-sys/src/lib.rs             | 31 ++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
index cd1602206e..a0297cb1a5 100644
--- a/contrib/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -4,11 +4,40 @@
  */
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "contrib/libgit-sys/public_symbol_export.h"
 #include "version.h"
 
 #pragma GCC visibility push(default)
 
+struct libgit_config_set *libgit_configset_alloc(void)
+{
+	struct config_set *cs = xmalloc(sizeof(struct config_set));
+	git_configset_init(cs);
+	return (struct libgit_config_set *) cs;
+}
+
+void libgit_configset_free(struct libgit_config_set *cs)
+{
+	git_configset_clear((struct config_set *) cs);
+	free((struct config_set *) cs);
+}
+
+int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
+{
+	return git_configset_add_file((struct config_set *) cs, filename);
+}
+
+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
+{
+	return git_configset_get_int((struct config_set *) cs, key, dest);
+}
+
+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
+{
+	return git_configset_get_string((struct config_set *) cs, key, dest);
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

