Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF0346AF2
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208603; cv=none; b=TRAti7jNuYSdT7/7862O3pHYzUh27Ap/yXicq3i0p6DKMxqrdF22iEu307S4MsobL4NTTnoX3JtlD7yUYfJH42nKYl6TT1OL7Waed5eECmvMW6Iel/xDToK5VzQXBQPQd0e+p2XrQbThCGAncKHll5UWrmJeIBW2W+sLiWiAuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208603; c=relaxed/simple;
	bh=MY37C0O/HQio15RS16SC7/fuwrWcb5hIRLJoH770T0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOOOL2Tz7gNqBQSeCP2+zUiwNe0QT1GqGOdfwwbMAq/jRoAuODwG1HxeC7mYnuH0k3hcQRV0nzF64ON88tqoBiJCgYnHWlUHgYUU6X9NcHlcwgcmG1SwE5O07umJBxjffmCBnuj63z204jq+wD5BEfzE7gs3GXQxXMqDs+zCQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BwebGj62; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tWTqPN06; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BwebGj62";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWTqPN06"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E8EE7A0040;
	Mon, 12 Jan 2026 04:03:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 12 Jan 2026 04:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208599;
	 x=1768294999; bh=fLVnIqEPSWvz2xv71SnAceecL47uPz44Qhxfj0yapVY=; b=
	BwebGj62doeSn3DeIYjC8wnoRuwwyhgHwu4TMIDeT/g7tW704l4cD6aMICdWKyxT
	0HjXxHm9HduFc3KBxxruIehLJmcAKceKpF0pIfTn4qogRuVHBacOE2qy/OD4R+zd
	BjdcVTzK1jcd1q/wVo3+jTZ8jYrfP5ttaCFAQwHeRgYDvFZ1rlOhYgA94ApggepB
	gFxrznN/I36jCbo5mNVNajpFi5lk/pxdr8fGCT5F8OJpDzli1BOO15Wrx0AWueuo
	I5Ini+7q89jAnMfDIKIUC+8UeNdiq29qQBpn3JnbZv8Mo/lTtNVFh4JXrfz29yVN
	KtQzembIWlZGG8L0phZdlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208599; x=
	1768294999; bh=fLVnIqEPSWvz2xv71SnAceecL47uPz44Qhxfj0yapVY=; b=t
	WTqPN06bbz3na3a1K5F2gGUe3C9cdGLrSz9jCz8Sco4sEo4LayosHXqBb0jvxHBL
	CNFawP9Vq316t2rTfKS2DF19hqxuTF7Jg2PXAz+PVy5kh1iN5pmrulVS848hgeXi
	zV1yV6+a7GVu4sdSxj7U2nEpq1HDnbJhz4G336wU7nFaFS+azy/RGmOLUJEITyxg
	4x513N9tI2AeN6YpoIwxh/QhSAfOzizl7dG0skpKElITWn0XS9QGfzlMQoTKBg8x
	cfrQnub5TCWr72TTuDDCx/sPUtxRYxPEuHSoZODK4wLAQ9E8eBmkNbeHzM/weotp
	exlwTD4bkoQa7q9F7YKrA==
X-ME-Sender: <xms:17hkadVEvA1GIFKjz1JmDxQJCsyi2ewjZ_eUdAuJZ6OXzSl0QISaCA>
    <xme:17hkaVCkLtsX9_WwlgM87ubOx8HEcD3JdjCln1yk7aoFMmobC2Ynn3JY9poZHDbdW
    46oEYLE6g8hmGo7tahZfWpt-8B96ayK-WOAIzcsX9ezPyodD6bLKg>
X-ME-Received: <xmr:17hkaWzeuUiDRYhxecKBjRoft8i95FJ1DS0tRN5JvRYrOkVYxqtMxD5ENU-MBZZWGqNPnYoKBszFg-hVyJ8Bb5UZAKApnQsVPQUrojClaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:17hkaaA_U5H7c7qkQRmo0oMp3CERPcRMe79LbdZkKY10fNXkyfSiOQ>
    <xmx:17hkabZSfX14tgsaXsc1G9u2du_XBB-7O3kc6LTR8hDA_LomKch9eQ>
    <xmx:17hkaag8BSWsohl1mPolopFEFKTpew4RKuc__3qJhsMkixMKj4yEtA>
    <xmx:17hkaV7NbID-J6LGUX7FnAUa2631oV91xGx5vkCCZSXPonT3hFHmeg>
    <xmx:17hkaZdBJEi7jDNLgJaURCJkXJ-Fyyi23kZI_XK9phavjJqgL7UDTPof>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ab70816 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:58 +0100
Subject: [PATCH v2 09/17] refs/files: extract generic symref target checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-9-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The consistency checks for the "files" backend contain a couple of
verifications for symrefs that verify generic properties of the target
reference. These properties need to hold for every backend, no matter
whether it's using the "files" or "reftable" backend.

Reimplementing these checks for every single backend doesn't really make
sense. Extract it into a generic `refs_fsck_symref()` function that can
be used by other backends, as well. The "reftable" backend will be wired
up in a subsequent commit.

While at it, improve the consistency checks so that we don't complain
about refs pointing to a non-ref target in case the target refname
format does not verify. Otherwise it's very likely that we'll generate
both error messages, which feels somewhat redundant in this case.

Note that the function has a couple of `UNUSED` parameters. These will
become referenced in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c               | 21 ++++++++++++++++++++
 refs.h               | 10 ++++++++++
 refs/files-backend.c | 54 ++++++++++++++++++++--------------------------------
 3 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index e06e0cb072..739bf9fefc 100644
--- a/refs.c
+++ b/refs.c
@@ -320,6 +320,27 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
+		     struct fsck_ref_report *report,
+		     const char *refname UNUSED, const char *target)
+{
+	if (is_root_ref(target))
+		return 0;
+
+	if (check_refname_format(target, 0) &&
+	    fsck_report_ref(o, report, FSCK_MSG_BAD_REFERENT_NAME,
+			    "points to invalid refname '%s'", target))
+		return -1;
+
+	if (!starts_with(target, "refs/") &&
+	    !starts_with(target, "worktrees/") &&
+	    fsck_report_ref(o, report, FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
+			    "points to non-ref target '%s'", target))
+		return -1;
+
+	return 0;
+}
+
 int refs_fsck(struct ref_store *refs, struct fsck_options *o,
 	      struct worktree *wt)
 {
diff --git a/refs.h b/refs.h
index d9051bbb04..d91fcb2d2f 100644
--- a/refs.h
+++ b/refs.h
@@ -653,6 +653,16 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
  */
 int check_refname_format(const char *refname, int flags);
 
+struct fsck_ref_report;
+
+/*
+ * Perform generic checks for a specific symref target. This function is
+ * expected to be called by the ref backends for every symbolic ref.
+ */
+int refs_fsck_symref(struct ref_store *refs, struct fsck_options *o,
+		     struct fsck_ref_report *report,
+		     const char *refname, const char *target);
+
 /*
  * Check the reference database for consistency. Return 0 if refs and
  * reflogs are consistent, and non-zero otherwise. The errors will be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9ae80b700a..687c26ddcb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3718,53 +3718,39 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *path,
 				  int mode);
 
-static int files_fsck_symref_target(struct fsck_options *o,
+static int files_fsck_symref_target(struct ref_store *ref_store,
+				    struct fsck_options *o,
 				    struct fsck_ref_report *report,
+				    const char *refname,
 				    struct strbuf *referent,
 				    unsigned int symbolic_link)
 {
-	int is_referent_root;
 	char orig_last_byte;
 	size_t orig_len;
 	int ret = 0;
 
 	orig_len = referent->len;
 	orig_last_byte = referent->buf[orig_len - 1];
-	if (!symbolic_link)
-		strbuf_rtrim(referent);
-
-	is_referent_root = is_root_ref(referent->buf);
-	if (!is_referent_root &&
-	    !starts_with(referent->buf, "refs/") &&
-	    !starts_with(referent->buf, "worktrees/")) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
-				       "points to non-ref target '%s'", referent->buf);
-	}
 
-	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_BAD_REFERENT_NAME,
-				       "points to invalid refname '%s'", referent->buf);
-	}
+	if (!symbolic_link) {
+		strbuf_rtrim(referent);
 
-	if (symbolic_link)
-		goto out;
+		if (referent->len == orig_len ||
+		    (referent->len < orig_len && orig_last_byte != '\n')) {
+			ret |= fsck_report_ref(o, report,
+					       FSCK_MSG_REF_MISSING_NEWLINE,
+					       "misses LF at the end");
+		}
 
-	if (referent->len == orig_len ||
-	    (referent->len < orig_len && orig_last_byte != '\n')) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_REF_MISSING_NEWLINE,
-				       "misses LF at the end");
+		if (referent->len != orig_len && referent->len != orig_len - 1) {
+			ret |= fsck_report_ref(o, report,
+					       FSCK_MSG_TRAILING_REF_CONTENT,
+					       "has trailing whitespaces or newlines");
+		}
 	}
 
-	if (referent->len != orig_len && referent->len != orig_len - 1) {
-		ret |= fsck_report_ref(o, report,
-				       FSCK_MSG_TRAILING_REF_CONTENT,
-				       "has trailing whitespaces or newlines");
-	}
+	ret |= refs_fsck_symref(ref_store, o, report, refname, referent->buf);
 
-out:
 	return ret ? -1 : 0;
 }
 
@@ -3807,7 +3793,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		else
 			strbuf_addbuf(&referent, &ref_content);
 
-		ret |= files_fsck_symref_target(o, &report, &referent, 1);
+		ret |= files_fsck_symref_target(ref_store, o, &report,
+						target_name, &referent, 1);
 		goto cleanup;
 	}
 
@@ -3847,7 +3834,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 			goto cleanup;
 		}
 	} else {
-		ret = files_fsck_symref_target(o, &report, &referent, 0);
+		ret = files_fsck_symref_target(ref_store, o, &report,
+					       target_name, &referent, 0);
 		goto cleanup;
 	}
 

-- 
2.52.0.590.g1f87b77810.dirty

