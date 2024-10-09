Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8518C92A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480322; cv=none; b=AE0ACobiVv8a8crUa1uRIFGF5kyobi9r1Z+epxoNsQDEtdw31bweQI8sl3gxuG7S0EbLs7zxaR3pYvCj4OEg0aj7QSBR0RH+eHwIiBsVypJGPEAE9JESlP/U9EbVIGGEsBKblELmr9DSAt3ZQlOkQVw+LG5rFTMeE6MCe7Ngn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480322; c=relaxed/simple;
	bh=xQqXaCfhJ+8SBshSebLEJc88cyWsViYwxHaE0UopMJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PQgvSR/C8SowLsWCruzX2ZcyQEuAPi3fgL0TkmjmhJD3EPRQxsTeKv/RVd3/5g58Lgly2J6v0IWap3dN+2O8Fq6uohiJrQrGXXskfBwuW9zSpFGKv9wRMd9mQvwd+98H/JMXL9O87UeuEiNNGWvbQ+XJL+orLwGP+A+XaU/h+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NCBe8FXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iECneaxN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NCBe8FXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iECneaxN"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 01FB9138029D;
	Wed,  9 Oct 2024 09:25:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 09 Oct 2024 09:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1728480319; x=1728566719; bh=RsD6nDRp5ubeh4l7RdmnZO0NNuJllJO/
	IGT0aFm68FU=; b=NCBe8FXBj5TDQY6HTsUxNQfCUkq2X8tULSFtm2xpIWYjxU/1
	RVBbM+sD4TwH2hEfTV+7D3FABBJ/UomlPv7spQHmjyHhlmMSXb49ZkyLWS+nIszv
	KidME4Gapzz86srZg/hEsVrNuM1/13bw7+C0hb871HH5tf2NhGpSfBlYFn2ZIQXM
	N/dpYtFGbvtyDClqZ851J7EVIX+/JUuqiqXYyoNNlH3gD7/ueBNV8gtOrumZ115R
	1TndwKIU6emN/MuSMUucwmVwJF+XU+3yDgix0h29dHFDlfxkq/+T0uOmywLL861W
	7+IBXgLKVGN/qdnUMSu6fc61eLl25kkpXleFSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728480319; x=1728566719; bh=RsD6nDRp5ubeh4l7RdmnZO0NNuJllJO/IGT
	0aFm68FU=; b=iECneaxNAo7wVo7NpHUbMAJVzeUx92bMN0R4KJRCmyuKY5iLX6v
	zbA2RoRhI81qrVzuw2jg3Wyv0fSbvti2OixjdbCGS7w8Xnr+zoWNsv0x2hze/N52
	XChA3ynNLy8Hj15YV/z6zpvFYiUoGiCEneI1c+4cT+K92YF3flLkkkgZBx4NYdhL
	9rPtBwmPFpbTXXUZSXtoKdVPpsmzYcpp6xNGCRY7X3nuN49W8TIRZdrON0iAc8VS
	zZdOaAeX7JscgH8bio5MQgKzSET8k8BnEkSY9vAO2Eqk/aZXweRs3ScuHiLL1uW2
	6lo5j/cSnaL7qgZXVBFWdvdC4Lr+GE1oySw==
X-ME-Sender: <xms:P4QGZ3YMNLfzcy2JQoGc_CWdqN4wnswys4iFG6QuYR1KWI30CYfufg>
    <xme:P4QGZ2ZuGd38S0DtDOTuVzXV_vEIKPo7saC81RfqqXyUammduFMsgLBkbUYJMPADw
    KIxHG7IWRa5ALuquA>
X-ME-Received: <xmr:P4QGZ5_9ay6Txt_cvcKVgOsI6YdaxF7PZJ8dAaIVnw-1mAzTUJMHonhWRnXpPABTnBh6zNH8dj_h8mmwYH-IKWEZ9OyK0C0TTEEibMBs2u8UMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepjeffvefggedthfeftdehiedvueevgfevgedtjeejhfevtdff
    ueeftefgtdekjeehnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhlrggsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P4QGZ9pCT78XiaNfp_qLqygjrtaPChW-VB-z9S8UYY-tbv53TVpjxA>
    <xmx:P4QGZyoXC5TLwe-PEno5iGH5nzrngQ2pV74aTeouUeIPbQDNKUxJDg>
    <xmx:P4QGZzQ1J0fETIg5ajimlAnScJIKcxJpZVXQgiwamV9RBiy34f0ueA>
    <xmx:P4QGZ6rwCxzjMazvhDhj-5kBHY3S-2z8aJJbGaXXO6jRad1S8nvysg>
    <xmx:P4QGZ50friT7Cc2clEpN2z_G101KU3VIr8fC8Z874AXU28cngML5Lk_t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:25:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92b9050c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 13:24:14 +0000 (UTC)
Date: Wed, 9 Oct 2024 15:25:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/5] Wire up Windows-based jobs in GitLab CI
Message-ID: <cover.1728480039.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

there's been multiple cases where changes I did recently broke Windows
systems. This was in the context of reftables, the libification
refactorings and other parts. Also, with my investigation of a more
modern build system I spent a ton of time in Windows overall. So it was
high time that I finally wire up support for Windows jobs in GitLab CI,
which is something I wanted to do for a long time.

This patch series does this with the help of Johannes. He helped me out
quite significantly by starting to publish new build artifacts as part
of the Git for Windows SDK pipelines that we can now easily download and
use. This makes it trivial to reimplement the "setup-git-for-windows"
GitHub Action as a simple PowerShell script such that both GitHub and
GitLab share the same implementation.

I've created a pull request in GitHub [1] and a merge request in GitLab
[2] to demonstrate that the pipelines work on both platforms.

Thanks!

Patrick

[1]: https://github.com/git/git/pull/1806
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/204

Patrick Steinhardt (5):
  t7300: work around platform-specific behaviour with long paths on
    MinGW
  ci: create script to set up Git for Windows SDK
  ci: handle Windows-based CI jobs in GitLab CI
  gitlab-ci: introduce stages and dependencies
  gitlab-ci: exercise Git on Windows

 .github/workflows/main.yml | 16 +++++++-----
 .gitlab-ci.yml             | 51 ++++++++++++++++++++++++++++++++++++++
 ci/install-sdk.ps1         | 12 +++++++++
 ci/lib.sh                  | 18 ++++++++++----
 t/t7300-clean.sh           |  2 +-
 5 files changed, 87 insertions(+), 12 deletions(-)
 create mode 100755 ci/install-sdk.ps1

-- 
2.47.0.rc1.33.g90fe3800b9.dirty

