Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F522A4F1
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501909; cv=none; b=FXinyaB6aQgL1HcGyfENZm96BL2dlHPg+5RABrV+m25//hNsYN1T43SuvFKELEjtrx/E6/sr4GzE69RgpV68LBzjWt/xQ+NAQrvQbftnn3QX6DN9J015TYAzUm44X3y6n597g27OryooTfps49ZvVSmlLZCmu/WjP0XpqpncpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501909; c=relaxed/simple;
	bh=VuUHQSH9xHXEjvViAE+WHFdYLclCieLj5qwbeseiXmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxTmPOi7iFtaByevl8i9GmAOiW4TkhlOpe3E9g75WIVjGPgwGrrWKg0CUj+2g1HGNCMws3vC5B3yICz/on/+JUjdqoF1FcDryY21UVYT7A+fp1pc411uDFVK4scZKH5G2bpKVyICnvLC2XMNldFil/KlATGqrvqZSSzwgVn0u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lq+Sk9v9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uUj/Ho9W; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lq+Sk9v9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uUj/Ho9W"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 13DB91140259;
	Thu, 24 Apr 2025 09:38:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Apr 2025 09:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745501905;
	 x=1745588305; bh=wiv2zkaI64q8o6iOB7qs93k0qfPKvws4zePTEtlcGec=; b=
	lq+Sk9v9XGyFb+HVT8PJTv6jLQNV/q6U+jq17Q9m+KpQ/bz/MlQJHPOORXLKaPb0
	Bhe9sH+7QX9vCbRRPSot3g00r21SaIxkRD0VDdIYLWE0dPWN4y8PQIphaXCAUYcz
	0Ni0zOQKSkVHZYMbAIv2ZyPI0dciLDBnKJHqFRjTmiWt7BkmlcWRJfRoahRbNMqr
	h5XtEMAhTOqUMWevojol53LYHDMx2hWZ/N+OOFXAYU1tPj5u/FKYQ4s4pAxit/Ks
	NDBkxTSK5V0LKBwqmPkZETx5xivfDzqSuYwLp/Fr4Jw823c4u6KfeK80nrBHULQb
	GgGNWTvugLWfvmjV/Bcenw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745501905; x=
	1745588305; bh=wiv2zkaI64q8o6iOB7qs93k0qfPKvws4zePTEtlcGec=; b=u
	Uj/Ho9WzbvkgPPnAujuiaY0kzae7ANBc4zAOLIc8HY8KgaleQhWYh5/2hcjQ83C9
	2WImt33vDlSIkO07NktCToyhNGEV8akgr8XkoXhBSkDFxvk3Nc1ym1FS/d6s/T66
	7EiIfxQuRYzSZBkVKw9C/l5+I0aIQSkO2ptXymuRKPaoPJcmw+Dw+ilTKTE3BGsG
	lVhvNYLRQaP7cxRMz8n94vA8K+vgaMEnkalGqJ4N+49scbEpOulD5qldeRleoIuT
	LNhqs2an5W1U3hE0r1+1Ug3WFg/ni357LWRxAyrhT9PBV3AvVVp1lH0E4YXE8k17
	Dfx2T93hjOLCuai6aJCMA==
X-ME-Sender: <xms:0T4KaEPzH3gQLlh7bodcRibTKSxYWc7-Z4hqrDdepEzV4_zSOeW-Wg>
    <xme:0T4KaK_h4n01u1YHZTwLjpSpdnxJyAxGgBbr58UbdiZjm_RHlFkm-jaCHX-v5Gn9I
    fW36ZVgIrOGNpXl9A>
X-ME-Received: <xmr:0T4KaLSpETeoz8NFzm5Ccv7QWVodaa_dj0w0l9HrkATLWnusXn5SJg5uv36jmCPqzY8p8MG28KM8HTU-HuPDd7hJ49tarB_GJ2rneTzJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshdrrhgvphhorhhtse
    hgmhigrdhnvght
X-ME-Proxy: <xmx:0T4KaMtl0B8tWpPogU4i6Nia8k7KMrDaZ70IwgB0haFGhia_XKEXVA>
    <xmx:0T4KaMd9l-SZipVVC2UxGWbejIVfuU-gTitREUlTXvEbVDQUpTM_zw>
    <xmx:0T4KaA3023WpRhS0iiuDEDvYYAqAcbplxpZRwwt6oocKikZMzcbqUA>
    <xmx:0T4KaA8phIAO9S8eo3WLNyzY5hGN8uumJXX_k3POdyJd1Jtk1D8AUQ>
    <xmx:0T4KaPxQ1A7cdAz4DXCq0l8RV3l5n3AASFyvOewFzfu8HHlGe_o1n3fn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 09:38:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d116d82c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Apr 2025 13:38:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Apr 2025 15:38:15 +0200
Subject: [PATCH 2/2] meson: prefer POSIX-specified shell path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pks-meson-posix-shell-v1-2-45e06ee4b6ad@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
In-Reply-To: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>
X-Mailer: b4 0.14.2

Meson detects the path of the target shell via `find_program("sh")`,
which essentially does a lookup via `PATH`. This may easily lead to a
subtly-broken Git distribution when the build host has its shell in a
non-standard location that the target host doesn't know about.

Fix the issue by appending "/bin" to the custom program path, which
causes us to prefer "/bin/sh" over a `PATH` lookup. As this location is
specified by POSIX this should make us pick a better default shell path
on all POSIX-compliant systems.

Note that we intentionally append, not prepend, to the custom program
path. This is because the program path can be configured by the user via
the `-Dsane_tool_path=` build option, which should take precedence over
any defaults we pick for the user.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8f04534c7ff..1db768380bd 100644
--- a/meson.build
+++ b/meson.build
@@ -236,7 +236,7 @@ sed = find_program('sed', dirs: program_path, native: true)
 shell = find_program('sh', dirs: program_path, native: true)
 tar = find_program('tar', dirs: program_path, native: true)
 
-target_shell = find_program('sh', dirs: program_path, native: false)
+target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
 
 # Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']

-- 
2.49.0.901.g37484f566f.dirty

