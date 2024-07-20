Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408541B86FD
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467725; cv=none; b=WXLbmcSi4abDqDcjurnWdQrhgC5lAHIOUDiVT4NbPLQd+0jwZwZXU5y8+zdYWZ2klv7Bj6+hWioh1u67LUdvdhtWCqyJVjOrSs/h93WA1LGcC/sCI6m3Mv6Qxl1Zo8RuYAgjZ0nOFXQmpvIYOK+Nu5Jsn82OQjj1KK9c2UtbnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467725; c=relaxed/simple;
	bh=74LojJWDbW9OcMNx9RyPKjMV5xMTrr3rTVDU9xheogw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHg14NHCEszK0TzmKHElNvr1yXUBrqQ4M6M4ZtvwQTl7GjFL3yRr8f0C4xbSx8dlKICf19KtTkJ6+jyBNzoZtM2lmgj1N+mN1kCLpGqqYAKcn2kaAydbgYMDVITC8d4roQswYRrb+xPmWe85xkKhlK8gT9YFVK3vRGqh1SezGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khWu6mGL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khWu6mGL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d150e8153so49410b3a.0
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467723; x=1722072523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OS2CkskgLXdpVTeUgcsIyFkMp5SUUYLcibIkpuXSC38=;
        b=khWu6mGLZ3U556B1JxB/AYU+EvRi69WYiFba1ifM6rZzw4t0HnAdOYf5SHnHUYyhOU
         qdguT2sB4VG/bPdQi1fTjRcUdm4qdCSvV8uTKE5XAQpsKP55jrbXsSSii+DCBg92Wr1c
         duVFvTWH7Q4X3UK7spbuc8VBoWHzb3nkB6x2qfPp+0MYiYSOG9uXR9jFH3ROndYIbE/P
         cXiyZRcGeUa5xe+wwTdiDbv04NTdXZA0/ECnR2lrvJOOqduQCMXBSeIBINxFG2/kYR0e
         0bxE1lCN53476CfCWiMg4LSLzsbXjIMiPImz6mNsEOMMO8Lll/IK8EhAbOhtfZ3Qv+Xw
         EzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467723; x=1722072523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS2CkskgLXdpVTeUgcsIyFkMp5SUUYLcibIkpuXSC38=;
        b=C6KUcwbc0FfNsY1OdkGtMLEmU6iyyGeOWXF2iAhqEnt0yiNEOOGnlet6XJEzNASr7J
         q8z1AowRCepVcTCXiH5R2qkqg7BB+uY6pTWX8UUx60vZe9EVIjmXGy8R/Van01jIgTAI
         vSiBv2iCQ819OYhgjB3ZlqHmeALPCTMEHxloe4dCLl9QwFm/8uX5LVCsOAh4njtSmOHD
         4Wm5ZsFPNCkQUumQd2M7c4LbZa2DSMXVtpaS9mahb+eh+Wa0LDg46JI2J8RVVvl5Qrc7
         2FDbLCy8Icp8laNtAPyEUFjvshVP31j8mn2dInTbJQH98MREg/Sa9QIkNsc0T6wNHTDZ
         0sYQ==
X-Gm-Message-State: AOJu0Ywp1ih2bMaTW6PVa5elt/5090gfYqW8t8Sd8vmRcw/nfxeZpTcM
	BzANPL1v2ONq87CLvhNBCxzvQN7EOn+NVWiVEwhOztjyb8ThBCWakFw0xg==
X-Google-Smtp-Source: AGHT+IHbu06Y/gzZg1/ZRYe1dODw4Ox2lm2d2PFb80Zj3xYeKq/O+rmZvYePShI606OxX6zRcrRi/A==
X-Received: by 2002:aa7:8e05:0:b0:70c:e1ec:4233 with SMTP id d2e1a72fcca58-70cfd4e83d9mr6578014b3a.6.1721467722627;
        Sat, 20 Jul 2024 02:28:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b2e31sm2349190b3a.78.2024.07.20.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:28:42 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:28:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 08/10] files-backend: add unified interface for
 refs scanning
Message-ID: <ZpuDVc_DAM0DRMFQ@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpuCg1GL1YE_sJBP@ArchLinux>

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

