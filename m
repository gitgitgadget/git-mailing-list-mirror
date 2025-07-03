Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ABC2D877A
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535027; cv=none; b=pXKDayuHY4KLsmVghDQvh82/eUOfUJiQWeSq7cdHgtL7h1GHkPboXq/xH8ZHTMZrfgqvMKy42i+Q8SxpWEOP38RIGD0NSp8miSkv68EaGjS4JGSqHxdJEhNWRwfDGXGQ2/nIpzydWMVXPldFCl1X87mWvljNmcp96Za2Qppru/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535027; c=relaxed/simple;
	bh=1hF//OB7MpjwgN7hTUiSGSiEYZC2uneYbHjLHkzKbsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bF9umfegtn9ycrxFSjJSP1yIsyt/SUVoHpb4wlH2P77v97eV2Y/drxXlsH0onTcFqVs5l1WCLaJdNFmBD+od4a4zVOMAl8nqGfnyDbpHzKuLy3FBFTCplCslVL6hJRmafHW31doG+cLhPMAvnokVck2c2gJ4F+O25RGZEc+CUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xMSXZgum; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9WyJy0W; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xMSXZgum";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9WyJy0W"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9D37A7A027D;
	Thu,  3 Jul 2025 05:30:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 03 Jul 2025 05:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535024;
	 x=1751621424; bh=N7C++oCxfNsq8K7+5JNUyKveB29NNlusyf+ft1e9Pbo=; b=
	xMSXZgumt0ZO73Brqaq6xQsyJyxfmVRivUx7SJS+1a4swukCNqfolTLyib+aHmR8
	rtk3OyobMRxAJ4alWpOhoePtP5BWCaItBt//e05twHFQRC9P8OzK+rIh+hXfC3lF
	kUghnNxAA7LEYwOOrxiFvgEC6p75qf7iwfiU8FjRvjSxYAy3Dbk8vYMi7Ztm8Fk5
	GpLI8aUnpDiAcSHF2CfMMmQXhb1OUPhdC0OkXehm4NBN8h+8Qop+5Gh6msiJ9Bvz
	nAxnI7lxsjSsjeeonmofO8RufANYFCi309vOGgiawTfrs5MuKACMjfyVO+YXyYJh
	QZ3+RZzEGQD2B1g94SOriA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535024; x=
	1751621424; bh=N7C++oCxfNsq8K7+5JNUyKveB29NNlusyf+ft1e9Pbo=; b=P
	9WyJy0WWa3b0f6BOhcf6fZwLtxuDqU4xTbrkbSRfrSgYRR1oMmbPKL2Anjre3ESQ
	lDVaVmTjZ4sF/MCRa/N32HJmhHD1NlFJ3LyPzeuMkVY9UY2aiCKM2LPsx0CPjoPL
	xE1IBPwTQQ5OMZFYO1pha4uS/FgDystJQeTnTEvkzuzLtkgJdtJiFYoU1Eq5MECk
	WdtPqnCaYkIqPaXbnE2sQr+Rp0suNOqDsgA/t5WnrriWuyOT0Kv6xJH9cx1YuZF7
	ZXxPU4yfRKYFeYlu/oCUHGcvc5Nw6VElL4wdHw5NtErc+0D9BK1EbzYkuHQZOxRs
	pf5ikHPP+3hyc9rOGbB/A==
X-ME-Sender: <xms:sE1maE5i-azG_iNaqk8hk7-KMTKPUJZYj1_a15-Mixs0pVYtUgcZHg>
    <xme:sE1maF4LX0B7NPW9gMhYigLn14GfAJ_pFkS5W-Vz6D3XJRayt979GFEfvv8DPphYt
    QI4036vw8zeIFG5Kw>
X-ME-Received: <xmr:sE1maDejtsKq-Vyyg8uRwcBN3h8fWjvHPc_VfDIbfvph91DrTSNwMtCgfa_6bYcK2llGXibLY_dAtn28mih2PwqNKX79xXxZHavHSbSWCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepihhrvggttg
    grrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgr
    hihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:sE1maJJU_mtiUIHxhnZfHEzST5ZQq8FXwk-9gpy5XVgIGuztNEvrcQ>
    <xmx:sE1maILyIEr62bvNWFKEY1KrKp8qpq8uGEtce5JOF45fULLZAojspQ>
    <xmx:sE1maKyppvb658AetpmJKg--cnG794pI1Gt5Fv9lsylKjt97saBLrA>
    <xmx:sE1maMJXlMYH25XF0eyfX0uvog0KomA9mlat_YkA8Gq43GyIGRtiYw>
    <xmx:sE1maMUTvbcjISCnGTKAEhXil4xBZcB0DIZRlpfFJgdsqr1RUYUUVUqk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7186c3d0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:46 +0200
Subject: [PATCH 4/8] meson: clean up unnecessary variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-4-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The `manpage_target` variable isn't used at all, and the `manpage_path`
variable is only used in a single location. Remove the former variable
and inline the latter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2fe1a1369d4..4404c623f00 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -375,8 +375,7 @@ foreach manpage, category : manpages
       output: fs.stem(manpage) + '.xml',
     )
 
-    manpage_path = fs.stem(manpage) + '.' + category.to_string()
-    manpage_target = custom_target(
+    custom_target(
       command: [
         xmlto,
         '-m', '@INPUT0@',
@@ -392,7 +391,7 @@ foreach manpage, category : manpages
         'manpage-normal.xsl',
         'manpage-bold-literal.xsl',
       ],
-      output: manpage_path,
+      output: fs.stem(manpage) + '.' + category.to_string(),
       install: true,
       install_dir: get_option('mandir') / 'man' + category.to_string(),
     )

-- 
2.50.0.195.g74e6fc65d0.dirty

