Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7EB218D6D
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429585; cv=none; b=iD7nS24osdRMwScDNEimSOZOX7M6B7WTx2EmDgnNmR9OusDLFTak8UU6pWWE969AYSVEeC6ecW2cgxEYps1t7BkcmalqgD/qtiu94APtpAR03J/cmBRhzmh45jGEqrXt+5lDq0+vrlT2cLi0v725pehj27fg6BV7XMvkm2/AXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429585; c=relaxed/simple;
	bh=371viZo39DIJij06+wZWQOheOrWGSz4GDm8hhnCe6Pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R762H+bDhiOaSDCPsiNi7dOpamKvFbdMZSMBU+lZwgUIwAUdt+U7BFYouOC21YZ2YmZ8NBjv+BWqktpgKDKGYbaIENPrJepoNoTOQ1zGjGqd1qNcKfriQBoqAit6XjQ3UIx9+yuNlO9UaW/C1cqJFetTWGKFtPgua95atT+89nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLIDK4Ah; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLIDK4Ah"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso7132054276.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 16:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728429583; x=1729034383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sM0/PbO3TZdZCI1NlRavrtq6Qj6K0lzrH4VoZunlKfQ=;
        b=FLIDK4AhZAdSAv85PzYCYdQ1+4YCedNKjF2++sXbGy+j7fK6dGp+CxuWlbNIvlnU1n
         wO+WLzMsDHkcXC3ePQPEqv1XlxZeZOs5J5jEtgELu5JY2qjKUewsN6OlA730zbs0/N4z
         CG9ex6jCQmZnk8/YO8HgGvuC4LiYYDDLnxUNJ6eoEjhmHu+30BBW2CKsfTcfM9KnUOaW
         nCbRBj8qegp9CF7SHc9wpCcMF30bH5FzN0WQdPZ3JYJBrEywJdVB3FF1w6WU/sWpuFFc
         ZlCAls0hTxiA31bcCVNIQaNTHfZLw0X2wTJsgWAxorN3qy/OXERskYZYdOt6ydIUTL+1
         oLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429583; x=1729034383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM0/PbO3TZdZCI1NlRavrtq6Qj6K0lzrH4VoZunlKfQ=;
        b=UDAYHJsIrTcL4VCIErY8OjKgcyEc07q+imT5LwheY5AGgGtsbw0AO8nIxl6K0fp0ls
         j4DFddn5NQmR25yGyZU1nGhjqDMwYRlkePZG6qib1yWbEvZC60GAhhdLceXFvyYGFrCQ
         FDwixvG+y4YHQIcLBSAhtxRaxu83tRdnTiDPu12L1aycwp5CfbG7pg+T2i9W1Mt3T3qw
         WJHNc9qwKC0ynfnXhMFpJ2jtE/Mb4/WkoJXGX+S/D5vs5X/MhnpWpRfFl8uGR3mr42BE
         BUTvkjwFvi6RF3nM6nvbKAoqAE614Ilus4W/brqolwXo+6M/kRdKxEMInxdzWJXgIOVO
         ODQg==
X-Gm-Message-State: AOJu0YxGkDmOBmUR6geiTVU6esdR74CqHL+ZdTLD5I1BaLWmLVd5YKwq
	lttUWpQVmwKuqHj8DyUMBteFUWmN4FSWslZ86tOZGzJxdQ57RcBDle25qUn4QJn7fBqr2hcRja9
	bN49G6EsZmj7rTI5mCnFto1n/4cQ+/tSMTfjtS3Xa1uj2omcgCTSOp2Junk7HyV7vCLzjscXZDk
	et54u1OlEAmISriOQESxh98/wo4pu4ztkPHKsaMZk=
X-Google-Smtp-Source: AGHT+IHuaZPSf4xi7hYkSk4hVM0h3mDExmM033KagOWVaRz0pGhiqwwUdYNXhQC1IGyvnGgZueno+8pdTb5/ZQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:7c00:8752:4498:cc1b])
 (user=steadmon job=sendgmr) by 2002:a25:51c1:0:b0:e28:ee8e:ed9 with SMTP id
 3f1490d57ef6-e28fe3205fbmr716276.0.1728429582742; Tue, 08 Oct 2024 16:19:42
 -0700 (PDT)
Date: Tue,  8 Oct 2024 16:19:33 -0700
In-Reply-To: <cover.1728429158.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1728429158.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <8eeab7b418b99d34a575a293cfac7bdea1e60102.1728429158.git.steadmon@google.com>
Subject: [PATCH v4 3/5] libgit-sys: also export some config_set functions
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, ps@pks.im, sunshine@sunshineco.com, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
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
 .../libgit-sys/public_symbol_export.c         | 29 +++++++++++++++++
 .../libgit-sys/public_symbol_export.h         | 10 ++++++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 31 ++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
index 8e4b94d821..29e8a5363e 100644
--- a/contrib/libgit-rs/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
@@ -3,11 +3,40 @@
 // avoids conflicts with other libraries such as libgit2.
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
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
diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.h b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
index a3372f93fa..701db92d53 100644
--- a/contrib/libgit-rs/libgit-sys/public_symbol_export.h
+++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.h
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
diff --git a/contrib/libgit-rs/libgit-sys/src/lib.rs b/contrib/libgit-rs/libgit-sys/src/lib.rs
index d4853f3074..dadb4e5f40 100644
--- a/contrib/libgit-rs/libgit-sys/src/lib.rs
+++ b/contrib/libgit-rs/libgit-sys/src/lib.rs
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
2.47.0.rc0.187.ge670bccf7e-goog

