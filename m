Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F32F0693
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056012; cv=none; b=Cohn1q/z5YnJrDEYNTPTUwPKynW5Mvr6BZqExP35wErLuMxRkqGgEdin2TwLoBPE0HEPvYS5VmZgLNwku3koXfCoRuR2yUpMVEpkCNrN9MGGgSczsneQZUlzYWZxQl+J3zZqDQmEPRu8GHnC5ZBq3puU2ZgmjKSjzLRotwKKAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056012; c=relaxed/simple;
	bh=Svww3z2ExhpTCz81sZsrsQM1sTZmv7ijNK6P+Lh4on0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=YSjkjrw8Bn0kOtsv5a/t0BE6FIwOhFiJswx4Hl2hHOkx6NcjMBLVOBRkTRUM+rB/LzCOZ58Y/B+mFWzTI5DhN84kPA4G/0ktubVDDt1v0WQyQ9KYQRhzLNynv5cTgDgOV2WiDeax8NwV8gsRzXVY2khiLXg/uTJA41DFHKgmpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n2CB3tdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zvt7QcA5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n2CB3tdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zvt7QcA5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A743EC01A9;
	Tue, 21 Oct 2025 10:13:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 10:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056009;
	 x=1761142409; bh=+FSLOKIByAlXZWoyZAEjVLAtMhEa/WVl7FZAsZuBjeU=; b=
	n2CB3tdA9WFbwSOpIIdvXCTMd7PfYjQTAOB1OVBlDktJJaUtH7nudual8Vx4HOjW
	0FhD5qGNogyqkbGxzIstmYZowF2BcfUCmwSC763n2aO38Y71ov6yS0OodGlpTLjq
	Apl7pMQRhhdz/BBEHjK6MOgRZEWqOye9gKnc2tMsp0w0Dyb74b9L/tR7NN8nUAqx
	iDjM0iOeoeASdFlFgYxN1RIh9f0peR6CPI8FFVobUdg/uOUKNPcMsbZynicnp+ks
	boJYhP0IwoODGPaQvrgjBFRtb2d/h671YbRsljnglvI+4pGUjrQoEM1ksmEy+Y9u
	3yqKkX6A8eobMqHldAouiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056009; x=
	1761142409; bh=+FSLOKIByAlXZWoyZAEjVLAtMhEa/WVl7FZAsZuBjeU=; b=Z
	vt7QcA5LpfDR87pMW0AQrIxeHE2sl1knieWnr1IhxE5FNvENDocGhwHMUMgDhTGY
	GppviZ5dLDuvx30NcPbcuwljdmqnNuI8K54/MycBJq/eF8fz2kOY0k+N1Nzdr8MT
	amm+luenWwJXxDYTlwgcUJqMQf09lWSEqDcG7I+KqNIitUVe6QSbOc6f2fY6wfKi
	zbLMieeH4W0rXPFLlE5tc8Gdsh4D4X9TRybEvgOc6fZET0RxqJUkTQMaBClhP1FS
	qBeEwPLrQZTkD/167HQ0VC2/CSNEXgZukPcjJWjCk494b3vtc7gCQQKct+0Kam7N
	1tFHN93eXAmEbLUJlDoJg==
X-ME-Sender: <xms:CZX3aDykoQcY3IPDg9KkKI19l53h_O_vCjUNjO_jUj7XnBJleUfphA>
    <xme:CZX3aCvNgpqegCuaC1rqYWIc5nA0WZANMRyQiMCdFq1kL1igFB1qUU_Kxz9Xw5T5h
    y_rpJ3RP547jdlHmsZ0k462WnL5LaJC3hM6Y-4vIlQOef--dzLtnhY>
X-ME-Received: <xmr:CZX3aKsFKPDleAhlET9Ti_vcgHbRwIRTfItJeZMZO0FiAgIaCTJNmm1q1e83pZMLc97S6Wstr-0lVzUgzSwswA0_5VlbG85AH496sygc1ZniHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtudefhfeuleevveejuddugeeuheegteeffffftdeuheelgfejffevjeegvddufeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhgtrhgvmhgvnhhtrghlqdhrvghprg
    gtkhdrrghuthhopdhgvghomhgvthhrihgtqdhrvghprggtkhdrrghuthhonecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CZX3aHOPkKKJbm3Ms3fOhhJNstOQ5wlrYW2NFA3ElkIZzD7ewpp8-w>
    <xmx:CZX3aI3h03r5a4yUXwIIqHnRm-OJ4PqWVuse3MdY4PE4LV0BpbmK3g>
    <xmx:CZX3aDM4aedyInKlItAzP0hmFuV-HmgwE5-w6NPEdSZ3qbNtkXEj7w>
    <xmx:CZX3aI3JIYc_Pmt7_Gek_vL3nvf-qdEkwvSP5OVDfvfr57yBgKJQeQ>
    <xmx:CZX3aAKSKpZH2p5edqTQI4iZdbKg0FCxdlPl_BnJ0nIG5E_N6wCyBy-d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03400702 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/9] builtin/maintenance: introduce "geometric" strategy
Date: Tue, 21 Oct 2025 16:13:22 +0200
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKV92gC/42NQQ6CMBBFr0Jm7Zi2UK2uvIdhUcsIE0NL2oZIC
 He3krh3+X7y31shUWRKcK1WiDRz4uALqEMFbrC+J+SuMCihtBRS4/RKOFr2mbz1jrCnMFKO7DD
 laDP1C2ojnDbayIeQUERTpCe/98i9LTxwyiEue3OW3/WnP/2jnyUKlObS1F1zbpSob+V05BHab
 ds+CNCpZ9EAAAA=
X-Change-ID: 20251015-pks-maintenance-geometric-strategy-580c58581b01
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
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

Changes in v2:
  - Make the geometric factor configurable via
    "maintenance.geometric-repack.splitFactor".
  - Wrap some overly long lines in our tests.
  - Link to v1: https://lore.kernel.org/r/20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      builtin/gc: remove global `repack` variable
      builtin/gc: make `too_many_loose_objects()` reusable without GC config
      builtin/maintenance: introduce "geometric-repack" task
      builtin/maintenance: make the geometric factor configurable
      builtin/maintenance: don't silently ignore invalid strategy
      builtin/maintenance: run maintenance tasks depending on type
      builtin/maintenance: extend "maintenance.strategy" to manual maintenance
      builtin/maintenance: make "gc" strategy accessible
      builtin/maintenance: introduce "geometric" strategy

 Documentation/config/maintenance.adoc |  49 +++++-
 builtin/gc.c                          | 278 ++++++++++++++++++++++++++++------
 t/t7900-maintenance.sh                | 246 ++++++++++++++++++++++++++++++
 3 files changed, 515 insertions(+), 58 deletions(-)

Range-diff versus v1:

 1:  d16d9ac4f01 =  1:  f14cf90529d builtin/gc: remove global `repack` variable
 2:  2beb7edfdc1 =  2:  64fde2d3fb0 builtin/gc: make `too_many_loose_objects()` reusable without GC config
 3:  e4bcc347e76 !  3:  9ba24540238 builtin/maintenance: introduce "geometric-repack" task
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +	rm -f "trace2.txt" &&
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
     +		git maintenance run --task=geometric-repack 2>/dev/null &&
    -+	test_subcommand git repack -d -l --geometric=2 --quiet --write-midx <trace2.txt &&
    ++	test_subcommand git repack -d -l --geometric=2 \
    ++		--quiet --write-midx <trace2.txt &&
     +
     +	# Verify that the number of packfiles matches our expectation.
     +	ls -l .git/objects/pack/*.pack >packfiles &&
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +		run_and_verify_geometric_pack 2 &&
     +
     +		# Both packfiles have 3 objects, so the next run would cause us
    -+		# to merge both packfiles together. This should be turned into
    ++		# to merge all packfiles together. This should be turned into
     +		# an all-into-one-repack.
     +		GIT_TRACE2_EVENT="$(pwd)/all-into-one-repack.txt" \
     +			git maintenance run --task=geometric-repack 2>/dev/null &&
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +
     +test_geometric_repack_needed () {
     +	NEEDED="$1"
    -+	AUTO_LIMIT="$2" &&
    ++	GEOMETRIC_CONFIG="$2" &&
     +	rm -f trace2.txt &&
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    -+		git ${AUTO_LIMIT:+-c maintenance.geometric-repack.auto=$AUTO_LIMIT} maintenance run --auto --task=geometric-repack &&
    ++		git ${GEOMETRIC_CONFIG:+-c maintenance.geometric-repack.$GEOMETRIC_CONFIG} \
    ++		maintenance run --auto --task=geometric-repack 2>/dev/null &&
     +	case "$NEEDED" in
     +	true)
     +		test_grep "\[\"git\",\"repack\"," trace2.txt;;
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +		# An empty repository does not need repacking, except when
     +		# explicitly told to do it.
     +		test_geometric_repack_needed false &&
    -+		test_geometric_repack_needed false 0 &&
    -+		test_geometric_repack_needed false 1 &&
    -+		test_geometric_repack_needed true -1 &&
    ++		test_geometric_repack_needed false auto=0 &&
    ++		test_geometric_repack_needed false auto=1 &&
    ++		test_geometric_repack_needed true auto=-1 &&
     +
     +		test_oid_init &&
     +
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +		test_commit "$(test_oid blob17_1)" &&
     +		test_geometric_repack_needed false &&
     +		test_commit "$(test_oid blob17_2)" &&
    -+		test_geometric_repack_needed false 257 &&
    -+		test_geometric_repack_needed true 256 &&
    ++		test_geometric_repack_needed false auto=257 &&
    ++		test_geometric_repack_needed true auto=256 &&
     +
     +		# Force another repack.
     +		test_commit first &&
     +		test_commit second &&
    -+		test_geometric_repack_needed true -1 &&
    ++		test_geometric_repack_needed true auto=-1 &&
     +
     +		# We now have two packfiles that would be merged together. As
     +		# such, the repack should always happen unless the user has
     +		# disabled the auto task.
    -+		test_geometric_repack_needed false 0 &&
    -+		test_geometric_repack_needed true 9000
    ++		test_geometric_repack_needed false auto=0 &&
    ++		test_geometric_repack_needed true auto=9000
     +	)
     +'
     +
 -:  ----------- >  4:  d1b805004b9 builtin/maintenance: make the geometric factor configurable
 4:  c9a6e576299 =  5:  d6fa70640c2 builtin/maintenance: don't silently ignore invalid strategy
 5:  3c82a91f152 =  6:  37f7793dab9 builtin/maintenance: run maintenance tasks depending on type
 6:  78502ad6868 =  7:  4b15eac845c builtin/maintenance: extend "maintenance.strategy" to manual maintenance
 7:  59a5450c44f =  8:  eb75881b6ae builtin/maintenance: make "gc" strategy accessible
 8:  51065b109fa =  9:  5c011e7a7e2 builtin/maintenance: introduce "geometric" strategy

---
base-commit: 0bb2c786c2349dd6700727153c13d81cbfb41710
change-id: 20251015-pks-maintenance-geometric-strategy-580c58581b01

