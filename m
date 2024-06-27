Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9823BE
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501415; cv=none; b=ILS1Y6RugIhSzw4Egnd1v18EDdEx6C861EI4a+rEZvd5fy73XfDJAz1GrLBvJxAozEpyyCwzqtKcIgw6/EQto//keedVnXqvVvrNbo+a6EZpZZFhBsn0ahPo5tWsEF0QXsZkAFvi7dCq2SSAW5jxYfmalR8zG0dEg+9VFjwUrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501415; c=relaxed/simple;
	bh=mfI5Kwv03fKfrSBuBGIt1iX3SSfHhcv2tfByPa/ZUGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGzNFaGUV8KsR2D/MTJbnZGgs3YJgpVndOUOr+SOpLM+/aD8VOoNrRtNtc060kra04Wvr05HN4Y6Dyc0/otEGID1mlo1moQxj3wf3Z/Fkzr20itZIrNwUmDB6K7fbx8Ob1urcXQnsgu887zAsqbR36Cp3ek/uB8bQkQFZwyVIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DitM/Pjq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DitM/Pjq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso6571692a12.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501413; x=1720106213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwnJTzOkZxdXLhBypnuUx/TOt+tOGgh3//QJ3Nj/i5A=;
        b=DitM/PjqtPyY+xxGAd7hnc9tWGDtahaDFzjy9XVFntso4hhE6rRZebvWZF04rE4JZ7
         16qUq4O3NoQ3Zs+Ei9ALPTF6dYfroKbiChSwNxwTzzALsamHJIjGbRhXLI0MVgLEti5Q
         N3hzGsG9ie0BjbeBGVFiCPb1IUhO1CTsnMJ3pOHvZFOPV9DwoLvOLMRmNymnAZKX/xRy
         HGFT3V3qAIshU2kwg5F3NL/Nfh4kJprK6juZ86SyhMbhJD+ZghmrQQJLUhj7K8QfwWyY
         tVt/PN59XqHXlTUYtojsur7apw67s5sH6N5m04QZ4k/e7bdG48grVUHjHm/1Cy73csxl
         413A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501413; x=1720106213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwnJTzOkZxdXLhBypnuUx/TOt+tOGgh3//QJ3Nj/i5A=;
        b=hVgWa7SjTf5SE7vA4SiDCW0JHa60r/zj2gM9fa+jlaXmgj8MlxsXiI+5isb5nlTUK1
         6cED+Wm/NVgn6uTmAd8b0iEhmGYax1VES2giPHbtcBr4qILmEHlp/82ZMk3hh2v7S4HP
         0COq7cBb0mrnDD2XcTA5gSPsapcPzAIqn95m4O2WhePHNDIGLu9oOmCPM2JAsASRUdBI
         UEyXAy/csL6BRvyOsMoX5nx7nhaOe1Z6G9e22jJmRSDrtfBwvrigap22Y7sIc+64iAvH
         Z3mfKQtwofVV+ibk8ThqdHel59XFgH8Qj9yxA4Vx7/ZEm5MTQ5hY3hddcWtXe6Lqzx9y
         czRQ==
X-Gm-Message-State: AOJu0YwdQiojzYcbrjZc0bRSSDEmGDKDIoEGV16Qlz5K1gOWIx8BMkdK
	Cv6rSmYdwBfZh+rBeP90iBF0OBVl9nWwmnYxfuszg3jVwQ61RvynJlgwkw==
X-Google-Smtp-Source: AGHT+IEcKYimI/M74yiPlCyWX3uHGJIpVY6AN9KXO4s9wXlK7EBpSn2T2mhdJm/TH8Nd5y8h3tmzMQ==
X-Received: by 2002:a05:6a20:5a81:b0:1bd:2894:a0ca with SMTP id adf61e73a8af0-1bd2894a15dmr6489976637.41.1719501413331;
        Thu, 27 Jun 2024 08:16:53 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b48caecfsm1476841b3a.24.2024.06.27.08.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:16:52 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:16:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 10/12] files-backend: add unified interface for refs
 scanning
Message-ID: <Zn2CYu_xTKg9snbJ@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

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
index 7257fffb77..aefc947fc3 100644
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
+			if (o->fsck_options.verbose)
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
+	if (o->fsck_options.verbose)
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

