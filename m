Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01A34845D
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208603; cv=none; b=C+Y1GnPYz/DbFQAHgBaUUfax4lTKBX4QvPRdmjJyPFrOktWTs3jql0us1njUFzM767yUHQ4dtrWcXTZMicrVuNK7ieuq2IUtGfDD/C9TdSK66/UQ3lZ8OFsF+uf1BamZ1le9nyy347gNLvxlBLwmcAL3DLdY2rze7ihOt1/d4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208603; c=relaxed/simple;
	bh=SQhC3rQuXAgRJuC+27hbM6mbYlkmQhrR0c26a2Cxnm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DswXYtr6FxB9zcRuiA6oiPiKs8/gqr9whhxfXCp2W9r2Lx8Llo2/r5fh8lKOH895uuTmBbPGeJzlA4glKXY81Z3a7pZe4kzJ/eH9MrZzOIBu5cZOdxyprBDMmoZOtfcz4tJlOO6cyrnE8aSSylDAMthDl429SOhtBwgHh1Q+5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=guiWcHkM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJwABc5w; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="guiWcHkM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJwABc5w"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E425F7A00B1;
	Mon, 12 Jan 2026 04:03:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 04:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208597;
	 x=1768294997; bh=pn8VB200b3e3N6t0ZRqcXbIEtBO0Pxw1wJ62TyDQNa8=; b=
	guiWcHkMJIkodPa9sB/18zWlo1n7Va4dKK4ujYRr31KvNLB0mWdCYWb5NVdKkERe
	gTIA3rj7Ky6po6Cmc4jqsKDPztMoF25MDhNLmPGhBGkK1SnJAtwbxGKWscG8geWv
	YKZJhVF+L41cGaZ3utHtx/9y502Ibe8YUiKrj4NLFOWdqe8nyklHJwC7zMv7G6fN
	SFLQYwu0dWTYuXAccXebAKCBXV/vpRLv1XgiQPTuzeMKFj3WptPqqYB5jQgZefuR
	coklr2GjMDEQSFDja/8ImCkULVS3qZgtWgULKcTvvGukyLajOMVhmIBuZnnLqj4x
	fDYqOsK3HHdE00R/8K7J3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208597; x=
	1768294997; bh=pn8VB200b3e3N6t0ZRqcXbIEtBO0Pxw1wJ62TyDQNa8=; b=a
	JwABc5w55V2y5N1XuoIXUz1eeitprXcJaykVjEd/ce35MReVSGfgGmhmwYsj5b2B
	qC7S8cqp4SIOw8a1FjOIkOEsGrR+FZVDdRuJwEiQc0KvmfeJcEUwuxNB+wa6kt1J
	ledj7kShsKXwnsBDIqM4VHhxa6u5yUddWoC3Mu29DSyw40xqwkptUzr/YOfllZBr
	p3o2B96zk5z1FZWdU3fSyRuFfOoZ1VawX5DjuHAJvyI2USwdhluzUCyMzN1fueGu
	mHGGvetSTdjbn0SebX2I/1JJd7t/OdCt5rOvzviwIWfelOLmRO16A+LEUSa8K9yI
	xxKFjMNeZWxNC5R2MReqw==
X-ME-Sender: <xms:1bhkadyywIFXAqFC45tXTsDrdNAZjSQoObiFfwXci9-VeJFl1AdeQg>
    <xme:1bhkaUvHX7zIEhlSP445pcyYlkcNh7_AUzd3QmlFbEAVdf806g_EQIaE5W2g4iIBe
    qEHXwMy5ETTnM2b8ql2tFMvKNamZIRdCnKKf5Vt7J3u1w_sVOp0new>
X-ME-Received: <xmr:1bhkaUtFdzlCUzgg4FGGfT6R7u_AYH-4tx-Afjzf6FE-NkQ2lWFCt5YSHqN6pEYQpdEaTrMratD9bhBX8Uk8yk5H9uqtKFTeIoU2B47WBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjih
    grlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1bhkaZNm-HPztU_2plozhtyqrYNyIIQGVxSRoUPrqg9KGhC7aTuDDw>
    <xmx:1bhkaS060QDyTAJryX3pdNygrMA3CCrnj5smOYtadfa2zh_wZQ9UwA>
    <xmx:1bhkaVO0ZwWYxlsNYlNsae7Cceu5llzRvjHyq-zL1lFf_GTkQ7TrCg>
    <xmx:1bhkaS1jgR0ZroKuMhZs096FySwzvyP4PcqM5vZzjeluEAvuNmaQEg>
    <xmx:1bhkaULcxfVzCr-56auIT6OIfUv1UjGDASUqrQ6cx1O3XlGAJ09MXSdy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4949595 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:57 +0100
Subject: [PATCH v2 08/17] fsck: drop unused fields from `struct
 fsck_ref_report`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-8-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
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
2.52.0.590.g1f87b77810.dirty

