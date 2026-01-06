Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEA1F5834
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704346; cv=none; b=W/JukS/9NLexxbZqjYQ8Y0tFEOQIra862/Wzgxcx9UbIyHxzn4gjH6gwIYamRmuurOjWQUn5LqM/+kfyq1zfDNNhAJKxLhwk9HUmj3Rbf7jUgwCNegUP9VFHc8HtmnJMJ7P3J3qJwFRgAclfsVe3at1/xCaC+qiwrZgpuoQDtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704346; c=relaxed/simple;
	bh=ri3bBZSaQEvn4x6qmWxlUaTYRfuXtkZ0Hv2gi0Svz5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=lgu4YFp2KWWGc5IM1M9SNzq5pBr+ra0znX/tkRzGXYUsYBcqzW6Lmds0zVmHKcYiEBx7eJ2vG7+EuKIp2Y547oK4l1tvDnn1yCirBeF1HDz0nGqhezqvtnPWOMXrcIHj/060ZIo6sEaYy9HTRScas3/INrl8rAxuEg4wzNSmbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WeBeXJAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tj9lL5NA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WeBeXJAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tj9lL5NA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C3867A00EC;
	Tue,  6 Jan 2026 07:59:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 07:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767704342;
	 x=1767790742; bh=jE4Z1v+9u+M1KRcr+t1+kVaeG0nm9oeur0xOwYkes8o=; b=
	WeBeXJAmUhgVE/04X6ksjfBcUMcZkYo/tO9YWZfETP60iLC5F3lFCOL+h8xc0qtL
	i+zF4pRg3X/m79lnK4BF8oWEljY/nbtQXNKUNQuU19wqw5JPYC7FvI4pPGxXCdE1
	AES4bT7CcVNcAer7ujkOnmf/SgvEnV7fFJ9mopJPua0xTiIGii08CisBJdZgp/iw
	db5P4NOvEkPlLuLUUWa4iDUbBljXft4YwZxt4va9kcUsn3VfretaL2RmEijC17Vu
	9h2x7erzZvH0lGPNokUFyID8YD/m9NNFi1GfmqvwaDgKnhjtzgYV0G6sGLcG3rPC
	S4aXbyxBgu24RgAoRRN+zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767704342; x=
	1767790742; bh=jE4Z1v+9u+M1KRcr+t1+kVaeG0nm9oeur0xOwYkes8o=; b=t
	j9lL5NAuJ7skvjwlENocLKChieckb9S890BeIjImh6d3sk1hyILOIlPwcSNcHyMO
	TLKLrQOJ2UuG5d0q3mijh28rGHnXKnikQfN4VB2CC3/gN6JDZj19z8U0P9piEZK1
	cWGUN7AxWppxkchAgfS5Bec0Dv8BfoklL1o8R6piKLGBG7LnmME9keU8hN4TNNwO
	47jOGnhfxdwSkKTKlW7pVO949Fz88Ft3WqZ9pCyJViGrWzU8ifQDDf2sHAPKHS5H
	6km5eppG+jyt8mxNHoiP2W1zWtTIkEBTieQuT0hm0VB2032s6r5SOmTXvqnXX+w2
	HN1UOjz0G8ZED5FNBoOdg==
X-ME-Sender: <xms:FQddadM3Ospa-akhTqrh4B2rrx2BkjvmNy6s-6d7NfWovXGiJ3X_jQ>
    <xme:FQddaW8XpDxSGRVCDWjq4wbDQqUEa0IaWvrytALYManGoNMrDiVO10c_2yYFy_MZt
    hWSMPUvXPe5r3WY_MB0KbwWUWOcIFgKkbIAtU5GQG2v_fVHwVlNZg>
X-ME-Received: <xmr:FQddaRTCKYnT6PnRZ5m0XnypJ8tph8kDWjQXEa0k5WadbWszqTxviZzYt6TiKbTrsUZShN9IN1JRMOEDpEyFSA41gtKZMyE3aGUBnA_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeuieejteeghfdufeefieevffegleegveeuieffteetiefhieejleeftdefudfhgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgtohhmmhhithdqghhrrghphhdrrghuth
    honecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggt
    ohdrtghomh
X-ME-Proxy: <xmx:FQddaYmotQZJqnWs6EhAH5Ecl1mi9yMVsVABynUqcrmB-ed_AhXVNA>
    <xmx:FQddaRQOUepKsqMtbY_X-mvU6hYOnolldGKlVE-Ctd_ygATH3SyLgw>
    <xmx:FQddaWNELzhg38ygss48T04fvROF_yMNiXRSMqA7uMMNIc30rSsQqg>
    <xmx:FQddaaUjwNBR7orWq9CSrUZ_RM60is-2haALG7ahTgQI9SbCdc_0TQ>
    <xmx:FgddaUzJOJo6lfQrj9oX4Wt-00y1w3Kn8qVjnPObZfUluln2B0a46P-V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 07:59:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1cdbe1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 12:58:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] Some random object database related fixes
Date: Tue, 06 Jan 2026 13:58:48 +0100
Message-Id: <20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgHXWkC/33NQQ6CMBAF0KuYWVvTFiaAK+9hXLR0KhMVSEsaD
 eHuFhbGhXH5/+T9mSFSYIpw3M0QKHHkoc+h2O+g7Ux/JcEuZ9BSo9ISxeCsCHQ3Eznh+UlRoC9
 rI5umIF9BdmOg7ZDZ+ZJzx3Eawmt7kdTa/ltLSkhBvtQojbVYl6fxFg/8gHUq6S+u1C+uM7fO1
 xW2hMq3H74syxs0mEcZ7gAAAA==
X-Change-ID: 20251205-odb-related-fixes-5f48a0993ef7
In-Reply-To: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series fixes some small issues I've discovered while working
on some other patch series. I've decided to split it out of these
because I'm hitting the same issues in multiple series, and I don't want
those to become dependent on one another.

The patch series is built on top of f0ef5b6d9b with
ps/object-source-management at ac65c70663 (odb: handle recreation of
quarantine directories, 2025-11-19) merged into it.

Changes in v3:
  - Use `test_commit ()` so that we the same object at multiple tips.
  - Slightly reword the commit message.
  - Link to v2: https://lore.kernel.org/r/20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im

Changes in v2:
  - Drop the first commit that regards geometric repacking with promisor
    remotes. As it turns out my assertion was wrong: geometric repacks
    do and have to consider promisors, but they will fail to handle
    them. This is a bigger topic to fix though, so I'll rather want to
    move this into a separate patch series.
  - Tighten tests a bit for the commit-graph generation.
  - Stop referring to a "subsequent" commit that doesn't exist.
  - Link to v1: https://lore.kernel.org/r/20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      builtin/gc: fix condition for whether to write commit graphs
      odb: properly close sources before freeing them

 builtin/gc.c           |  8 +++++---
 odb.c                  |  2 +-
 t/t7900-maintenance.sh | 25 +++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

Range-diff versus v2:

1:  564b26fa6b ! 1:  3ef6ea3560 builtin/gc: fix condition for whether to write commit graphs
    @@ Commit message
         establish the proper border at which the auto-condition would be
         fulfilled. As it turns out, there's another bug: if an object is at the
         tip of any reference we don't mark it as seen. Consequently, if it is
    -    reachable via any other reference, we'd count that object twice.
    +    the tip of or reachable via another ref, we'd count that object multiple
    +    times.
     
         Fix both of these bugs so that we properly count objects without leaking
         any memory.
    @@ t/t7900-maintenance.sh: test_expect_success 'commit-graph auto condition' '
     +	(
     +		cd repo &&
     +		git config set maintenance.auto false &&
    -+		git commit --allow-empty -m initial &&
    ++		test_commit initial &&
     +		git switch --create feature &&
    -+		git commit --allow-empty -m feature-1 &&
    -+		git commit --allow-empty -m feature-2 &&
    ++		test_commit feature-1 &&
    ++		test_commit feature-2 &&
     +		git switch - &&
    -+		git commit --allow-empty -m main-1 &&
    -+		git commit --allow-empty -m main-2 &&
    ++		test_commit main-1 &&
    ++		test_commit main-2 &&
     +		git merge feature &&
     +
    -+		# We have 6 commit, none of which are covered by a commit
    ++		# We have 6 commits, none of which are covered by a commit
     +		# graph. So this must be the boundary at which we start to
     +		# perform maintenance.
     +		test_must_fail git -c maintenance.commit-graph.auto=7 \
2:  20bb4741eb = 2:  55cad3ea0f odb: properly close sources before freeing them

---
base-commit: 2797238193944b52d12624a04a962f40b9bcad69
change-id: 20251205-odb-related-fixes-5f48a0993ef7

