Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0699F17A599
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015074; cv=none; b=IZkwEPc460lpEkGyavhyN0afpS2KaMOiCjpPuGoUAhUWk0NvUzjs36h0fOEshguDiQmzl6hFz4W4zu5CKuTvxItlndV4PjElCC03EM9uI+gqEQgHHdOHBDe9f71v0GE0Dx6jc9P7RZFZxwzDomDYEf9bw5XeU3DJfXLCXS6T4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015074; c=relaxed/simple;
	bh=UrDMzI/fDR/GyLZnZt8IH1yAlAowxGIlDTM2eXKL51A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9hiP70EFkRqfW0sfOSTjulfQgJ74fE+SWeCKU6t1Pntxq46FnuTTkuaRAo/tN8uTDIUmf01pvArF8UgkuK3jyKO+sdAvetvV5aAy0kvSl/8gdsGsuj/PtV7ZdtoEQnLnh5rLlTk5PtvLyjA+UXqHL0JqBU0XyufH6pTmMuPKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsvofsiM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsvofsiM"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af4868d3dso268578b3a.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015072; x=1720619872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRS82vf6Xog1qs7YecMOL10IUWpS6A53mOBHrDZUGGM=;
        b=HsvofsiMZ0O3ihdmXZ+NWYhXrwjkhiZa6DFOXz3VZ1ORWMCcprMk/jKQNhgHRXCgjP
         pvF4TWIA+sPnHkBEn4KavsDoJ/XdBZcE42LyGIw9lWS9ntNZPrVb2JTh0UZWnbhtvDWl
         uAPQWxSoz73WbU+eBOqwj75sAQX+8LJY0zp6M2m2uChd+IsejqWGhFSC7TRXByShnjs9
         jXpsQVsC/No6346vRwS1XYY+CEIuXyq9//h/hG2xec80J+eI7pvQ8kXMwjpkWB4XOCmt
         jYkeFFpFk3IKGpIHSBApVXUY5BSr0rCbubrfTSrc1sQ8at88Ch/bQYZXd2V+FigHUdYk
         pWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015072; x=1720619872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRS82vf6Xog1qs7YecMOL10IUWpS6A53mOBHrDZUGGM=;
        b=ptCr5RGrQ5Yx03xhCbK5xwX2OBg7z++Wq9hfelucpmdXu3pLXdlow93mUV4Tq6NO16
         90HbJVrSVGl765D6lso+rXR2pvNI4yYVtPi12viEsG7dhjU9rUilavEjf4Jz9vDR0yNh
         PVmcHpNqKw5C/KE5qShI1Bf7E2tzwQY53RGJcEXylEBZfPOiL/UD0TCIPjT/agDtiHSF
         DNo6HLRjLT3G+/g/rTUOzlb2PUIXkrp2RoXv3NTkSCTgdE0yaOtZ6q+bF1b3BSqiASt1
         ndMv3mXdt2KLmMsM0TvPxDNxyTIFOkexWWiWVoISTbDUlw+9KKW/olSSQugDI+k3xyqt
         x2/g==
X-Gm-Message-State: AOJu0YxBSajqQ872hHTIs7ZjgiqxjVACPtbl+bYFGRJ8wjcDKD58yneR
	0FD9jcg1Uv4TpXgr9+reJGHLb3ntNoL3/lcV48rO7mSRb3bXhGIZUERR2KOd
X-Google-Smtp-Source: AGHT+IHzm3RUn7qewT6ZevdLWmvidfNTxaLVCR8dDYFR05FcWaIaDmpwowZ/s8+8JAfmHjORuaw4Bg==
X-Received: by 2002:a05:6a20:d510:b0:1bf:5ca2:a9b6 with SMTP id adf61e73a8af0-1bf5ca2ac18mr8036987637.50.1720015071406;
        Wed, 03 Jul 2024 06:57:51 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c8ec50csm7725756a12.59.2024.07.03.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:57:50 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:57:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 4/9] refs: set up ref consistency check
 infrastructure
Message-ID: <ZoVY31KvLduy25iX@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

The interfaces defined in the `ref_storage_be` are carefully structured
in semantic. It's organized as the five parts:

1. The name and the initialization interfaces.
2. The ref transaction interfaces.
3. The ref internal interfaces (pack, rename and copy).
4. The ref filesystem interfaces.
5. The reflog related interfaces.

To keep consistent with the git-fsck(1), add a new interface named
"fsck_refs_fn" to the end of "ref_storage_be". This semantic cannot be
grouped into any above five categories. Explicitly add blank line to
make it different from others.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs.c                  |  5 +++++
 refs.h                  |  8 ++++++++
 refs/debug.c            | 11 +++++++++++
 refs/files-backend.c    | 15 ++++++++++++++-
 refs/packed-backend.c   |  8 ++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c |  8 ++++++++
 7 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index bb90a18875..410919246b 100644
--- a/refs.c
+++ b/refs.c
@@ -318,6 +318,11 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck(struct ref_store *refs, struct fsck_options *o)
+{
+	return refs->be->fsck(refs, o);
+}
+
 void sanitize_refname_component(const char *refname, struct strbuf *out)
 {
 	if (check_or_sanitize_refname(refname, REFNAME_ALLOW_ONELEVEL, out))
diff --git a/refs.h b/refs.h
index 0ecba21b4a..804d6a7fce 100644
--- a/refs.h
+++ b/refs.h
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "repository.h"
 
+struct fsck_options;
 struct object_id;
 struct ref_store;
 struct strbuf;
@@ -541,6 +542,13 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
  */
 int check_refname_format(const char *refname, int flags);
 
+/*
+ * Check the reference database for consistency. Return 0 if refs and
+ * reflogs are consistent, and non-zero otherwise. The errors will be
+ * written to stderr.
+ */
+int refs_fsck(struct ref_store *refs, struct fsck_options *o);
+
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
  * is acceptable, and place the result in "out".
diff --git a/refs/debug.c b/refs/debug.c
index 547d9245b9..45e2e784a0 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -419,6 +419,15 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return res;
 }
 
+static int debug_fsck(struct ref_store *ref_store,
+		      struct fsck_options *o)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->fsck(drefs->refs, o);
+	trace_printf_key(&trace_refs, "fsck: %d\n", res);
+	return res;
+}
+
 struct ref_storage_be refs_be_debug = {
 	.name = "debug",
 	.init = NULL,
@@ -451,4 +460,6 @@ struct ref_storage_be refs_be_debug = {
 	.create_reflog = debug_create_reflog,
 	.delete_reflog = debug_delete_reflog,
 	.reflog_expire = debug_reflog_expire,
+
+	.fsck = debug_fsck,
 };
diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa52d9be7c..d89eeda8ef 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3408,6 +3408,17 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+static int files_fsck(struct ref_store *ref_store,
+		      struct fsck_options *o)
+{
+	int ret;
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fsck");
+
+	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	return ret;
+}
+
 struct ref_storage_be refs_be_files = {
 	.name = "files",
 	.init = files_ref_store_init,
@@ -3434,5 +3445,7 @@ struct ref_storage_be refs_be_files = {
 	.reflog_exists = files_reflog_exists,
 	.create_reflog = files_create_reflog,
 	.delete_reflog = files_delete_reflog,
-	.reflog_expire = files_reflog_expire
+	.reflog_expire = files_reflog_expire,
+
+	.fsck = files_fsck,
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a0666407cd..5209b0b212 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1735,6 +1735,12 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck(struct ref_store *ref_store,
+		       struct fsck_options *o)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_packed = {
 	.name = "packed",
 	.init = packed_ref_store_init,
@@ -1762,4 +1768,6 @@ struct ref_storage_be refs_be_packed = {
 	.create_reflog = NULL,
 	.delete_reflog = NULL,
 	.reflog_expire = NULL,
+
+	.fsck = packed_fsck,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa975d69aa..a905e187cd 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "iterator.h"
 
+struct fsck_options;
 struct ref_transaction;
 
 /*
@@ -650,6 +651,9 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
 typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refname,
 				 struct strbuf *referent);
 
+typedef int fsck_fn(struct ref_store *ref_store,
+		    struct fsck_options *o);
+
 struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
@@ -677,6 +681,8 @@ struct ref_storage_be {
 	create_reflog_fn *create_reflog;
 	delete_reflog_fn *delete_reflog;
 	reflog_expire_fn *reflog_expire;
+
+	fsck_fn *fsck;
 };
 
 extern struct ref_storage_be refs_be_files;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index fbe74c239d..b5a1a526df 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2303,6 +2303,12 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_fsck(struct ref_store *ref_store,
+			    struct fsck_options *o)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_reftable = {
 	.name = "reftable",
 	.init = reftable_be_init,
@@ -2330,4 +2336,6 @@ struct ref_storage_be refs_be_reftable = {
 	.create_reflog = reftable_be_create_reflog,
 	.delete_reflog = reftable_be_delete_reflog,
 	.reflog_expire = reftable_be_reflog_expire,
+
+	.fsck = reftable_be_fsck,
 };
-- 
2.45.2

