Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D62EBBA4
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861338; cv=none; b=O/G07YZiJNoMq3jC/srZDGKWs7ntMS1utsFfJ+Lj2UszvBlDJwGRVdXv6uDWjpv/2c3uJtbZOS+cnk0X7BDZOuY0luFt5ZpUhpDTaOvXMF/jCdVXBE8J9NlGD+EUTiXSuq9wBdgS9gi7AASdLZDw3QJodkR5saTqkY0/C1E6bY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861338; c=relaxed/simple;
	bh=XC8LBCH7bpTymn1lvoHWUwaLAaPyOWfrqypZVdD1J7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVgNjTRv4F7sEIsbP7LQ8iuRTBmXiB7ZhsXPOHFvTVoIdjkEitZAnnV8nN2IWnduKyEFT36+rMOgceZ1bSeVv7Keu56nbEqtaDUXjh8NvYrEpTwXzrRCU37ud+8Em6HkbFzlfnxLJlBwEdRBvKpbtMvFOkcCbANjNhnZ3ebpgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VslnaU+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGOkZHIJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VslnaU+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGOkZHIJ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18D8D14001AB;
	Mon, 23 Feb 2026 10:42:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 23 Feb 2026 10:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771861336; x=1771947736; bh=0brdhtQ7Ub
	71lx3vNtsCIE8vLyKKm2PVaf6L7DroAew=; b=VslnaU+TTEHhuVQEzaZv1OqgxP
	abLm49eSDDQfwtRj3Ugc6r8Wp2ikpEmLrvQzynAK10DR/ThNcL6CheEa1bWvrENe
	nSWXQqJDNfOd5WDRvE+o5rYmBikg0VaGV5meQcevcyaVq0uHhpbMUaPVERmzkMAi
	Ns9HzpCAak19kv7HlGdNOOoc9iYx408pxU9T36VpdCSeSPUxwhAFsb2auCwJFK6q
	NM7/piw/qcfIw7vwKnEbWq6Yze9KhjIGtypv8h4NoFHyA9zs5tEVNIfjqPza+l32
	eVSjJh2YCyHqYzcSvA35MnTxyQvFnGKc4k7qvLwu2ZDw+9gRWVLvBkHlaK8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771861336; x=1771947736; bh=0brdhtQ7Ub71lx3vNtsCIE8vLyKKm2PVaf6
	L7DroAew=; b=nGOkZHIJRWm0LSt3nW5Wd0ztUNheiQ4vr2cOZWyDMKB8Evs3Jfa
	201et/f1EpN75o0UE9U+l+3ADunOb8C4RWyGEogC8k1vzOFGnImOI6wMdjP5vEUU
	v1/D5wSGunVz1PPJuaC0in3UiADLmH/KDzo+UV+vXO/vPCbyJHKSsR8tDQU0iLf2
	/uL7wdZXpQKrbFq+zCIOLhFyZHcTmdlnHYCkRyQz5wQkW+RFbwAPgQXbBq3dpGAZ
	FTRs+9PvKsmwlTIZkw+B/X4AwHoMage8l2rY1U/DhSfWyL3vdvhXFVCpn46RjTOE
	WnnB0IYchnY/vRQlOOOID4eYgYEoUZo9giQ==
X-ME-Sender: <xms:V3WcaW-Fk9jVMDn26paHDoQ8XYiUIULoInVxjEIqkn8VjGPzvieTXQ>
    <xme:V3WcaabLdvzIVY8VXMaARrdwGnGATQyGmVbFbk2SWytcHM_LlF8WUqwVAVz456hC3
    X5nKPzoI_V8Mg4ojBvXIdlMwLUNflOZVOo4jN9Lvf6o_Lii8AmaSw>
X-ME-Received: <xmr:V3WcaV00VzNhbY7WloJvY10dLKpAZTPcFzs1Y0faGBzAqt0InzHOF9XOLyA4pP2d0lxc0Xdm2ORoqtXafh44JLZxCaAY8sUa6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehprghulh
    esphgruhhlthgrrhhjrghnrdgtohhmpdhrtghpthhtohepghhithhhuhgssehprghulhhi
    shgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V3WcaVZJ1gT6eahOp1Yz2yyhl-lcYxwbi6Dt-598iS80ufxFm1UYvA>
    <xmx:V3WcadJM3irgD-qenp5Ubc4946fKD12jxGQvF7iCD2eUtgC34lqAYw>
    <xmx:V3WcaUGAc3ZIgG5f30atyvVZV_GOO5cLHLL7zd6iZgbaQ3_mGIGuSw>
    <xmx:V3WcaUt4XNx1To3zf6pro_NuGjFdwXUUwc-NPZRZQgASVrhqnhbtbA>
    <xmx:WHWcaUGWUFL69XYYiyzAEfMlAsl3bmDBzBT38sf9EI_2LdZrSp-ruDLO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:42:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Paul Tarjan <paul@paultarjan.com>,  Paul Tarjan
 <github@paulisageek.com>,  Paul Tarjan via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for
 Linux
In-Reply-To: <aZv02KjfheyFlMfb@pks.im> (Patrick Steinhardt's message of "Mon,
	23 Feb 2026 07:34:00 +0100")
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
	<pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
	<aVuplzNaoCHlZG3S@pks.im> <xmqqikbrvz2l.fsf@gitster.g>
	<CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
	<xmqq1piet47r.fsf@gitster.g> <aZv02KjfheyFlMfb@pks.im>
Date: Mon, 23 Feb 2026 07:42:14 -0800
Message-ID: <xmqq342rpiuh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 21, 2026 at 09:07:52AM -0800, Junio C Hamano wrote:
>> Paul Tarjan <paul@paultarjan.com> writes:
>> 
>> > I'd prefer to take you up on the offer to send the meson support as a
>> > separate patch.
>> 
>> This part of your message is one thing we needed from you to unblock
>> ourselves, I guess.
>> 
>> Patrick, do you think you can help making this into two-patch
>> series, the original one being the [PATCH 1/2] and update for
>> meson-build in [PATCH 2/2]?
>
> The changes I sent should be sufficient, so I'd propose to just roll
> it into the v5 patch.
> ...
> By the way, I haven't yet done a full review of this patch, I only
> chimed in to help out with Meson. But I can have a deeper look once v5
> was sent out.

OK, so it is not quite clear to me who is doing the v5.  Is the
"offer to send the meson support as a separate patch" still valid,
or we expect Paul to squash in the earlier patch from you to prepare
the v5?

Thanks.
