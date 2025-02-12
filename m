Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C51FBC8D
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394981; cv=none; b=Kt5LnPM/rZ3Y1AjplQ9S0TyML3SVAAsAWoZmxSJHIVQRpti0jADsVuwhngtrSfR9wB55RXs9sSLZ49CELaEXQrNYcwvqjXA8ADWZErWsD/cpb0A96QFdZnFX1Tx/5BjzuOfim8wnyCsFLrS631vw9Lg6vubJbzClWZx4wtoYHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394981; c=relaxed/simple;
	bh=DrPVAZbNnoFfQ9ujPkuVy5xkOne4zdhTnaJAqGbbiyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nuwopYSQJxSzGl96/ww4nQ7PCbvy4Y/TZw36D5gmNNc737WK0uuv3fDS8rwgHGSm1SiCRC2d+aIVs1BbC9OuMymF5e1WGsIshdshGyqB2pQyo4m7VE/cldOAB6YD3ZEZT6uhc4cQt+f4ZwwIRuV9JJ+pwk1tE35gAZYqNFNc3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qH3dDYXI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AlQcdFg7; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qH3dDYXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AlQcdFg7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 498BD1140171;
	Wed, 12 Feb 2025 16:16:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 12 Feb 2025 16:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739394978; x=1739481378; bh=DrPVAZbNno
	FfQ9ujPkuVy5xkOne4zdhTnaJAqGbbiyA=; b=qH3dDYXIWmLPgYnBfNs8LNG8vn
	m68yuFyGvMUKNlCzgpLwdL4ng/CXnJQB96mD5fP+NHSisGtxMl457CuccveAid0t
	KgX882VALqYSN2UVSJ1etMFxcrD7wkYlPrCg3B6XY7d3DW4v2kVOMEmY0YGgrbsA
	ZfdJOFu9RKKAoT068XkPZDRJXtJXl6Y605oWsFfvy+Wr9fpMnkFve2MRDXhtVqXW
	aw+PugxaiSEf0jPXWROcMwyFivg9V0DkXRqVpeY0efJb8vI6Aaz87MPd+X/VEwPI
	eeijlrSeAgIbNoi3hosedQRvBja7o7aYpLkTVRYBhvPz8qGkimV9levJG51g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739394978; x=1739481378; bh=DrPVAZbNnoFfQ9ujPkuVy5xkOne4zdhTnaJ
	AqGbbiyA=; b=AlQcdFg77Eo+6Um1Zc5FQZwC5aiFw49bbazcoNKRF/qnPhAw0pk
	+JmzAxuCwMkXN31KlFedtB1ohMCPnFhlgq05HOejGQZjM3oZusXuG7YUWYK0SGBr
	EGdvy9+oCBUfhpj6PZdOHflaAhd73172GeHFuykau6I7Nwj8vEDNdX6dK2QXlQHl
	wa5MRY9llaHLtwfd6E0GGMopAVBABqmlxGW5CxDIFtzKTbAx3kGyad492+HBoTri
	TE/rTlaQj3Q0QYy+ujg2YM9GuCuwCU1Igdy3nDKZXJxlWj6Z0SQVUHI8Q3wdE2+t
	L67TLXiwIdFkmOFwhtTGOWWhP41/fE3l6aw==
X-ME-Sender: <xms:oQ-tZzHKFWutaL1dkrlZtgGlrGyEx9y5hkqVGWXG9IdNIqQv5eA9oA>
    <xme:oQ-tZwU5EVc8JEX9FEDPNNSDeZ7HQAuAnpzJgYeOb1QSvsZt4pj0zlBJAlMa1aJXZ
    3TmPcPMngjKh_x51w>
X-ME-Received: <xmr:oQ-tZ1IdjGlTl0T_fCrnCmsYaq26vEa_DPGcKITf4wc8ZBuJDHoXBTcurZ0z53FhqYUp16jC8F1w_FfmjfzztgvMaR17rCrKB_xDwy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepughhrghrieduheelheesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:oQ-tZxGUezvU53EyCPXMehXVn82j7rr5VcfkVCWJcE9_3UhWdCtIOQ>
    <xmx:og-tZ5UVldTkaINoJ-_Xall1Kba8IIeHDOdDJ7QgI3JqHX9BvLCg3g>
    <xmx:og-tZ8OqIBEpgXmPt1r3AOAdBCqhuxrJhGPyljxooq7wM9K54AZdCA>
    <xmx:og-tZ414tZwooW0PTHqQJOdNaL9Y1b8p2DoZ31zBO2QiMhyUWRETAw>
    <xmx:og-tZ8SFHDCdp-5Swi6aIY4pF-H1QX9CVcAosgdNRKzbmxz8Q8ugOYpT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 16:16:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] [GSOC]  Use unsigned type for bit flags in
 commit-reach.c
In-Reply-To: <20250212192841.8321-1-dhar61595@gmail.com> (Moumita's message of
	"Thu, 13 Feb 2025 00:58:39 +0530")
References: <20250212192841.8321-1-dhar61595@gmail.com>
Date: Wed, 12 Feb 2025 13:16:16 -0800
Message-ID: <xmqqfrkiuan3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moumita <dhar61595@gmail.com> writes:

> The `flags` variable holds multiple bitwise flags (PARENT1,
> PARENT2, STALE),these flags are defined using (1u << N), so maybe
> there will be no issues if it is changed from `int` to `unsigned
> int`

"This change will not break" is not a good reason to make the
change, though, as not making that change will not break anything,
either.

If you need to write something, say something that positively
justifies the change, explaining readers why it is a good thing to
do, and how the resulting code is _better_ than the original.

Thanks.

