Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82951C32
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253626; cv=none; b=KCFSMkEyO4r0LJsjWdbclC9449YFepTG8RY8qyoRuy3jA2dksMRK3h/6C9HxVLzE5FDFuzTT4cTlDxQUIsX+iaYeCkpAHmfuPNOvvoHWKQLKn8Envfy6cC2DLp5i0j0j49xYgcNfmVN6KrYNt31rAMdGdRaFaFOWqb1TSYSiwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253626; c=relaxed/simple;
	bh=TNLP7FtxtI3CJS7OB9lgQz4T+vWBsvW2nmmyH/lYiac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d+0B0JaFijr2SlkCAixzuzF2lv4F8dAeMj8c4eooRavKy8+EOajze18G9Hwjz50VQXAdGq3OGxiD5QrWrpyxFgI1f9nYxwX2DKsZmMAOA8EaQ2rwGGH4FJuYGBJHGTCVdmjQceqc8PobonY5BPfv3Mv8p/Ts/ZuYRDdPG1ApxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pnj/RSWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUpCB0Vo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pnj/RSWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUpCB0Vo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAE381400105;
	Fri, 11 Jul 2025 13:07:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 11 Jul 2025 13:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752253622; x=1752340022; bh=Y7LeoXB19b
	c7V3Brpd1V80fBusniwazy0JkuyTM3HtQ=; b=pnj/RSWYUxG+IHs7+/PmZiqrXY
	QueGTqwUuGVj+rEo3gBhx70+jOw3ABkIUW1F1q6VUWjlERgDp51alG0wzVzuIrLS
	8Uxx3MK1GSla7KptgJLrq24aIhW9DpywRm/cYlZuLHoDdy4rbdryejWFCeqOTHRK
	kXHpiz8ho84xNehMB5qkslQuMvBb6mNtcr2EMDyuYitxaM+3MIJ5fnfUxcH8M9iL
	6FIjf+qEclZzm8Z2lFW7nts80xn/+R3ru5s32HoNxN1xkFY5KbGBE8gfbyCypswf
	8KF+qvr0HQZoMiEOo3rkZVa1C2Aog06FmWRzOyRAXdbJPizPuxT5hrAgrr0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752253622; x=1752340022; bh=Y7LeoXB19bc7V3Brpd1V80fBusniwazy0Jk
	uyTM3HtQ=; b=XUpCB0VoWIuEwWbjnDgFOt+prxHeQf+wnxO4Ti0wPod6GqwC7tN
	zLbS8qLon9YTf5++R22AltXbOihYKRC+vCXbdO5jNYZsG9MshAaRqVKqMTp1cMi/
	V/d3FGXQshNTq1buyeBgVtbebC7+WsPhkdDvfCKc9Kiu8Uh32XscXOZ5P19gEmvh
	4wNvvDn12hX8/n+1dFMRx2dffECthkaswIZ+45Bc1eWai0/S/KwUnHKcpWG+B9Zy
	UYRPgEGFKltxgiSEjoPkjlmXnAR3lNS3WOys2+4xfv8QL3tqQHL4LzIPl4p8UznF
	GRmwvUAfAAGn7n5KoDcbml3IGrrbGaHwItg==
X-ME-Sender: <xms:tkRxaHTZZj76STyHfpfcz_rFQ_glc6Ao0I_MaSQqC1Z734SNA0Y_MQ>
    <xme:tkRxaGWqXPNJaR-9ZUNsCSkNl7U-vySUUtPhhei15wPsQq5dAdRjUPYZ36WRIMYIL
    UFvnGN8LURuwbSy_A>
X-ME-Received: <xmr:tkRxaDS5VhnThDSdkFdmoQCkNMCams5cXpC4GKc5omMqfMzYdpRzeEpBsQOeo-sOe_0WKyqMGFxrlRvHjproBp4IuV0VvWBUEGsF9pI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepoh
    hsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:tkRxaIln9s_97c6v3mMDagagh_NHHh8P5Q6lNxMqc5efjtjemxkCmg>
    <xmx:tkRxaB6LiH_Mjl6tFDepQgqwj3_6DvGjFg3aXSBpzg9pLnQb0lP1zQ>
    <xmx:tkRxaGiLorEMlJBear3t3GNIQ4TUw1mXb1Le4u0jLU5CgzWcOCu6ew>
    <xmx:tkRxaGHGve3HJDl3XFQB7363qhSxP3cQKFLwxSwX0BzkR_uOFgJM1A>
    <xmx:tkRxaDfW_yhJB8n9lexerA8jHQuRp23k3fPjHVIKENW-ANCXr4fKmBBl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 13:07:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com> (Phillip Wood's
	message of "Fri, 11 Jul 2025 16:09:17 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<xmqqjz4iv7mt.fsf@gitster.g>
	<f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
	<xmqqfrf5nxnq.fsf@gitster.g>
	<b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com>
Date: Fri, 11 Jul 2025 10:07:01 -0700
Message-ID: <xmqqsej21wsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> If the "auto" comes from /etc/gitconfig then we'd recommend
>> changing it there, instead of overriding it per-user in ~/.gitconfig?
>
> Yes, though I'm on the fence about that. I wonder if we should
> recommend ~/.gitconfig instead if the user account that git is running
> under does not have write access to /etc/gitconfig. That also raises
> the question of what advice we should give about clearing settings in
> the system config file if the user does not have write access to
> it. It is possible the human user has write access to the system
> config even if the user account that git is running under does not but
> we have no way of finding that out.

Isn't it last-one-wins?  How about just telling them to do without
any "git config unset" and just do a single "git config set", either
to the repository (when the "auto" we saw came from the repository)
or to the per-user configuration (when the "auto" we saw came from
elsewhere, either per-user, or system-wide)?

>>>> It would be necessary to special case "auto" after 3.0 boundary
>>>> anyway, whether we (1) die when we notice the value is set to
>>>> "auto", and refuse to work until the user chooses a comment char, or
>>>> (2) use "#" or something hardcoded.  Either would be better than
>>>> using literal string "auto" as comment char.
>
> I'm leaning towards dying to avoid any nasty surprises when the commit
> message contains lines beginning with '#'.
>
> I'll try and re-roll next week

Thanks!

