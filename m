Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0E1373
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066805; cv=none; b=LYnohX59zrxLtOUCDisAM7VG/E+6qJWRWnK2fheJeIThNlg1GeVYBCn49h7pnTn4EPrzUpuOa3aqLME8b+V9HFJo71u2Jne8c2y8z70x5XWe9+Mw5avpt0Lms3bokkjfZFWWv6IJPgoRtqBS+FJl7RN8qfC7QnfQzQaJ2fngK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066805; c=relaxed/simple;
	bh=el+4cGTFKKUDKVkXf1bS2tcxQ8Kk2+NDU+dC7dYoYDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DmNGguBZXTXpcM5vs6RG3vl39XIKVxfmpBC7/8M48No8W84JabH6oV1dPX2iEn3dnqmgsZhDHWftR7stcIErFHYXYuirwhi6JwGtLdPaslQVCDmna7crm4i5HfjC3N9UOimobchpULY7Kj/aYaSfu3ipOYVcfKAssByw+2SfkCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KQzCPZDe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEBJC3rK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KQzCPZDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEBJC3rK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2CF4F7A004F;
	Tue, 21 Oct 2025 13:13:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 21 Oct 2025 13:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761066802; x=1761153202; bh=el+4cGTFKK
	UDKVkXf1bS2tcxQ8Kk2+NDU+dC7dYoYDY=; b=KQzCPZDe8SvQj6N+OrCmInc0qU
	JqgRlfaipTs00PalvfliP/bkBk9y4+PEgNgu4VTI1G2aCwsEWgIHAPTZUzyv5b+p
	20h0XaPLtWkHNhN+7ua4QpWFcu38M32CP+0ZATd0GJA524Ph4xVXE3Tfi1I7I44T
	ny0aVMeMgwQ5UVQk3zd3ZEX328O/+JhKD7bwf0xjHxWFD3Ky8Ky5rk8NKfD3FF+A
	KvU8IIRs4e1PDue8PtlrcMgWz4tGCymKAh7mFGSVwfxfa2PlehzpWzphI3lqggkG
	v8LQ+KTq22S/v4RjGgFcxlNh0BDBVcbCP9zuxGc0ErqMgANaGeIgtJnvruFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761066802; x=1761153202; bh=el+4cGTFKKUDKVkXf1bS2tcxQ8Kk2+NDU+d
	C7dYoYDY=; b=NEBJC3rKsULQkLOYBCT5LiYcrIJi76H8YdugstXvRzcOKVUdgm5
	hUL1w20T0Z3UQAfpfOTHc3HjCsUcchEsp9lqfWCzfDh7XEGjzWdhLeiZj4nbsU/M
	M/HXLNqt46pPQafvCctOLirlVPRdPhlDBuOatUxC7Ldjuwj0ant133Oc/KVEIkkZ
	6z31S2MlUd35R9yhecSM29m8URKzE9QQm28O74Qwcpz/8SeV1/TuzvT9LeG3RHYm
	lKh3Au4+xWr/dNKZ4Qf2O12S+UOjdPkMbowc78NmaQ/9Bze2GW1VhifSs/v2KEw9
	T0NS/ePAGErs7yx+aQmd9tbwvP4mWtBSicQ==
X-ME-Sender: <xms:Mb_3aAggkUhk4a-dGfG5bhx1I8_V2dNiT6JIIjm6oqjHV_fkMkfXOA>
    <xme:Mb_3aMsUY7eRuNuBMnx2ZxhC7yVpVbx1sic_pujJC6i0ZsaK0XML5_IrvkCxthyJ0
    _Ysd3ttBlbZYrWoqrzI_oAUWW4Ysozs2eDq3fcRpuk2EoBuxF7f2I4>
X-ME-Received: <xmr:Mb_3aB6XxZdqbgfWZ1zn4UxPCfYQhiQbF5tzH39jz3hjWfA2G11gVTN-wyt1T9SSaybdEbTSPCK_MdKZyhvJHjZ1X547p5_k-NBC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehushhmrg
    hnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Mb_3aIO7e1y-WUztZeFKSxm991cALtB4qBJM-o0d8chC50FT3sOAKg>
    <xmx:Mb_3aPtXYGgHsEDjoPqalLTmhpvSEzJPgPYmTD6Gx2IdO3Nv20IbaQ>
    <xmx:Mb_3aLYWpVSPGVd0glSlnkX2YUiInLgLhvH2G-I3t9B8k-6S2vqU8A>
    <xmx:Mb_3aBymgi7bo9OZXmh0Kb1CqvcbnUrlZ4To3G06XPqQDNeLEfImLQ>
    <xmx:Mr_3aGRKZ4qqGzrwhM_PGQzVVz2Lw9MaXioPv9-Tb1qAG1UdydCcey1L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 13:13:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  usmanakinyemi202@gmail.com,  kristofferhaugsbakk@fastmail.com
Subject: Re: [Outreachy PATCH v4 0/2] do not use strbuf_split*()
In-Reply-To: <CAD=f0L-9e0uYv-T6HYkCFAWPa57y44PXV0Xi8S5MfHQVgnYUAw@mail.gmail.com>
	(Bello Olamide's message of "Tue, 21 Oct 2025 11:19:53 +0100")
References: <cover.1760997183.git.belkid98@gmail.com>
	<CAP8UFD3sxU=r-zVmM7xL84qEsDL6cFUceAV4np6uLxFTVOnWXQ@mail.gmail.com>
	<CAD=f0L-9e0uYv-T6HYkCFAWPa57y44PXV0Xi8S5MfHQVgnYUAw@mail.gmail.com>
Date: Tue, 21 Oct 2025 10:13:20 -0700
Message-ID: <xmqqikg8w53j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bello Olamide <belkid98@gmail.com> writes:

>> > Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) for example,
>> > in the series, notes that abbrev_oid_in_line() takes one line of rebase
>> > todo list and splits tokens out of this line using strbuf_split_max().
>> > However, no simultanous edits that take advantage of the strbuf API take
>> > place but the tokens are merely used as pieces of strings.
>>
>> I am not sure taking this commit as an example is really useful now
>> that the string_list_split*() functions are not used in your series
>> anymore. Maybe you can find a more relevant example commit in Junio's
>> series?
>>
>> [...]
>
> Okay. Thank you. I will take a closer look at the series and look for
> a more suitable
> reference.

Thanks Christian for lending us very sharp eyes.

What we do in these patches now is closer in spirit to d6fd08bd
(sub-process: do not use strbuf_split*(), 2025-07-31), I think, in
that we do not split things into an array of strbuf, and instead
parse things out in place as much as possible.
