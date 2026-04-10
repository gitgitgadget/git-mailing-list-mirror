Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A783BED76
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823208; cv=none; b=Jr+UlqbD9sHy7XWi/C8ggknZRy+c7GCkeaUlBjuFRq98l3AlveA1+2cJbwPTAwdcAwk9CwmlSs8c805gzibGNIz+37z6scsH50rVrHk0I9F51HgYV4Yh16QtDVyoqfl2+GBLHTu3BDXam+N6PfqJXgQuDUUG1qqh/DGPUaiBCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823208; c=relaxed/simple;
	bh=isvjigbx/kqlyQO4Wgc4AuIBiFrQTzeenPO0mOHGCmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRrcROWxgF9pkia1LHb9OvvHrgpxLKzcvSrCBoH5J39/BM+FhAZFKIcs87RPfv+KQrpbvcpsJo4Gfdi2B/+sI9CKNVZPIfu2QtS7cihiWk1jpUMDd6ZHj4pfTOEHzf2vxXh55dUxVlmkuhRuYEpEIYu1iAdTsMnnMqbTxZosR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LgBSSOMm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hTXTptZq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LgBSSOMm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTXTptZq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A3397A029B;
	Fri, 10 Apr 2026 08:13:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 08:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823206;
	 x=1775909606; bh=r76h6ue0K3gsJrosKAi9y3V4rKg2VFR4HBBJjpfx8ik=; b=
	LgBSSOMm6xa5LHgvgtQDrS0Y6lpOZDVOMbvupKjOPZLG9D5C2MQTslYY74SmzNRW
	RVeWDnGfBFK7NIma4OEI3MFq7K7bpVxZ4dHuIlXDJRx2ifXXicw/kAcdPCg1Bfsa
	fNsjwwOiO1uY4bw+rv0u5EWR02+kPFTYgEXajsgIStg/veZ7wPIt3t/GErvst8XJ
	F5fFRy4lrQN9lwWvJ++npU/2v5XKrsTamFWeaerj7Uxg5j9myfBdwLaLvJ1YXGFt
	NKAkt3C0s9AorprAdbiCybpKFNSQ5ldGHFZRy65xzbC30lMNyB4ARpLFTfwpuMgx
	uadq+YzlZhFAqIeCRCMWjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823206; x=
	1775909606; bh=r76h6ue0K3gsJrosKAi9y3V4rKg2VFR4HBBJjpfx8ik=; b=h
	TXTptZq8dKYi5e5CpTFB0g1/6o13mEn44HXF4HIWzzhKzfHOazyXu30PsT+5zP3e
	1kl7OjM+Gk33TPkRsq1/Hcy5TxoWm2QMJFnu+4ybqyT1qp6rpI0yytoFV9jOjtk0
	05FlVVR4MWiDJieU+Y6geAwoOe8WsiT2Zl3AxW8vV4/4UPFIWhqfPSsFVApisfi+
	1WriK6GA0tCOZD3MeMBMVHZ4945cmnPSEQuYIYt9nh37idqSUIQLs61myWto8csw
	du/8c/mKFoCMhvYrrez2xHwoSipthR/a5UdGLPQvpkzBM7VBT0IYRQV/1noSKQcH
	gU1QgT6HH5cy/zhxyjR7g==
X-ME-Sender: <xms:ZunYaVhjZQVBPLgaM0x1aTu2qqcuYoP5Sr8IWUNV17ZoBdUvKnSWuQ>
    <xme:ZunYaRdUXvqwyD_XojOn4y0ccV4YqZCWspfHx7m-hv90hXWPgMZMB57WpgFq1KskX
    zwCAQbZLc7pT-Sta6Y4li2Ut7YR7xei0IZ-7QfzF-UfJmJTAzgG>
X-ME-Received: <xmr:ZunYaSeAaAVy8UrfknxL7T6z1cp_B4lXcZyuoR_uqjzUI-bN1qkrfSqkgQ51wbHxKOKJIJExW0Fp37XLhgPrzcmM725N50XenVIWCI-FPGuf5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:ZunYaT8eYA-TraHpYqRWkiKa7wGMPVLt2ilcb8h4Lsa-7OLiDg86Fw>
    <xmx:ZunYaWn2jtVdg2Z5eIlwfeB7Tx5xJbXBxCRvv_r4d8ZOKm2M4Dc5EA>
    <xmx:ZunYad_BnqDTPi-QeMprewoWVAxLYRklmyLiS42jzjyg-t0CCRORqA>
    <xmx:ZunYacnvLY_K57f_M4fAJD478uv_Dj1Wa65M1pmDgZKJm_BBFSnypQ>
    <xmx:ZunYaRdhvmHCuhW9_ohT6-xX9dCJK5Wq7-7fkLJS_6wbfyqyt1V3qJVh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a12a94b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:45 +0200
Subject: [PATCH v3 15/17] odb/source-inmemory: stub out remaining functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-15-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Stub out remaining functions that we either don't need or that are
basically no-ops.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 8934e0f547..e004566d76 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -303,6 +303,32 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
+						 struct odb_transaction **out UNUSED)
+{
+	return error("in-memory source does not support transactions");
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
+	return error("in-memory source does not support alternates");
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
@@ -338,6 +364,8 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
 
 	source->base.free = odb_source_inmemory_free;
+	source->base.close = odb_source_inmemory_close;
+	source->base.reprepare = odb_source_inmemory_reprepare;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
@@ -346,6 +374,9 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 	source->base.freshen_object = odb_source_inmemory_freshen_object;
+	source->base.begin_transaction = odb_source_inmemory_begin_transaction;
+	source->base.read_alternates = odb_source_inmemory_read_alternates;
+	source->base.write_alternate = odb_source_inmemory_write_alternate;
 
 	return source;
 }

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

