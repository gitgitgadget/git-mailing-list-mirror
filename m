Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0421FE45D
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078046; cv=none; b=UXKfjO8ybv71QV1uyGLYAZMWZXgW3VWZ2oNjDLHZHrwu5AqhSMgjEWuXtCn1BBGc0z5uod4nDdskTeKiBeOc2XHMmOUV6RYH+S477iYofRQ/6e1tb5nGumZHhA4/bGZbOj3KQOonthPgG1WlD2JnLw6ragR+J+4bNWrRO7nuMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078046; c=relaxed/simple;
	bh=i+usvQ1onDbGDOeohgJ2z3YxFiwn8oVarO+B3oEJh0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DBSS6M/j5wIOUUxpaoUf0UPB7j+0Ins6rn5imuDBwchLXR3UBZz/MrOPIWZMeBcwiJa3RMLbvrbn2e6m4YszZ1fDFh/EYQ7zOiWERO1uUImHhnXXm0ISP5R8QRF6jHWMf4vZS6dRcgBAKystVbaBJ7dLO8qd1gyzB4Pt0lFAPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=epCtV5m9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYKrF2un; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="epCtV5m9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYKrF2un"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65BDA14003CE;
	Wed,  9 Jul 2025 12:20:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 12:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752078043; x=1752164443; bh=A02onLCpNb
	YSnETHuJC6btzh2gS/WwWlJ9E0qsxUK80=; b=epCtV5m9Ktno7+qeKc8ZN78Ex8
	RUfJ08tTF8wHxIwuqeXh7rrHtP/NeLZAAq8YRpI8UgYOzQaeKc1YW3/CiRWXvuxk
	xBiOKdjIgdz1Uvm8qWow5ADZdAsqWgKcQS/ySlD4e/XpkNDWRwdZcd30Hq7EW12m
	MVtG5DX7PNpaLn2lVsFZpcnbPfNrS+oq8/HaDhD8ZM49CoAwSXGjwdGgVs8Oq/UE
	B3TaDrrfwLmPn2oEvXgFAX99rcsLLoRfVfi4Hvx6DB/oJIyMa7KICYZYYZRIOtb1
	1YSJI44CyPZZ0SdXBOXH3Y1RwepDGwq2Qt/SkOMy4998aEBywTxKyX83hgKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752078043; x=1752164443; bh=A02onLCpNbYSnETHuJC6btzh2gS/WwWlJ9E
	0qsxUK80=; b=DYKrF2un43wxWBdnsNNUpdEr6SA2Bs8UcF8oSV1cblNQSg776rs
	xl8OW0tk+Pwq3yF5v2zK4g/qOj/cO1JOBzAD6/BCoEZ9yms1HGKEEfixklxjiU1u
	CyUvOFBmr5etG9LvDQs2RVofD+xXNpZBdAHui3D5tZS6HKZ7cZ719nA62bxsbBd9
	xVlUVW/3gucHuIjXyvQF8QzSCS7Rs0Vhko0skezjrJf3PwqKcceygho/7h2HgHTx
	KJb1FlPfA+emeFhZSI01sl4szqGVikcgpFDrPHk+2vy2FGHiggh+nQjXzHRnTFd7
	GVRRR6cz3ZLrOtL6AC1+XVwSlMLQP4TzD+g==
X-ME-Sender: <xms:25ZuaJWPm--xBkWQ6EffozA0AJnpB9vLWB2KQy_lODg760pGzl4juw>
    <xme:25ZuaHLc20YzIZXGrGv3oyKF2KJ4b5Hu3oaSdQsmADN242iS76qiCEO308CxQIjV9
    PU07Y5NEhjIm_AD0Q>
X-ME-Received: <xmr:25ZuaL22cle7rOpDWl-A8A4Nx7bLETvVSpVjBDyZKlr0YQHldPi4RR12Wy2zax9cfsc4c5tgZq4nKdJSTYTVNw8SKH8HKGFkfuf9MLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:25ZuaN5w9u8k_uBxVsBcCtLnYNV3rXG78NdqxaSnTbSnuXCLAxb6CA>
    <xmx:25ZuaE_iSnjZdCKDty6yu2lcIRtVtDVL_lGKPk8blHOJwz9G6AGXDw>
    <xmx:25ZuaEWx4xV9xEbjogKstmDKgnaCidcL256mLprcAnuWaxzv2oT6HQ>
    <xmx:25ZuaHpzO7M4GbAIlKF_ZD0gD9ylMg7QnU3SEqnWqa40dkqcPJQMtw>
    <xmx:25ZuaLSEIgZ8Uxpn2po8ZoaQhMFcIC238HECjS14h1oYqAyCtbqL2X53>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 12:20:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <f679151a-c843-44d4-9e28-27112d26f30c@gmail.com> (Phillip Wood's
	message of "Wed, 9 Jul 2025 10:38:19 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<xmqqjz4iv7mt.fsf@gitster.g>
	<f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
Date: Wed, 09 Jul 2025 09:20:41 -0700
Message-ID: <xmqqfrf5nxnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> With hindsight I should have been clearer here that the advice given
> is based on the user's config settings.

Ahh, OK.  If the "hint" advice message gets generated with custom
sequence of commands, that explains why the sample looked so uneven.
Disregard what I said about clearing every variant from every scope.

> The advice will recommend a command that updates commentChar in the
> scope where it is currently set so if it is set globally it will not
> prompt you to set it locally in each repository and if it is set
> locally it will prompt you to update it there.

Again, I misunderstood the set-up that would lead to the sample
output.  If the user has "auto" in ~/.gitconfig, replacing it at the
same place may make sense.

If the "auto" comes from /etc/gitconfig then we'd recommend
changing it there, instead of overriding it per-user in ~/.gitconfig?

>> It would be necessary to special case "auto" after 3.0 boundary
>> anyway, whether we (1) die when we notice the value is set to
>> "auto", and refuse to work until the user chooses a comment char, or
>> (2) use "#" or something hardcoded.  Either would be better than
>> using literal string "auto" as comment char.
>
> We can do that if you've changed your view from
> <xmqqfrj6vfsn.fsf@gitster.g>

Yeah, I think using "auto " as comment line prefix is simply a
nonsense.  Thanks.

>> So, a simpler approach might be to treat literal string "auto" as if
>> "#" was specified under WITH_BREAKING_CHANGES so that the end-user
>> does not have to do anything when they want to "revert" to the
>> default comment string.  Then we do not have to give any large text
>> like the above.  We can instead say something like
>> 	The 'auto' setting of core.commentChar (or core.commentString)
>> 	will change its meaning in Git 3.0 and later and will always
>> 	use the default '#'.
>
> That's certainly simpler for us but it does not help the user to
> update their config. Presumably they're using the auto commentchar
> because '#' does not work for them.

OK.  But those with "auto" because '#' did not work for them are
setting "auto" not because '#' does not work, but because none of
these "#;@!$%^&|:" work for them, no?

As you said earlier, the "auto" setting cannot fundamentally work at
all if we let a third-party inject any commented material into the
editor buffer.  The comment we inject ourselves we can control (and
notice), and perhaps back in the simpler days when "auto" setting
was invented, it was sufficient.  But that may be no longer true, so
it may not be just "tricky to fix" but simply "unworkable".  From
that point of view, as long as the reason clearly is explained to
end-users, I am fine with "'auto' stops Git and you'd need to unset
or set it to something else at the 3.0 boundary".

Thanks.
