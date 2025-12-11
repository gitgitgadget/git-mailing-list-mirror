Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21199946A
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437610; cv=none; b=r/xqIVflM5Iky8JXQkIbxF3yrc/V/xjamOER87XKmTVvxkKoXhkYqk+5BvwltP2wLmCBap/Fqotzt/92zAuLYBW6p2mO+Ia9NDao1YrndjkdoIvBET5K1WclbOXGCrQE+zWMc5SYLLR1PdLoEZno+BWVXrTihiQ9er8hxDDSAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437610; c=relaxed/simple;
	bh=NtYZuqP2VuE03yqmisbT9+BBQzM1e9L0vHqrhkGOBhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=BtCDTjnLA8fBpFRysEicaRLs+56HZlQEydONKJ5tF5GtiFYxHB43kKns9tZOoFxZInnaELgrdiXhbc10Z1VdhEVzPOGqhgZ4wR6Ews+vCpt26pyBRgEEmcF5Fc8XsIe9RwnQ+CHM4zweixAb1MTmaZtyjP3hWR/6LBR3+RccAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sQeYBpZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Frx+ACvA; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sQeYBpZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Frx+ACvA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 3910713002AE;
	Thu, 11 Dec 2025 02:20:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 11 Dec 2025 02:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765437606;
	 x=1765444806; bh=ZVx+4i8jFMK8HR3+ClGrD4X5UfGT5nj92sjteYZaCWA=; b=
	sQeYBpZxA6dIl9wCWo2zGz/gAS5dIpOtZK1yaHCpWjQa75d3ymzneOVP6PsHW3wY
	MtcWMnQSkbePRwRBFdMSZoZ7MuYL2XsD5sSII9V0VW4T/CIJtrpByEbyrtMxKwuf
	UEmSJQXwzd5nQdUC8NpbV3KIZC7h+oafBmmyX5w3LGu9505VpJpe9JBHeKNwpd6U
	Ja/3I9OK08wwWGWwEFxA+ECRZFQC02vAdiCJmQGDfeNZLFtVcZrbGDMy1D2/LwvL
	hfa0jLTX3/YO0EWIoyxP7W9te0BxhvbDIAuT1SWSwEuyrNLaMhjF7JLXZc72Vhyi
	QYkm6Qkslxjx4Bqt/YrWWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765437606; x=
	1765444806; bh=ZVx+4i8jFMK8HR3+ClGrD4X5UfGT5nj92sjteYZaCWA=; b=F
	rx+ACvAVDqvjNlGnq3lEgMBtgjZDW6xJ68mqHDKP37NwLGZCw5nRgLemQV15lKuE
	5amLq3oKHajo3Fu/3ZPeqv+J62hoUy++oW4mesoJrwTP8Zia5z2KeEVo2uANKmgq
	LcTt4f6MZnSV+9VZ7tGdkpHD9OZmZAVNFLYP5Jx///wp0+5lBEOwrDm8B0GXM+0Z
	Ioy3TuhPxp78extrp48xNSncgBAFAB2JjlP1JU0A3sdgEk8FUoqszwZ6yHAiFRws
	SP+RkMffnwwf8FIpt72omp1rK/24gF8VJeZiAGBd/FspCA0iApl4S68LNRs8HYHD
	YdqoH50XyJl5LKJAiM1KQ==
X-ME-Sender: <xms:pXA6abZpyWwyBDPzJJD2ilsUbiLiU6YBDOF3tNx1Psxkea43AyWdIQ>
    <xme:pXA6aR1-VUA3FUv_ZRO2TkDEzcu2jrqdpDcWowKHuqXbvZIqggPa_RkCt2CKSD2Eb
    HCU110KN_3tv2EcVgmBPu12HT7JxDMN0MuDpApsfMuNEytrEdUvZwE>
X-ME-Received: <xmr:pXA6abXI7tCfRAmVEiift8C6y45dyerKKKlWlmfWiz8lewFU0WLzTU_o7_sRxegxFPx5dWTLbr3iZ-gqy7NcV_1GyAuVvejlsfH__QyCUM26>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecurfhhihhshhhinhhgqdfkkffrpghrthculdeitdejmdenuc
    fjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedv
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:pXA6abWWpGPUw9wk3V2LYU4TlzxFsuXnYiL8JOQUHu1cayn-x4LHpQ>
    <xmx:pXA6aadEuJtZGp4nckiMw3P-HXlzbqDt8sbqnNHKyWifiH6WDxWUog>
    <xmx:pXA6aUXGqAEAUvvsGVlHQuSlfGDZj6rdBNLPlHV00TWWDsGzwA1XuA>
    <xmx:pXA6aTdzbWIwOKH2Dc_f_P7e6T02CA8yLHQeZFdFayjLuHTn54FucQ>
    <xmx:pnA6aZ85B89dXhKbAfyDCRe6o--Ix4znfUZudb5JyNo24C73QNv8Ygvy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 02:20:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 37e57f58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 07:20:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] Some random object database related fixes
Date: Thu, 11 Dec 2025 08:19:57 +0100
Message-Id: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1wOmkC/32NQQ7CIBBFr9LM2jGAEFtXvYfpAmSwE7VtoCGah
 ruLPYDL93/e/xskikwJLs0GkTInnqcK6tDAbbTTnZB9ZVBCGamEwdk7jPS0K3kM/KaEJujWiq4
 7UThD9ZZIe1G161B55LTO8bNfZPlL/61liQIpaGWEdc60ul8e6cgvGEopXwwZTVqvAAAA
X-Change-ID: 20251205-odb-related-fixes-5f48a0993ef7
In-Reply-To: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.3

Hi,

this patch series fixes some small issues I've discovered while working
on some other patch series. I've decided to split it out of these
because I'm hitting the same issues in multiple series, and I don't want
those to become dependent on one another.

The patch series is built on top of f0ef5b6d9b with
ps/object-source-management at ac65c70663 (odb: handle recreation of
quarantine directories, 2025-11-19) merged into it.

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

Range-diff versus v1:

1:  5c15065406 < -:  ---------- builtin/repack: fix geometric repacks with promisor remotes
2:  2fa3991003 ! 1:  1702bf6e7f builtin/gc: fix condition for whether to write commit graphs
    @@ t/t7900-maintenance.sh: test_expect_success 'commit-graph auto condition' '
     +		git commit --allow-empty -m main-1 &&
     +		git commit --allow-empty -m main-2 &&
     +		git merge feature &&
    -+		git branch -D feature &&
     +
     +		# We have 6 commit, none of which are covered by a commit
     +		# graph. So this must be the boundary at which we start to
3:  a06d0716c3 ! 2:  7dd4e6fabe odb: properly close sources before freeing them
    @@ Metadata
      ## Commit message ##
         odb: properly close sources before freeing them
     
    -    In the next commit we are about to move the packfile store into the ODB
    -    source so that we have one store per source. This will lead to a memory
    -    leak in the following commit when reading data from a submodule via
    -    git-grep(1):
    +    It is possible to hit a memory leak when reading data from a submodule
    +    via git-grep(1):
     
           Direct leak of 192 byte(s) in 1 object(s) allocated from:
             #0 0x55555562e726 in calloc (git+0xda726)

---
base-commit: 2797238193944b52d12624a04a962f40b9bcad69
change-id: 20251205-odb-related-fixes-5f48a0993ef7

