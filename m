Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280E4657F2
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922797; cv=none; b=UbXIgiPypH4YxCKS6NRrQyW/S+T853P5/dIK3Uldcz8elZkQg7ShwMHqGeQ3x6eIT+fOj2CqcQ8o2/19SMK6OEbI8Sa1ZmN/SD6h7dIHNE8EbI4Hjca1UchOO5FYu4O+Nxa8O/uD4hww6fbg4vf5Ln4jlXc6KacCPBTCfsbX9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922797; c=relaxed/simple;
	bh=78ZlQsf7QmmfbBXjXS3kcaZa0llPSUuNJMYiNoWUI/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhkfW6hBf4cUDkpWLsNC6ouS5U4GQD20OvwnrI0sFjcuK/meh+TCytI4ByyEbXXGXEXFPVyGtFcHfnV0IR/57sqNZQdd6fIWuEkktQOiJzmNPkF+t2z9yuaFvsS8KeVi/JsoFgjWI+Rn2a5wqHDt38PdhJPqKq7sswyA9Xc1J9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ym90Cw48; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NL1qgX1i; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ym90Cw48";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NL1qgX1i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0E767A0049;
	Tue, 20 Jan 2026 10:26:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922793;
	 x=1769009193; bh=yjXHj0OgbBDfXdNTMAB7avFQ6MMfKNz46+uzvd7gYAs=; b=
	Ym90Cw48KWnjHXQJ0xh6y3B4EWiTzTacHjzdTqlQyTTBBwvEosKilIkOBgueDdLx
	6KTksw6Yd1DbiXf1kFfDPA+ijdBuX15w5lfD7I2VydoT9UREAsctZsaAbOJLsDG6
	CckReL5+CgDZmDJ0fBJSgDQVkI57MEsdC0c6AxGcz9drJvqdTGhB65+YfNMFS3or
	SZsiYsdxlsvOCf7laYClCUQOGlPuNw2uwmqqbo3pr56GqV2zu3eYwCQmOSSM7qro
	rFY9g+rnbJUni7C1YQXSMBCwV6mAObnKk9nIbo7Tq1JYVxZ3RS/xDp8NatIcqUSa
	YEM13KDn6eCihHO45EIUvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922793; x=
	1769009193; bh=yjXHj0OgbBDfXdNTMAB7avFQ6MMfKNz46+uzvd7gYAs=; b=N
	L1qgX1izkEgzv4P4g50ANK8GyXGdJPBaqQxihr2xXgbzZjE28VkovY9iud3OoHRK
	dL0VlGmMfe/TS/I3juXcYuCgglSnLA5pQmwWJoFzq9/Jjg33S+JMy9nDhApOUuWO
	ReCjVpsWu4O6b13IINT3NmTqlA3T8ck1rcgxoFn+qAY2EFrUT/4NZZP4vZICdZ+O
	7myFArRq2wOBUaxkEIp6iHdF6CXWsU7F72CCUoeZ9cYacVcIv7jHUYHNsGbC1cKz
	ec9Im30q1vRiOACM4H4IVArWHiM0j1GmZpj04KVrGXaQGsXiNEXC40XfW/p8i0RO
	A02B5jtkh51cM3aAaEcLg==
X-ME-Sender: <xms:qZ5vaeSr6TM38u-_f8eXaz4GSWb0QUoD0RR5z_emZkwip-TmoF45HA>
    <xme:qZ5vaazIS5w9hzIap8-DPTwbsJA3AiNhUKHAs8X1BnUqyFhtfdRaUVT3th5o7M6UB
    Lbkzo1l6bSYUOFMDjOA66daxQhFD5oo5E99hc8uCA7IW7jNjPgkyEE>
X-ME-Received: <xmr:qZ5vaQ0HCTeey6B7qPegTE51TwdfjPgViBdEVCFkkHFy8NEh3idTSfTNSejXdH-WCDsWXtsjAaNyTf8hhLDwE-p81K4psQzEgMrbvO_KzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qZ5vaY68SSpOwbynsAPNQOYM7CRpEwrJ9gFYIFHQdOPkVS2dnT-0QQ>
    <xmx:qZ5vaTUS9uQAawmGC57iZRHIjTX3gnWMnfCLr_H_Otlk2kdUdE5eHg>
    <xmx:qZ5vaXCsk55Ymbh_GZt1Bahe0u1umEDRInhI-bDRYm4K1kVjtQ5G2A>
    <xmx:qZ5vaS4f-NBYeyQPTaXglbb1TSvuyrKkca5SBx1awPNcWtdIdVO4FA>
    <xmx:qZ5vaYWfaesTpkrtZRaoTS0qQNCOZ0oCoFN3TIBTEyzZ8YhAaY6Wa9Oh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 689afc2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:03 +0100
Subject: [PATCH v2 07/14] odb: introduce `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-7-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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

