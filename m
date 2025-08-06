Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6C221269
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519891; cv=none; b=Duy6oA1ltDNnsfHIN6JInI3Rl9sb9UNaYXuQOxGwrLbM8I3QR+EbVknlDGHtGcyOop752uV/b8BksB416iUhRXKou98IkDEKOtSKXEa5rcehfqTjudq+E6gOtC6SxTSAfAXSCqDryiVXsFItiwIgxP/8kfDBhPR0O53Zz5M+a7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519891; c=relaxed/simple;
	bh=ayK6AO2dKTDBRRjT/aJ0B7iIOk0cSNh7HPdylkT6hu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPL2cpczIbi+5Kje79wgX/GPzTJxOiaAhO5tHCDtuk3EpxITEStNk6UwYWc4hM+trElDGzrpuq4hdD9uZAdldVSWos6bQ+KeeaQ3EM2BhnYUMriDOxTWueEL/5s3/KVqSSik1v9Eo9CI4eyxJk+g4wF2kPB9QjlOpdDrlRaoZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hSrUU39m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZnmKLShy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hSrUU39m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZnmKLShy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DE5111D000F4;
	Wed,  6 Aug 2025 18:38:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 06 Aug 2025 18:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754519887; x=1754606287; bh=91XwpMg9bc
	fI/i/twZr9Bf+GkwP0j7IcFoqzGDTCUNQ=; b=hSrUU39m2hbwalqbxFMiqK3x1U
	eGRjR1wa0fxPcbZSA0i3KzJ3ghdh7R3E/b313X59ao6JW2n30WAjJWZLHArULqb5
	Rpog6LfQpDGlXBhCseMOkLkY0BCe3dHLVX/V6IvsIu3HpwxSUquVQIh0A9dWJUgZ
	BYwZBsEp2FFtaoHIjYaGH07w6pLVWjIIUyZM8BfLFyGqbZCbwxzEDQmEyvZi/ue2
	HOxfMkcp0mklmTTIzbCLlHzYn/ZZfKGsZ7PIAoMSdFwLt1aH5DyxQvdK2Sq8kpA+
	ngvzNdoupTGhPjwaj3uhEMEci7VWb3puN0v7Htv6+mrfqZSa9kD8qAF8P/9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754519887; x=1754606287; bh=91XwpMg9bcfI/i/twZr9Bf+GkwP0j7IcFoq
	zGDTCUNQ=; b=ZnmKLShynxr2oRLRSO8hRdbd3/d510SdvPGpSA1gU6Z9M6rKZfP
	5lPhRJCquO0y/saB8qI8oQYWsPyCc1kCheBF0PIG7Skbdh04p3j+8PDJPKdidMDq
	ZoEgohw5ilLdMh8VPlajd++iJ/ObivR3Em6OA2TiYKEcMAbk/U+L9lBT3gXv0koW
	7ODstG72q0TJ6jqkj4qFCDSr52NwpLvNu/mmu2tluUf1Adw3jjo9EHIOB3k7u16i
	c3NFvukp95/K+MGxGtZcj0tHcBAj6NJipWJKG8YvgcVHC1WyaghnixB3fM3rrJNO
	dntDbPazEN/Id0PDEeCo8ciUn5Qa4nw9CqQ==
X-ME-Sender: <xms:TtmTaLbVoNxaWnEdGk0A9ITwYYOgmBrHEYAPM_IITpPehiuoaCVZqQ>
    <xme:TtmTaDDGkj9ETrxl7XvR8z0bPyiY4PtRSqfpyykDnq9yu7E0r6nLwdajN0JjYyMgJ
    SN222TKiwZBw2w7kA>
X-ME-Received: <xmr:TtmTaFZVsjrH7nl5IACl7cRKgzWx3OB1-aZ-QdEvk0dbyVcfzxAA826WzuL6RqTPW_4bUhbBRZGRLsRMloucMk9DbKvb3aTrbAZDcxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:TtmTaLm0rEUo5ZQYShy89CkR_ALORXmL3Sz0gGuntd4sv5Y6JqiW3Q>
    <xmx:TtmTaKqTpJptwAkYkXOZNux53cCSTTmfLuo-PFSHYldvURl_ivJuCQ>
    <xmx:TtmTaNDUxgnp_9jLxJsX4vd-IQ_o5g-1SEGviVm4ittG9ZIJvdl6mg>
    <xmx:TtmTaNG5SY9SffiA3LYdZ0wOXz2JIJmNJifvUJAmm05iDFbUZBgmtw>
    <xmx:T9mTaD3ZBpxFJq_EwsH9-nThXwICjDti7VcGm_xTsOqs13p_NZOgf1nj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 18:38:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  oswald.buddenhagen@gmx.de,  ps@pks.im,
  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v8 0/5] repo: add new command for retrieving
 repository info
In-Reply-To: <20250806195537.93302-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Wed, 6 Aug 2025 16:55:32 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250806195537.93302-1-lucasseikioshiro@gmail.com>
Date: Wed, 06 Aug 2025 15:38:05 -0700
Message-ID: <xmqqbjost6sy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi again!
>
> This 8th version of `git-repo` basically address minor issues from the 7th
> version:
>
> - A test wasn't passing in the CI because it assumed that the ref
>   format was files by default. I fixed that.
>
> - t0450 wasn't passing because the documentation didn't match the
>   usage string. I fixed that.
>
> - A test generated the output and the expected value but wasn't
>   comparing them. I also fixed that.
>
> - strbuf management: now we have two strbufs for printing values:
>   one for unquoted values and other for quoted values
>
> - Test codestyle: now it's ending test case liness with \ instead of
>   open strings
>
> - Documentation: this version documents that we escape the value in
>   the `keyvalue` format.

Thanks for these updates.  Will replace and merge to 'seen'.
