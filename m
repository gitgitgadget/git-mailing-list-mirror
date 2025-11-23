Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7C248F4D
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924412; cv=none; b=TX0R9nzHu2JAOaVp1pwOuDeEwu+eIAnzcCqiE+pcO34VxcBIu99HdJd9xLBUMi4eUPE82PQNPi+RR5u39NYWPza1SX12AlKm0udjjapEiNf/FPlN84uiC5qjKJ55/6ilN66aPYX9Fn24oQ6FwygYpLbrhp1FkOsBC2CAK8NFxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924412; c=relaxed/simple;
	bh=Qya94C9ZLPlR/3102l3NZiDnlb1JQtR1B2TOjZj3WTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWg3LXs65QyR68e2ygxJR1wXz91w3Jpxi2lrK6T0va249wooEBlZ718jhEv/rTvqhZ8ACd9RDNqYozoK/Nq5ebQlNO7muVE0DTu9sqpr+JpAjVW3F6pWtrtmnqbwS5+WvyK3M+eH4JD+B+ZLg+H2G/6xeCREMcfiNDc5664jgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AGoYK8XV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebf71wyp; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AGoYK8XV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebf71wyp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9AF571D000A1;
	Sun, 23 Nov 2025 14:00:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 14:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924406;
	 x=1764010806; bh=pCYu11gEqPTP2uCvXeFxxTVaIWawU22lCcFL3VNjrps=; b=
	AGoYK8XVvIGU+lV2FsGwwmkY5G8dYY/BKT1SeBGHtTSUmul7mK0VliK8ONYq7ap3
	w0IjjXQffsMzt5iQH3YbR8Cy0oXre9ML89q5RWfDHNd4LATH577wbpfe1oqMsOD4
	m9MYjkwyCtNDa/RwybdpFfSp/LXwYSMWDchpyPamFctcO0to92hKaSaytT+9w8os
	Ku9zIaiSlNhXGGyU4fVpxdfffG7NOt30E+Ot/xsTFO5W1J9ANdcVMq2NFY4AOer2
	oB3uZYCuflxJKaHBH2Hpv6Hk45xkQsSHwW1AX/wSHPW7vzVFCU7JXVvn7Qwc/SGI
	YooHwbkBiAEQ4pRFUhWikw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924406; x=
	1764010806; bh=pCYu11gEqPTP2uCvXeFxxTVaIWawU22lCcFL3VNjrps=; b=e
	bf71wypamijDGwsUWYdJK0kx0VNcU5RKS6AajnJKxSL65ReU4yyh1HBN668S6ECM
	5r894AbySbiYYiS3y6+WCyu4sGIc/U3hGAZq4VfF1wbqY/TcdAQEII8ajuxFc87O
	gX5b2BwbrBBM43vNxrk3r3ehwhwsvhDLhsEuMYKySuJBqcLagG5Qi52qqZSg+qyb
	Ocr2DGBZa4uTHoBWKpnXOhShRjImWo47nk6VO1UgpeQL+337k2olj8KPF4hJDqvw
	fFYRM6ScXDuRq1DdvjpTe6OcILHD0mPLw7dEcG4x8wBApPstF2Tgw4KFTxzkGD/U
	NYynfpZS302TqzEIaT//g==
X-ME-Sender: <xms:tlkjaU2Ie7h8_P-mVQ0vPPM14o8w-1FaNXiP_RQTjL94C6IfTYjM5A>
    <xme:tlkjaWH3OFk6J6LthFb6upclbIvF660l9LvvzxwpkmQFBe_Dccsm1NTV0XeFGC7wv
    fnwXYjWbfH2e95RwT27lbe-HCOSxlp4gl7yrOh3hurL1oNfk6-QEQ>
X-ME-Received: <xmr:tlkjaR6I2MR09YlslQ_D15kXNgMJh1aMUcokWgidU3U0xUfAfbrh1jK70odEamQ4iUPnvg4mt4Dqpgfu7Eg_QpYhdewzHjqrJ2MCs4MV0kNjlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukefffeegfedvfffgiefffeelhfekvdfhvdelieeilefhgeeihfegteehledtuden
    ucffohhmrghinhepihhntghorhgvrdhrvggrugenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tlkjacv2RLMm_Dtn04OkEmg4T9DjxQvHAmESZ9MNiIOI-Gj6bGFhjw>
    <xmx:tlkjaS6sfIR3YAEQxu8YvJbkp5DByKF_VfjHB5_eL17ZJ4adK-X8wQ>
    <xmx:tlkjaXXxxFjch74fxMwIKtpT96C3VirC_H-2HKlOeBrddfq-7BR5Nw>
    <xmx:tlkjaU8AkVKBaVmNqI6xRPhl7LQ7IZBXtjWPVopmUPbdGHG8aovgoQ>
    <xmx:tlkjada_jVkiSIl6nwbydgpUAS-_5P_geqagSbUFEqOMPML5yEVkJuge>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba31a118 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:31 +0100
Subject: [PATCH v3 06/19] streaming: create structure for in-core object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-6-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for in-core object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/streaming.c b/streaming.c
index a2c2d88738..35307d7229 100644
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

