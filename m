Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8601AA7B1
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103478; cv=none; b=OtMnN1osO6mg6PvTZ4s4i7KRsqdHc/X4mcaKIyf74ZNFm9IIszhGCrNwGX5PxHbVLYWwB1+biPOTtuSZ6BTIfZJ+U2B1Lj1ekDyhr7Tva+5GNrQIFm4JnmJfeP8O2XJopso4tlF6qKxymI9khtMuvrdLQXBVlF0uEMpzInjHIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103478; c=relaxed/simple;
	bh=5V0XiAbP8HWSYG2I6t6wyCWdiAvyF9V1n8no7T7g7Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUdIcEgVa95NMAsojBHYA4CWiOB4ScUm129U36dvqLsBO3UbXwHwaL4yGVNvfCK5SxyGN15r76EKemkKUEmbucY7vwNA3zn0wKtc0hpdqLI7IAdbXtC0t4HLIKlS4INQ65ArE9SWJ/lAv1JZXuqeaLNBsho4I+SyU1LAkJRTDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMLIowbd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMLIowbd"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724455f40a0so1534348b3a.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103476; x=1732708276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ75sjuyqz5k++4m10zIcF0Gbi0g1hHVhXO/JjRwBWE=;
        b=QMLIowbdJQ6AOybTrfNLr92sH3JHKook3CpXtjZzQZDl3Wwk7LXlNTUEFzN2fVnbfa
         w9tJBajA/O15a5Fu3l2nyCbZOqtNR7QYrrVRBGInAo4sbP0FZBO80NESoYsrS12yxhUC
         Uyhg2r7fzS2CtOgyk0iRtpRTVhkk7jMUL8jeyWaIw9cxuBxy8sJG5RIaxGaQB8i+RKvZ
         VtEPJKZHbjKloDM0cDQ2M+SMhZp/ybqrJjPFUsjCO05GOpp/uhiMy0MRtctJRJX7i958
         ZC8650CKjhS3lu9QaER/l3ac+sNJgUdBELg/AaKHuEyVMN2wqjwCD7EagzsCphhVC/Fv
         qtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103476; x=1732708276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ75sjuyqz5k++4m10zIcF0Gbi0g1hHVhXO/JjRwBWE=;
        b=ARRN5diEKaBESfl0x0NOh6aL75dCVfRgKgDVUMTrpj519lYMmEiYwGCR/izpxZjNwv
         EnmfSKZv8I3QsPXDbh0DLfelavXGCxCt9+eHvdgZGoQvEM3uw9O6YMGXtrei5h7aDQO7
         beHU24sA/F3+kuHTeFsAnKitV9RmLg0vs0bn+Sm4jp2yRCh+lA8ceRN5rCFColGwqkYG
         U//bkQDTZm1Hj9IfyvJjqVTXbYXQYtp8QjgSQjehdyjVLZgDjE0FulpMFl44GOtc78Ce
         LdZvn7fbdWKv9T3aOvV+ORQ790F+9feTwQXNgHEmtB3Ovq6P/awT2ocxJPzGW7cFpG5V
         LxEA==
X-Gm-Message-State: AOJu0YyqX3Q607cTwt2YBN97sKbFnUlSpAJ4ncHNiroZ451EpTEF4XOn
	TWWJNL5qbJAzGVYWdarsBHfeCDabs6kDXAFfbm61PM2/kTZOQzOYuHJcXg==
X-Google-Smtp-Source: AGHT+IGVB2BDk9XLCCxpmo/EEXUKN5Y//luOBrhJ7DDbpu670NGL4rMc4vDLfXPpqGgez0d6ktG6OQ==
X-Received: by 2002:a05:6a00:c94:b0:71e:4196:ddb2 with SMTP id d2e1a72fcca58-724becf6a48mr3158500b3a.9.1732103475801;
        Wed, 20 Nov 2024 03:51:15 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befe9b4dsm1413792b3a.191.2024.11.20.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:51:15 -0800 (PST)
Date: Wed, 20 Nov 2024 19:51:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 3/9] ref: initialize ref name outside of check functions
Message-ID: <Zz3NPE52NcfKYE0Q@ArchLinux>
References: <Zz3MON9_9DGD6nsy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3MON9_9DGD6nsy@ArchLinux>

We passes "refs_check_dir" to the "files_fsck_refs_name" function which
allows it to create the checked ref name later. However, when we
introduce a new check function, we have to allocate redundant memory and
re-calculate the ref name. It's bad for us to allocate redundant memory
and duplicate logic. Instead, we should allocate and calculate it only
once and pass the ref name to the check functions.

In order not to do repeat calculation, rename "refs_check_dir" to
"refname". And in "files_fsck_refs_dir", create a new strbuf "refname",
thus whenever we handle a new ref, calculate the name and call the check
functions one by one.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b055edc061..8edb700568 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3501,12 +3501,12 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
  */
 typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  struct fsck_options *o,
-				  const char *refs_check_dir,
+				  const char *refname,
 				  struct dir_iterator *iter);
 
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
-				const char *refs_check_dir,
+				const char *refname,
 				struct dir_iterator *iter)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -3522,11 +3522,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	/*
 	 * This works right now because we never check the root refs.
 	 */
-	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
-	if (check_refname_format(sb.buf, 0)) {
+	if (check_refname_format(refname, 0)) {
 		struct fsck_ref_report report = { 0 };
 
-		report.path = sb.buf;
+		report.path = refname;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_NAME,
 				      "invalid refname format");
@@ -3542,6 +3541,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       const char *refs_check_dir,
 			       files_fsck_refs_fn *fsck_refs_fn)
 {
+	struct strbuf refname = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
 	int iter_status;
@@ -3560,11 +3560,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			continue;
 		} else if (S_ISREG(iter->st.st_mode) ||
 			   S_ISLNK(iter->st.st_mode)) {
+			strbuf_reset(&refname);
+			strbuf_addf(&refname, "%s/%s", refs_check_dir,
+				    iter->relative_path);
+
 			if (o->verbose)
-				fprintf_ln(stderr, "Checking %s/%s",
-					   refs_check_dir, iter->relative_path);
+				fprintf_ln(stderr, "Checking %s", refname.buf);
+
 			for (size_t i = 0; fsck_refs_fn[i]; i++) {
-				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
+				if (fsck_refs_fn[i](ref_store, o, refname.buf, iter))
 					ret = -1;
 			}
 		} else {
@@ -3581,6 +3585,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 out:
 	strbuf_release(&sb);
+	strbuf_release(&refname);
 	return ret;
 }
 
-- 
2.47.0

