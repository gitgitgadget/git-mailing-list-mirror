Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42C7F9
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194442; cv=none; b=JpYC04+AlBL6iHKxLVKdDTWG+pisl5W7sL4gcFCgqZ6LPVznxEVRMugQwN6KOASZHREoSoETofqpqAWDFTaDDEdGbOVTl1p4jLH8FiDEKwOuUuYX5QnflPYziKGCWBouQM5+hMhQEtcsjrVz9sYLc+iH7zcsUNOPSE/+s7l3kZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194442; c=relaxed/simple;
	bh=VJpNyf+fNT2Y3RIMgbqPnJLQWIWXmnpsD/sHt+nfYVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9EusSIh8swpJ4pKNRwkEDnDhLBCrs619PPhzKRPY6Uihwo8bQ6nqChwHaGmuxtA3LmmpaWWo1nX7vO6+rqYXBeQIalzJksMsA1hAzOiImdXz+OhPjjRMNdjaSMK49r704H+Xd9N+NJm0BC6PVYsjSqdoQgsXVC/QMCeVLb6A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SEC7YdWK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9TSrCrB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SEC7YdWK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9TSrCrB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDFEA14001AE;
	Tue, 22 Jul 2025 10:27:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 22 Jul 2025 10:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753194438;
	 x=1753280838; bh=R6Aby3N9V+LLibFyHvL5y0UKxIIinxCpC9GW5arUeYw=; b=
	SEC7YdWKdqh8qZPVDT+grK+2gcIpvsaBNVPkTj8/CYWBzdgDgckiJCUE0ieqanN0
	crwhqaXD+OphXo545xy5FeE+XgrNV2KWVTn9NP8rfYVvCwRHWqRKGis+QrXhW6Da
	z9KUOPGQ6z5qRJBmmhv0I8v/T6bsGZWPnCGoGF0EwAVFl0ZiWV+fhIt3XPfe/f+V
	cyVOYloAXQkjdXIkAIzS36gV339e2V0/qT7QeEuTlCBYUvL5LgG5tlpe1Z/t+lkP
	AQYiGRaf+TvHJV8q0wi/7la1NirtXM5MAgYIR1mO+Tohgo41WfnL2lttTo7d5SY6
	lMckXh/e5N0PqLZ23tzbTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753194438; x=
	1753280838; bh=R6Aby3N9V+LLibFyHvL5y0UKxIIinxCpC9GW5arUeYw=; b=J
	9TSrCrBfcI7UmGzV/iUBKPeohWyTGSNabBf4YANgqCJQjJTvIblpUDWVTFH3nYFq
	WZQ+ReoM13iI6pUwUqTSrRhYODBjeQQrKrJ1HDYr8fywrkezrJEWeMXjfDK/ebeS
	VByKdtZP5DCU5RynwJG+NQ5lRB5MAvLPLWrkmjf2/5tnf1J4syxVcEHg4H9eOHKt
	Qwwfq1NX9JjJpHrPOw7zmdLy9O32Opry8CaW4vw8HY6oixdISrFb/6kX18CRwc22
	K/8Nt0IQrcXh5MGmnxJBTCafRNfcjLAuLReGiiDtcSNGl5bTCi1epTB8AFobeopY
	92r/k8gFU1wSWe7X5noAg==
X-ME-Sender: <xms:xp9_aBr20OPyh9p8jLvqG-DE7Ny4jrf5TpX5nDgFNyzVx3pL8AM5Ow>
    <xme:xp9_aMF_z3Hg3EPpwRztwqkJMMWWscUgRuV24Xwo0cXkLuLzwZ27eOqVOJQYmHYP4
    PB65gRN4JUz-BAVKw>
X-ME-Received: <xmr:xp9_aOo6-umPL4Ilwt6uHM5yaGRKN0aiJdFoVwskS46YTvWS0yDheyjVgFQiUfeFFli9ua4bhnnHnoQLOIKsruqzdT392xLBfufC9nY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xp9_aNYgpxIO8-7a19xcEBA5oQw-Lktn2fohSwAjfKBO4l66wU2qHw>
    <xmx:xp9_aPVdIYHRZh9hjc9Z9GlvTE1ZFJ_JLDO-n3SO42Ye-9T8RluwBg>
    <xmx:xp9_aO-VgxdQxdiYp8iX0XDHonp0zz2RvkLq6l7Jbx7A2q0IKbT5rw>
    <xmx:xp9_aA-V3bSPvlmfWlBYeZbuLgQ7D1kfFxTTq8n_YYfUPVYVGi_Jdg>
    <xmx:xp9_aBU3Qn1sOChML5FG0rfdJJwrKFbSX1O-bsNjD0dO6ALII09zomyv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 10:27:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Git List <git@vger.kernel.org>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/3] commit: convert pop_most_recent_commit() to
 prio_queue
In-Reply-To: <aH8vKQa7z313w1RG@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Tue,
	22 Jul 2025 08:26:49 +0200")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
	<8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
	<aH8vKQa7z313w1RG@szeder.dev>
Date: Tue, 22 Jul 2025 07:27:17 -0700
Message-ID: <xmqqikjkuwqi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>   $ git log --topo-order --reverse --oneline -3 e436bc94f3
>   36554bf51a commit: convert pop_most_recent_commit() to prio_queue
>   304f06e0c0 commit: use prio_queue_replace() in pop_most_recent_commit(),MIME-Version: 1.0
>   e436bc94f3 prio-queue: add prio_queue_replace()

Funny.  Thanks for spotting.
