Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6D36683B
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612628; cv=none; b=iN3sKjtpwXMxgFmxGX5Fo2u4IUf6uNgtLq6yO9epGrR2Ra7BdqSRVYb5RJ7rmtqjsCJQWCDy/0xk/72ypxjigBGNsLzUr1wZcTYvD3UWnf1VrvATQi1aQM+C5ExAlqPp61/SVaaAiVVT3x86YP0Qiqyu+GklkJIBFSv9p7rncD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612628; c=relaxed/simple;
	bh=Dx1FZQ8DcBMyHKEpxiAP7uMBzOmLwvKFvpgQrtL3Em8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OuEBm7d39Jkh+CrjDq/F1CR3oupOioNryxLMS8wkK1CmgImLYyEa88cBiHiypvE8DruzQe3LTk8CTnvAm1swAT7lkp8OPqN962GNz0McMbeC9JXutwJHcdQBKN4ZeqlggekAa0HXDuPgafFzSY1nY5CDs8fHlHaVQ8JvYC/lQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cQud7K+y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wmmKmyQN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cQud7K+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wmmKmyQN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D3935EC0574
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 03:23:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 03:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1772612625; x=1772699025; bh=dCj8LwboIj
	xxRS7OmTusAZ6VEB7YoJSJNmjQE9xf+uo=; b=cQud7K+ysQN5mMipr12S6NZ748
	MmsithEd1JrOstxvJLeeeChGLcTTvdSAMC4oDpAhOUll4aXWktzc5MXJzJA3i8Pp
	oLe36M6nya/br+8gLbO0tppycu4aU1cIADlhQpM/v35XmmYJa+SshmNzmlcUZLPp
	eZRB2TAEQe0WndcB9JwGwb95MfYktwUtvXgIJOezGvebstRYLt3pnHpLyzvqWx+D
	kKc6nvidtN7ssBVWRphAab5b/tOPzwEVNarRjskAOj6JETgZjSdE0z3OjJoh4GlW
	sPHK2/07+BMwQ4dD1O3EyfX3K2rJ7sdRL9XtEqvsWmdEiMEim8svaTEZTlRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772612625; x=1772699025; bh=dCj8LwboIjxxRS7OmTusAZ6VEB7Y
	oJSJNmjQE9xf+uo=; b=wmmKmyQNU9Ve2VXZ7eCQneAVBbcEoRXWXyp+kcngBffM
	DS3q5blNt/2+VWKdl/w7me5wsOyJAa8ubfIFVmZQ7bWF8KenAHHzKveC1U1s3GfA
	m06mGSjhGTHrqH+FVJVjY4IsoOYu80r1GsHKftwub1oLO+KmN9pdjFC0AZF9wBlC
	+YMa6WHyup1rE65zWEdAvnQXqfC/qhXWG6MwQB/p8gF+ffDOatuDJDnXO3qmFnld
	cfIim3xPntRg+XWKwIMaaQxH7dvVQX37A2BMR/9iZvvfrAW3Rq7qhUgBAH6yS3Z0
	jr75bfH0yKG1TvwZffcbJKbGg7Uic8fRRFbFPNp+yw==
X-ME-Sender: <xms:EeynaWiwEeK6VyQtIygxHZoIngaxZ1o9savvqRUvZy-2FNmhNAt-ww>
    <xme:Eeynad-ghZwTTX6inmbk91UOPJKUb3qLNVl7XjaPdOGFJpS4Nzes5ZKYal2atubMW
    OeKxV_kRK00QlpMB3kW5XrPLJBTcmOgqsNnxYaTThp8302OjEwEgA>
X-ME-Received: <xmr:EeynaTtEJN_Jaw96Vbze77y8DQJMPkpNxZAaAJ30kFeoSnb6Bk9zXsjYJS9dbE_lBe0yPs_fDoKmJ7SCKNmRGcdc7UDurM7IFlJmuWEjm63aWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:EeynaUaQlxD6G-hEBs2UvshWY1ttkHnVb8staBx0-M5hCgNXyTywLA>
    <xmx:EeynaTpH1JHFX5-RjNryEzGl0aY6Lbf5CVWLfBdIo3isPtMAhF-i6w>
    <xmx:EeynaZ9cg4aQQEzRkYxfkEITM2OQrgO7c1Lsq-xWnFBMCVwF_S9uOw>
    <xmx:EeynaS9TuJ4UtIxhwgMrfNskz33RBzZwcdTpIJTfWSb7ZagW-28RMw>
    <xmx:EeynaTh9SGclQ_MYBBKbLbfme7G_HNHnZUFqmK5MA9xEoxdbDB5uQ2Ow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Mar 2026 03:23:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cad3e1d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Mar 2026 08:23:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC 0/2] Makefile: deprecate autoconf build infrastructure
Date: Wed, 04 Mar 2026 09:22:59 +0100
Message-Id: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPrp2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMj3YLsYt3E0pL85Py8NN2U1IKi1OTEEqAmXRMzU/Mks7RkC+PERCW
 gdqBMWmYF2OhopSA3Z6XY2loAV+2y9W8AAAA=
X-Change-ID: 20260302-pks-autoconf-deprecation-4657b6fc83aa
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

roundabout 1.5 years ago we had a long discussion that eventually led to
a rough consensus that we'd rather want to get rid of our autoconf build
infrastucture. This eventually led to the introduction of Meson to cover
this use case, which has stabilized for quite a while by now.

This patch series thus starts the deprecation period of the autoconf
build infrastructure. Target for removal is Git 2.55 for now, but I'm
very open for discussions here. I also assume that depending on feedback
from packagers we may need to adapt the timeline.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      INSTALL: recommend Meson instead of autoconf
      Makefile: deprecate autoconf build infrastructure

 INSTALL      | 11 +++++------
 configure.ac | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 6 deletions(-)


---
base-commit: 2cc71917514657b93014134350864f4849edfc83
change-id: 20260302-pks-autoconf-deprecation-4657b6fc83aa

