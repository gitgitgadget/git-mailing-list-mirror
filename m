Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF880BEC
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445795; cv=none; b=sOuixfp2vK/8YCaFWW9eRFQ4b2166akq6Z5m5BhYof5/jt76IIyW0RebSfORJAmAwgU9Y2didRZy9d5kZH2L/ciHTheAVpqgdFcL96sO5pix1J5yMEbtJY+iu0J7ZfHvF2CGm2q/cemzx2CvyCWs7bLrI00L0rBWCH6TJx30Jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445795; c=relaxed/simple;
	bh=S0bP3/AX3MX3DxFnCOPiXKJrLhQV20Me5gL9Jqq5Gbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWJRfTi5L5L0QgnqwdD8BaPgfVPqkEqo/eo2vE9Da41BLnj+QqjOxxcXMsX/EeTn0ohwz8rRZ1Mjq7qKxWwHRFA2KlmzpcVEbKI7CGJMqPkzfaW0BvZtfi+AuXQMeEzm24NSB47RXTRL7woCuvFVcTqirfxUPaHPPI6y+I42HHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8t8CMhb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8t8CMhb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb3037b47dso23247895ad.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445793; x=1721050593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=N8t8CMhbmHs65Qedtg4998NC6IIQHZ0BRlhntM0g4FDHG9QXi47113jTIb9xfa6JVO
         O5EwjmsFgJ7R91sjN+tt0aTCFZR8d3N17c4KogafG6qwidC0nhyZT/0rREC/Z7JnTIwe
         7jlnCN5XeUGwnTBL1Hpu0oBLTJPtgmG6HZ9DE7x5CZkKZxyFUaK4DRXiuO4ul+sP1nPs
         u9j5/X9KM9Gc1Qqc8L67Syb3s8eXLkddASw6ANfuKIO047NoSM0Y5zYA0MX154SKkhaQ
         b7tUubZXc0QYew9CcGK5y7s3Jdr3scCkMoiiZRL7zlHvjRNH0hWG2ok5/1CkIQKWgBk2
         mQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445793; x=1721050593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=p92ZwDM6ymlWc3baunmzG55uYIQGeWDddDE761TlWUv5QdZ3NQgCJDajtvj5fJSJD9
         GDOByJ/hcgQc1Zc2XUoIbfjHEhKfnaVhqCMg5T4gUxqllg6kRnOdUnKrujZ4TX3SVLQK
         2U1TZ8kJWBhx1KNnR4qB/2Ftjnz7yvwyW7d4wRDML9yrAR7YHn+ABD9t/RofMcN6iPwX
         Keglcoh9QHLKdZYdTOpI0AI0ugxF/z3LMsTvmHCfx9EFrCycZJ6dx7fGFOMFR6Ea+g36
         rWkLW3D16CjkRchF7y2qh9wrAz78O0u1knvoZoho3II32O9IPrFpZdTq3DjzIi+TFXIo
         ISTA==
X-Gm-Message-State: AOJu0YwJTXWKrjQ65fN+LA+tr+pQOo3WQsi0fSz329bGzoRUpqEa5lev
	r5xpEE6Wt4tbx8PB5G9kyLKJuGlnOUbhwaa8SPBhhwkZkwv3/iapvtHh2kXW
X-Google-Smtp-Source: AGHT+IEJvAbCiKTlLxOxAbjgM4nSkl3cNLfuAPXhdeMLHRYXVWYC7U7hnMjWRcQBdctJ2iEZ9WgQ/g==
X-Received: by 2002:a17:902:e841:b0:1fb:6b94:66ee with SMTP id d9443c01a7336-1fb6b946931mr25954615ad.26.1720445792744;
        Mon, 08 Jul 2024 06:36:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb5dddf37esm45939485ad.55.2024.07.08.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:36:32 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:36:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v8 7/9] files-backend: add unified interface for refs
 scanning
Message-ID: <ZovrX-YWae1Iy7D2@ArchLinux>
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
index d89eeda8ef..84acb58782 100644
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
+			if (o->verbose_refs)
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
+	if (o->verbose_refs)
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

