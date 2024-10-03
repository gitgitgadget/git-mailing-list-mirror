Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3319B3EC
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970003; cv=none; b=dERCTrnsk2EPrtQl4Zf9FZ5rzlni31j265SskLQXxzjDU7gQsHY6hKKX1AOCxgv9OctyrVXor1qDFy11UEn9M3YaoKkCva3ISkDTbDYYtoaB3qsxL+DztTjQE9XCmTdQp/eiFbZEhSApuxEB72fRSvBdo8QwTBoB16BEstooIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970003; c=relaxed/simple;
	bh=SNAKr2a5/g8xJWfqD9ON9Oxg9TNd+eNbQyVDn4/FZgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sAx7ufxFXuDZd7egb2CLgUCAGken5qdTw4ooJgjyxghLOu7Sh3Tcgr17/20KT9+wYMWu13EBKGjZC9Zf82246cSyW9GXB6BbHdJuzTZYroQoyPvpwUWYmxFWBa0zKUaa8O9zJKlFRIYSssjprHc9uR2TPrC4bsU3moPlEBd39Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VU1Ty6Bp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFT7FIRv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VU1Ty6Bp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFT7FIRv"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D133A1140175;
	Thu,  3 Oct 2024 11:40:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 03 Oct 2024 11:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727970000; x=1728056400; bh=ew11Cbn7e4
	YDGEfTkK/Dqm7VzNLpGu5xSknZaytogDc=; b=VU1Ty6BpDqCyJUURqDNRKLjvoh
	o2nA3RYJQvnZUc3SZ0BlU31YPHnBQXrAh1JttHx8kSvhh7dJ67wrPr8eZvZyZbdk
	uZPSSIx9fqH9MOlcD/VhUR4jM5c/XzC2DXqeIXxUhZtMLwn1LhbRQ5G8lvMgK00+
	6BbNqcCyURx4ihAkqzXEagI8uV/EM24GcZ3DK7Mde+bC5rU9fIXRbJ9L3IZHnUMU
	dX+OMxHmx65yEfwOiX9+vWRDGsNDnoqWrGm7LpxDlpWMYbL2dbsGbUncAF6+GUAo
	e/5JMMcZNDgwlBf4r+Q1VXzOXNgZIzrYFm4JxQ9eAWMOz/TVLeFKfmCSpK+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727970000; x=1728056400; bh=ew11Cbn7e4YDGEfTkK/Dqm7VzNLp
	Gu5xSknZaytogDc=; b=fFT7FIRvbOmKFJuG0KalUSZne/o80qlW621bs7FoT4+C
	EDeu2WdHQy27di1FXtxyP1navihSst9or1tB3cfouC+JxoYbHax6fJAalLF2P9xj
	bJzOrLZA/QUgvEk4EBplP1EC1rjptkVR2cPiuH9n91XjYgFlWYmA75HtZB0qY4oE
	vQEMZMXHL4GQJRm+VDh9qaSDu9REKbU7scPiQKM6V4zOv2MouTf1J/U1YCy9sUxl
	KQhpR7+zY/VE1Ji2G2TodOde32kapLX//0ZxhLiawFmgTr38YyrbwLTWGyIAlh+Q
	whPEMaNz3zgjjepOlLABpy4dnj8kPDiLLWDpfjT5fg==
X-ME-Sender: <xms:0Lr-ZsVD4JB6HvGm9Dj7CGo0XX7BKp_pjHNHRNPt8K4yO9KJyKIDtA>
    <xme:0Lr-Zgn18cNu2t94uyINUTfgX1jxRoyLrxjDEuhGFBPtBG4jDzc9g58cLKs5_6SW1
    Ce3CW-3gA7e3YhxJQ>
X-ME-Received: <xmr:0Lr-ZgbD13lT4RWUW41JoZ8Hu73WX0cKyxEjqSC85SvjEofVg6gPHp-2xwidKYyP6OKt5upZCJ9ZvYwc3l_3GG2fJpAJ21BmoEn2AmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehsphgrrhhrtdesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:0Lr-ZrXZgPzRH-CSoqT-cCxazLWuWjDZJWz9HTBk5qUkvQ0WDw7dkA>
    <xmx:0Lr-ZmkUlSteLZ-GwwhfmeyKEcXEc2bJf72_TqprDCiNnaoa_Ih1zA>
    <xmx:0Lr-Zgejgt6obNxQLNORwP4AT4y4MXIhsR2YxqmmfnDSTyeO1tKsAw>
    <xmx:0Lr-ZoFFKes_Zi4jYHV4yZNFGdRrvHjbHH1fXQetfHMi3KosudfUYg>
    <xmx:0Lr-ZnCjE3IhpPDEGwYpzftn7qaXUh83-_8i02rOwGHcT9G9FbqTGm1I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 11:40:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Sparr <sparr0@gmail.com>,  git@vger.kernel.org
Subject: Re: Lack of system-level excludesFile
In-Reply-To: <Zv5SpewqUmlvhOl-@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 3 Oct 2024 08:15:33 +0000")
References: <CANp3UNBGd=jiSZyFSAdPjayvgHbP5SF4Dm-uCNwna_H16bRgRA@mail.gmail.com>
	<CANp3UNCXqLJmAj2Vc7jB+i9qRjfKzrri_Mr9VvG4J5tUR-1HeQ@mail.gmail.com>
	<Zv5SpewqUmlvhOl-@tapette.crustytoothpaste.net>
Date: Thu, 03 Oct 2024 08:39:58 -0700
Message-ID: <xmqq34ldjiup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> So basically, I think such a feature could be useful, but I also don't
> see it as immediately necessary because the global (per-user) file is
> also generally useful for this if the user is aware enough to know it
> exists (which I admit they might not be).

I was around ;-) and the reasoning is exactly that.  

Per-user setting was considered the most appropriate (not "good
enough", but "more appropriate than system-wide") primarily because
the exclude list generally is just as personal as it is personal
what editor is used.

The same reason led to the thinking that it is perfectly fine to
have "*~" in the list of per-user exclude patterns for an Emacs user
but it is dubious to have in the list of system-wide exclude
patterns, if such a thing existed, when the system is used also by a
vi user.  I do not think it was explicitly argued, but it is natural
to lead to the conclusion that it was not worth adding such a
mechanism.

And that led to recommendation that these patterns of personal
nature should be left out of in-tree .gitignore file.  The Makefile
and the project source would dictate what build artifacts are
expected to be created in the working tree of a checkout of a
project, and in-tree .gitignore is the perfect mechanism to mark
these *.o, *.a, and *.pyo files to be ignored, but because not
everybody who work on the project uses Emacs, so "*~" falls into a
different category from these "usual build artifacts" and the
recommendation was to leave these outside the in-tree (or the list
of system-wide patterns, if we had a mechanism to specify such a
thing) .gitignore files.

But this thinking and recommendation changed over time, and I think
people (including us old-timers) take a more relaxed stance these
days.

If the contributor base of the project includes both Emacs and vi
users (and in this day and age of DEI, you are encourged to be
"inclusive" and prepare for the folks from other camps to join the
project in the future, even if your contributor base is solely vi
users), it will not be likely that the project wants to have any
files that match "*~" to be tracked at all, so having such a pattern
in in-tree .gitignore file to be shared by all participants would
not hurt anybody.  Emacs users will be helped by not having to worry
about configuring their per-user configuration, and vi users won't
be hurt as they are not going to add a tracked file foo~ to the
project (and alienate their friends in the project who happen to use
Emacs).

If you take the reasoning one step further [*], it may make sense to
have a list of ignored patterns that applies to everybody on the
system, regardless of who they are, what editor they use, and what
project they work on.

Having said all that, wouldn't that be already supported?  What
prevents you to set core.excludesFile in /etc/gitconfig?

Thanks.


[Footnote]

 * This may be a larger step though, as the set of projects that a
   single user works on is much narrower than the set of projects
   that any users on the same system work on (hence the types of
   files that are potentially tracked by these projects are much
   wider for system-wide exclude list to take into consideration).

   On the other hand, are massively multi-user systems (like the
   time-shared system studends 30-years ago used at Universities)
   still a thing?  If not, then having a pattern that may hurt
   people with other preference on the system-wide list would not be
   a problem at all---after all, you have the entire system without
   anybody else.  But at that point, system-wide and per-user would
   become the same thing ;-)

