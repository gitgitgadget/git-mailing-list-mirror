Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CB1AA79C
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568657; cv=none; b=HEznIVADOyXA30NwN/pUL3w6IPH92fYUmPah0H5zzlhi5Uo8EdHSCe8sSBYjIHoFHdIOJX7zY7SMSTd1+b3IQrcUKYfC4jobh9+xL9HQxutJ2Vj0GUgPzxrj2XFtTpbTWFTUcu/vQWomBxPkqPkOFFvS9p/ISBxaUydp6n3GYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568657; c=relaxed/simple;
	bh=bS5evWXb33XPjmaVnvFvoC3Uifv6g/oqonkDRPQhScY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5uhYJv46neVasdklJWbcz9qI0UCE+hbBJjUGJgxPSe7aYTqvWhFzBxFiHwTek7O6ARSZ9dxe7uDyyqsVOWTas2/Arjd6o7Dla5RAi/6PBPCFpj+zH5eBIYBccNYnPpIhQqCLIWnYcufsAGVyz6B9HvKvhNgyLpgQ6AHlX5kcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m0WJ2uE8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Penb2ikc; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m0WJ2uE8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Penb2ikc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1475B25401E9;
	Mon, 30 Dec 2024 09:24:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 30 Dec 2024 09:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568654;
	 x=1735655054; bh=P0DlE9cWGE/TKbpM8C4trBcg1hG+giRcQ78PDr1j3UE=; b=
	m0WJ2uE8NNmHQrAl4Clj7iiXA4+TfC1t0G0UJMAXHvilYyeaLXQkWXPqTFFZUxwK
	HU+SL4o+YHglbRWMCgsOPPDrKQWMguCRTws52Ope4dGhPSCGGHqEShhcrWnmrh6O
	mnFXHYAVe0AyiKlcxnzKkvpbcAs73qRV0wt6+oI9yLozeKLhyoSjx9A59HaCkD1Y
	L/a8kgyB1gJ1Q5Yize09k+fdwIRWXtZ2cn0xZtO+hLXKBfFjX+XTKcbaQ+JuVXeP
	hK2b6gZiRyjJ1DORFN9+54sxP7ybcTzZ+PXGyCQ86cTl1J7iv6uYOCvYBV2d3mSa
	lCJ5PdcAWUofRIjEyyWhbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568654; x=
	1735655054; bh=P0DlE9cWGE/TKbpM8C4trBcg1hG+giRcQ78PDr1j3UE=; b=P
	enb2ikc+tS4n35djf/V1xElrdeN+ChgqufZTRA7xo+D6bHCAVkKjJzGn5I15AvP4
	NaEtfJhy1SCg76SmtyFCjQPEH5lwowDsA/a3rUjANSM6NL3ejsvBJtpaot38jJUf
	7MRqIxSvp+GOxF9SPtqq3sXxXzcAOTuS+Aab6VpJ2uYerobp3RQnGukdBojFkzjD
	Xqo6D5p7dSIikWObGjR3Bt6abrQrIOhvh4MeifLGm8Otk0tHA4LAOeYq6wlSZbX3
	/bhmzC8czCdiyfHj+fS+++xb3XY5FqXgpJcI0FXd+y8903+bjMWypQTPi7dhY32J
	3N1cuhSK0oddAWYpBqylQ==
X-ME-Sender: <xms:Dq1yZ7x_u_B_CiBsh_EF7mVw7PiXgUMlR4LQ1Q_CvpdbLSMNfvS7jQ>
    <xme:Dq1yZzRn3gWaMP2hYgfS8CCAEeowiXZ1YSA4Ays8ZkGip2Pab_NGxaHMyfsYSYFSI
    PrFwoHBEZtS5zvBHQ>
X-ME-Received: <xmr:Dq1yZ1UBu4PnOnSDhtb7pyhUymp1pF7sn66aVYELKKuCZFkIulnPIBC0uf90-TgrWd9gl_mJkJzacNLhoH4kuTZQJKX3Ir3JYVku0jVrh9ZGXGM->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Dq1yZ1hbEU89rR9BTpbjI51MeYvaSgbY3GT_XCWSN0lYcztrLs6Cmg>
    <xmx:Dq1yZ9C42AOA6bgEml7BcfhnHZpSET8ILvfZfJZ4em4gnPeOthUinA>
    <xmx:Dq1yZ-Is-JkfpihVnuaOluNZa-BXIDNo7UbhyZqLDVumPwqO3cQyDQ>
    <xmx:Dq1yZ8C581UT4asUmZh9iA1LvYhnMnFLia7TuKVHwG_k1MxcxawU-A>
    <xmx:Dq1yZ8OMML0-TvpXAzoMV4BssZBi7kn7IP_XCT2BWUQ68_klsPAF-RYr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 897b74c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:08 +0100
Subject: [PATCH 08/10] meson: add missing dots for build options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-8-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Most of our Meson build options end with a trailing dot, but those for
our SHA1 and SHA256 backends don't. Add it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson_options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson_options.txt b/meson_options.txt
index a7f308d217f29ef301848e63623a49207ef83125..d8d283982bcdd0f688556e0102c0133061dfb304 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -50,9 +50,9 @@ option('regex', type: 'feature', value: 'auto',
 option('https_backend', type: 'combo', value: 'auto', choices: ['auto', 'openssl', 'CommonCrypto', 'none'],
   description: 'The HTTPS backend to use when connecting to remotes.')
 option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'CommonCrypto'], value: 'sha1dc',
-  description: 'The backend used for hashing objects with the SHA1 object format')
+  description: 'The backend used for hashing objects with the SHA1 object format.')
 option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
-  description: 'The backend used for hashing objects with the SHA256 object format')
+  description: 'The backend used for hashing objects with the SHA256 object format.')
 
 # Build tweaks.
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

