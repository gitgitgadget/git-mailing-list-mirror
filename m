Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219A558BA
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990889; cv=none; b=DX66bfj3u8swmVpGl0+XYpgMJi0r71CAeRvvExWH9NoiNF5CKRIYyR55hp9MyQzNhFXlruR90X5X0BaH++FeOmx3ZCbQtQLrW8Z0J8L3XSo3XVzfKHY+ZMvbo9eYiBy+tye5OeqG3s2RxAXTLdIfNRh1XUegDJJ9jK9zhIUHtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990889; c=relaxed/simple;
	bh=pGmJmhBYpkAPX6ii9f8hnC6t6zft0XF2cXHtif6AM2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aXiiG/GKYUEgIdFWB+cjbfozOiR24fa4FoYKODB3cO1JOsv5lLtl/isY5n8zTBIWrt7Q3fCoP+vQY5De0gbIWtKtVzOULmApHEFKxpFINWk03/ItBM/ah1JSC1OHA8IM+sNFhdLKeScqZcmmEVRwJgxKq/FqG3C0vTDZIg7N+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uE5alUC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iiRGUGAL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uE5alUC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iiRGUGAL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 880FD25400E9;
	Thu, 12 Dec 2024 03:08:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 12 Dec 2024 03:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733990885; x=1734077285; bh=pnNrhn5cPg
	QFuJsr5ozMY4gqCqorxRjDG9MloheVVSs=; b=uE5alUC1XnQgESiIsN0hdigj0S
	TFsJ0tnndvilh/fbCv7YXt914/CMbaJXIGX+UCw63wRL6ohoV+aafw/RGKGElTjp
	+RGpz2NYR3guDTOWxd8SXtHtArZc3zFHrhHkUe/tgDScKev/YfuaOHQ5t1xorCZ/
	n14vtxLcTBp20pSrCrX+NTaEKQTz5f9BsQz+KiDqLfwhPrXb825AxZeE5G46t5Ow
	fJGCFr1bEWKe6kGj+SlF5yHs33whs4c5scr/ExWxDgT3r7Vu2MCK1PFYblAb3Wpo
	StEW9DPsdkGKMqwE7WEwLBoEhTOIunViQbo8btynN0BvPsKTdHDlXQU2j6cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733990885; x=1734077285; bh=pnNrhn5cPgQFuJsr5ozMY4gqCqorxRjDG9M
	loheVVSs=; b=iiRGUGALHPwn4G9FAvrV6rSndRT+qYwwwXAsxXAPAItO9Pz2tfO
	5deK9wZNf6+8ZAAMy7faR2nLmhVxtfjLM3E7iplhO63Lz0bUlG/oPjbQ2f6zImiR
	zcSTbGL8Ax/zQzl8hDVocjRrNqTFp9CIMMIkKHMiyf4t0oSGXm/WuOn/uaGMkHv/
	EuBGXHbocTi8XYU7VRuPv+i7z9MNuIll9yOFcoiqkHvvJL6nVCoMFdSEPGFgf7Be
	aSbj91kNfFURBedPgJXx4ehw60lutNUuKn9+5WmuGGyX4mxseVwBhu6rnWPUjD6z
	afVEcINuXpVYoF4qX9S44DxoYuOWhW0s62w==
X-ME-Sender: <xms:5JlaZ_VExwOJo9guf_MAgi4cg-gKbC9-zPxYcl1C9PJ1h_5mo34Dyg>
    <xme:5JlaZ3mWnvOiVGe6Gb3BCOjDE1-XUaE7CZy4MiudCqryrIod3TLcgKHc1oSD5zr9H
    R2CSnADk_7cnZcPyA>
X-ME-Received: <xmr:5JlaZ7Yfo9Kcqepdcpc0NvgPVOmfxWR_14pL0Ofitw6EAhjVt_0rG61QEzGtXknkiAiiJA0PVbQPwnG9DP1CETk_KqhwKXDLx0hnG74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5JlaZ6VwnZIVJ0i51AdOBJI3eE_nAlnqCOCpeF0zgPzLpYCPZo_FEg>
    <xmx:5JlaZ5n4nAohpVvmNleVNREuXqSTlOKTZp8-vC1WOopKdpImLynhWA>
    <xmx:5JlaZ3frIeg8Z6jpkKRxiwPU89aIw3tRWI2dLkqMK1fAaq5g5jYR4A>
    <xmx:5JlaZzG9TwaY-E1azUdJW_YM_IADBgV0H0gC-dtwRSq-isbTa28K9g>
    <xmx:5ZlaZyBhz3IYRtbIsWv3dQBekBYF6Thq4TbvYdh0c-uQtCeSssyznzXU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 03:08:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] bundle: remove unneeded code
In-Reply-To: <87y10mhrfe.fsf@iotcl.com> (Toon Claes's message of "Wed, 11 Dec
	2024 21:53:57 +0100")
References: <20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com>
	<xmqqcyhyi7g7.fsf@gitster.g> <87y10mhrfe.fsf@iotcl.com>
Date: Thu, 12 Dec 2024 17:08:02 +0900
Message-ID: <xmqqldwlfhnh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> #               false &&
>> #               test_cmp expect actual
>> #
>> 1..17
>>
>> What's the "false" doing here?
>
> I'm terribly sorry, how sloppy of me.

Heh, let's not over-react (applies on both sides; I should also have
stopped, took a deep breath, possibly try to remove it and see if it
makes sense myself, before asking that question in a hostile tone,
sorry).  Mistakes happen.

> I added that during debugging to
> be able to inspect the t/trash* directory. This shouldn't have made it
> to the final patch. My apologies, I've submitted v3 which doesn't
> include that line.

Thanks, will replace.
