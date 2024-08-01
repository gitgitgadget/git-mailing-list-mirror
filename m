Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058F13B5A5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525295; cv=none; b=n8AFrRpvRBeUaGTlZI1M61RktK35DhjpwGjr9RNBYsUSNbhHjJL84Hby1CURKFQk2gDxT1m63l4ZW+qe4YE28eI9r2M8pkgeMoIC+xCEcoB7S6QPoHEi8jedXGofJWkTFfDMyfTN/4fAvUvDIiJmpZ0LjpvnxlECz23pri3cPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525295; c=relaxed/simple;
	bh=3/wshvJstV7/vMaFhJbMNrDCQsKwR9qjbWybMEiAmZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7GVtbIg4lLnPKBRYRwPZ0PlatR14Zy/59bPLa5eDuerWgUOYJ9x7SyHpShEp1G4i/NweISmZP0fEIP5UkS2d7ahOuAUPxqP1ojPL40SOQfZxuyV8axeRRt5rn9nljzvIKM0eqnExW51qINPi/PNZ3COIZg6jtLe+XBFltn7SHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVYvoNX5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVYvoNX5"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso6137485b3a.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525292; x=1723130092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXNtaTuVg1hU2q5SrhUTVXkyTgBdS6iNLMjlgd76QFg=;
        b=kVYvoNX5rz7eYv9Il3gNioCJn7lN60papdgaY+n7tEGtQZKd9mCF196IXBgJxOWMZJ
         PRmQqCEy5kdoOItCjP/ijWCnUZT6dUAfQFVPEMRSdxHwHyzjPyuKs6h9MoHNY5apTdWE
         B4K9WJEyyPAPfMS9MACsq7qcyFGxYEdG0ljk50OzrsJUNX2kRB++YTIWiKkaM81FhB1Z
         2YA4y0Mu47Cdf2l6N2bWJnHnFzUdr3vrbM7+rlHutBMS+/uKyWNadHWKFD7NLfBCRg5q
         ReuhRYpt3s29QLjQWvGQdz8SLo+PL+ODxHe22fFGrZvceGrepo8QUHk1DbRr0Rqd1dpV
         QRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525292; x=1723130092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXNtaTuVg1hU2q5SrhUTVXkyTgBdS6iNLMjlgd76QFg=;
        b=XY0jK6Ln5iSxJE3UQTVvMJw4/zEok1LlRvgoaZTTmMtw6XGvKOd0toCFoU0Urzbuh0
         tA3IVXJcu03J8L1C3IDvtgQbe3r2pRLZO/BKPxbIHaAsEJga+5sqKAMxhRI5t7arv5PD
         3QNC9IbTJm439jyA2ZIocxywpfvSyUQFSpGq5V06/jmyxOXGvXdL/lEj7JOHusWaTP9l
         NUmaLREwucXQsXhebWkkOuGHa9xcrZ8Vt9uXdXbeTUJa0uA3opIH0ZAp2Fktl3bkgn5m
         4XEZN96LOmR3hGFi+FYt0T/qJWicHdCg0fNiec61Qi4Iyxv1GGk8VTglpTQxAcj3ywhM
         CvZA==
X-Gm-Message-State: AOJu0YyGCZ1E20qcNmGwrJ4YlLbhYxcmFB8nSPkvTlSjEYzFSLUoHm5o
	TrS0KLESbzQ2rXu9TfVNmTA/0cYGqGA+Sbd/Q00qfpU5Bb0r2hv9IlkQHw==
X-Google-Smtp-Source: AGHT+IESJK0DRD9Xbsw4sQuvTohGnIEhzVsSwhhp7t9NU5BdrkqU+YKYDOZpYUkUguO7uX+bl33PAg==
X-Received: by 2002:a05:6a21:174d:b0:1c0:e997:7081 with SMTP id adf61e73a8af0-1c6995ab39cmr552670637.29.1722525292412;
        Thu, 01 Aug 2024 08:14:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e188asm11643305b3a.41.2024.08.01.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:14:50 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:15:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 10/11] files-backend: add unified interface for
 refs scanning
Message-ID: <ZqumgrIo7pJ--reA@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

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
 refs/files-backend.c          | 75 ++++++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

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
index 4630eb1f80..5574e78656 100644
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
@@ -3408,13 +3409,85 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
+			       files_fsck_refs_fn *fsck_refs_fn)
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
+				if (fsck_refs_fn[i](o, gitdir, refs_check_dir, iter))
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
+		fprintf_ln(stderr, "Checking references consistency");
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
2.45.2

