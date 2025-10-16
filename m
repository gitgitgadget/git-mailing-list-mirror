Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75C62E62A4
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599612; cv=none; b=FEM8Sux12ox4s3+Ps6E9EBkocgtJhIAm5oBrFNBxA8vli6wTiNzLRvpaTuoV4gazLX4EnMTGbn7Ib5N/qSIVbljI3fnFsRaj7tbuF9LOFQpepvc1PhgnhWtEw5kKV4XVzM549hPjyDtP43ksDW+HLRf9yeWLe3Marn74lLV1beo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599612; c=relaxed/simple;
	bh=ce5E8WwFAaQol7XNcvzB+dKVDypDqxh2jPb3/nS4Gv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gnKT10aOu7VHA0SoAsKIrjToeIZFt1uSzjXJWSys+GypeNaAgJLkd1TVf2MYlF4/tL5KLKyDrujug41Vkef7EIUEndX/y4bERXvMApBsqs/EL7gYyYYrWZRQP+FAzIEYOvtRboySbsdZngq6ezvpXXbLKEh/w/ioIJAD8BIMmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cOuEd3yX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9Ad3O1b; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cOuEd3yX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9Ad3O1b"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C0CDDEC01AC;
	Thu, 16 Oct 2025 03:26:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 16 Oct 2025 03:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1760599607; x=1760686007; bh=EFhEAAC6xV
	WMkA8/r6DNW2BDSWfyET94NzWHeity1nQ=; b=cOuEd3yXbj8DovuWfAeCUoe9+I
	PO0b0kblSqMnFRw/51BfeXAGcASl4NNj6ytz1JF4XJXE/KeIfQfdK05xsnBS9pXn
	HWl4a0ZsLSl+nAd3O84Bj9WWqRZ9pz5/bhc5ZWIbwQlyjZxWevnL/LRyL3T7L9Qs
	2u1tSPGRvhYDTCE4gdEEM/hYV2mwrGAZsH83ZlzFpb52wYFbxeOdKMfQsJc6wJwZ
	ksgx0t9vk2mC7Pei5U7LalRb5PV5BfA/vXbUoqM3CzQsIKTASlI/+h1rZvIFAljp
	tKiHVguY0AoJJ5xgSAtTh4RqapBvZQzHC78D/7VKj92Sd97wwRpxXY4sxhRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760599607; x=1760686007; bh=EFhEAAC6xVWMkA8/r6DNW2BDSWfy
	ET94NzWHeity1nQ=; b=F9Ad3O1bZdmhlxjlav0SG095n/oLhPhCbHp3GQ2oFBrR
	RMSOoykaz69Ka5nGhl4C8DDF26jXUIZbkfHcQXM4xmdIH5zN2wDxU48r6pEllEoo
	fsb2LTQKA+dzgh87CBYDt6aVz9isd4lNwsZzrhfu1Px0vIiPRvgXn5b/5XaWopl6
	0PxuDLAdcYjQ86aH0B5gKNATp1ThVAB08dn8S8gqpSptHTzcKqApe46JpTsN08ci
	SA8C9rdmTsB4GpoLOr2x/HNHJvtyFjo0CUCX8Wvwb7hJLaNiWWLodh2tQht5KikL
	/LMHT78KV/lYSAk6kUsb1AsC+2EBqohupepyXGcUIg==
X-ME-Sender: <xms:N57waOhBLKvqyJPl3250TmwiF8EL1Jcs6o8i2ITVrfgy2CHMv_0ZSQ>
    <xme:N57waGd3wEgs-a-c8u7MAWI68rK3Fd9mJhnNbFPBj7NkX8H9W1yx59kyywDkwoChB
    k3nAiosKA6bNFQ_NtR82Vz54BH5GrBqv86YoiJKi3BqDICxnEL1vg>
X-ME-Received: <xmr:N57waDdpq35RAQT34BlgnIj_A15bQqgy2K7faoZhZpz4dWrfq1qRCjTmFaNXiQz53j2VvVU_lIxX1L2SVki7S6SZ9dXQlshXy1D5pfnGu-mJzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N57waA-6AYl3RNf4VrGdYfhqrbmFHWBsR5Yp-Fm2TORSU53LlBjDYQ>
    <xmx:N57waPktG9WA2ged_miz91KRTi4nE6ORqizU8JE77d6nKzWNxjVg9g>
    <xmx:N57waC_K_YEjgP0Oa7DzASEYdFyWYaJ-jXIdaAMhWIrwEZ86tKIGUA>
    <xmx:N57waNlZ3O-1086HUBMRP6U1L0mhqNpjMypn0t7O744xPac5wG6pGQ>
    <xmx:N57waH4xQ-orDZNGMXPpKpxLFIWsZDn52RVHLABL_wKeYgLHeHwnKgzz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:26:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84588196 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:26:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] builtin/maintenance: introduce "geometric" strategy
Date: Thu, 16 Oct 2025 09:26:31 +0200
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACee8GgC/x3NwQrCMAyA4VcZORtoBoHiq4iHWmMNsmwkRZSxd
 7d4/C7/v0OIqwScpx1c3hq62gCdJqjPYk1Q78Mwp5kpEeP2ClyKWhcrVgWbrIt014rRvXRpX+S
 cKmfOdEsEI7S5PPTzn1yux/ED+akH4HQAAAA=
X-Change-ID: 20251015-pks-maintenance-geometric-strategy-580c58581b01
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Hi,

by default, git-maintenance(1) uses git-gc(1) to perform repository
housekeeping. This tool has a couple of shortcomings, most importantly
that it regularly does all-into-one repacks. This doesn't really work
all that well in the context of monorepos, where you really want to
avoid repacking all objects regularly.

An alternative maintenance strategy is the "incremental" strategy, but
this strategy has two downsides:

  - Strategies in general only apply to scheduled maintenance. So if you
    run git-maintenance(1), you still end up with git-gc(1).

  - The strategy is designed to not ever delete any data, but a full
    replacment for git-gc(1) needs to also prune reflogs, rereree caches
    and vanished worktrees.

This patch series aims to fix both of these issues.

First, the series introduces a new "geometric" maintenance task, which
makes use of geometric repacking as exposed by git-repack(1) in the
general case. In the case where a geometric repack ends up merging all
packfiles into one we instead do an all-into-one repack with cruft packs
so that we can still phase out objects over time.

Second, the series extends maintenance strategies to also cover normal
maintenance. If the user has configured the "geometric" strategy, we'll
thus use it for both manual and scheduled maintenance. For backwards
compatibility, the "incremental" strategy is changed so that it uses
git-gc(1) for manual maintenance and the other tasks for scheduled
maintenance.

The series is built on top of b660e2dcb9 (Sync with 'maint', 2025-10-14)
with tb/incremental-midx-part-3.1 at c886af90f8 (SQUASH??? play well
with other topics by preemptively including "repository.h", 2025-09-29)
merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      builtin/gc: remove global `repack` variable
      builtin/gc: make `too_many_loose_objects()` reusable without GC config
      builtin/maintenance: introduce "geometric-repack" task
      builtin/maintenance: don't silently ignore invalid strategy
      builtin/maintenance: run maintenance tasks depending on type
      builtin/maintenance: extend "maintenance.strategy" to manual maintenance
      builtin/maintenance: make "gc" strategy accessible
      builtin/maintenance: introduce "geometric" strategy

 Documentation/config/maintenance.adoc |  44 +++++-
 builtin/gc.c                          | 271 +++++++++++++++++++++++++++-------
 t/t7900-maintenance.sh                | 212 ++++++++++++++++++++++++++
 3 files changed, 469 insertions(+), 58 deletions(-)


---
base-commit: 0bb2c786c2349dd6700727153c13d81cbfb41710
change-id: 20251015-pks-maintenance-geometric-strategy-580c58581b01

