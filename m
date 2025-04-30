Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E9B25A633
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017109; cv=none; b=QqNoCFhfLa8rr2uIzw4RbAddXOfSKsUrDm/XTKL2/CiA/rvG4J6ru/nWphdUeWofki03iVYOqCgoKC+MWt6/1K+1RJWL21TryvsX/txoJ2xnGOVupsyo8qC0aKGhkmAPgI7Vyv73bPug1hX4CO65gnW8yNDKp0md7e/SfODWA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017109; c=relaxed/simple;
	bh=Kank+rPtEAfox6GKnvn/VNx58cggqTXJbbp2MMWa6vY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S7jFwYnP4L5C/RSPc6E43/a33qrvF5QeT4G+lOL78GDQWEpFOi7V5GCKr0xhtamNQ1vkNeWS73jHZj9gMyXPOmNAMP615F+q3bvNaASs4DaPns6uxTzzYgrjZEeMQs7ZXIQMWD0RGiwXZZNJ3nIVQpcBJD5wAmDog2MlRlZ5tb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DAAtMopO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TptRrxUN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DAAtMopO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TptRrxUN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6B5F11402B2;
	Wed, 30 Apr 2025 08:45:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 30 Apr 2025 08:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1746017105; x=1746103505; bh=XnYvOQEfUg
	pRKviJWFsQXPVEEJwD6VtCPoOZ5qydYb4=; b=DAAtMopOkx+pb4ubI9OUMMygMQ
	4gdMbCiE+3BZjZzK5i0M62qQSOfh0Qaf1lLHlKkDwwVQfAgS1wP2azIMd59/GZlU
	EM+Dj3jXWXWuovofO/CnEDjo0wrhWp6MbwzKAVAoaC2pgAnNUFvPVS1WanqCaGnk
	CPZIneWBW+DrrQHkshedNE9yD29KZgcPZqNcVhwocSW3h+oPaZ9GRsHsUJ18gqR6
	kVwpH7HBBWF6NrX9Wq6XVDqODLrbaddDhRrsBH5PB2qKyqk1wq5eylAxIlMbS3eo
	f7yxmaecv0mtFz3Mbo9ihy/HInfjaQDWw293f72+DeWC3MUi1xKR0IgYOQFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746017105; x=1746103505; bh=XnYvOQEfUgpRKviJWFsQXPVEEJwD
	6VtCPoOZ5qydYb4=; b=TptRrxUN26c62/M6SmsGlTCRMo+MRf9swpU/6AFX/8Tk
	5pih88W1MoOnFTqPLBIhOTNh/pAIKLG0lyC7Lz8J06y+DKi+JnFD2oQuKjbia3LR
	Kk6h07tAH/ZyVpkf+ccJc4hyGcJ7h90Z+OZ9Paojr8duuI5IvbEFPoxAP3tMRaQv
	9XShRXYM1CBQIOQni/DiUVnNrcrPqZCSpkUsbUSSN249x/oLTEcYKyvvhq4J07VN
	alC/syKvF2VInhmb94Aez45sapHXjGtuVhUmVFbnJnR+omShtPZU1z0/2aTefI0t
	uPXa9bZ8YXdzR7NTp5h+RwtNq0GIYDDwY8/24IJQrg==
X-ME-Sender: <xms:URsSaNA-uZ_zfODgwftfy4Fq9YU0f9J8uZZLspJRIOLpbMUGsHB4KA>
    <xme:URsSaLi6BAB9Q-CDVr71h92f5QMulJSIG2a5_z771_Z9Sv0Ev7nNKY4jFOxjNck4k
    NayhuldlXMxww-vfQ>
X-ME-Received: <xmr:URsSaIkoxerPgwf-_-RrUf4_5t-ZUvD-W2Ka6iTEjYEGKsa0aJJoU0RRFuXJdlo-U-roOixvvdhLhfn8saCutkVRRBDvnCwfwM8C-JD3ujL4Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueeh
    gfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:URsSaHzEjInal3mOz-BQKIYJg3iPQ4bhBOpGL1s83vQ2fprGUTzQpg>
    <xmx:URsSaCTVCvDfhXyYtUSydlfIrohwVkTQpeMv0P-vo_HFN9Ts4m74WQ>
    <xmx:URsSaKa0MSbLIaM8oO_OQIMxpuwa1pqVH1cOMuc3XLnkYAKz_PFFvA>
    <xmx:URsSaDSgHNt2RVM94IF5-4QiqF7AAwZt6iH0NNy9JAcXL1A3u0uEag>
    <xmx:URsSaFknPP_B_qek3otlHNPKq2fB9-MuVtrVj5iwmh_4FN8ZnM43pw6t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 08:45:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebdbddd9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 12:45:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/mv: bail out when trying to move child and its
 parent
Date: Wed, 30 Apr 2025 14:44:56 +0200
Message-Id: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgbEmgC/x3MQQ5AMBAAwK/Inm3SooiviIOsLRtU04pIxN81j
 nOZByIH4Qhd9kDgS6IcLkHnGdAyuplRpmQoVGFUVSr0a8T9Qj8GdifSItuEdDi7CZ2oSRvbNIb
 rsoVU+MBW7r/vh/f9AIkr1LxuAAAA
X-Change-ID: 20250430-pks-mv-parent-child-conflict-1c15f775e638
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, 
 Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Hi,

this series addresses a bug in git-mv(1) where moving both a child and
its parent directory may cause an assert to trigger. This discussion
came up in the context of [1] as the assert causes problems on our CI
systems on Windows.

Thanks!

Patrick

[1]: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>

---
Patrick Steinhardt (2):
      builtin/mv: bail out when trying to move child and its parent
      builtin/mv: convert assert(3p) into `BUG()`

 builtin/mv.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 t/t7001-mv.sh | 24 ++++++++++++++++++----
 2 files changed, 81 insertions(+), 7 deletions(-)


---
base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
change-id: 20250430-pks-mv-parent-child-conflict-1c15f775e638

