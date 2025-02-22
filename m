Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE574C6C
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740190074; cv=none; b=H4UQ0cIPAfBz1cFpIoqF8F1uSeIq0YUR5uF0EmJ+h9mrCEKrMwHkxFbcVAjSw62FJjYGpXl37qGNR1oJr47ETTqVAQJQkIPrrwMO9aE8vyqVeA6L4fYX6LHr37Q4A9XZbU9HauQw5pfHVjDdQsK/lvnOX3sTLliGaSX5l2DYx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740190074; c=relaxed/simple;
	bh=hdbhjLcEoLNVkpNrfDRP8+g6k2zod7KF+bxXYF19hpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3fv5a4WyqlDq7RUwiyvaMQYwuYYa93ebtE5guQzZI8eOjHU/I32ZzZ45LVSmHglBVIC91tBc1taf3IEPqaSzwGR8lkoP8/r7C0a9TnPY6ITHNpjTQyzdH7sSs+tcCVzoX5GBRRL/b6naFvaulo1NWd5v4dHhLjusodMcQQCk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QBRDb566; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=72jwOV8b; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QBRDb566";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="72jwOV8b"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D62F5114019E;
	Fri, 21 Feb 2025 21:07:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 21 Feb 2025 21:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740190070; x=1740276470; bh=n87vuNO+VS
	FXf9+JzSgBf6VONoVca14LWRJvEb3bpvs=; b=QBRDb566r1Zt3kCrhZe1SsDdx7
	VsrvINxPJg3B83bj3PBk3O2Ry4XRLsAsVM8qUbq+gC28ZNrlklggoAIWyX1bg0Ao
	2ekyogjVoDzBH8GoIJd58bqFpd44xpqDD1YdOet/O8+AsqKFkQ1ThyIHHjRB0zD+
	md/H6mT+1xyA5ZaIlJpl/JDepHieuXnZP6zRpHCkaFizYLH49bha5fvoAmF/G1GO
	zM9hEO8/QkQ/nzIxe4m/Cj3AAgoa8A2WoXqrCQN3RfmGh6jHHB6rqbROS9PkCGEx
	YMsVwJCYXYklvhyOULMFbPqfBqIdvjuiM/9YDtHmNPqNbPR5q94sF8mlw1QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740190070; x=1740276470; bh=n87vuNO+VSFXf9+JzSgBf6VONoVca14LWRJ
	vEb3bpvs=; b=72jwOV8bSCI+Iri4kMJF1KKFvmz9A1g2tmiwC4I1jCKBYWn5UAC
	HRfgcTVR6P5NzWBIgpMcknoKjXBvWvi/vhcSZpeC8hgzQxInEKYHTvO3oiqPtFWB
	JysEhuGYn+aKNtVmsN9KRVq1PMzBOFryf3uReavNNSNb+LBQYOxmW2dqP171nBm1
	89ikkNHEvVy4KXN4FeEsZvXtswnImN8kG08khAF3+KgOhlmcRhavReAwdKdFf+62
	W79GpoKrjzi3v6PAF/WNyTDrxWnVnPnddCHuVNW/y8Js9+kUGx0VCDuEU/v3wYdC
	ayjM3DJIs/hNTxH3+g2c2vDt2rNnV1W4iJA==
X-ME-Sender: <xms:djG5ZxGvRaIQFjI4rr9vEbAAS79D-9hoUnG8VhMxnOS7aFrUOzc-LQ>
    <xme:djG5Z2Xslhx0NJxC6NdsUmWpTY2LG61uO5ucj8sz5BL2gcoMflNpprQPYdeFfZCMo
    1CQfG_AnTZvXz7DCw>
X-ME-Received: <xmr:djG5ZzK9IT9uoRieKjs41h8pn7ilAaOH-IEJhRbmujyckZyZVYSBbuZpzKOzGDfTbhwM-PwfXDVgIrQrInfzd7iYks4-rZ41wny1iNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprghuughrvgihsehrhhgvlhhmohhtrdhiohdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:djG5Z3HmUzwqCB28T_LDlVz_F4u7kRQ1RyP6JGghV-LU3pf6cFrTvA>
    <xmx:djG5Z3VoMrv3LUc7JjOniwhKrwetM-o5awIGXMYmZ1zwVOWY21djsQ>
    <xmx:djG5ZyM0EkHYvbGIgLBaiBtqKIdlsmT6Bw8IfNO1vyoFyZe-AEQieA>
    <xmx:djG5Z202eewZOc7Mzqje7J1HHth8vtIoWqjWsm1-cYEwT0GR0RbgDQ>
    <xmx:djG5ZyTbcd37tHt8D2FSEKW7S5tuUTtYOJUhm0rQTMD-YItIaWhpeX6K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 21:07:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Audrey Dutcher <audrey@rhelmot.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: Bump _XOPEN_SOURCE on OpenBSD
In-Reply-To: <CADanSV3w++kkTgedLQorKgJ15kc5bEkNvYTidRU1UbwW4jCC6Q@mail.gmail.com>
	(Audrey Dutcher's message of "Fri, 21 Feb 2025 13:41:08 -0700")
References: <20250221180225.3176533-1-audrey@rhelmot.io>
	<xmqqeczr9guk.fsf@gitster.g>
	<CADanSV3w++kkTgedLQorKgJ15kc5bEkNvYTidRU1UbwW4jCC6Q@mail.gmail.com>
Date: Fri, 21 Feb 2025 18:07:49 -0800
Message-ID: <xmqqplja91fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Audrey Dutcher <audrey@rhelmot.io> writes:

>> Is this a recent regression?  Blaming these two line ranges ...
>>
>> >
>> > [1] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/include/stdio.h#L236-L237
>> > [2] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/sys/sys/cdefs.h#L299-L302
>>
>> ... in the OpenBSD repository says they haven't changed for many
>> years, and I am wondering what triggered this all of a sudden.
>>
>> If we know how we used to have no issue, in addition to how we now
>> have issue with the current OpenBSD (which you outlined very well
>> above), and when the situation changed, please add to the proposed
>> log message.  That would help people on OpenBSD to decide when they
>> want to upgrade their copy of Git.
>
> The thing that changed was the release of clang 19, which enabled the
> mentioned Werror by default. This is showing up now because I am
> experimenting with building software for OpenBSD through nixpkgs,
> which prefers the most recent version of everything. I am not sure
> what of this is appropriate to add to the commit message.

When reviewers help me by asking questions on what I wrote in a
proposed commit log message, a trick I try to stick to is to pretend
that they are not who are asking, but the question is coming from
those who read the commit in the future and they do not have an easy
way to ask me the question.  The only way for me to help them is by
updating the message they would read when they see the commit (IOW,
I unfortunately would not have the luxury of going back-and-forth).

In this case, if I were writing the message for the commit, "Unlike
versions of clang earlier than 19, clang 19, enables the
'-Werror=...' option by default...", would be something that would
help them.  And as Peff mentioned elsewhere in the thread, "When
HAVE_GETDELIM is enabled" would also be an important clue to leave.

Thanks.
