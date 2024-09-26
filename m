Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B45171088
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352577; cv=none; b=I/+XtEGeDBk4fBaavdXB4pk2aJYr4TiINBKvVA90l6IEPIPz7Ka1C1/LfSgHvdvstUwkzU+MOmcTUe5sHMi8N7y3Da4bV8/tzzC/oG8UsY1A8qPiPltetVhGakBKggar6ibogbZW3o8x2cNTKybjIxL3DtnWHe1j+Zc+i0RVMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352577; c=relaxed/simple;
	bh=Og4POaJyOUGfizEOyDdNUWav+aBGZjmw3VunrELV7hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMZ1X/XtI0qM8rt4EBEraKttzQAXI23EwZAk1rmBra15SWMMxpPmhPRCW9LMoi0FURmpRTTdIYuOjfSxKdGcB4oPbiSnx0MxDNnlY1xpYP0qxd/oO9MyVz1Z2jyQ6pyKLmD8ICs1lT2dXfRt7UQGudKXAjln0tncCep3L5gR4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hBTnBwPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iv3Ixl33; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hBTnBwPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iv3Ixl33"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F17DB114028E;
	Thu, 26 Sep 2024 08:09:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Sep 2024 08:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727352574;
	 x=1727438974; bh=burLqz7LluDrsb980umJ7SjPMw6WOzSN8SbtAbNdgUI=; b=
	hBTnBwPgEqHyp4yUxIFkgx/M0Fs3V8TxJo807izd0Foa1jGnoIFn/V4vJrF5cLa+
	aRJsH14uO0eh8/6Os3L7NaKWSoFmtK5fB2CGFw9jrnD42Zka9nOdmx6EwegPP238
	oAOJcqv9tAT+3RaA1gFcOnsraBMyhCZdq7+Cnlo3l73K5vZpHVJAs/+Qhh6xom5/
	yIxAzASOkF4lzICBiS6LrUdsfXfuFLrT2P2mmEESj3EvrFgYR9DgNVpnYFQLXEYL
	oWgoW+a5KIMrf0HuwI1mwr/7JQYL4dLrZEqIwaVW+xev2bAtJeDmqN43SL9C5i4U
	DLsASvkl3rzE1AWBuj7gug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727352574; x=
	1727438974; bh=burLqz7LluDrsb980umJ7SjPMw6WOzSN8SbtAbNdgUI=; b=I
	v3Ixl33oalPVjM5lX2imprT19XuggXcM738IvlJV9oirTipzHyFt3wJim5kKJHyG
	uqey+YzWjWFSm6jRXsWnT1saYpNMkFY4H3On3GasKnYHuO6+sNoSTCc4rrji9pXU
	Ag1uzbe9TihbigrvqpbVNrkhbylyv1SgHyJrYbuAljNiQg3iJzy6hFIV68DMSSZi
	4EXdJf1hxbDuoaIhpf9MZMazkkTUlkJWOJTppF/CpweWUArblK7DqTGxcz/ekOWY
	biPlL+3IE5IXAXw9tfe0T0iDct+OUCJu2/6VcetqUsMtjfu3x3PK5PN+Z2+PY26W
	cWS6pwChkBwA+pXJYuzSQ==
X-ME-Sender: <xms:_k71ZkbuEA0vNu-4BVmKjrEN4f4qo5xY1z9jb9Q1J81oLDbGENhGxA>
    <xme:_k71ZvZzxmrM0J3AqpdfFkFIfd9ciQcYOUMRs0Rl0DSsqBaC5R-c9uUFS6X8MFGoN
    1vyn4gRT49OUK6vig>
X-ME-Received: <xmr:_k71Zu-71vRNQZ8IfhLQ1veeo7GPJZ0z5uV4QQwKp5VARf0nnYsUHNkNSkpbD4tG47E3MHo-JyZ-iDzZDnQ00bgjY0-taKdcgL9E9SOB4gmIqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhsohhnsegv
    ugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_k71ZuoqfvPWz_Hc912chWC1WlzJiYk8piJMm0mhBrCShF5t4X2JTA>
    <xmx:_k71ZvpFQr_i-GAiyBGKSFY-9DSHYPHXu3OYoGoSpyAxaX0fIudN_g>
    <xmx:_k71ZsQDdclphPnCz5RN6TYdDVSfDRGHh_w2UcK5FmpGOze_1gCW1g>
    <xmx:_k71ZvpDgsuxDuc1U0fc74Kakm5W2SmKWOx0_EWVF_r_qYva85oDeQ>
    <xmx:_k71ZgmYFpLeCMxnJs9cue7bglzxCy0AKBc6OtVpwPJU5d4Om0pQqKeB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 08:09:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ba7f8e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 12:08:54 +0000 (UTC)
Date: Thu, 26 Sep 2024 14:09:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/22] reftable/basics: handle allocation failures in
 `parse_names()`
Message-ID: <ZvVO73dp4dbtxKi8@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
 <ad028020df717a57879cf3fdf5a3648bfebd2c78.1727158127.git.ps@pks.im>
 <1abdf814-e75e-499b-b5ed-094b52cfca35@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1abdf814-e75e-499b-b5ed-094b52cfca35@web.de>

On Wed, Sep 25, 2024 at 12:19:29AM +0200, René Scharfe wrote:
> Am 24.09.24 um 08:32 schrieb Patrick Steinhardt:
> > diff --git a/reftable/basics.c b/reftable/basics.c
> > index 3350bbffa23..82bfb807631 100644
> > --- a/reftable/basics.c
> > +++ b/reftable/basics.c
> > @@ -152,14 +152,26 @@ void parse_names(char *buf, int size, char ***namesp)
> >  		}
> >  		if (p < next) {
> >  			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
> > -			names[names_len++] = xstrdup(p);
> > +			if (!names)
> > +				goto err;
> > +
> > +			names[names_len] = strdup(p);
> > +			if (!names[names_len++])
> > +				goto err;
> >  		}
> >  		p = next + 1;
> >  	}
> >
> >  	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
> >  	names[names_len] = NULL;
> > -	*namesp = names;
> > +
> > +	return names;
> > +
> > +err:
> > +	for (size_t i = 0; i < names_len; i++)
> > +		free(names[i]);
> > +	free(names);
> 
> These are allocated with reftable_realloc() under the hood, so they'd
> better be passed to reftable_free() instead, no?

Oh yeah, good catch! I'll wait a bit longer for feedback before sending
out a revised version.

Patrick
