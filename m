Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A801DC05F
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162223; cv=none; b=lvlFTl9FXc790LC8ddXOHCVTklX/IjjiEZAl3Esksqc3hw1jgkrBwmv5BRA/jm6wygSF2RnAUYtQVkz7pZUOMogoX1UQT6gviDt1WjHGGe098/EuMG/+tC3eXfwpF+ZmtgXPOjS1fYI5xtlaXbdKfKAiuc/lBaJ3wKkwH1xrGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162223; c=relaxed/simple;
	bh=Xl3iX0VJ/u7NFlmmljA+bD8ey5H/8HtM3oLC5UJ5MU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWx8jvPdqY9xOHWe25UHBQArlKrkPsbXVVQhBQ1P9r5x0pj9meGAlN6ofVl7M6gGja9vuixOJ7azvmYf2U9Em/taFwkkwGf93i8bo/1Cp+WqWibFAUJC5MdiEUSs+iJ23WYNlVozAqZtZjRbf00wgMZg3WbpIoaj9z8goQxKWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nB4hrMVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lv9TnwM0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nB4hrMVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lv9TnwM0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3055D138087C;
	Mon,  6 Jan 2025 06:16:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jan 2025 06:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162218;
	 x=1736248618; bh=ZGukKVurnzK+MilwZ7Q/qLxdA3ZGB6RCeV86FtNkMNk=; b=
	nB4hrMVHvgm/4zPDbLPaXcE+iO8vfJNSsNZWWYlswG+iV02aMUlh+IU8uVKAydoG
	CAExYBgUbYmKXYOaWCQcVbOdolR/iskb/tX6Eea/HsTnVFhlFOXB0F7OPpmi3Vwp
	vTFcU28PbBDFrNCinXdXXcQubwwUyZhGzhXrbgguJ18nKuAAgMQA7CszjiLeXPXZ
	quW7n20wObNksRWlYPQ86F7wm6ieXqNGbLE5+v4rpbM6yrYW1371n3wVu9A7vsX5
	hUIksCijW1ViwnOCOiKOretD0cizDsn7KzglXbRN8c8AHezQGj10NQfXOxpVqA3M
	xl3DGfTLNJFN1DAlGwduOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162218; x=
	1736248618; bh=ZGukKVurnzK+MilwZ7Q/qLxdA3ZGB6RCeV86FtNkMNk=; b=l
	v9TnwM0XDbGlaeC5/z0Q7gCtkGZO0Lw+mvegqisJ2DVbjLlQ6PD+8VHzeqd3QvRt
	WMFIpzkHC3F2dVV3pmXDNlWQi+2fdqzzyEp1jzCnkJig0ZqpM6RKMEuC277GUjsk
	HorjsDHM6Evi0cLS/0uaQRJJPKElGUkjQAwrkWuj5hRDrbKNjg34s9gVGMLv3+2L
	k9MRMNwzNWl1VuPNu9u0NZxe3j8Y3hSTnBD9tTLUs+AWL4i0H7DicbT7755YFlBw
	PUTXtvDJL982A9X42ose0Mh1SjnlA6r422S6I5fA51o/SdEYhBbiX2Kklf9eiwmf
	S7HmMPwwyloXvo0ps1f1Q==
X-ME-Sender: <xms:qrt7Z5otJKsWb61kCpT4KGLFhP1xDm0m4KVZDZ7Y1P7GNgVXORoCww>
    <xme:qrt7Z7riTT1miqydqo2N0kkONbAdr7u4q7pZ5PnkFHBwdJrPY-2j7tPFUazQf6g8M
    yWAoIXdXRrSc_XYJA>
X-ME-Received: <xmr:qrt7Z2P9tFp_7c-L4NszGNJe7ekEDmk-TaCdGV1ODEDOPWLurmbdb6AsvmYvnhlVXdjhl8WUqullanCM7byWu31g8jtUkSvs_fAbMb-qktimEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qrt7Z05B3vAK-_eUVkCm3Y2CBQ9WT7FLJOMBQQD2gHqeRU68Hvusgg>
    <xmx:qrt7Z46meVHJwsZg8rDj8fCxS2npMava-NXT61rlKd3agSnCXlAZIQ>
    <xmx:qrt7Z8gaPiyfVY_i-xWWiMeixPN_C7HZdqAl4e_zRe7A9AUrcVuNgA>
    <xmx:qrt7Z66ofjXIS-cGyPpVEzC1ywBJhfebibuvRmUQmeeBU-PEBJu4UQ>
    <xmx:qrt7Z2kRNEOhVAkkQZ5AFUq83vn0phuQh1rz6KRU8vaoQIgCpIU0k9se>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb49a541 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:55 +0100
Subject: [PATCH v2 06/10] gitlab-ci: remove the "linux-old" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-6-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
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

