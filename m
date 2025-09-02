Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608ED2F656A
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810169; cv=none; b=M1jSAxWS3rkfZwLAyKS1yuCTAehL6E3vgd1sYP7Y1EoE789bHLC0bKbBTghdoiJR8DztnDHdtz66VIpZEOaO8OFIr2kOU5UjASZIj8xJ3qoEwqe0+AZdXAykIr9DSTvT19OPPtPguKYgjzrHPPcIYKkJAuhIiDS+bb7P6XIX1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810169; c=relaxed/simple;
	bh=aBmirR4f/stPSnEV2rVL2D39miyJlIVw5wBrvc8Rcmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRQ8hIsMw4yfnnILjkO3e5/lbbK3+2/+uLgJW5I23oDR6GfXaKzw9Kf4JmcFLVCIP7Z7SkZMPS2r9FhOwv4F3HMPzgU87gBeoJg5ln3lb0Mx9tLfYAS1mJjkeeuC1PHV+3QilQ8Wc8f1IfMprjGcXHqHGGKuQkq/lm1iPKgYTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m1KTuNye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNltXbAt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m1KTuNye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNltXbAt"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C75B8EC0480;
	Tue,  2 Sep 2025 06:49:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 02 Sep 2025 06:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810167;
	 x=1756896567; bh=wrJbU2Qpq7Dr2g+amfRBLT4pLGY14gMGiZyN8AlNOzc=; b=
	m1KTuNye4SZYlwr7nePDNzsf+fDFHHOMkWxKBFjRmXkEr/U81E2JpiOordPkHdUf
	xbKb80Uws65sSdWAELFh5SYK03v2GyYGdRCUv/BDyfa2uBopwhLSB1APNDiPXQ5Z
	2L6IFgZVtQn1XaZFQnIcaz1IesTJVZJiIgPjaYr8Ra57S0c5yDudPhBewhhZjUHA
	A+ioLGZTRbId3iwsoVDwBxDbspTuiC/RMAxomQ4YC08vsyCm7DbliHMBBrovtQSw
	MA6kXSK46uHy5jjg8vJlMjgL75bIhEY3+O+ebM4tUhB+Ai4k9K4t2JinJT6Two0m
	yrZB4SD6T2JJL8tCP5A3iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810167; x=
	1756896567; bh=wrJbU2Qpq7Dr2g+amfRBLT4pLGY14gMGiZyN8AlNOzc=; b=l
	NltXbAtddYcyNTlCSNe/qeNLOrG3zUYpTx+EPSx8o/f5Rx5H24kVXq+WB3BOKuik
	S6ynYC/LHvSYRSer608EWBfImfIeYPlqEkYiRtTbZQ6bx2o/7DCMJN4twDg+Lld6
	oJ5ExcsDwRc0HYrwPpMkcbemWS8vXIZkaZ1TcISuU5A2KtcwolmKLLIQvPo+sBB1
	JGqitLmAtcdJp5H8owuHPkpb9Zz/eM/D/YS8nXCXJtGA+nBL4QDLanPhnbKfXZYm
	8n0/wE5Ub1gH2EN/vSvgQLoHUvEWujVIIekHI64ZSE6FzgS3A04NlovZGJ10d2f/
	vtukLeBGmqrnf/IYUp79Q==
X-ME-Sender: <xms:t8u2aOMDGnWJ-uDwITFfyhJ9q8bDiFKi6tNAJ9vbvVPESpvfoDN3kg>
    <xme:t8u2aIcs6E3oaZNMOJG7EG4lDnR0IuPZQIyRTPgHiTAqwM1A4LYMrRmfvNXNZZqDG
    RalRt18jOMQsCb0zQ>
X-ME-Received: <xmr:t8u2aLtp8WelabyroUyWyu0nIZt4H21xitcRHC0UHdzvvfhSlNYVtDL3xZhAZSYE2O9O3XiX8bBrn869c-BIcg6Zr8lAxdxs2GT6T9A5pKjxHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t8u2aJnDQf7txwVLWAJ3holIrnHfDgRtkoFYqtj7HSQ9Hlzz7UjdPg>
    <xmx:t8u2aNwXxFr4EBx-eZLsbs-NrBaBAq4y9yEcyGdmigwsjpY_y9Y_ew>
    <xmx:t8u2aLMY9--OlsJULmw6AX0V0GZ9T9TAQsrmVDFc1PBHdEMwXHuHOQ>
    <xmx:t8u2aJqX2yKgo6LU-rB7rN9_NPKk1xjrDC34ogpgn64J7AV3mIjggw>
    <xmx:t8u2aMwH6Goneh8-hwmlI0plVVrBMOXSGMVGhW8r7_H488GDLDDGf89i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58901953 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:40 +0200
Subject: [PATCH v3 15/15] packfile: refactor `get_packed_git_mru()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-15-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `get_packed_git_mru()` function prepares the packfile store and then
returns its packfiles in most-recently-used order. Refactor it to accept
a packfile store instead of a repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 4 ++--
 packfile.c             | 6 +++---
 packfile.h             | 7 +++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 914c6e641d..9558ab883e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1748,12 +1748,12 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	list_for_each(pos, get_packed_git_mru(the_repository)) {
+	list_for_each(pos, packfile_store_get_packs_mru(the_repository->objects->packfiles)) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
 			list_move(&p->mru,
-				  get_packed_git_mru(the_repository));
+				  packfile_store_get_packs_mru(the_repository->objects->packfiles));
 		if (want != -1)
 			return want;
 	}
diff --git a/packfile.c b/packfile.c
index 3e0d2a8f41..91d11e0562 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1042,10 +1042,10 @@ struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 	return store->packs;
 }
 
-struct list_head *get_packed_git_mru(struct repository *r)
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store)
 {
-	packfile_store_prepare(r->objects->packfiles);
-	return &r->objects->packfiles->mru;
+	packfile_store_prepare(store);
+	return &store->mru;
 }
 
 /*
diff --git a/packfile.h b/packfile.h
index 86f2c07101..e21ebd75d4 100644
--- a/packfile.h
+++ b/packfile.h
@@ -142,6 +142,11 @@ void packfile_store_add_pack(struct packfile_store *store,
  */
 struct packed_git *packfile_store_get_packs(struct packfile_store *store);
 
+/*
+ * Get all packs in most-recently-used order.
+ */
+struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -226,8 +231,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct list_head *get_packed_git_mru(struct repository *r);
-
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.

-- 
2.51.0.384.g4c02a37b29.dirty

