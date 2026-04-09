Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4A379EE8
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719507; cv=none; b=h6omVa1pE/hvaXKmMt9p5wroRVkmbPgLyYkVOGValJRlw8RHTVozyqfsbUT2wZ+OwcBb2nBn2hNRqIWLVrpRwR0kQf9XXyCiCc52OvRHMapGLN0m+zmlu18CVtekaFdtKrOKUEBxM4dHb6u/20p21EuYjWXbIjKdoe/hdtAOHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719507; c=relaxed/simple;
	bh=4ehHNDRM77vuqTXmMxOaZxSVTZewACCEWKWnPQKrKiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzmCibe2O/2C0p4vjmXzh/t3sGx8vW/6Bk0JsNfWW8RODukepJO7DC3GazjiLZoTm4H261i9OSbv4Jmu+4135LRn1chon4jTvu5dL4xBXcXJhQcW/zJfyJlcOfWYdZ2rj3Ia6ajkYtnKFSE3EDEP0zXK7STtKClYmrR+MqCnUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MwuXuMSj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r3AFSFO+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MwuXuMSj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r3AFSFO+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D31A8EC048C;
	Thu,  9 Apr 2026 03:25:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 03:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719505;
	 x=1775805905; bh=0wDVynQr3lppkdrXM/HivUROsde5R+XryUmuKdprgLk=; b=
	MwuXuMSjhNktLdkTn+2SlGif7vXz7pOrV5/lFv/Oe1tiKDcqY13T0ydBUSEiqgK/
	RJ20wu3LdznOpiTaZImBoCrDcMaLKpvwtkodTxDgy39c4xPKbxOqbGRCWb/PpGz9
	42MKqbsew7sOxj7mjNoUYc+hHrhta7KsUNcqfHXB+2hO6nKqVm7r3PQn/B1d2AwC
	EV+2g3lom14u0iooXpmAnhnZZftaYN03flMt8RGxOJKwd6E78Aw+9RS3F8m3SIKn
	QrfHIva9vHoKdoQgEHbndRjtTjLdZ+KNAiOsFWi5yflT9mhCPyZJjRD35m4YJxar
	x4zX4droPsg7x2a3gp+VMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719505; x=
	1775805905; bh=0wDVynQr3lppkdrXM/HivUROsde5R+XryUmuKdprgLk=; b=r
	3AFSFO+e4b2PAUpUOwV+MSJMAOjMVTRwWZzCHSFl6D448eLPqdg0XmAFziUfeqex
	bOBrc421xyxadwqePlifVktAbzahtFWCFqFAb6VGO2Zy5amsGwgbThqCj1Zdl5Wy
	DjQYPMWBLAVJDsy67An1sITESWqEVxn5vBkJ3hqESY+xzTxmKn38lUqM7VLEWjpl
	hRk6JecFZ0E5tmJXpB2Wh2MfRHdStcrfwisHBml0+vmDM9Io+CEqLVKrJX8J591C
	W89NCHTN11mynnWPLG2oUOm787KTZbk5Df/26ZzeOvxwb46ZY1JEc4sgHk7GaoAT
	rmzgKNUZ2tuzErdiClb5Q==
X-ME-Sender: <xms:UVTXaTvvHz2tx67Drs2QLxM8dnYdvMB9njqsG98j7DKrIdTcd66Y9w>
    <xme:UVTXab7VvR1HXh9YAL9Ii98FSJkIBIwL9l28wg01Q_SRjV9rUIoDxdZAhArsuZTXk
    82AfleMzU1YWCLnhI924e7G9Up6wSYkyfTwWF0RV_6VKyXBlIrQRQ>
X-ME-Received: <xmr:UVTXaUK-gjtYgLNMrZYsL49Z1etKmKQ0ocGPwwBPGUrokn5nECrejyykPXIJtQ7KH8Ro2f7x-mHO7MVRmeW_1h_FvDAUAyHPz55MFRx_ejI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:UVTXab7RPFdTHvUFkTuZ6Rs5NUJVMQ_dK6QLnx18YdsPMg-Ji712rg>
    <xmx:UVTXaXx931Kn4LPAgdKAllrdcaPTE9kSUl1-zzWtu_P7umk6TDUwUg>
    <xmx:UVTXafZWx1Qa1vWLQFnqKW7v2ta0DpsW3UBVoMFjKXvNL9TWAm6x3g>
    <xmx:UVTXaZQUnB3pz30tDHvyjix4ynTcj5vbd3qibzp_q0299f5qJWinhg>
    <xmx:UVTXaX7Z6i75PmUZDcmmbq2Uks6SOAlSIJuqah3i_3HYMUzeIU0YOxNR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:25:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01c00953 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:25:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:34 +0200
Subject: [PATCH v2 13/17] odb/source-inmemory: implement
 `find_abbrev_len()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-13-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `find_abbrev_len()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index d1674836cc..a8eba373ee 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -165,6 +165,44 @@ static int odb_source_inmemory_for_each_object(struct odb_source *source,
 			    odb_source_inmemory_for_each_object_cb, &payload);
 }
 
+struct find_abbrev_len_data {
+	const struct object_id *oid;
+	unsigned len;
+};
+
+static int find_abbrev_len_cb(const struct object_id *oid,
+			      struct object_info *oi UNUSED,
+			      void *cb_data)
+{
+	struct find_abbrev_len_data *data = cb_data;
+	unsigned len = oid_common_prefix_hexlen(oid, data->oid);
+	if (len != hash_algos[oid->algo].hexsz && len >= data->len)
+		data->len = len + 1;
+	return 0;
+}
+
+static int odb_source_inmemory_find_abbrev_len(struct odb_source *source,
+					       const struct object_id *oid,
+					       unsigned min_len,
+					       unsigned *out)
+{
+	struct odb_for_each_object_options opts = {
+		.prefix = oid,
+		.prefix_hex_len = min_len,
+	};
+	struct find_abbrev_len_data data = {
+		.oid = oid,
+		.len = min_len,
+	};
+	int ret;
+
+	ret = odb_source_inmemory_for_each_object(source, NULL, find_abbrev_len_cb,
+						  &data, &opts);
+	*out = data.len;
+
+	return ret;
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -271,6 +309,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
+	source->base.find_abbrev_len = odb_source_inmemory_find_abbrev_len;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

