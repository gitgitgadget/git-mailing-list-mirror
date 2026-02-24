Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783771DDA24
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971681; cv=none; b=Xd4U0o64H+R4UHADNlOolCC8+y8/NGVkpQV2l2GymhcMfojMm7SMEHWCsxuyTLk65JpHQ16eVDl/+L31VhVCTlHVB/owQ7g1HJm0Q5tBPfHCSjoqlQ+TJHl6H4f5oCN5ocs3H//hFRNpUocr3Umc+4oGd88Xaw3CO8qbPKuI1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971681; c=relaxed/simple;
	bh=7LlUc96GrlI03gB7Z33dpuB9EVU2t0ffUeLDdVO4gAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l31EkOQ3DWvXCMNse0n1BMVTNp0ikmTxieWwzPA7qfoU8yGmsu4m7vgPMyUHVoC6RwkjxZV3puIK91Leo5anH8s8cnTvNYDnFvdARxluja4AmS59gE44iXtQiV61XyYftU9APjwRFaXN0NvJbJO0zt3CceVA2ftaNXBlHWeGk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RF7nlkhO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhlKwbtR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RF7nlkhO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhlKwbtR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57C327A0278;
	Tue, 24 Feb 2026 17:21:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771971679; x=1772058079; bh=gctTTu8mHq
	hHrohS/4B49xB3TCDFKRq/9IGd1mobrCg=; b=RF7nlkhOtpnIr9J4hU0locoxkj
	WpHoOSjepy8q6FpbQlJB/dwBTMs7zLvB53ht+GGaD4QuhFlppxQvb5dZ+7DxmKUo
	kxhEuzrlMqeoyBHN41YF7D0kUEYOU2utSV7kCictfu8QXtbrmR5BIRjaksOlH2KT
	mxVjdX0SkaG6OxsVpjIBYZqGyD2pqMnaHD9FaRZHd/tGhu7ml3IwLLvHW5/hJXsW
	kCtNZlAaRRVTS+1dgqjo24ROQC0qR/JxEuF8nTin3gaCuQa+BcSX282DmWOF1A0d
	VLMfHrPpintrBwSIggT1MuW2xOAKxP76Uh9kikDzqqZVpdpO1Vz2FvKk3qSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771971679; x=1772058079; bh=gctTTu8mHqhHrohS/4B49xB3TCDFKRq/9IG
	d1mobrCg=; b=JhlKwbtRwf1oOHQU5LmDnf4v+EEDoTmV23jkLP217xLuaitgNOx
	A13Nj/otuj7e2YIerrWp3J+xTaL3oPrxD+vHN18HkuvJ7L5cVGBuTV/cBZGxeiks
	kQVc20hSiPDXIbNcwspvY6L77Z5+aQnSc8HMiYE1SY2U4pwD8A6rkPytArfcbmeM
	5857whFl4aMkrif4CbpdXv3fk66JyXab8wSsJLugJfO2GQMkpzJqIH9AJ+hJwILW
	Rvyi/HWIKyDMJi++lDBqiV5ZhNcmY6DnDa01Y2zu+CSXvtaFcws0kzEK9BF0RUoa
	Zqpei73LLHgiSOgc0RZKydrUWsf+vgkTr1w==
X-ME-Sender: <xms:XySeaTS7Xbr7kdzNL-aV4OX_rGOS2k4GYoEx8N-vfbPccoONHTCnXw>
    <xme:XySeabpTNldVYLf-lqGxSLsmZ314Oe5NFmkC8cR22CodfN6uS-BVcd60-uglQO16h
    3RVfcqiQ9RhM86NE06ywJzoYErQy2LwZAtDYJz0y8vdQ1kV5jEKAQ>
X-ME-Received: <xmr:XySeaRJV5Q_3WWH0hD8wrih4X6wqAFGbRbvQyB5A1vbjPjMCl5cUGuM1elc4g7unelopwk1mFrbvXYV6olSMCnjpKbPMOAqTAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:XySeaeqOTF0PQ_9wTacA8ijy9oNy5VyHDAzq7sV41eM2RApb0DL_7g>
    <xmx:XySeaZzSzGKuZVBt-10-vxTZukbB8SR9xOvKyO3J_k89K5fRT-IAWA>
    <xmx:XySeaSMuOoqjYX9uam0y4z67CMVPCTehrpI6nJdLOkTAhiu2TkiYyg>
    <xmx:XySeae5etlhScxU72GXKm7uyEsdGU41yhcx2hIgzr9-ZUGb5j61HZA>
    <xmx:XySeabKUymsTQKLJJybb77U5jEdKptEQXA7mRUT0yx7EjOfj0IK3jz55>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:21:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  gitgitgadget@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260223133034.GD215671@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 23 Feb 2026 08:30:34 -0500")
References: <067978dd0946732e00e4805d62ea51348fbf336e.1769112471.git.gitgitgadget@gmail.com>
	<20260221080201.7847-1-haraldnordgren@gmail.com>
	<xmqqwm06rp6p.fsf@gitster.g>
	<20260223133034.GD215671@coredump.intra.peff.net>
Date: Tue, 24 Feb 2026 14:21:17 -0800
Message-ID: <xmqqms0xeqaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So what about this. We add a config option that takes a list of items to
> compare against. But it _only_ supports @{upstream} and @{push} for now,
> and interprets them as branch@{upstream} and branch@{push} (but probably
> done manually, not via dwim_ref). That limitation gets documented.

Sounds like a good way forward.

> Then later, if we choose to allow resolving arbitrary refs via
> dwim_ref(), we can add that support on top:
>
>   - rather than manually resolving @{upstream}, quietly rewrite it to
>     branch@{upstream}. This is OK since branchless @{upstream} makes no
>     sense in this context.
>
>   - otherwise, pass what the user gives us to repo_dwim_ref()
>
>   - optionally allow substitution via %s or similar. Technically I think
>     "%" is allowed in a ref. I think that's probably OK in practice,
>     though if we want to be really careful, then "[branch]" or something
>     that's forbidden in the ref format would be a possible substitution.
>
> But if we stop short of all of that today, we don't have to worry about
> all of those weird corner cases I dug up in the earlier thread. And if
> nobody ever _really_ cares about sticking arbitrary refs into their
> compare-list, then we just never go there.

;-).
