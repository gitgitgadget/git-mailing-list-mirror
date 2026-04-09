Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF937C0FA
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719515; cv=none; b=pBy7n3ISOfsG2uFLav2dpUlvN9iJS7BDnmVerA1gQJ8nHpSMNGyiH4RISLxURDTXa+h52GMpwxr1C+Ptd8VaqvhgyBltnPoY6yWlq/BC6Dxo+Wi4hauS06oldhDpSxM8Mbi7UJVbAjHfEGQhYvOrWNpO67/TUg7vgHJOUWk2wW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719515; c=relaxed/simple;
	bh=ub8UP83AKYkSDtHeWtkf9czDV8lN1ylEfGLTJpcu2Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aa7Ih4O/dihMVC45T31WvK9xkaJaZPrG/nRqHUtuhuHmU/NGXcmOUM18YttCTKnaSyoctubHQrMzvEIuV5O+KfkTh4/yxQZQYILOIMso6SL15jIzOquNrj3tSK6Nk0JlsBPw0khQn3pzv3RbEq0+jtJyKmKp/UMysn72x7rDnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XT94SYDy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NbHCXpR8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XT94SYDy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NbHCXpR8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0662AEC047C;
	Thu,  9 Apr 2026 03:25:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 03:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719514;
	 x=1775805914; bh=c0y7vPL9OjI1Lrqf80cjQ+vOI8Pio6LkPGX8OWS5Iwc=; b=
	XT94SYDynXx4QMaX1YaONtln3i21nQL0hkMGpmJZfvY9PM7r00wCHYJKYRkCWSDv
	P04Mf659raruPz5AhCSX7KTUDxHHo3ayleAggpAFih7q/sqWhjCbABjI6icyYoM0
	1TcXcTO4Ypx+uFXpgBg0eG4PZh5mKM/clPv+mB2lazw3QD8z6o7yC5jDCUurZAnN
	mK5wJz8IwYmJX4hqFHWX9dm2YMAoX9Qo1N+j8h7t4+QCtHaiw+QEXKtVcTCDxMTV
	1FxIMTUgXFkgvqWzyP0pU+sK7gjUCsBdL9jKtilpG1MYw6q923vckGdrLKdTf7Sh
	xXGb0N4H55ogoZw63utr0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719514; x=
	1775805914; bh=c0y7vPL9OjI1Lrqf80cjQ+vOI8Pio6LkPGX8OWS5Iwc=; b=N
	bHCXpR86FSSVigf8yvm0MnA+aKBFJXUeA5WcJ+nhPG1e13uFEOh6X/yXUZPankOP
	CqTgc0F4/0vqiMVacEIPZt+BSH7OxxiVckAQydSRsvP9MPVnpDk72qakNVLhZwDY
	jJ8GKvlz5/Fc2YM9kAkHY+PGqpdbnSlI6ECLqrowhaQ0JPH2h3edw88AuFLfrtQg
	aIdcGsfJ9IWQuwTtNE3K6XNOfZ0V+zMDq6vG6xTTiTKbshhd2QldrZ58JfYnkT5U
	sJcaEX1anNtCV4j2GTAkh3lQyLq9aeAq6VVyDhVl7m6pUqt8gG8B5wNDShkB5SlW
	7bYPvCoDIvSm03CTo7QZQ==
X-ME-Sender: <xms:WVTXabqRwcChNVvDw9Lwl9loONv5xDL4To13x9hj-fZeBQ-JH6wtrA>
    <xme:WVTXadEfolC7uRBcvfW0-wWoTcz--YsTjRU6OhmX-oDSlmnefrj1b2f4Fm_WObXEs
    Z7xKFhZ6ZEF6cJ9rUXJGbiUFXXZuyGp4BEfek8XS8jxOeN8aqAYcec>
X-ME-Received: <xmr:WVTXaVlax8QkWGg6TVKXH5x74NBw09uPO3geftp5Xgp_5j6TPJB0QrcaaY6lascxzvLx6DwYodSpcvuh7xOgu2AKgxgrgOvJwfm_sFFmb3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:WVTXaYnx40QOKd8gNf4GPqtpVxvaLQA21rZh01VYUB_FbQA5UDfhiA>
    <xmx:WVTXaetovALiOcRF2-4W3MCbxyNTX_y5tSpatV5cLXs8O8G8RpyOFw>
    <xmx:WVTXaTlPsf0ngHRRqvH2ib7Ngm-_ixyGi5JR4QpADCNkbNDRi84LAw>
    <xmx:WVTXaRv7CjbteiOEe0J3ow0oEII3FD4fAVzwr_Gh5Q1gAEJ2wtSEyQ>
    <xmx:WlTXaSPYWfIQf1-y3dRNkWQPHc9Q0f2ziG_4XBFsZbFv4BtUYcs-8u00>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:25:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35c2c298 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:25:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:37 +0200
Subject: [PATCH v2 16/17] odb/source-inmemory: stub out remaining functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-16-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
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
index 15a6a5ae64..1140b1b916 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -299,6 +299,32 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
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
@@ -334,6 +360,8 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
 
 	source->base.free = odb_source_inmemory_free;
+	source->base.close = odb_source_inmemory_close;
+	source->base.reprepare = odb_source_inmemory_reprepare;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
@@ -342,6 +370,9 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 	source->base.freshen_object = odb_source_inmemory_freshen_object;
+	source->base.begin_transaction = odb_source_inmemory_begin_transaction;
+	source->base.read_alternates = odb_source_inmemory_read_alternates;
+	source->base.write_alternate = odb_source_inmemory_write_alternate;
 
 	return source;
 }

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

