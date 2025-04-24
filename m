Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EC19992C
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502579; cv=none; b=QkHlnVvIaCLwun5nEg6SgDs16GgGWyg4lSOggeZ0PGnmQaOmnXHpRRPj6TrBswHJXMKNH90mT/722l4h9LWLN00vlb8HGVgzXlWtWafy+tUdet3TfhS4n6gv5l0JlTuWqX5EVrA0KLa2immWedX964Sfq+zLoVpnhVdPP8vqXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502579; c=relaxed/simple;
	bh=WsjXJgEfYwieHzUOKedmUgGVPDc9vczBr4XaRGMAeWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDeD79gwpAe+UXQVD7g5/0ccqeSphMrkvCyxynCjqIs82Li134dIaQ/3mXjpH+wC5q7SV7g/jQkLIFEzgHg4Z3E7Do57SiA/vNWOIv+dL22eHcl99L2y3IeJx8reXUQQbnm6PhvyBscxyBm9imE+DMVMQfqmbNDZM0jPdY7/uMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zKNsJ5st; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmVLrF0y; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zKNsJ5st";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmVLrF0y"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 70EE011401D8;
	Thu, 24 Apr 2025 09:49:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 24 Apr 2025 09:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745502576; x=1745588976; bh=BukCF+1aQs
	ylgyKs+QOxrwym61S//QlTOkK/FYYQ/LU=; b=zKNsJ5stXoE2WT5jlj3LBw9ni3
	cFN1J3ZTfKN2U5QYxHjUfsXq6r2JD4FVN27vSFUULuAvJl+jcS/miM92lhmSfomH
	E/EJLp8LP1IaWLB9Pa+aUjM8CFfMj8dFAHsANN1E5U/VX99cR0edPjNKQh3Se9Z8
	GLrEnTCePcnyz74nLZd45WAcZzEDcVKrsGbMEp4qfwzTwpYVnfFuq0gM/4SW0icI
	P1d4iDt1yCImOgxUxvxg3AJGQWQL6Cvci02TxPgmbGd/Tucdcecz/4F/OqiMQ9k7
	cfQJ3rwxnmwLn/AuqlccGmWtFQkJF3drieCU6pHAgmXswYVJ0Xq3s9YP5EHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745502576; x=1745588976; bh=BukCF+1aQsylgyKs+QOxrwym61S//QlTOkK
	/FYYQ/LU=; b=jmVLrF0yASxkO1iicQrC+W/SmEACo/bsMyYcxQnZ9teNpcIuH7v
	PGm784a4s3E2wpAlPUTbwQoH+VeqZmDeI3NW1J3ZVH6bE/+cJnYjnIxefwFA+j2h
	8b9PDdOc7QvhIGRHZ+GeLgYdUG5SHQh3+pAcx2D9q7htkMcYAlz7cOvah3NYkrfK
	86ZZ2hsZfxyb42gPPRWBulhR98AFFG4s6at/wzRZ56Xu20Txp+XBk0kOMHhrWHNK
	Bb01DVVJgfVnlKoudWBcfGR3FxYIssOrxEqFYHBga6VKKA3Eo2a2NQ5m0unz1v5A
	BexGhDWQnyWmUu5E7NUNpYBpIQstezzVuTg==
X-ME-Sender: <xms:b0EKaN7ZZ0wr3CMcMiT3iYgP81KX3oRLfqRQ4BTnLEEmgety3B7MnQ>
    <xme:b0EKaK5Tk3oLjPodjge2TmTXrGYDRa_WK6ukrwEpB2Jsvcg-5I_7d-PYQDFI2uR9e
    iRnKDiRBD4wDJYPrw>
X-ME-Received: <xmr:b0EKaEdNsY09bWhSgDUR6VagMiZZyJnnVRzW-T4-b7eVcLwldOfPS4DIPrJkL4NK02MnYMtCEpCui2qlxWTfxMhRE0zV5EHveaXVopY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrgh
X-ME-Proxy: <xmx:b0EKaGIdQ7QOcrRPUVz6rWUn7o7doYm88QeYjqBDa_d4onFuO1ZApA>
    <xmx:b0EKaBJTlVvvyVStF4qT2q6LH4eae5tZJ0Zltnww2GFI1K3iQKlJ0g>
    <xmx:b0EKaPwmtdjfR73dvFLFFXptfayS-wd4fu5s7zzR_F1u-_RyhavOdQ>
    <xmx:b0EKaNKSFfEFLZwQfz4RmXO0C73ntA492nbrMrCmn7jryBrq0lX8BA>
    <xmx:cEEKaN9yjaqab3n7xNkXZAJGwH8QfnaWECpmwk9l_pFp4jPyQcGie_AH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 09:49:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa5222a2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Apr 2025 13:49:32 +0000 (UTC)
Date: Thu, 24 Apr 2025 15:49:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
Message-ID: <aApBbArLEq9dSIYr@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
 <CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>
 <aAdK9gnXOO3ERq7w@pks.im>
 <CAP8UFD1zqAk1_Y0ECu4=iyeF4k4LagfLgHWkEr8iz8ZnwkVT8A@mail.gmail.com>
 <aAm-pcIfrFt6mjlV@pks.im>
 <xmqqwmb9vmlw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmb9vmlw.fsf@gitster.g>

On Thu, Apr 24, 2025 at 04:13:15AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> I was more expecting something simple like:
> >> 
> >> if time.found()
> >>   ...
> >> else
> >>   error('Benchmarking requires the `time` command')
> >> endif
> >> 
> >> in the same way as in meson.build elsewhere we have things like:
> >> 
> >> if not msgfmt.found() and gettext_option.enabled()
> >>   error('Internationalization via libintl requires msgfmt')
> >> endif
> >
> > But erroring out by default doesn't really feel nice to the general
> > developer. I'd claim that 99% of the time, developers will only end up
> > running the test suite, never the benchmarks. So the default should
> > match that and not require GNU time to be available, if you ask me.
> 
> Maybe a stupid question, but does "time" a shell built-in count when
> "if time.found()" is evaluated?
> 
>     $ type --all time
>     time is a shell keyword
>     time is /usr/bin/time
>     time is /bin/time

No, it doesn't, and that is intentional. Our benchmarks explicitly
require GNU time because it surfaces more information than the shell
builtin.

We even have a `USR_BIN_TIME` prereq in our test lib, which is
unfortunately way too limiting for some platforms like NixOS. Maybe I
should use that as an excuse to also refactor this prereq while at it to
instead use a path-based lookup of time. On the other hand it's only
used by a single test anyway, so it doesn't really feel worth it.

Patrick
