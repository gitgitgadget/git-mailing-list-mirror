Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A321147B
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071840; cv=none; b=tNJEoMA8yIGQTLcxz09zaSYtkMZktzIEQjmkR71OS50ztm477E8oH8BU2U77tV62bEGajdSUrLXcpQwiAw9ITDzYpx3VttwNLbihOkgl3W7vzC61QSevc558RlnnOcqdRSDYInPiT5HXgExo0BJ6vdNaknKLAYZw7Q+/8WTYvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071840; c=relaxed/simple;
	bh=SqgwrBTkrYbv5glFIrb56jno8ArmyZR/5hk9xLLHDZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+/dGGT2TnZ6EjZfNrK6CLm6EmgsqNmY/Gc93OwNc2pC8E94g7ywg/tXmZWB7XRpLtsXUuFjeo+srsDKRWdLpRVa1ZIRU6annj+THC7y04m2AM51ptivvjNFVHxvC2TkBSdoP1mEeXhSY/8M1wOPYYwkrKZ+8gJhmSkIMWLV/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=buWCD7+O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mNqFE6rP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="buWCD7+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mNqFE6rP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C1BD013839BC;
	Thu, 27 Mar 2025 06:37:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071835;
	 x=1743158235; bh=qOkz5tNStvWV5OcPZ4w3xCtLyTUs4qHhI9eqR2Q3F9M=; b=
	buWCD7+O+H3VQ7gf99rPlTEMVzFHicpDWOZA4bzkoKt43f7hGWJf81X+ZyAuRcl/
	DyNh7VljMaap+rj5PfHRGDF1dGyhz996oup8QGk1jasJJ9ysGuAES5CemHAajc6K
	5Zc/ux1DI/H8O3d4cTElTL6H9ogNzxztJIuY6h4OJUyEZ0rO3bmP+dLvUuSZZVmv
	AihZM8+6mE3YuOil2TltAJP6rGKT1bHgq5g0SGYklZV2B5TY7BteA9HK7NKNfoXZ
	KMl4S4DV3BET9lLWeeZWh1abBxBSveJ+hKwXr6n90Ea9mCrW7gf6kbH+2vMYj2+X
	hojs9kY5S3u6R5xA6n8H+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071835; x=
	1743158235; bh=qOkz5tNStvWV5OcPZ4w3xCtLyTUs4qHhI9eqR2Q3F9M=; b=m
	NqFE6rPAXnzaBXdgLN5Ys202PT2BNJV6B2wKmPQ5BRJ3zeAigT/Og+gOLVUp92ei
	4fCIFJ5iQBkuCOLPsH2xHCkLCzrsVr/Rl21jFaggWmJD52PXQqZAhQIiegkOXlNo
	4damA8rQeXSKGX78uShxLffkCdy4uEbLJjXCU798hql0f0slEEvO1Cb1mB7fkjDC
	ykfFZIKvpPawNWOtO9FfKfLm81YdiXMhLhM/6Fmg2+oNNriX0/LSgTSSBPUePPYS
	hOlwGvgf286JqDMxnv61suA8kgu9kCbPdxnjKJ9QwDuJB7ijtiYe4Obtr7+nUwvf
	pzLOOmnf0s8pjCf/W+OVw==
X-ME-Sender: <xms:WyrlZ5ttP6DJM7Y8GWkLd1BBl9xkxf25R5txjhCd6IbvaHKefmJ_wQ>
    <xme:WyrlZycJVfSyyyLd30CKykZjjpexpYeOF36we_MaRrQ5yMvy6vdsy3cvoawwq6pt3
    6cXYmX_xUzZFeeKAA>
X-ME-Received: <xmr:WyrlZ8xHwqfdO_cWBhf9JRG9Gj3lhVEDcFrRvyjdvDTqo2qDX0uKm2AyclqjLrTeYcpntmkstxJ_fRPy_eKZk_wKy_XLTdCOfYWZFK-GO2E2ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:WyrlZwNGLVektwDccYoi5UFRC-UPLXJ-G3FdTeaq4f6glrHRfSCQzw>
    <xmx:WyrlZ59FNSyQO8kbOzwmII_7Iyt-oktpoliF9HwWX2BrpJ0MUb4bdg>
    <xmx:WyrlZwUbtkA0hhx8BR3HUmH_mwy00x7oY-UF6i-e_rJrNJob9vRTPg>
    <xmx:WyrlZ6eQCdtIHmdzykan4lS4UZaeoQjsUmIfS6ik7OjhK6JvFJ_lxA>
    <xmx:WyrlZ8lHzGpg-oFD3nIM6MjCnaYgh2M60PPKc7kSzexQJM4D26jq9AAd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cbf7bc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:06 +0100
Subject: [PATCH v3 08/20] meson: stop requiring Perl when tests are enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-8-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The Perl interpreter used to be a strict dependency for running our test
suite. This requirement is explicit in the Meson build system, where we
require Perl to be present unless tests have been disabled.

With the preceding commits we have loosened this restriction so that it
is now possible to run tests when Perl is unavailable. Loosen the above
requirement accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..d6e27b236fa 100644
--- a/meson.build
+++ b/meson.build
@@ -772,7 +772,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
+if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
   perl_required = true
 endif
 

-- 
2.49.0.472.ge94155a9ec.dirty

