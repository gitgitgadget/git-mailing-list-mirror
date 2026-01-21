Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E5481FA3
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999853; cv=none; b=fBeKuEt+DAj2IRilEL9N/zBvVqsuVwlS0swIEnTV5CS/JwpPAhUVJmfKsKTlKSbz0c89kq94BTkGPSssegR8SrPQ/2NMayyIv0qX/BApMqCgG4Fo9I2MjthSuWE4I+9My2A1KXSkwiXOQyD2UQcfOlwE+LgQYQJ+Fc96va0SMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999853; c=relaxed/simple;
	bh=78ZlQsf7QmmfbBXjXS3kcaZa0llPSUuNJMYiNoWUI/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g3EdZuG4aX7ywHUJN6+H3apBNhvLiJulzSxULXTYvQBpCNLRqEf3rVkEnQYMFCLw6Q2FMMpIRoaz+iZAIA6NjK3lwycbawdlUYIpfRWarA6/aHOLFuVS/33PzKqQoCqF5ji0n3xLUhKSEGw1U5iHuFLcpprjuQ52HnWOOFzYOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iMPIpNDt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FrAIbPsg; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iMPIpNDt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FrAIbPsg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BA2501D00016;
	Wed, 21 Jan 2026 07:50:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 21 Jan 2026 07:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999850;
	 x=1769086250; bh=yjXHj0OgbBDfXdNTMAB7avFQ6MMfKNz46+uzvd7gYAs=; b=
	iMPIpNDt/iVntN8/2vMuPRrUjqIoBsLD868/wh2kEFCbeAqMrYzCnQJ9hiItvsjw
	6aZJP89QPWg2MuAY8JGGHmy2p+MaFJpj++JqUxK8zN4NIUnaDKiwWEIqyl3c9m1D
	LVKun9WbGg9YK2u25ry2MGAxXSwCEO1Go1rVX1rxT4jbQPWAbRKAmztMPtFPYcKB
	++8HtI84toXv6CwTR4C9Lld1hsvXA9cy064MmPt/13aazi47DBW8V0giXHjeijd8
	IzJCs6i2m3yZXWd8uK54WG/NWqEtkOt5b6UiYjmOI3gkZ2h509tRVQEvm1eDJThG
	XZqnqun4kxQwfW/OjhBx7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999850; x=
	1769086250; bh=yjXHj0OgbBDfXdNTMAB7avFQ6MMfKNz46+uzvd7gYAs=; b=F
	rAIbPsg92X2VYFCIwil08ag05w23DgplK8U/6df3OmlklJ1tPEyh04h7PuEyJbUD
	OvHcQTXMfJtutfKs9onkQzgq0c06PXVIOgbE2ygYl1FQDFeWLvw1J5TZAJsnDlgl
	eQGW8v+p7pbpgP2LEGWAuzxQbEJvW/Q/22nFsocDALegB7d8fq2F3upk6w9/VULn
	PpT4e32lRh6mtjFQ28hail7kT4oSAWf/Ub+oVTbG7ckCaHF0Bq3c8BrLlOB6Lnq0
	oANaGKlglUtPlkgclhV+udqbgU7ZlaT/Nvx0cNzbbwhhgVIkj8bX9CFha9XDnIex
	i4JJGhNLYvONYzDXZlxcA==
X-ME-Sender: <xms:qstwabSFS8yuF7YwqB9LOxEF2YuEV7ryabr3Yo15Cl4NkPHjhVX9Bg>
    <xme:qstwaTxmZpNWGWkCwalkAd8kd-mGhxeszvevVPurh_VFPy_uwtEu1qFJt9ZVOnSup
    8efDVHE304XBJ4Yw5JrVsX4JvJCzh_95tccWzakeZ1d5HMJO8CHTA>
X-ME-Received: <xmr:qstwaV19rXdsZc9221Ghe5W0AsC_VT29rLgnbsoTHE1mmUWh_bzRlbeVJRnurSX_EPD1jmIY32QJQyjxKvOuUwXTG5ehfczgUTtQx0653O4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qstwaZ78W-S5JYNthdW480oxVxeqZxPL-9h1H7j0B0vpbhjo4XgPsA>
    <xmx:qstwaQW5CXO-YkxX3duZmt_2457ybYXQR1pQ_gHLyIIRJVEINsII3w>
    <xmx:qstwaQCTkOyEAr5_tBGdvas5vR3cdCLB4Ev3eM7gm-e5hCQFC1-TuQ>
    <xmx:qstwaX6qi6l59xgIQA6gDRh9VlelCTJP3kn1NdOid5o6mh-L_XtXPA>
    <xmx:qstwaejba4eQkyy_HjxkYxkm8IkNQuLwGJija_FkWNgd725bUdnMglA_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 070a752a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:23 +0100
Subject: [PATCH v3 07/14] odb: introduce `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-7-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Introduce a new function `odb_for_each_object()` that knows to iterate
through all objects part of a given object database. This function is
essentially a simple wrapper around the object database sources.

Subsequent commits will adapt callers to use this new function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 27 +++++++++++++++++++++++++++
 odb.h | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/odb.c b/odb.c
index ac70b6a099..65f0447aa5 100644
--- a/odb.c
+++ b/odb.c
@@ -995,6 +995,33 @@ int odb_freshen_object(struct object_database *odb,
 	return 0;
 }
 
+int odb_for_each_object(struct object_database *odb,
+			struct object_info *oi,
+			odb_for_each_object_cb cb,
+			void *cb_data,
+			unsigned flags)
+{
+	int ret;
+
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next) {
+		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
+			continue;
+
+		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
+			ret = odb_source_loose_for_each_object(source, oi, cb, cb_data, flags);
+			if (ret)
+				return ret;
+		}
+
+		ret = packfile_store_for_each_object(source->packfiles, oi, cb, cb_data, flags);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
diff --git a/odb.h b/odb.h
index f97f249580..8a37fe08e0 100644
--- a/odb.h
+++ b/odb.h
@@ -475,6 +475,23 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
 				      struct object_info *oi,
 				      void *cb_data);
 
+/*
+ * Iterate through all objects contained in the object database. Note that
+ * objects may be iterated over multiple times in case they are either stored
+ * in different backends or in case they are stored in multiple sources.
+ *
+ * Returning a non-zero error code from the callback function will cause
+ * iteration to abort. The error code will be propagated.
+ *
+ * Returns 0 on success, a negative error code in case a failure occurred, or
+ * an arbitrary non-zero error code returned by the callback itself.
+ */
+int odb_for_each_object(struct object_database *odb,
+			struct object_info *oi,
+			odb_for_each_object_cb cb,
+			void *cb_data,
+			unsigned flags);
+
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

