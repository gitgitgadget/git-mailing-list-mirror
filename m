Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96D2D3A72
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548143; cv=none; b=HYkOb/mfZ8tBVupnoj7IDjF6s25xt3vrFCGZJ8LOF45/7HlPFN8QOQFqlFm8pS7uYkts1A8Mpz3kAqbl8JaicOariWKOZmAD7bCzQx7/+j0BpJ/Eh1mUDS2o5Qp8DVwCrKBhmeC0nuSenQe9542cfitH8V4KODtdDgAJQ2q1mDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548143; c=relaxed/simple;
	bh=ebBepql+/RgqMQwnWQsJ5t9EI8A2DYDYECr+ahkyP7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkgQWJvUckpwcTdsGXEx5JmiVec7W2eh6fTHznV+7AZMZuUFtuxuzhSi43OJNXDOpjyDn2lWFCBOChrrvzYRK5EcoRAeolz96bfTwSKjdTjZK/zA2GLUcQp9zM3AN3dA9VobfjqaTLRSVVNKn5fQFdix+tqlr9KITVUWQTgVZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uy2/SQSf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jv4YSfln; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uy2/SQSf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jv4YSfln"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60E9A7A01F6;
	Thu,  3 Jul 2025 09:09:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 03 Jul 2025 09:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751548140; x=1751634540; bh=tapVxQGPzj
	8sqXfIr4uWqWwFpVYUzokrVs0TLtFKTkw=; b=uy2/SQSfzzuFPGAU0hzbkaY9r7
	gyBEEbb9r1AV8nh/cXvWP2bZaH6DyOwmsqUkmm98KyP4lWyjfRDEw3Pl07fVfKNe
	q8RHBvT6MjzyXJlEWokRdu9bMjGcEBE52O9IFZp25hG4pWfrCZtlQu2fxoifjxx0
	38KS18FtMITyKtGxc8XDg1nNKPzw/lTpbqQpJSI7imdcW0r5uqvHNTKk5GB69AoK
	y9fMGZCh1yBl3wLLNQISSV6e8riy/P44Bk5lg0ejzrU0xljEfNLKcWJNkxpprCUe
	tPjUIfBoB/0goFDn86KDvae85w7jV9uUPJDep88N9/0qv2FKBbxJON/j+iKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751548140; x=1751634540; bh=tapVxQGPzj8sqXfIr4uWqWwFpVYUzokrVs0
	TLtFKTkw=; b=jv4YSflnZ5ZsVVPn9l0i0Rs5De5cZRbX+EKTTwu6oR6ZcTa1gOW
	wUdlqUSGeMHqI0vpC5skdmJbi8nKHkP7gx+y27pWZpLLWLxIv/ak5ofyfk0L1rDl
	xbac2eChM6Kc+9q7xiSmbe5rRRDXSuXmGZhYmMMboRVjmHcoPHMoq67/vsza8paC
	4hpsq3GCXRaWALMN/J1EQO2NNe7A7RDWA/MRiWpp2uaJUtRj0s//To4e4RKzj3wt
	ekwp5ZW9cYFYUdUPtHLh70GxOgpnEuwi6aFMCqh4H+3kUfmlBc+cB9R0SIfstYbg
	Xpn758PVhwzTetxquSVl0cjK4OZjxyTQnhg==
X-ME-Sender: <xms:7IBmaKgy8N0f_MYDsn4yr9dOuNbUDyk_DR3aEAqBkAco7sfnKlBRXw>
    <xme:7IBmaLCdnvcdQRytjMm3PyIlNTSZFkK44wRASnm21YOEGQDqisL8Fv23trclE8ZZ1
    nUZU4D-bugea1WHtA>
X-ME-Received: <xmr:7IBmaCGc1eVjE9uIvV3Hh2uHmAFENvx7lOaAvDMxlbBMAF705CKhE9xl-zaNhekYyW5amuFLHeOqpz6Wsg15Gvht6Rb64BM5UED3OUhYyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggvrh
    hthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprhihvghnuhhssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7IBmaDSMiJeox3JvxXsFMA_KpquKopBNNzdhI42YCBCoAaCFg5WUUw>
    <xmx:7IBmaHwuTsccmjko16QPzikowyFE7t-eXhWdaEaUEQNUQzOZ7sKi3Q>
    <xmx:7IBmaB7PQ_2nSGWNbKBJdvLk4D2LNhUqihXQWBWS1hmUZPr5YWxO9w>
    <xmx:7IBmaEy1OSjXHO4Q-Ic5dsKurywbYN-dw0tPdR5qIWDGCqmiuIq-Mg>
    <xmx:7IBmaDNWaIGOLH4IdyXWAAWkZgs6M9U826h7dEg4nQlMDYVuyo-8C-0l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 09:08:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 933a91f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 13:08:57 +0000 (UTC)
Date: Thu, 3 Jul 2025 15:08:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/2] BreakingChanges: announce switch to "reftable"
 format
Message-ID: <aGaA5iwZDuougIwQ@pks.im>
References: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
 <20250703-pks-reftable-default-backend-v2-1-5a27e72a8c5e@pks.im>
 <CAOLa=ZTJOqqr25Sj0YSAc9rDmar2qZiVD3H+K6qhdN3qKdqbGw@mail.gmail.com>
 <aGZslJSks2GF3uB7@pks.im>
 <CAOLa=ZQUp6S3yQ-zCfPxCvwoJeiPdXh5U9mojH+9-P1RAAa2gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQUp6S3yQ-zCfPxCvwoJeiPdXh5U9mojH+9-P1RAAa2gg@mail.gmail.com>

On Thu, Jul 03, 2025 at 08:24:01AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Jul 03, 2025 at 12:54:24PM +0200, Karthik Nayak wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> > diff --git a/setup.c b/setup.c
> >> > index f93bd6a24a5..f0c06c655a9 100644
> >> > --- a/setup.c
> >> > +++ b/setup.c
> >> > @@ -2541,6 +2541,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
> >> >  			repo_fmt->ref_storage_format = ref_format;
> >> >  	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
> >> >  		repo_fmt->ref_storage_format = cfg.ref_format;
> >> > +	} else {
> >> > +		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
> >> >  	}
> >> >  	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
> >> >  }
> >>
> >> Shouldn't this change be instead made to REPOSITORY_FORMAT_INIT?
> >
> > It made me a bit uneasy to change `REPOSITORY_FORMAT_INIT` as it is used
> > in several places. So I opted for the more contained change.
> >
> > In any case, I found the logic to be hard to follow anyway as it is not
> > immediately clear where the default value actually comes from without
> > the `else` branch. So I consider it a good change regardless. In fact, I
> > would argue we could go even further and change `REPOSITORY_FORMAT_INIT`
> > to be set to `_UNKNOWN`. Same for the hash.
> >
> 
> Exactly, I just read your patch and the existing code around it and was
> a bit confused because I couldn't pinpoint where we set the default to
> '_FILES' when there is no ENV or config setup.
> 
> I think changing `REPOSITORY_FORMAT_INIT` to be set to `_UNKNOWN` makes
> a lot of sense combined with your change. I'll leave it to you if you
> want to include that in this series or not.

I'd prefer to leave it out of this patch series. It's going to be a bit
more involved than just switching out the values and adding the `else`
branch for the hash, as well. The repository format code (or rather all
of "setup.c") is a can of worms that I don't really want to open right
now.

Patrick
