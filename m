Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065E198A33
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530950; cv=none; b=ECUraMd5WwgYj7Oij0c+4anoE2iCIv4eAXHi7yqhKf3vAGf2laE39v+GaGARZbBPbHyyDYGT2WiROpSFI+BtZ8vWyt8Z3Xt54XIfYkLi1L3jHcalGxEJEHxyCklzTTfjLd/MXyQKd9Dzpbwa2oC8I7GG7DsCQar1SXxz7337NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530950; c=relaxed/simple;
	bh=3jNulDoEtszGX6IKGHMO60P+FD+bIrdOXyjTWR7fWEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UerLodECRxhFq+00O9Vf/1DxADkTyHcg0rbNVW7JNLmtMGinUrkkQ5pQckt+ahQr2eYzaUSSXB7pn2hETo7pCP9OWZkbc/XqOAgs/FD4UzTttta6eTQ9iXADRXq0poA5KF29AayPed12Ka/7wnE+Sdjw6n03GpljCN6z7n9oRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NFiZSjeC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnLSIl+R; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NFiZSjeC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnLSIl+R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AD0E1140265;
	Thu,  5 Sep 2024 06:09:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Sep 2024 06:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530948; x=1725617348; bh=NYrmNutO5j
	gH0+qQyI30oOFidvbdgYn+jR/j4uVZIKE=; b=NFiZSjeClZDj6Z/heWP8DWkH7b
	pbnWuUOVWvm2L6SF5SODFqZzpA8BzTKTDi0T7kTPSMN4YeGJhcrhvh+0RWxBtXXr
	0dQq7/omv0lFNM2ASPi1k25uq+8YAAftrfRl2kB7563m7Th+o1iqxrPxVzLLPE4k
	Pv74n1827pObAxApbPreqXOKV+gaDszI6/0t8x75Exc130czzU+iDQiiSuCYY9Qq
	cI7zxkh06T8q+hwaiyTyPmftoG/ZLBZXWH+JL7pfGGaDi0FJCHRREItCTYlOuIa6
	PWQ3t8IvhGaA6swk34hdBQHlx2WTWhgKvBQj+IxAYCAXCBzr5ZIe0Odde4vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530948; x=1725617348; bh=NYrmNutO5jgH0+qQyI30oOFidvbd
	gYn+jR/j4uVZIKE=; b=XnLSIl+ROPvQAEiqwylRy9to8x6MWDBYHM8ie1W7jte7
	RKA4Sn1I+Vi2MjR/xmBPaWicKr5dPso6QoyNgD/ri7k/Orow/HBK0cGxsLEs/LhY
	QQ+joF1YZ/W7sPMEAwdOuUAgVz6OPiGL/vjkEqt7gEOP+UOI0VPwj8LobvRVhnto
	CSl15c2mz9CDJ1TSvawrbC/8dIpc1ycmG3fXfHh4bvmb/6wvOzyh9NyNNphAY/6l
	Pv0KAcusteUig2KSw8p3Pt17B+qf1XWP7r1HRChA29ub8l2ppRJC6KAn/DSgKNcu
	erCUn1rvNRKUSj+Dg5wL4drm/8z3Ay+bV0lEYo/WfA==
X-ME-Sender: <xms:Q4PZZsaTtfoWvEa4PvUB4VfeqF5sC6Fn0OeUyLPIwUap1nPRn7DaPw>
    <xme:Q4PZZnbrkRggJMS1h5tWjZbO12Hddt_k0G2-01LdsGiSyrz88z74J1aTVwg3raAcI
    YceReeLsSgiY606cA>
X-ME-Received: <xmr:Q4PZZm-d1etZ1y0nTNYmGaBFj07mUBvJRLPFsEtyNN-QDJ-bT1Qqm-V3kNs0ggkK-IuTl8RwB-keYP3wa5ndTWsI8gNjzxnLiOmYP2rcFxeOIQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepshhtvggrughm
    ohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Q4PZZmounf7_x4XX4Y8KAW7vJmx0R_GdKsQvH3XAyFvTVaqssZkXRw>
    <xmx:Q4PZZnrDm5IZtW1pOdCaLYNRgyQS8D2LgQ99MVY6Kw0E1viu_rABpA>
    <xmx:Q4PZZkRzUN8AUZdnAQX0bExxHNdKL7ZvzxqYyrs370qkE3mDJtS2jA>
    <xmx:Q4PZZnq9HQoYwqVv3GD2qBdaGXc8AQJSKDL2P5okoLRyaZzFQAdfAA>
    <xmx:RIPZZod2Z_R6SVXbHK1fe8dBJJlXxb88FpcAdpHD8gmL0ghm9QB_b-nN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 86a53388 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:55 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 10/22] send-pack: fix leaking push cert nonce
Message-ID: <a1baba39bc555fc8b9d82b0148c7ad5449ed3bf9.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

When retrieving the push cert nonce from the server, we first store the
constant returned by `server_feature_value()` and then, if the nonce is
valid, we duplicate the nonce memory to a NUL-terminated string, so that
we can pass it to `generate_push_cert()`. We never free the latter and
thus cause a memory leak.

Fix this by storing the limited-lifetime nonce into a scope-local
variable such that the long-lived, allocated nonce can be easily freed
without having to cast away its constness.

This leak was exposed by t5534, but fixing it is not sufficient to make
the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 send-pack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index b224ef9fc5e..c37f6ab3c07 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -501,7 +501,7 @@ int send_pack(struct send_pack_args *args,
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
-	const char *push_cert_nonce = NULL;
+	char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 	int use_bitmaps;
 
@@ -550,10 +550,11 @@ int send_pack(struct send_pack_args *args,
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		size_t len;
-		push_cert_nonce = server_feature_value("push-cert", &len);
-		if (push_cert_nonce) {
-			reject_invalid_nonce(push_cert_nonce, len);
-			push_cert_nonce = xmemdupz(push_cert_nonce, len);
+		const char *nonce = server_feature_value("push-cert", &len);
+
+		if (nonce) {
+			reject_invalid_nonce(nonce, len);
+			push_cert_nonce = xmemdupz(nonce, len);
 		} else if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
 			die(_("the receiving end does not support --signed push"));
 		} else if (args->push_cert == SEND_PACK_PUSH_CERT_IF_ASKED) {
@@ -771,5 +772,6 @@ int send_pack(struct send_pack_args *args,
 	oid_array_clear(&commons);
 	strbuf_release(&req_buf);
 	strbuf_release(&cap_buf);
+	free(push_cert_nonce);
 	return ret;
 }
-- 
2.46.0.519.g2e7b89e038.dirty

