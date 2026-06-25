Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AF3C8197
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381473; cv=none; b=UrFbJBs0oWq44woDZ5akXih5A9EZJ/kFZXExEVFeAGaygi4z4XNzVKIsw2RBj10jIRcqHMsQ0LaX9WSfhKDLksCQk7jysC3pt+lPSTpEtvvBIXLNIqFTBu4YPIMzf3u9RSr06Y6yYetFWeN5Qe6tm0431TM3AAl5ru+igb8YKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381473; c=relaxed/simple;
	bh=xFmm+2sKCxPRqJOGTlvIwl1Xkm7yrPlMtGK8KLrSRbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUCSoCAeKZMl9Rx44H8EGXg0EoqZ+192/SQnSPfHbWhsXmajCZefi0zYVJWAkTyWv3qWG4dBzS24W9+3UkwFA5Ka7XJTufmiMmGhyNrFBpv2GynbvMI7IZ83QVkF0Wrehhu4KBooIrLemdMPVs2RVsKZ6kz2UoQPfectN6/KOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YuNDzJwR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krl6tDL/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YuNDzJwR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krl6tDL/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C7031D00091;
	Thu, 25 Jun 2026 05:57:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 05:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782381471;
	 x=1782467871; bh=8C4BgYaCb4sBbJjCGV2unTq1+1QcltbgxNBiF/YQN7o=; b=
	YuNDzJwRxhhp8DJdlsMYBLt7O6Pi6iN+1+42b6Wqhv+VVQII4eMFeoyZ0nhUUU7M
	a835ivi2VvilrPUkWpq3hi69V999Xe0zvahPvn2SIW8QUHGBNThfF46+Kn/Xb5G4
	tF2zpupikCUfZBr+RcFezxxLDnU+VXEacqoeB/ux3slrqRgeyQrztigAFP06ZobH
	2XEl6nNZew/nRJkaKmzsArTKU6aGdq+Qlc+MUF2cfr3M89cp+ADdfZYblEg2bbsq
	/eWfr/txF67EF7AaAZXi3Z8AtwwO0GFyhMc24z5xomOhK/HMplOa5wBy1+gq64GI
	32h3sWZH+LtG001rY3KHMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782381471; x=
	1782467871; bh=8C4BgYaCb4sBbJjCGV2unTq1+1QcltbgxNBiF/YQN7o=; b=k
	rl6tDL/N5PLwSeIJuPHAJMX/MOYRn4BBzZP4bpbuwVC/GKE6og+F1R7dhS8AEF0r
	DOmgFqVLy50563TVtDgdCTYW7y6ZE1AH0XEBXy6lpFtkBzMOkc/hh3fJ+2B28azL
	0CX8MoQ1/txkY48jzekqrzEU7xNGfbRDPZIkbAKXgyfwm2K5OJ6AOEEznMkFLFMw
	aqCPhCpApomZNrC2CiJTwZTJHgFeN8y/EYPRQzR2IDcknKFXlN219h7mJ4NORaYJ
	ozx9zHMLiW6G+rZYRaa/mO27NuMhfJXu9X/q6PtnQgeQUI+UEPzkYozhTIa6p7aw
	a7feXEcXCWHwSSR0lj+Xw==
X-ME-Sender: <xms:n_s8alNdJqhzSHiuGWe4WgNTr9jC-P0WYxL03zrm3NQi3G9wYb7HpQ>
    <xme:n_s8avZFhMQoUa2pEIZplNfEkaI_G0ZurosWM3Zy31tx2YyWthzl8fAfjMTCuYzZP
    B-qzRQNOacQVo_S64zwoxGnDPOCEIdP4vXSmXMBh1UtOQAAyxF5Ew>
X-ME-Received: <xmr:n_s8ahrWcorwPz8BzHfkWqkIw8wXaGHTG2A3iFuMvXGGKHU9ycP-aAOQfv41TsnHHTVMDmy4END6-NMFOpm9jX94Q62wjh_mtzWYB7gXsQ>
X-ME-Proxy-Cause: dmFkZTFlCm4oA1wczD9UOeyzznN/Dz6R6epJS0EwRilGmnsdznMtxSDSXIX2g12XzSTE4I
    8lZ8x93Ii7KAH49OU6btJDN3ONXamZrNImfsK5pmLhKYJmEJnQ16qP55qwHvfqzzj9ayqP
    xb+A4oP99a5jp9fpLTayGzTYgBp7fAzVIXpUaAHqwXxMMSAzz65UVMuzPhSbA0twpWOIsT
    M9W3uAQsQLAHp+04JqnEs7HPp0BBo6lH2VGuT8izLDCmeNjq41eGrnAIxPZivJ6Sjl/SDf
    +5ynhME/f4e+IMUmQUQ8JCwozoJuJ9M6lSd6+XIvCvb5t6MQMdQnuB+lp81XKczSkFe7aQ
    hkNvwVv9TjWfcg7ir0kVXBNv7/Ct0r2AL//De8bViKsnhgkQhO8LZJv9iatqCDCioo4Ujl
    Whqz2vmQiJBmlSYZUd2fZK2xqxe5y6o33vkCygDZ7dLX1boTIoSHhxcDceydDzG1bY7t6d
    Oy5izf7QDzuWofRKNIXwM6NqzZhcXA8GiYROCsuj8uhSJZ5XSenZG98gU1McUzrVOs+T+I
    3eQHV45BSnfd422HuFCmxfHrFymp8eqnAln1STnIemPvFd5E0usAIbaadmTOHcy0Cc62AY
    S4ifR85ic3ogVAGGvh+flPQOm1GdUMwVkBvQyDyLUnrLHa5xiucG4HWbwq6g
X-ME-Proxy: <xmx:n_s8arYIA_QuPdrjgERIeWLUrOcty-1M1q97bWUajNp8WCgfk2-R1A>
    <xmx:n_s8ahS1R-WChlLHO4UR37xyEFXuS4eNgsCBf4XsjtC9jlj8HfX3yQ>
    <xmx:n_s8aq6SOV3y_SlnGw0EeOz7cSUuA5aMJuwQKXPLwjJvXU--XgPHRA>
    <xmx:n_s8auzRhvVIgpb-CiA-w3uy_6wMTZzj8w0ubIokoF2jAuuJxBOTsw>
    <xmx:n_s8avBsWOs1mPV5eo0XASHu5PfaIFV9dDU2TnsDFgjjU38qcnq62yXb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:57:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22e8f3f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:57:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:57:39 +0200
Subject: [PATCH v3 1/4] odb/source-packed: extract logic to skip certain
 packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-pks-connected-generic-promisor-checks-v3-1-7308f3b9dc44@pks.im>
References: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
In-Reply-To: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

The caller can pass flags that allow them to filter out specific kinds
of objects when iterating objects via `odb_for_each_object()`. This only
works for "normal" iteration though, as we `BUG()` when the user passes
flags and specifies an object prefix.

This limitation will be lifted in the next commit. Prepare for this by
extracting the logic that skips certain kinds of packs so that we can
easily reuse it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 42c28fba0e..3afc4bf01f 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -126,6 +126,22 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
 	return 1;
 }
 
+static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_flags flags)
+{
+	if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+	    !p->pack_promisor)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+	    p->pack_keep_in_core)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+	    p->pack_keep)
+		return true;
+	return false;
+}
+
 static int for_each_prefixed_object_in_midx(
 	struct odb_source_packed *store,
 	struct multi_pack_index *m,
@@ -306,17 +322,9 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 	for (e = packfile_store_get_packs(packed); e; e = e->next) {
 		struct packed_git *p = e->pack;
 
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-		    !p->pack_promisor)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-		    p->pack_keep_in_core)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-		    p->pack_keep)
+		if (should_exclude_pack(p, opts->flags))
 			continue;
+
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;

-- 
2.55.0.rc1.745.g43192e7977.dirty

