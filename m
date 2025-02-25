Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9751A08AB
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512752; cv=none; b=SV24JUql9ye4jFV6ZexnvgcQTQ25LhFej0tzleuM943w22aFb6YaKtrjd+5R1x8nJX1lhO1B4OGt/URhk20b18OLqlPWiLuwmQpj5R1bRZkxX4z4vBrMlQI25R1c5/XUeDZRDT2K2ABCuU+bYq0WVnFNArSnSB04dJ98eKXod7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512752; c=relaxed/simple;
	bh=gUzFAXpy6540JiF/pWCozeC+nc1lVfbpbh44MzIqFQg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ixJ0hcy8BfkM1GQYCfNDNzLZEJATMHkVUM2I6RUEvD7TsMJ5BD0WMDB2AcHNJa9lrIAoHi8OjHKGDPbGZSvva/dzJ84FuzgymHEmj810H2UlM+2CdkNkZp6QFDNPJQgamJuNo18Cy51Elq+UDUMhgNCnqD6FUE55JBRYIYArXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y2Ibd1hm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AzmRuNja; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y2Ibd1hm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzmRuNja"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 684471380A38;
	Tue, 25 Feb 2025 14:45:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 14:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1740512749; x=1740599149; bh=zlJy1vgimzLKvny37n7A1E0764pnHaYl
	dsJQrK2/9Yg=; b=y2Ibd1hmn0Rq2HZBPuWlgbKuXTxlDGXDzwz7HiSNh+Ka+IG+
	ZLitp6Jnbog42egoT9o5xYNzdNX3qldJPUL4op/BapGdydRITsww2PzIlNLtgjUC
	TWN8u2D1Mzm1aCObcxCJfDqxP4j/zKQG+ObmhFdFo4pWSkJwWKYPl30EYPkG+3mf
	93EvhTvtMGrPHhCmy7Nty82nWyb2eFcBDG6lhXEbpiWjvh7fXTuU28ZT7aWw08wC
	6RDdAGXkZa9mIrtH8zO5q9naP95SqM7TrWH4M8EOOLNa/ziOiXSAyVoxkDMgUd3i
	wfvn76V5r9xNC7nOJUlsaQX6nUFzT9b4ZcYAgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740512749; x=
	1740599149; bh=zlJy1vgimzLKvny37n7A1E0764pnHaYldsJQrK2/9Yg=; b=A
	zmRuNjadCPlT0upCyrK92EEF33Y/Y04zMVnBEho6HDAY6e7Cq+mbm4FyBvFB9GZP
	yCgN8dWbgnS6jOwKeprAYDcwakW5/83f/rbSeQKeEMJoiPRzzaJ01TI92/pM7oIv
	KBqEuuOlYwq0EQVxiW6hXkgQsoSIAvEYSgdoXschFQ/YY2ux/hVglpuMIs/XRmzl
	Q3nr3y9TUlcX5SWDUriPDAkBh9TZfhGQHI3Rh6Cpbz9UwvROXxqcP65BlemXY/ef
	3jBBxKA0dXHMe0Ri6ITF6X+3c88jj/LrJJx0Q5K7V4pep4QqdV433tkQiKZ4qJde
	VEKLcnu3oJZCM/BGrd6FA==
X-ME-Sender: <xms:7R2-Z0gK_85bzRWFcnaVDHli1n92qijaPxdgkTZ1w9lAxakD9ZkEpg>
    <xme:7R2-Z9AsKnjjwgLG8SotDkRKxYPizTEbabqwSax9nkLOxUPijNDwY6U9WhMzk7e9l
    yb8y9DIZogaFLpGyw>
X-ME-Received: <xmr:7R2-Z8FMWLWTYWW4HVBj-cZqiREdzW52cE8cVXAttIMenBkdQFtUNM7FHSXerr_3iZwciy_QYCUSks3IejgfJw9amPcMvyuv4oDn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkfgggtgesthdtredttdertdenucfh
    rhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepiedtffeikeegleeltdelleegffeiueehhfehvdet
    tdejkedtvdffueeigeevieetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7R2-Z1SAXfC66nEfNe99ZE_4C2G3Z-e46O_HfQXGXvYkppYWy4Vlpw>
    <xmx:7R2-ZxzgzrpAu4wXy3LdFikrkhOequKSPwwK_d-FV7DwXSaZb60Qfw>
    <xmx:7R2-Zz4wJcpS6Hh8sOAQdwey8fJwQ5VCk7P65Xjtu7Z07basHTmqxQ>
    <xmx:7R2-Z-zP8iqtdPAGlfw935YoN0_LNna9TtC0wJPC6o-y-tl79xK12g>
    <xmx:7R2-Z58fYIhWT7XyoQ_3i1SWRF0UHPlynpcPwQmaADkwykqshDbxgUnu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 14:45:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Date: Tue, 25 Feb 2025 11:45:47 -0800
Message-ID: <xmqqo6ypiz9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

As of yesterday, 'next' started failing all the "win+Meson test"
jobs.

https://github.com/git/git/actions/runs/13506034920

I had to do one of my least favourite activities working on Git:
bisecting CI breakage on a platform I have no idea how well it
works.

Here is the full "stack" of changes, it contains all the topics
merged between 'master' and 'next', plus a single change that
butchers .github/workflows/main.yml to leave only three jobs
(ci-config, windows-meson-build, and windows-meson-test).

    3a7e83b527 Merge branch 'ps/build-meson-fixes-0130'
    e59193e984 Merge branch 'ek/mingw-rename-symlink'
    a209cf1427 Merge branch 'po/meson-perl-fix'
    9f1e73677c Merge branch 'ua/os-version-capability'
    82f01cb375 Merge branch 'ms/rename-match-name-with-pattern'
    8b04381049 Merge branch 'ad/set-default-target-in-makefiles'
    2cab1bd7d0 Merge branch 'pw/merge-tree-stdin-deadlock-fix'
    92b43de9df Merge branch 'mh/doc-commit-title-not-subject'
    685c150623 Merge branch 'bc/diff-reject-empty-arg-to-pickaxe'
    c5093fc2d8 Merge branch 'tb/new-make-fix'
    9091607e95 Merge branch 'da/xdiff-w-sign-compare-workaround'
    01e86410fe GitHub CI: trim and slim for win+Meson test breakage hunting
    2d2a71ce85 The thirteenth batch

At 01e86410fe and e59193e984, CI seems to pass.

https://github.com/git/git/actions/runs/13528755524

With ps/build-meson-fixes-0130 at 3a7e83b527, all the "win+Meson
test" jobs fail.  I suspect that the series does not break
individual tests but the breakage is in somewhere more
framework-ish?  I didn't look into individual test job failures.

https://github.com/git/git/actions/runs/13529323827

I'll also note that in one of my earlier attempts (which had
ek/mingw-rename-symlink merged before po/meson-perl-fix), one of the
10 "win+Meson test" jobs failed ("win+Meson test (7)" to be exact).
Rerunning the failed test succeeds, so there must be something flaky
in t0610-reftable-basics test that is exposed by this change,
perhaps?

  https://github.com/git/git/actions/runs/13528071468/attempts/1
  https://github.com/git/git/actions/runs/13528071468/attempts/2

As the ps/build-meson-fixes-0130 topic has 13 changes, and each
iteration in the above exercise took somewhere around 20 minutes, I
won't dive into the topic myself to identify which one of these
individual topics causes the breakage.  This however gave me enough
to go on to today's 'master' integration (mainly, by mark the topic
to be held in 'next' until this gets resolved, and deal with the
other topics).

Thanks.
