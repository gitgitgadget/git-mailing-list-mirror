Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B713BE642
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823203; cv=none; b=WaGFhucaBrn2i01YQe9ilpAwGbz4vYWUt9fI0XqRw1Y+0H4S98gf88yWFW/XnCMX7OyLK2sS9/fl4+uM4ERS+rPmPqhn56H0/w5LnePB4X1o82r6Tb3VwEKuTi/8+FJAtfmUCsVOrlG6zUYdMTNGjavvqSUQMpNnLiR+HG4J+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823203; c=relaxed/simple;
	bh=hqpii/w5IErUfpDIOmLlk5YQ4siRIrISdaijWQf9sxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnn7eMVgbwmvTRGW8KDHdr1abay70rw8v4FPrje1SUDRCrixjXb4kRrRggKdvDHx/eATN9hZ5opkQ+MQQu2zInVgow5nFToQjqkMTwV/ulhzG8njaKX//tFH9Yz4oZYVxZ4KHbIKI3NxjvPFtJbD6hbyqZsZADP7vYEbywQAL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bghk/J+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m7JcDUd6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bghk/J+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m7JcDUd6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8F747A029D;
	Fri, 10 Apr 2026 08:13:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 08:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823201;
	 x=1775909601; bh=Yiqup8lHp+TIyyrOwiPXNreXnORAKftCV3z7K2c9Lw4=; b=
	Bghk/J+tC9bzIoOBPYVH4O3Sh9orVfR2EsRd2H0RJ+UwMZEQkhBnHeVeUViYOgg1
	Hbu7rJWTZCbItLpkKilsMy5ZOwwiQQgiuxT2fa2CQuqLKUhWM2oIVqbcnZNXtFvz
	l7poD+57ysxHdFiTC2gqJ/5xiVVLceGKncm73ajGmUGdGIAtBHeoTkDy3dhTgt/N
	+3aGLrsFjtRUugY73I6Eqly75AHLEaQvFvhbnicj/rDs60e1Digs+oTBkIBbsfnV
	5QsZKCnw8lY7iL8SD+PyZNvETMLc2wUAPuLZD2FeOfGNH4KrU88gKehTHjnZDEJa
	aGLovG9ce/9aMAg8FJQaXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823201; x=
	1775909601; bh=Yiqup8lHp+TIyyrOwiPXNreXnORAKftCV3z7K2c9Lw4=; b=m
	7JcDUd6bU7Nj3UGlbLmci64OV0TtUeM1FP8EhOesi+/Upn2NnLDDYwH+7d8ITtqf
	THCdahA6qmOatG4GdSNwxj8nviYZRciN/w3kbcum3Ye53OYTAj+8LMAZODDdcQWc
	WJ1r8+myKNyAvq9l5n9XxhUnRtb75D4/RnpEB+IDwHZE3qYLoYYHb43MBSvwq1qw
	vfD0w/LVelbpUZv06AZUcH7nRstWQKfLk24xVXElc/8aDgXnSaWJbhCtLk0lGv79
	ctYw/iL6HphSYgAw25Ar2c8QjcPmlocGhjHuZv8mmDuZKwtMNsae6AuiLELaMQs+
	sd/dxX9JDNb0syHgOEzkQ==
X-ME-Sender: <xms:YenYaQUre7MU-pCplzSdFcf3Z8_spdkY2MTQ8-P61UBVFgUh7sIspQ>
    <xme:YenYaX3XMUcC1bye5qtfMtbiiE3zriwyCg7aE9gT4lPrQ6G6Lk8JK-nSVF02VwIjT
    lnbCnAbElVOws7I6r8--IhWNU0Es_nQZKrZqw9VcLi5qtMhEIEJ>
X-ME-Received: <xmr:YenYad2R2Q0ZKW3fxL94EdsckDgm49r3zVPmuukbuRosMrLIU8o02TGLiO1VJ4WkhPwPRszOGtMzTDcubVJ6TQMi0jEHPYm0XVwzrtWXn4kJZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:YenYaa8kzeZIZvF7GqGjO3iY4SJae7Zvfe3lksp-3u3sLA41mzbjVQ>
    <xmx:YenYaa1ZMzIU5J6pz5hB1_d6xsp3UiHHvMaOli8hz4pSBJ6lmz-p7w>
    <xmx:YenYaX-mvaETNL4chFsl-KzpQFq7t0q7wfaZjaCk32ohMNgYu0snDQ>
    <xmx:YenYaau-mEN8XRWr98K4Ir2tljhOuZOXXo-sjtk29PwyW3tSllHD_Q>
    <xmx:YenYaUeqMjinALCb8usVdvV2XgXDLffF2pEgYBVHK1MfI1iSxDq9sRXt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50280460 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:43 +0200
Subject: [PATCH v3 13/17] odb/source-inmemory: implement `count_objects()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-13-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `count_objects()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 44d9bbedec..674dbcad30 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -207,6 +207,25 @@ static int odb_source_inmemory_find_abbrev_len(struct odb_source *source,
 	return ret;
 }
 
+static int count_objects_cb(const struct object_id *oid UNUSED,
+			    struct object_info *oi UNUSED,
+			    void *cb_data)
+{
+	unsigned long *counter = cb_data;
+	(*counter)++;
+	return 0;
+}
+
+static int odb_source_inmemory_count_objects(struct odb_source *source,
+					     enum odb_count_objects_flags flags UNUSED,
+					     unsigned long *out)
+{
+	struct odb_for_each_object_options opts = { 0 };
+	*out = 0;
+	return odb_source_inmemory_for_each_object(source, NULL, count_objects_cb,
+						   out, &opts);
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -314,6 +333,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
 	source->base.find_abbrev_len = odb_source_inmemory_find_abbrev_len;
+	source->base.count_objects = odb_source_inmemory_count_objects;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

