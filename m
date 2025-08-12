Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448E2EB5D8
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009443; cv=none; b=X0OEKond0Y0AjNQZlpmJGe4pyCuSoquo3Fbfnvl1WBCf7COWYCTb2cX3J3wFB4B5xVVr0osCrHZZBYw6X0DU/VGR9aNAcLwRw+0+KxQIwUfP6P3eUFCdSJp1rTHRu/h44Hz6Rz6kTjQd9sFlIKezPYv9o2wNij1fCoLiQzJWy8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009443; c=relaxed/simple;
	bh=hit6nN8HzYTlBmspDHFg4rku0bzinMY9x0CwjwNA8B0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfqyibpeUK3hOIg7HBcQqJfLUc8uXJkvaAO+gDaxBpiQ7A5aTuoGNQkKoIHjHgdNcnKT4vVIKtE1ua2lZhfzt1iRO4hXoyjTVkrABt0Vx+vijLR/hc3vBYcBIfmr3gc26dqcSbxhZ+EEbdIKlHliOaU+3pQM4j0+3odtcUP/cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kWs7Hd7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3Cbp9tg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kWs7Hd7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3Cbp9tg"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FBCB1400171;
	Tue, 12 Aug 2025 10:37:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 12 Aug 2025 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755009440; x=1755095840; bh=+oXOp6Fs5N
	0dSeepwLoeV7wUTx8ge+KHKNtM3dCCQOU=; b=kWs7Hd7AZBXXwwaDbbs2zC77sr
	tZKGmnY6qSvvokqemNFYda52eKiyDZCGPf2dYaW6vBpDqr3JkzhDCXKx0RSY8hLg
	7x7B8XsMwzCfFA6NIVJ3j/+AlmwOlxOBOLIUrhov9MJj9SLlQxwrxmhizq7tXNtu
	K+Lx5OYVRVaFYtDDFRkNj2sC3vHAfz8V+0v60EZKz1Ramm9hHsZJLCRoItPCudMe
	+1sP2FXoyAAmrHajCcpoNrJcJKDxR6Igk8lUaPi9P+vh9YkvCe5JBTkMSRRwRc+F
	ti+kptogfri383pi5xaEg77wkLu89NUK5jTHqpbkUBX9qEVbXmZ4JRilEFeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755009440; x=1755095840; bh=+oXOp6Fs5N0dSeepwLoeV7wUTx8ge+KHKNt
	M3dCCQOU=; b=D3Cbp9tg7x57Ty9QfC0JdiNluHKcaxSXzXP2L6ZJhMq2Mt0ErCk
	esIr7zLjA43ZuxbzD3i4TP2H29rrcVrQzO7LbyTDdaMv9WRsdJ51Z2vVWrsZ9RXP
	UjT+ZGhcPpUGL3TCnjms5W6XCJqFkYkozbMnywweVELLZMdF1LPwvEeQ05XVj21M
	WmVUJp+U6EJXQ9q0fwhP3MTVBQpjOKJ1OpPo01LxyJbT0MVNzC9hV+Qusolpl55m
	K+XeVvpXCWTX6aK3euTBHtm6+HJhOdKsBRqGWARs6P0nMR3RhWNyYtsSQdeyUgDu
	TEWGdUfGZD3OLffLujOIIEb9swYMGmaKQRg==
X-ME-Sender: <xms:oFGbaBjVBL-PS4Rt6whF8hGc5J_etBgw3ybpQKIYvHS3o6xk0OGhpg>
    <xme:oFGbaBjetJGPf2bFXh1-BGA4AGwFh_0IMIo5RK78zKOSPLNxNr8MZzqZLb6GvQLQx
    Nu2UpNcs1uLDwXYxg>
X-ME-Received: <xmr:oFGbaHhKTZ1n5D5qZiYqQMcNQL6RiIqscOIukObStkQ_bsV6D6UhF3RH7jjj8Px7TvI26ovmi3z5EI3s2rljNwJ-3YVqrfSl83YI2tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghrvg
    hnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oFGbaBJChlZaYesfDxZRvbmXuK43k9xsxYtXr5rX2roW7oZal4jdmw>
    <xmx:oFGbaGGnGv8ccaJ18o7hWYWfNg5AYMFiPD3NCeg4baIBr6X2AMldLA>
    <xmx:oFGbaFSyX1IoFk20Dn8M244Xxueyy0HZELRjvxePF5nfnN4Jg3Scsw>
    <xmx:oFGbaCen10E38SeeS0RJpj927ruXAtIB_hD1QlY34-rF5Fxlcl8x4Q>
    <xmx:oFGbaEfCmP0ZiO3YuUGxYSzWMMaamQPM-0BSqa9sIFGWtToizlQXmTe6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 10:37:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Carlo Arenas <carenas@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/stack: fix compiler warning due to missing
 braces
In-Reply-To: <aJsJE3UzKIVeg3di@pks.im> (Patrick Steinhardt's message of "Tue,
	12 Aug 2025 11:27:47 +0200")
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
	<20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
	<CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>
	<aJBNHzE3RQBZZTcU@pks.im> <xmqqwm7i527l.fsf@gitster.g>
	<aJGNaQwnd6_A0Ppw@pks.im>
	<qruwf2zjl2uvf33mp4ajklvgx7wq7ctghu53rxzbgndfojudvh@ylr4otznu2og>
	<aJsJE3UzKIVeg3di@pks.im>
Date: Tue, 12 Aug 2025 07:37:18 -0700
Message-ID: <xmqqwm78wqqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I think the suggestion for using a shim layer solution is relevant, because
>> additionally to the compatibility issues of the zero initializer, you also
>> need to take into consideration that the proposed solution will still trigger
>> warnings when compiled as C++ (where {0} should be instead {}).
>
> Do we even support compiling Git as C++?

There was an earlier effort to rename variables like "new", but I
think the motivation was more like some folks wanted to try building
with C++ compilers.  I do not know what the outcome of it was.

But people like to disect and include pieces of useful and/or
popular software in their programs within the limitation of how the
original is licensed.  Especially a part well libified like reftable
may be a good candidate.
