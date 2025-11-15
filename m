Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B721D3E2
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763237042; cv=none; b=EUhj+oBHFnlFRrEjU3SczKhWD+wgv4zoKMucKN+UhuKp3wcj9Ti4owTyknvP3mE5huH65SIiT58O5SBCPY8smXLkWpFc7TraOn3x1quDse0iBcWpFPwLrsUOJLCGuzAYek05vxwZwJUkljIzoLAg39E1tYyaNwWVHX5dK7lVlzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763237042; c=relaxed/simple;
	bh=3uad0Wq4fc+nYMZh1+Wo4vhsWlH8nxcWXsl41gbZxos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tdUu2lhs3EblOcLUtON3KF+OP1a/s/E09ae+rGPTMDwR2lfBBLHhbgGhiSZ12YcZVOZy57XUnnpnAEk1bOxlf9eKXGYM1L+BBrhzqRAFcUgBcmyzBmqq/os8OTEs5UNceBplWUzeE/cILZIw9xZrPi1fSJiWkh08zPk9ovIxg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HLusMSAs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=278LRnun; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HLusMSAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="278LRnun"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 670067A013B;
	Sat, 15 Nov 2025 15:03:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 15 Nov 2025 15:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763237037; x=1763323437; bh=m7BwvI24wp
	cHdVDxtVd3aRKCcKCeTfQduIUiYla6eEE=; b=HLusMSAsRu6LJfQVcVKtLQkRmD
	8ClcveXRkwufZDz9lJO/P6kK5b3f6xbkpN/lMjIJR8fREGDbUB1RQZgMe+seGWen
	soOHp+DtjK/wMm4KEVq60wcgjVYrE8mEIWBxyHWBQ2XdRvwRXfZyJotwEbFYyl+H
	B7qlzuo8zL6Fr5frTSpprDO2wjQx0e3V+B3wVE9bDASf7WLqn/1Zs77c/Ucu82+2
	6opO9BSw1u1WIafQ+EDE6PTiQxXqn29gQng0ylWQuyDNElFkUEcz0/K0D6JHY0Sp
	cf9gv80A00cRTI4F6XSY2GAEVWlGIvIdbYpZupD8Tt/eTA+bijCEN4m7izhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763237037; x=1763323437; bh=m7BwvI24wpcHdVDxtVd3aRKCcKCeTfQduIU
	iYla6eEE=; b=278LRnunmR5rbulmNzofvaFy5ZnmL2HKkT4yVYKa8xLCDTzmAVG
	fw58KrT05zGlG8E5lxGDaNQaEDAaufjYcPQLwCAuMCZHpK+OvzV1ocotVhYli8BH
	qcu4fOq6XliJ82Cf4NHq7WWpAu7gTeMzQW1g8RG3paBGhCJ/6n8UrOMiYNHXOZFV
	ralyJC2HHbse6wg80rjpC4MP82onlB4N8GsnZ1ylM59dGZ6NQMPz1dURtF3ZpAo+
	Slb7m+1CSJBqepb5zf9UI1hPnAd1s9V/9K4jehQb2JeVO4UEMNU2Gk7I4zWJUpPI
	EJxKoQ36SPLRpW7wqUp+XZwV8FrFRU7HYVw==
X-ME-Sender: <xms:rNwYaXaAhcG8UtAo8rXKNfD9jZ6n0cLlf3vwaw0UYAOzc5--gNDqaw>
    <xme:rNwYaZe3fkjxIoUdeaDPyqKdmM4lHPvYs-LfXKcjjhnGLGq00JS5bNU4v6Z_bObBx
    afKdSYOH0avR6VVoTnSKL3oVxsIs8OhBEpZdoJ8PCnuNl3ry8vDkA>
X-ME-Received: <xmr:rNwYaUmtN0SxNtBbGOA2wHKh8QQRpYUm16BH_ypkporFAUM1DfqIjFg8-Zn73sajY-CQzGSqs9avkruF9K7sCCIvix5-9j3HFP6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:rNwYaZ3VsvdYbNFFwxKd1ZcUWcLkit1-wPr8a2ujcHV5PsQ10nAGdQ>
    <xmx:rNwYaddqjMljwGNcN_QRHrIhCy5vdxUasN_85QpEASU9dYyYfG9KLg>
    <xmx:rNwYaTa4bKtMtz5Rh4TlILJMRo0zH8J6XR04CNeA90uQg_gwe8HK1A>
    <xmx:rNwYaSG1DdoQae0ADzk5eAhckiqR-aBa41dVa5RNKP6r2gFeRvJAIg>
    <xmx:rdwYaS6K4dnZMBbbdTDiQTggtWBl_yb57GQ5XqsFvE4ct4GFRxnsfhrJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 15:03:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C
 and Rust
In-Reply-To: <CALnO6CA-6waRpkqzLxR+f2yzwfhmf_jvbtEZC7FAFN9NLkqkXg@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 15 Nov 2025 11:59:08 -0500")
References: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
	<5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com>
	<a30ad114-61c2-4eed-a24e-033b3b9d6d0c@ramsayjones.plus.com>
	<xmqqpl9jfdso.fsf@gitster.g>
	<CALnO6CA-6waRpkqzLxR+f2yzwfhmf_jvbtEZC7FAFN9NLkqkXg@mail.gmail.com>
Date: Sat, 15 Nov 2025 12:03:55 -0800
Message-ID: <xmqqo6p3dpw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> Me neither, but I suspect it may mostly use of non-word "signless"
>> that is the issue.
> ...
> Agreed, and I suspect this is roughly the implementation.
>
> My point was that Ezekiel seemed to justify (?) the use of "signless"
> by pointing to those warnings (I personally am on the fence for how to
> treat the combination of facts, but it seems useful to consider that
> char is not easily comparable with integers of various signedness).

Agreed.  I think your point matches my suspicion that the use of the
non-word "signless" was what Ramsay reacted.  The 'char' with the
implementation defined signedness is making -Wsign-compare even more
quirky than it already is.
