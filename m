Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322116B74C
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847293; cv=none; b=Ln4VQ3Mf+eebirrqV87XTw3NWlcEFi+nPPHKfsxOgptVBzgEBZ8xKrgwp+wwuc2BZc67ujCCOpRTtjRZteErxUDqVuQMmLUgHu4MU5MYlgtwJcrWbZ7SMrqqyK46HyY0YSHGOvhm9t7ZGgpVAHeZBk82jxeglLIfwEkGSPkKSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847293; c=relaxed/simple;
	bh=H8bBaD/r5g0bhNAZPhyLDYGLSqu4f8FUd6DfqlOnvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFyx2NkM1M27mFmfeFrWyakL1ZUblKGXUQrYODTzQJvJSSW/IY9R+gP1FSJrkVgeXGliO0XxgNtu8LYZLJLWRGsbM+37+OnZfK1AU/4eIyY84hRRfF0bBBsG3+MEmXSFj6feEH3jdTQwkZsoyVfxtoF46uOAjR60FhKZNij5MgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EysWk4dK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EysWk4dK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so1717466b3a.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847291; x=1720452091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc2x0qPO2Bx2OyST5S83PSXATgDjPMUKdU5k8F+AbBY=;
        b=EysWk4dKAqjpeM/IsC5S40jDWiH0aRhTr/9lnWcnh0V86zA3j6qUA4Xtk7dpL63LxZ
         VK4uRrer5n1ViAMZ44l5/h8E4YRDd+zRe0+S0kef2YzZi/S23GwzT0qhbK/7/s2sn4sS
         3vHwH8P2CTZd+3SJNKlOeEnT9TMS48hjnFi6g0kvvYTlx/yGzQ+vrqOd1GEhjzrpzoIl
         i7k1e+I+QcfQJLXAPJbXVDbzWZFfG9YEYAXLxpi2IwJ750gs1YVD6bjCBizh8lrDivmM
         tMgspAzZfl1UfnSoDSQ/yL8Bpzcv0T8z2/KzrxypsjYs6E+ufiD1kjFDaw8mmMUxXr7K
         LssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847291; x=1720452091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc2x0qPO2Bx2OyST5S83PSXATgDjPMUKdU5k8F+AbBY=;
        b=okaSGphsIWPnYQtJYyWSlI53U1x7pfW1LepDsJShgLo/VxmmxEtPNfjX3BiwPfaO1A
         zAS4ozRrhaE48Zz3s7wrJiz6xjVYHHXmXlQyjayPBpkSOFMQfDo9nXbQ9ixpVhyoXKk8
         TKsLYFUnUWr66P7gQWir0xNoAAqahLQ+MyoxJSbjm/TFVsrJ+TZntQu9PFQN6K8z9dJA
         bn+g6X9sMmsbhQf4abvzsbc9ij0nM+MKKy2EFlZnzgD+8kWYb0S3BpTBYp+2iuAry88v
         UhoQqP4qGqLGtpKsmySzKn+8lxHrrywaTQyLn6iaXrf1aWwN0hNXYmuPX42iOvCM4Px/
         VEsA==
X-Gm-Message-State: AOJu0YziSMtXpp4CUtOeXhwBHR+jVLWAzE2qlVTdvGlN8t9sy93bHJf1
	6w3Deyy2WfXb8OstTqCza/NIFAp+pE5Pj3osjgruodtNPMj+7/Q+0qmOQQ==
X-Google-Smtp-Source: AGHT+IHHIVw/jNOVoUeDyTSep8/rE4cw/Ua2+QE/letwea+7rCdQbH3MOjytWYl0UtjA1nQfhfgEQw==
X-Received: by 2002:a05:6a20:7490:b0:1be:d745:66bc with SMTP id adf61e73a8af0-1bef610a18fmr9884718637.15.1719847290882;
        Mon, 01 Jul 2024 08:21:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598bf9sm65967635ad.276.2024.07.01.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:21:30 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:21:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 09/11] files-backend: add unified interface for refs
 scanning
Message-ID: <ZoLJeIhdxHx1O7uA@ArchLinux>
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
index 817813e723..744ee5c5db 100644
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
@@ -3406,6 +3407,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
+			if (o->refs_options.verbose)
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
+	if (o->refs_options.verbose)
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
@@ -3413,7 +3486,9 @@ static int files_fsck(struct ref_store *ref_store,
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

