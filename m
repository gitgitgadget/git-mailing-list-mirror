Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E622757C
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623725; cv=none; b=Mn9yUsMDyP2WIzLCodNWzfVAE9MUxw55YgWpungAUnWpkA7cdo/D7MuYHszQYVyy7Me7+atbycyHLQONI1nmbdgQd0HG5jwMnCFnnozNVIwzJ1k9XS6pjPIHpvvC5pZOuf8VATE1je8DrKnal4PM+Nl51u5AfjQA5juUPv/WIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623725; c=relaxed/simple;
	bh=VMtYppdeCmSozAsN4PyRwGivaP0dLzq8LFXSuw6/Olo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UOX+8gUAWMkQ0djVQigTXeEM1fR+gkwAcmFkn9LCr9QHcCfaAqvSsPlMrjTtboat0mU0FeIPiSIryYTVLJyQ1JZNIL3jy7JytPEcTwJ2cbmYwTY1/NwFp3SV2d24TKTWicaPnbvUrwFC5beL+DKkWBd28aQajDpTIHF2IlVxVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ofpBrGXC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GKk8k793; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ofpBrGXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKk8k793"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E5E21380240;
	Thu, 19 Dec 2024 10:55:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 10:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1734623722; x=1734710122; bh=xvDiUZ/PE4
	e4RTABupKF8+pls9neQON2F1RaadHw7Dg=; b=ofpBrGXCjkMSWGv5fDAjeVzzCS
	Z/ge8e8ZeEjUeyNam/dSHlHW+rkb3a6R0psyKxO7+bg+BAjoABkXHYDdOANwMVeZ
	Jn4n8bWhR2j5+mljh23XRbAYM66XL2PMFrMLfdUygKefL3D25i2GX8oKihQ1ZVzK
	ZYL7NNC7g+dkWzyhDdJnUZN5+VlpusaTLPdf3Y8dGbjY3uZHn5zYyqa3KuDBAijX
	WoloNKdEb9snz0taEurzPqiC0KQ23pYbulzsn3YE4Gefgg8twR0ccSsEz8uBwWWL
	NEFdYsKRt5/NksHpuRS341f0QcplCrlxGsIsoMx6VymnovfyobGl+IlEOXJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734623722; x=1734710122; bh=xvDiUZ/PE4e4RTABupKF8+pls9ne
	QON2F1RaadHw7Dg=; b=GKk8k793XUmB0LvVsSd7Nq7aePxfCccQ9qlDwZCbcs9Z
	kBK2yz+2DnD33XnjhXVNpZSTetJ5LOqP0oZ6dSoGUg8zQNJQJOwOTAfekHB/an0T
	pxSZdTVj8v0ySx2YoW04HOpP1vGi+aP7yN7htKKQnJxMkLbGRrgaiafP88Yv28L+
	iwqLfiLG/R6VDq3vRoMSacxmtT3yOnkE0Nt4aemlHC+jO0ZitiqckEk6DHo8zEv1
	GdvLVf9cH6T1meP/8WEkNiAWWgNd391XQD4DSRRXQ8jI0K6okHbp864GrpWp9O0A
	V5UIlVdBnRLZdp2JmYUl87nNvzNcoKimzpHwXWqTtw==
X-ME-Sender: <xms:6UFkZ23A5QGs1_jYsaUK9UHYn2TG-CwUz7p2P_f2w3thH5sReTPCmA>
    <xme:6UFkZ5H4JmzQ6tXfPWdcvf5TLlkP5vJYNXRKLDGohvdj3hZtCbVH0nXvWR0lDTQEq
    k98rhYKo4rIt07w4g>
X-ME-Received: <xmr:6UFkZ-5z9up_3saiRcZO2NjUr9feIoPF-BIXdJF1G0Nix8bXYHFUCp85Z6ZNotbRd5omI2cbbTFjAoEwLW8I5AJ-nx8rbWYperP95l2Af46wbA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:6UFkZ32cYv-XEmww73u7GBVqYw8uRIOnhhCn1T56AeExyHL5WVxAUg>
    <xmx:6UFkZ5GzFDsY9lH7_3y5wwSkgYSYxfVA3zKCwExxmBAL_f82mbaaWg>
    <xmx:6UFkZw9Xt4kUFbALQ0g_sXZplywJg2VCEI6yIOwo11-SoJEnPiLqrg>
    <xmx:6UFkZ-kcuRFy47BjlbL-boOTGbh7HxksYS1_Fs9cfqvsXSURawch7Q>
    <xmx:6kFkZ9j_b3sGWm4DOfvcbC4eu0sQ8p6CpYKJQiOv1_cWAFpUChyYC0Bq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 10:55:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 666ce455 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Dec 2024 15:53:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] GIT-VERSION-GEN: fix overriding values
Date: Thu, 19 Dec 2024 16:53:35 +0100
Message-Id: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9BZGcC/x2NwQqDMBAFf0X23IUkTQv6K9JDtK92EVfZSCiI/
 960x4Fh5qAME2TqmoMMRbKsWsFfGhrfSSewPCtTcCH64FseIm9z5kl2LrCfzkUSQ4vYqgt0Z3e
 9xdalAWO4Uw1thpd8/pP+cZ5fxhIgFnQAAAA=
X-Change-ID: 20241219-b4-pks-git-version-via-environment-035490abec26
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

Peff reported that overriding GIT_VERSION and GIT_DATE broke recently
due to the refactoring of GIT-VERSION-GEN. This small commit series
fixes those cases, but also fixes the equivalent issue with
GIT_BUILT_FROM_COMMIT.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      GIT-VERSION-GEN: fix overriding version via environment
      GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT and GIT_DATE

 GIT-VERSION-GEN | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)


---
base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
change-id: 20241219-b4-pks-git-version-via-environment-035490abec26

