Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0242B75E
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306659; cv=none; b=fDNqMUQni4d5RCHUunhnL16eB3I7VoYK/HH71ooCuLEI+opKKhguGxZPTbPrHIU/sfY9vgQ1PXEIGXGJs3IFjiQWBaWpZJMdu3imSqfDobWKaBKecEfIu6iZjDnELDAA0Hv2C0D2NdlAuOWA3WiWVAUNTmcilW90MWqnw9b2918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306659; c=relaxed/simple;
	bh=jlZuPl/uAmKNHaUIVkgapHxbp+QQ/tIei6enUru4044=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGzJvFlLD9HHSBL9Jj7PTOIwaLejq3FaGFMdk1C0SR7VUnfiKfNyx4Jfe26oloXkAC199WugoFU+ZSVZiOWq7jQeEUZH2RvUe+ygZED64ElNONnBfvMvZlCl4xK1qXgHt9wQlNrDbRxI1j0XmE9iPzN11lkNdmv40pJtPj1es0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j3CxebmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rib+Gtq7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j3CxebmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rib+Gtq7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 28BBA7A01B0;
	Thu,  5 Feb 2026 10:50:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Feb 2026 10:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770306657; x=1770393057; bh=TipxZ6nKgs
	pm6WZzkX511BH/43SMcnk35toko6rGF+Q=; b=j3CxebmM15zC1JDIOeWb7J2PzP
	2mzc8fHTmV7W5EYbaWfIxUMMsrHQo6TTUf2nlca+SWVcoTWsdvAIaJ9HHDcEI4i2
	XeV4Bk0yNQGMYLcgCxLy2wyvegKTu+6MjsQDiYad9Aa4U+8PRQCL0OyNRlMnFBKJ
	+7SrRGCHwvc1xfWX9OEa/GL8zDKi5diarEZ+NNyhJEx3GJ/S0qcFUbDoRrZhK8BV
	N6jEOFI3HXnOLhfXotSMWXSmBXfTWLPKYwTDBKTwQz9uiufKUfr+GypY5q36wdUf
	zugT+1AS0c3DvgjVi8LWE6zw6gNd8OwkPxX+11khtrfl8gogbW/mM5i3lPMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770306657; x=1770393057; bh=TipxZ6nKgspm6WZzkX511BH/43SMcnk35to
	ko6rGF+Q=; b=rib+Gtq7fV2QVhQo6OjOrYHDszDyjQZAd3VD5WozAu6nZhL6CSg
	4nQxZr4Vlv2v8B+ah59KYs71iOA+loAfXVg/kObu+d2qDEFs7UzujFUyFABm8OxO
	Z2fByfOyvI4cEUtwpToAHutsFSs4GlImova5q7OyU5D1s2xP24gnklvSG4dDxJg9
	A8/Zak/ukfuYReE03rMYsi6X6ua1x30Zl+6UUTCnMkq6vwqy4Du6iktjJZE1puEx
	VvUIXBpmJTxOdlnZbv+06rJPOs2tyaifC/1KemaHT/mKGQxUb2a6NfWqHngEuo21
	qn9d1hPtBMujhSbY4cztERZ8ShwMVjR5gAg==
X-ME-Sender: <xms:YbyEaYFRtO8R17AMvn_8y7Z0hTqbHYkMDHJTLvSB6e_CJlZHsnWmAQ>
    <xme:YbyEaYyRvsOnjJNANQ1Lv50vQGlZn_AuyQVZfC2h1jVCbFT2PiC7bAdCEHt5uA6tV
    FAaRGuI3YmJBUrcp-7WwnK-gFzoMaK258GerwVqTywtAfkA3Bk9_g>
X-ME-Received: <xmr:YbyEafjIdVgeDA7mCypbE64ICYaIDvnl72ohgL9t_poqd2qtM0ZMPGWjmH9LhjHSXCwKB4Q59RNeP_Lj2wK5AJdc-YmkDZZO0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehjedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:YbyEaTzlH7pfafhvZYIUok3wLW6nx4v4S5TFc7t6Hh4oiwZ2vC-jGQ>
    <xmx:YbyEaSL-Oa1gSHshiRVT57m4nztInAkAR8-YU9O3A61j5zYY4OEyqA>
    <xmx:YbyEaaRB7anWOopQ3LddTU__8KP_XfuQTcxcuDQ3EyrbQEHY1DYv7g>
    <xmx:YbyEaapUAawYxa6tAbq_SkQS53UE7NDQwsct3KMq_GgD3a57MvCjLw>
    <xmx:YbyEaY61PWFd1zxtPgybm1CbJ5NEROMYDoGhQCO45K0tQym_f1WJtbsm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 10:50:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] whitespace: symbolic links usually lack LF at the end
In-Reply-To: <aYSLP1LqBiMwur3O@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Feb 2026 13:21:19 +0100")
References: <xmqqecn0nqyt.fsf@gitster.g> <aYSLP1LqBiMwur3O@pks.im>
Date: Thu, 05 Feb 2026 07:50:55 -0800
Message-ID: <xmqqms1nmbog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'd suggest that we only disable this check in case either:
>
>   - One side doesn't exist, the other is a symbolic link.
>
>   - Both sides are a symbolic link.

Hmm.  That is indeed a thoguht.  But we do not want to complain in
text-to-symlink transition that postimage lacks the terminating LF,
so the above rules may be a good start but will need further
tweaking, I am afraid.

> Another question is whether we support symref targets that end in a
> newline. I guess the answer is going to be some form of "yes", and in
> that case we could of course loose some information. But honestly, this
> is so much of an edge case that I don't really worry about it too much.

Do we track, apply and diff any symrefs?  I thought that we do not
touch anything inside .git/ and symrefs live inside .git/refs/
(except for .git/HEAD)?
