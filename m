Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBA1A7AFD
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986558; cv=none; b=iGRT+dqteJcEFeJvpVVVke4Vrp/Plaqh26OR1HSfYVjawXA31d8i3IyDDWQEjdFsGqu83hCZ0NQmftBYU9gaLPu7lSC7XaMlX6c3xON0vsYp7RVjHR/qISFVUXgnALwG9BBJqxKH7RyTXRcW4r1r43pYmrFDSgr1CTsLnrBqki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986558; c=relaxed/simple;
	bh=vwiMPzd16wRIaG5G+d2wOFTyGJ3dsLm+VVQaoyf1nEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1r63qZSOf/VPHtsQJ8ka9dOmqA6LSJ+PTHOEdy4w+zgHw/OHQiPO1kXhWdbHjqbaPtN0+olkvJm4ZcjeQPc37mo4fXgYFGlgvzeVYYQ6D3ufxzrl/ua5TTenI1mr+gAI2oeqjaj9fkTD8aJPNRgx5DxGf9ntSh+/M19AnCxvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g3GK7Msc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7GMpwE5b; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g3GK7Msc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7GMpwE5b"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 441A71140180;
	Fri, 14 Mar 2025 17:09:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 14 Mar 2025 17:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741986551; x=
	1742072951; bh=qT04BWsLMK/yoVRQhr+xNIkAyw0svhCVcYc38JD0Rzc=; b=g
	3GK7Msc/HZUXeermcVlZXbOjvpLvZjd90aHF/mz/94HEc+Q82zN4lpgmi0hSUkKf
	3sAomEZSfd1uVSgA88Iwo86j+m5r3VGs7fnlxnkAIHPM6C0vX5zp8QUvaIsTPmmR
	uoqgjGlic4b4Pn9i/xeeSnWkuVnDA1AgV5vm2qpbto7vDSvu1IkfWaHqMa4C21bc
	tOM7zVJoEi0qrYrU4ilkbsgqBWcVkweKt7z/Hcm7TsT80oahIxj1GvSoJWU+pZQy
	FOltcZYgRyG0zLqoWHnVdwp4msrCX+hNVsBCM0frj9rbBGpfx7O1r5bhLsOjEMfD
	axNrL+2NJh1fMon5dTYoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741986551; x=1742072951; bh=q
	T04BWsLMK/yoVRQhr+xNIkAyw0svhCVcYc38JD0Rzc=; b=7GMpwE5bxGBLY8xSo
	0BMeTxhavIy3U83NvN2NfCrhzu8AK0LA7hJrgzgpCI1TDsmuaotWql2MMAPVb9rz
	+9hsDyx9fyIYzGo89XooSSz11b36ftADEejCq3F5S9AHzpmU3gCpCvRst+RCLp8w
	w8kenDVH0StpGTvq3qJX0Mb1mEJTwNeOts+RvFrky+KAkiDb2ATILB6CfWbXLxfw
	46KUyxm4Q/9eiKS7L4YkVcNe45xSnJZfRHMIVkmE2BEwlwfKzdvHzCbWf6ckAjOJ
	uiuhDrmaO/+5ncZoi2i+1fKxU/jgMFK7xt+fk0kC6nKMpVr3qy6IirfUnoaYEGPq
	T4lpA==
X-ME-Sender: <xms:9prUZ_Z3T1oohoZ0g459EYoB7HMHZ18TldsXKdiPWvsMnISujO1AZw>
    <xme:9prUZ-YzWwwfy3T3C2pQGsnOYTlDrwCnYO1WVOq8bGe49RvVvBvERarN4_tAR1fst
    f1gMFKyoa2rdbfbMw>
X-ME-Received: <xmr:9prUZx8V3nZJE9qqPCiWbi4OMJWO_Fp0cyW4M3UIErPVRGLcZOLIholcJxKGoZfqDeQcY3mfHKChj5_oi8FX5y2mAqun1y6eEtcruoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepudetgfeuveeggfeggeefvedutdeukeff
    tefhudeufeetleegheeuffdvheetieeunecuffhomhgrihhnpehmrghkrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9prUZ1pEAMMZYxTKHFTjPNG8BJPZoDgYlXw70fFp8jWmFqpxDpmx8Q>
    <xmx:9prUZ6q6wY_oosxD4Ad7cnvT60-lQrBybTukhjyYbVpTtYJ2mryPUQ>
    <xmx:9prUZ7TSz0QKNwSzTrFZEdW3BHLJFbLyDLuQ0nFbDzguWa1TeW4XeA>
    <xmx:9prUZyoAWMwWIfssfoaeGuXiyIzCKFAC_haTScZkDOYy560cRpLoTA>
    <xmx:95rUZzmqdXAtMvW49jpqWWP2k3-Gcueg2hrlwpV7E8nTMt-1ZG2RXlSv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 17:09:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] -Wunreachable-code
Date: Fri, 14 Mar 2025 14:09:06 -0700
Message-ID: <20250314210909.3776678-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-188-g35fcca2323
In-Reply-To: <20250307225444.GA42758@coredump.intra.peff.net>
References: <20250307225444.GA42758@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So here is a recap.  The first one has meson.build change from
Patrick squashed in, the second "errno" based one was what made
me write the last one, and is kept as-is.  The third one introduces
NOT_A_CONST() marking to an expression to tell the compiler not to
be overly aggressive to optimize it out.

Jeff King (2):
  config.mak.dev: enable -Wunreachable-code
  run-command: use errno to check for sigfillset() error

Junio C Hamano (1):
  git-compat-util: add NOT_A_CONST macro and use it in atfork_prepare()

 Makefile          | 1 +
 config.mak.dev    | 1 +
 git-compat-util.h | 9 +++++++++
 meson.build       | 2 ++
 run-command.c     | 8 +++++++-
 5 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.49.0-188-g35fcca2323

