Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674E1EF09E
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253056; cv=none; b=C1U5h+3ZeJgHcBMEgqmcoaDEvx+vFQrHMduoiCd4ag8sVCxcrfJSiyrLgDf1xFVN5C3bLNg+b8lx/m9hOCzIS6f61bQkOz0D10dnnA4oBO70jdq2uwM3ZenGWxLbbrGIE5+AbNBabObMy3PgUzl2RI0EZs7v+ctlidkeKvz4sWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253056; c=relaxed/simple;
	bh=Xl3iX0VJ/u7NFlmmljA+bD8ey5H/8HtM3oLC5UJ5MU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Myrq2xGZDPXLSAYgHgkAl2sirH1CcAH5saWC5jQIZHvphQrYMy9rgL3AJidvBXY33U/ggr4XlGEZIBTgdIj1F5Ftxb8emvN7OJHydM4c/DGCHeO0EXIweFaUe0YlFfM8R+7vkF72lPpGwTc/t36A889Vx9ylklErONrFXZ5hIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I4o4xs0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcK3IMNZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I4o4xs0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcK3IMNZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C48851140172;
	Tue,  7 Jan 2025 07:30:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 07:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253051;
	 x=1736339451; bh=ZGukKVurnzK+MilwZ7Q/qLxdA3ZGB6RCeV86FtNkMNk=; b=
	I4o4xs0lKvzqj3zvSi8DKrItJIMp7FDSjd4tIIXddZmxrsPhUX5Z7Hpuw/VuaMp3
	Q3Yj38gLOlzdACdK27+UuAU43rmFEVmj97g7gXhyYr9d4TyLy1OE8VifCozSJg9S
	4GT8+aTWye3m3GjrmVmmw1FIZLOZvfmoCRWKZOjsPrb6KDTkqyhF2lZAtY4GAy5k
	7QDtYWE+qU8TchRZk1BE+Kl6sPse2+WVDlCVFDiNB3h945reehTSI+HUalkcDxzA
	CPdmq8/jLXS4EjpSIZqYis0wswbw/gQkAtrJ5BNgJmmFFaMUB42V07EZjG2e3dVq
	XNuXeGmJ1S4XMF4c/BYnnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253051; x=
	1736339451; bh=ZGukKVurnzK+MilwZ7Q/qLxdA3ZGB6RCeV86FtNkMNk=; b=Z
	cK3IMNZhxTzxWtBMTaH2Lxw27BVLxSdHfce25kyV/b9ZTyLlaYUyaVKsWocogYkw
	BLuDH1C2OkcesAWkVPJWYm/P2z9DEEWX3ObxyCD1ir5WZvLknmAtwtXOg/wJ8KnO
	uTjeViPiXOSCUEDegjPOwG4O1hooJ8rpnKQhACmGfhYhaR9693n3ou72dc82FOUV
	rQBOt9LpSezEBpdBimkHV0w21FhZwWz5SBgPpnHevbVWdG79xWTPzdGMyvNoK3P0
	LS2O3lX783VQP5IjNog9KH+1Y+0fWUiHkY+P7ni71+dd30y/ofLBMSoLFW5NO98q
	ukDVMBKc3gEJPqllz7BfQ==
X-ME-Sender: <xms:ex59Z8lb3jd4z7op7gM3VM-vnUaEhW4ioKcaMzIUFmf7FrxDfazs8g>
    <xme:ex59Z73GZcNtCxGNYN3uzM0NMRdhqUKEpuZ9YjoyICFMlXJIauLIqw8jRahmMJkGH
    ITDR1ks5m17GFAgFg>
X-ME-Received: <xmr:ex59Z6rEf7Yq8sLer13R02NADCK_e8wEUP_eS0KGFpbaZWHAxn_De3HR_0dIBpwUB1kx-4rg3JSwMc7XPvJYedG-4clankJlbExkUzNU0xzwdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:ex59Z4nksnwrNrY7zlRk5o_uBwMceRsU-R-csB0izlCWwmETSRqG0w>
    <xmx:ex59Z60oDoqtR35Wl8O4tA9cwWkREg9hE4RGmH6MDOrjJg6xeNqMrg>
    <xmx:ex59Z_tb9YbRjmMMiyyrEc4khJWGujIyj8rhCNgSR5BDrpEKaEgy6A>
    <xmx:ex59Z2U9Hc9pz3KlblWoS7Pb8EV-G5wxXbKeHv1RKudCNjGLxNvEpA>
    <xmx:ex59Z9QzccuZWK0o0M7XGwiATshT5Zl9rdXd8X8VsCtDu_CMfOIK2GD_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 10fa4dc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:48 +0100
Subject: [PATCH v3 06/10] gitlab-ci: remove the "linux-old" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-6-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

The "linux-old" job was historically testing against the oldest
supported LTS release of Ubuntu. But with c85bcb5de1 (gitlab-ci: switch
from Ubuntu 16.04 to 20.04, 2024-10-31) it has been converted to test
against Ubuntu 20.04, which already gets exercised in a couple of other
CI jobs. It's thus not adding any significant test coverage.

Drop the job.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9254e01583306e67dc12b6b9e0015183e1108655..00bc727865031620752771af4a9030c7de1b73df 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -36,9 +36,6 @@ test:linux:
       fi
   parallel:
     matrix:
-      - jobname: linux-old
-        image: ubuntu:20.04
-        CC: gcc
       - jobname: linux-sha256
         image: ubuntu:latest
         CC: clang

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

