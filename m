Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E424A064
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451285; cv=none; b=l7Yq6PjEiX6BmLfbYxYH4JXXsIcUTfbTcjfyo88XxfQRtiXAH9Vv0FWZKkj9ahFPaUtrjjX082i4V7Qx9uWzi0u7u33JSY/K7x7O+BdMNR51bhzGhobDnebvlgpdC9Ke0e3o3eNmOP4lGYi5keur6wQRUVHtTO9jk7FCdPxhBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451285; c=relaxed/simple;
	bh=FL1+59T/FaRsIZSbd70bRbo/MJyQ9SV7c6j5WnOhNWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pr+88nyC2ZNNVzjitaqVTa8CAxGLDpDuvEYn7KVAwdxir2rylrpbk31mB8zA/FYC30Ljs/OQm5CgnF07SnMTDSAYXUnFNZ3mMXNbzgV3o6MJLDy1h38RKbTReSuQvh+nhEO/j927f9ln0sBVzjZ+37JWyZ7v1UnDb31KrFDsEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FXT8IsN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMGFZBcU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FXT8IsN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMGFZBcU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 131091400338;
	Wed,  2 Jul 2025 06:14:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 02 Jul 2025 06:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1751451282; x=1751537682; bh=yuX9l41aYq
	IT1I1z1JBoo5/QU6HAehhIotH7oRPd+/w=; b=FXT8IsN5CwsvqowT2eV2lXnmlU
	qtSIQxm36Da04l7Q2ETjZKGgO9zmgYRTN/dS1uYnd9Z4WySgRQcIqQqhV/Io9pxv
	bXmkZjSqlyfoUdNpgX8Eh9svzcft6HqCFdWUnW/KOJiiWISkqoO9rGVrKCpwbZ/q
	TipdWpLbdAnxawCsbfxvp9im9FLpZTBbGDgVz2AGy6owI8WHMlJMybV3NpwI+z+o
	eb00vcUZt7WfyMSRWVCqh5OVqQt08IawffGK0Qz1C2KL9eG8k5Vsf0gfAh+UgGWQ
	xbd44iiuQtXKtxZMzpQspfbeQvXstO9RNPy2mtvt48MlO2C25REjwjXseavw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751451282; x=1751537682; bh=yuX9l41aYqIT1I1z1JBoo5/QU6HA
	ehhIotH7oRPd+/w=; b=TMGFZBcUljit4M+sy//5wjHafxAuou56913qSm4fgB7p
	wWKn0h95QwfCk8Qd3UniF6OLxVdwO118nydQ6dpshVrdGVLeI6RrS1D4Tvd/WSzT
	B4HZpqFQOUod69b8EBCSUU9/h4iee/GCYc88xeoaJarFYTwl1F/H35+0G199ZrU3
	/H0KdKerj0AOPyxd5AcaJC4K2fb6YP9+hkPfV5NJ6Ei8x1SBXNd3yWz3E0fiaBRo
	hyM8eNyo3YzN/WAjG4yjS4r1JzGrTSBJcx/4ZH6D7zQSXvkoSW2gkBfVolaVOxKP
	m4tDNeQi0Ccqx5xlLjXWbgSQBaMaD46rdWBnStlGjw==
X-ME-Sender: <xms:kQZlaB5nyxnNLVT1JbZzM4cnJWKlp3ukOA2WFW68dUIpC2I5__7u-Q>
    <xme:kQZlaO733RWV2OMqPTMmMcCnGwhgDFqRCEj1o2cC75LhLpWy4n20tXN6Wgdf5jIPa
    CJwyF67WHh5fG__kg>
X-ME-Received: <xmr:kQZlaIe8CqcVRuxAWacmsp3bKuPz52M80CEa_NjCN7UYHTU9bbaOoOGk5sTTEy3GNXgwtbqWTY2ND-bIGwdvgOWQxfv_2d_SnxWqDfNelw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    eugeektdetieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    eprhihvghnuhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggvrhht
    hhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kQZlaKL7SuiHf5MlfsumMbXV6bbh8EqDyph2I0pPwNP2GtTJKSd4qA>
    <xmx:kQZlaFJ0nPcVh_HzTWLbgVe_p0-5feT-iXSToWgiBL-H9tBZgFWC9A>
    <xmx:kQZlaDzPndaz9e5UHOybPTWNjv0XookagVt0pFBFRL5CS0ComV8KMA>
    <xmx:kQZlaBK2Tq_cJi9WHKa2F6-tI1UvQXIuJZ05hikMHAw3dce4PEpc6A>
    <xmx:kgZlaDDvRWMSJ28wvy0A_KtEuadDNM0-xCDDWccPbQzN4zV5V99l1pap>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 06:14:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbb47c5d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 10:14:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] Add reftable by default as a breaking change
Date: Wed, 02 Jul 2025 12:14:20 +0200
Message-Id: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0GZWgC/x3MQQqDMBBA0avIrB1IE6zgVYqLSTKpQ0KUREtBv
 HtTlx8e/4TKRbjC1J1Q+CNV1tzi0XfgFspvRvGtQSs9qFFp3GLFwmEnmxg9BzrSjpZc5Ozx6Yw
 KxvwtQVtsTcr33r/m6/oBFdFfpW4AAAA=
X-Change-ID: 20250702-pks-reftable-default-backend-6c30f330250a
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

the recent thread at [1] motivated me to hack together this tiny patch
series that paves our path towards making the reftable backend the
default backend. It does two things:

  - It announces the breaking change for Git 3.0.

  - It makes it the default now already when "feature.experimental" is
    enabled.

The first item is subject to ecosystem support, most notably in
libraries like Gitoxide, libgit2 and JGit. The second item is intended
to extend the user base to power users so that we get more test exposure
out in the wild before we make it the default in Git 3.0.

Thanks!

Patrick

[1]: <xmqqtt3vkhwk.fsf@gitster.g>

---
Patrick Steinhardt (2):
      BreakingChanges: announce switch to "reftable" format
      setup: use "reftable" format when experimental features are enabled

 Documentation/BreakingChanges.adoc | 39 +++++++++++++++++++++++++++++
 Documentation/config/feature.adoc  |  6 +++++
 setup.c                            | 18 ++++++++++++++
 t/t0001-init.sh                    | 50 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)


---
base-commit: 83014dc05f6fc9275c0a02886cb428805abaf9e5
change-id: 20250702-pks-reftable-default-backend-6c30f330250a

