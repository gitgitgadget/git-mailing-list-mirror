Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3081849E7
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351211; cv=none; b=obIpMpoEQopKWmPxdkUubOETThjMGJpy1jBoqDAOYm85fMflHpZmpUsWzHRrTFNIhDpvphnHh8kUVtmUtYaHArlB+VtBYT02sstjUWI1Swtc8HnqNORKHoIgihGKOcYYSC+QzvrazFgy9WBsPaJSQVwSiAOXn58ce/eks/fsXBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351211; c=relaxed/simple;
	bh=pDD7D9CcnXwaAmsKfNBN7kj5HNBRCMFffkZkL6ywj2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paChOqtvWivP84PNOWOl9thA+yqTOygDYH96tqE2MDGLtBR8c9z9OCU5+IUnDq9Sxsr1txgLIZgkUMR/GXDGXk2AECaDbAnhZHs+RhV9GQ8E54RhmUkatm2umD15/FGzlXtxSaTUDIBaxByjKmjXhd5125i0NNeBnFS1HJMUvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lrpn1K6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWf2mEvB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lrpn1K6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWf2mEvB"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77ADC1140242;
	Thu, 26 Sep 2024 07:46:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 07:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351209; x=1727437609; bh=CWtWbvbwts
	iDKJRrls3/nQgEIvJpKLpMvoBzqJ1jt20=; b=lrpn1K6ACNKJdXpprc6lajWA4U
	PQrI8PpxvzwgBW/UIGcfyRBrekPVpfYCzUTaOJdqCDmSgSuwtqxBXtc6irEG66iL
	ww+aiGWQq7oYykhBHHMQTd6VfXKWv8gH2OICuBDAzjS+QlinLAa9L5UYpMDFltIa
	/tHfx/Dn3H8O+x2Y7bAgCJB2K3IIMZPCdWD9lu2HyXZQNZFgi6udgk4yTgClkySk
	MHx+gEHAuua/QB+g87fzbxPza6vd6JKKofqfyY4Tcns5frzGBE74OrYdxOFZzuX8
	AM7ao/MGmY9Bj5++hGOS6KtSXohG8UMwmJYmeAj6ZwtYVG7UWkyS5s3Eao8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351209; x=1727437609; bh=CWtWbvbwtsiDKJRrls3/nQgEIvJp
	KLpMvoBzqJ1jt20=; b=ZWf2mEvBvC7J90Ma5M8/UtLX6mc5V7BUb2gg+51Ng9oY
	E4lgGscyDa8iXBuSeIpT3IKu06u+5PvayBJBr6Q5bAgl+F8TRyGr7gtKoE+8fEoM
	CpgFHD5ZM4RLfGU0yYlCZoSd74QPAJlvOq6y5pA21J7v7OLwDaqYSZUGJa9+pssP
	uj2vI7NDBvnnlQWALSEeRcjruKBhMzPkdvDxtG9dsssyXt+HiTvo1wr1QCnvAx15
	mnq70wf/IZWY9bBZC4uR4+sXvK7MWtKR4sl3fw7nVrdF/Lb9Mi5plGt6BP4kZs9p
	s27hRPV1lts6t+/Pg2NBqndhv/I62cCWG5dRcLX+tQ==
X-ME-Sender: <xms:qUn1Zkeb-kmVw0AAzOqgZrpjx4Og_ZpsVAeRsYXtBuuN11c1iN9jGw>
    <xme:qUn1ZmMDoKarUsASIEuoUxRUH6JbL-c7FKaW1F1FibFkQIcV60_NpP1W_mduSdEAj
    qh-MBow-Ylr4r4aaQ>
X-ME-Received: <xmr:qUn1Zli70KXnLzRPbmHTxpTkkt3NJa-D7mruFoyYkxiLQeS-n4appWDLszwUvmXj9FLWKEb_AbiCBXD8PpngZC61EaC36z0w6_7cKrX_KYlaYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qUn1Zp9ANGyd04JFoId6efcI-atcABVAkzs9PmS0Anvu9kbG0I2pZw>
    <xmx:qUn1ZgsiJrVDWLGjyAksXaLZrcl6s7a2hz5z8N54bipBpQDPBaCuAQ>
    <xmx:qUn1ZgH93NAkfnOuwEejYc_WkmYQYZ0v_Km79nsiEGAr7L7NFpJZWA>
    <xmx:qUn1ZvMw8AaOzIh05C9pLM2QQn6dtYOUxfM1nF8k5PqOhgfxkkRfJA>
    <xmx:qUn1ZsKhbUMPJ_5XFbDPJSr2oRgRf96oxXOrjg3BGMpWnBaV-WYRPBXD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61d89448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:11 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/23] trace2: destroy context stored in thread-local
 storage
Message-ID: <30928eb8f9ce4c2e6a82f566ff740c31604b0d5e.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

Each thread may have a specific context in the trace2 subsystem that we
set up via thread-local storage. We do not set up a destructor for this
data though, which means that the context data will leak.

Plug this leak by installing a destructor. This leak is exposed by
t7814, but plugging it alone does not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 trace2/tr2_tls.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 4f75392952..7b023c1bfc 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -152,11 +152,19 @@ uint64_t tr2tls_absolute_elapsed(uint64_t us)
 	return us - tr2tls_us_start_process;
 }
 
+static void tr2tls_key_destructor(void *payload)
+{
+	struct tr2tls_thread_ctx *ctx = payload;
+	free((char *)ctx->thread_name);
+	free(ctx->array_us_start);
+	free(ctx);
+}
+
 void tr2tls_init(void)
 {
 	tr2tls_start_process_clock();
 
-	pthread_key_create(&tr2tls_key, NULL);
+	pthread_key_create(&tr2tls_key, tr2tls_key_destructor);
 	init_recursive_mutex(&tr2tls_mutex);
 
 	tr2tls_thread_main =
-- 
2.46.2.852.g229c0bf0e5.dirty

