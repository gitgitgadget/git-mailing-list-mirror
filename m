Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7013A272
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698639; cv=none; b=rmAqugrF1KtUo5iiUA8sDPNtxmwppaPwLsSSpgthkWMp1GwWIlM5X7XKbhyT3nU4uRrUwH4RPQn4g1GMiTF8nn5PfCMcGzZ8lp3//5QTzCH1U8k4lNq5y+MD/7Ne48eBN79LXnglpM38YCobH3y4vSYIFQqagHa9Cet6Cg8Tt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698639; c=relaxed/simple;
	bh=FV1qqajHxuokfFNRlMRf+k3VTIm+yI4O8f2E8J45+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qauZMuJAA7yafmBz91XHj8bryLKTvZi892DVoMR9rvULSma+VG6DrgYJ4TILqCeKSgREh6eZ0EOAZ23LMe+PPpRoKtLPKx1wy4eGts0xvv60tx7wrptgM9Jcm9ns11iGKAZzai8cYBcgMv9OhbDOPAELo27Ha3cD0jk1ta9P8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFqCwHW1; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFqCwHW1"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6fd622e5d2dso741729a34.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698636; x=1719303436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2alQISuMYm5DSDex6yRGz99dfafhJTvtDrtP+0cRwe8=;
        b=aFqCwHW1edu7cEp3AhgOKMOvxnErXXr24BbAbZo6KziCezIXXcKraauAVW0AvTuQGr
         FPvsAD5ctdCwPCAI9D/VVWArrSXfds8HH7o3bLohr8SGAZHhdwmEV+0ejJm3tEUtxMh3
         sj0LIfHPqFscTDNl0gNvJxtY1TkWK+ah0Ztbei2YgUDftfOC9XPwdf8aTodTjzF53a8x
         ZmQ2+dzPQg1vSEkmgjF++JD1fwjjxsS/gSqpStFJAu0ZqJeOjAJ4BaXliqKkiQSPt/up
         hlFkAeZOkMZ4LfDKdngtbg8I6Yb69zjYy9BbV9/aaLL3VruGc2y+6I9pa3c3HQZRQNzU
         pOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698636; x=1719303436;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2alQISuMYm5DSDex6yRGz99dfafhJTvtDrtP+0cRwe8=;
        b=KchXiTt+8yekbrOJy/jyqH1Jp4brc0lg6ubQgGDffUMF73Vwbushv9yi7iIiXi4nHU
         gJNv20Z/3RBefV7twVAf21ZrBym8W9THSyxCJHLd5vhTY5o42ttCfNAn4sEydlmlyXWd
         +2DKAVI3Fc3Cc6DitiGdJvDoz7mDjaR4jrSP8T7e0tw6gQkszhHtThw3Fp+O8W49kk9z
         aoy3ahJFG1peh8q5xcfoVeQ2eKObSJ0kWTpYzouy3xXW+GUXcfyp5sABqcV67WkXkPad
         RfmdNAhZ8NZ+31sERJL7VDXNh2LcQaKuzUA++4KXV3gHuVvu/5zn1MejdH+WQcODRlGF
         IaWw==
X-Gm-Message-State: AOJu0YxQYqHbenC73zAQQoZRS5+S4lgt2wIFg+FbuW1S+CbCDv2qOc1Z
	8ZOpot9YV3C9xgzisIQb3fOIdX7aOq8P4wMWsPX1+6aPbBfUbhu2bLVQDQ==
X-Google-Smtp-Source: AGHT+IEx6Z9KhKn84DneSqwOqeJqyIlmfiCnV64096SFhq+GBhuxOcyDWsFo7++TNzim7FDQtHtwMw==
X-Received: by 2002:a05:6870:c142:b0:258:3455:4b02 with SMTP id 586e51a60fabf-25842c0f99fmr13440635fac.51.1718698635629;
        Tue, 18 Jun 2024 01:17:15 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91db4csm8792943b3a.18.2024.06.18.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:17:15 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:17:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/7] refs: set up ref consistency check infrastructure
Message-ID: <ZnFCiYrvAypGLtcC@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

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
index 547d9245b9..6306c25fd3 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -419,6 +419,15 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return res;
 }
 
+static int debug_fsck(struct ref_store *ref_store,
+		      struct fsck_refs_options *o)
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

