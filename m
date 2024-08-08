Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799D18D651
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116664; cv=none; b=GYwXARq5mTWyaPJGMDWcUh10g7hb6hGT2GEIKnWLX6EvEmXkqVXvwsRQRJJmwe3N2CZkJpgSWLVWjm49jhUvPGKzIi3nkUQI1OWi4qneQhHtxqI7XcKB/MDASBhGdTe2PtjDX3FjgXw2l3EwxVxeUq5IwhQ6+fwbqePQrM4O7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116664; c=relaxed/simple;
	bh=L5WKcyQYBehw7x/KDP8984hDmycKh7np7STXOvudpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlNxKBU94/q8Dfwsp8F04de+NIOaVe8DtMVtZFc2OHznYblITNtCto6NzPw+BVl+CcOV0pxZrz4/D4nQmn4PZDgSUcf4chc01h4fbl1d1agS9cFuDjIY9qV8UlmeAx5g9/01chchjHQFxqCupc4qFeUvSZyjdUEEvImE1xK0GtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxENq1d1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxENq1d1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc5296e214so8948435ad.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116662; x=1723721462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OilDfyeBDokH26Ok/xTnZCoz9iA942Q7BuRSTwjR2Gs=;
        b=HxENq1d1/mn0xD3R4BrUOsn10Lke/qYWrGfl0wfmlt9IYm9/n499FO81rGTfaZr2Bi
         ObbOS9OKRK84iFt8uHS6F/d6CXa8+TAZZ1Ru/CgopPrR9LVsPiBfrvxd8vFJEBgn4fUU
         ddHfMzN1GqRbUoIQccBy/6cYZpZrmdvQE2tP+ZImZweCojzEARS4vJbiJLp3UnHHsAOk
         /wjmV0XhYzLTe0TjdMgBUpYGK3jZQa3GOEzlvGdJwL5rkR+ysCiLvfXQiMSUizbQo8Lu
         RbcE/HFVW/K+RAq7ST0DiIUSukmRdQSrHHzZGCfIl9YQ9nl8m5/cCpxntzG3+T5Y46LS
         E4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116662; x=1723721462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OilDfyeBDokH26Ok/xTnZCoz9iA942Q7BuRSTwjR2Gs=;
        b=eVMq4VORLkm+LcrYsTxlt46qpCPx+T3D24rL+LaAh9/l9hOUFg7AXc18kov/UK59PF
         L5kcDqdsWLImjCUZoRTRNGh9/bcqxHfuzJR6P6H8DLG/sn+V8lm9DBBAyZ/BfG5pknI9
         KsdFmWrdAGZLNZ0edUPqGVYdPyVJanq13flMy9EUc5gvb96dOakmpvYbFm1n96Wo8ztj
         +/J2imXOI1c9R8K0TkggeDqdHXm0lWBiouMuwzaVbc4mFoKKR/N+2pbf7V+gYHedC40I
         ImC0y0y//pQurNB+doa1Cvzvqf8X5w0V3WhzWygSv15XkRfpLH/4BnXrzA6hGB3+W7nt
         ring==
X-Gm-Message-State: AOJu0Yy6BX/CsqwSyGbYktX+GZUV6zHJ+bjAWIBB2/ZTZRXQd8DHgIKL
	kIUkp+0/jsQ3BgZrthgpnVs534bdMiFTP/UPgWOxe1HvJGnV1a+KhkMbEuN7A/Y=
X-Google-Smtp-Source: AGHT+IFkqAGy6vArrLWCP52cEw/nSl0dO5vTw+/AZc1XvoPC8D8M4cZ/PyUJXS0CMMFK3TGI33LP7g==
X-Received: by 2002:a17:902:e743:b0:1fc:58fc:caf7 with SMTP id d9443c01a7336-200952495fbmr18892735ad.14.1723116661781;
        Thu, 08 Aug 2024 04:31:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592ac89fsm122245215ad.276.2024.08.08.04.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:31:01 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:31:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 8/9] files-backend: add unified interface for refs
 scanning
Message-ID: <ZrSsk27zqOqSXTpH@ArchLinux>
References: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>

For refs and reflogs, we need to scan its corresponding directories to
check every regular file or symbolic link which shares the same pattern.
Introduce a unified interface for scanning directories for
files-backend.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 73 ++++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index f643585a34..7c809fddf1 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefFiletype`::
+	(ERROR) A ref has a bad file type.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index d551a9fe86..af02174973 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,7 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4630eb1f80..e511e1dcce 100644
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
@@ -3408,13 +3409,83 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+/*
+ * For refs and reflogs, they share a unified interface when scanning
+ * the whole directory. This function is used as the callback for each
+ * regular file or symlink in the directory.
+ */
+typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
+				  struct fsck_options *o,
+				  const char *refs_check_dir,
+				  struct dir_iterator *iter);
+
+static int files_fsck_refs_dir(struct ref_store *ref_store,
+			       struct fsck_options *o,
+			       const char *refs_check_dir,
+			       files_fsck_refs_fn *fsck_refs_fn)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct dir_iterator *iter;
+	int iter_status;
+	int ret = 0;
+
+	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
+
+	iter = dir_iterator_begin(sb.buf, 0);
+	if (!iter) {
+		ret = error_errno(_("cannot open directory %s"), sb.buf);
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
+			for (size_t i = 0; fsck_refs_fn[i]; i++) {
+				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
+					ret = -1;
+			}
+		} else {
+			struct fsck_ref_report report = { .path = iter->basename };
+			if (fsck_report_ref(o, &report,
+					    FSCK_MSG_BAD_REF_FILETYPE,
+					    "unexpected file type"))
+				ret = -1;
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
+	files_fsck_refs_fn fsck_refs_fn[]= {
+		NULL,
+	};
+
+	if (o->verbose)
+		fprintf_ln(stderr, _("Checking references consistency"));
+	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
+}
+
 static int files_fsck(struct ref_store *ref_store,
 		      struct fsck_options *o)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	return files_fsck_refs(ref_store, o) |
+	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
 }
 
 struct ref_storage_be refs_be_files = {
-- 
2.46.0

