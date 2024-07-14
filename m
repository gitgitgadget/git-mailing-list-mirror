Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3E1FDD
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960343; cv=none; b=ZZY+T+QmuMht/+htPJ+RnJpNqBZELcD0qJpF58mMIN5G/gcELIX2DWtzD3PtpHEROj78macDxETB7Bj4rrqCG+PcNa/J3vRHCGAM/WDnMWG8vVCJhAsvIiu9EYOHUW00mchrW/i53DXqBjIvfoR6dr+KIp+14CmjLscLK7HO28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960343; c=relaxed/simple;
	bh=74LojJWDbW9OcMNx9RyPKjMV5xMTrr3rTVDU9xheogw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwKzcV/mqVtR/mZt0r2svK8n+Hlti82ctJidM0R3tQ3/R/kJUlrIxw/Pxj+mIIXX/wkRJaVC8I9k/S4FUS5XmeDBU4g4Ol1LN/CX/6ZmHR9nbNQ4oTzyOZbfuqusgQvOCChXqEMEJfFevqe6yadRQD/jEjW5aZQeUSpr15jEDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SECrwK2m; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SECrwK2m"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so2628295b3a.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960341; x=1721565141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OS2CkskgLXdpVTeUgcsIyFkMp5SUUYLcibIkpuXSC38=;
        b=SECrwK2mu+450IU1Y0vMrK7dPjmPuD1udDyrgyH5amTaaFuCU3ubXYwlLihxkngjH1
         T+8pJmfoAWcFmjxEKvkr7g/iO+O4Lt2J4CbnFmUE4ugDaiI3StC9nbkocH6XlzARFWzi
         cj3DyM9alEvgbXKh8fox5IDmijmjt2IqsLChzMZ/AHbRbrHpXfeqR2gOJhNx+BueNQSg
         Y/sVkERqRB9fK/I8T+AXZYh2TG4Aze7yuhxmyvFTRP1bOKg+aShy15GiG9qW7SwgVtgr
         dSHRBvybPSYPL3iXyARZmlOyuQEV6krI/OuV+UwB/yhrQfwVODoUimuiM6IXnF1AubaW
         5ZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960341; x=1721565141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS2CkskgLXdpVTeUgcsIyFkMp5SUUYLcibIkpuXSC38=;
        b=AcDU24/n88XyyxfbJMraCho2ohR/x1zQhbpJ7BSbgwlCItW9AXHkIlpfLA04c5aUwn
         JKzPkVyNGS5yyc4ki0Bk8y6pmjLLPmBn57mSd75VU4k/8V4hm+T/rZpKEGdpwgw8GIB5
         J0IPE+aVgZdGCIdFAMCbFXKZ6OyW1njzRIhrdMrBBgvE8T99rWeXaC+LPQJ6HlHZfYwS
         QacFXy24QqT39OFPJwyOH+KkjizxqJFNaxpZUdJgsEGNICP5ToLI83MqHWk4K2lgGDJ7
         nF0UvmzapDu5EectyBkyeQ+Ul4Q4YsMedhTP4m+PSbkMqMk2bWRMs0MbrIVvTaYOXZIF
         e6wA==
X-Gm-Message-State: AOJu0YxBia9UiHLVvGzGRQXhAJ3pBsbi5FIUK4ertQc0o0NJvNMF9fz5
	V+jaioTY6hbGWu1qGiV9CfsO1Bvk3N4YOqgYut1Dk7QXfc5AUKAhep2CJw==
X-Google-Smtp-Source: AGHT+IH4lbuBVsbV7S3AKZPZjY+ByqRS+mXH+kEpICS24LA8PTPdH6GvQgZlOQEIKPKZHbUcHHuO3g==
X-Received: by 2002:a05:6a21:2d04:b0:1c2:a55d:88bd with SMTP id adf61e73a8af0-1c2a55d8b5cmr13753133637.53.1720960340671;
        Sun, 14 Jul 2024 05:32:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0ee8ad03sm22228815ad.246.2024.07.14.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:32:20 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:32:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 08/10] files-backend: add unified interface for
 refs scanning
Message-ID: <ZpPFWB4XtLqoHIx9@ArchLinux>
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

For refs and reflogs, we need to scan its corresponding directories to
check every regular file or symbolic link which shares the same pattern.
Introduce a unified interface for scanning directories for
files-backend.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 77 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d89eeda8ef..794e9f3f2e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -6,6 +6,7 @@
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
+#include "../fsck.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
@@ -3408,6 +3409,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+/*
+ * For refs and reflogs, they share a unified interface when scanning
+ * the whole directory. This function is used as the callback for each
+ * regular file or symlink in the directory.
+ */
+typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
+				  const char *gitdir,
+				  const char *refs_check_dir,
+				  struct dir_iterator *iter);
+
+static int files_fsck_refs_dir(struct ref_store *ref_store,
+			       struct fsck_options *o,
+			       const char *refs_check_dir,
+			       files_fsck_refs_fn *fsck_refs_fns)
+{
+	const char *gitdir = ref_store->gitdir;
+	struct strbuf sb = STRBUF_INIT;
+	struct dir_iterator *iter;
+	int iter_status;
+	int ret = 0;
+
+	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
+
+	iter = dir_iterator_begin(sb.buf, 0);
+
+	if (!iter) {
+		ret = error_errno("cannot open directory %s", sb.buf);
+		goto out;
+	}
+
+	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
+		if (S_ISDIR(iter->st.st_mode)) {
+			continue;
+		} else if (S_ISREG(iter->st.st_mode) ||
+			   S_ISLNK(iter->st.st_mode)) {
+			if (o->verbose)
+				fprintf_ln(stderr, "Checking %s/%s",
+					   refs_check_dir, iter->relative_path);
+			for (size_t i = 0; fsck_refs_fns[i]; i++) {
+				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
+					ret = -1;
+			}
+		} else {
+			ret = error(_("unexpected file type for '%s'"),
+				    iter->basename);
+		}
+	}
+
+	if (iter_status != ITER_DONE)
+		ret = error(_("failed to iterate over '%s'"), sb.buf);
+
+out:
+	strbuf_release(&sb);
+	return ret;
+}
+
+static int files_fsck_refs(struct ref_store *ref_store,
+			   struct fsck_options *o)
+{
+	int ret;
+	files_fsck_refs_fn fsck_refs_fns[]= {
+		NULL
+	};
+
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking references consistency");
+
+	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
+
+	return ret;
+}
+
 static int files_fsck(struct ref_store *ref_store,
 		      struct fsck_options *o)
 {
@@ -3415,7 +3488,9 @@ static int files_fsck(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o)
+	    | files_fsck_refs(ref_store, o);
+
 	return ret;
 }
 
-- 
2.45.2

