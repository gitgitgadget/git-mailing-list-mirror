Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9135C199
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962398; cv=none; b=cuM8zUo6sFEdwpa6ppq7yacjRNBpjExwiLpIk5vzhlNYFVIDSkbVaEFCWjbpaM57hrS/1dVS9U6rmhmCB0+E1PG0wajSsSfsDurPmYgls1mVSl3nUv0QMw63c2gxbRw3jN5jm90wSPMxuK7NxPa3/D3L58XEtj7gsBoBVvQQ5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962398; c=relaxed/simple;
	bh=ZUPbDObJwMxN1DlSt/oL+yySHm+Qnhp8AYDt+ozSRlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EC6jpl0Jcm72iJ09nJE1xbm8XSglg83k2eCgvUgA9MgtJYgTVAeALP6qNAGGiE/v6DzQdV7RssJiZrt/Sa2o7p8GySw41C4vf9evJM+seHU4gKf7zj8pbIIvOtAe/kZODuX0J+CdgnHfE1tRUnufwhQw+rAF08oQ74NMp7GjUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D7bPX2U8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCKcHdRs; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D7bPX2U8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCKcHdRs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFCB37A0174;
	Fri,  9 Jan 2026 07:39:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 07:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962396;
	 x=1768048796; bh=vaE4I1Z11qkjvhObRUXSKzVXSXZjNH+dGEknsyMQI0o=; b=
	D7bPX2U8tW5Mdcjuza/sVxf0+4tSLWM1A2E8ANHvpRNlJy7zgkG6AO/ZKnFGWKKF
	wuPafKC3lxtPJ081OcKiQrcirQC4kiO4aEGV9uuB75Fawl6yvkaQuPmpyMC5qegb
	dhWBwtZ5soVa0tCRBabGwFjLSvMkSbeDgCvT0Y6WalFmUsHA9yUB4t5d5DS/OVRD
	Wr0ZIV5+o01jmcW1uqIMNfoi81lVFEVb4oeSo+HeM4jKeAqKZJaonpI66+IhjQNp
	Ptzydno5lOr/JfOeuoh/K+DIpJaagEbHfxQZsc6KfLtHUkr0qY7t0FIUKMcoLoF5
	/v2OiwXU60k/6tbqLPmAjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962396; x=
	1768048796; bh=vaE4I1Z11qkjvhObRUXSKzVXSXZjNH+dGEknsyMQI0o=; b=X
	CKcHdRs5qaSK1Q77uqbxAIW1APfWwrSVYVv30NrX91jH5TLj6DB2r2Rl6JvZ8Z/7
	EOynkMKyif0givh5MNbXYMvuij5EUiVt6a2kHSgpTbhYDMT/RJHcjPnk0lx0W5Cf
	V7fmmXyAnTw4ovDSJA3IuHP9B21qHbfSOxpZkz5nBGX19cVsZ6Nx+UivA1o1uo1d
	71z6xEVIjuX/UllgXl272EgaN7SfSUaDmcuMNelzUjCilc8jef3I1fRI+rxy5o3l
	DelJCTRkJ7ufIVr/DAgYS5OOpa0Y5jwqdXa6w+vtD4InrCP6dAwoeUIM6XjGaDHn
	RtdRPbn//bM/w/4NbQA4Q==
X-ME-Sender: <xms:HPdgaaBlBqGyjsZKO5ZPSPwCk2zBpadYqYJDhPmpgQIVC41EmPSZLg>
    <xme:HPdgab_8WHDlggFzgKQPr19QcfUAIreSKhJpb99znI-tkDuC1gyO2FHRJtgQsC1Kk
    Bk-9xMotLA_47lw3TVIoViSVhDCsfXHhMfjtkW-vw7EMTWMP0qV>
X-ME-Received: <xmr:HPdgaa8_iZ_UmH45yRax-EdUDB4y4BooBLXRj2ZSLKaWXNS1sbKLXmTm4_uD15B390tZtEqFcVHSJZmUMc8SRpA9rpbZDIC5E2kpRTIx9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HPdgaSfbxZzihXv8bAv3I12RADL4DuXY15faveUf5o9Ef_IWQZIwBw>
    <xmx:HPdgaTHVeMewZdoiGESHINWOZGFrBHYXaBih7VB9Xw7T8hqvbfMsRA>
    <xmx:HPdgaQdNuo_MNuBLuw7fapviCYNRN23qeeAPusahkPoYvYCpDCCDOw>
    <xmx:HPdgadEfzhVfeXkh8_btUZDVOGuSRtIsJH2yeKOjKLS-3xx4Ahkt9A>
    <xmx:HPdgafZIUvmGCwaKS74ovbLnwfEHgFq5ylTNAoW-7BpzFo3IMzR3vvkm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3df6a08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:37 +0100
Subject: [PATCH 08/17] fsck: drop unused fields from `struct
 fsck_ref_report`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-8-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `struct fsck_ref_report` has a couple fields that are intended to
improve the error reporting for broken ref reports by showing which
object ID or target reference the ref points to. These fields are never
set though and are thus essentially unused.

Remove them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fsck.c | 5 -----
 fsck.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/fsck.c b/fsck.c
index fae18d8561..813d927d57 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1310,11 +1310,6 @@ int fsck_refs_error_function(struct fsck_options *options UNUSED,
 
 	strbuf_addstr(&sb, report->path);
 
-	if (report->oid)
-		strbuf_addf(&sb, " -> (%s)", oid_to_hex(report->oid));
-	else if (report->referent)
-		strbuf_addf(&sb, " -> (%s)", report->referent);
-
 	if (msg_type == FSCK_WARN)
 		warning("%s: %s", sb.buf, message);
 	else
diff --git a/fsck.h b/fsck.h
index 336917c045..bfe0d9c6d2 100644
--- a/fsck.h
+++ b/fsck.h
@@ -162,8 +162,6 @@ struct fsck_object_report {
 
 struct fsck_ref_report {
 	const char *path;
-	const struct object_id *oid;
-	const char *referent;
 };
 
 struct fsck_options {

-- 
2.52.0.542.g9473a8513b.dirty

