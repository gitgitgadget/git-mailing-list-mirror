Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E43594B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990520; cv=none; b=LyE7DLDhWq5R0rlLdY0G68Uykeg2cJH/rtjOWsj1qMPp8WNHn5OhawUA5I8d++R54M4ZUW21ehvqzoUCqTZHk4aS8ddnbk175gkSSVoCjH+s1u1W55HXNUSgVXkRzw32mhgkdnq836ScyRDsMF4ROeuzPun5bAjTOl1FxKFfLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990520; c=relaxed/simple;
	bh=VhcqtXP42f9BlcTTbFWxV8VFisWAQoDqXJT0TMsEroc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=reXlFhNXyVrajAUD6vSvDRVO7/mhI8Ngjh55XSs5WB3IERuMKAMkjbnyzyBWVy2UrYNHxIRKGJjHMUgwjmbDSY3N64KHe1+p/3prjlt7ZrdnOLgKx5sg+ziHdjv9aNGwjgtef0BfqLvBzIkOooUucgzBQxrnlD8xTS5MDKRPqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J4CPEWSq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UF+Ap/cj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J4CPEWSq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UF+Ap/cj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF69E114010A;
	Wed, 15 Jan 2025 20:21:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 20:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736990516; x=1737076916; bh=fSZfmnavmS
	0bbPYWIkNgz3saNHewQh/wO5CzHR6EL/Q=; b=J4CPEWSq/uuHNyTlXmaNk57O3a
	zdGlO+7oNTIjbTNlBytmYvwJOddXr/+FWMYNmtIjECK2/LZ/7RcrVIA9hoPm3Rsm
	b8wtZtqFls6ehhubH9YzBYnDR/o+6lad3/yQPi4K6zFhaG/S+aGMWc3swq1sdHjm
	DPeQ9Bz4tax7Ynqx6IkfJs/mzaBSILuhRL2Ez9p9blEhlYkdCzrr5wJBYpGEF3na
	VW+tUGjmFVvnaVjwfSBc1OAowiWXRZdgwGm1L1W1hr9BQfPM8pz6TcDpa0t85bHd
	Syerwgwh5N3yGmx2jLNPLDyzZC36q9P+oodqkolD/zrRgpOhS1QMQ4/JBqRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736990516; x=1737076916; bh=fSZfmnavmS0bbPYWIkNgz3saNHewQh/wO5C
	zHR6EL/Q=; b=UF+Ap/cjJqIyAx3EzAAxXkzLJPJnF4SbWOcTh0YPYsVX+bHLxj7
	3OFaKMeGdb8iSAgQl5HGoVxGt1VJ3JozGcDO6xxIcW367AMYw33oLH/swOXD0gVe
	xkUzzRPq3oU5HEnTskMzbaoGv4szQFdWQWn6NT6vIjwkCTqbEniXyybrncYR57Fq
	QPGf939De0iZfJ/1mprb0XdmnglSvmhxZ7PWFMoxnM4F8jwR+y88vSE4n4jEtB6+
	gn1k/0jv6vty/sPJjqvVQeZQRyCHFennXFgPBm3FXN8L7RjtIvR2/sCb5WwIRYPo
	ttLqpnNIROBY7b2MhTUTEqVNRwcGNstjytw==
X-ME-Sender: <xms:M1-IZwrf8cHFfXRajJSMns-Q2GOwkMXs-xPt-CV7xlI6-fYXeduGkw>
    <xme:M1-IZ2oPjXO0ltYtGimsN51tZXx9RjBHxkugh7Jckb9Kf4ANqSrEIafLslyfq7EVx
    gYURJzNWk_yEU9fdQ>
X-ME-Received: <xmr:M1-IZ1MkAQiR4GqVNw-ReMPg5VoJfoexrMLLNkECUClKtGu6Mlf3KZPggpIK2-dY77uQ-1LklndptXcyRn3VPokWqSbrbjSjryqH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehmtggvphhlsegtvghplhdrvghupdhrtghpth
    htohepjhhonhgrshdrkhhonhhrrggusehunhhiqdhmuhgvnhhsthgvrhdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NF-IZ351hirv3q3AJid6NuxaRNXd6BU8GtwsQ6-3DR4OvjoohGAq5Q>
    <xmx:NF-IZ_7-OrmzMou6mdLrqdZzkLeY7cIi3Q5rSLepr5pCnG01R3YUXg>
    <xmx:NF-IZ3hiRbbBhAAtefZ2u7VzjPgbyX1QPligPaO5VPE2Hkf6-VNJpg>
    <xmx:NF-IZ55OQDtkf1celbemUaqeSWn2-43Pv53bO-cHOqwTU2OU224QeQ>
    <xmx:NF-IZ8saHZ6erB7DaSbttqIsucGRxRivkQ3OBvRj2WYEtPSiciBS5R4S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:21:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <xmqqplknvek2.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	15 Jan 2025 15:32:29 -0800")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g>
	<20250115182419.GA86610@coredump.intra.peff.net>
	<xmqqa5brydz1.fsf@gitster.g>
	<20250115212952.GA96537@coredump.intra.peff.net>
	<xmqq5xmfyc4w.fsf@gitster.g>
	<20250115222728.GA132248@coredump.intra.peff.net>
	<xmqqplknvek2.fsf@gitster.g>
Date: Wed, 15 Jan 2025 17:21:54 -0800
Message-ID: <xmqq7c6vv9hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> It is a tangent, but I wonder how many among the 40 really needed to
> use usage_with_options() to react to "-h" in the first place.  In
> other words, these manual checks for "-h" are done only because the
> code _wants_ to react to "-h" before it calls parse_options(), but
> does everybody who _wants_ to do so really _needs_ to do so?  You
> already have shown that "gir branch" did not have to, and to me, 40
> among 100+ felt way too many.

It turns out that some of the actually cannot be helped, as they do
not even use parse-options and calling usage() themselves is the
only way to show the usage text for them.

I'll send a 6-patch series out shortly.
