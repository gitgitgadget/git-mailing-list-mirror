Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989A1C8630
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052479; cv=none; b=WqtK4x3W070PODjUf3/RuSS4yoYDUUiq5nvR7x+Nr+prpHEX6vG2mZpCBeXw0rkpfIQvycvMSxSpRXaGCvJWemUqf3V63mG5Y9s8DH/C/GEItDpsibSggCwrdI2EsXmjArC7qtwFFcfqKe6R24ldaBPMSUcZNNV5Ep8TZllF14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052479; c=relaxed/simple;
	bh=uCuHH/LLfT2EbH2hje7DZ5v6YzNv+OiReYgP8cTq8QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e75Z1MsrFhV1ukQnmwDhi1A1ILoNE5drzVe6EcsExeYfLg1KjuthriLv4IMFwHMwUAkLs9Qwjyrl4IDxF5vDy1CL9sV5EC+mmeTWld/jzrlr2YPqfMdtAfH4QGfYi+PUqY0MXzNSOn76o8/4mNoD01oUUE2wHe6ZlHJjZGIucjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XKeDXrYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YiVRe+8t; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XKeDXrYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YiVRe+8t"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BEF257A03DE;
	Fri,  5 Sep 2025 02:07:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 05 Sep 2025 02:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757052474; x=1757138874; bh=rKM7eIwDz5
	ZovJqHrt8zyQ2oifpmw63Qb3LOSzI/H8I=; b=XKeDXrYNEZLpqpnSm4xOZO2ELi
	UP96ze6pvHIx5NrZrWMhW3hFARtGUwdLv3zWpi4TeXhFAYJbcvdOzE0dgusmFokX
	5wx5Vls1I5cq89w8s37aRQ3ELkIv7Fyv6XLgzyZz1j1LW/VWlrSzB4kI/0yasmf3
	zNREwdEu4kwNswBCzvdyB5QMWhKfz6BTkqZ3uucFpVIJh/SVC3wjGaEs1nxr1h37
	8VvK2K6A656XuQR1YE8uyAYMo0nCG18f/JxpeHMqRhc3PEA/n8COBTlZUiZeObes
	zb44Vwpgq1kvNAZ16HaIwx/8+RhV83coXeJUbvcScTXcL28lIs5580CrF5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757052474; x=1757138874; bh=rKM7eIwDz5ZovJqHrt8zyQ2oifpmw63Qb3L
	OSzI/H8I=; b=YiVRe+8tGOdqF+hie7B0BLmm0qvtGmQf5CLK3IRrrFiG1dWzasr
	FKxUQ4QEWjH0nURZD0ik+oECktFYIBY+jnTtFzKorIJSrhFzjx/UIOG6jkY1F/TA
	oV08Qw/Pz/gr3E6iixM6KWobc2W8YjzqPugRnnAxnYFxfPkNaG6WciOraebGaGoo
	hiAMd3OC9S86vI3An/3AY9CRBV/abFEx0NMPnk7UCntlsuWEbss+nlw+CUusMvUE
	jNUSbZ86K3DOEZr9Epx0XIDDOqyf99bm7h7mtgVxi6SXKrgTczjCc2mGmiWr8N/c
	5o34G4YRc9KC+RB38F148B4HE9Bki+ddX0g==
X-ME-Sender: <xms:OX66aMuyEOXdHe1dlX2fmF87CzDuUm9ZCK0Xaf9noGHz-HUHkRWZ9w>
    <xme:OX66aGk_-Jqp_gQsB1r_fgyKOjePG6mxWpHHKvBrbYsJNbQHMsu5pgWJ43IYmZm0y
    0KOuyJHeeoVEgL4Ng>
X-ME-Received: <xmr:OX66aGyvc4tkCS8GXZ7-wpNEDKDmVPHsJjmbfgMORAtCi2WKj688pQAgiJDQhrO09-Es9BiU4Pyfa_Zr5uGo0Zjww5NUgz9yq-Jp6fegOS2B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdr
    shgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehhuhgrnhhgshgvnhefie
    ehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:OX66aAMBpgXGn7jIPgXp3XHByJeNRlD54E4-jnVaiUuwVqQEcrLlpQ>
    <xmx:OX66aKphzAxuMZtIoftLkgxedCS1sxf80xFuWspw1XwE_DVOiv0mUg>
    <xmx:OX66aBGsP9ASQUAOhTnw4p8drKCWwjg5TTa3eU6Zy5khHfEBTUK7cg>
    <xmx:OX66aPr4TCEWoCTfVCkLxWXuY0rl8iMhLpF7iuKZra2DOnuP7ko2AA>
    <xmx:On66aB0hUywIQ3L2tK97XobMMSweJlloqn3pgW7wbZE6SrOhrawKn3xB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 02:07:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2081b33 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 06:07:51 +0000 (UTC)
Date: Fri, 5 Sep 2025 08:07:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
Message-ID: <aLp-NA6FIIX5k7xh@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im>
 <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
 <aLfHvl5JuttXrI0y@pks.im>
 <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>
 <xmqqcy87fkhm.fsf@gitster.g>
 <aLk7QEEWy4nWxsQK@pks.im>
 <d990d908-5513-4f35-91ec-ff860ca126d5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d990d908-5513-4f35-91ec-ff860ca126d5@gmail.com>

On Thu, Sep 04, 2025 at 02:30:58PM +0100, Phillip Wood wrote:
> On 04/09/2025 08:09, Patrick Steinhardt wrote:
> > On Wed, Sep 03, 2025 at 11:40:05AM -0700, Junio C Hamano wrote:
> > > 
> > > I have no problem with that.  I am still unsure about that "reftable
> > > cares about the name being 'master'" thing.  If that can live with
> > > any 6 byte name, we may want to fix it to something different from
> > > 'master', for the sake of removing 'master'.  Perhaps 'banana' or
> > > something?
> > 
> > Huh, did I miss anything? I scanned the thread for reftables but
> > couldn't find any discussion around it relying on a 6 byte name. Could
> > you maybe provide a pointer to what you are referring to?
> 
> c.f. <xmqqwm6ozn7d.fsf@gitster.g>. In t0613 some of the tests check various
> sizes of things in the reftable and those depend on the length of the branch
> name

Ah, makes sense. Thanks for the pointer.

Patrick
