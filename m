Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54E13B580
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310320; cv=none; b=eLJcHdxTCfVSM0WOOinyIkVJWuxPI2NHhhI7syZloTRRmsRZS7wQgOJbp/7ZxcAE8PyewP5wB6T4iwqsJavS4zTGP4lZqCTYZPY+e6IMlPpP9Fz3nnAvFucL1XQxseU6uf7RY/KudeVSpWeu1A5gQOiroo3uBFHxYSnAqZnCYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310320; c=relaxed/simple;
	bh=lL0Uf6Yos/1qSOTLHQ6wEUlzmTScor++Nn3QKxQ1gYI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bE7Nf8sqHEhCS1Da6GA56nZlB5nsn7bbxcpNv985aP2Hogpytfkk5nZqI7M8nYtbGH61Awbe0oV7aJ1aqJ8yAeWbxd7L2M+pfa7jjy3FrqRACobl6+sIXI20g54lp6ULt2ySLQ/JJaekEqE3UM0ZGUHHIpXYrnwiSi/yB67aA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeWvsPuP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeWvsPuP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f275c7286so1355600f8f.2
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310317; x=1718915117; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLIF4q2ZHyh/Xh9xiDa55Q70fW1Ev/dNsms6su/hvVc=;
        b=HeWvsPuPR55VMZWYLLCSXDM0M4g2h5M4Cm3KhUpTMWPx8TUSOm9XtlVy+6Uh+Js88v
         wqeWzn8bqCDPKzGkz2JGQzy+vH4goXoQTORHpGkozlR5jPcrHABFkxB3fTZvRena+9Wq
         7OgVquGKmYUdh2/Sklm1QtKpSW/hf3bTcAUwMgosLyn9Wt/ZBJdEl++j2HQ3EJfGGsq3
         kRQyu1SsHrD2gVZHVvd6aWahymUUYdelFfAcLVr5qGnrPvYWHyJB4mwuo3UHTzCBMoAA
         zF6P+kb4yd18oDEyqo9kcp/wR5C/nPcdbym3dqz5AJGg4Mtd05rNKEgUz/KDnnCfGtUu
         Dlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310317; x=1718915117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLIF4q2ZHyh/Xh9xiDa55Q70fW1Ev/dNsms6su/hvVc=;
        b=KUpjwxfPk8/pHokHm+2H0X3dTz+Eu6EBTGKR+OOXdmxr98GeAobpNdMTB3oKjmtVKG
         4FTbgYyT89To7weDvXxicEA1yeiIgL20ilBjFR2WjsCmJrmQirIu61Xqk1BT+VEHP420
         Ahtrf5kI/7iqCztPoy/vDyQxUySUCkhNfmzBs/RylNjiEaIBQ46JyIeWXnyu1k+Tlt4B
         KC4Df4qadYmwTVG6ZyZDO9sNs1OKAwlhVFZvUs3g2oMwDSwQt22zNxJx7Gzz4MFtvEEn
         fdJJogt7iQS79SCSVrth4KbaAVqwFpHzScG3WhvaHwvoiH73kY6/+H3r+U3/xLVr+kN/
         67oQ==
X-Gm-Message-State: AOJu0YyypBBzr60vuRheCEX52qE8av6vlDseLTQR1JQtG9rSlTT18sZ8
	Loq48sIyBQoyz3m/g5+mOPCDQaJ9HxwQNa4IRk4KhJt+yzGs3rtyPciSig==
X-Google-Smtp-Source: AGHT+IHZSTqPg5VWVpPYNAPG2QQgyBZomN22xyMxTRaynH2GSav1JVrEmgulAQI7h7THzJbRYDV02Q==
X-Received: by 2002:a05:6000:102:b0:360:6e1d:6c68 with SMTP id ffacd0b85a97d-3607a759bf8mr561795f8f.16.1718310316523;
        Thu, 13 Jun 2024 13:25:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509346asm2604148f8f.20.2024.06.13.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:16 -0700 (PDT)
Message-Id: <32ae44b6260eea8dad7a428ed92e25b3891ddd9c.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:07 +0000
Subject: [PATCH 7/7] merge-ort: convert more error() cases to path_msg()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

merge_submodule() stores errors using path_msg(), whereas other call
sites make use of the error() function.  This is inconsistent, and
moving towards path_msg() seems more friendly for libification efforts
since it will allow the caller to determine whether the error messages
need to be printed.

Note that this deferred handling of error messages changes the error
message in a recursive merge from
  error: failed to execute internal merge
to
  From inner merge:  error: failed to execute internal merge
which provides a little more information about the error which may be
useful.  Since the recursive merge strategy still only shows the older
error, we had to adjust the new testcase introduced a few commits ago to
just search for the older message somewhere in the output.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c           | 53 +++++++++++++++++++++++++++++++++----------
 t/t6406-merge-attr.sh |  2 +-
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5410dec2b4f..493aa55aa80 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -558,6 +558,10 @@ enum conflict_and_info_types {
 	 * Keep this group _last_ other than NB_CONFLICT_TYPES
 	 */
 	ERROR_SUBMODULE_CORRUPT,
+	ERROR_THREEWAY_CONTENT_MERGE_FAILED,
+	ERROR_OBJECT_WRITE_FAILED,
+	ERROR_OBJECT_READ_FAILED,
+	ERROR_OBJECT_NOT_A_BLOB,
 
 	/* Keep this entry _last_ in the list */
 	NB_TOTAL_TYPES,
@@ -615,6 +619,14 @@ static const char *type_short_descriptions[] = {
 	/* Something is seriously wrong; cannot even perform merge */
 	[ERROR_SUBMODULE_CORRUPT] =
 		"ERROR (submodule corrupt)",
+	[ERROR_THREEWAY_CONTENT_MERGE_FAILED] =
+		"ERROR (three-way content merge failed)",
+	[ERROR_OBJECT_WRITE_FAILED] =
+		"ERROR (object write failed)",
+	[ERROR_OBJECT_READ_FAILED] =
+		"ERROR (object read failed)",
+	[ERROR_OBJECT_NOT_A_BLOB] =
+		"ERROR (object is not a blob)",
 };
 
 struct logical_conflict_info {
@@ -2190,15 +2202,24 @@ static int handle_content_merge(struct merge_options *opt,
 					  pathnames, extra_marker_size,
 					  &result_buf);
 
-		if ((merge_status < 0) || !result_buf.ptr)
-			ret = error(_("failed to execute internal merge"));
+		if ((merge_status < 0) || !result_buf.ptr) {
+			path_msg(opt, ERROR_THREEWAY_CONTENT_MERGE_FAILED, 0,
+				 pathnames[0], pathnames[1], pathnames[2], NULL,
+				 _("error: failed to execute internal merge for %s"),
+				 path);
+			ret = -1;
+		}
 
 		if (!ret &&
 		    write_object_file(result_buf.ptr, result_buf.size,
-				      OBJ_BLOB, &result->oid))
-			ret = error(_("unable to add %s to database"), path);
-
+				      OBJ_BLOB, &result->oid)) {
+			path_msg(opt, ERROR_OBJECT_WRITE_FAILED, 0,
+				 pathnames[0], pathnames[1], pathnames[2], NULL,
+				 _("error: unable to add %s to database"), path);
+			ret = -1;
+		}
 		free(result_buf.ptr);
+
 		if (ret)
 			return -1;
 		if (merge_status > 0)
@@ -3577,18 +3598,26 @@ static int sort_dirs_next_to_their_children(const char *one, const char *two)
 		return c1 - c2;
 }
 
-static int read_oid_strbuf(const struct object_id *oid,
-			   struct strbuf *dst)
+static int read_oid_strbuf(struct merge_options *opt,
+			   const struct object_id *oid,
+			   struct strbuf *dst,
+			   const char *path)
 {
 	void *buf;
 	enum object_type type;
 	unsigned long size;
 	buf = repo_read_object_file(the_repository, oid, &type, &size);
-	if (!buf)
-		return error(_("cannot read object %s"), oid_to_hex(oid));
+	if (!buf) {
+		path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
+			 path, NULL, NULL, NULL,
+			 _("error: cannot read object %s"), oid_to_hex(oid));
+		return -1;
+	}
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error(_("object %s is not a blob"), oid_to_hex(oid));
+		path_msg(opt, ERROR_OBJECT_NOT_A_BLOB, 0,
+			 path, NULL, NULL, NULL,
+			 _("error: object %s is not a blob"), oid_to_hex(oid));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
@@ -3612,8 +3641,8 @@ static int blob_unchanged(struct merge_options *opt,
 	if (oideq(&base->oid, &side->oid))
 		return 1;
 
-	if (read_oid_strbuf(&base->oid, &basebuf) ||
-	    read_oid_strbuf(&side->oid, &sidebuf))
+	if (read_oid_strbuf(opt, &base->oid, &basebuf, path) ||
+	    read_oid_strbuf(opt, &side->oid, &sidebuf, path))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index b6db5c2cc36..9bf95249347 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -295,7 +295,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal o
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
 	test_expect_code 2 git merge recursive-a 2>err &&
-	grep "^error: failed to execute internal merge" err &&
+	grep "error: failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
 	test_must_be_empty output
-- 
gitgitgadget
