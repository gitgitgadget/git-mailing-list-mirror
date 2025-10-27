Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC97081E
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579328; cv=none; b=kIcaTt3VmqlzVlQnepzUkpw4KOoKrek8bb3kgPiRWBr9BcU/XH0ADNRCWhf4EhDtnJ2tNH1YqShhhvRY7qnAo0+A401rkbg3no11TsDgRU0UrA5gBf/N46nDfLUw6BpIBEXu33pZ0Y9E2DgYnm2l2yBNZg5wE3Xx6YLF0OLQmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579328; c=relaxed/simple;
	bh=NOs6HW/nEOYadETSu6naimpNgfOmEwn1DAKoExLRX6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZ5wvoJIh0XgYUqnc9KFCytzUadGw8BtioMth+Hd3LzXp2+OrMRkuGL9+VEg1LGTG10PXjd9WftDcnb3oWRQJqDd3AoCOhWdPkf030LCwEBBOM4M0KikQSTS3J3OS8CC+emloD1OfLJIF8tIjY+VmSQIMCIA1EJd2UQPzHvqH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cNIPuci4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=feNJcn74; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cNIPuci4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="feNJcn74"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 604BBEC01D3;
	Mon, 27 Oct 2025 11:35:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 11:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761579325; x=1761665725; bh=41h1aXyksh
	/ymbd4eL6QcbNMotIlHuhpaV3WF1iB82A=; b=cNIPuci4BeB2ThdTmdD2L4ptne
	R+udFfov1Gl8rIsWufPdUvp28LPUiv0kD0nYhHhMWxIhLuPIOT991rkYxhivlpfK
	fD/3NY3RD/AKzizkgWp/YH+bJrfxdJS2GEBa2/0kpgIRQpaRFkbsx0Eo3Vi599D0
	hNDCQoAMarpwjwCo0ZoPJnF2LATPJ3X1tBaRIS7/m9PZoFkFi9/xDG17MdvxGCmx
	Vbw50EkHGC8o8Zp7VGqzRlEUhyTVBWiolPoALyd1pzK40voU/F+5+4anPM4A1jDt
	fTCTo7pGjdll9devXvWdJ79Gfe5c7bZOiWxSsp3qgKRvLrXyxPxIWU92SOsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761579325; x=1761665725; bh=41h1aXyksh/ymbd4eL6QcbNMotIlHuhpaV3
	WF1iB82A=; b=feNJcn74CGlx43R/l0dH6re4jQEzdsRIWEAv5isx2DPPNMaUQaw
	YZD6IZjwuyDRq8IkiixWKlZ/NDwm8xvXlbUOeAcu9nqjNtZPG3u/WntDKkHU7mVd
	BulfhQpxKJgU5ypG9eCkOPWJgbmRSFkRj7fDTtEhT/3Fxhm01UoUDWPM/j+ONygu
	JW9HPLaHYcTniZf7cgI3xsOPy9EPS0WKQWnyfq9kQ0edoP7eGrEu3iZHKAovccz5
	QG932M4RlO1X8ThwIzcYmp2aa+DIXjOlXlESrj/7t5XAwSrD5PSBo3xcDAyop40w
	v9wOSrMAA5K5adHiw3E5/MBhVH7BUR++d+Q==
X-ME-Sender: <xms:PZH_aFMxq1diDjIRtHEmMbnx1NjEy7AlYm6lk-5Yp5yrgAjdwxavHA>
    <xme:PZH_aO9S5_cLyjWR3RS-HXaZAhHa2UQa6N15EotVMK0uQFC83QZsornZQiyH1laiN
    kDhe8CQ5MhRwQZGWc9nA4XHDS7PmRGAHgMc1jyXgb9NpX3awDsXffo>
X-ME-Received: <xmr:PZH_aJQXP4ZzCWke7WVr3X1rGo-WcTguYGtdarmG0x1KtRIwcgxYpcxnAA0jbJLWKrqNiLv7Zv9rxBr4Gy0aKXZndNh2iriF-jGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshhruhhtvggvshhhrdhoshhssehprhhothhonh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PZH_aAkQnMUvqJnWbooqRH_HkStO9UN--6PqhIaUjqWpthkWwvK8EQ>
    <xmx:PZH_aJQfaJ3jyX2vDlC5BtZMVReRBU3___Y4qWWA7rXOhD2-w6V4nQ>
    <xmx:PZH_aOO3ulQ91YRygGQCY2jRuawB7gaWx3vA5KSVmRj1CMoERj_45A>
    <xmx:PZH_aCVR5bsQ_sOq7jz6o5Vc45jD9H7Qo2jtQhNsJNBQSlHwRsm9rw>
    <xmx:PZH_aIViMb2cB7OC5pqEtSBMf1tLutn6TDVHLbTK6USYbGp377Oj_bSz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 11:35:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
In-Reply-To: <20251027142902.GB2758515@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 27 Oct 2025 10:29:02 -0400")
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
	<20251014003404.GC1507@coredump.intra.peff.net>
	<xmqq7bwltlb8.fsf@gitster.g>
	<20251026152614.GB2095501@coredump.intra.peff.net>
	<xmqq7bwhmecb.fsf@gitster.g>
	<20251027142902.GB2758515@coredump.intra.peff.net>
Date: Mon, 27 Oct 2025 08:35:23 -0700
Message-ID: <xmqq4irkl5ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> I added the "limit to known bad case" in the illustration not for
>> performance but for correctness.  This was because just like we
>> weren't convinced that the "**/" may be the only case that breaks
>> the existing optimization, I was worried if stepping back by one
>> byte may somehow make a pattern that should not match mistakenly
>> match.
>
> Hmm, I hadn't really considered that. This is mostly hand-waving, but it
> feels unlikely to cause issues because we're giving fnmatch() more
> context, and never less.

Yup.  The above was an explanation of what I was thinking when I
wrote it, not a justification.  I haven't thought of a single case
that it would hurt to step back by one byte.

> BTW, there was another bug mentioned in that original issue around
> backslash handling. I didn't investigate it at all, though. It didn't
> look like it would be related to this optimization, so I think we can
> just consider this fix independently.

Hmph, backslash is GIT_GLOB_SPECIAL so nowildcard prefix would stop
before it.  Could it be that we mistake it as a directory separator?
I _think_ we are still cleanly distinguish paths from the filesystem
(which could use backslash as directory separator on some platforms)
and the pathspec (which defines the slash as the sole directory
separator), and have platform-specific fspathncmp() to absorb the
differences when matching one with the other.  And nowildcard_len is
all about the pathspec, so it probably is something else.

\Thanks.


