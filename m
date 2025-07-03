Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379912D948E
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535024; cv=none; b=ByIpeo9pO+7ddqKaVRdKt72b6Nx/1JziwzjStM5IV+ohwcRINyfXnus+pQioPZcLp2oPaVllDVgfzW7bhgRYuYOOpk83xJr+Fd/vEPF5wa0DT6gaKABlY0vjX9mThVdEIpiJUErWJ43vhxTgFljnO+UQueIxPxFy9S1EtWyvEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535024; c=relaxed/simple;
	bh=Be8lgxdFKx/Pq/H+d7zAXA8D6vFFAjTGer1hDcCSFhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSR7jcQGf8aPrmglxfZ/jnHnSqUYkrNuy4wQDtl83FdjqVlXNwmReoaYW92UzuSd3LmRQQSibfGHBmwwhtWPAUdCWQ9RqrNDH42iGhQbf8P82GWUuTp/rlrUNSgM07NOKYrJ2Ri/48aRIrl6EhTbnXBuGr3ebem1+rMVMQCBCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LMEUTxLd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FWEhOJ5M; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LMEUTxLd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWEhOJ5M"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3137F1D00279;
	Thu,  3 Jul 2025 05:30:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Jul 2025 05:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535022;
	 x=1751621422; bh=9/DTGlUpfrY/i+8GsRLlUr6qRRO2rQYSGgQh61GHGoI=; b=
	LMEUTxLdZoRu0+JaP0czbPvzSWFHRKfn/XQFu1TT2GGaVTO6333fptfzdpdWNcc5
	ePIXQEBMA3oaIOHCkW216MSWNSwRAdjYOBrr1N/6eAC08SZc3on861orS5OycimI
	rxTA42QypSPZV46o4QoP3yJgXuWxtGHcu/GkGTQU5MP0z2uZm96bxbc66WJ+Zojz
	UwfWGCMx69e0EvwqrwrOZUL5D0F13uzEHtpZt1N5eNuZg5x3oaVRtH30wqQuq9bL
	NG3ft6SpoxCL/B4SFURtDcPYZuKiTEVICbCDY7tKOGjTOLoBIiBCpFXJuKzSVr4G
	3cLTTxOuHKHEtDd1FpV+rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535022; x=
	1751621422; bh=9/DTGlUpfrY/i+8GsRLlUr6qRRO2rQYSGgQh61GHGoI=; b=F
	WEhOJ5MZdIQzIcEFY5oP/W45nm5FJd6k4siklFvvnLX7C0JveGGVlX1mfbqQeuKc
	0l5Ld2HT39VReCRw45mMU1xgsBZ1LsE+SziBmgSA9b/4dl7b2b/jbBrwexkpNl3G
	WytOAk5a56d28TI4kBXsU7485319CyijbhdRtSoU5uRVYuJ1HeEZjpqVpHkjLs5X
	K6xtFLKnfDWB2zq+k0nycpcxMyC211zisTAmqhlR817mfATfue6tPaeNwKG2j32V
	27ppRLW11HYDiK2Z5njKS4ojck+G9azme7sYRhythXWiiFCj2LxpOs6d+vlEXIEJ
	0dFJF7NbNRI9L+rI14dEw==
X-ME-Sender: <xms:rU1maO_5VGUA47Rq-QDlPTLps_5XELdqoOApd96fXXc2aroLTM52cg>
    <xme:rU1maOtABXAsrqvQaU5VngVBkOCfBeLoy-2UWMKFfbNgybbw5uGNmyMuGBb2DZbUq
    fgw5_cUTrFJzqOA5w>
X-ME-Received: <xmr:rU1maEAelARpPzDcvWMrtHYWtBzKUxs1qSxLM9YIbYmFKlRMypOyEkHjBzgg7CyyPEASHOvkVp14G3HMxZncXyAQseAHL3RLnUNLDG6HKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehirhgvtggtrgdrkhhunhesghhm
    rghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhm
X-ME-Proxy: <xmx:rU1maGfNIa6Z9iv8_d5nYt_0EJZd5DZWlmNWUuTTyC_WF93PRCZLJA>
    <xmx:rU1maDPDJmxm-rY25KFA_6vy8EibU4yeP6jD-wmk0ysB4A4tixSCdQ>
    <xmx:rU1maAmLy41bspCBrPC7LRoQAoeB5haq5MaUXPzCVNysH97Kh4wg4Q>
    <xmx:rU1maFvafas3iuLvde0bBnFLU3qMCsZ9KB7z0ayNdZlUmIlFHOfHkQ>
    <xmx:rk1maLZLm2sfuGVkqGSJpNjGU2Bxfb7hPHffsxMY8RpZdFHu2OBczRcH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6822eee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:45 +0200
Subject: [PATCH 3/8] meson: improve summary of auto-detected features
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-3-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The summary of auto-detected features prints a boolean for every option
to tell the user whether or not the feature has been auto-enabled or
not. This summary can be improved though, as in some cases this boolean
is derived from a dependency. So if we pass in the dependency directly,
then Meson knows to both print a boolean and, if the dependency was
found, it also prints a version number.

Adapt the code accordingly and enable `bool_yn` so that actual booleans
are formatted similarly to dependencies. Before this change:

  Auto-detected features
    benchmarks      : true
    curl            : true
    expat           : true
    gettext         : true
    gitweb          : true
    iconv           : true
    pcre2           : true
    perl            : true
    python          : true

And after this change, we now see the version numbers as expected:

  Auto-detected features
    benchmarks      : YES
    curl            : YES 8.14.1
    expat           : YES 2.7.1
    gettext         : YES
    gitweb          : YES
    iconv           : YES
    pcre2           : YES 10.44
    perl            : YES
    python          : YES

Note that this change also enables colorization of the boolean options,
green for "YES" and red for "NO".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 4e41c3007bb..4f22d72641e 100644
--- a/meson.build
+++ b/meson.build
@@ -2193,15 +2193,15 @@ meson.add_dist_script(
 
 summary({
   'benchmarks': get_option('tests') and perl.found() and time.found(),
-  'curl': curl.found(),
-  'expat': expat.found(),
-  'gettext': intl.found(),
+  'curl': curl,
+  'expat': expat,
+  'gettext': intl,
   'gitweb': gitweb_option.allowed(),
-  'iconv': iconv.found(),
-  'pcre2': pcre2.found(),
+  'iconv': iconv,
+  'pcre2': pcre2,
   'perl': perl_features_enabled,
   'python': target_python.found(),
-}, section: 'Auto-detected features')
+}, section: 'Auto-detected features', bool_yn: true)
 
 summary({
   'csprng': csprng_backend,

-- 
2.50.0.195.g74e6fc65d0.dirty

