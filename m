Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B52227B83
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186318; cv=none; b=l8Wq+r3TTbaN7Q8ZTaf3pfhp+sYTdGiist25uIS7T95A4dOC22eK+tKbWPZYxnyX70ZovPCpoI2Y9E4O/v4JBtUrsC5jXLYjOXDtmRVB7FU1q49ZPl16bsagjahgnN/7BwnOWSKr9s45uii+eTY9rIXKK9uOLC4H5Bgdrpv7aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186318; c=relaxed/simple;
	bh=6GCq2mP1CgktVBE1+BslXj12jrtBZe1IUro4bZq/NrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HWdfZNaCjgpflJEn9jPsy5RFoPi5n73Vic3ddogCM+jy0n9Kaeesl5Vx4lHXKOUjNQ0X9eBxkVRc2TnxLRuXgqiWiEvtX7gCQsz0Z0es8NYQ2IlEEZPeofUMM8YJwQiXuIllgVOBUkolXTg6uruwO/5vY5McPhvXJbqH7n+ohXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NiNvym0g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BF3ORxzo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NiNvym0g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BF3ORxzo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B1AF21D0013F;
	Fri, 23 Jan 2026 11:38:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 23 Jan 2026 11:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769186315; x=1769272715; bh=Eqmas0Pmqj
	QLknOiB4b7zX1xWYTiaRmC34gIIWOqysc=; b=NiNvym0g1AJ/22bRn1O6UBIHgc
	jG1MthjHz4oCoQ2c4YAhX8qs0vAt6HFqtlP6e4xXCD50NMsRw+0Q6O8+ealirvGO
	0PjZrAw14YN1994ssrdYrUReuSNSdIkEJXkKUuByItA9nSDNQmbUgoCJqIX1hX2F
	FHWGwXgI2p90vEoyS0Z4mLRy3FxjHy+brGMwG3bDx3RbUquj4UBibEwDgZOKV0Rd
	ADNzaLGTV1NSCuTNXMQQYMronGLvs56lWXt89xdybt9fjLg4iOk4sxIk1WWZxWJz
	SVXujZb8iLGHv9IVoTLrqPh0NMZ3aJy2Jac/JA/PTWRcuFLlcgPDbTDfc4ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769186315; x=1769272715; bh=Eqmas0PmqjQLknOiB4b7zX1xWYTiaRmC34g
	IIWOqysc=; b=BF3ORxzo1hpKA5R7EQ696MDeqH/i/rsekYEjUkOWa6qZoWUqN0r
	j2tWM6TEV+SqxSjccBavaglN793yFOGN9/TWpRBUzsqojS3K5138t9YMXG0k3oYX
	aDW5Bx1bJfaRsLvzvZBIbYtkQfEMkKvkXwnHLKAKfsmkdsR4hzikcp7A37HsWAgk
	+V9tcD2mfXm28ehawoHE0LL3S5ldi2QsIrzXZI0kevSUNeg1DtpO1Q9OiEI0lolK
	hbH2YOejDqC4Wcw7NgRdbbtr1VNAF2gVsG4zs6dVRY3F1Z/GUW0dJyYPj2t0OhN7
	Vz+EPjn/uqXvS1buF2URWiAvDCs4RKTty3Q==
X-ME-Sender: <xms:C6RzaXNAKSlsvIfj9YhIKGtdLzLctZ-_4pAN27zFiPRota3OajEm3Q>
    <xme:C6RzaUijL-0B-PjUqy4iNaFH__edDcJ2c5qwsJ7rxJDKiUYLZo0ygjXCe2RasV3rU
    wb85PbBmpVQoSXhY-Qt_TqkDlOxnH_8r2wbsSCDxH_TYrvIbPbWUA>
X-ME-Received: <xmr:C6RzaZ4KeUf30WapDOxwXVw9VtNoAIWB3KZo4TN0JxKYBxUDUwhq5UGwFg0my9Uk2xIg_CxRUMUj1HT6NNlbygQGKxqs3ejK8jYWano>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:C6Rzab0uSAkL42VSJLboitAUQ7PrbPI_iOXJEmdPecK53_I8vV2w-Q>
    <xmx:C6RzaUvkdUu7LoleHdPMMvfx0svfvZute4qxFY2mjblTFst2cFyidQ>
    <xmx:C6RzaR5ME52NuK_Pcbh2DVrSNBuOZMYEcS837xhvhUQYTg-UKicCZA>
    <xmx:C6RzaQdZSTDm5hVhPITAw4CrGrs4bx0JultdFkmUqAcMkZFOSviqiQ>
    <xmx:C6RzaZqWjdI6dwlu7eUO9A1bvfrSSywMQmmzk6dsWTAz-TnenpzKaFrS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 11:38:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [RFC PATCH 1/1] add-patch: Allow reworking with a file after
 deciding on all its hunks
In-Reply-To: <e98d8aa20fb4a82b93b9887e38eb8289252b936d.1769164663.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 23 Jan 2026 12:58:45
	+0100")
References: <cover.1769164663.git.abrahamadekunle50@gmail.com>
	<e98d8aa20fb4a82b93b9887e38eb8289252b936d.1769164663.git.abrahamadekunle50@gmail.com>
Date: Fri, 23 Jan 2026 08:38:33 -0800
Message-ID: <xmqqv7gsi8s6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> After deciding on all hunks in a file, the interactive session
> advances automatically to the next file if there is another,
> or the process ends.
>
> Allow for reworking with a file by introducing a what_now prompt which
> allows for navigating with J/K or advancing to the next file if there is one.

Describe "how" you are allowing these new things that users used not
to be able to do (no, not in the "by adding this variable and
switching on its value" sense, but in the "now deciding on all the
hunks in a file does not automatically advance to the next file, and
the user has to do X to move forward" sense).

> -	int colored = !!s->colored.len, quit = 0, use_pager = 0;
> +	int colored = !!s->colored.len, quit = 0, use_pager = 0, skip_what_now = 0;

This is getting overly long.  Wouldn't it be easier to follow if a
preliminary patch split these existing variables into three
independent definitions, and the main patch adds the fourth one?

> +			if (s->file_diff_nr > 1)
> +				prompt_whatnow = _("What now? [J,K,q,>]? ");
> +			else
> +				prompt_whatnow = _("What now? [J,K,q]? ");

I wonder if ">" has to be made so special.  Wouldn't it be easier to
reason about the logic if ">" (and probably "<" to go back by one
file) are added to the prompt in the same logic that decides 'g',
'k', 's', etc. should be shown using the "permitted" variable?

And when the inter-file navigation is in the permitted set (i.e.,
there are multiple files involved), you'd show ">" (or "<", or both
if you are dealing with the second file among three files) and ask,
instead of silently moving to the next one, or something like that.

Organizing the logic that way will also allow you to move to the
next file _without_ first having to decide on all hunks in the
current file.  Just say ">" to deal with the next file first, and
after you are done, either come back with "<", or the system notices
that there are undecided hunks in the earlier file and takes you
back automatically.

I also have a hunch that with such a code structure you may not even
need skip_what_now flag, but I haven't even written the code in my
head, so if somebody tries to do so, they may discover the reason
why such a flag is still needed.

>  		strbuf_reset(&s->buf);
>  		if (file_diff->hunk_nr) {
> -			if (rendered_hunk_index != hunk_index) {
> +			if (rendered_hunk_index != hunk_index || skip_what_now == 1) {

Style (which may become irrelevant, as I just said the variable may
not be needed after all, but anyway).  Elsewhere skip_what_now is
used only for "is it zero, or is it not zero?".  Comparing
explicitly with 1 only here makes readers suspect if assigning 2 or
70 to the variable has special meanings and wastes their brain
cycles.
