Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29A1D90AC
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971555; cv=none; b=RV817KtSYtlCwuugdi+MQWHvBzfo9vMoWb2jlr07q9IjhVSR0v7N5CELAqiCR/q+nNQM+B486rPCJWm9hjxLyA5OR95Ts2oElojZpwe23jq5nOReMGkCMcPRUxNOECOOXUuQ3rNKKCfzD5vexmCDNpvOqjx5cLCir7TIZ5QDIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971555; c=relaxed/simple;
	bh=QUara2RCrlV5RBdycoZ9Rc4EIVzU4MmDCGXWLXRjl7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Layqrjsvu9Gbjx2+L2AATJ0rfBC4ioLsO7aZgou+at6e6hzQ5s5vjACxUpBDOx+J0wQ20ZkiY3RqaK+4kPDq1XkHhXY1v86GqOHHfbtiE+hdQ/O6oeiKOqTwkEfjfnTYvswVRqkrrv4mXudmQsOcl6u+e6Fl0Zjdng1wVS5/qe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjgaAYTN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjgaAYTN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so1242805ad.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736971553; x=1737576353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpt9H0neNvl8rmSiM1Q8p/j2QcPblK/XxzKQSDJ9OHk=;
        b=QjgaAYTNiIDe0/KJsDxQ3SqaMoFXIcXiqfwqAr+CASi+X8pl9gm1f946Q+1D+HvzML
         7fxDbUyUF0YeWER+BsSj7dUR1fT3e8t+oynEcfaqH2njPOY/sFmKm6f07OC/yM8gw2xE
         tKPMm/hmBW2m+RqMVtqE5A8AG5qMkKZobA0cFj4N7pXY7RNpUcAvXYHDXgBDsm9LmYOy
         j8V8E3vHDI4ntOHG2EOJCTAO76C2J8dO8OCY8o9AxLR4secOE8C6InocmibmmtG62npg
         c0A8aWMsu8GD/MkUyVkHezgDQ3ZClcfBiO+Ezm9CclBntNZgDZkIz5AEwg1Exata6pIb
         uj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971553; x=1737576353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpt9H0neNvl8rmSiM1Q8p/j2QcPblK/XxzKQSDJ9OHk=;
        b=UEa30XFKClYJs0/sXr1hc8kc9KI5nZHLcvEl150HUl2ONRFDKPxlL6eOnrnBu4b6zx
         WdO/SlhCzSJUYjUZ9KiRg9j2YwMrZGnNRJ5NVI1sciMOU1MY3iQQxNIZLlSKcSuQoiPk
         scZz3Xn+4N+tAZ4Ch15oelvQ6sMriyAXBTpdPr4lG63oN7KDmnKAbJUG7Lt9VrKnwuc7
         uP2wktDw4zx+IQK0mgt2tU9bjB3gItlEh+tDnzPveJvEp+ZuGSPQmkYz2YYqsOHZzdsD
         jjOY1zyxVZZ7sHHdEvFH58pgrW9UjMUCOat0REzcZyQ5B0Sr8iIPgTs8xhUK0l0xrKTy
         6aLA==
X-Gm-Message-State: AOJu0YwEPfeCpVq6zaIUbTBkvrWhuU6+jJB7Pw9paIJao0f8+q6m9avn
	WTrYltTmIft3MFXaKJDM8hqRJ4EHtxmgNH2xnLqZHyDlsFlPQ+AnQXJ5U/3ynemB7dafhDjGGsq
	g38zQv03TsNcW+rqzfyg4TMammEPkf4KFwmFxVSfy0NRE21U5t50CdKT7Cc/rozfyLFwXI41wap
	KRk3pN7UQPjhDXNFIW6LgmY3MW3gDGuXrm0lR18UU=
X-Google-Smtp-Source: AGHT+IGEK2+k8R3AVS+xJMSIkEbVGZGOlLKGCty/Mr/AaHHeBa6wRvYP9faikYC4pU+Y9Orq1qIpJPcU6O98GQ==
X-Received: from pgbbw32.prod.google.com ([2002:a05:6a02:4a0:b0:7fd:51fe:a923])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d81a:b0:1e3:e6f3:6372 with SMTP id adf61e73a8af0-1e88d132ef8mr48768743637.27.1736971552779;
 Wed, 15 Jan 2025 12:05:52 -0800 (PST)
Date: Wed, 15 Jan 2025 12:05:42 -0800
In-Reply-To: <cover.1736971328.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1736971328.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <03f39b6c3ae8a36b3cedaa76d592af00491be1da.1736971328.git.steadmon@google.com>
Subject: [PATCH v6 3/5] libgit-sys: also export some config_set functions
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
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
index 7cd5007902..1799fc6fde 100644
--- a/contrib/libgit-sys/public_symbol_export.c
+++ b/contrib/libgit-sys/public_symbol_export.c
@@ -3,11 +3,40 @@
 // avoids conflicts with other libraries such as libgit2.
 
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
2.48.0.rc2.279.g1de40edade-goog

