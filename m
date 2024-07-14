Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F41FDD
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960305; cv=none; b=WwzRGtE8dOQA4IFhaVgMt1Exa4TnAIl61shMJhhL1PxyQXrywb+/3OxiXGEiNzG+GXAO2/goS/BiZZeNjUHLGG16hDVj6rRw9E6khuHYobgj7TwlwIZE7dwOmY9vX9d6Dwy3A8CyF26pQUlrE50NDDKWbouBxiFbAAdqJyEmUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960305; c=relaxed/simple;
	bh=Xaf9riBzozmCKz1H0udrYwbdPauR82bQALqKOtzPJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHIxf2/Iv7Cv/LoMvhvZegjvFRwHyL1NBgdGZChExjzsElu7dG7bL6Gk0eaPxGGhuplz5/iTLzFHjioON6FT2zKRNyiRXcXZ8M/Y977sf4Cs1tbc3+VxjI1ZstT1fsbV+XxCD4Y/ZpeM8d6R+8CZZ0wksBMIQIy94tsADaY51sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAFTxNZu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAFTxNZu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb8781ef1bso25486335ad.3
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960303; x=1721565103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=laa4K3fMvS0I93jB3AnHiR4n7++3zAPc3WP2RAf/kko=;
        b=hAFTxNZu/W04NOEjNQ+hGePZN+t3KBmjO1hQ+O+6W5eE+8eK/NBcKieyY4iFEqloA0
         Hv3sXyPcAPcxgQl6lw1u/QYUnCdBVEwatxW16TtI7SuN6fDnPIif6qVoPsIGoh1Xg6/c
         fhl6xKvO0aE8bEEf4AiD/wGTpycGhxygoZd6vP9OnFGd62JrNVm9b3CWzxYQb1n6mGjD
         FdaCyBOa6Ylw3iGn6LBiR4POKvPgCa4VTMkwPTUyjiogXUdr3GvsXIpSKacE6hPq4D+B
         H2vTS6Gz91JsCOIbaNMF75D4bP0jHORKZuHXZj+4P1vvzKJXLPi7ic9nB3rOz+e15brR
         dZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960303; x=1721565103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laa4K3fMvS0I93jB3AnHiR4n7++3zAPc3WP2RAf/kko=;
        b=ue1vKIyxJf4wtRB6s0+UTC0YuNI82OS/MU6DditQUbIMAdSS3Mgp6SxA2wemymGGO8
         7iBXZnl8EDf8HWB+RBRk4ojRHFSo/gZ0hxgpHbNMYDGQFuJ/XSM06rgwpwjy8n9mh/ca
         3vpU2GSaOLAkgX/w8Z2KczIAQErZLWTbVNXVW84ObyUWpBf7iSdh5x9waDy6XSlh7O9c
         TuUGfoGrCFu8nYCiym3yDYPTz1eeNo2TDsdW+hGd4ROVENwxMElP41cymDl9N1GYkUFt
         Olk/SeDj+CthYivTI+CCzYDMYdX4BGWaWZ5bD1vwfA9JyQ5+XWBQ/Nzx++i8rxjyYHiq
         fYkQ==
X-Gm-Message-State: AOJu0Yzt2RoY3Bhbq1KCdbo4yfk+wPk2HMIHt09sxayNgs+3PfyKD3zE
	KJ5hG2UlpUYo1l3hDIHXww/KLQm7pChzNO7Y2MAmkCBL1tHnK7wShKmWEg==
X-Google-Smtp-Source: AGHT+IFzUhKpp1eaNFGeCwBv/6jajAn52EsUHKJSmR20BQMEVLn/sS6YPcrgIo6B8khy7F9D4gNWxA==
X-Received: by 2002:a17:902:ea0f:b0:1fb:5f82:6a53 with SMTP id d9443c01a7336-1fbb6ea44e0mr121339655ad.43.1720960302739;
        Sun, 14 Jul 2024 05:31:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2712csm23095625ad.176.2024.07.14.05.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:31:42 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:31:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 05/10] refs: set up ref consistency check
 infrastructure
Message-ID: <ZpPFM8nqzHUxYkCe@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpPEdmUN1Z5tqbK3@ArchLinux>

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

