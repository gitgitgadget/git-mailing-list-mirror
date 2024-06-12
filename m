Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52516D4DE
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182456; cv=none; b=lhclmzpjaGkNqMxIsrAPbQrFyrMhhkuTVtci8bmGK+jJVQ2cZ3cUGW50IwgEwT8zDvK6PqE21NcLUnBkKQotqRW6GOaLSHsC1YXYdQqDZd6/ktvW7/WAgOTv2Cnw4h3jK495kNbgs60P0NASorgETGw8q6F14Zz72idZUHWIKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182456; c=relaxed/simple;
	bh=GeM1so+jqF0PEfqMJA5GfVxBAyCKoK4hViYPnZVMLJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMomqcLz6FWMJHpXlheTidxyeSwGLkzi8kOzzP02bjd/iI/ruVSsXSwQJXM9OtSnRjUSyHOsNWFROWNK95JDJC6i6/auDszgResEl/U7BBOFiaohbZdMlFDy6bWvTbJSiBD8E99q1k3JWxSNVuCcrvHcQUnnguRUOFM+aQ+WF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKZ4xcxi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKZ4xcxi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f70509b811so25406165ad.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182452; x=1718787252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waBbTMwh1Mg0f6uQ7T7X5z4S4xZWlD4xYL5ehF5enUE=;
        b=mKZ4xcxiK9CdQeUdXJnDcDKzHfYsI4xqgyCPt5tJMDK3AEUFFD9FvmDmyX0CnH6OA0
         6cwih79mmFNaU5PALfhpI9vHHjzoANIbSQaXHLTc5nFmu81SHxU36/XfmwNVmkuyAunC
         OlMU36RlXOiqm2qe0B68nu+nonSCVlDqNqdDxIwhRpTvCaAKdxFLjht6ET574hMuvptR
         yITN++D0PHr7TFxzbZOiKNINz2ode2loprtj4yTrP1UiqymIJE3T2FCkg9DPgFSH6ZK8
         v47m7haAeoJOaeMidgLPYodvbrEAkXS1t2vNVYnEYlw/vKw9aeURewhlpEENGYgPOjxr
         n6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182452; x=1718787252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waBbTMwh1Mg0f6uQ7T7X5z4S4xZWlD4xYL5ehF5enUE=;
        b=ljEHKY6hTXBwUe5nXq+UvhAxFhiiFE26YRmpR0rYoiGVAItpsOo5UznIf7ZEVbP+hy
         HSs5MWeoT6RIDIi3CU+vvEjQZCtTlzXKVy1tVi8i8H/uv+fSW+E5iYoSY2sfJCns4UC4
         pjX8G5GdDllPW6FEj2M1YIBjb7WqqQ1fQSx2sfp0wLH7JW4CyHLHtWBw4m5h2fNnTuh+
         4N5Vaf/9DctgoJdPtlxE7KMTlaa6d7D14cHYFySpQ8uYouwgo82yVGKV0JO95rT2Rj1m
         9XhXE4/1XirMDRwmwmVFW0SozZb74A/y4lCP7nl/idnJAkvk27lGu2+ajIku7HJ8hnYl
         Ss2Q==
X-Gm-Message-State: AOJu0YymVlqzKwCD+w1b6CZ7z9YGIBAUX7wX3wnN2b9vRUqj8cbhuOjT
	cvLizWTUmuckxmKNBhsIdePuYvl52QBR6ZnOM5mAy4bE5P0t/xO7ZnbLJVT4
X-Google-Smtp-Source: AGHT+IGANwqzh3aqSSSeGwU7l8Vh+M7y7QjrzeD6P2kvgDtzr1WAGiexArqWbWCmrbxIozL33+ydgg==
X-Received: by 2002:a17:902:ecc8:b0:1f4:a3a1:a7e5 with SMTP id d9443c01a7336-1f83b566b3dmr13652585ad.13.1718182452380;
        Wed, 12 Jun 2024 01:54:12 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:11 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 2/7] refs: set up ref consistency check infrastructure
Date: Wed, 12 Jun 2024 16:53:44 +0800
Message-ID: <20240612085349.710785-3-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 refs/debug.c            |  9 +++++++++
 refs/files-backend.c    | 15 ++++++++++++++-
 refs/packed-backend.c   |  8 ++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c |  8 ++++++++
 7 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f7c7765d23..0922439275 100644
--- a/refs.c
+++ b/refs.c
@@ -316,6 +316,11 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o)
+{
+	return refs->be->fsck(refs, o);
+}
+
 void sanitize_refname_component(const char *refname, struct strbuf *out)
 {
 	if (check_or_sanitize_refname(refname, REFNAME_ALLOW_ONELEVEL, out))
diff --git a/refs.h b/refs.h
index 76d25df4de..5a042695f5 100644
--- a/refs.h
+++ b/refs.h
@@ -3,6 +3,7 @@
 
 #include "commit.h"
 
+struct fsck_refs_options;
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
+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o);
+
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
  * is acceptable, and place the result in "out".
diff --git a/refs/debug.c b/refs/debug.c
index 547d9245b9..110a264522 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -419,6 +419,13 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return res;
 }
 
+static int debug_fsck(struct ref_store *ref_store,
+		      struct fsck_refs_options *o)
+{
+	trace_printf_key(&trace_refs, "fsck\n");
+	return 0;
+}
+
 struct ref_storage_be refs_be_debug = {
 	.name = "debug",
 	.init = NULL,
@@ -451,4 +458,6 @@ struct ref_storage_be refs_be_debug = {
 	.create_reflog = debug_create_reflog,
 	.delete_reflog = debug_delete_reflog,
 	.reflog_expire = debug_reflog_expire,
+
+	.fsck = debug_fsck,
 };
diff --git a/refs/files-backend.c b/refs/files-backend.c
index cb752d32b6..e965345ad8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3402,6 +3402,17 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+static int files_fsck(struct ref_store *ref_store,
+		      struct fsck_refs_options *o)
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
@@ -3428,5 +3439,7 @@ struct ref_storage_be refs_be_files = {
 	.reflog_exists = files_reflog_exists,
 	.create_reflog = files_create_reflog,
 	.delete_reflog = files_delete_reflog,
-	.reflog_expire = files_reflog_expire
+	.reflog_expire = files_reflog_expire,
+
+	.fsck = files_fsck,
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c4c1e36aa2..db152053f8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1733,6 +1733,12 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck(struct ref_store *ref_store,
+		       struct fsck_refs_options *o)
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
index cbcb6f9c36..8f42f21e77 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "iterator.h"
 
+struct fsck_refs_options;
 struct ref_transaction;
 
 /*
@@ -650,6 +651,9 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
 typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refname,
 				 struct strbuf *referent);
 
+typedef int fsck_fn(struct ref_store *ref_store,
+		    struct fsck_refs_options *o);
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
index e555be4671..7f606faa9e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2242,6 +2242,12 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_fsck(struct ref_store *ref_store,
+			    struct fsck_refs_options *o)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_reftable = {
 	.name = "reftable",
 	.init = reftable_be_init,
@@ -2269,4 +2275,6 @@ struct ref_storage_be refs_be_reftable = {
 	.create_reflog = reftable_be_create_reflog,
 	.delete_reflog = reftable_be_delete_reflog,
 	.reflog_expire = reftable_be_reflog_expire,
+
+	.fsck = reftable_be_fsck,
 };
-- 
2.45.2

