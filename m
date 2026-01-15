Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F37374176
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475118; cv=none; b=OS4FRXcZ5mU3eK1ab5lEWCzyHj6rNRjXCTuqCm17dqec6VOuYRdUpyWHkkpPSrjJ3keTWc2+skvqxDrpbiA2b/BuC9D4xkGq/YmpzwIjnOz43lrdOIyVXnnoVsHUpUYg7gt12e0ytDdEA8Zp9B0TxSGq8aUtKbGZeHib13VeqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475118; c=relaxed/simple;
	bh=efQJRr03Co7rBa4eXdlDCcnolvcz1nTTgb7IzHQOG1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxSQHfMNRvmgnYqFn4ENH3a/9ejoiFUkvxjPcL17qLGx1ug3oOtASHSuGq0XcpltMl1QLxRsYXQN570WwyvQEQPmqFLJoEaCeNeAOzCiwP/1/tuoNHgXhgVLAHkOAxDD/ohnCf80i9oxyJ5aUbTGDlo2WA5KM/OzUdgR+WScgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fvEt0kLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiyPAnD8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fvEt0kLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiyPAnD8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F7167A00BC
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 06:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475111;
	 x=1768561511; bh=CYkx+yNfjkz2GTrA59C/30fMmiNmskiwn1YlppXbBqE=; b=
	fvEt0kLJh6Pbpt5Ng7I8X/umhLwd5eRCe1UHhenqomcdtaksMWi+zz5Azh2xFjdw
	byRYUWbly5JQ6dloHX7PbjPrXFVJY9I/km/hZ1d7iBXJj+mGRaYTynBlQV2cNlCD
	X8s4my+xLNOXavfBuqc2tO4E9GO4SlIjPHM0/QrYjWO28nkGgL0cJAITAej3Ai28
	9czZfY9k5CsXUvlLk3UHi3WSq4fw+CF490ZU1j6W7EjMhwhYcQRGR0exl4f8ChIw
	+kZP/4ETZK9AV/nkJhasu+RJGS2rZp1k4AOXXq7ojvxQNIONjGdqeG6KjHswsiAU
	C4iKnvJSGbRX9E8eBVpSAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475111; x=
	1768561511; bh=CYkx+yNfjkz2GTrA59C/30fMmiNmskiwn1YlppXbBqE=; b=H
	iyPAnD8mv60BQiImXkRMG2Glpj84HubIBZjZGV7UO67zANb7wkiTCF1Ub2WbDVIq
	+RumYtyxwe9GO94XSgakH8LoVCCK6uRgeaLhv3oqE7zvH7Swp6UUjpAxVsI4ytSV
	dS0LKsB3SGnNHV2uiwA9++nGSkxlOci3Bysrc16GnjGzuLshwxTEtABhAnxrHWOH
	o+WPcpCgG9AIX29pDCHjqrv2+ISEXFyT20LIBt2QxU76zceSnNfq//+9YdYmfSUG
	lpLDr1+auliQHveanAE2mGDH/4zgVJbzfqaHAWwD6eUAl2GzQ56gSv8GmoP9utMK
	hOxFqIGVj5BTKzpJY3wuQ==
X-ME-Sender: <xms:58loaSmXVxHxckUDbtM0bu6VPJnoAJRQyTWiUKBcfGv7WWDGsl7Ikw>
    <xme:58loaQxHhqL8exd9thUO497hgsWtdZLXqOxeHbuOLU7EXiXYTyIKwgJ9LjcbNd2Mj
    BTGJO4tKrnX_M5CTFhagALU7lv-IFvMtleMq0FFvawucgszchIwtQ>
X-ME-Received: <xmr:58loaWRzMzpESnmgq1xsfVSxZ0w_BWVtzoYgYgdic3hGSAEafxmKEPnkTZJLCsDcGrp_v3Q3p0pc8GJmbq1mr_4kGQD8TEJCTgVXohNg6KYBXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:58loabt6OYKXzbD9TnDDPTR4G7nOBK65qx5OgrKj1_QSpiRO8qVNFw>
    <xmx:58loaQs5RgbYfyR-srJc3oyuohmlQ-PJXkVwmYdNWga1eosDYfVOmg>
    <xmx:58loaZwY9aQyfTgFVvcXxutjYnJQ_msKFdKqOqG7HU2Ze_qy1MU8WQ>
    <xmx:58loaeirRnc812MHKJdLJYBemI44waCLS6uq3yO4RIoGUXcMPNWQYg>
    <xmx:58loae3uPaLxULR59YWibhsmCP-Tr_jzV1SbmNVWl8Wt42ec1g4ZloV0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd8c717b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:35 +0100
Subject: [PATCH 06/14] packfile: introduce function to iterate through
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-6-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new function `packfile_store_for_each_object()`. This
function is the equivalent to `odb_source_loose_for_each_object()` in
that it:

  - Works on a single packfile store and thus per object source.

  - Passes a `struct object_info` to the callback function.

As such, it provides the same callback interface as we already provide
for loose objects now. These functions will be used in a subsequent step
to implement `odb_for_each_object()`.

The `for_each_packed_object()` function continues to exist for now, but
it will be removed at the end of this patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h | 14 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/packfile.c b/packfile.c
index d15a2ce12b..cd45c6f21c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2360,6 +2360,54 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	return ret ? ret : pack_errors;
 }
 
+struct packfile_store_for_each_object_wrapper_data {
+	struct packfile_store *store;
+	struct object_info *oi;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
+						  struct packed_git *pack,
+						  uint32_t index_pos,
+						  void *cb_data)
+{
+	struct packfile_store_for_each_object_wrapper_data *data = cb_data;
+
+	if (data->oi) {
+		off_t offset = nth_packed_object_offset(pack, index_pos);
+
+		if (packed_object_info(pack, offset, data->oi) < 0) {
+			mark_bad_packed_object(pack, oid);
+			return -1;
+		}
+	}
+
+	return data->cb(oid, data->oi, data->cb_data);
+}
+
+int packfile_store_for_each_object(struct packfile_store *store,
+				   struct object_info *oi,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags)
+{
+	struct packfile_store_for_each_object_wrapper_data data = {
+		.store = store,
+		.oi = oi,
+		.cb = cb,
+		.cb_data = cb_data,
+	};
+	int pack_errors = 0, ret;
+
+	ret = packfile_store_for_each_object_internal(store, packfile_store_for_each_object_wrapper,
+						      &data, flags, &pack_errors);
+	if (ret)
+		return ret;
+
+	return pack_errors ? -1 : 0;
+}
+
 static int add_promisor_object(const struct object_id *oid,
 			       struct packed_git *pack,
 			       uint32_t pos UNUSED,
diff --git a/packfile.h b/packfile.h
index 447c44c4a7..ab0637fbe9 100644
--- a/packfile.h
+++ b/packfile.h
@@ -343,6 +343,20 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 			   void *data, unsigned flags);
 
+/*
+ * Iterate through all packed objects in the given packfile store and invoke
+ * the callback function for each of them. If given, the object info will be
+ * populated with the object's data as if you had called
+ * `packfile_store_read_object_info()` on the object.
+ *
+ * The flags parameter is a combination of `odb_for_each_object_flags`.
+ */
+int packfile_store_for_each_object(struct packfile_store *store,
+				   struct object_info *oi,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2

-- 
2.52.0.660.gd05f3a8ea5.dirty

