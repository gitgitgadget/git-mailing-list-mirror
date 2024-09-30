Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56606180A81
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683736; cv=none; b=qLiuUwxCK2ufA09eLwv6ffqIY2573cRJESbn985kJDt2d++j77d/MR8hE/8EAqiTq2nwhRUAhCC6eGMAzhcYaufAOrG8F69GsO7QqL+Yg4OSS2/OdOmrTJzYyzGB1Tg0BvO8LResmQ1slVCU58Bc7obmArDL6Hy6eOv7R98Fr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683736; c=relaxed/simple;
	bh=Zswhj8bzzwaDVF9AVjXkQKAz1m9kMspBbAzz3AT6mNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaXYnB9jtEeH2O3zU3h3bpxSNWY0llevTMAPL1H7Upqa2wOuPZLXXIXaE72S4jGrFAwDg9M8h68TIxyEouBCaNQdeBDgtqEqi1pLKBzgTiAFwwLTMbu2r/eMEa3DKm9rACdFFs8sCAg9Ndi41crH0BvygmB4fw97hDQN6KdAIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G6HmKmmT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJ53XeQB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G6HmKmmT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJ53XeQB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73EA1114020B;
	Mon, 30 Sep 2024 04:08:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 04:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683734; x=1727770134; bh=z8Kzk/FqIB
	ZU/NtRBLbQbHWe9vmBuE9QSNvJ4WCGjKw=; b=G6HmKmmTCb25Oh6g5fyr3nhV0a
	mzu+Tb3/l9OYoi2Np2A69cGpET05wfI0Z+gkd8lYF6nVWxlg3pFTE93H4QeUEPXF
	Rl4cbH4eKjOLx3I5sV1YXIm7iDJxprx0m5d++xM98B0czROK50CAaWvRagniuahZ
	Cg50H/eneS/aMq6FrP0ylWEqG28X1sx+P6WrOewaIzRkvGkFvUScEpDXB9twBosd
	k8GNI9IOxcikrEtXN1MivpPb777j4p7E+FoJHdGEqXCd/SdqyHBUei9620OvQggy
	f6tCxoqB+G7JzBT3HjfsT3d9lR7wgzAuM/eIXEGUPJ/Ngzo2hQ5eSHxqHgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683734; x=1727770134; bh=z8Kzk/FqIBZU/NtRBLbQbHWe9vmB
	uE9QSNvJ4WCGjKw=; b=BJ53XeQBjKegTsmoxytoeJw9B1R3LWnbPBGvPc8AFYq7
	TlFrAyYtDbTRFUuxhEGduYkIaEU9VZZa8AcLdhY6RBh50rEcHni//znc8dd2QrKQ
	h7ybzAiA4z5uDx8R/wdSy/0TxGIbd2jVNk4AgPCM37JniAvRmuwEaaRtlLNbjs2J
	xCqkoKPI6TuUXhBBr798nvXUFrbPu8LOyjJibbQ/h8alYeXtS1wODzTKC7wN2BGE
	fvtoHmo3umnxgTXn30OPurGjciXPlvgWDVgo47qwwsjxvIuRrImIPxN6zpImse5a
	RIh8Qd5fJgoBw7Xfp9JDDa0J8fxhddfyei+pCmKUkw==
X-ME-Sender: <xms:llz6ZnRTtiIDaAJAazPvu-rhJy_vNVEGRH6K5y-fvyKjmDd9Y_kfoQ>
    <xme:llz6ZozcgWUqiV50m7Ei0fmAYbhKSo5RLeR08y2-2eVvcZH4J8QZytVz92NlkOG7j
    hzZ54WPJO69Y_jBHw>
X-ME-Received: <xmr:llz6Zs0H4ZQyeM_z8xKZTRfTvjo4GYtE77-MyjffPVYML0Go4fRHfA-9daWzrIj55I-xMLdW2cBqZiCUD7Wv6J5aGaFTMPtumtVErfV1h4rpM6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    gvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:llz6ZnDssczr9egyZNJKVjPplkc_Zbp-2wb75OmbwDsLJuJtdvnUnA>
    <xmx:llz6ZggQslXg8LlRIVjfTH4swlUACri4Hbe7iIEa6M_SvhbtZ9U5zg>
    <xmx:llz6Zrqffq9n_FP48wbOHZH3QrU3wV6XPU1mo9OLifh76Cl1aorb3g>
    <xmx:llz6ZrivgHq-sZpVobAOEuGwcaboKiTBfaHugFdQAsC_z8QQfhe5QQ>
    <xmx:llz6Zod9Q7rVuw-v6VsjRMoet4wvWCWZsUq1eHP5jL4XO9zqW7oR-6Nr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a03bbafc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:07 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 14/22] reftable/stack: handle allocation failures in
 `reftable_new_stack()`
Message-ID: <c88645a251494de3dffea054887ddbe84468f948.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures in `reftable_new_stack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 060b2c1b90..1b77c9d014 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -56,10 +56,16 @@ static int reftable_fd_flush(void *arg)
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		       const struct reftable_write_options *_opts)
 {
-	struct reftable_stack *p = reftable_calloc(1, sizeof(*p));
 	struct strbuf list_file_name = STRBUF_INIT;
-	struct reftable_write_options opts = {0};
-	int err = 0;
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *p;
+	int err;
+
+	p = reftable_calloc(1, sizeof(*p));
+	if (!p) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	if (_opts)
 		opts = *_opts;
@@ -74,15 +80,23 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 	p->list_file = strbuf_detach(&list_file_name, NULL);
 	p->list_fd = -1;
-	p->reftable_dir = xstrdup(dir);
 	p->opts = opts;
+	p->reftable_dir = reftable_strdup(dir);
+	if (!p->reftable_dir) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	err = reftable_stack_reload_maybe_reuse(p, 1);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	*dest = p;
+	err = 0;
+
+out:
+	if (err < 0)
 		reftable_stack_destroy(p);
-	} else {
-		*dest = p;
-	}
 	return err;
 }
 
@@ -171,6 +185,10 @@ void reftable_stack_destroy(struct reftable_stack *st)
 {
 	char **names = NULL;
 	int err = 0;
+
+	if (!st)
+		return;
+
 	if (st->merged) {
 		reftable_merged_table_free(st->merged);
 		st->merged = NULL;
-- 
2.46.2.852.g229c0bf0e5.dirty

