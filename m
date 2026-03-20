Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C0359A6B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990497; cv=none; b=i7oMLAWg9OvH4eHNuneOw0xjM53vWQJxoYrmQkgGQtxgBz+94aqGAsC6hiOLu8u9d3uzBEtXZXK2b/gDcqRAzSHS/wqDyz9Z+0Rob36VF6u2459dbTADexGq/6V8ph3Tx/WKyf04Ga3xeG3QOgY34/OuEabehF3hs6jYXOGNHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990497; c=relaxed/simple;
	bh=FTe8trAfMi0UeRQra0kYnYZyVcWJ69u4WDsDIM8y+Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bj1Tj5+CAAyjnvsHS6ENO186UttFy6eL8uOrYwE1apqwy8HQnWJ1DnKNGKF000DtOwOMh4nIMQg07y5Mjx7spjKJDw1RBgCCGZCSG1Z1bvVn9x7F/rkfQCXP/rENnS94IPURGWxaK5y5kDR8OCkGmMmMxAlPPoIkST1Aa8SwdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W4mTQRyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMlmmifE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W4mTQRyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMlmmifE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6EEF7EC018B;
	Fri, 20 Mar 2026 03:08:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 03:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990495;
	 x=1774076895; bh=pd9hCZeGujFJKtpJeaZKuPvaRvTnACveFfgjLIfchog=; b=
	W4mTQRyly2yNax44YZ2kHhPyv3mxPffjZOe/lVWxMQisw4GCMkA6ZOdy8vPh25gN
	yFqSRswEidLU9uJCRTazQuu+5qW/mHkFvJ9ag/2tsPj76oGKaH3zjGNMbthZr4Pb
	Aju4bt3eTBRc/G/Vn29jxyS09ioMuAHl+FyRStY0yL9GvV4A3hL9gVXn2nkz7GLB
	ItvxdUIEnPkUAbjZQ4NU4nZVHT0hgC/ev7n4Xc+/ewWp8nr9UrOR85kra8XeRUYh
	5m6OkbeecKuaEe/EiOm5g/vQIIYSuZHYyC1WvlJR/4G47DIMGy77uq6ckqfHuxEG
	atV0vWba4nsn11sEJpnRJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990495; x=
	1774076895; bh=pd9hCZeGujFJKtpJeaZKuPvaRvTnACveFfgjLIfchog=; b=L
	MlmmifEGG6Xkfhdyh7ivDrgrg5I+jZfDN61i7gUnd+0YipUTQB5khQJlI38xn1rR
	0nShxZMPcofWd9YbQ40O7w4nw2H1cHuduJuPAViJfK4tMVOACphjbs2Zj4M4VU5s
	ZAveZSuZZhIAah8+Kdu5SAVrwDvAq4WwVX5WLN/t/2n1GYgH4hMaBmbwrD6ZiLm1
	DnJCvxf2K0RnELmOE0ojv/0hKTSeh7BjnZy7UrKXpwy9Fo/J5cZrFQN+D5wrmQFO
	eo+IHWe+ZBEgKdtTSfJVUPSYXN51Wi4DBrCJ7jtTrfFHC5PIL/4wzsYX9af3qDPK
	t4I0ubZoyC3nnC8Qx5Mgw==
X-ME-Sender: <xms:X_K8aeNfSYpx07TXF9ZdmSBkt0OXpL--4sbRU6TwGnnmGSOFJb31WQ>
    <xme:X_K8aUa9eb6R_cTixLejPDRZjVf_9RVJ0TWhXKV79PaNXOLcxdrgqeuBODMzTU10j
    twPTi_Zr_PuZaUSDdM4UUrZg9IbSlqCvWshKjoD3vnDWRDxsNxjmgw>
X-ME-Received: <xmr:X_K8aSqD6N7a_I5E7PY0VjzWC8GLK8U0WgKHGE3SezziefXN_IRW7rlYqVA_gmMX9Q1msAwXBYut59EMw11UT0jW4a_JOTeqMqHr7YuNppY->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:X_K8aYYYWg7jTcS02vADvjQ8KkPplvn5UvrYrKslvA6R9RoYpnW_og>
    <xmx:X_K8aaRQTki36GtXYbAKaQF99XyseU9T9LB6Slcxd9aJeBHlAvUhzw>
    <xmx:X_K8af4ujb8HAteAL1ZaQIhl4FeKtHk_kVFeIgL6uW6VAozoCUbvzQ>
    <xmx:X_K8afw_UGumKDk2-U1tN76pV-u-wFa5yzKU2wSG5x9rj2Shco1WLQ>
    <xmx:X_K8aQZ7OO5V5MhVCTL0cMEGQ5mMOUiL7KneJ-0bjsb15Vt55ye6M9TW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:08:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0fd0dc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:08:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:38 +0100
Subject: [PATCH v2 12/14] object-name: move logic to compute loose
 abbreviation length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-12-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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
index 13732f324f..4f77ce0982 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1952,6 +1952,44 @@ int odb_source_loose_count_objects(struct odb_source *source,
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

