Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CF2E40E
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730543905; cv=none; b=H3y8KLz1Z/3ayU8yJOnsyPwsOiEyvN8KIg6dYGKPEq01Xs05oGuGUjMYh5IigrEWv/Ph3SCnM6MOYcml/VSbe+FEG/PxTEqzU3S5+1Nben22EQHppHu9lwXYVeRyvFo1EX9Dh+vImVUWqer6O2VFiOgG6KPZyOI/cIGC05ynfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730543905; c=relaxed/simple;
	bh=LKsWCPYI7st49V5/Og375rDdtjlX+oOoH5btC5tKw0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2DtEysuKc4/Cd2BYjqZ+SlK4RlQw6oRPVvGwbGcT49MPbvIwn+UX9kVh6c/08gfoVd26kx5LIZ0qfAodhoZ3tA7ePjJzbXamRl/NnLfOC8wNy9uREVqk91eqHBQ2tA+J0rxn+EG2J2Kx4PagFUKLgNvuZ8E2fAKGBkOeagPGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OW8NadAy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBGBE7m1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OW8NadAy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBGBE7m1"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 383A21380224;
	Sat,  2 Nov 2024 06:38:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 02 Nov 2024 06:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730543902;
	 x=1730630302; bh=XqtFCdx8BCOCdjvHCFsMht/oyHi42PZfDf+rDdozU/Y=; b=
	OW8NadAyUT5hFKqvYgaIFtPwHHQM5Z8SKc4BerDBoEHO74chZrcQaTF7nBfnwk6v
	U+qecZHjFHYdLy0z4hMQTRYFbyPhrfKFnlLGLNzq/uz2PaK/QltEOlAE8B/0TNBH
	meaM9JVQCCdm1blH47LrYMIB3qt8Npk7gxoXiHtcrIy8QEgHYRkJ8mUDFoq4Wdw4
	65engGO2pSrakIvmko0nrJF7KuucKOk3JmhxTj02YOD9NhvP69Ybd+zyxp3Ueq+F
	RZ+T0aXNNypUymorKLDrO10CkSJkTcGf/sXv9Uqw9ukb1uzq9wrLUccqHwIGWMX7
	LY1GzKyH5xRqyitK425Ldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730543902; x=
	1730630302; bh=XqtFCdx8BCOCdjvHCFsMht/oyHi42PZfDf+rDdozU/Y=; b=X
	BGBE7m1HhKTuCO6IR+4mvdQqQGDxMmq0PCXSG97UJ0ogh5Js8wJJSjMpcJrlLolC
	FcHphxByaEtsUGz1AoquHDCG0VB2JCgRLCJ2FQsykohofoQ9koyclR55RyHUFQEG
	sso8LBZROdNm83BmuP5jPq2Zdb/U0PIjvWCpmpiJxVl4Ai00ZvRpBUKo/nyT7mDN
	sx8bfCJtiXZG32AtdeDGMUjdbyToTKTqi+apo78JWFqQKf2c40Ih+EE/FIfxourn
	ZvpeBmxeTmFHdzsN99woNRA6YssxMgYI4Zm1+Gn13Km0mmKD3u+ZZ5ArM2Pdrb8u
	uYUVf9qIfKZwv+xYyCikA==
X-ME-Sender: <xms:HQEmZwb3VYx5o3nK_ummjShld5zXaD5_J3EgP70SPFkBwhRjwO3MTQ>
    <xme:HQEmZ7atBzIDu9wf8PhO00AwcxXy4JFCVSYE76H1lEX22KL72e0fT8HaFM1aS5gXJ
    znTPLuqCb0WVA1z6Q>
X-ME-Received: <xmr:HQEmZ6_SfiLqsFRp72m2-Iuqoebz2kqfEjsYHLl8566w1qGP2UbN2BXkIdRcLYJfvgW0dq_k_SzMUdsyUQt0ozY4YqaGOAczHJXN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeluddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptd
    ffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehhrghnhi
    grnhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehjohhnrght
    hhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HQEmZ6pagOGeVd7s78HK6qMIXcGfdjs4YAneK0yZTz5t2gQRbR7n2Q>
    <xmx:HQEmZ7oaF5JJjsLeEs6RWdHC7BNxHtCqv3Ani5O2bpKXh2RMhnLmmA>
    <xmx:HQEmZ4QZOGbw4rA1V1jScLANPo2rCiLNRJjlsM5lgLPJR8zRaeoG1g>
    <xmx:HQEmZ7oGHV0E0QFAOAGZvxVcHBCmuBU2wBq7XMSNwANUjfYmX1YoGQ>
    <xmx:HgEmZ8cp5yeC1quhIvNmUG9Uw3Rj_lgaPTJ1V0haibGUhVKvM83VFbPW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 06:38:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Han Young <hanyang.tony@bytedance.com>,  Jonathan Tan
 <jonathantanmy@google.com>,  git@vger.kernel.org,  calvinwan@google.com
Subject: Re: [External] [PATCH 0/5] When fetching from a promisor remote,
 repack local objects referenced
In-Reply-To: <ZxwIhDsM+19nAZkT@nand.local> (Taylor Blau's message of "Fri, 25
	Oct 2024 17:07:16 -0400")
References: <cover.1729792911.git.jonathantanmy@google.com>
	<CAG1j3zHXThL_JXP=9xqvg=wg0R1wZYnA-okfFxqmcUQ9w0M36g@mail.gmail.com>
	<ZxwIhDsM+19nAZkT@nand.local>
Date: Sat, 02 Nov 2024 03:38:20 -0700
Message-ID: <xmqqwmhlyl7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Oct 25, 2024 at 02:04:21PM +0800, Han Young wrote:
>> On Fri, Oct 25, 2024 at 2:09 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>> >
>> > This is a polished version of [1], also with all the test failures
>> > debugged and addressed.
>>
>> Thanks! I think I can drop my "repack all" patches now. :)
>
> Thanks for saying so, I dropped the 'hy/partial-repack-fix' branch from
> my tree.

I'll drop the topic, together with its "Need review." comment, from
the "What's Cooking" draft, then.  Thanks, all.

JTan's 4-patch series should be queued instead, I presume, which
I'll look into next.



