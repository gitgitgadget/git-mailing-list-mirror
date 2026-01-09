Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532835B159
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962383; cv=none; b=dRFSX2KDbO/FmX4eCXWz8EzjbNQaMQC6t/B9niGodCYeh6dIz10KX+wrqMVIV9gjkxGWWaioDChN6273ADrUW3TYqyJP0uLdaeLTwVIdgjLVfdEbQ+nFZcCtFH2GaXnHDiqga5JvPehur0jKFqSBK6A10sC7luzRyI/7NDOYAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962383; c=relaxed/simple;
	bh=H+RiuTqClsCqS9Sdc9i8dIWdSdP5j6v4jNf7yC3vO+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUEl8D36O3WmR/S2m7rCDg3sckLPbsOiTR/RbRD/bM+qkn+EeQYL1+nWzzV7VWurri+jylndV+3mTKnWInOW6dpU1kPVOWolh6JWjXUBjaUuBdyI31nDPZ52ioRutCrP4lHZ1sTiD5iAEHiw+3KqQbm6EV4lMvruuV/jzmLbEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WE6zxZHJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PtLf1LAh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WE6zxZHJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PtLf1LAh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F0F81D00185;
	Fri,  9 Jan 2026 07:39:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 07:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962381;
	 x=1768048781; bh=HXSGwb+BySU9UcCSgr3uGrUqplDPnkO1RG8Qhzzbr1E=; b=
	WE6zxZHJ7JyFW5UDHyTMUpcVrrgIP33Q1jssnYo62MY9woHdhZOzwejggMdDJHRp
	3HbP1QaCdaZjnWHuhYfIEhv6P29vJaAHzoyqqinGMVNtLxawpSatnvf/KuDKmpP/
	VNlFaRtipudy0RqfD/XMe4fwref+svJIQeaq1auSw8Fv/fGeXlw/pKo4Mi5Wsp1C
	A5h8I1wSjYUyw1gXHN46t85Clk0MFLS1CI2i2iBAwxPGUk88fnc0me2oF2r35TeU
	ydInH63VaBq6VW6GPgzFRljC3rHXDy8Fu7iCll31FGCfOPCHi8gQ3jW4KTKaZTRL
	oXYEOR6VCAv6tpF8d9gSEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962381; x=
	1768048781; bh=HXSGwb+BySU9UcCSgr3uGrUqplDPnkO1RG8Qhzzbr1E=; b=P
	tLf1LAhrk1fU37gxMCTS3at/bxMRzOA2IcomePoU0xPYTeaZHtQ5ojjnxtI3CoRd
	sQx8TQByHm9pp8cgDZ8GXhUP7RYTbcBMEdiuLTN5nDu3gEDP9L2dmbjn10LGUvdS
	WWXhqyC2jDS57nV2jqnF2SaK1vTclN1jQCLVdlzEPy41Udefa6+tyFxY9ir/FQXi
	pMU3H+nr3MC+3xlHo6K+Y5lOM4wV1oVJrnlw5X/U0IbahKz2xuH0hh/fQ0ruLyPk
	YCyL+Q+4LvcnkbRVDbWQofQbshVQodStetYvTZexD82eZTMXJT0z3Fhahm/P+pYf
	ogGyZSsHhsFEALlpf+4dg==
X-ME-Sender: <xms:DPdgaSo_h0kMMzkoUEvlTEcCsTnErqbAMQWsiCWAwJ_1ay-VFuDjCA>
    <xme:DPdgaYGY3ymJalvkaCYh2-wH2s6aFLR6akjIuj6ZnlXmBDK4zGxp-X1WUaV9RiepH
    Y4gaHE8GptF7q56Gqs9kaOfHrkbHyQhbsH95tqlMKDsQToSk15TGw>
X-ME-Received: <xmr:DPdgaUndoWBeyMUTxNkNZbs2gRwdfq0yl-f6lpWQwNXypJvTEV_9B-cUBRwWz7Xrhxk1bX2gJYlm4gxAxNQPf57NyetUmhbJY6vkbxFOHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DPdgablR0ccmYuavnrI3DZaiqEtECddQFyuc88FblmutPUAB3Wmnug>
    <xmx:DPdgaVt9eVLSj_p-tfPMMZ5mcnftkUBCOsB5doCsYLhxHzYfdV_ziQ>
    <xmx:DPdgaemiz8jxR_qPeIq52s18nVne2xOSAzhRJIBtof3Skv_1s7T-3Q>
    <xmx:DPdgaQu9ZLctAVLSSalryIm1iKhMql8-DvnwyJ_gEKmSAn7Aqo0Llg>
    <xmx:DfdgadhQ3c_vnjr1Lyi-s8OIFofST6YVECeOjj2L3TMGlvHqICCVUp-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99466b3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:31 +0100
Subject: [PATCH 02/17] refs/files: move fsck functions into global scope
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-2-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When performing consistency checks we pass the functions that perform
the verification down the calling stack. This is somewhat unnecessary
though, as the set of functions doesn't ever change.

Simplify the code by moving the array into global scope and remove the
parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 297739f203..feba3ee58b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3890,11 +3890,16 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	return ret;
 }
 
+static const files_fsck_refs_fn fsck_refs_fn[]= {
+	files_fsck_refs_name,
+	files_fsck_refs_content,
+	NULL,
+};
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
-			       struct worktree *wt,
-			       files_fsck_refs_fn *fsck_refs_fn)
+			       struct worktree *wt)
 {
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -3955,13 +3960,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 			   struct fsck_options *o,
 			   struct worktree *wt)
 {
-	files_fsck_refs_fn fsck_refs_fn[]= {
-		files_fsck_refs_name,
-		files_fsck_refs_content,
-		NULL,
-	};
-
-	return files_fsck_refs_dir(ref_store, o, "refs", wt, fsck_refs_fn);
+	return files_fsck_refs_dir(ref_store, o, "refs", wt);
 }
 
 static int files_fsck(struct ref_store *ref_store,

-- 
2.52.0.542.g9473a8513b.dirty

