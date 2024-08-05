Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D115F418
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876359; cv=none; b=ZhT8ExSrm0Qa0jRmzlgBC9hktxkRF3w6lFK/QQw75TbuVdELvBdvvIMBKYcIp3bqPQMPpwaSkPE4Nk9fhJ8W+cfGwoG17DqRnzw6F+mOg8agyPC96OcfOEMKTXXoJoe0mGfy/e7SZe0gcj7Jenars9W64gJyfpYsluQgmpYr4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876359; c=relaxed/simple;
	bh=KRF/lgkg4nJlvvPhfL5akAM4TFBDzTFv3OEGaP46ij8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdT3xGf3MXmP1dkEIQzjiWldvidzfzMivWf1aNe7jaDRktLKphzQr8HDV/jPfDaiWbYrQtHyyhcQdoKiOLFKAkffTxwgATudasdFQRymRIidhMU0t5ip2yKyR1aCnyUTQhU7QwMYW5kIJMOCyTuxiX9+O+Eipn6pDbJwmBSbx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFIFzXdw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFIFzXdw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc4fcbb131so92250755ad.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876356; x=1723481156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=blnd6GJmx2eh97pHBI5nYwJsboRd771jhYfXZMmtlQ0=;
        b=eFIFzXdwngU37vIXl2q5sEhBu5E/2QFX0niUZTnuFxWxzNyDGQ6pKWr2le1k0L1HiR
         OXCKZZDg16Tz6k+JjZb9KevrRjNRZ9spG6C9gh9imSOc8j5PkchIN/LQXwOikDwrZJA9
         Sp8gsjcB5cx3l5Ti6JHmN5N+2E+2Bjp21EtXG0LCNhcW62j1xqKguReyMzShtx62qN17
         TfjYkmWE/yI2bcEGPPWgfW9Nk+Y/NhRbJDe65HxyThKyvKqDejH5bCxgH7rzlH+QTLkN
         IUqeMalTyfX+f8LFnHZ/o4y8SSZS1d8E9DyrHQ0A4cAaimwZpINdokYB1GZVo5/WdAXl
         MMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876356; x=1723481156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blnd6GJmx2eh97pHBI5nYwJsboRd771jhYfXZMmtlQ0=;
        b=OfGse8t8X3oc4HpvJU48a0DKgh9unNktMttpjePFzjQERv8ldFeTRNg+mg/7r2WAFW
         lOS6GeBkQI/cjTlPVUhyQVU8n5SPqYbufWvlwAzIfV6puW3tU/shpe6KW9NaIKXlR0Ui
         rq5xOUKvz79oIlQniRmYmkMVAM93ygm3fJarSHtaNPRylJ16OBHKOdokBQ4s9YLhncKY
         hqlZkVzURDSoI+HlstvodXxP9gQgXDcS3gnnkYrl2G5a+xh+tE83s7SH9u0syI2CLNTb
         fvBvbGK/T9FHfCN4QtbvvGEhgzZSOqMDJJ5DGeBjrJdRyGAk8mnpBJxGI0n9jjqJ9NVH
         Y0hg==
X-Gm-Message-State: AOJu0Yy5B1TkEsWifSgpkVUbuT0i1d27TJoOxvbL6aSjggU1fIlHZpyS
	KF+SHyXNddvZ7UV3nLq+Ql1dhcCAm4RyLaZ6/gcv/1M4MHZ8ydZbOuQxGQ==
X-Google-Smtp-Source: AGHT+IGRjDxmuGcysYJWEkbtLIIld8jsois4nGAU0SA8rtqjH4QKPnTpDfubCCIq2WBymw6Nfo5CZg==
X-Received: by 2002:a17:902:ea02:b0:1fd:5fa0:e98f with SMTP id d9443c01a7336-1ff5737d3famr149632605ad.44.1722876356375;
        Mon, 05 Aug 2024 09:45:56 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905b43csm70224875ad.146.2024.08.05.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:45:55 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:46:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 8/9] files-backend: add unified interface for refs
 scanning
Message-ID: <ZrEB4PjNPM6SZspS@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

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
 refs/files-backend.c          | 74 ++++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 1 deletion(-)

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
index 4630eb1f80..f337356860 100644
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
@@ -3408,13 +3409,84 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
+
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

