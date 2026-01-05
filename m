Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84472230264
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619024; cv=none; b=D/RWVlbQZxxH0KUXAUrDwcD3g15JCagX/2oqMdyaGjwWrdv8Etdz2Wwp9GdrwJHMjQXm7ikwge0s4SRzdTnwDHuH5oP7tnw6JEHcMIX8Wzk8FTdghvhUIl7Ivr6ol9N5yFAa8iqoXZ0tr5Rn6jnH92Kz1bJwuVFJN24+fC8rZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619024; c=relaxed/simple;
	bh=02qlJaxzTZF0/pqF9gtV5s5HqrQIgp5Y/tgRQyNRMtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpk3bIZr+1eLuX34wGmIDmSWS6rDUTp0j1iH9hmM6AP2wB8vBpWFW/f/bp2MNubygBgfW60/yYurZtHjG8wjb+eoZpl6KaKOEjBu3sETTf1MuMbK/D6KrpeJA+2XSEC6ByiKsAOifyFc90fSfzElyU3QV9OLd+q3oqCW3DPTRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HcSViK/Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmy6D2Lo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HcSViK/Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmy6D2Lo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DFA981D000F0;
	Mon,  5 Jan 2026 08:17:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 08:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767619020;
	 x=1767705420; bh=8k5c1HlCPHE+CsEEyRlVIz46q5WUFW4pbtc9pK7Y+Hg=; b=
	HcSViK/YEf8donwuhd0Kccofm/teKGu5yae0CnJVG2LleHGjMCBpGVjeOPG6+Mbu
	2ZTCFZkn+zexu3AAmRW2ONYeMtRxRmIYQzu/CtN694OfpETvmzmj8+7r13eFxJvV
	zk29SLOxXRl7GkbVF16ssrLXqUpkh9Sbg74yQf1IS6ibDFiTKSazS2YASgufNT6i
	3DmiBzm9jIdK+gtqU8p3Fhlmq87445fVfdRjKYD8PieOmXGreO7eHJPy1626VIWN
	PZ/UXRyuoAMP+Xs2YVMbOa7Ll315tnxPT97+SN86Vk/b5+cJVQ+d/G6YnAUmKr2S
	dnJziLQP9tkiXCRdxdHaxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767619020; x=
	1767705420; bh=8k5c1HlCPHE+CsEEyRlVIz46q5WUFW4pbtc9pK7Y+Hg=; b=f
	my6D2LoIwTOGZEAE436nT1MkPf/7vn2YTF1OuGqxupuakrZoc3nAuaZDAJXPFAyG
	DSdJssEifO6DV+PiG7cDYtasEYrGlSZrkiluDU2m8EHmP8mGSK7Xy8F49ug8HuaM
	F1SXPcXEHKhbxDNGRGD9evFCZG9v1q0b/Q2Ix8FEKl4502JGqDhA4lPd+RdLz9EH
	VlwftcQAkA8AsLA8F/2PkHNJflqTygHSuzZVtzFwuR/kmN6OIXpN1cYG0XrjLAY2
	TSabjfC8FWapxVfaNOneRa9GuIl72Hps70yPqdCXUAo4tpOOKmJ/YjGF/WnXY/sM
	7xca2Xd0kNAgySeZ11WGA==
X-ME-Sender: <xms:zLlbabJyiEGREovzCp64727ThIuOyrWkiieq-a7PDxBS5DcOZm_6jw>
    <xme:zLlbaVJh0G55EsUM3x_1sWkY6GZZbwpwFVpyNlhYmREn8Cbg-AKhIEL-Gx32LaL8R
    9ikyvaXc1uHeDdoUILMwYOiRDrooqcba2MhKWtAg8TPCOwp6S0If9o>
X-ME-Received: <xmr:zLlbaRUSCm6x8ZfE2wMPsEqMgNVbfAwvkFCxVQUj-FQC6Z_GXAQHLA04E_cG5C8uHzHDnpTIJqT4h_GcsbGB2ISdo9qgPJo4X9yPcmva>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zLlbafjZvu_lDOsW-PAUKQHROwdqd9_cfZQSnWtfXU0jymm2os9FFQ>
    <xmx:zLlbaU8cfnaueJ5VZtj4VfHTy7Io6RCOOgL-W7L8gbeUd8vWIDhHcw>
    <xmx:zLlbaRDzjPmQC_pvh9TW37WOSObISynyGqdFRfvWZodi-XSjRoulcQ>
    <xmx:zLlbaZKQuLEC349Aq98TLW8K7izw-6wdlGG9JeI9lSQdD73pSNZlwg>
    <xmx:zLlbaVlqxxYg9qkYjN5B-gTmMLAzgHzfMBsqmO2bQX040oOmjw1-vDC4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 08:17:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d445c171 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 13:16:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 Jan 2026 14:16:44 +0100
Subject: [PATCH 4/5] repack-promisor: extract function to remove redundant
 packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pks-geometric-repack-with-promisors-v1-4-c4660573437e@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We're about to add a second caller that wants to remove redundant packs
after a geometric repack. Split out the function which does this to
prepare for that.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repack-geometry.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/repack-geometry.c b/repack-geometry.c
index 17e6652a91..0daf545a81 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -197,17 +197,18 @@ struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)
 	return NULL;
 }
 
-void pack_geometry_remove_redundant(struct pack_geometry *geometry,
-				    struct string_list *names,
-				    struct existing_packs *existing,
-				    const char *packdir)
+static void remove_redundant_packs(struct packed_git **pack,
+				   uint32_t pack_nr,
+				   struct string_list *names,
+				   struct existing_packs *existing,
+				   const char *packdir)
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
 	uint32_t i;
 
-	for (i = 0; i < geometry->split; i++) {
-		struct packed_git *p = geometry->pack[i];
+	for (i = 0; i < pack_nr; i++) {
+		struct packed_git *p = pack[i];
 		if (string_list_has_string(names, hash_to_hex_algop(p->hash,
 								    algop)))
 			continue;
@@ -226,6 +227,15 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 	strbuf_release(&buf);
 }
 
+void pack_geometry_remove_redundant(struct pack_geometry *geometry,
+				    struct string_list *names,
+				    struct existing_packs *existing,
+				    const char *packdir)
+{
+	remove_redundant_packs(geometry->pack, geometry->split,
+			       names, existing, packdir);
+}
+
 void pack_geometry_release(struct pack_geometry *geometry)
 {
 	if (!geometry)

-- 
2.52.0.508.g883dcfc63e.dirty

