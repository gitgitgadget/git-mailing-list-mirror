Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11813A1E9B
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493071; cv=none; b=JHO/2LlUDJLHRXUJ5aOnsV43iM31kMYbWMfxjqNPHpbeUR/2vbChG+s0uRdiXaSzbGRVDUNRDf6cJmWUSrk1Lq6SjqlmDp8Rx0dviyit9iUb2QhlmnlUcR9ZeX/rTf+HJ/YsywErOH2CZt1WZy3nooYwmChhPkNuvnXoZPXdRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493071; c=relaxed/simple;
	bh=/wLDwmZnOGK3fdbHlry5hUlDecLxwmxjBV45w65BBBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XUiW2ukk8ZxY9xDyRhoU6hDL1y4BNzLkLkcjOYys4SiyhQjoLmavMvbiS2Q8pF2hisBnU4k2LMtB1S+bqtRCAbfRHDIXWTklet5R3Vsmbuvt3Cke5+GfVMp6W1skR3ZqlaauuE8A3rz0Z7YQiRtLzkbAB4S5QFW2WD+DgBDJZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=afJY4WmS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zQJoa0Q/; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="afJY4WmS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zQJoa0Q/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D42A71D00087;
	Sat,  3 Jan 2026 21:17:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 03 Jan 2026 21:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767493066; x=1767579466; bh=/wLDwmZnOG
	K3fdbHlry5hUlDecLxwmxjBV45w65BBBA=; b=afJY4WmSBiZSc9v3cYsC17MLN8
	f4MKkgdWtAR8bsNM8KID0P54LCfd0hDMUUztnnAb6SXjkwnygsDwyDlsLQ3D7/oH
	OlB8Twqrjo78yPSYvyyV47USVA3O6p+vm0Wyvhnbs3UZLbLm+V9WJBlhGrcyVh+U
	AEL3/HYyY4PmZn/UQ6teji5+lT2hoHEuZxVd5vL/49wD1ByRB5oZTGRbdbkCrj/s
	bYbauu/U1+njlDPpzj5njxZSqkcj72NQjzFFbFm8cbY1IUQC+xB78hOo1Nbt220r
	tJosQqmmG8XarHYHwoZmuQPCF5i4YhqydJ7+bwym7PTL2jTyyQCLHO3WuzjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767493066; x=1767579466; bh=/wLDwmZnOGK3fdbHlry5hUlDecLxwmxjBV4
	5w65BBBA=; b=zQJoa0Q/w0mZ4o9a8AOpQWG0d1zWR3nszlZhTJB+c1RJbs6IIdv
	CzJjFlHe3qkCymOTU12pOv4FTFNWU2X9L5hgssxf+9AbtBectzTTjDBLSVlm5jCu
	g8nv0peEiSxTaL9nhgd6WJUQlzCH2Ig8zhfqjFvnC3PXi8REo3iuipBWZvt7V9G9
	mnLDQn4qDkHLPboS06/EEQ3JxNiZ/90MyS6472ld1Wl88Yxb+/Pe0Lu/mhrgjzdQ
	gIiIt0hB9yx7mkOX7cbIdhRU1JJB2r/yWM9SAfRY6HYdF4Bi3R2zwlvZY6jXSXei
	ZR0w1Iyp9Dr49LKoSNuvbjePumIxzTnK1Ag==
X-ME-Sender: <xms:ys1ZaTwzGMt4bam_kLeFP1SUrdGvIlelKeUHcOHPI_JYVfaoAifaOQ>
    <xme:ys1ZaSR51N3bMt6P1VdLD9eiOKqQxLxDZqnv1KkyjEbjbPvswq0Ml3L8WLZA48xRm
    ZWHB3cyXnWuKqtluq-YYe_6VI848emiYH8R-8RQo9S3MLlK_g2e>
X-ME-Received: <xmr:ys1ZaSX6Z6vv6kwMTMnTkRBBkZcdodbpJqsJsVHSXREba_0fjrJDXqeVctoi3pRO8yUf2LDSsUntzxLMNQEx8g8SdL1KIy3UzjdlSv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ys1ZacbNPu-swGRsKpXej688KL1qHRz02Oe3OIS_1WKXKIXlm0jSiw>
    <xmx:ys1ZaQ23Zl70BeuGcQ4oVevzugtt6ULxoXKRSiuZJi-jgvppzgYveg>
    <xmx:ys1ZaWjsw86hMFA7t5_Auot24H9ss2MDdCWa_5vy5rCmerqIWp_1AQ>
    <xmx:ys1ZacYrnLe7IM3RLdxUZJc5zoSmJ4TcgDZhH0hqvabCOCg4zYgy_Q>
    <xmx:ys1ZaZ1gtt6Rv0rmiP545aeIw_eB6Z0KjGUt5Wmu-phyM-PMqPLfzQcP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:17:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: Another look?
In-Reply-To: <20260101233839.17639-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Fri, 2 Jan 2026 00:38:39 +0100")
References: <xmqqh5t5c4lj.fsf@gitster.g>
	<20260101233839.17639-1-haraldnordgren@gmail.com>
Date: Sun, 04 Jan 2026 11:17:45 +0900
Message-ID: <xmqq7btyqfxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Again this seems to do a "step 1 goes in a direction, step 2 fixes
>> its mistake, step 3 changes course" drunken-man's walk.
>>
>> The same advice to restructure them into a logical incremental
>> progression that moves the codebase in one consistent direction to
>> eventually reach the goal at the end applies.
>
> Isn't programming always bit of drunken-man's walk?

Yes, but the point is that other people do not have to see you
taking roundabout route (or for that matter, they do not have to see
you coding in your bathrobe like Linus, even if it may be true you
;-).

When other developers later need to figure out what you really
wanted to achieve so that they do not break your intention while
they update your code to fix bugs in it and/or adding new features
on top of it, it would be far easier for them to work on a clean
history.
