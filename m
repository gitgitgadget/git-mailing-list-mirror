Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B743AA8
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560073; cv=none; b=WmpmQB0lnpnsv4ZrIt8SIuylW7AR/JddPmji0dV6rxoqvVSDlaVuIEUC9enA5vpUJ52pZVdz/JKVP3+xf0efMNzm5PZzJ06p7ZBlknRc7MnM0IPtbcCkVYAWx639R9Xoe76eTf+kS7z7310H4wTsmO5cHaB1vtjPrvKvxeuOJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560073; c=relaxed/simple;
	bh=/PCiYWVbQpC80mBiC0oUJ6LMWWyy17J91RtpId4Lcow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUywKcME+WVhYtOuLg1LjXzSFBvXfhEt93hbxbPKFbuqK6ViRJouaLUwIokKsB/5RzMquVmjrd9c7GwlM13YT+K6gmgGlBO3Jmdg9YBaegT7LH6yl8I4/iYc2bkm7eiGBHJWcelMXGYFpekUKsVXYhQ9C/cA5pkPmEVFb7CSKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m+k/f9hH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uzIMZLlX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m+k/f9hH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uzIMZLlX"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 77B6D13801A8;
	Fri, 25 Apr 2025 01:47:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 01:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745560070;
	 x=1745646470; bh=Awe5wve9OWm8g3HTHXVQodpYIeqZJiPvWFA2dhJQSpE=; b=
	m+k/f9hHhb9NbomNy1wu6e77LIF29zYpqV9GhjalkfUIVZTNOLMel+rW2lDtszbG
	WFogv445qRkctJdKnU4Sb9Qgj0gGw0JXIBINL25ZX4yNp/XMIfUzzAzqwYCxzvWQ
	dDmgEl/CmyieiUUA0qnQXOCFJe4equ/Z4rjIvgDMc5H6WYc9C4/OVkKBnp9U1F4w
	naiPPUV6Y9MTIpxUNwe+rFNkc9oI3g3UW+52uJqJsxT981OHHufEqr15DToMjHNQ
	3tuNqCI7NRjk0OJumAoH8By42DzbW0Zht6qBvHfgz/W/STxUD+b42tHx3TJ7TtaD
	iF5tmK8m3KK/OBD836RHhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745560070; x=
	1745646470; bh=Awe5wve9OWm8g3HTHXVQodpYIeqZJiPvWFA2dhJQSpE=; b=u
	zIMZLlXsZPkwTNEuD5q5B3/pEDTNdDRoACe5auaI3bXCAV8lrP9BBA07vkVZr8rk
	F5hLkuo+PGu0UJlnlcYUS4vexRGRVhbl3zHtdkhhgfvOEMHfvNteU5stT4jZu0N3
	83Diro+3gYdWQWTEg2RJ2SgERW3M99aeS5nlJOOFVWfG6FoRDnmOr4WSE2wn0scD
	x5QFEmsS7E/iZvP2n5FuJ8hv4CrrDbxma5/SNftS2CAR8AkNRulTu5hAME+nCf2+
	LKT+EF0WBuhfKk2WcK+/haDJUoRNjR9OArpiLVyc+w8Ey4lv+hE8DZJj2pPLaPfd
	MR6pwDRfcyNKVW/cXTxdA==
X-ME-Sender: <xms:BiILaJt-jS0AAbJtqIG0c1HsxwMoRwYweb48azPtIiEFv7PdDZBQuw>
    <xme:BiILaCdG2O1TkRT2oGq7X5X1QHv2OIBu6qa7bMDebHZXwZEPPxBIIuGR2cuhERxBq
    GGqoVlFlgidmmeOJg>
X-ME-Received: <xmr:BiILaMxAcQng5BvgsfaS3gT55pntlKkz08isrPsVvMhP50mNFtEUuOOxMoEH3GsjJPgZq-NItr6kRonRi2qb4ko-8OMGr4dwjoQ8vzsO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiise
    hgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BiILaANLY66xgMFanOieGFP3QYsuzt8wphxo7quvPFBoVyU8u_OSDA>
    <xmx:BiILaJ9ms3IP72DMfFJiB-DPnIFBOg2PgMFuU5zx0gH5-GnMLGay8Q>
    <xmx:BiILaAUoEAIKyVrNOrBQ9mBGyvSG4XtvkadUgyutOq5KopIT25Bdyg>
    <xmx:BiILaKcZDxLueWy7EBUMTXYS66ijXghiDUIjIUvEE3vapIoiZFM_2A>
    <xmx:BiILaDlZky96aNweHXc4839y6cjg3m6zmfgqFY_wnE9EntSyLBE5gX32>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 01:47:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6d48d48 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 05:47:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 07:47:44 +0200
Subject: [PATCH v2 1/2] meson: report detected runtime executable paths
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-posix-shell-v2-1-fddc6123511b@pks.im>
References: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
In-Reply-To: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Git needs to know about a couple of executable paths to pick at runtime.
This includes the system shell, but may also optionally include the Perl
and Python interpreters. Meson detects the location of these paths
automatically via `find_program()`, which does a lookup via the `PATH`
environment variable. As such, it may not be immediately obvious to the
developer which paths have been autodetected.

Improve this by exposing runtime executable paths at setup time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index c47cb79af08..a180c66ee69 100644
--- a/meson.build
+++ b/meson.build
@@ -2080,3 +2080,9 @@ summary({
   'sha256': sha256_backend,
   'zlib': zlib_backend,
 }, section: 'Backends')
+
+summary({
+  'perl': target_perl,
+  'python': target_python,
+  'shell': target_shell,
+}, section: 'Runtime executable paths')

-- 
2.49.0.967.g6a0df3ecc3.dirty

