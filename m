Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E026C385
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042233; cv=none; b=ivgAa5/WiXBAH+Sv2BwiP1D0ONlk/3smrH94eiPyM+KJkESgmGFQ5vsFMcwgdpdf/jAt1uZnnt6Ro3kRUveP5Not3ZZmFzY8u1+xgA4UmAcJI5rUf2rEtxColM2WiHsldSs7xj3x6XFet3KPFmKq6k/XrPfRmqNzyoy8ocCIh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042233; c=relaxed/simple;
	bh=LUaEzTkkMPUSTR5U6NtiZy216kXjkUypW0sRboJE+jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luVNJ+EcjQSPpBQEnGnLe2qAqTropElMDL5r7XGVI46TmKA6nUy/yqwWjfgMSED56AQBapxEIj3bVmdrJLGXvMoMQfG3ABl+HFB7+Sl6uOnye6phmDCdihTwBUn8ScFMNtvgBm6W61wS+7xAWC1RkZkAz0ECZGiFnMLLFACUU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V5SDNv9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVCq3QcY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V5SDNv9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVCq3QcY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0E94140025E;
	Wed,  9 Jul 2025 02:23:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 02:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042230;
	 x=1752128630; bh=E95ApTaLSY6qvPSljtVfNy7tEih5os4RAl6dAso6hwg=; b=
	V5SDNv9bcepxyeR8M0Ow/EyNiuSEn7lvvDMcyPuuvmIn3u2aObn3r1HpqgzqfNXh
	kmG/7eBwx3kWGPyMlhyG6+ZGq74lmf30dFfcW3jEIEoaWYUrtcDj0M54Tn5CTA4W
	YFc+CpnVYrBigXkbBA3OJTFc0cn3jHaynFpiqoFw4Xl/79mnWYrfeHXujI1hiKwT
	9xcvWy6ejhtPnirxXQf5xmkm0BfpP7GlZGoZmEZ/OJ5nrDwfJR4Lhov80j5EOWUC
	cUYkfpFA7H++CNoCOftpWkJUush2Z2AvsOQfKSL980wjId3RSodTxQhh+ZrUYG3x
	UknafpfA/Y6PzkXvM0+qng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042230; x=
	1752128630; bh=E95ApTaLSY6qvPSljtVfNy7tEih5os4RAl6dAso6hwg=; b=V
	VCq3QcYNsbv4LEqal1v1q9rFKMs4qq/zxSHX6QjumymFYw2lKwBd+ecQmXVKjopo
	MZcykhnuVJZgHKr6XBS065B7bDue6XA9XV846FZ7ow92QTGfQcpUEJCWd3mo1xaZ
	GSxumDq1OlMSjasDVku6h7Nug5OvYI8mVjCpSBrZbk+NnLYrHHdsYZKdGDA0hssm
	PN4fx9M7n+BCvED9bxvDQxIKTRTXKL6onE3SqKSnDCtyo6C0zV+h5GrL7TYUbSdc
	KgNCDaZAX4S4zmoro2qtzLa5jPYvov8iZNeGqts+s/soiPbNyw4jOswqJ1rLvaHV
	0ZxaaQtiUlq4+yiFfNNdA==
X-ME-Sender: <xms:9gpuaK2r-6wZ0oAuCKUXZ2nEGPr5y58REzJdHpbANuWPzXPhOStyYw>
    <xme:9gpuaA5bllTALahGIJ8otcRn1owLsxVn7hTbZ0bbJzZAmVU1d2dFetY1vqfPkv4Gk
    6r9RM01g6RBVk5I0A>
X-ME-Received: <xmr:9gpuaL-4CIFaSF0aGQtYTUUtGyu7I-230B5cmxr7iavGSQzZ5731ptwcKyyG7Yoi7RMR2PbwxlBMVe8x5lPo2d9nLtqJjRUk-9F9FqkoABT8eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9gpuaPWeoCx6CAcUU-8C7TnsoqvRJj8snAUnfVot0jO2kO4v_S2cDw>
    <xmx:9gpuaGrHeN3KtN9Ipk9rmyWKyxQq7pAzXOkJqQM7wrxy1oibUKqwkg>
    <xmx:9gpuaBni2iTLgQ-C88kg24SDzH5PWtCaIScDA1jMRmGx2BZhVaX2TQ>
    <xmx:9gpuaG3YSerVEk6Ynq4X8WNoPDLri5GH7VbutoLaJV6VfsTjJxqF3g>
    <xmx:9gpuaKvShosbzyjFEgIuqtlfZZmMvE5cHIhTZP_8gXnCFxQoC0MhwvV4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:23:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4de168ac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:23:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:37 +0200
Subject: [PATCH v3 3/8] meson: improve summary of auto-detected features
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-3-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
index 0ed00254ef3..29d076bbaac 100644
--- a/meson.build
+++ b/meson.build
@@ -2196,15 +2196,15 @@ meson.add_dist_script(
 
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
2.50.1.327.g047016eb4a.dirty

