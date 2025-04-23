Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A826E143
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394515; cv=none; b=JHmXAMbuT7KCxllQ12TBgvap0XUhtkAetTpEuA1NVfmvshnmm193xJHgqSE4uLv901laEjrhsx9HSvhEWqLKASTvRYORfkRy5Ga+h8VGeePq3sBq5iLOIvwE+Io5TswXtk13iCFLx9NesAzG4qku7nwM8W6u2ZoftXB6u7q1sL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394515; c=relaxed/simple;
	bh=keDuK97SRhEic+zKTv6QoePDwaQQtHvco6WA4JrSNGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbsfPRrFkcTrSHHksbb+sV0JAZK9nSxlJlu86V7beKC8fTwChy0z3hGMF9fY8gINo/LgDgMlurZNmIyPjNpSZEgCCd5t5ImcPOqce5UK0Eygqf1cMiF8Z16u13Bq+/OO64duZL3lwnaveKm0BJ8O8TKDZCrmKTRkBHV4XTdYrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TCDWlzKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3WD29wV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TCDWlzKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3WD29wV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D1C4114026F
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Apr 2025 03:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394513;
	 x=1745480913; bh=Crq5DH38ypZT/G5Mt4rKKuFkxtJfv9Ti1JXXqsoiDLc=; b=
	TCDWlzKDTSdO6GGW3AJMAUnFPEpiT3MFIuMAsIdtKU2vLQgSYOBakBVA1tZ4wB8f
	Iwi/VRpxxcvNrpCdgxO0DsF7gTXhtl/dEw7GWgHNfQU4TYxGry7tx9KXBK2rC3w6
	YaIOaAIeBwV1oNqZA/lq+ZREiHXzZzvX76hq2l7GOLe+R0ls9u7MqeSqk3RtPnLt
	WAcDA6zijgq/gdiyvsIKj9S6bskU3K5ku3wfuEvap5AP1tYrCHDqp4hHdbGQQt0d
	aIv6SMCrFTZyiU0vH1cDHlVR4xNW18os11hTmQD9V39/X11RTLnxnWdKO+tpBMVQ
	Sb9epbGY38GOkv0JaUJNXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394513; x=
	1745480913; bh=Crq5DH38ypZT/G5Mt4rKKuFkxtJfv9Ti1JXXqsoiDLc=; b=I
	3WD29wV7YJroY6Ib6Lk1Ctj80XJdyTokIF0w1CWKQ1qaJoa0AT2Zz7O3nTi4x3al
	1Fs4gAPQNX3rpclg2thfv3qPNcOG0lso1zAxggdhTxnOWOklInffbKC/dAX2rdew
	IG1Djwy0tLTiM0e/PoC02qXbZAK6R2YfvEAFTIbhQtA+g0l/XVSM54bnEnynUgy7
	iqHFSBC4ofjyc3Km+1TvPk+gj8Bajmnrt0q0SzNd/TuINCfuc9T1+ivN8XQh208u
	QoeC2qHqBkkCBJjkfZJ1LW1NpFffR65rAd5ynogxLEFJk7/GOqqCEhNIcPtO/wTc
	OWCoXRDPKKLIC9xtx1ZBA==
X-ME-Sender: <xms:UZsIaPjC1Wqj40DFPOCyVG9Z9t9CzEVmvFUDIV3JLGwFS7S7-mWJww>
    <xme:UZsIaMDvxJ5H2wRnC-O5Ul7vJ7IGzSbT0I0C8AKuCx2bxVJp8ESIe3Al3Vfa4F5dX
    vPvnqkKCtPLS8yoyA>
X-ME-Received: <xmr:UZsIaPHsoAUE7tsrztZ3zH7rKsFwJyUr9-L_iCkoYJEwH4cp2swo-VrgI4qk7INMvcLlL-EegZIKs2SbnQnftnXblOsQF4m7KdHiSK2avw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlh
    ihqddqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefoseht
    jeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpsh
    esphhkshdrihhmqeenucggtffrrghtthgvrhhnpefftdeigfegteffledtkefftdfghfek
    keekteelleekhffhgfduheehleevgfetieenucffohhmrghinhephhhtthhpphhrohhtoh
    gtohhlrdhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UZsIaMTUdKvEoO9QYTZkWIH76AGbI6jd4rCaiXHR3CY7-sLFGPsHOw>
    <xmx:UZsIaMxz2lC7JMza4lSsnTUvuRpuIYHULy9jIdxphmDhzWzddRCk7Q>
    <xmx:UZsIaC4yA9oPXRRYis9uYwnt8pKK0M2b8QeZR6uBiFa3UEIBrlG3yg>
    <xmx:UZsIaBxDd0vmfLgaZJ163wWm-F8zkxuajBmVnGX3BlUIYcWKGQMLuQ>
    <xmx:UZsIaIeuOHjRBj5TjYh-M_N1BHL5SHfVYcu9_HcL-5Wn3g2YEdBKIone>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bf18555 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:20 +0200
Subject: [PATCH 10/13] http-walker: don't fetch objects via promisor
 remotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-10-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The HTTP walker is responsible for fetching objects via the dumb HTTP
protocol. To avoid re-fetching objects that we already have locally we
first check whether the object already exists in the local repository
before issuing the requests.

This existence check is done by calling `repo_has_object_file()`, which
will fetch the object via a promisor remote in case it is in a promisor
pack. This fetch does not make any sense for us though: we're already in
the process of fetching the object anyway, so fetching it via a separate
connection is wasteful, but should otherwise be harmless.

Fix the issue by converting to `has_object()`, which knows to not fetch
objects via promisor remotes by default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-walker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 95458e2f638..5ad2eae9a11 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -138,7 +138,7 @@ static int fill_active_slot(void *data UNUSED)
 	list_for_each_safe(pos, tmp, head) {
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
-			if (repo_has_object_file(the_repository, &obj_req->oid))
+			if (has_object(the_repository, &obj_req->oid, HAS_OBJECT_RECHECK_PACKED))
 				obj_req->state = COMPLETE;
 			else {
 				start_object_request(obj_req);
@@ -496,7 +496,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 	if (!obj_req)
 		return error("Couldn't find request for %s in the queue", hex);
 
-	if (repo_has_object_file(the_repository, &obj_req->oid)) {
+	if (has_object(the_repository, &obj_req->oid, HAS_OBJECT_RECHECK_PACKED)) {
 		if (obj_req->req)
 			abort_http_object_request(&obj_req->req);
 		abort_object_request(obj_req);

-- 
2.49.0.901.g37484f566f.dirty

