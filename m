Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665215E97
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622900; cv=none; b=F8VQ9FiY42DJF7XNG3pbjUaovgoIq30quEBpC4g1O5q8G3XjG6A8/uqqUvUC6XiCnzqr6yN0b6hf6UbdYCNk4Thh0WwXW2G9tpTFma5PTeHGfymjr97dIgb6QuudSRC0X+6YRlIGoA1tDD4TMz+T1dUvGxq/qYPsSDHXwwuAaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622900; c=relaxed/simple;
	bh=S0bP3/AX3MX3DxFnCOPiXKJrLhQV20Me5gL9Jqq5Gbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bObQNG/rSsAhdlT3LWwNGPdG29sZMNl6msanrDkPU3CT5TXggxkj4ceeEgf4/p72mDiokKpwdftZF+x8uPkXgV5ibpwv6Qe/y22oD2o1tj+NEGvp1SpxxanE41E0xh6NZjF1UZ88Ej9TBNGZZeRlTWd+GUctnPbL09zJFLSOjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ2DS7SX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ2DS7SX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so624951b3a.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622898; x=1721227698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=UQ2DS7SXsUvE2VyGK0ZWbBwv8jnuBkZwtKIyqmjmdvUg48bne8FDNq8AkhhoB/HK9V
         ZU265zAUKJaFoXOEYxPuKkAVPsylKAtc6DGwT9XUhlqz00auJqBnCQzGuKpnbmpCAJ/o
         +/Vhwtouu8ZadD5svmKSGQ34HUGgepi2AKIbirZcizRYqgQ2d/LCkdx5rZeExR8imLxJ
         9mnHOWpN7UZWgg63GkgeiosB3lnjN1lsW4lm2iiPenR7xwWKmQI8wiIDBuiEBqiIUO5Z
         oj+qqyjrrGatnHj50qSLQwCInDcQkY4UFEX8VZSFyYrHTaSBxj7n/9XOMuwdKQiSA8zp
         Lxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622898; x=1721227698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=fdYETSWRfkLbk+/xbsHCdsBGEfTyqMElv7cMuQiS730v89vYENsp9dJVjl/OVv2Kwt
         hF852MXfqP4VKN0oUV9IC4JmK9MaUFJilBTiiE73L6+YAV4rmV/YxpmVdZSmfUS6Tr9s
         i1pCy8aafra8EDJ+ceM2nejK3Hxq8WPVExd/hEPJBmLS+FH8skuOELLsCJnpuwi926go
         oyglPfnPn3KoDGKxx+y7aWix9dzxCgRY5dmS+RQxMMuGwm5AehQOHVkD8iag2ALN5vH6
         niojmLSaUNMpen/8YaDggSHo+r76AIhYvr1GQvOLzveksFlXz9NGqBWWW3OXVrfAjTMG
         NaFQ==
X-Gm-Message-State: AOJu0YwKyFzKF1hqQDssZQnsmuU1dyr4hWO2GpIg0D7Tw5cFHEdVRaTO
	z3xNYqkys2i0qKEIVFMl1OXWFV7q2Nwk14BOXzlbVJ4sCoUjgUrFZACPZw==
X-Google-Smtp-Source: AGHT+IFjSd8rsEEPmpgUVoA7Xk38FftjTH7TXJqGFyw3ktCENhmk69gzYWUXf0zCzgzySLG7DxD3VQ==
X-Received: by 2002:a05:6a00:3cd6:b0:706:1ff1:c5ff with SMTP id d2e1a72fcca58-70b44d49d0bmr8509869b3a.1.1720622897675;
        Wed, 10 Jul 2024 07:48:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397c1e5sm3983004b3a.145.2024.07.10.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:48:17 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:48:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 08/10] files-backend: add unified interface for
 refs scanning
Message-ID: <Zo6fMt-ikLAYxMH3@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

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

