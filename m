Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAE1F4726
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517670; cv=none; b=Vi4Aw6T/4bjwkaZDO5My9P/FoMV/SDbSVy6XLRY0EzOdC9RNifz1CZsHI2/xBA8fmKg7WIcoNAM7JNlvzeWbVxSEB73dUOjBkqqF9uZ9s1y7o2ryiw6WS3z19cnn8YVJQFWhURzG/+xWqQ3lKdh6Jd5BdF8qkMoB4ToCHUYBIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517670; c=relaxed/simple;
	bh=wMNCWf6s29KpHZcxEWiYo/DoNvHpeTy11CEa+EXGFCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6wGNDwL5QruCy9A2OOB+WoRrr9DMqIDl2tEm8xor/jSTWcDOE6626P5KndEVDmHAfukBDd3LATjTupVJRVzdPw8WGol0aCy0zY0ZYz4BgjckJ7wKEtZSnnXIJBezLeWR1jjuplqn3PGe70BXP1+NYAJ0UnXtQxklnOcWCor6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKo83tir; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKo83tir"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71ea2643545so2679594b3a.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517668; x=1730122468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcrIzPe6eAmshJw/eCNKdp+NDct1XU910ErxjPGCOGY=;
        b=JKo83tirZIe5IOb9IY2mRyKSKtC82n32th3htK/wNAY5O8Vwv6KFHD6dR2mm3TRyDk
         xSAlnzVXGsDT0E5xvPqqRG6VxA1UTbGjs8dtBzZ+QVdy216CJypTJ0iXr6ZSIQbdjqiF
         n81O/XcYEGzDiYUdBCKZKB1pAos/6Sm/ETiO2VZmVkf91MGtLpJx0GsF4uCCgYVf+TxB
         xvxxzKXRVlvbaM2fLsK0VPj5XVMwkkjNOZcUizLkqHJEr7xVSB0rGwDUqh+LmxK+Xof+
         3cZL0N97tT1Tzr3EhHZq7811V4/fW3/XnNAQTRWneHe00NB1BthxDJ49jYAXrG/lj4dT
         Y88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517668; x=1730122468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcrIzPe6eAmshJw/eCNKdp+NDct1XU910ErxjPGCOGY=;
        b=mpmKYLA7PP5DIKd70y+NX9VcHqPETmQrWB6cUHtu/BJWA1LtRSuQx8j2MArBpvSimx
         ukmfN3WRZJNc73azbvMKbxf1Nm8rqUFpUFLmf/97SE8xez/89WYa3b3NGB7frdjthr6R
         YPgpD7xveUiaMu9S5A6xrwbmDNhpideELGyF4jpPFactR6pcos4bumLvc8+YT50n2KUj
         swjmT4mSRvzVQc8G6u0gFZLdUxYwoLjpE33XWd+WpETvKyzWgTspNRDdckKDghEJM04t
         kSckMOBEAWezK2JDKxtN84Hehn0BgBtf2/uox2WWAt4lYeHHLmrlCUJyr0Uw0kdVfaLq
         TOIw==
X-Gm-Message-State: AOJu0YzhT3tIzicbJtH+ezSZwXLz0m8wc4fnMXBNgaY21sRssDFFrWuJ
	1bLI8MdNtOg5IYT+Wi/48fwkNteEUfz3TPXToIh3RF0tAPrOSiYKQJ8DgRtA
X-Google-Smtp-Source: AGHT+IFKpQlegprdqlr3OvCR9CgpJydbz2d13AqiB54lMjyOYUmPNCm6MuO9yCGT3dzAQxfjsoPhUw==
X-Received: by 2002:a05:6300:4044:b0:1d8:d600:2c6b with SMTP id adf61e73a8af0-1d92c4a1e9amr14992625637.3.1729517667805;
        Mon, 21 Oct 2024 06:34:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec131399esm2947300b3a.13.2024.10.21.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:34:27 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:34:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 3/9] ref: initialize target name outside of check functions
Message-ID: <ZxZYZy-9deyT6I9a@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

We passes "refs_check_dir" to the "files_fsck_refs_name" function which
allows it to create the checked ref name later. However, when we
introduce a new check function, we have to re-calculate the target name.
It's bad for us to do repeat calculation. Instead, we should calculate
it only once and pass the target name to the check functions.

In order not to do repeat calculation, rename "refs_check_dir" to
"target_name". And in "files_fsck_refs_dir", create a new strbuf
"target_name", thus whenever we handle a new target, calculate the
name and call the check functions one by one.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f246c92684..fbfcd1115c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3501,12 +3501,12 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
  */
 typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  struct fsck_options *o,
-				  const char *refs_check_dir,
+				  const char *target_name,
 				  struct dir_iterator *iter);
 
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
-				const char *refs_check_dir,
+				const char *target_name,
 				struct dir_iterator *iter)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -3519,11 +3519,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
 		goto cleanup;
 
-	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
-	if (check_refname_format(sb.buf, 0)) {
+	if (check_refname_format(target_name, 0)) {
 		struct fsck_ref_report report = { 0 };
 
-		report.path = sb.buf;
+		report.path = target_name;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_NAME,
 				      "invalid refname format");
@@ -3539,6 +3538,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       const char *refs_check_dir,
 			       files_fsck_refs_fn *fsck_refs_fn)
 {
+	struct strbuf target_name = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
 	int iter_status;
@@ -3557,11 +3557,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			continue;
 		} else if (S_ISREG(iter->st.st_mode) ||
 			   S_ISLNK(iter->st.st_mode)) {
+			strbuf_reset(&target_name);
+			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
+				    iter->relative_path);
+
 			if (o->verbose)
-				fprintf_ln(stderr, "Checking %s/%s",
-					   refs_check_dir, iter->relative_path);
+				fprintf_ln(stderr, "Checking %s", target_name.buf);
+
 			for (size_t i = 0; fsck_refs_fn[i]; i++) {
-				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
+				if (fsck_refs_fn[i](ref_store, o, target_name.buf, iter))
 					ret = -1;
 			}
 		} else {
@@ -3578,6 +3582,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 out:
 	strbuf_release(&sb);
+	strbuf_release(&target_name);
 	return ret;
 }
 
-- 
2.47.0

