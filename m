Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE83596E9
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900283; cv=none; b=p4TKPb/Ui2LZITo0UbZu/b+Ctf8do4bBsbDCc784K8Vk7LgcCDIA2p0tn4nQkZHCE8hh0nb0tIjSsldgFOgZ7qWrfVRQ1L5HIiNn2aESfOyw8PwuNkhL0LUpq/poGGXWyJQCDWeO3zzqXRkAl3VG1jfX6tHuN5Z9DGjpTQi05uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900283; c=relaxed/simple;
	bh=aUjYOd21URqoA7Llg2PwipTP+0gal75uTqtFtJruCK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X4QgtQTJGItKdf8jaBfYdZXR3YsGtOPbmNk68j0xZEMIwjSthoSvSbu7J0AiIPlGTi2Otnj5zaRxaUnWT/xBDngIq9ndv6pMGpH6+D2UxZy/anH6r/BPrW6KNeNpuR4EqvdmV3H9LrrI75wewhorWbJDy3fq+hfOxlCiKulZivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FH8Zrw85; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOnh4iaK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FH8Zrw85";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOnh4iaK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D7E4EC0645
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 07:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1770900280; x=1770986680; bh=U/Y/t8Lx8k
	wb0twHMSMXfS62aJiCQG77LC8iyK6Sem8=; b=FH8Zrw85dyY2fEWYbS9zD7vLv2
	oE0LL/QgW9e9eMgym2G1JDBoCEBStb7R5FQFtfGRtpqeI84qhwD/azsZ6norZq57
	gw14G5teG2m9fVXkPuywvPUIaHb0P9i0y8qbv/lNM3EC1+GbaDIUKh5e8OwAgFsK
	bnWwWy8tAig+9mWt9p+jxfyfz6T4qDFmcx1hjZ6TtqUBRnO4OkhFEsX61vowr7/7
	h6k+nxQ/2nk6mEUGai/+hNikFFXH94ROcXA0ScOhE/hk97OJWbJIJq0rGz80IGK2
	P/LFOznzUs3n4HGgJI7RGilFA7iDOsfY9K1izvONrs623ICvWwb14Sq/vGng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770900280; x=1770986680; bh=U/Y/t8Lx8kwb0twHMSMXfS62aJiC
	QG77LC8iyK6Sem8=; b=LOnh4iaKNj74wvFpSC+ijEcBeTV1V9MTWAC2Cn33jNqf
	MGC7eHdULbdIfz600YkjyLPCz+Y9FkJUdTKv3o12VqWz80pvccMP3wHyUjv06mfD
	GkBtn41BsSScY5Ss9AzDUJuhcpjp26+2tdxU+cBhCO/+SqOl4VpLMhtII0hBUaVe
	t0LyF5yMne/HIB7D3nUp1FAzK57dsgQbCoXP5S+LhMAYgX0PVyKxYNHFY3wxU1Jv
	8dtQAU+vp/MPHC8YqSWjyX5FNA+vRR1TopnRp910kIJ+9iWWZfiIiTzJfml2SCtL
	miQPSCCk7ztKy7+zu+zB+/UmijF0af8sr4PU4xx6OQ==
X-ME-Sender: <xms:OMuNaRiiGpAbIC8sO_brSRtCmzUSR9taaAKcAOc_Rl73niNOhEr4PQ>
    <xme:OMuNac-ouC2lBfLMKV_ZEeyWtPDe7pgi9RFCCX5phFvgyaGo1mW2Ub81ZOdDFSIvV
    KnSQ-t9NXb9KrzanmBSJF-Iax2FEgZFjNhqcGWNMDBUZjytUsco>
X-ME-Received: <xmr:OMuNaWtFQPymZwKZzol8ef30fOxrvtrFSGMpsz4KTIusaJ4danLfOua8alm55wVwaONaRj7RaCcKi3aaxxH6WWVNslsVcpgnX2xJnECj9L8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:OMuNabYx1Va_WKAsXG1aAB0FzMWV6_4Sbweq4O3pLYa-ExDLKF0mHg>
    <xmx:OMuNaeqjXMxqnvMPL_mUk_aNRY1y6uoGs2r_taQcKxKEfeHVhHkeHg>
    <xmx:OMuNaY_zGAiA3TUbDF7Ywne4PMq-QDmm5yQohyjvUCvRETCWZ5-Iog>
    <xmx:OMuNaV83RXauAWckrhAuTG5HFpHasZTa3_Akq65fyRJipCSB2L4jRw>
    <xmx:OMuNaVmXAHWi8XfKnEfkzIRdmsWOtj70zRI34w5a0SH9ghm_RnKUzuhx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3fa8e3b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 12:44:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] builtin/history: some smaller UI improvements
Date: Thu, 12 Feb 2026 13:44:33 +0100
Message-Id: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHLjWkC/x2MOQqAQAwAvyKpDazxQPyKWHhEDcIqiYoi/t3FY
 oopZh4wVmGDKnpA+RST1QdJ4gj6ufUTowzBgRwVjhLCLsNtMZzF9lVvHAJ6eKSuzBznqWu5gBB
 vyqNc/7hu3vcDsD+aTmgAAAA=
X-Change-ID: 20260212-b4-pks-history-dry-run-2b840e530ae6
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

this patch series contains a small set of UI improvements for
git-history(1):

  - The first two commits adapt git-history(1) so that it performs
    verifications before asking the user for input.

  - The last two commits rework the "--ref-action=" option to instead be
    split up into "--dry-run" and "--update-refs=" so that the option is
    less focussed on technical implementation details.

I decided to send this patch series as a small incremental step before
sending `git history split`, also because that series conflicts with
aa/add-p-no-auto-advance.

Thanks!

Patrick

---
Patrick Steinhardt (4):
      builtin/history: perform revwalk checks before asking for user input
      builtin/history: check for merges before asking for user input
      builtin/history: replace "--ref-action=print" with "--dry-run"
      builtin/history: rename "--ref-action=" to "--update-refs="

 Documentation/git-history.adoc |  12 +-
 builtin/history.c              | 255 ++++++++++++++++++++++++++---------------
 t/t3451-history-reword.sh      |  20 +++-
 3 files changed, 181 insertions(+), 106 deletions(-)


---
base-commit: 6fcee4785280a08e7f271bd015a4dc33753e2886
change-id: 20260212-b4-pks-history-dry-run-2b840e530ae6

