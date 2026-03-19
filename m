Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF538B140
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903217; cv=none; b=Nzb9nfmqPI0cn1K/F6qDGyKlD6+BuQyEBxAXZSPMxWBtZCxnc0/90i+FL1wRx91dcYykYXvYlzi6MA8r703z/o9xQDPdi80WA/5gt6aryfzvczOTjHBJyjvNAy4Ka8cJS+bUbtUfaBoyF/UZrHAZYVf3Y7VXg/Bp8lXaWPC/0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903217; c=relaxed/simple;
	bh=tA9HNGg1T+kXxrVxsT0h+/3j85OPZTJluEoFxkca5JM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLOjrowBXHD7z5VCRK5QmgOG1a1iSpwtoqbgoNkFoXb1uRW2yT1SZ3pSmeWm8CJOtP7w3S+FQBUKPb6ZUabKKzeDOXoSma4CcOluwwDbXzfLavb83CIN3Q0K5WcAo+Ydd6DU6N7v5Vu8+4r734iidmkftKWswcVWyK2SM8NHT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=esVte78E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MduvSFVg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="esVte78E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MduvSFVg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DAD11400167
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 02:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903215;
	 x=1773989615; bh=VIc2BHCWuiIFxilNFT9YWQ6NZcoqZVdMh/LWZo/NJwk=; b=
	esVte78EiuKchkJhPbcKTmArwBGOZws81gflHdUNaQQ5YxRn0iaCllR2JiWprtcl
	fbZWKdCIvtLnZO5Gg1XafY2CauaRQdpOcn1H+Cl+blMzpPV3iG344nSFWf1TkPs4
	gkAXWzisQHLDROWuYxkU2mWIZ3G1IZlQa/atKjy0i7woqJlzNaawEy2NdDPuE4lg
	48KL0x0FPBqgfD1V7cwjZ2gRgqwkOZ+0EqNMUSuy5Ss67+cgEdiZMj9lIZGK7m8c
	UZ8xMUzYkK3tvM2wJRRMFi57HGWgx2BH1dpEKN7MDah+vM36FkEXc50Kfl9Rzr4l
	+tQzEHnDcEMw+yjRJEzZ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903215; x=
	1773989615; bh=VIc2BHCWuiIFxilNFT9YWQ6NZcoqZVdMh/LWZo/NJwk=; b=M
	duvSFVgwgy4TDRsKxiTIr8zAhswp/Z6M3krMch5FuuIGgjXxCnI45T9h3yfoF5RH
	J+/WXQjpBvVw6yTwuva8NenyeBkaWWkft7/poi0QXVElbG3um6mlRfiMY7X5t+Y0
	M7koeqgVTQqbprecPsFVu3T40ae0yrM6oz6Z1UlpnEWFbgSNs4A7Fu2wfh+J63PO
	cBwawICfXJrbASStU1Sbr5CTPh7XJtlbFgFlMl0rrAG/oYtTNHe2aInaZDNbcGRi
	Z0RFXOrc+dFnPbGyv4AtgJH+qF64RrRBHf2zRk3XrkcyPDtHSyoVxJn7BqZMeDTC
	jDyAB+tAwMdBkYj06yVgA==
X-ME-Sender: <xms:bp27aYavOM4djFBbVAPVeF9pnjEtXH6dZgMRVthfJ5oQDystBhGuTw>
    <xme:bp27aaU0_WXTya35RjkPXx5KGSOWTWzwNy02_dWVIJ6eD9ve-MWAyfkX5zHrfrMEk
    Dqz8iq64PBNiqRN5o0KD5YH6h8t0D3-Rl5bLnGz-55kymGpHo4c>
X-ME-Received: <xmr:bp27aYkTWgSn1wOfr2uBFPIynthpWpTCi37O6dZ-h8ky9MQ66nt_r_EY3ztXJ-P15eTqdYoxuv92aVgiB4tYRvAsNXh8l87CsLoN91xdcEbd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:bp27aXzoqABQpvPBa1x-5XupeCyHkKkJD_ultHrqxMvpxSsyOYWXRw>
    <xmx:bp27aThaP4S2x41m9TszdVD33xFmn5tp2s5LNN5ueEI-c4ba7kEcng>
    <xmx:bp27acWmUremXmHxmuTGDXzMoee6_9sIlyGZGhqrr-Bsa6R0sNwMEg>
    <xmx:bp27aV0JofIj1b1Ub3VwBZyDQDh9V_THneyb6nKXF76JCOgt6yMP-Q>
    <xmx:b527ae5O2LbaVlyg1kGVodZt2CXGHlM7dQRLj2212L2EvD-O5qBTgCHC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ee75423 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:10 +0100
Subject: [PATCH 12/14] object-name: move logic to compute loose
 abbreviation length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-12-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `repo_find_unique_abbrev_r()` takes as input an object ID
as well as a minimum object ID length and returns the minimum required
prefix to make the object ID unique.

The logic that computes the abbreviation length for loose objects is
deeply tied to the loose object storage format. As such, it would fail
in case a different object storage format was used.

Prepare for making this logic generic to the backend by moving the logic
into a new `odb_source_loose_find_abbrev_len()` function that is part of
"object-file.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 38 ++++++++++++++++++++++++++++++++++++++
 object-file.h | 12 ++++++++++++
 object-name.c | 27 ++++-----------------------
 3 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8a9e68a768..35be7e58cb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1951,6 +1951,44 @@ int odb_source_loose_count_objects(struct odb_source *source,
 	return ret;
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
+int odb_source_loose_find_abbrev_len(struct odb_source *source,
+				     const struct object_id *oid,
+				     unsigned min_len,
+				     unsigned *out)
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
+	ret = odb_source_loose_for_each_object(source, NULL, find_abbrev_len_cb,
+					       &data, &opts);
+	*out = data.len;
+
+	return ret;
+}
+
 static int append_loose_object(const struct object_id *oid,
 			       const char *path UNUSED,
 			       void *data)
diff --git a/object-file.h b/object-file.h
index f11ad58f6c..3686f182e4 100644
--- a/object-file.h
+++ b/object-file.h
@@ -146,6 +146,18 @@ int odb_source_loose_count_objects(struct odb_source *source,
 				   enum odb_count_objects_flags flags,
 				   unsigned long *out);
 
+/*
+ * Find the shortest unique prefix for the given object ID, where `min_len` is
+ * the minimum length that the prefix should have.
+ *
+ * Returns 0 on success, in which case the computed length will be written to
+ * `out`. Otherwise, a negative error code is returned.
+ */
+int odb_source_loose_find_abbrev_len(struct odb_source *source,
+				     const struct object_id *oid,
+				     unsigned min_len,
+				     unsigned *out);
+
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
  * writes the initial "<type> <obj-len>" part of the loose object
diff --git a/object-name.c b/object-name.c
index 32e9c23e40..4e21dbfa97 100644
--- a/object-name.c
+++ b/object-name.c
@@ -598,28 +598,6 @@ static int extend_abbrev_len(const struct object_id *oid,
 	return 0;
 }
 
-static int extend_abbrev_len_loose(const struct object_id *oid,
-				   struct object_info *oi UNUSED,
-				   void *cb_data)
-{
-	struct min_abbrev_data *data = cb_data;
-	extend_abbrev_len(oid, data);
-	return 0;
-}
-
-static void find_abbrev_len_loose(struct min_abbrev_data *mad)
-{
-	struct odb_for_each_object_options opts = {
-		.prefix = mad->oid,
-		.prefix_hex_len = mad->cur_len,
-	};
-	struct odb_source *source;
-
-	for (source = mad->repo->objects->sources; source; source = source->next)
-		odb_source_loose_for_each_object(source, NULL, extend_abbrev_len_loose,
-						 mad, &opts);
-}
-
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
 				     struct min_abbrev_data *mad)
 {
@@ -772,7 +750,10 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	mad.oid = oid;
 
 	find_abbrev_len_packed(&mad);
-	find_abbrev_len_loose(&mad);
+
+	odb_prepare_alternates(r->objects);
+	for (struct odb_source *s = r->objects->sources; s; s = s->next)
+		odb_source_loose_find_abbrev_len(s, mad.oid, mad.cur_len, &mad.cur_len);
 
 	hex[mad.cur_len] = 0;
 	return mad.cur_len;

-- 
2.53.0.1055.ga2ffed1127.dirty

