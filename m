Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4ED139B
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254272; cv=none; b=CkpiklSrEzUsv9WDF9PfA3UPE1N0pNPqVqZ3s2odv7JRjmb5nE64gt49KQdoe0t3VG1fdCFwtXymk50yI3c1WCoXN6aZiBFmbjPCiYy+3WbHDNJbT6K0P4ATzokz6kFO2fAUq0CJFFtEVYetcObkm33aQd6HZw7HouXtMjFxxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254272; c=relaxed/simple;
	bh=XAyuCdvSy46ahZi8t0Ai+E3k6ePWsd7qS5O8aNlLx6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XlEP53BboVI34/ByYaQCUx6i/E7Ujnw76tkfdjpuzgeAA2+MaFObaz4MP/FzBFawr4AntDsv9gFRP8TKVP9xslQNjDCgx5LoZgzSXQ6aePliu68zNLolp6hfO5pVu6r7YUMWsLqy97Qn3JOkOuxEFLG2sig07dtibmO+iSXDMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K2njVwll; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c6wqy715; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K2njVwll";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c6wqy715"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3FCC114010A
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 11:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1738254269; x=1738340669; bh=3/NXgZl4Ht
	3SOKlE9IfG7Fh47snc3PazjWuNGOFiyTw=; b=K2njVwllOU9m34I83RX98eEDGr
	zx2cpy9iL+vN1L8caqza0+LCNuxFV7fZv84scf/KcJjqAF+dBVhaT2CUhRLKKnjR
	RZ5WL86i/K3tVJabkL0l23fbBYW7nlDerjV9z3n5sWO5m1r26JesfDJR/oWgpbIr
	9/KLrV7DhB31gJxhOrjRb8sBQX1uFfYlnCSjFzGl2PAs64GCcC3hriEnxyZ7jeTC
	8vs0/Jqt04+IjN1hvx6z8LfBD5K/rt25SeQ60EXnEcj7BTqJwhiPzry2pm3SBo1U
	n0AaV8ASJlP3Lp1UzO0Ob6jYzOxtxPFrZjqmqXiTNdnPb4XzmAjB/bVwgzSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1738254269; x=1738340669; bh=3/NXgZl4Ht3SOKlE9IfG7Fh47snc
	3PazjWuNGOFiyTw=; b=c6wqy715YMUWzpjt3AGAOsmYiXu8a4HHCLV8UPrNeqWO
	AtpSLm/H5aK3Fh2oJLbM/j70JayEogt/vsniy0MfOpB1d9iQLVuYXdUtaexxXUR8
	NL8ju3+KKa9+SwWbcirkQTXFSOuC3u4kj6y7T8atj5mCOaTXWgMrt43sR0s9Co2D
	4IplSZ4REkCz634046TWzFeTNwInaoiqop3bNuhf+FiivqqwdFuvCaXoC2kIwh8F
	5q/iLLbEiICHrSoaesTCyEhmPWL+lcIQjG0pPsbF+dB+nhZrPrJ+aGEN73nDz+dP
	tvxUB4NSFxdHsoarZOtDzLnmRq8lQ/GtiCP09J0IqA==
X-ME-Sender: <xms:vaebZ7Od0ZX457Ipd5D9MLiA67hI2AeJyP8knpDGpTS7HE-k6-DwkA>
    <xme:vaebZ18T6QBV41r14H_uHeOqgzFPb5vtBqlCyOKw-CnalgYjhieVYeltrg9XZYxm0
    USuV-seqFyPj3iRLg>
X-ME-Received: <xmr:vaebZ6TxmP8APf-YDMRkLpobDRnso34HsvoKPhE7Hwele5Z2Rq5C0Iy3jCliO93HdA3H48ydu0sM6y3BMGom2fe4MS-pPrz0Zad0R7PnSgGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vaebZ_umS30FLT67b3JYko8OYyHJUevao0cpRAOveW3wxNooYeMkTw>
    <xmx:vaebZzdf4yabCKZB5pXG_qSb3Tr6Ow7bClq5fKmA4zf5V1ssY6x4SQ>
    <xmx:vaebZ72Q9c9GySrqmDmZSwMRP-sghUy9aWVO07n-lmNvXtGUyV450Q>
    <xmx:vaebZ___cfLNUejdqn0DSMo-X9DvP6KHBLNoEJ0IMFKRtmYkfl4CRQ>
    <xmx:vaebZ7F2FEbAOWq3xSNJCl7q15LOTMG4Vkb-DaG1EWjssOv5nn3F1O9B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af41b067 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 30 Jan 2025 16:24:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] setup: fix reinit of repos with different formats
Date: Thu, 30 Jan 2025 17:24:16 +0100
Message-Id: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCnm2cC/x3NQQqDMBCF4avIrB1IYhTaqxQXsU7qUE0kiVII3
 t2hy48f3quQKTFleDYVEp2cOQaBbht4Ly58CHkWg1GmV7pTOFncvxkTceCCM3l3rEXo0ce0uYK
 PwfVktLLWaJCZXRr//hev8bpu1JV8S3IAAAA=
X-Change-ID: 20250130-b4-pks-reinit-default-ref-format-96a5e2104421
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this issue with the reinitialization of the ref format was recently
discovered in our CI systems at GitLab, where caches contained repos
with one ref format but we tried to reinit them with a different ref
format. But turns out that the same issue also exists for the object
format, so this patch series fixes both issues.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      t0001: remove duplicate test
      setup: fix reinit of repos with incompatible GIT_DEFAULT_REF_FORMAT
      setup: fix reinit of repos with incompatible GIT_DEFAULT_HASH

 setup.c         |  8 ++++++--
 t/t0001-init.sh | 30 +++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 11 deletions(-)


---
base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
change-id: 20250130-b4-pks-reinit-default-ref-format-96a5e2104421

