Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1435968
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583481; cv=none; b=pjhMGmCHMcNWi8cmcN3Fe1sbDqUxm08lN1CRSjh1D41cvVN55TznNvmeXeYbg3V3W80DIhZckZHNM1NFinw1QXyvr/z77Na3IbX+q/qtjX2mht5VAOdnOGosQK6gPQUpBtJ4dR+xZsHeZvjRQM24YXeQZI7k5Qk4iKpBc871I/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583481; c=relaxed/simple;
	bh=LK8MEyPgijVUPzkzf2xTYpQa7NtLQNF5lRwzftE7LQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=atpljtdz3jg42dd7MdRUumZh7ilKv+ZUOLH9PKWOwfUg6cczop1+kNZmgSQTioOJMQ5GzlVEjNUQg0IlzGvAStbd/Hodhs62Q1mzARO8AiHXBH1evy7DQstHwWgCegIE99JefT+mEhf8NoHrfIuX/0getsamqA1BabHK6BE8mAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dh0FwQPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOZgN1/z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dh0FwQPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOZgN1/z"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E90B11401C5;
	Wed, 26 Feb 2025 10:24:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 10:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1740583477; x=1740669877; bh=JfbGGt0UTZ
	bYsdagcz67bYeStIEoHnuQkyn053MwG98=; b=dh0FwQPJa4Z6RyzLZLpVPuQfhX
	fX/8FllyebveEqzpuUMTGLF4o8EGCOu+olHEwZ2b9lgaLX5grbiTMzp+C/o+gq2L
	dUvP5xjOTuuvo3CZCZkYgDSEkzrM7Z9QKkGVIkvCq4y5Eh58wxVZ7CxIecmtjIZq
	4XpOVcYbS2hl2v1B5Ur496SbboFygRYcbJOYT0miQVP1OGD8J4gYtqAc+JmTFCg1
	a6FYMlwuXSMLbMghd+N9gCyJ9HRv5x+vCcDg3x8Zin/NV2NIO22/0Xgx98kT13F7
	id4t/wZdUdtIdC1up4VVp1t1k+jrueTIbw3xAfkUOl+oyuzU1+Now4GIunag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1740583477; x=1740669877; bh=JfbGGt0UTZbYsdagcz67bYeStIEo
	HnuQkyn053MwG98=; b=iOZgN1/zNoDq8JTgDvb0/vqxsVu3VmwkbyIpaLRorkl1
	oxzGwMK7V4QKbJjUpb0NCtgzxKYHV9FaUDh4P9yPc9PP/WlL/N8lqR3Q59OUHUlu
	LlZ44oW+TWAjzLx06ZxoA+dJ3h/lYZsMD2OekgsQJVrTsXz7XZeop3+X0KAWEHof
	pR6gQWUagIioD1WG8DR4SF8mtJk2OZz7IBXZ41ct+l/PaBUhwNs8uUO5wPsy2jBe
	c/nkmomYa0HjfbwZVleF6gEtOiLDAhsOqI7A0wl5Ue/4hWLQ/m3NsC4TNm5k2IFx
	oDPoKvBrUovzsKVY6+wYtWHBHBSD01Q9m/gXwNehOw==
X-ME-Sender: <xms:NTK_ZyTbbrYOrNu3ho3EiNgzr7CDZR5kZLbeooLG4xkmu5Y6aAFQCw>
    <xme:NTK_Z3zCO8tFZacFzRTtxWcd2-Ygh_0vuUSjMwcTw-imw8C1jDaw1zCHwpiajJI6g
    xB5yXq3UJUoELV7lw>
X-ME-Received: <xmr:NTK_Z_2O3QJ2BHExJAVevA9MzpMJ36Edo-brkgTUfFYzwxU6EHjRC99e5soCFbTanq31dy7SG0Eb3pPK5J5cs9rfpxdpayqmYZIaiWzrSAIWshIm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhefg
    teffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopedvtddvhees
    uhigphdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NTK_Z-Cb7MJTc-CRC84FoP0v7bPM-gxoyobZblBl5rGe00BMN8uTYQ>
    <xmx:NTK_Z7hijcGTqt0tYHkz16BzkRyPBY8KPA3cwmTwO6QeI_p0Mla3BQ>
    <xmx:NTK_Z6r0aoK8HhlI7BwdVwXjRiqu841fJf2d-HYOvi4lnIufB6hB0Q>
    <xmx:NTK_Z-h5sAqvX86h8kxLmQwLZX3cnR_utOwRAN5SMd8_5ykq_eAdCA>
    <xmx:NTK_Z7dd8AffkXcUGuNAu-sxg9bmX75L2s5G2nKywYQ5zMbs1EzbHMt5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:24:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f65b366 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 15:24:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
Date: Wed, 26 Feb 2025 16:24:25 +0100
Message-Id: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkyv2cC/x3MQQqDMBBG4avIrB3IhBqhVyldhPTXDrVjSKQI4
 t0bXH48eAdVFEWle3dQwU+rrtYgfUfpHW0G66uZvPOD8z5w/lT+RrUNFi2BC6ZlnRl71gIOkoL
 cxI2DRGqP3LLu1//xPM8/OIeyem8AAAA=
X-Change-ID: 20250226-pks-maintenance-reflog-expire-61c61410751a
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series introduces a new "reflog-expire" task to
git-maintenance(1). This task is designed to plug a gap when the "gc"
task is disabled, as there is no way to expire reflog entries in that
case.

This patch series has been inspired by the discussion at [1]. I consider
it to be another step into the direction of replacing git-gc(1) and
allowing for more flexible maintenance strategies overall. Next steps
could be:

  1. Enable the "reflog-expire" task by default when using the
     "incremental" strategy. and then we might eventually switch over
     the

  2. Use "incremental" strategy when "features.experimental" is enabled.

  3. Switch over the default strategy to "incremental" after a couple of
     releases.

Thanks!

Patrick

[1]: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>

---
Patrick Steinhardt (6):
      reflog: rename `cmd_reflog_expire_cb` to `reflog_expire_options`
      builtin/reflog: stop storing default reflog expiry dates globally
      builtin/reflog: stop storing per-reflog expiry dates globally
      builtin/reflog: make functions regarding `reflog_expire_options` public
      builtin/gc: split out function to expire reflog entries
      builtin/maintenance: introduce "reflog-expire" task

 Documentation/config/maintenance.adoc |   9 ++
 Documentation/git-maintenance.adoc    |   4 +
 builtin/gc.c                          |  72 +++++++++++++---
 builtin/reflog.c                      | 153 ++++------------------------------
 reflog.c                              | 137 ++++++++++++++++++++++++++----
 reflog.h                              |  35 +++++++-
 t/t7900-maintenance.sh                |  18 ++++
 7 files changed, 263 insertions(+), 165 deletions(-)


---
base-commit: 5a526e5e18ddb9a7dfc5a2967d21d6154df64a4f
change-id: 20250226-pks-maintenance-reflog-expire-61c61410751a

