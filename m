Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C673514
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782900; cv=none; b=n/moXgMTdjtSIxgVcSSuMlAttk/6iXbbfQ+Gropff5X0aj3rFIjXUtXMAYKTVqfYHi7FSZ582gcNtqdR+pLKfHLxhFL49IGEuRtx47fVyHzsNTBkzCJMoiGDdY+Aci8ykTb2EoQ82GsZPX9DXHPxtzzF+B1U39vJ/3YsfFvX/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782900; c=relaxed/simple;
	bh=p5tQ+guEGQoep+FasFzMk4dHeNLSn6pyEA7QQmENpC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd3tABxz7/NV8QZHxaqIccizZ1W1RaAFzsokQy4feaxHkyzXVzzvXRZTivCyn765VbmCABjEXMl7T77BxEoU5wzoBwQbRys1xFtIAvkWI7HnIKX289MkIgd4GxlrZTuizEw6jP7xhccayuTB5/1NyLZgGQa32NboMbqCjYMzRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh0HzM17; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh0HzM17"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so4550556a12.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718782897; x=1719387697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBFZcvivzkBzB6T/hEWONlZZbiEiAS/ZvCiBrpj1U6o=;
        b=Dh0HzM179j30PusBvfRXpoNvuCoukPjK2F70jZyBpNutVVi72feLMFmWRa5jehE/br
         Y2lTx4/qQnSbKdfSaMSBGWp4wcL1lhO3acxVLhHXehbMuM1TWqYy6m7t1TdfTt9/jhFT
         mYcpzXHkD7J00/oFN27P16wYz/zqMd2QfmR4WNYGbcGR9eQRMBi/pEGZIVde2dD5kCnP
         j5VdHYsfKPRSi0MqnxcTCRl2lAW3Be41EysiJTISN+gjN6wAMans6KqfN+HnLHfrdaty
         9Mn9xDuSWXj2zmGOSwXfPnmDIVpUFwZNfKniBkdKqpfVj6irzWeAsHgXdSEQQauPQ7ay
         creg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782897; x=1719387697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBFZcvivzkBzB6T/hEWONlZZbiEiAS/ZvCiBrpj1U6o=;
        b=n3sJayPpgfEOJzlx41oLHZGR4BjXhYTbXWPfohTGHRnhgPGiTJBckIXm1Ktbf5vny9
         7ua3+AfBuxnQITLBC3uAibZ4Vm+pcs6ZO6ae9imIFPirduDTe2V9HIMzYLK2hqfktXFh
         14/P5dEhi8MW3yQXk4Oi2BF3FdC3vJcWf7w2AIKtcXBUnU9Q8APnTE26w8IXNmZL0cc5
         O6dWQaWlzxVvHd8W/3f93dATlIejYGm4Y+PlBwvOoxQEg0lpiWL0kiU9C+7Nh2aOAC6m
         zXa0Q9eB3Zz+MnBu1jdv/vr45O/G2aLBLJtCHEHiOfayqMVjfZRljWI0vx26FYgDyBUs
         sXeg==
X-Gm-Message-State: AOJu0YyNmMrA1MZg5HewrGuiVyb/fUKGZa8VWxMa9OcivbArf+mRxdxU
	UddOMs7dXwiiYFHA81yWfJfkWgn4rDyCFmtfzXrbYy9M6VMvBHj9ofW6fg==
X-Google-Smtp-Source: AGHT+IHsXGtbWZs8rEywzFmMTLWTwI2D8hOdmoatIVOXroIe/ema8wfkiF61+4gDlVe+iPjiYb5HxA==
X-Received: by 2002:a05:6a20:12cf:b0:1b4:3f96:f1d8 with SMTP id adf61e73a8af0-1bcbb385db8mr2003385637.13.1718782896721;
        Wed, 19 Jun 2024 00:41:36 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f07c5fsm109922435ad.206.2024.06.19.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:41:36 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:41:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v4 2/7] refs: set up ref consistency check
 infrastructure
Message-ID: <ZnKLr-H_HI-I-7xo@ArchLinux>
References: <ZnKKy52QFO2UhqM6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKKy52QFO2UhqM6@ArchLinux>

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
index 0c1e45f5a9..cb3b8ec36a 100644
--- a/refs.c
+++ b/refs.c
@@ -316,6 +316,11 @@ int check_refname_format(const char *refname, int flags)
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
index 756039a051..93fa23c7ee 100644
--- a/refs.h
+++ b/refs.h
@@ -3,6 +3,7 @@
 
 #include "commit.h"
 
+struct fsck_options;
 struct object_id;
 struct ref_store;
 struct repository;
@@ -547,6 +548,13 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
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
index 4519b46171..ba9e57d1e9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3405,6 +3405,17 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
@@ -3431,5 +3442,7 @@ struct ref_storage_be refs_be_files = {
 	.reflog_exists = files_reflog_exists,
 	.create_reflog = files_create_reflog,
 	.delete_reflog = files_delete_reflog,
-	.reflog_expire = files_reflog_expire
+	.reflog_expire = files_reflog_expire,
+
+	.fsck = files_fsck,
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c4c1e36aa2..ad3e8fb1d1 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1733,6 +1733,12 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
@@ -1760,4 +1766,6 @@ struct ref_storage_be refs_be_packed = {
 	.create_reflog = NULL,
 	.delete_reflog = NULL,
 	.reflog_expire = NULL,
+
+	.fsck = packed_fsck,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index cbcb6f9c36..280acb7f9e 100644
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
index 3a75d63eb5..2b2630d47a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2281,6 +2281,12 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2308,4 +2314,6 @@ struct ref_storage_be refs_be_reftable = {
 	.create_reflog = reftable_be_create_reflog,
 	.delete_reflog = reftable_be_delete_reflog,
 	.reflog_expire = reftable_be_reflog_expire,
+
+	.fsck = reftable_be_fsck,
 };
-- 
2.45.2

