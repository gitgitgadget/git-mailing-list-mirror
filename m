Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A7259C
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753571725; cv=none; b=sVZzob6QqRRj/l85JCY1mCZ+z41ueppRFmbIpUvEjIx9Y7LbjFXtTjZXEjKb/+Gc2RbCMPzs/FkOTnLsKo+pDHErVXb/fnMjz5QAu//01bcCbJ+tWNx2j+VEHmJWrfes/FLKLpHMqCG+lC4H5eljBMHLxNzfIv0J0Rbj4ROjU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753571725; c=relaxed/simple;
	bh=izqJp9/er5oq1CjDdtZRm32Y7MoPryQOD0QPPwwsAZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bc7an04XCJVXVIIt2MjoSzg/QJ3IIEY6xF/TbezOUvmkeM8ExrPeP4ctaSrQpzJKvr9J45XCWnYlrCZPZTxvA+8bfdJpFoyjWr+uJv5nYyE9kW6jWx2Pd8obmqxlYb5Pn3a4ZcsBL+/HTerf6TXxS+07vjvNAoOn568E6GH2Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IOf2WaCD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rvrt7uA9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IOf2WaCD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rvrt7uA9"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A80214000F0;
	Sat, 26 Jul 2025 19:15:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 26 Jul 2025 19:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753571722; x=1753658122; bh=4T+zAtjBbF
	PvEcF1OpVZoZdYJeH2IL4tUVGhHFTHp9U=; b=IOf2WaCDM5qVCaq2UFuHECUFZY
	Ks69l89RH8d30RMxLgbHQbhUZ64J4r5/YHHoyASScP7rI3xMcniXhrETCVprXjfY
	eHz5z+qJY7UkUV9qjO1K4YWY1OLCcZW6404UNfHfe3ciaVcinGN5qeKvD9j18HN4
	mEIcp/adCtwad0WOiVBZtsYVkDjGXpL1EGQ6KNRnKtcWlnb/gGFN/vMg/6BfGUcJ
	RHOh2KIIcBgorS82ue8GBQ5xCvHHxyq5ntFQXGHdtAwVLqYzTamr1vCU15HfkTKa
	WkDrHmvuNrzGZZ6FOfcOSw//MjsU6I3BMpK8wk/hXvb7A192nEIvR/URWeKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753571722; x=1753658122; bh=4T+zAtjBbFPvEcF1OpVZoZdYJeH2IL4tUVG
	hHFTHp9U=; b=Rvrt7uA91DBjXiXfwbnp6hYLv7bVCnm2ZYDVbPH6etu/vvGtq+d
	9RyLrtONOgEwV+xHX70htv2l4ZZNAufU8klkUY3dKcPi/eQeQwan4RbpSfY2+/iP
	sUL9z+ARjjK5GW8ZvALfdVz3ONYiUxAlrhK5FkBdr5eP7qQEl/uZ4NHpXCa7BuCq
	jet/E00Bi59E15L4nWwlSHe5ql/XDecyQhqk8Vsi1m+szwBV4FQs+IDMt8d+YXbw
	BVQeYkGVSMylwCIlsRds9QHHgCKTDeCHiRuGtdCpWcs7HYYKOu3+orXsknJs0xQM
	itvWjWfc56Rh+MGcGVxHO3t6yWlEDFE0OFQ==
X-ME-Sender: <xms:imGFaHfHWCnCcQ798qK8nKDiHIcTau5piFuD4LJGGMljLCPMbYrbVA>
    <xme:imGFaItqyBTnZ_LdXTURYS-8kIoi9Hdj8oqW0u0FbDyDSkKReCe3mehHgT6HzHHs4
    yYITc8JDLcXNR4i1A>
X-ME-Received: <xmr:imGFaG9p0zDWVUviGZv6zwov_2hsvnktAy-6GBZIdAPEpmiYi68wTGf84QoVv0LeQukcwpeW-LPtnw2KgGOnnxeGKKHmn0T7047aCK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekjeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:imGFaD1bJ2QyAX883eQdpNhEUtZzf9q5w7T_HZA_0KFp-Bf4HtSKqg>
    <xmx:imGFaLAA8waLj3YpQinx5tAp6Xe53xytGbu1ZqKyTcuQ8DCLc3ppcg>
    <xmx:imGFaPeyjuDmT_L-cOf39b3A6KsXVTppL3J6Nai6ozqcylSHjCTGeg>
    <xmx:imGFaI5esfb4WaTC68c7WxJA8EiexsAMLescMxpegG4KjJkQu5ELkA>
    <xmx:imGFaPMqpJB-CYwHIp26FLVk-RMz_Gk7lyA6oRy58gCAJ0Y-hge549fR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 19:15:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document test balloons in flight
In-Reply-To: <m1seily1e3.fsf@gmail.com> (Collin Funk's message of "Thu, 24 Jul
	2025 09:55:16 -0700")
References: <xmqqldoen5v3.fsf@gitster.g> <xmqqecu6n1pt.fsf@gitster.g>
	<aIHY-PXYYzE8JULj@pks.im> <xmqqms8tilvs.fsf@gitster.g>
	<m1seily1e3.fsf@gmail.com>
Date: Sat, 26 Jul 2025 16:15:21 -0700
Message-ID: <xmqqcy9m1r3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

>> So the only effect it would have is to smoke out truly slow platform
>> maintainers; if their users are happy enough with such slow upgrade,
>> they have lived and they can live with versions of Git that are
>> years stale that we no longer care about.
>
>
> For what it is worth, Gnulib and threfore Coreutils, among others, began
> using compound literals in 2017 and it seems to have not caused any
> problems [1]. Even 'pcc' supports them.

Thanks.  Our worry however includes platforms outside the Open
Source and/or Free Software ecosystem, which would not be helped
very much.

