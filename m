Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7B19F464
	for <git@vger.kernel.org>; Fri, 30 May 2025 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622537; cv=none; b=PtTSNbl1VQJ7MH7S40RD6otWlbD/4iihbilfacQEtDHlMSpZhYCYKqPmapqzPWgRzVXUlcMYQ0aN0jIth8rrRZrShNEKHYhcs+pEWDkTlqF80g94BAulqF+Qk406M/11yh5pF7gw1ErdIl2yimx5cOTqTGCKETzOxeesb5JUzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622537; c=relaxed/simple;
	bh=HCby5s8sZctP269rpmNtnHZVb9AFQG2Je4jpn5XOqBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxHDvyE9TVTarbHHSvfChAf3iW5NnzykuRIKv8eIQw0PSIm1M8h0p3ksaAed34e3RBozE4QpYGVjEwRu0nxHh8CpL+eIXcApE2HAXb1a/w1L0W1gnYoV6GrmjXGVbZERLRYcPfuhDCCUEcGyqGK9lYSAUcoWtMwgtMuuQJthp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u29C826N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmuvloEB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u29C826N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmuvloEB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D60502540119;
	Fri, 30 May 2025 12:28:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 30 May 2025 12:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748622533; x=1748708933; bh=HCby5s8sZc
	tP269rpmNtnHZVb9AFQG2Je4jpn5XOqBo=; b=u29C826NpR1D4+Y26prBQt8uy2
	4qKFmda9m3CQ1CuivC70VeWw0/EbVZvNOmSjpuE3xosOrKO56aziDBv0k4G3ZtBK
	8+MtAIskeK7dHfjb8BbTzYyoTWlJdPa4kMt+hU1WCZi4QqaK1yWRgV58p7lXW4+z
	r3FtyM3CmUV4pazFPzysiiEpm4PnJnfnRpAgU2ecKOYcylGMGW+TPGkgHvX/Wb2W
	k9+oeaBxAc28ef66ltkSBLxoewVH/KGbzGF9gU3I+NaOpuSKF0PoYM0KWyT8l/aB
	bkq19XECX6ZPZiA+Aht3E0OokD5H+M3stpS+E6XHMj1V+7dMqDKip0/jCX5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748622533; x=1748708933; bh=HCby5s8sZctP269rpmNtnHZVb9AFQG2Je4j
	pn5XOqBo=; b=gmuvloEBujGIUlIJ80eFE2wZfl5WpFo9xISiIyBNO+Iekypbkyu
	ciNercTNFPQ/nXtsxc8J4MxE8kIepXQISYWgf/KTTM7Z59N7HKrq/X7SMOEY5y/s
	BixPelGZw05Dwb+/dDdvyV+FdKqDbYHLXJO8rS+Hgdnhuz5V5lJoKD+M3fD70q1L
	AbKVhzQhFCJgo+wJ1c4QLmrJfewqSSrtEPAbt4dCiyzLTMYOONc+S/ZqYIDHqCDe
	yT/hm8s/VyNzEVhMSNjcEO3Bym34y0g9i2Og6fNvMy24rcBBOAUw66RkB6cxbxne
	xl9mbKFdhE1UcjeTFT7Y4gNAV//+cLG+E2Q==
X-ME-Sender: <xms:xdw5aJxd5A-HYJF201tF9rMc8iJZtWNJ_nCfMBZ18KnGZdiHHHiADQ>
    <xme:xdw5aJQfHMxYQv5dWedMhp0CFDqgMDODBzn2Tl3TLROwtAuylTjBvMh8pVB4xlllv
    DEQ-vQafO84CFR1sg>
X-ME-Received: <xmr:xdw5aDXCKJhuwqNg2nLU7RE7deXqZEr2DSVO0CYF3iDZQwgbMCMl4zJa3TcRoDo8DbaThL1KaMCn7Rd0BGcdElT88wP8D-Hzi4eS_II>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleegkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrshgsvggtkhgvrhesnhgv
    gigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:xdw5aLi6lau1ORU87WhV8U0uglC4MU2HSjavcka2GBvoB2NAZebjvQ>
    <xmx:xdw5aLCUZYIoR6xJaCrd1_8K10bt7aAiOQOscJG91sYrXxz6K7q6GQ>
    <xmx:xdw5aEIL_fuV4H79XjUiXGB4U4WB7HWfxtY9XMo01X5DKpIjNkW2cA>
    <xmx:xdw5aKCoULK1vGjSue8fZ8qAEjyxg6KtR5ekr8ZgZ1b2Ansmw3MmUg>
    <xmx:xdw5aNuuZy-JfLor7KaCTYps7KlpVYcft_wOxcOeveA90STPYt0_D0w4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 12:28:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,  git@vger.kernel.org,  "Randall S. Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
In-Reply-To: <aDlwsM_18nYB2MOr@pks.im> (Patrick Steinhardt's message of "Fri,
	30 May 2025 10:47:44 +0200")
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
	<20250529101136.16219-1-carenas@gmail.com>
	<xmqqtt53l7cl.fsf@gitster.g> <aDlDtbUcX5NA8wCK@pks.im>
	<20250530062533.GA1321283@coredump.intra.peff.net>
	<aDlwsM_18nYB2MOr@pks.im>
Date: Fri, 30 May 2025 09:28:51 -0700
Message-ID: <xmqqsekmf4fw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Ah, that's something I missed when introducing `REFTABLE_UNUSED`.
> With that added context the patch looks sensible to me. Thanks!

OK, let's fast-track the fix down to 'master' before '-rc1', then.

Thanks, all.
