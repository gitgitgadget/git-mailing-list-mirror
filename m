Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EE035B656
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930396; cv=none; b=AK6y/pVO2NemSTJQPcuLT+0+2CqXFBf1i9rtgSGbIz7gKdKBlnmUn8kOdSop+s/u69DlsKNIHfYuLau1eLV7REHn+UHWILKRPthugPfYA3Tuu/PoUmmmHztpTh3jWZIypUUde47quNs+u7nZyhHzxkuCHQg++pMzyq4GOGFFvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930396; c=relaxed/simple;
	bh=URCUtRPl4Ol9drGIPbenVJOvr7c6hk2EtQ7VIyM4D+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m3bLUVf5/rwPKDWmlSUbv7r3R/aGM6xF9LN5sza1Dbg4C9Zed3l8b/hbhcWppfS4OeCyUEaiFy6i+wmLcvSsIcr1Xh7dtoQqXuc65O68kvHh7/EseYFO8x+5xKS0q6o+Lh7qpCpe9ZWlF8KXWO8xrKPUQJ+UBpxVAAxbx0ISyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lGGinilx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmA4L4f4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lGGinilx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmA4L4f4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B566F1D00103;
	Thu, 19 Mar 2026 10:26:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 10:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773930394; x=1774016794; bh=URCUtRPl4O
	l9drGIPbenVJOvr7c6hk2EtQ7VIyM4D+0=; b=lGGinilxIaJQe6wXdDDuqL6q2S
	CURHmbmcdPRUry/zh+2OMfHaZjvL2jqDUI1CJ1WYGzYZj2U5qBw6BidTdRLzbvh8
	3KE5TAE9XAnYiLNrcnEIMq+yez8Bo1veeCAL1iTs5m4/ExElvxntJFS4JKQyO6YP
	xBaoPAjdggPNoVu9vsLT84jSj2jJqeY8B5p6L+C0bXC+CuXVARn5ozXhWazeoYYK
	M8MlPVu4sjSvqgZmGatEJ01WXm9PWOVNIex7fl1Wx5U//6C/NA+z97TV0WvvAp5q
	IzbjkUlA/+KHt/fmjSoauVVcGYixbCEC+4LOyT97TrnBykP3UkIIRSodp9GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773930394; x=1774016794; bh=URCUtRPl4Ol9drGIPbenVJOvr7c6hk2EtQ7
	VIyM4D+0=; b=HmA4L4f4R57LOYcCpmMeRY2O7NWKfCnBSUL7VYHHq8TPIjgn3ho
	TSeSTNNOQ0A3Yvp9l2lbLlTcJmd/ryL6DBXpzKPLyJ8vOJkrLYpE3W47JBBwpBjO
	xzgq48j7XByuaBM7MNsmATL9eM9sIO4Mf8eJtZYA/jOKRTqs7tU1vqQi7V0ouNYP
	/NxURxBzmiidKv/pifMLJCsCBkECeJsbw1w8obOzqh9m4bvUjF64eEhSmpg0fWje
	QNyLRbbavRDScmI99k2lWotI37buqk3J3p6Vaznlk4rbAuI5KZwdgo8++wq2g3r3
	ew2iLjXpVwXqOtIomYLa/WA2BYiskJlx5ig==
X-ME-Sender: <xms:mge8aelDLiK2Yh325AK3pbF36rQ4WLe28Owej4MXXnLrAzbILjh3tw>
    <xme:mge8adQ3VHkSe5cvu0wBUAJDVaYzC45ULNuU9Z8HaRkBuRoAgJtgcmwAfaH3nLsM1
    LoBRxqPX_WsLgUzma3EBZ29SPuZ2bgSPTBrktxTDBsYhTiTpeg5>
X-ME-Received: <xmr:mge8aaBF8tZaJS4ZHdAaJ5OR6exekft3jkQjX_XUd6vysNtwxG-N30FlOUXkfFSzqbdyK66iCByrnCIs3XYy5GWSPiyGJXLJHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:mge8acTo_weVoHcm7eG1zAMaB6xPBZNtqOQZsuyF6NPNpWd_Wh25vQ>
    <xmx:mge8aQqvJ0rg0KCEIk0LBNACcDNo0B9fhI3qfz-dcfebHqOTLsCxdg>
    <xmx:mge8aWwE8k2foeegceZUWTJaZIWUgH2Mq6lLVL_x1HjUp9Hxsv3Vew>
    <xmx:mge8adLzZ8nZQ3CWwfhLl3aJbShIUXMykpSRr7OHDycj008mxv0U6g>
    <xmx:mge8adYfTFNhCNSjSTYknut92pHLis2fXp0Xvo9k8zrfBjlUra2Zte2k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:26:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/14] object-name: backend-generic
 `repo_collect_ambiguous()`
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-7-5ddebad292b0@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Mar 2026 07:53:05 +0100")
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
	<20260319-b4-pks-odb-source-abbrev-v1-7-5ddebad292b0@pks.im>
Date: Thu, 19 Mar 2026 07:26:32 -0700
Message-ID: <xmqqo6kjnbdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> those objects to a `struct oid_array`. This can be trivially achieved
> in a generic way now that `odb_for_each_object()` has learned to yield
> only objects that much such a prefix.

"much" -> "match"?

