Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD43C33
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553860; cv=none; b=Yqp8loe9P3X4SXIJJlIm8gqDiASTf2M4ANi2Z3QOFffuug3VgKHwlG0tC20VhTpWHHuuaFv5qt5XgoW7Xk0HSR7KTxhUogRIHuOAE/lAuS5GKHMdsMnAfeBTdfzsmUPQ0whHJULUO2LNNnhteQm2YVm1MhQ87ekco0f70u04rSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553860; c=relaxed/simple;
	bh=E8UM/UUW8mI/f2m07LO0UakpUUd4+Xi9ycqbJRZU3d8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=MT/XczC+CEM/A/g/dWwX3QFD5M5yj4x5BoF8sdAZmEy0WKoPNeXyxMN8PwAnXHSxVUzGOR7O9dQpAYf6ClDMJUX7uiLGT0jkJLLUOgmfVQ5gDBEShs3r4249djCfx/b19DLlAOGqKO/6rLVJFqtqBwz0t6T20ADMr/bbCByoOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sr+7PGbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=24CvO29z; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sr+7PGbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="24CvO29z"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F07CEC0251;
	Mon, 27 Oct 2025 04:30:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 27 Oct 2025 04:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553858;
	 x=1761640258; bh=2JAX9AbIyj2ZvfgtPHXcFpwNzThK2zzb40a4mdfXnEc=; b=
	Sr+7PGbDBAY6cYfQfQ29Qaf9mGzeixWGSgDzUN56VTBMl9vsIOsPhW6G4MtAh9t1
	1nEYlYQUg6nUkstT6AEe8Hhu2bk8AsBpq09b452LH+GUaeYqXYvlLCAXWOXUpqCU
	JX0Dlx0g7rWm2pcKzRDIH4hd4obLaIaLf1ti/b/LFGHphYUJWmkVqo4VToOFJHxp
	DgpoBPvTUvjkSMCnMsxhMesHXxI13dKlog/U0bJn2gTslW0Ab5FsQkh9oWtcMlE1
	BdieEa1Zu8qwzF0VUhIRXxiJCv56kqFIn0pTUDpdg7CutwWCJbWrdADlE6aJKCjz
	dj96R8tpOCP0/Jn6Xdc4ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553858; x=
	1761640258; bh=2JAX9AbIyj2ZvfgtPHXcFpwNzThK2zzb40a4mdfXnEc=; b=2
	4CvO29zKckXHUhmxvHHRom9FpK7UTscM+V5lUm6LSp8ienfXCfP7/AHuVBpkBU/3
	Oed0ZT7mfAw4AFXjJOaFxCGBFPdwY/5tslRXfHt9I11slMup0bNnpKA6UIiMHHDU
	HVDoLeYDCKpvFCFHkSINGnBUdQIcgYeOt5B8+57RSd5P10NZBRu15R9Q9KhiwirL
	WCq1NNk0iW+2kkYDn9qZ2nkKwOD0EdJV7Bty9nS6ydv+0f1foOyY4SfmqR5m8JhT
	g3s6eKuNvfFrRoz+6jRoJyyTCMWWyNdsVOIuWWBe1CiZxkX01QUCzZl/ytZnqQag
	2AqCcdbt/bv+OLWsb0J1w==
X-ME-Sender: <xms:wS3_aHS7zAUPTdXvZ7et1MLf9SzNpmlmgcj8O7LbeWLreepRQ4f3kQ>
    <xme:wS3_aPrusup11YJUUnys1SLcpUA3HaXBGPxEitMEISgW5y5R1SQTdC-YxJ-MosAEE
    ozo8oYZd-9RsWU1ZpDz9AwXIUvDe7S2rq-_CH57KYO4uYhUS3MmPg>
X-ME-Received: <xmr:wS3_aFLvbm7F3WISJWxwWDzoJPhS5yORvZEb1SN-IKj81tJGeFizrBX5rpvp5A2hcpk5cChiNe7OAlL73R1XDe3h16IN45WKbgpK5GdTZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetjedvtdduhedvvdeiueeiieduveejffeiieduhfdufeffffdtfeeuffefhfffffen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhgtrhgvmhgvnhhtrghlqdhrvghprg
    gtkhdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wS3_aCq8ePFw_PK1MixDmzzB-36vKhTpurED0NiuJrL47Z_FyjJLmw>
    <xmx:wS3_aNyWQ2EDSsXd3R9DWG5ziB3BeQV_hZnCg-VSOcRXJAgG1cyQ3g>
    <xmx:wS3_aGM9HQL7I2nooGbvQdkAKYcpyAWW7MYPJCg293msGBSKcS9vhg>
    <xmx:wS3_aC5dF_N4jf62ziw_QB-36qi6tKz8M5G6Xxzx_YC-miZ8pOibEA>
    <xmx:wi3_aJtjrxisPAYXHZTZgiWnEBuyrpLEXeu9G4rHIWHjOL_OkzRzY6Vn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:30:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6806212 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:30:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] builtin/maintenance: introduce "geometric"
 strategy
Date: Mon, 27 Oct 2025 09:30:50 +0100
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALot/2gC/43NTQqDMBCG4auUrJuS3xq76j1KF0ZHHYpRkiAV8
 e6NQovduXwH5vlmEsAjBHI7zcTDiAF7l0KdT6RsC9cAxSo1EUxozrimwyvQrkAXwRWuBNpA30H
 0WNIQfRGhmag2rNRGG24ZJwkaPNT43kYez9Qthtj7adsc+Xr98tcj/Mgpo9zkSlYqU4LJe3q6Y
 EdWexQ7T/BDnkhezapMZEYKa9ifJ/eeOuTJ5OVWW2krq6TJft6yLB9ZUYJ9cQEAAA==
X-Change-ID: 20251015-pks-maintenance-geometric-strategy-580c58581b01
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

Changes in v4:
  - Fix a flaky test because git-repack(1) always decides to rewrite the
    MIDX, even though no packs have changed. This isn't a new issue, and
    other maintenance tasks behave the same. So I decided to punt on it
    for now.
  - Link to v3: https://lore.kernel.org/r/20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im

Changes in v3:
  - More line wrapping.
  - Improve readability of maintenance strategies by using nested
    designated initializers.
  - Use git-count-object(1) to count loose objects.
  - Link to v2: https://lore.kernel.org/r/20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im

Changes in v2:
  - Make the geometric factor configurable via
    "maintenance.geometric-repack.splitFactor".
  - Wrap some overly long lines in our tests.
  - Link to v1: https://lore.kernel.org/r/20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      builtin/gc: remove global `repack` variable
      builtin/gc: make `too_many_loose_objects()` reusable without GC config
      builtin/maintenance: introduce "geometric-repack" task
      builtin/maintenance: make the geometric factor configurable
      builtin/maintenance: don't silently ignore invalid strategy
      builtin/maintenance: improve readability of strategies
      builtin/maintenance: run maintenance tasks depending on type
      builtin/maintenance: extend "maintenance.strategy" to manual maintenance
      builtin/maintenance: make "gc" strategy accessible
      builtin/maintenance: introduce "geometric" strategy

 Documentation/config/maintenance.adoc |  49 +++++-
 builtin/gc.c                          | 313 ++++++++++++++++++++++++++++------
 t/t7900-maintenance.sh                | 245 ++++++++++++++++++++++++++
 3 files changed, 544 insertions(+), 63 deletions(-)

Range-diff versus v3:

 1:  e1af6298ba2 =  1:  9893494c0f7 builtin/gc: remove global `repack` variable
 2:  3009eb5fa82 =  2:  d9214040c96 builtin/gc: make `too_many_loose_objects()` reusable without GC config
 3:  888f8576a8f !  3:  0aa6444cef2 builtin/maintenance: introduce "geometric-repack" task
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +
     +		# Repacking should now cause a no-op geometric repack because
     +		# no packfiles need to be combined.
    -+		ls -l .git/objects/pack >before &&
    ++		ls -l .git/objects/pack/*.pack >before &&
     +		run_and_verify_geometric_pack 1 &&
    -+		ls -l .git/objects/pack >after &&
    ++		ls -l .git/objects/pack/*.pack >after &&
     +		test_cmp before after &&
     +
     +		# This incremental change creates a new packfile that only
 4:  d14b6d9bfc7 =  4:  ccff4aea2fe builtin/maintenance: make the geometric factor configurable
 5:  0b2e1dc2561 =  5:  594ee7d3765 builtin/maintenance: don't silently ignore invalid strategy
 6:  417554d8c89 =  6:  cc5844dd05e builtin/maintenance: improve readability of strategies
 7:  0c7f246a9f3 =  7:  6ce5c3bf93a builtin/maintenance: run maintenance tasks depending on type
 8:  4e01332152f =  8:  bbbaee0d13e builtin/maintenance: extend "maintenance.strategy" to manual maintenance
 9:  cf8adf2e039 =  9:  f4faf84e06e builtin/maintenance: make "gc" strategy accessible
10:  20bfc9802d7 = 10:  fc65b12ed9e builtin/maintenance: introduce "geometric" strategy

---
base-commit: 0bb2c786c2349dd6700727153c13d81cbfb41710
change-id: 20251015-pks-maintenance-geometric-strategy-580c58581b01

