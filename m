Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E3016132E
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847233; cv=none; b=rCA4PUD2jFqXuRRmUhV9eTDOJADBYg0oJSG1ve/NqZmDMHYnY1WzbacoErCvmmhOEJfrMeAhSY86RYkJOkaKALzYqOqOJEZ9HkKVXhNrYsxneKmuvqhxouHoMBBdQJRHmdsytG6u7+nKK4MuKXW0XmZSkVt6O64XjwucpL5Zygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847233; c=relaxed/simple;
	bh=q1jCNftq4YTPKr5sLAfTsKnpyXKs0d3GZMiEyFdxMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFRZ0GRgsFnC2zi7KvSxuQHaWsStux1wvJvU+Ley9HFqm538rwY+UzQtl4aRkzoh1iilUD51nppD3F3VIq4ysY/AEWJGBbvSu70yaWrmEJMrZk3Wnw4luLbo8V6B5ZSkUC6dDd/5NEQvCeHKOM5+nrsJR8tiVqCLCXp3bVOdqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNqTQpJf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNqTQpJf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso17253255ad.1
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847229; x=1720452029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pVT582GTNgvgnQMaIjHrnyoLGIiXPzJZByiO0e5MAk=;
        b=BNqTQpJfPriiXBfeJivVq/QhheRowiNcjygHYFX5pmSAKvgyu/myIubXecfOYhY8kL
         Cdl5UXWUD2t3MFpQdd9RD91zyluGh7DpCGc/fRPsii0aZaNQd6p5HquBVWRfg6pT+v0z
         /RfXTI6ZUIPQqdgv564wYq+Q7GO0SYznLYqNISU96YuFdfWVTvtdhb+RRuCBDz4q2DcM
         rTHbTeAjDy7ihi+loSu1JIvEr15lXwhyTnaG7i7OBOvp9LOz07ixhSXpnNej/gmUYbJP
         DnUhcx6TE8ZtdkDnb904n5oWSmhrLuX+Z7lgLC1cMd8WogCKFfvrm9QNLqhofduMXZEo
         pU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847229; x=1720452029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pVT582GTNgvgnQMaIjHrnyoLGIiXPzJZByiO0e5MAk=;
        b=H6QrzrnxzDb+kIUlAxG4fzGcWALpLIudZ5UuLFRy9g+pQPu9j58objR7nl+Bxd5Tk1
         67uLuzT/q6WbMuMadnFWMEOAa4mM2e8qyeidgC3DH5ctbtPTdSQ12cX15O/gHmE6W73p
         fZfPmrkZ2bFZfhInndfyvy9WUKMQ62pGL2MVh7AYEW1VLoZsCfX3z/Nmff7o8+funq7A
         XijRY5uKjfH/9fHvam+18KvkN9pwx5OxYvsHujZdg5ulBpk0pdtTbWqSNBb2DCn/wSDD
         ecvYJliPYr1gMKHEojmzN7/tCbGtAEDjQ5wzy31Qt4wKmya77usEQt1tgC1ZAxVp14Ow
         6JFw==
X-Gm-Message-State: AOJu0Yz7f3lz2aZX9TBwtuaEKcHr8Q6gXSuAGXJsBWecWEgd6ZuNghSq
	xTAg1+9fXh2ec8kdXfObYfuuPamKYp4uybuYpItd9mVChQZbNo6dtWnxvA==
X-Google-Smtp-Source: AGHT+IH+qqnc8e68kdNguzQp1S7y4QMTZLuzfsSymdpVpZ13D7qXA0px3FPZid6BX7hCMDB5VOWRuw==
X-Received: by 2002:a17:902:e885:b0:1fa:8f64:8afd with SMTP id d9443c01a7336-1fadbc73cadmr34787495ad.11.1719847229501;
        Mon, 01 Jul 2024 08:20:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b6esm65789155ad.156.2024.07.01.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:20:29 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:20:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 06/11] refs: set up ref consistency check
 infrastructure
Message-ID: <ZoLJOmBjzKSq9L56@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

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
index dd0d9c360f..5f17de38e2 100644
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
index df8cbf6124..946e929af9 100644
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
index 44c5c3b201..817813e723 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3406,6 +3406,17 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
@@ -3432,5 +3443,7 @@ struct ref_storage_be refs_be_files = {
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
index 7d872a32ac..7f07de8d45 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2292,6 +2292,12 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2319,4 +2325,6 @@ struct ref_storage_be refs_be_reftable = {
 	.create_reflog = reftable_be_create_reflog,
 	.delete_reflog = reftable_be_delete_reflog,
 	.reflog_expire = reftable_be_reflog_expire,
+
+	.fsck = reftable_be_fsck,
 };
-- 
2.45.2

