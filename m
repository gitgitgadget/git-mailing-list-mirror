Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896D53389
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296441; cv=none; b=hgk2uGPhyHJfff3nbepBlBNZDDYPilZHd2k2HSBqjzL1nKq5kZCVFsK57uhSdYGqPAXBJ8fLD6SBfKdUu6EKdy5pu3Ttx4tRF6MEQ4xIwwff8yCadM1Q+TH9Ok/o9s9pdRfcv2bL1KCeWUjgbNHBxIYrySiyceyIVUlv1SuD96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296441; c=relaxed/simple;
	bh=E/OMbmBRKYZDhJ/7fb3PUNnnxYmm2Eq+m2EVtDYfHPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g71sCzx9l+XBG/u2IAnVuo1juDuCxOZK4bPeh13uTgL63NXdzzPTd0Al+oX9l7ttyPrYS3AzUWbkidD5MFzt7a6yo3kaJV4xf55jazG3IBNG0CCP9jvl1BWZ2WPNwVqMJ25Z2+53pL17sUy30OCCmBcF4VYpmMGYSMJc17y/rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QqJPVKfd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sRzsMptv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QqJPVKfd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sRzsMptv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AED8911400D2;
	Fri, 27 Dec 2024 05:47:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 27 Dec 2024 05:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1735296437; x=1735382837; bh=TgSTdw+i3z
	RX9LTa86ehrpPhT6CpOw9g0Myr8GHgYtE=; b=QqJPVKfdLsqxqiWnd6HI5TVhc7
	fGWEKuo3rHiMctu7txBz0/qxCMj/bdYYPObyn16YAq7ajjjvSM9YGIiJB9M64H4r
	7/nGZ89oT/et3Vm/5tQTCz4P65KHztNvj5PCFUTbJPUm4iLqs7mJPbvcf9gjUQUx
	yqCBmbVdQ2uJys0UP/mbJDmAATc9vzV2Y48OfGc93acxgfK8doTmWbIBrZSzXV3X
	UsPy2aYEZREpEmQcT9vnZu93UsNHVfIsggHOVyloYKSSCGdgZp7OM7+ELaWlLKKY
	eqsbDx7otnWWpbL6iqm5MFcARzOCmTLagEmcmkA6Bj/SCMirtG6kjsYnAk0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735296437; x=1735382837; bh=TgSTdw+i3zRX9LTa86ehrpPhT6Cp
	Ow9g0Myr8GHgYtE=; b=sRzsMptvbSpF2V9NBbXsn5ZXJwGqDKEVCvDqX+McHKO/
	kVvxBq8EC74G9TxBjU3PadUQ1yaFFGDJO/xqw9P4gz95RXxvKG45AISSK6nw2DTo
	foi0uy5cV+rNQubfBDXR6+ktdJ+9iQ46jn/dKn9gOuOsW79IIgt+AvbRRGjjZyjt
	69UGHpve/9NxUAoLQg/e9uw0OnryMCGihIex0NaRoinxQQOFeEy1Wj3UFvOoX6jn
	/6YnvUdTVoYUNT+b5CouCheXyHsAAUesh5RlOho/LeV7EsWxpwMuIOivf49XG+Xy
	ABQp0jS8wJBrlRF+VZacruKKe8pg1zLkJQuO43IiTQ==
X-ME-Sender: <xms:tYVuZ-coDnHs8cbVlxjnU7n3QgOmr0PvuC6228pxRS2qN6Ng-zS8ew>
    <xme:tYVuZ4MQsSqyz4wF7QJPNuOTdzJvna4LO0FxuL03fvkh2LjCjcgKErHFK_zd0j1bF
    olwfI3aApVpoNFQGg>
X-ME-Received: <xmr:tYVuZ_gRXgwrXeO3LDCz_SHTfbPyOP8ET4RllUj99GWgtsk4VJg-54A6BXGx8Yn4DuNzgbSLFBVKw7FOU_yCMZtXIhSFoW0mm-KRvlKfosj8ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:tYVuZ7_ita3PH4HcNE1b7o69KwYXc-i8ZKJftUQEacr72vu4xMzWRg>
    <xmx:tYVuZ6vpgEZdxwfW_eO-xMnQfNg_NdLrKI-V6f4m1t-VDG2vVV5JIA>
    <xmx:tYVuZyG8XQsl3JM4Yy6Yv0xggQOMQh6NtjISh_IiuXflC1i8lcoVig>
    <xmx:tYVuZ5NR-Ixy__VcZOIHd42_3aRnHnqYkAncMCUugLyLfHHAJu09mw>
    <xmx:tYVuZz5hQd-EPbWDO_IDruz1gSxSK_pGetdNmhzS6Inl2DBaCwwIzav4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3be2361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
Date: Fri, 27 Dec 2024 11:46:20 +0100
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHyFbmcC/x2NQQqDMBAAvyJ77oJuLBa/Ij3EuNGlGMOulIL4d
 2OPM4eZA4xV2KCvDlD+ismWCjSPCsLi08woU2GgmtqGqMOxxfwxDNu6yo7KPixoMqfbZK+M5J6
 +djHG0L2gZLJylN9/MbzP8wKyzhfscgAAAA==
X-Change-ID: 20241227-b4-pks-commit-reach-sign-compare-235a03fffc78
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

this patch series is a follow-up for [1], fixing two smallish issues
introduced in that patch. Naturally I couldn't stop there and decided to
also make "commit-reach.c" and two other files -Wsign-compare-clean.

Thanks!

Patrick

[1]: <20241220084949.GA132704@coredump.intra.peff.net>

---
Patrick Steinhardt (9):
      prio-queue: fix type of `insertion_ctr`
      commit-reach: fix index used to loop through unsigned integer
      commit-reach: fix type of `min_commit_date`
      commit-reach: use `size_t` to track indices in `remove_redundant()`
      commit-reach: use `size_t` to track indices in `get_reachable_subset()`
      builtin/log: use `size_t` to track indices
      builtin/log: fix remaining -Wsign-compare warnings
      shallow: fix -Wsign-compare warnings
      commit-reach: use `size_t` to track indices when computing merge bases

 bisect.c              | 11 ++++----
 builtin/log.c         | 50 +++++++++++++++++-----------------
 builtin/merge-base.c  |  4 +--
 commit-reach.c        | 75 +++++++++++++++++++++++++++------------------------
 commit-reach.h        | 10 +++----
 commit.c              |  4 +--
 commit.h              |  2 +-
 prio-queue.h          |  4 +--
 ref-filter.c          |  2 +-
 remote.c              |  4 +--
 shallow.c             | 38 +++++++++++++-------------
 shallow.h             |  6 ++---
 t/helper/test-reach.c |  6 ++---
 13 files changed, 111 insertions(+), 105 deletions(-)


---
base-commit: 76cf4f61c87855ebf0784b88aaf737d6b09f504b
change-id: 20241227-b4-pks-commit-reach-sign-compare-235a03fffc78

