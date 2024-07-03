Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556F1E869
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015131; cv=none; b=r+bLGbiifVkEBExnOTNdJQaTJVULEFkCmH5AfLHWcrN7zczvr99Jj2GrUHSZYkKEpEzfgmdgO4/WxCSyI3olJCLpPJofZ5OWcssbxVYWEt14AWAPVm27E6C6S+wXuIpKPFXOxzlGCCF99LBjULIRzOj+RfcBTCVK2rE1+Cw678A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015131; c=relaxed/simple;
	bh=S0bP3/AX3MX3DxFnCOPiXKJrLhQV20Me5gL9Jqq5Gbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa/9vPzim3hnwfoW+k5DCycoEySHw+6Nwt0GTfBqXDhOnL5xWjXe+CIjHkzTT9H51RO1AxaRdL4Y6tGInH8FawzHQzJCg4z8/lp9xuZ2ue7eQoVqslAxzI4bk9+o0fzpRZ0q4IkRZZrLmvd8glpPdOmQSDp/e7KRRNy///cbmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW5ewd4o; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW5ewd4o"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c98b22638bso118807a91.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015129; x=1720619929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=nW5ewd4ocJjkpT3KBdYCv0DLx6Um6gSEPBU3n4c40GLCJSTnwSgB66bxWUz7GE6rVq
         k0UmRP1la0lmOWNqMxj95l5pcs2bC2a9m/TCv4F2Nc6kZSBckJDcEGAnA7Ds5S9b4oAV
         0Mvrc3GlANdsNJ+SPx+sDfa1MnOqwJjxs32D7Ep3ApA8IflBluUTShGaGfucZHWCfRgI
         9zfORqeUmZs4iYZmr77ebf7TvyO0WTmQsnB+22LAEeJ0FdziYguLpJyAxNzhzsTObHVo
         pAQQzDfpxlnuLcv+Z+HFX0n6OzacKjh8UhWCdw0vGHHPP0XQf3tWVRO8TBJ+nz900Od8
         0rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015129; x=1720619929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=D2taEQA5tbkNkvWiACJ0rWF8cb/QWNFaN6wcsVMEL8YBNLM/b8vPi5daR2RA8QP9aO
         vC/2VTM4TuvG4oC3lk88JUfh6V0SAgNKYUGZ4PtdOp8jkF9sAPb5HBFxWJL1eL/tn659
         hRTs1Ri5BKE+nWEvuOTfTvJCl1YR8Z98Eu2l3PThUz1fn3PZQ4G2bBwmrIl392XRAHz8
         otjyWzjmlPm6FpAeN4bDHfQZxWPfkA89IKVjJr84xYjfeCo1g5pS2ObutjP42a3U/dF/
         x3KUD+85UNbIiqOsb7zV7AUDavFwux62xfFfkALYz0NKWsJJ6i5rajLWbdxv/YJe0/WM
         dOlg==
X-Gm-Message-State: AOJu0YyxcOs1ESwtPk6iXBBcU/aVZUxkV037VqmSZil3YWbulwm72bl6
	L1jPr6qOyFwRhoiMif44m1FFbYhibjfy2SQ3WsVuggvXvPHXnfs3xsV5wU6C
X-Google-Smtp-Source: AGHT+IGXNrGno+4w0I8P0EYqiymJKUIu2yOz9CAgtS3c8H+JAdovBtIv3Nfs3m8PT5frPCq41roE3Q==
X-Received: by 2002:a17:90a:e291:b0:2c9:648f:f0ef with SMTP id 98e67ed59e1d1-2c97acf5810mr2919588a91.9.1720015128629;
        Wed, 03 Jul 2024 06:58:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e7fe9sm10768155a91.50.2024.07.03.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:58:48 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:58:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 7/9] files-backend: add unified interface for refs
 scanning
Message-ID: <ZoVZF0h_5VGVyuNI@ArchLinux>
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

