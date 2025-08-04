Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23E23ABBD
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300441; cv=none; b=JJjCORT5zmy+rTGJlAYRGbM+tkTVas6s21Tat+uyWDbROL2uexWNxaFIWBavygGbYSoPzv9jVfI8x+YFLihKlpmSNUzYdSwmH0WwkJHHim3maoXADTI6xVy/50UxDXvtl6GECUbsATYmSPUhg5QMXP3Nrz0fkobmx8RpA3bj3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300441; c=relaxed/simple;
	bh=PGny4cUXWCV6RnGvhWjRbrmP4V2pcLG90+bFRe7hP9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fNYX0REp41LG9z6R0YDfJnpQVkuwD+7hH/RWNex06dNf2gnwaEXaNCRDkaRP1hSdU3b0F8FEtjJU9zvn7hCCHVusHTZh5m83I4o1fTNRpiQmCpznCfMBKAIHDpIt+iehJK6lnkUlMch7Q29kAuN0BLAiO3tTRFGbNFjhcR8b6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fmKaD5Lf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JHDozOJ4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fmKaD5Lf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JHDozOJ4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 00CEC1D000ED;
	Mon,  4 Aug 2025 05:40:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 05:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300437;
	 x=1754386837; bh=dKjmBNeJg+o1BdL4lqTSeJRTGwGOQPDVMI5aHbaWFY4=; b=
	fmKaD5LfKRDQywILaUEoQYNvoTlTSDubKmkScKXjkyyr0sjTvjlJclppgoo4TYtz
	06u2jJfDoI7AX5eT9RnX16sz7u7u2gqPnqu/RyLXoFdZCPp254sc/d4cbqEP9/hJ
	Z5FeGWTT9ntIOEwePzo1RH7pF6G5LRtHT1B/RE7YTy5E2oHpFDdPwFtaZVeMyr0Z
	zq9QsrI5Kj2w/uVEoRB+T+AUWL2v1epPAwOHSlBlmzfjlIt8vDAUm9IfBmHVz+JN
	j4YkhMqK9G1xvM7jDKnmIYjMOz6lyQsJME/Q3OyRqOKYoZOl+Ert69bJaSUUTvBX
	qoAdAlRHiUGHfWHLOACvOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300437; x=
	1754386837; bh=dKjmBNeJg+o1BdL4lqTSeJRTGwGOQPDVMI5aHbaWFY4=; b=J
	HDozOJ43KGmtPuWZ/GufPbA479Kb9J7KN3f5pDUSgxvJWM4OXLKiPSRD2RPng2/h
	/F0WibrvO9DLDk+JXQir/lM+2GPmt3nzLNR3BemODYWKHHKhMaqh7SJE6Szu3Zse
	aXaU7r+qDAQkSGknxoKAJkvXLjdUBQAOlkZgOxfDGqGO5bbY+9UIp08NOKJWQo9N
	xAqPshODCOzPH3XyVcdUyEwYWaF5ZI0NEQj5mqPJpDn5G0RoHPvjSASomyKXBUdc
	pSVoqkym8LehMEwUliUxA+8OMYK7FPolF/d+Cs/Y+GyJYAYZUvbWxggmEZ7qaI1x
	nN7krs6oGKgKN5pAw0hKA==
X-ME-Sender: <xms:FYCQaMmSkj9MniRM0Cp-D2_Ve0JK4uFxpT04TmFkvO0QdjUGqI35Ew>
    <xme:FYCQaMAL3pTuxGIa_tr1wHDHltnWiBTXy0VyW9uvQszm2oPTIom-tcxg2Roy5Ws4y
    GWdGT9Miud1nPVKAg>
X-ME-Received: <xmr:FYCQaMfJ811iGk9ypc2h155G2LcLT-F7RkVKQ0Gacy26EYb2brqQYUVdeNFCvkbBfIiqdv9H2UFsustVJo42eLQbDznwEMMRs_t2J0X2TuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhm
X-ME-Proxy: <xmx:FYCQaHIxUIcRkDdaQVKyCAf7yGUB8RTX-9dwDamvf5UIwSxKKgOOcg>
    <xmx:FYCQaPdkQbiQQOeJZvOvpiXykZKsFB5UjpnZjNBz3DHHZzzzaEqjtg>
    <xmx:FYCQaO2Z1lVpc3zFmgBQJeKZGd9LcdbDbTryaLGG6KHh6uYBxJQw5g>
    <xmx:FYCQaIhv-Hj65Xyh6S9G1rHx-2p914eLKS9xHZ9VJ-E8CsgcYAwIgA>
    <xmx:FYCQaPKmGQgRRW9U3yNgUBrWs1_Nm_AWdrcfH4Ok8Tf3xJFmbBQ8hEEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:40:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f559722 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:40:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] reftable: a couple of improvements for libgit2
Date: Mon, 04 Aug 2025 11:40:21 +0200
Message-Id: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWAkGgC/42NQQ6CMBBFr0Jm7Zi2UCKuvIdhQesUJiKQlhAN6
 d0dPIHL9/P/+zskikwJrsUOkTZOPE8C5lSAH7qpJ+SHMBhlrLoojcszYaSwdm4kDPymhGGOOLL
 reTVoa+Ma23S2ViWIZJHuURLHvRUeOK1z/Pz+Nn2kf6s3jQpDVdWkfVl619xkcOYXtDnnL5gGk
 PnJAAAA
X-Change-ID: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series contains a couple of improvements I required for
libgit2. With those changes libgit2 is now able to run its full test
suite with reftable-enabled repositories. I still need to invest a bit
of work to make it memory-leak free and compile on Windows, but overall
I think that support for reftables is almost ready.

Changes in v2:
  - Another commit that fixes handling of outdated stacks when doing
    compaction. This issue is hit in libgit2, which has a test that
    performs writes with a couple dozen concurrent threads.
  - Add a link to past discussions around `{0}` vs `{{0}}` as provided
    by Eric.
  - Link to v1: https://lore.kernel.org/r/20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      reftable/writer: fix type used for number of records
      reftable/writer: drop Git-specific `QSORT()` macro
      reftable/stack: fix compiler warning due to missing braces
      reftable/stack: reorder code to avoid forward declarations
      reftable/stack: allow passing flags to `reftable_stack_add()`
      reftable/stack: handle outdated stacks when compacting

 refs/reftable-backend.c         |   8 +-
 reftable/reftable-stack.h       |   9 +-
 reftable/reftable-writer.h      |   4 +-
 reftable/stack.c                | 398 ++++++++++++++++++++--------------------
 reftable/writer.c               |  23 ++-
 t/unit-tests/t-reftable-stack.c |  50 ++---
 6 files changed, 253 insertions(+), 239 deletions(-)

Range-diff versus v1:

1:  e8aacccd51 = 1:  c8bba1f88b reftable/writer: fix type used for number of records
2:  b1a331bc78 = 2:  6c20e9a874 reftable/writer: drop Git-specific `QSORT()` macro
3:  1b3556685d ! 3:  c2ed4eab6a reftable/stack: fix compiler warning due to missing braces
    @@ Commit message
     
         Silence this warning by using `{{0}}` instead.
     
    +    Note that we had the discussion around whether or not we want to handle
    +    such errors in the past already [1], where we basically decided that we
    +    do not care about such old-and-buggy compilers. But the reftable library
    +    is a special case because it is used by projects other than Git, and
    +    libgit2 for example hits the above issue in its pipeline. As there is
    +    only a single problematic instance of this issue we do the pragmatic
    +    thing and simply make the compiler happy.
    +
    +    [1]: https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/T/
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/stack.c ##
4:  c1fb437781 = 4:  0f1bb446ce reftable/stack: reorder code to avoid forward declarations
5:  33dcf7ca70 = 5:  5aaff713dd reftable/stack: allow passing flags to `reftable_stack_add()`
-:  ---------- > 6:  ccfa5b59a0 reftable/stack: handle outdated stacks when compacting

---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603

