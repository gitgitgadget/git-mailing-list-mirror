Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8227E7EB
	for <git@vger.kernel.org>; Sat,  3 May 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299611; cv=none; b=Attu3upubJ1rJk8PTRpCyx/3+rjtu+uBvN48YPHyWybv/1zJ4RBfohzf3DvMT0BAmjzn6rcFPyY6mwOL10ph1udICTYrwUv5TvCb2guaK48JlrTszMQPKEbxp6qFlsGkpYVB29XmIKJMwqf/Gj00QgtuENT0VUMF8TYztzHEXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299611; c=relaxed/simple;
	bh=2HZjCf13aBM8KOedfJsTF6t45dQcxt64M13LQoxelow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZRVsi4F4w7rdQqodVlsI8wfqEiQkAviZBi1axabbs1/yiYBxRFrk3x3N1BCp5RlCH5aHnUGmQTgqFaiOFmb1rhZnkgwuXGkxncJVHaKZm9bTMxrur4+Bz4mhNSPxmZImvix2gRVVkN7HcapRRZyLcBwTM7AQRs6xgmz0LFz88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kSCVgCg8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imVTvVDv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kSCVgCg8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imVTvVDv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38197114013B;
	Sat,  3 May 2025 15:13:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 03 May 2025 15:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1746299608; x=1746386008; bh=U+
	rfQZmVpK7stccaaBZGk9J4dYuiCpoTt4kndqknCgk=; b=kSCVgCg88CkjYnAZNo
	fCkpyAbrg9dSEB0Zb/HiPXQYnj6zUZWqCfP4cABDXjh+0D6/YJPemDQtLQ2KVn03
	J6xkkr1+kphgio7YQcLAIex/H4uyEgghJpF/vB4FQBterpM4SFdljeDrqhKRgSLk
	GqrijBZt9U9KkFKYyjgPh1g4gN/6FWUrsaZa54mG84J3Sh3o5a/KAkqWLbCyTq0e
	dkfPojrmsqaPIr2+800jasmc14p4kANo63kGNEBfvPcxL5sXjEGyYSfoJqqmpgHW
	vnR58Ri9lYGGYpkIWP1ldBF3/HerkhMCv6DwBIqys7M8lsTg65zqiOqTwznowg3Y
	GkoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746299608; x=1746386008; bh=U+rfQZmVpK7stccaaBZGk9J4dYui
	CpoTt4kndqknCgk=; b=imVTvVDv0M2ywpY2Tn1yNH5hqMQCe+9qqruqA9CDmaWX
	JGDLKnKJ3ivo6VoYhFdTd2sil4taJf6a6jn0vfc3ioKVRe3/htizSGMWHKQBOcJV
	U0VHIPNTe/x44BOTqMYDVk6Wdq5dpJOAo1Cso2VvQJbMs/3DnaS4ejQIFdDPZwX1
	GW2xRV8BwjL+MTYPxKjCNQBgokRqLnCsr10IqYXQGAvnuvTfLjjExfEIiVyjw1Ax
	yDq9Hhi3811o6WeYAp4Eprpr50f3GtViAsXdHJmve0/lfyikj3TsmbARzYfxiyeW
	sxKRPyaQAhAUbpV1II5pmMV2YTUslH/CcTQc1IKw7w==
X-ME-Sender: <xms:2GoWaKOyXt_qrh9_QcruJXL6noNjt9TikG5T88XNNCjTsNKSi0TYKbE>
    <xme:2GoWaI-dCoA_7rAin2lp-XMHRpD5r0_xbl5jHjuTGKODtmPr9uB_nfMmTIraSm0U3
    0eFE2_xhJeIgj9RgA>
X-ME-Received: <xmr:2GoWaBToR0dmShLMBcuwPOGUNNi9TFPcuMZQRdhv0IDRuKL2yyc3_VsUUJe_JpZ-Z453uNflMWorr_Dii5vlgBAbGCXJtcZ3luXQpPub4so28zsREr9VYhj9Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpeehleehhfeiueehjeevfedtgfeitdeuvefhudeg
    vdehkeevvdeutdeufeefieegveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2GoWaKs0c4MjUgspNCnNtsEuefFRRxbJKLdgyz21iSmsPSHupDevwA>
    <xmx:2GoWaCfTRo2OoOH3bUhDO8UMs-8GjrqdkNRUFAtA4ZqaryfIBTzcQA>
    <xmx:2GoWaO2Nt8OlwIv4IO4gLckX2AMrCc-A-FwEBS4mgbgKYbO2vOHkKA>
    <xmx:2GoWaG_tww0_Qdah2w8kcgt1xgUfEA_0wcewdnRojq12uhZxg7Ud9g>
    <xmx:2GoWaKA9TGCmJKvReGw6UyRnRkS0AWdsq4bIGHov7YyYr6RDQsJYo96J>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 May 2025 15:13:26 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] doc: fix subheading and inline-verbatim
Date: Sat,  3 May 2025 21:13:07 +0200
Message-ID: <cover.1746299135.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.459.gf65182a99e5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I found patch 1 by accident.  Then I looked over
`Documentation/doc-diff` and made patch 2, after
finding out about it.[1]

🔗 1: https://lore.kernel.org/git/CAPig+cQoFC_2M-S0d7SLBPFvusXQC93pbk3QP2+qhsa7BJGnuQ@mail.gmail.com/

Kristoffer Haugsbakk (2):
  doc: reflog: fix `drop` subheading
  doc: branch: fix inline-verbatim

 Documentation/git-branch.adoc | 2 +-
 Documentation/git-reflog.adoc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
-- 
2.49.0.459.gf65182a99e5

