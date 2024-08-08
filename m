Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DA13D265
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116410; cv=none; b=kef/umRgFTd8nEH428Ahw14X7oOFe/43mMrZ7ebvr1c5RP8qzHUkr9hJVO7Zm+/4hGBWw6zxIJOG9LVh6YLXSCDp4rYGtpPuVA1v3k5AxedqmecfRGmVaZ/XzMKGN1WBa0kKM2G9+beoVjO+fvU0VPjVXTW66R03yvSA7A7grcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116410; c=relaxed/simple;
	bh=d0U+zfe5Q3f7g3/LK0qr2DuDHFPH6/t3E6P5vC5/Uks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsYIIvUsct8TepUQupF6n0XMaWXiikZDTSWwEMsJDYIO9iPYX9GcjLLly3Xlotwh256Bh1G61WlWNGNN6e+RxPCmBVdz+7taf9PRaBQVDJM0hMe7kMNyzFckYAjjH18MTn2Cljl1Y8DgAP2FCuKKTgbcT+Q8ZqesaE52i5+wPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKm66L9q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKm66L9q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc4fcbb131so6640325ad.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116408; x=1723721208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXSYuUIlc1sLEM0xmW8Sg4+1Dl1cviP9OhmRc0x8Q40=;
        b=FKm66L9qiR9WwEOCLMA6cC9b2o0TnWMg4Ld0f3FNvQOJqRFyfIiMK0pkSgKZeIhwXH
         r6bfQS+/USFadQRg8afbgBvuxp5dScHTdyU41+Cv55Y7OCF5MrhAf0HBDojr7X951iuP
         ci/d+fi0+ghC0CwQNpO31YTUdLnALCSkM+ulB45P8BgIw9P8NKyZnicy6boa37pIuQMM
         u5dx5+7/La4oVdEEDVD+I7mtaaNp71PSdqkxuOP2O7lK0KS2TFjnfwXHJkZtnak588iz
         skn+t1CC4oD/cLQ1q2CNvRQtPmI1behr28S1L+CfUI8s29s3r+GGsyaLPHkCh/cVj9OK
         kS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116408; x=1723721208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXSYuUIlc1sLEM0xmW8Sg4+1Dl1cviP9OhmRc0x8Q40=;
        b=qHTtjEDVezCy4U4cITsjGdp9XB7zjwYMJZGzuZFOq7MXMR/whfhpF26LMRRPu3HwWO
         f9ajRrKZ0bOmdBnUOdxQ5ofdJ4GY0QuiQyhLrmuGaWJ8b9EzXOh6mPvk8wYI0PNGdOT3
         0djH36/aneLUbqKXBdrFvNeDAkfy//t67FikTnH1UrNmvVQvv0+YNGErgvBgfC/af/75
         Irjh35uMhOjTFYexnftP1h8czApg36HbSdiAFFrF1VdSFjbeBBITcBo36AmdguKPCyc+
         piCS3/tQ7Pi7ALsEw1UdrhqFWVRaknr5rxGhio5P3mzCE+psfrbRzfvYuH6TVN6ETx4r
         F4eA==
X-Gm-Message-State: AOJu0YyAFm4QJ59udHtPsg7L2NVhYEBQTSrRsygBQITsUdGAiFnUHjNW
	OgjuLbyjbAwfQk2SEzArgrpOaXfwLvtlfQ2wrVEVZ5vXTeTBMcJLEL9PFd2uKpw=
X-Google-Smtp-Source: AGHT+IHhortMSyNNQo4HOq0cL/ejTZgD0SRAHvIWLNKVH6uWf7hHdQgqxrrH689CRR0DEupLIuN84g==
X-Received: by 2002:a17:903:120b:b0:1fc:3daa:52 with SMTP id d9443c01a7336-20095224ad2mr23045425ad.11.1723116408145;
        Thu, 08 Aug 2024 04:26:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b54bdsm121996675ad.293.2024.08.08.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:26:47 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:27:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 6/9] refs: set up ref consistency check
 infrastructure
Message-ID: <ZrSrlU8TesYsTb2C@ArchLinux>
References: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>

The "struct ref_store" is the base class which contains the "be" pointer
which provides backend-specific functions whose interfaces are defined
in the "ref_storage_be". We could reuse this polymorphism to define only
one interface. For every backend, we need to provide its own function
pointer.

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

Last, implement placeholder functions for each ref backends.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs.c                  |  5 +++++
 refs.h                  |  8 ++++++++
 refs/debug.c            | 11 +++++++++++
 refs/files-backend.c    | 13 ++++++++++++-
 refs/packed-backend.c   |  8 ++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c |  8 ++++++++
 7 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 915aeb4d1d..6f642dc681 100644
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
index b3e39bc257..405073621a 100644
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
index aa52d9be7c..4630eb1f80 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3408,6 +3408,15 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+static int files_fsck(struct ref_store *ref_store,
+		      struct fsck_options *o)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fsck");
+
+	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+}
+
 struct ref_storage_be refs_be_files = {
 	.name = "files",
 	.init = files_ref_store_init,
@@ -3434,5 +3443,7 @@ struct ref_storage_be refs_be_files = {
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
2.46.0

