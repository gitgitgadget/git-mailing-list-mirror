Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AB329E44
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538682; cv=none; b=YL4iDhrbJWVjUXGdnS6l68raZ5TH+o5BE3hcRjF+64hI3s3gc+eXrC0CUFOLiJoaBBQL7KaIqDBQ2oJlHkyxU14mJa4/I3pbpZzRem0y/xMWhoK3mZer9clWWq5IWfAPdoKFUvbsRo2bHfcVeSQyZdegXb8J4M0j2JtJQyvMOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538682; c=relaxed/simple;
	bh=1eTgx/jRnAAyf+nJUQf7SJ6H8NfKoLf5eC6cfkIwDnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9blhwOLaYC6GF7O4A07XntnVsorOajOEtdYzEDd3OAUXgKlTxZ/+CL+kGigjug9YubsJSMQDaFQI/9Yn3c6kvpVGw0CfzlJt3TSutoOdubPx4YguL4/SPJcHpve7ih4WpSBvyzWOTa2r/lmiK2FKZcZAgBM2XSiMMHU+o4l418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fHQVC1Np; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yfg62QuW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fHQVC1Np";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yfg62QuW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BC0A5EC00A9
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538679;
	 x=1763625079; bh=eheCtJoHzdNtoAPT0D/vbTFifcaeRKX1BCMFYuVV6YA=; b=
	fHQVC1NpZkxX5v0nrIz5WWCp4Zv/J728VM57iloKMPNzVFA+Tt055p0K+OK3RrSa
	hB3cc4ed1Mca/GNDdAoWcjomL6Mq68s/AQi18/22Cr1AIIYBevT+kqx5slRlWMXI
	qF91nvSYKxs9HXhxxewWJss7DsggJKhNnvdNZ1L5DyEHiUGNQWL/WA548GmDySCo
	YEWnovbHzMwZ5cGyTToruBcNMA+eHBZ6cJ3D0Qkp6tUOQG1koXg68Lg/VM+5yER/
	6QZLm9v4sw48VYBiGmFUALjXmXYImSyOWtoJbRQdFWQqqTBVbAQISCptZz3AMGVm
	ZvyzJYfr99O/RBxYJvpiKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538679; x=
	1763625079; bh=eheCtJoHzdNtoAPT0D/vbTFifcaeRKX1BCMFYuVV6YA=; b=y
	fg62QuWfjdNy8F6tEMQfovJPAuH5Xt/3c21IyGmbuHM+H8q9ggm/SgcG6ni7JQ7r
	LXS+l2Hj8EhZn7t1zUGOHXhaEXcpCEG6ETLAzAH+hq/6rzJ5iNq1RwxHpurM+8eo
	us96KVyZ2txAZJvhBCw/ksZvn59tkGgNHAawN+eCAhyZeGGpBZsRt9DXXxbhFQa1
	XHWkkdr4y/5lPLSWrOxEaTR5JS05FIhrixzwlb9e98RWWvJloue1Cy/Krbch+WTs
	3h1DjVzmf6TNb09ObGI6QWPU1fZs0Aoh67pdq24Rqw8CEM1ELIRz4H2VNzRS1Fe5
	TyE0ZHiv36ncwVuKPdn8w==
X-ME-Sender: <xms:93YdacBnaDeBtRO8sJx3EwzCmni4i4Sz4pvQvM51LKAv6iJ9BcospA>
    <xme:93YdaVfBSjAo0Uab-cY6okw9WwCYzZ6LBEpHJwr2-FinenmXWU8BhFNraEZv4-7RS
    eurKS-TKMqwgZuj-fZsgSTfF8AE3gMos711euIw2Ay74C96wF6l>
X-ME-Received: <xmr:93YdaVPn3uPFhYha7E001-acA_BNR4qxVOHWzKPT6mFjjuLFT4FZA9AucCfn9gyXwhLlK5i5CbGXCsG5oJcmg-OebyioBRhp_K8AlM1omA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:93YdaX6Rtuz_BEKHzUMpQWZ_tKvqP7Ou74aPayy8mfXqu1z-GbLWmg>
    <xmx:93YdaRIcwNWcwfX0IUhqFW7q6EbCG__sbzqO9fE1aQMm-uYuv_HwXg>
    <xmx:93YdaZcMR9qic17oXcNOB-46e3eJvXB4o2kPIUxOJpUGBPOXBo0rdA>
    <xmx:93YdaccPw2HtPV5C6q8Bd4KFolA1eBx12NJkrNQ7nnM939oVSxojsw>
    <xmx:93YdaXA8ihZqoSrG43zzo9ffKAENm7Yz64-KShn2Wqo2EE102a717nxq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1648949d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:54 +0100
Subject: [PATCH 06/13] oidset: introduce `oidset_equal()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-6-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new function that allows the caller to verify whether two
oidsets contain the exact same object IDs.

Note that this change requires us to change `oidset_iter_init()` to
accept a `const struct oidset`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 oidset.c | 16 ++++++++++++++++
 oidset.h |  9 +++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/oidset.c b/oidset.c
index 8d36aef8dc..c8ff0b385c 100644
--- a/oidset.c
+++ b/oidset.c
@@ -16,6 +16,22 @@ int oidset_contains(const struct oidset *set, const struct object_id *oid)
 	return pos != kh_end(&set->set);
 }
 
+bool oidset_equal(const struct oidset *a, const struct oidset *b)
+{
+	struct oidset_iter iter;
+	struct object_id *a_oid;
+
+	if (oidset_size(a) != oidset_size(b))
+		return false;
+
+	oidset_iter_init(a, &iter);
+	while ((a_oid = oidset_iter_next(&iter)))
+		if (!oidset_contains(b, a_oid))
+			return false;
+
+	return true;
+}
+
 int oidset_insert(struct oidset *set, const struct object_id *oid)
 {
 	int added;
diff --git a/oidset.h b/oidset.h
index 0106b6f278..e0f1a6ff4f 100644
--- a/oidset.h
+++ b/oidset.h
@@ -38,6 +38,11 @@ void oidset_init(struct oidset *set, size_t initial_size);
  */
 int oidset_contains(const struct oidset *set, const struct object_id *oid);
 
+/**
+ * Returns true iff `a` and `b` contain the exact same OIDs.
+ */
+bool oidset_equal(const struct oidset *a, const struct oidset *b);
+
 /**
  * Insert the oid into the set; a copy is made, so "oid" does not need
  * to persist after this function is called.
@@ -94,11 +99,11 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 				 oidset_parse_tweak_fn fn, void *cbdata);
 
 struct oidset_iter {
-	kh_oid_set_t *set;
+	const kh_oid_set_t *set;
 	khiter_t iter;
 };
 
-static inline void oidset_iter_init(struct oidset *set,
+static inline void oidset_iter_init(const struct oidset *set,
 				    struct oidset_iter *iter)
 {
 	iter->set = &set->set;

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

