Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4432E757
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421101; cv=none; b=tXK4At1/TDfWTpbZjU0sstqVoR7plUhhOwKI4MJlnzPx7knrU6vxgPZPkFzWFWmDofGRC6MFdhMwdNWhjAD8XEhqB4EaDy/TC18CuzEsSVaSrAv2qkVKdWRCX+HTOqOm1rwCcuRfaEiAzatPJbYVky/VfkYx2z0oJdAbpV6VYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421101; c=relaxed/simple;
	bh=B4J4G2mu8jAvvdFxFvPhpofLHPTNl/F0cb5Fm/9hVus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Spjt18U4rCPtg6bwNFg06YHcdqN0nygpMXxzhbR2+LPTlrOsPPErEOcd/fUOHoaZaEQfbAziEyruAISteQtct9hJJR/4teu7R+i8nvbJER1NuPK3Z9ggeAx4KxW+8YTBsuYaD3dZ0By0v6MNGJuZluTc7YSYA7I/HxP9KZ/r08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D0dYmPYz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liiJLi4r; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D0dYmPYz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liiJLi4r"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 32CC21D0005A;
	Mon, 26 Jan 2026 04:51:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Jan 2026 04:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421099;
	 x=1769507499; bh=Cb/nTNoHweYLbaZt99b2h3ZNq/tFrXtLtSFTWLIcRyU=; b=
	D0dYmPYz/dOCnl6qCJqRgSD1ktcVdybCI4zVodwUPOQgnbXRgeLM/Xy8rXogW/Nv
	rmwPReNYu4A7DZrHIqfIa5l/nuypk95fJyvKO856oEV0bvDMhcYpVntBG6CTy9bL
	1TYm6bwWfNFpJsc8gYAqC14w1BGq2oylil8yuDp0MHWcP2iCYLkevN9unkzCtwrv
	jQpQHXiCFrxpsLvLSSOsrZ08ab/FpV6KRoqQV8IfYIZzgxbGdEMtRwj6w1Ut9zdK
	RAkcJvMBgddC/YIdVhG/sHafnJ9AjmdqUadMFIvRfIALPcr3O6BNPteyVKEHpoTp
	rUT6VTzACkiSd+0XBTGW8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421099; x=
	1769507499; bh=Cb/nTNoHweYLbaZt99b2h3ZNq/tFrXtLtSFTWLIcRyU=; b=l
	iiJLi4rFwIaxEUlWMBHE4mZC5lQL2YY+5X6iXrejv1asZekx/3gLMzI82RVhpVR6
	ntODMX1O1eNohBuT/SZ0Ql4fv5RV++Fpx73irs0YnS5qGTVsYf5EVd1deSOx3ScJ
	9XWf2O2CLjc07O2J2+v8NxjHdFlZg7pOyTjCO8NRD4imEe2Q8KQq1Q/vmEPi/i9i
	wqOaZNrXt6VUPRrYMNnUdtJKwuaRceyVNB8o4RJRWI6cG7S8Jug8gM3z00FBURxV
	JpioYh4P6cJKF9F6TYFcXJI4+cpa7tEZcV4qrQHKYtSiXR9gizIfCKQZgimLXWuR
	vtZx7BFPRt3rnIi8f7pSg==
X-ME-Sender: <xms:Kjl3aZMYleIVOB4z8N-j4EwBIi-Ftubi7QkCTlA1vSvQ9xZU-7hyHg>
    <xme:Kjl3aS9JQvKezxT3UgL8ywlhfjGqPIGJK8VmEC0O_uMqJbaqnFDve0CraX5uZPBxC
    mA2xy0mWROf8E4xiPGF2C5xOYwYCvr_LmBj-00hy1kmVzQOg6bG7w>
X-ME-Received: <xmr:Kjl3adRwN1vupl6bh1Vv9vqoWsWWpMlU8e5RuaReDzThDEyzIbnO8o3CHq_OfnsAhrTcbhPLv_JpEllvn1oTEHyDfzP9L8nsxRhDig1YKxwRnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Kjl3aUmQiVoXP3SmVLEK2Vv1w76FnXGFyfQYh1Olj7H1jvnS11UBOA>
    <xmx:Kzl3adQ6wSLzVOIBBT8eg6rwPKTn3JD8n6KU2cKMGrbBk-UsmWjhbA>
    <xmx:Kzl3aSPSJsnqFOulGA9T_lggrfTZx_QD7x13BJuntdnXUg4I65ksAQ>
    <xmx:Kzl3aWX-gSBGDN5botU9DECBaYx3qz5kHHKVHkYStXY0VY3GsrlX6A>
    <xmx:Kzl3aQxo7P0qwzC-vkj07RasrESrMCtlnL3a2SNnI8iSEOCjUyCYgxXx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc4f5836 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:22 +0100
Subject: [PATCH v4 06/14] packfile: introduce function to iterate through
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-6-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Introduce a new function `packfile_store_for_each_object()`. This
function is equivalent to `odb_source_loose_for_each_object()`, except
that it:

  - Works on a single packfile store instead of working on the object
    database level. Consequently, it will only yield packed objects of a
    single object database source.

  - Passes a `struct object_info` to the callback function.

As such, it provides the same callback interface as we already provide
for loose objects now. These functions will be used in a subsequent step
to implement `odb_for_each_object()`.

The `for_each_packed_object()` function continues to exist for now, but
it will be removed at the end of this patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h | 15 +++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/packfile.c b/packfile.c
index d15a2ce12b..c35d5ea655 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2360,6 +2360,57 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	return ret ? ret : pack_errors;
 }
 
+struct packfile_store_for_each_object_wrapper_data {
+	struct packfile_store *store;
+	const struct object_info *request;
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
+	if (data->request) {
+		off_t offset = nth_packed_object_offset(pack, index_pos);
+		struct object_info oi = *data->request;
+
+		if (packed_object_info(pack, offset, &oi) < 0) {
+			mark_bad_packed_object(pack, oid);
+			return -1;
+		}
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
+int packfile_store_for_each_object(struct packfile_store *store,
+				   const struct object_info *request,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags)
+{
+	struct packfile_store_for_each_object_wrapper_data data = {
+		.store = store,
+		.request = request,
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
index 447c44c4a7..b7964f0289 100644
--- a/packfile.h
+++ b/packfile.h
@@ -343,6 +343,21 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 			   void *data, unsigned flags);
 
+/*
+ * Iterate through all packed objects in the given packfile store and invoke
+ * the callback function for each of them. If an object info request is given,
+ * then the object info will be read for every individual object and passed to
+ * the callback as if `packfile_store_read_object_info()` was called for the
+ * object.
+ *
+ * The flags parameter is a combination of `odb_for_each_object_flags`.
+ */
+int packfile_store_for_each_object(struct packfile_store *store,
+				   const struct object_info *request,
+				   odb_for_each_object_cb cb,
+				   void *cb_data,
+				   unsigned flags);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

