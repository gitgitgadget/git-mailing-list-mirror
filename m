Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93F347BC9
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208595; cv=none; b=AHZopyWxHiezl2KgVpIhu3T6NMWZTo9qHPs5P51kVOCt27lnZGLYBnzG7Qe03GC2uW/2/wchZdiYuRgc9jlvEpw1CrQscFGOrTqT1BYx2/KLJHgvNjvBnjNV85YPmsEp85fASBFDexX8NMej3qcp8JDVWtAoE+f0jD5R5OVqOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208595; c=relaxed/simple;
	bh=V8mx9Jsmz4u2c3ki+QqgEKDFNI7sjK4sFwMWSjs4Jeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DqDnGp0Hl6R85n9VkcRy/4SyMzoduEKdHtH6l3C6GHeWzCKz4tib9JcUl+vcIwX9ET0pcGT39TgVHW+8l5j91JpklPySmGqrrOJfORK2XTWtBMQ74095te/qV6tXLp7dINowK3IcL+LHtIdeaQEhDFv3Uu97n8NVHvzKRWnCr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DSJIdWyn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ufPUHM11; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DSJIdWyn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ufPUHM11"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9AC9C1D0008E;
	Mon, 12 Jan 2026 04:03:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 04:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208591;
	 x=1768294991; bh=qe54UKlYftJB6nLnzXxvaK94ih03tpCyFimrEKuKwdo=; b=
	DSJIdWyn74j8x1W2q0FRZJIlphjj7L+/OdL3abdbOmbyKZC0OyqwkkIAfH6zCCuC
	gHllCFSuVyUynQbH2aGLvjWTBDI7R/8QNkGj1JqZwyJ6j7jre2QwZe3tHyeiG0TS
	7+IIIOqEsBbBQOjn6i0hmJv8Mk3ejfBHPHL9mzov7pc1ZuMDxkRb+BjKA5AAmfZd
	zLLdAmXAtFZMFXJLlG6VTu10UlenZzPSXSAHuRytemAqLPXhB90EqeFGpd8bxdF4
	RUbxdVKFihMHVCW5NQ/PlQryiT9ba13LoRzcC9p5Z/KnPp7UPGfpC/YULLnzQUqh
	Ubaaq6I01NG4g0sSXGiYCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208591; x=
	1768294991; bh=qe54UKlYftJB6nLnzXxvaK94ih03tpCyFimrEKuKwdo=; b=u
	fPUHM111svQ2bRrEWILYNujH4S7IWD+fv4N0z9dq6SVgRvojMlEgJyo5EsOrcCls
	PShlrewMbQfXFUfbcvgzAqrtz46LE0IG+9WIauqeK5LTIFxbvpHWvrRe5Teq8NwW
	ZDNJgCxQSY/ITxabxd1UjbF9RR59U/vp72J6iRL63ifgp4Afzijz8Tn0CQO1yhy8
	yPwX/GlxEIljWdGRxoWhljd+RNUXKaBp0sB0/doWKWd4jlH0JhjJnkOLL8uvN9wi
	TFWldCTY+DwR4YKkNk/e7sj94r+JYYx3z2EOSDNRHfK0dUPJTuT7KHXwVEC5JmWO
	UySAo3j99doEk3ibkVWDQ==
X-ME-Sender: <xms:z7hkaR_nhDfcrYlNEJV87Bg6_F-oudhTOuYwtiqG61BH_wks1VPwPw>
    <xme:z7hkadI5oq8VReEUpbABjtydGVhwQaiiunN7Hu8ua5OxXsKnK9ORIqZCihueYMrT-
    -LM9zaArB0ipaPzCBTW_0ZdKyHQSzVhon45nUSVvQItR8buHa2j3w>
X-ME-Received: <xmr:z7hkacZSGyYVhhYdWjyP11v6ys34JzxxTC_v4KXna3E1IhDe1y5nbZWxMgeUSTYwqr_LrynlLmO-OLeT02teVRAiQqp5_fSPchC68oe1YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjih
    grlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:z7hkafKlUrH_qIFdtTuVbq-rkW1IgLNCNnkDALBk6OfG5DAg6YffRQ>
    <xmx:z7hkaaCPwQImAWJzaqK0KHyWKdsfrVLrxu1dr951ztLHH_UFx36pZg>
    <xmx:z7hkaUpohUXU6Fp8Dc_krM6UAnqpfdFRr_5H-rY019Z_xRKrkdBdXg>
    <xmx:z7hkaVjtijOBfGvQIM-fY2Hw7qf_8Eo4abZQEI8WG6IFiOaiRzf30w>
    <xmx:z7hkaTnfRQxtYK4kVlk0ENhn9RRFSowcyiYORqLw7lPUasYFqQ4tYSV2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc538f5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:55 +0100
Subject: [PATCH v2 06/17] refs/files: improve error handling when verifying
 symrefs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-6-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The error handling when verifying symbolic refs is a bit on the wild
side:

  - `fsck_report_ref()` can be told to ignore specific errors. If an
    error has been ignored and a previous check raised an unignored
    error, then assigning `ret = fsck_report_ref()` will cause us to
    swallow the previous error.

  - When the target reference is not valid we bail out early without
    checking for other errors.

Fix both of these issues by consistently or'ing the return value and not
bailing out early.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9972221f9f..abc2165339 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3737,17 +3737,15 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	if (!is_referent_root &&
 	    !starts_with(referent->buf, "refs/") &&
 	    !starts_with(referent->buf, "worktrees/")) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
-				      "points to non-ref target '%s'", referent->buf);
-
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
+				       "points to non-ref target '%s'", referent->buf);
 	}
 
 	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_BAD_REFERENT_NAME,
-				      "points to invalid refname '%s'", referent->buf);
-		goto out;
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_BAD_REFERENT_NAME,
+				       "points to invalid refname '%s'", referent->buf);
 	}
 
 	if (symbolic_link)
@@ -3755,19 +3753,19 @@ static int files_fsck_symref_target(struct fsck_options *o,
 
 	if (referent->len == orig_len ||
 	    (referent->len < orig_len && orig_last_byte != '\n')) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_REF_MISSING_NEWLINE,
-				      "misses LF at the end");
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_REF_MISSING_NEWLINE,
+				       "misses LF at the end");
 	}
 
 	if (referent->len != orig_len && referent->len != orig_len - 1) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_TRAILING_REF_CONTENT,
-				      "has trailing whitespaces or newlines");
+		ret |= fsck_report_ref(o, report,
+				       FSCK_MSG_TRAILING_REF_CONTENT,
+				       "has trailing whitespaces or newlines");
 	}
 
 out:
-	return ret;
+	return ret ? -1 : 0;
 }
 
 static int files_fsck_refs_content(struct ref_store *ref_store,

-- 
2.52.0.590.g1f87b77810.dirty

