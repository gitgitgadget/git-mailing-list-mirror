Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5613A272
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698742; cv=none; b=qzz7MTU80d/FwWRnj9ZkvTTg2BzfC7e7bwecgygZQBsfGcJphpInPSqQ1Cup7RpW9h3P7CAhSvqcDc7ovPxwv3oXVjlLvEJEhVbl53dBoFfbZ6gHg+rmFCYZ00W0Huiwzy943DX7Vo1KdBM2VIPqoAYDrJnflbrYrEI/8FSL5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698742; c=relaxed/simple;
	bh=n+j28WuJ2N/H9rzpi+gmvg8/na+kVKl38/rTINfjSLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZiOoUuvWox32hPi54JrCSMqAklrMcSTVwbrRs0urs1uahBNjCuVh1iwIz5AERDRDAyBjjWgc69kKFiG8FFJIwIk3nhxa/DBSjCc6YTl+N7Av0R95QF/sp193jgm4NrCDzwpxTZ0K9biM5hNkE8g7CzW3Ey+k93cs2ImBpiUifjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIpWuGYV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIpWuGYV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f70fdc9644so46158405ad.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698740; x=1719303540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6sK2wAsAML3jnjt1M0D2YLTXcpOUzs9cY4C/BrcwDQ=;
        b=nIpWuGYVL5/jIiDDdWRq75CSD1K60EMhxui+n+Invb8AD7vfeFK/hVr/wrsGc7qXIt
         AEajuYhF8GokE35OBopI3Sad6/so7aSd/9F+hmsshQRJrMaeI9Nm5RSFB7HckG7ifB1/
         T6z/WUAPu3/U9laJmmwL2+JYK2Cain9j0sDmSzSrcOMCsz9f2JAjL0J8o1iNEmDRI1pG
         n6tkglef5O+q+5ih1ijRZQTzp9l/AHnOz91ltIAp4sOHTdiNuw6gxyrdeUBFBz/h6FfW
         ozsGAKCPELqce+De9L8kk3WDVuTINpUqFAx2Div6Vu+HaQ2dBqbu1TkbkbRJFI3O7T6t
         mtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698740; x=1719303540;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6sK2wAsAML3jnjt1M0D2YLTXcpOUzs9cY4C/BrcwDQ=;
        b=C+f24Uga8TfTW6sfUyNLzYuVaRns60zMa8ysg7PujI7IOzrVBbWKMTICIGpBORJojy
         ADzEzkPPcX4mJQqnnEzH4+xGwR3lnEyD/Bsn4rftBHXXJJkdsTDFIRfQiKVTmYlRGNAj
         BoIXrSYQvwPBU1Mv3iaI+ZX5HzB+yvT/Vi7O1xYILIGKvqRzrOP812s8DxQTjuoQzIr3
         RNldVaPzQRF7QC7z4pKQ6IjJNrI7xJ3if5MncvIblOcIx3TMsAxV4i1wvRrJk/lO9Qms
         2MNNOPUWXGmgVogpuvJKAFJw+LhGY9L5f5yi46r+sdlwIs/Pf/780SNH8Lnh8yK7Pf9T
         jCBQ==
X-Gm-Message-State: AOJu0YyXp4vQhbuY36hdgXAzpLqyvhhhH1oC5yrK50zQ7xh9jnklQRBM
	axv9A54kv1XQB/AwyKcUfdPaP16rou4WgvHs2iXYD62SKlzNdyibZyx5qA==
X-Google-Smtp-Source: AGHT+IGs3ec84dvSRz6u1QaDAK1GUD+xtKy2aXF7ZEXRixHC//qwVKxb7YKC1IziJYNTuYe6pagNJg==
X-Received: by 2002:a17:902:c942:b0:1f9:9ea4:6b5b with SMTP id d9443c01a7336-1f99ea46ecdmr5016235ad.3.1718698740144;
        Tue, 18 Jun 2024 01:19:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ea5sm91672215ad.20.2024.06.18.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:18:59 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:18:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 5/7] files-backend: add unified interface for refs scanning
Message-ID: <ZnFC8YgcfYhhYb2V@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

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
index e965345ad8..74242dbba4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4,6 +4,7 @@
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
+#include "../fsck.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
@@ -3402,6 +3403,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+/*
+ * For refs and reflogs, they share a unified interface when scanning
+ * the whole directory. This function is used as the callback for each
+ * regular file or symlink in the directory.
+ */
+typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
+				  const char *gitdir,
+				  const char *refs_check_dir,
+				  struct dir_iterator *iter);
+
+static int files_fsck_refs_dir(struct ref_store *ref_store,
+			       struct fsck_refs_options *o,
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
+			   struct fsck_refs_options *o)
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
 		      struct fsck_refs_options *o)
 {
@@ -3409,7 +3482,9 @@ static int files_fsck(struct ref_store *ref_store,
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

