Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA7338F4A
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710886; cv=none; b=cpwGWFCMiYDzI8smcpcSdv1voRL+h/AptQRySsPWt98BSBnApcqOLhd07LLstu8MTWYeG2N5tJeA3Dwwe9sDbYz/p7ghDy9pUhQlC1iooqD2xukcLCodSdgMGirtEfrhvDXNwZn/KxTdzxrQVm8g2IITiCgnRZCcCexehMZfi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710886; c=relaxed/simple;
	bh=De5MOCgpAobGlyRPIboDLMVF44c1xwBGDznUgINXmHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sT8AEhHniAeBZ7Who0hhkjp1fwwq+9EgThY9KIfdgGyUvmDr44oPHNcF9gth7f5eDItH3fvi84+PJJY98SbIRHL+ZN6Hdwjn5fwdnlPll8rbz0J6pTn1IarLX++h7FsrIVxfNy9/D4HyoHoWBopYGxh0ew7UIrwOSn9M5yQyylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FWtzEcrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xvyzWdY3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FWtzEcrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xvyzWdY3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DDEA11D0015F;
	Fri, 21 Nov 2025 02:41:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 02:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710883;
	 x=1763797283; bh=htbjbOP+mtf62FXJPYEpUhkysfhzH2vZYZdYnL8Gysc=; b=
	FWtzEcrA0xcwtBG0KFuht+jFnjSLVg31CDIhGFzHCILi2k0uBGvveeCTTNSXAZ/P
	YoNMMjpAa7UZ2cgLEpSbiKxg2U6hBkqLVEpXZp0wEqwI6ZdQ0hmsfSzn0Y6qFPFF
	LE0TvkfgNF6XVboJap2rzVald15e5MQ6/C1i27IyrImn9N7hh3HfuQh1LjC+mBuD
	GILPG68hOBXwc98Ww/JurT18ywUoAoGssBdqmfmhpvThcSuAin0kYJghmgRw4iC6
	e1j+DSmowL7/e6W+bqpmqfGGxQpmYMgpjCmgis1E6OzACH/QqteSuDd9sigUJt2v
	Lc8czP8Ao2KpHHZOoQc+tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710883; x=
	1763797283; bh=htbjbOP+mtf62FXJPYEpUhkysfhzH2vZYZdYnL8Gysc=; b=x
	vyzWdY3KNSfvyZTo00hoJLJNvBM1/cxn6whatdINg4613DDgTd0Yw3K1OcWGQBQi
	sJaNqRifKRS+rba2KN0kEQLbdnGFlyESgzZvV5pd6UPps1B1bqlC3Vgx5Nq1ys3w
	ojqDET0uWTf7eNsIw98RsNgCklgsMU7AvS9ty5MBFaH4ZjtPjV67rvZwACWjkTWN
	kDtChW2/E/9Go6IGLWprP70F8j5wPeRxdDbe8YyHP4dEjMJ772n/PXrqTVQFYY65
	JopvvI7z6VYDIQRzO7jiGUOvy3ip7wTurL3PdlmPKxSIZZhc/tYlJXGbyucy34Xl
	zEriJjq+yuPcCPyZh1JfQ==
X-ME-Sender: <xms:oxcgaW7mb6l7Rqdwux4OH4peOhBl_JE1met2nCMCBOQ5T4ph1-PZBA>
    <xme:oxcgaXXo5TDmmQ2v_OzvVU4rpKYY9Bd02eFlmQP2M3f1W4lxCPowuzyEEd-4SWHMt
    HJe_JQsu3RQdVeJlcejvyE9s9jbwiSbegime8V8jsMbJFz0YOFpdA>
X-ME-Received: <xmr:oxcgaS0gF1cScm76RTcQOcR3td7NYHybdHZiimf2-BVSU0JxwWk8KgSVaC4FwPO8xkLguLpX5AKsUt4l_c4hvDnLuWroqBZWBOF26-sNRaGR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukefffeegfedvfffgiefffeelhfekvdfhvdelieeilefhgeeihfegteehledtuden
    ucffohhmrghinhepihhntghorhgvrdhrvggrugenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oxcgac2kB3RU3YknPReogXn-PBsnpObCme-lvOjdbU2J_wME4HvIfA>
    <xmx:oxcgad_UrmL7Tv8TnXM3e-XOLaLznF1jUXTNtQ0H1JsP61adIF4Kzw>
    <xmx:oxcgaR1-1sHUlnD1nJcNUxaQ16k0Mz3y9Z_HCYXvgvzlFRKNmUdcOQ>
    <xmx:oxcgaS_KMBRBQpfsGG1t11JbhKneuO_Q3HtpujFLsdkCgKMm3-lVjg>
    <xmx:oxcgaQyAZOwJvVaCSW5suzMGypVXsTRa4fpYLeUZcGTnZTAJfdzPWo6W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aaa8f36e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:51 +0100
Subject: [PATCH v2 06/19] streaming: create structure for in-core object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-6-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for in-core object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/streaming.c b/streaming.c
index b8ce82483f..3af2f0c776 100644
--- a/streaming.c
+++ b/streaming.c
@@ -39,11 +39,6 @@ struct odb_read_stream {
 	enum { z_unused, z_used, z_done, z_error } z_state;
 
 	union {
-		struct {
-			char *buf; /* from odb_read_object_info_extended() */
-			unsigned long read_ptr;
-		} incore;
-
 		struct {
 			void *mapped;
 			unsigned long mapsize;
@@ -401,22 +396,30 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
  *
  *****************************************************************/
 
-static int close_istream_incore(struct odb_read_stream *st)
+struct odb_incore_read_stream {
+	struct odb_read_stream base;
+	char *buf; /* from odb_read_object_info_extended() */
+	unsigned long read_ptr;
+};
+
+static int close_istream_incore(struct odb_read_stream *_st)
 {
-	free(st->u.incore.buf);
+	struct odb_incore_read_stream *st = (struct odb_incore_read_stream *)_st;
+	free(st->buf);
 	return 0;
 }
 
-static ssize_t read_istream_incore(struct odb_read_stream *st, char *buf, size_t sz)
+static ssize_t read_istream_incore(struct odb_read_stream *_st, char *buf, size_t sz)
 {
+	struct odb_incore_read_stream *st = (struct odb_incore_read_stream *)_st;
 	size_t read_size = sz;
-	size_t remainder = st->size - st->u.incore.read_ptr;
+	size_t remainder = st->base.size - st->read_ptr;
 
 	if (remainder <= read_size)
 		read_size = remainder;
 	if (read_size) {
-		memcpy(buf, st->u.incore.buf + st->u.incore.read_ptr, read_size);
-		st->u.incore.read_ptr += read_size;
+		memcpy(buf, st->buf + st->read_ptr, read_size);
+		st->read_ptr += read_size;
 	}
 	return read_size;
 }
@@ -426,22 +429,25 @@ static int open_istream_incore(struct odb_read_stream **out,
 			       const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct odb_read_stream stream = {
-		.close = close_istream_incore,
-		.read = read_istream_incore,
+	struct odb_incore_read_stream stream = {
+		.base.close = close_istream_incore,
+		.base.read = read_istream_incore,
 	};
+	struct odb_incore_read_stream *st;
 	int ret;
 
-	oi.typep = &stream.type;
-	oi.sizep = &stream.size;
-	oi.contentp = (void **)&stream.u.incore.buf;
+	oi.typep = &stream.base.type;
+	oi.sizep = &stream.base.size;
+	oi.contentp = (void **)&stream.buf;
 	ret = odb_read_object_info_extended(r->objects, oid, &oi,
 					    OBJECT_INFO_DIE_IF_CORRUPT);
 	if (ret)
 		return ret;
 
-	CALLOC_ARRAY(*out, 1);
-	**out = stream;
+	CALLOC_ARRAY(st, 1);
+	*st = stream;
+	*out = &st->base;
+
 	return 0;
 }
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

