Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0E1D63E0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032668; cv=none; b=bdTxfxuzSn6wWqizLzK+Q702vQUdnVbLDjLQ74kdNKCpqtGIl6/Tf6mERJ+IoM9QHIbyyiY9o8fAEDF7sT/jc3FoiU77Kv7z1X54ukC2lkfGKeFWEIRdNZ+/oFFKrA51jRlZNn2Zfo6irNGL4TRU+pEZWSuzb6uJB1t4BvG0UPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032668; c=relaxed/simple;
	bh=ah+bGRBJF+407D7sNvycueUsnORlo3FFfRSnyRXISF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Po26aZ9lDJh9jNLA6U6eMpGo/4ZkaQBWyuJB3qbRox+qedK6T2CzMXlBftKLiUd6ZGqnFP/dzwQI4QMM8ytjxKgKuyJj74Waui5RtebFOz2MCT0UXr8hqQ0WEzi5UDectNYjko8aF8N7AfAnXYNJ9TVEhq8FSawSjiJYPrN938k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IILMcqQf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IILMcqQf"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35bdb6a31so68334097b3.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729032665; x=1729637465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mV63ka8xhQp3EHnR9vAoeu/+XItWOBDIaE0cjtAql+I=;
        b=IILMcqQfyJQorDfPZy4RaJJOR+RSz7DvinZ5vbLW/MKB+YgMCT+IMobMyjtwcJItaG
         OA25qUhr5BKO9XtIGCrXqV1sCMvE1OhTLaUhPOXAYMU8SWhmvRC8Q7MAoDx43Tzhf5vA
         NBO8B1Xi2ECk97klPTkhXgmgX1xtAgoMoeEgdfKQmqI7xrkDrBRKM7ABTaDH3uPHZubg
         d8BZsmEVxVBLBEJfQB+/b4EsRm0QsJSIR7wFPYDzOmC6e0HHoqekpdpBLCRaQWP0WRuF
         MODC6PkNJRllfFk8PPsBYO1x3tyqnd8beCNSboA+RRBUretCmBB/Iar0pwNaOHwAhcgP
         JSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032665; x=1729637465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV63ka8xhQp3EHnR9vAoeu/+XItWOBDIaE0cjtAql+I=;
        b=qajapRRa5HecWsoT/fbKi+aUZwkZ3yBgKb5IohPGVeHmqEkjNWntJmbpBgIjhb4Wpf
         p5il19eFk3MlItp5O8VGXQGtgYN7y3IFKjSF5KpUvK0ZMtZiQvpSWTlab3QRzH1YwT49
         dY7N8uYVLoSrIeIynjmV9hseHMnqONlGnxbJwc89yInMKwZDVA90u7WD13bhKhh3pwN6
         yga3uSEfr5w5VNV6wwTRJwBLZU6xfuzJEwUFMp99ne7OlZyrx9vFZKFNGLUbJiY16rCt
         otBMig+jQAqtI7YKEWt3F7RrczmF7+FVKxfoZqtD7FwEFOi4XfTIr7zO5gluwRdjUCLJ
         u03Q==
X-Gm-Message-State: AOJu0YwJ2Rfyfvl/sbtxuVuon7/B3T92QUNoQkVwRQUW0v5BbzpaL/YJ
	qlZf01+mdDz26lnoK+UERYT9HLe+XWjZBJJFrdHGkQ1vuK0IrVuuLuX7kdu8uW7MsQrumwKyXcE
	1pw3LZcTH8ZvD7ajR0tf9B0RhiJtHTMkZ6Rcrvz40P41U/OvwGTuh0n7IoDci8udY8c/0V5/Zjx
	UY/vDTEyVttovhzNQfruOHmZBkpzFMCHRMh6wY1jk=
X-Google-Smtp-Source: AGHT+IFtiZ7PpuymWas9hdPODfz8i0+02Oxp1/RSMWkxiJz0tuRVtIxu8oahsSFN/33rht0HNFGW+QkisCuxCA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:ddcc:6d3c:e4d6:3076])
 (user=steadmon job=sendgmr) by 2002:a25:b227:0:b0:e29:7473:3566 with SMTP id
 3f1490d57ef6-e29786aa478mr864276.11.1729032664692; Tue, 15 Oct 2024 15:51:04
 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:50:55 -0700
In-Reply-To: <cover.1729032373.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1729032373.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <00762b57d032ddb80fb47ef277a164a46f1fc10f.1729032373.git.steadmon@google.com>
Subject: [PATCH v5 3/5] libgit-sys: also export some config_set functions
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, emrass@google.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com, 
	rsbecker@nexbridge.com
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
2.47.0.rc1.288.g06298d1525-goog

