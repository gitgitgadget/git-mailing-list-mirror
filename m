Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A512356CF
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754324921; cv=none; b=oX8gvUZ0RTb0g+HHSdzhsWgJUBVYLXKJn+DuXTWQgwzkcSytwJLEflkCzU99YQB3PvIZ5bkQxM6wNOlZupxswy4EVUKOw7rlLeb2URLvLcGu8z6ZP9/ZF2VkL18pXmzd3PFfp0kJX5Q/+Jg/gukzz+xq4aDZNDB1BbsY5g2kb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754324921; c=relaxed/simple;
	bh=q79sa8yfY17YgVdKE9Wsisj63VDpvFHIsGu6K6mXpuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tSZSEFjGfHKhvePCTfxz8NgqB7toxn6hCjG4iFGhAWqHWR+Ax7KeyZ7NW3wuGoyJhezVwcsgOHy7S1w4ppUWtBXsRVyr/soBXCXKe2ntr0EOdMoOKdpE8MVWNLNh0r4CebAGv5IqA40LuNYXDfXZfroCEi284BBTRkn52w6863I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iMdGIZkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ecvbygwp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iMdGIZkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ecvbygwp"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A44F8140015E;
	Mon,  4 Aug 2025 12:28:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 12:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754324918;
	 x=1754411318; bh=8PIaRPcDD9Rq8HQ5soDO4JK8WY1uxq6NEK7+G7qtvao=; b=
	iMdGIZkfvII6lgJBILGf8qFdKqnfU5U+xrgtAHVoR9rox+kxGTTaOMtwP+EWe0HM
	rrSJAPUp1ALbUU9PMoNg7Q2RWrJ77jl8qNnL1eX+apw/fBF7h44Jye3BXy/hn3Ol
	61H1bFofwOgY2lVd7BqA986rGxq/HzgQvuYRxkD0/zf+nF01HIhLh+WcKvaH4vjz
	rbBgNAlvn6djXQ7kloTt9v0izN1044qPZA/xFrvb2Z7uLHUswzhyLAfdJZrI3RkI
	AU8oSA3ms3p02D3Z0fcqck3bKa7WWVvlqlqeMaz8C7Ur1sYxizMTfVADxCok6Mst
	jvnG+FSnwm1z1esSnTFc6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754324918; x=
	1754411318; bh=8PIaRPcDD9Rq8HQ5soDO4JK8WY1uxq6NEK7+G7qtvao=; b=E
	cvbygwpzr2MWN9HW4M3ppi/mlrH7M6JniHJ7cW/RE85+Nshf05RQ1LKqFQeFQZLb
	wtTZLHyCUes+l4WeXQDQA+xiY4q45ldgwW0jFa/ushjedCV9QlHwWh0+NidwqwN+
	DhngOcxsSAHeHYiySlJIqS1LlobANeWOFM66cbXpJu8isjKFoGQGnVnpbixEDGQj
	jPvlwkBMr56RUwzDTcrbUiCwzzMPycCMkeSzGP5jBAR7YLlvFXstsvw7g78ctiwM
	jmvbFEZMfPhCnqBEhJGxNv3gdxPECzG0Ki7rdMa8xfDLrVJN+EOjTHLCclSy7JXL
	M2GRe5F59A45GnUUwMJLw==
X-ME-Sender: <xms:tt-QaF3lOAWpBw3K2N9e-QKWcF03xgGre1Wqv7tmP4rEQeUgEGOz8A>
    <xme:tt-QaHnJGRIUJVS9N_kOH2lsM78xm3cQ2Rmj1ireTS24zrY_E-xMLLtrC6rnszo5P
    7HL8JG6N_POrIhNkg>
X-ME-Received: <xmr:tt-QaMWoKg8D6NXZGVVCUEQ-Kvw_ab3fBh5fl7l4oiI4C7KMkkp0jkBsPM77kv14Ez0jbMh-DB94Xjj2wr0fzeg7ixoKdTzObOkL8V0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesfhhmohhrshgthhgvlhdruggvvhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhoshhtihigsegsshifrghprdhr
    uhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tt-QaNuWfGncf1TS9PQDWat72tJujeE6cQz8WSqnYpZ7RS4Exbb3tw>
    <xmx:tt-QaPZWddkIizHh5Ur9EZss3NCSQOHY3cBKW8IQt3CRHkV5ubuMcA>
    <xmx:tt-QaMVSGNj3tmoJMngZwTqAgkPzjJ1aemYOrHuYCWVQV9C84BYMuQ>
    <xmx:tt-QaER9xfdskHuLxpp0h-hYTOGW2YR2Ko4hgIvqoriAYxIpBUIoBA>
    <xmx:tt-QaHTCJsm-VTUFzsLRRhd3g4KBK8CcHqh4HE2KEZSbewA8vJswtIzK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 12:28:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: FMorschel <git@fmorschel.dev>,  git@vger.kernel.org,  "Konstantin
 Khomoutov" <kostix@bswap.ru>
Subject: Re: Feature Request: git mv --after (new flag)
In-Reply-To: <ddc841ec-bc4b-4c01-a99e-9a65af3963bc@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 04 Aug 2025 18:04:05 +0200")
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev>
	<0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
	<2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
	<hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72>
	<917aa62f-5f2a-40d7-8fa5-f19a14926241@fmorschel.dev>
	<ddc841ec-bc4b-4c01-a99e-9a65af3963bc@app.fastmail.com>
Date: Mon, 04 Aug 2025 09:28:36 -0700
Message-ID: <xmqqwm7j59vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Aug 4, 2025, at 17:53, FMorschel wrote:
>> Wow, this seems to me a really weird design choice.
>>
>> Do you have any insight on to why is this?
>
> https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/

Thanks for giving this URL so that I do not have to ;-)

>
>> And do you have any idea if this behaviour is tracked to change 
>> somewhere? Maybe by project config? Like, one project could opt-in for 
>> an actual "rename" history.
>
> As a bystander: I’ve never seen anyone involved in this project
> wanting to track renames as part of the commit.
>
> PS: You need to keep the CC intact when replying on this list. :)
