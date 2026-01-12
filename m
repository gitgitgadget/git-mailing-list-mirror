Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3A346FB8
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208593; cv=none; b=sDfeF8I9WTitQlgYnwu5k678LxUM+2vsRDu/1XbP6+s4UmcxCc7lLdT44xbEjssJw9M8+yBc2aCTrhOdQ8NMl4YxjbOj6iCWCwhp9Rc4AG8dnF37T48WnfWj5TkcjIXM//4ycMKowj6PH8Nv6Ie0cMjWG2xoAbLDkVEcDJE9WbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208593; c=relaxed/simple;
	bh=xhdwK/quSk/37juIrOIR6b6JaZoAbmRRcDHWkIBH4qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdqxUGzMWExKpOpv73Li5PNKoaP2jPhdnICGjbxAWcTZXslGICOFDMVYjBFnoWOJvmCRmXmGfacFezHkF5LksA9aflfj0ZnfJXHi81+UG7igJ6Y2TpCpSX41k0Et+mGZk+YT/vZi5Y/UywdDsMmHOz16NRAc1lNWRoLGxGdhat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Quo1xV4g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xfXA9mXi; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Quo1xV4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfXA9mXi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 67ED51D000B0;
	Mon, 12 Jan 2026 04:03:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 04:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208589;
	 x=1768294989; bh=v91V+YonS3odFLo3Gvhu0X5QzbqZ4rkreUbDFt2YLxw=; b=
	Quo1xV4gqEtj/rDXILXE8HkJF6AErlrBhvAWdy0XR1Ho3If5nswGrQaOWdg7bt/l
	2wqxO0OU1Pogv2QBHnHy2I9x+lcHI/YCKmGHzizPbR9X0XmmbYIsPOrw2oOrea8A
	h//p/RQHR1Pm27OOGj9X6AvI+INlf8SA1y3U/9y8R0L5SnfLoh1duqnRbTVMwaCG
	hLJc3kh3G1ZXn0mT208NkJSeEkyle7CT1TsK0iFe1i1dgla5FYBgAneEHgcxDBTw
	ubVZgXQGSvg6jWm8ruWmTbm5gydbUIER7mcZMx4ILKqUgiIchtUMT4tkeWUkLzVO
	5J/5OZ2QRvGay35WjC//DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208589; x=
	1768294989; bh=v91V+YonS3odFLo3Gvhu0X5QzbqZ4rkreUbDFt2YLxw=; b=x
	fXA9mXiRsIawVPpH0tIUkn9yDLj2usf6H65LWoFOnFY71rXILBQ3i/l4EcJjUAXM
	A+i/5vd7NIeLciRcO86go+s4wQcrPGQHTVLEn/zXHRACGRgXbxmrcm5T8iKEs/Ks
	Xvno6wamJoEa0FgaiKSqd/mGLEzxUZs1Yrcs8z31Hr4KjegKc68s3KIMIliDsTgf
	e4utV8JDvkEb/jjOaSKIFts1rbEvtWzf/jCiU6WwZbRPwlgk2D5SjdQCK6zyqhqh
	I2DT0x05gVFe950grQLw/HKIfMy/t/ebSP6yqvp5CLObaUznaQHRt7HihrlwSPte
	Rd64CGFXl9lQ+gK9wQFQQ==
X-ME-Sender: <xms:zbhkaVINbFTmiQ7n213t7NfvTkseMcWgGO1F1Ifeei6BisRsTY7rKw>
    <xme:zbhkaYlPYxs3czJHGDEFU9wxJ8Gs_pHyU97kY3791ZcAH0bVf7nQwZwNkIb3kQxTk
    r_7BUvk3frFhvadeBaTy5OwmbMP7Tk52cTFqrf6N5vYO5nPRC_8zQ>
X-ME-Received: <xmr:zbhkabH7hze0Y07mhQl4nsafezxh3Xjj_7hDB3TkHwkodbztfp5q5oKVOVZS-Yd3dMNQmKrOzlPL-YRGVInfGIUNz022Znkr7JLEJb4NUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjih
    grlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zbhkaQG0_T55V16k89osLhg94_r6WwVnUGLayjAAmtEevfbzAII9jw>
    <xmx:zbhkaQMGDPv3h1g11l9UkX4fnOU6cqPsxWwr_BycKMn3jexJaFMBzw>
    <xmx:zbhkaXHC2uDlWY-QI8tWVLPeFXUotMEe0VM4LGx50NeweIaCiTIRfg>
    <xmx:zbhkafNZ1fN00N_kpIdzciaeg2khOeHgaWJHBndXv4pjh8uw23rC4w>
    <xmx:zbhkaWA4x1zSQ6ktHqQdDyzMvAoO3hxwnN1eRBrPl6S2XAW2_9ERW--o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c2f3b92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:54 +0100
Subject: [PATCH v2 05/17] refs/files: extract function to check single ref
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-5-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When checking the consistency of references we create a directory
iterator and then verify each single reference in a loop. The logic to
perform the actual checks is embedded into that loop, which makes it
hard to reuse. But In a subsequent commit we're about to introduce a
second path that wants to verify references.

Prepare for this by extracting the logic to check a single reference
into a standalone function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 80 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4cbee23dad..9972221f9f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3715,7 +3715,8 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  struct fsck_options *o,
 				  const char *refname,
-				  struct dir_iterator *iter);
+				  const char *path,
+				  int mode);
 
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
@@ -3772,7 +3773,8 @@ static int files_fsck_symref_target(struct fsck_options *o,
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
 				   const char *target_name,
-				   struct dir_iterator *iter)
+				   const char *path,
+				   int mode)
 {
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf abs_gitdir = STRBUF_INIT;
@@ -3786,7 +3788,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	report.path = target_name;
 
-	if (S_ISLNK(iter->st.st_mode)) {
+	if (S_ISLNK(mode)) {
 		const char *relative_referent_path = NULL;
 
 		ret = fsck_report_ref(o, &report,
@@ -3798,7 +3800,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
 			strbuf_addch(&abs_gitdir, '/');
 
-		strbuf_add_real_path(&ref_content, iter->path.buf);
+		strbuf_add_real_path(&ref_content, path);
 		skip_prefix(ref_content.buf, abs_gitdir.buf,
 			    &relative_referent_path);
 
@@ -3811,7 +3813,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+	if (strbuf_read_file(&ref_content, path, 0) < 0) {
 		/*
 		 * Ref file could be removed by another concurrent process. We should
 		 * ignore this error and continue to the next ref.
@@ -3819,7 +3821,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		if (errno == ENOENT)
 			goto cleanup;
 
-		ret = error_errno(_("cannot read ref file '%s'"), iter->path.buf);
+		ret = error_errno(_("cannot read ref file '%s'"), path);
 		goto cleanup;
 	}
 
@@ -3861,16 +3863,20 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refname,
-				struct dir_iterator *iter)
+				const char *path,
+				int mode UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
+	const char *filename;
 	int ret = 0;
 
+	filename = basename((char *) path);
+
 	/*
 	 * Ignore the files ending with ".lock" as they may be lock files
 	 * However, do not allow bare ".lock" files.
 	 */
-	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
+	if (filename[0] != '.' && ends_with(filename, ".lock"))
 		goto cleanup;
 
 	/*
@@ -3896,6 +3902,35 @@ static const files_fsck_refs_fn fsck_refs_fn[]= {
 	NULL,
 };
 
+static int files_fsck_ref(struct ref_store *ref_store,
+			  struct fsck_options *o,
+			  const char *refname,
+			  const char *path,
+			  int mode)
+{
+	int ret = 0;
+
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking %s", refname);
+
+	if (!S_ISREG(mode) && !S_ISLNK(mode)) {
+		struct fsck_ref_report report = { .path = refname };
+
+		if (fsck_report_ref(o, &report,
+				    FSCK_MSG_BAD_REF_FILETYPE,
+				    "unexpected file type"))
+			ret = -1;
+		goto out;
+	}
+
+	for (size_t i = 0; fsck_refs_fn[i]; i++)
+		if (fsck_refs_fn[i](ref_store, o, refname, path, mode))
+			ret = -1;
+
+out:
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       struct worktree *wt)
@@ -3918,30 +3953,17 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	}
 
 	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
-		if (S_ISDIR(iter->st.st_mode)) {
+		if (S_ISDIR(iter->st.st_mode))
 			continue;
-		} else if (S_ISREG(iter->st.st_mode) ||
-			   S_ISLNK(iter->st.st_mode)) {
-			strbuf_reset(&refname);
-
-			if (!is_main_worktree(wt))
-				strbuf_addf(&refname, "worktrees/%s/", wt->id);
-			strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
-			if (o->verbose)
-				fprintf_ln(stderr, "Checking %s", refname.buf);
+		strbuf_reset(&refname);
+		if (!is_main_worktree(wt))
+			strbuf_addf(&refname, "worktrees/%s/", wt->id);
+		strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
-			for (size_t i = 0; fsck_refs_fn[i]; i++) {
-				if (fsck_refs_fn[i](ref_store, o, refname.buf, iter))
-					ret = -1;
-			}
-		} else {
-			struct fsck_ref_report report = { .path = iter->basename };
-			if (fsck_report_ref(o, &report,
-					    FSCK_MSG_BAD_REF_FILETYPE,
-					    "unexpected file type"))
-				ret = -1;
-		}
+		if (files_fsck_ref(ref_store, o, refname.buf,
+				   iter->path.buf, iter->st.st_mode) < 0)
+			ret = -1;
 	}
 
 	if (iter_status != ITER_DONE)

-- 
2.52.0.590.g1f87b77810.dirty

