Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A835674E
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603254; cv=none; b=onF0vzI5rc3iIEnQsrtZ80oWqXPIA5kHHTNMbnBfyQNBiA4ZomV/eCcd8QgWG9Eoj+U0ZVf71herObbhrONgg0g6gl5AGvS40CavFd0CKK1ekZJEUSzUQAIId3pqLpboWEG9LUSxSXpeaJc2UfWQd/Y389MXGdsQ2g4bWbWhK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603254; c=relaxed/simple;
	bh=5V0XiAbP8HWSYG2I6t6wyCWdiAvyF9V1n8no7T7g7Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmzdDP99MEww/s6YyNyEl0Cwrd9/lqPwSN5HEQG2JZbRmkVcVc75BWDX+DFg1skEqD51YHVdrU8EtuaqgM2eWIvZJfWxF/NkVKtNWCWu480Cl2Ec6ywYL08NIbkqdFjh4PwpDxtLJ9bUfrPNfcCWBQJIRYqnKEz7ptXtUBL3OWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Rvk3rC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Rvk3rC"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so664047a12.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603251; x=1732208051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ75sjuyqz5k++4m10zIcF0Gbi0g1hHVhXO/JjRwBWE=;
        b=M2Rvk3rCnf01xgUkRcA3/nBhMkHfbe+CCatXTF8Nz+QL1WLuEXN1wk16Ca4UduwHKp
         dddq0o/TCZoN+dnKYN2kKD0eshVsuO4fzF4F1jGbNyOKzLiRfVES1TYu2/wsrar9TpzC
         EbHKcO+B0YcG3ymx2vCNORlQZJeB2N4b85OCRT8nAhsBLH61Lkdn/Cn08g/spYQkK2wA
         iZFyEJACFu/vxGuFu7HhMvbvK5U5Vl/STs5svfhwxspJuFNtQ9b6RbpNq3Jasvjpu6+L
         nX3X4vzXKDJDfWXQU8k1tJixjc4Cvq7PxsN5Lbq4XQbsBxj79MNSW1IQYEDzaeZSMWI4
         SRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603251; x=1732208051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ75sjuyqz5k++4m10zIcF0Gbi0g1hHVhXO/JjRwBWE=;
        b=fZLhmDBXorhC2LbSfG6nFczwGuAAx/PUQdcz9gqUAZQD59iyau3QrctcAPWMfhRgUQ
         cgKMKZ4rwxB4rTA02/jJa/HG+cNIBuYvYHzHUCLTOHRrvTU+wyEYsQxjCkedy3qOmck5
         jpJmOn9A76wAg5w1nwvwTWFLI+pOo0Axjrh4MK+e+jTZnNkdRhBtF6RWpJdDONqBvajv
         aCZJZhQBCTVjDSH18PwLG84RY77T8mIThrlId4L6PYYjHIis4ahWUnnx1elVeoB19rU3
         NcOGrnPlo0+vcX/OBsAG78A5GUf5s7eruUiKMpHJtxIP5Sa2BwnxNGbHd0xVBGmYjkDm
         liUA==
X-Gm-Message-State: AOJu0YwQWIry5t+Sk5A+yEQgMsg5gNGVIUlpm8udJNrzEzwp57J4ZfmA
	ieEk0w+FJH6LwIblk/twqBt8xz6gv+RQYTuCmXIMfi1ds7mBgV8IdrJTkg==
X-Google-Smtp-Source: AGHT+IGuA+Mkrsy4Ejm5+WH6GiE/wBTqBQcsVLJ9y/vXAW3Znsa4YJPU5/KM56ZRHvwG/2zghL57GQ==
X-Received: by 2002:a17:90b:3e8c:b0:2e2:e4d3:3401 with SMTP id 98e67ed59e1d1-2e9f2c906cbmr9253109a91.20.1731603249789;
        Thu, 14 Nov 2024 08:54:09 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024949a4sm1508486a91.11.2024.11.14.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:54:09 -0800 (PST)
Date: Fri, 15 Nov 2024 00:54:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 3/9] ref: initialize ref name outside of check functions
Message-ID: <ZzYrNBzugqMRU_Ty@ArchLinux>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYqoai8X_Wdtbmt@ArchLinux>

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

