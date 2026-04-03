Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6832D781E
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196189; cv=none; b=Gjgzx1/6NO4xmPngIetDw9dMkBTvul1Vm78vutnVhNDx5z/0engMGPxpWmVUxGXApdAoqOMgMFwyRgiwkmiYyNd4m8hbDVOp6ylOwixJ1y0hz2rpKN0WOUaSgPqqfG3RWKB1rmGNVASpXpBg6hdlES/T6T8aYk1ArTwrzYofR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196189; c=relaxed/simple;
	bh=5JailUOfx/BVx6DsC9kACSjpITkuSIAYcWSdX+yJNZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kaWUt1MEye8GA47jtJ+tkuHr21HD/VVa5Pra/MnTWBMhzFSDQUcTY8Dg8sAXt8S6KLzZ2pgyGRnxuipsmcJBKeR0gA74MwvcDrgqiy3SUMFOh+xAmwBuL3iib/IELQhH49AQykRHVWtlsOVKejNzGnRUasdi206csdQNOkqSz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rVxqB960; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2D7hZsb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rVxqB960";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2D7hZsb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 381331D00064
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Apr 2026 02:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196178;
	 x=1775282578; bh=Ei/6eQNgo920JEcnxUefiLQ2AKFDtxwLF+mCKMOD9hw=; b=
	rVxqB960tL1eQL/yRmFa2l/2deMdw6YHwn+NQDrtiv9dyf+lvneUo82T0nNvcGP1
	RX2AiVYBlEDe97veJcj3ULLpCkes18zYS25C8hUChU9g9Gvuw9giHcWWWTjX1pv/
	McofHgb2jXWFVFK3BBgT1ciK1CjI2kp+KZc6XcGBCx5/jI0IEuWefNThdzOhrtfv
	9veJmq3eipih/Hp0MKcyxWRn9iHIqqOzp53jAsgEXEKYPKzvByFa2XZD08pp0ZOz
	f5NSNndBM3ecKYeLGzpcFO9tHsFIzSv5d9l7yQvSB3wSV5KvAxATuneoclemubsC
	jVtt2UQRNa6/hwHSQjHkiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196178; x=
	1775282578; bh=Ei/6eQNgo920JEcnxUefiLQ2AKFDtxwLF+mCKMOD9hw=; b=a
	2D7hZsbccAuVboZhcpdvs1axcVLNzuN2s+pr+DhCTdK2fbLAeZKd/QHuJcmrVaG1
	3S8rVUEJXpW8p5mRRFiNqp1XtLk4MmQDWP1NwVmbVlI/6UzuS4t1PRFJgcxNHrrE
	1nyCnQ5czWz+vGdgIOTSNd0JpcWpD0Q3gXeRZFj6mI8LosxNaiqSw5Z4EvF62Doo
	5k/zOfk/aZf1meAWVzf4LzSSBVccwGDUhy1cW71DlHdbzBRgZkSXGKFRSezNmMyK
	DszC6b0UWCWvTE+LymbEmHTHNXPDGTP5k1eLscOwk8YCdo4xPYZM2rq8CKH0zWkC
	9VyhdbjEeEQTWhpuFILTQ==
X-ME-Sender: <xms:EljPaXYoUtM1RtB1BnUN4eDH1Vu5u6yUsD_wnWEaIfvldVbrzlEONA>
    <xme:EljPadVSvRGVFC96dfPBMoFgjp2xp7qjSvoX05iEKcoZckqsyjBLw_HK2TUahMjHE
    zggpp2H-hsu-7E1Jw77LS4mwPhTd5DjAgGl9TUvy-lKHYJ-p3mT>
X-ME-Received: <xmr:EljPafkNhjT8ZWqrYbqKfDoKzlZnVqPBdNwm9jyIgUrxxie-K2zDCiGEsXJBtl9Pz3y2iKurrSrmzJgZVuAbSqNhwR-Sj0zEINuUZh8YipM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:EljPaSwqowWtOlrG6G44YLpEBw_6YNvq_1Tccz-JcxNwuh3SV-zFHw>
    <xmx:EljPaShyEagmpOPAaJiUUxoe4UWsjp0IgtNjj9C_UR1Fks3rceP1bw>
    <xmx:EljPafV3iOrycagtIw7jTDDov5p6cWZ6vfHp1GfOQZwOHMANEXCJZw>
    <xmx:EljPac06vJIGeKDapktkKK1KpJ3ULzqo0NbtW5mzn-SXHelNnVfDGA>
    <xmx:EljPaZ5cprLVZKjNlUemtcPhC09c77vixpXcHDd3t5ZCyOaPiUmIX6zc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46e1edcd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:02:02 +0200
Subject: [PATCH 15/16] odb/source-inmemory: stub out remaining functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-15-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Stub out remaining functions that we either don't need or that are
basically no-ops.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index c5249d04bc..53009be032 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -296,6 +296,32 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
+						 struct odb_transaction **out UNUSED)
+{
+	return error("inmemory source does not support transactions");
+}
+
+static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
+					       struct strvec *out UNUSED)
+{
+	return 0;
+}
+
+static int odb_source_inmemory_write_alternate(struct odb_source *source UNUSED,
+					       const char *alternate UNUSED)
+{
+	return error("inmemory source does not support alternates");
+}
+
+static void odb_source_inmemory_close(struct odb_source *source UNUSED)
+{
+}
+
+static void odb_source_inmemory_reprepare(struct odb_source *source UNUSED)
+{
+}
+
 static int inmemory_object_free(const struct object_id *oid UNUSED,
 				void *node_data,
 				void *cb_data UNUSED)
@@ -331,6 +357,8 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
 
 	source->base.free = odb_source_inmemory_free;
+	source->base.close = odb_source_inmemory_close;
+	source->base.reprepare = odb_source_inmemory_reprepare;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
@@ -339,6 +367,9 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 	source->base.freshen_object = odb_source_inmemory_freshen_object;
+	source->base.begin_transaction = odb_source_inmemory_begin_transaction;
+	source->base.read_alternates = odb_source_inmemory_read_alternates;
+	source->base.write_alternate = odb_source_inmemory_write_alternate;
 
 	return source;
 }

-- 
2.53.0.1323.g189a785ab5.dirty

