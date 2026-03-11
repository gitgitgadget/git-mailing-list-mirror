Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FD30EF8F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249517; cv=none; b=se760jDAu+BoFqCTKptcrU/QFRCOTFbL9DX3VGuJRFAQ/afHNB01lP6pGXKBre4s4rw7q+x5QFoygafCdsREGhLDH/WL7qgRnRZg2bY3UHxIKMVh1tFistX/kGgWtV8LIvn/IZnlTzwDM/3co7D4Xwq1xrxtgeACbonC7nkJsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249517; c=relaxed/simple;
	bh=Siz6S3XtMN+NwgxOL3cjWA5Xul7vRP91Zxd3K6WTLTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uIISpJ+NHvtOao7s/CxDlY4ifNUCioTdZ8U6iQn1oOn1eF+hVoVuGvJRV9ZYja+9GXVEO0z276d11No82ewh6CSpp7loYq5iW3WcsI3zYiHkQb2fCEoil9+MGg3ILjW0rBcEiTV+psV8TAKhP2mLIiz1iVIokH6hIT7iCo5mlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WnKJFfbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKiiqbZU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WnKJFfbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKiiqbZU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8ED5EEC0648;
	Wed, 11 Mar 2026 13:18:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 13:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773249515; x=1773335915; bh=TCg10Mo0sP
	0xO18tn/lSLQ4/LuM2zXUcfxPLAn6MiPo=; b=WnKJFfbsZsAJX+gvik91u2Naid
	8UcoIwfMEAEkOkNPpBQ7JZK73YxCqJhH9SMr6ubg/kbsuIB40OpIXFykqhnDYOBF
	Q0Ki1bx/eunedxq3mnNb1ZV4fpl/JgrjAEywzbHTQ5cg/ayf6Pq2ELfSpK8Nj/O9
	WPKkISykhcWPfUI9fqewaCrRGrcYaEfnhvzOm2kOEMpSV1Pgk/I1T/7qrG1hLZHZ
	75ZUWGw1ieyTGk955hbrbsRetjeqiA1YQpxeu6R39A/K8t8m87bZwFlvCg7QlDxY
	dLQB0cTtPT/2yTVo683exm2KltFFTZDt6JK5tu5f6oz+uaUnoi7DZBZ+a5jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773249515; x=1773335915; bh=TCg10Mo0sP0xO18tn/lSLQ4/LuM2zXUcfxP
	LAn6MiPo=; b=aKiiqbZUqYIS24QVIoc0737DlLpL4s8YBljspSSmcdX5xxXbX6p
	p4DodxSYHjBpyoq/9OoE8QRc6WpPB3NuhTaKsu2ohHC0YU0VA4UjLJ6aF/n9WXRF
	vp8U6ly1ILQXsKy0cO7VfpFaJIOnaYCQno2UN7+4dvHRkMfCzxIOmY1NerrAWTn5
	3dX1s0I+mYwu4P93imGd9O+EFwy+AY+/luJmNuQS4WdIU+j/KgM6tpRvCA3Nd/5h
	ot30e26MwAUa3b1JB+ZNYOJoMDeEikizyg21Rks46fNrj5G0b9u/CtBCfMxuxLZt
	Q3G8LLUWeiLOMtv2G2tn6+uqtnMHRxIi2mA==
X-ME-Sender: <xms:66OxaVPcuqyKadRqO9a8xMs7kEYQMXV8oyNLuDss8rJDFUAISefIBg>
    <xme:66OxaTf0GCfQu_WloRqXJP8FPh1zRG5wtJlopPwSctvQlKL3MlsMOCOxIUSqNGqkQ
    GfoXtVY7QVIEQWCFmOQpQy85crPSPCp548NyGGYvw3vDKGUZPRF5g>
X-ME-Received: <xmr:66OxaauPXmuOLyOzYDZhs_BzO3JhCtE7wO8X_HUueebthUt_NZ2L9DgTdVfHbbCHediW-Ho1YoWUJaL_B3CGICuoY76jZxy-bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeggeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:66OxacmKEJ13ofN6xZTaWcVoxtW_30o8wU2SMrKkGMj9GfUYVNsJCQ>
    <xmx:66OxaUwHBADkMNgB6RYIzfYHyQF8rxXAZjPwgYERK_CFF1wQHcdvKQ>
    <xmx:66OxaWOrjpiSR4mS4yh4HkjExgrTH5nFYrIHq-wofz9AfIcH6Ivm0Q>
    <xmx:66OxaYosb_No4Ma-wtV7ch0Y99cAbkT92mDTSz0BMx86_2z-Axyv8w>
    <xmx:66Oxaa9gHsPL1t0K2bTgV_4RfrSW5aXNLJIXFayJWPZ56u236w2Y5llS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 13:18:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
In-Reply-To: <3fb4baf7-a820-401d-815b-a0b7c11fe6c3@gmail.com> (Phillip Wood's
	message of "Wed, 11 Mar 2026 10:32:50 +0000")
References: <cover.1772837832.git.mroik@delayed.space>
	<cover.1772839973.git.mroik@delayed.space>
	<c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
	<6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com>
	<xmqqikb3ws3e.fsf@gitster.g>
	<3fb4baf7-a820-401d-815b-a0b7c11fe6c3@gmail.com>
Date: Wed, 11 Mar 2026 10:18:33 -0700
Message-ID: <xmqqa4weqo7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/03/2026 16:45, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>>> Possible values:
>>>>     - commitListFormat is set but no string is passed: it will default to
>>>>       "[%(count)/%(total)] %s"
>>>
>>> It is unusual for an empty config value to mean something different from
>>> it not being set. The reason for this is that it allows
>>>
>>>       git -c config.key some-command
>>>
>>> to act as though config.key was not set.
>> 
>> That syntax is the same as setting config.key=true; disabling the
>> feature triggered by config.key is quite counter-intuitive, isn't
>> it?
>
> I'd forgotten about the boolean case, I was thinking about an empty or 
> missing value clearing multi-valued keys which is quite common I think. 

Yes, "git -c config.list= -c config.list=one -c config.list=two cmd"
would defeat list-valued config.list defined in /etc/gitconfig and
~/.gitconfig and then use a list with only "one" and "two" on it.
Configuration variables like push.pushOption, merge.suppressDest,
remote.<name>.url, etc. all use this convention.

The form without '=' is a valueless true that I do not think is used
for such "clear the list", though.
