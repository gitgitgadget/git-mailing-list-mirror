Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586825C6FF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734813; cv=none; b=qa62mKA47rR79juyravl+0EhKS5+Cpnb6OZQ4+vg8kQhMtSPEnxPqwO17UEmLH/4EsN5+s+6Xz2g4rIN6v+GGB+s3VjKTb4wZZXA++75KEnfxEuOw1VlyU+XXR/KlzOQMMz8akAm8vcBsq8WMzWaWSGcwxO8eQrMZHTF6Nt3jU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734813; c=relaxed/simple;
	bh=wGlb3+rLi0aLm+QqXjufLUC9cBPzhplnIN0a0eTdE18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stkMgDFmpjxSb9+pELlRuKBnxUhRDadDxm9hDqnPbiB3CNTBCjp3K0a1kMzVX/kWzo78nrSdal+SuEfESlbh/xkv0cOXYIgXUcAWNNuLIXLo1qalp1Ui70s0PBu8SMB55PPFisPja9efOV2a9ZC67EPu0e3eKWtqu1xjZdEOzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KCuGFFuG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPq3RL+e; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KCuGFFuG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPq3RL+e"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 10FF211403D9;
	Fri, 28 Feb 2025 04:26:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 04:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734810;
	 x=1740821210; bh=APGBsIPikIn5RqbKe/1tXWn3YkPoT3urwrHxXg/T28w=; b=
	KCuGFFuGwtXuaLEShvdX3HfQwo20dFdYdogCRz+aMf0cYAO42T/PY9DVtbBecma3
	/12LIADthuPfW+TlPbt9kEPb/E6C0XxypvHcPyz0N1cFjIogC2gIYT+KgIFcCDYJ
	JwPGsQmiZYdopFBDMevRvq+LoitRV44RhhjdwbULdk73nXe6yMPUsE+GKw18X35v
	JeClMST2cqp7eMfyN2y6UOLcgyBYxzioG1db6ng6oOqF4dSRTBuo8uXD9cxNSZDM
	zgZZ6QDA9C3BgOqJfVm6i42n63v16rtJ70i16x0EcyrwqOr6nCqiptfPUMd3OByL
	RXTcDC/FyGfcS0zmcFO8Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734810; x=
	1740821210; bh=APGBsIPikIn5RqbKe/1tXWn3YkPoT3urwrHxXg/T28w=; b=M
	Pq3RL+eKX6sJnNujdsely21W4WcCdc01QUzV8AUWM7ofMdTjSzKxogQk1dbB7KIC
	tr5dMrBiDvZEkPmMS5+7jCYBcEOFXoNDE6NvXQ4Tlb5s9M6GZ7K+oi0HJwthL6xu
	LRtxVGc6QHgMAx6FA5yXJHs5BH96eeEF5hUZqXhJawznNOfsXbBLfUF0jN3UGIQa
	GmY+0wWaUoC9QUx6KGSLD7HKwxoI4T/0uO3WdKRB86GfLRonpeEivqmSV4RGWoc/
	N7MmuHnDlH2bVXMX4+7mcI29tfc7giJpvTNzptzj9HB87DUeDFDvxckLXs8P+uYS
	7vRmNyrE6H9UKyjeVikEQ==
X-ME-Sender: <xms:WYHBZ08X-5zMBQJN9Bjp9J6FOKMwKfWsYs7iYqJtYwANnfSlpg1XNg>
    <xme:WYHBZ8sCpLQ9aDe12lAUHUMHMxcSYZBJUELUsOvw0FiD1ZEbcnhw67O5wmdQnPNDg
    iomHB_1f_MYcwxy4Q>
X-ME-Received: <xmr:WYHBZ6Dq29j2JGtcvKR5UM7XsuYBuQNkaLlBDCi7NlXGqLRNMRP7hTi3I8msvnGHk1eR4bufVYsuXcFbbSqgDxamQ10Y80gXmLue93_j7wR4srVV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:WYHBZ0cS0jrjyMGt3aZ15GSGxOwZGm3NLg4dTTe78gMMjPgmUrX6Ow>
    <xmx:WYHBZ5NWlW8ej7qg8Zd-_zY-t_ujbwABa0sUJjXpEfXSJBqGDGsl4w>
    <xmx:WYHBZ-mKyHg8Go0ChZjOhKVrnMq3Zoa4Xwe6DwNYRYPKLfcw0yIUfA>
    <xmx:WYHBZ7sMmikyJlbtQdqS_TQloTc34s98_fZKuR8QzNB4-EjEmAPGrw>
    <xmx:WoHBZ8fVD3zsGvU3fBYyzs0OTXRM23KxDc3wIdKhS1dfotEupxDieuYJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6914b66f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:39 +0100
Subject: [PATCH v4 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-2-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When reading an object ID via `get_oid_basic()` or any of its related
functions we perform a check whether the object ID is ambiguous, which
can be the case when a reference with the same name exists. While the
check is generally helpful, there are cases where it only adds to the
runtime overhead without providing much of a benefit.

Add a new flag that allows us to disable the check. The flag will be
used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.h        | 1 +
 object-name.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index 4367acfec50..79419016513 100644
--- a/hash.h
+++ b/hash.h
@@ -204,6 +204,7 @@ struct object_id {
 #define GET_OID_ONLY_TO_DIE    04000
 #define GET_OID_REQUIRE_PATH  010000
 #define GET_OID_HASH_ANY      020000
+#define GET_OID_SKIP_AMBIGUITY_CHECK 040000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 233f3f861e3..85444dbb15b 100644
--- a/object-name.c
+++ b/object-name.c
@@ -961,7 +961,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
-		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
+		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
+		    repo_settings_get_warn_ambiguous_refs(r) &&
+		    warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);

-- 
2.49.0.rc0.375.gae4b89d849.dirty

