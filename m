Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1130B50F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675714; cv=none; b=FGq9BvEJwLjpX4vWIQGNhj3jnW5HYrpnsfLtsjvMu4VG+71v8BNc83qnB7kgh3M/qhvxNYarld41UogYCwcSjFt6jNGaO9/Dhv1G8SJj3bsU2VtiJOH/iJIAahq2ht1amJHLWxxraTeogVqpS54f/UfrlQ7VDMtJbLq/CzTkh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675714; c=relaxed/simple;
	bh=bhbdZWm7bkn65FycualhfDqDHzRypgqbUWhdBCl2zLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoAHyODroyek+L8YUjrkTYTiVNdXSksTZ6Xurz+7RwK83DKIzz2zDkAZBJj46LRmiWzF1Z4mktFSiY1syX8LlH5Wp+PSQCCBXpr2jUrlCuv/Ti9LiZrlxtr7b22efuTFkBo5FxHTVpke6n8/8wE/3DSh8PAXBVrXCpsWoqe2daA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GKb3O7Vf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+xAZalD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKb3O7Vf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+xAZalD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0406E140002E;
	Mon,  9 Feb 2026 17:21:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 17:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770675713; x=1770762113; bh=uH9XhnhqBD
	yLw9sEZVVXR44j7ot1lO8J71jfqBMkS6Q=; b=GKb3O7VfBTMUvaH/CLr3M+OPH0
	D1+XJj4rYGYpUuX4isVnU0bc+azaF1y8+HBulvAbYZ1wRhn7CEux74m1vqoX2nOf
	jZ543zaaZLJ8hkp0HUmv2jEJC2B1CNLCpp4LDQva1yt/Lv7GyCcM59/JbM+yhCeH
	X7G2ZUTuzly9xKSTfxZdSIOX4BW5jaNRFlYz+zpl7WaeEVHEjnuFkV/zy+H/94x+
	k8E5s70XJh68sV2ALWVCLHS98QORBTbFuwIZA/V1CCRxBoPI3542LxjDo12m0mPQ
	KGPTP0tuYhaP8in16lsGgz3haS25jAPkGTgRm7BH8Zau3IiQ2b4iNFdu8IcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770675713; x=1770762113; bh=uH9XhnhqBDyLw9sEZVVXR44j7ot1lO8J71j
	fqBMkS6Q=; b=m+xAZalDGgzUncwmI+KOOHm24sEAuuWAN64XooibOo7Ce4xhZGA
	M3PU53mIkoUXLfxTvQkMkZo08nVMJCv2h52oVZik7As1QRpWdUr4/dZBBinDsQnc
	PL15uDdFmar0hoUoasLzqwBccc1rv51T6Fr8adWGUo+caVRYrO18S5habyXGXrsj
	3gXJcd4y4WJxlu6uz59zHI/lpqq9LedTrwbjjLohgCHx8W/iFPb1qmOPC1butr4F
	PWIZwGaY44EnSaefpXwGu1tnv1ZEXbOpD7aTo5qD9gR4zMFMdN8RvrKQHTjO9tOD
	Wh7se2dCF3z5kXABGPZ5AK0k46YVpTWZYOA==
X-ME-Sender: <xms:AF6KaS8L5PAFEGvxqZLoMVMMqtMQhjKQ0grmVnnsPPUc2qMJmplgQg>
    <xme:AF6KaZnjpZ_se5Z7dkhMU7fJ4Pebtm4iPAMl14tiI0EJRug8zixUUmBczbaiSoDHN
    bIjGQLjwZmptcBWaiS0RbgA1RCchabjGkDmNElHjkAIMkzSw6MNsw>
X-ME-Received: <xmr:AF6KaQXxOyZVJHncf5Bg8pGoMzsv6XQat_CZPtMRMmtlKuHN7DIa9XWG5YVQpkhgdYD4kz0mY3md4RyIhu2JCBFqJjaXHH5n1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AF6KaWFHTS5zgy1nnbKbb0Y7xzpx5HrnGKqDm4kT_jB0kLFJVkmP0Q>
    <xmx:AF6KaUdHikXYm3qDWO4hwAjKeYO0qJrO4xFnEvjrM5aLMkLvVW1lGQ>
    <xmx:AF6KafJ8WiN0HNIgSC7qk4WJb5spRhgT9qAa3ru-44BVUZiQnGH96A>
    <xmx:AF6KaRHnGbtMHvzuMZ_j5bIMW5riQ3Sn-2TZa5jI9gLDgKAWkbQ5LA>
    <xmx:AV6KadVMCc5gEhHCnl2OZ1pBj9Qwyh5mnW4lz2m02EHjOro0OUkQLRtv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 17:21:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
In-Reply-To: <CALnO6CAET9GOsNCdmd3_Jp5Qr3Rfxn8cgmu9n0N8s7uNYpCchg@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 9 Feb 2026 16:57:11 -0500")
References: <doc_link_rerere.328@msgid.xyz>
	<CALnO6CAET9GOsNCdmd3_Jp5Qr3Rfxn8cgmu9n0N8s7uNYpCchg@mail.gmail.com>
Date: Mon, 09 Feb 2026 14:21:51 -0800
Message-ID: <xmqqzf5h36dc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
>> index b0b920144a6..115882edab1 100644
>> --- a/Documentation/rerere-options.adoc
>> +++ b/Documentation/rerere-options.adoc
>> @@ -4,6 +4,6 @@
>>         the current conflict to update the files in the working
>>         tree, allow it to also update the index with the result of
>>         resolution.  `--no-rerere-autoupdate` is a good way to
>> -       double-check what `rerere` did and catch potential
>> +       double-check what linkgit:git-rerere[1] did and catch potential
>>         mismerges, before committing the result to the index with a
>>         separate `git add`.
>
> Minor: should this adjacent be linkgit too? I thought yes, but on
> second read we really are talking about the command.
>
> Anyway, agreed that rerere should get linked. Thanks!

If you are happy with the end result, I would not complain, but
which _other_ potential thing were you wondering if it should
acquire "linkgit:"?
