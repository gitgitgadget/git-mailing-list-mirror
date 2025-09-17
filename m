Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0EF34BA20
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125789; cv=none; b=Nty5odr0SVk5yyNr3XsKm1bDKVOouwPCy2RNblnYQD3f0wmCVMcrijUeIwn3jZ2aLB/yJl+FqpymfniXTwxE+9GAy4rl2RhI6dY4d6I4PszMVa6QvT7nft0vBFKyM3fp9OyJ93+xZSLDOcagMVe6vz64v8NfJ2ZMjEc9iw0MH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125789; c=relaxed/simple;
	bh=7wH8+e93+Av+/ACnf3r635Ac7OjX1StWY2BUTfqbP8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXcKY5X9KYwuu2v4CtTA/tPNfYoHsnvrOJILb9YRBZACd5hzeECuQCpunwVW6uXv19wd8RSkaz4h1H+tDyczXKVkcxBlw+zYhzhx+JI37O+7Hr08gZ3Nq7WR0daQgU8P9hjQS29s+nhSj8q23MtYcmG9bKKI1UPYYlKrKC/y55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j8uN5xS0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTzRd1C2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j8uN5xS0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTzRd1C2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2F5B14000FE;
	Wed, 17 Sep 2025 12:16:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 12:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758125785; x=1758212185; bh=ESuureFIrJ
	8d907awRCs4KJcWV/FlXCG3BK2f+kk5lo=; b=j8uN5xS0u9tTjDm6um+RVdWU2U
	vSgtyUT+k2iA9QHdp+uLEbD04QY3VX3T2x7gS03lEPqGwWJsk4WuApMRYXPEpZai
	70ixbFYmt2Jbh/ejWEaVkk8nx/ZhTbl4e+D09VDvToLn1oVnYdHtLfJs2mfZOg+5
	4TgE5aTkJs+QxDfLONu3XWOiI2M/4PbqtypsfuzoFly6yh0hjqprHTwWV6O7RRfn
	jzpDUca6obkaP7juNWPOiN6OndYe69/np16t2nFRSaf5l4fT2uV0vAPlN9Z+A+/W
	8LwSQgjKnrmS8d9Oub+TxZC+QqITcNilCzl3GH0PcEa43dXdx0bnhAgvzrYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758125785; x=1758212185; bh=ESuureFIrJ8d907awRCs4KJcWV/FlXCG3BK
	2f+kk5lo=; b=BTzRd1C2Xxc68iSRces4RguOZe01ZKGxt5+5VL4cwbTS+3KtktB
	d3M4xaT/ocGlW4CAbtrdjb1zZQb7uxk2BGat9bi46552j+WvHbCOzpBJ5YOabgJ0
	KlwXadnqv1ylRDdKZQHcD4aLno6phubo3HhEKycSoul+KKbPPNjo75otWTnzN9vR
	FDlhm/im7Fp7uSxc9VKb0djkeb/GK0lUeelNU1VTLCpYrEk0UG/1ZgxADCf7tP7I
	pnT5JpdFiFec6TNJEkH9mPSOtZXY3grWTMGSIeGsk3iLW7Oqrythd6lN0piPd0pQ
	di3o3iwiBC1b0+fLYHngCuAAic0bO8cbtJg==
X-ME-Sender: <xms:2d7KaHYIwmORgsuxhZSTPFRjctXumORwJ0Ff-eVzP6_PcIyO_9gM0Q>
    <xme:2d7KaD96Q9k43oQYZ0_TUDWQgJKWNAVtcR248kx5FqCTlKkC2SrHPxukRvFVL18DI
    TF8XUwqc5lWpEjRTA>
X-ME-Received: <xmr:2d7KaAYVUwSWn6vBOQCnK3aZg8xpeZPda6GRCz0bc3OVcrFpnNBHeniD8WJc1-jexMbTQ0-WMl7YA-nIMH-k8kjE1Qg826EuWdAfELM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehhuhgrnhhgshgvnhefieehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2d7KaPMrgFlyX8yQjL-f_T49-oYZk7aTOcO-TPg5dUJ6sxwwgGvRTA>
    <xmx:2d7KaEBoYNMU5K1aljZhbHPCa05hkbNWsELR3fSQmpnWulfbBAzyxQ>
    <xmx:2d7KaOI-kKwakBRBa03maFIdJlHYmwF4GgxAVY_-kbRVlDhViShyPw>
    <xmx:2d7KaFPNqpQf7Hp8YK1sdHCq1nS7ztgsMviCLaa7wnRMVAge_kg75A>
    <xmx:2d7KaNAAJruihBhcqUBOtRHNtwUgjItTffGRL-Mj7jxbZjmPX6yYm4zf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 12:16:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch
 name to "main"
In-Reply-To: <xmqq7bxxf6kk.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	17 Sep 2025 08:21:31 -0700")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1757518141.git.phillip.wood@dunelm.org.uk>
	<xmqq4itarqfd.fsf@gitster.g> <xmqqv7lhigb7.fsf@gitster.g>
	<70fa7537-3b89-4c3b-9dea-5a7ea0174a9d@gmail.com>
	<xmqq7bxxf6kk.fsf@gitster.g>
Date: Wed, 17 Sep 2025 09:16:23 -0700
Message-ID: <xmqqsegldpgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> That does make it more in line in spirit with what your
> "breaking-changes: switch default branch to main" does here.
> Instead of assuming that we won't have "no default set" hint after
> 3.0, we do assume the "no default set" hint will be there and
> squelch for a bit longer.

I'll do only this one, and revert the other test changes that are
now mostly stylistic clean-ups.

One thing that may be worth commenting on is this part (which also I
reverted as irrelevant to get the 3.0 change going).

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index df0040b9ac..c7f39248e0 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -562,9 +562,9 @@ test_expect_success 'init warns about invalid init.defaultObjectFormat' '
 	test_when_finished "rm -rf repo" &&
 	test_config_global init.defaultObjectFormat garbage &&
 
-	echo "warning: unknown hash algorithm ${SQ}garbage${SQ}" >expect &&
+	expect="warning: unknown hash algorithm ${SQ}garbage${SQ}" &&
 	git init repo 2>err &&
-	test_cmp expect err &&
+	test_grep "$expect" err &&
 
 	git -C repo rev-parse --show-object-format >actual &&
 	echo $GIT_DEFAULT_HASH >expected &&

I think in the longer run, a change like this that makes us check
only what we care about (i.e., "do we warn about unknown hash
algo?"), without assuming more than necessary (i.e., "we shouldn't
get any other warnings or hints, or this check with test_cmp that
expects an exact match will fail), is a good thing.  

Perhaps a #leftoverbit material.

Thanks.

