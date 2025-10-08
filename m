Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C21DE3C7
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924097; cv=none; b=jL7j3rqBbajR/9f7wQTW8AZomtLZ8CEsTe9k2xbfPWBq6GSp3v/uSYnxO0iMjar5s2BMjiEJWcDoOhC+ssDtGhL8FkM8DtwR71wN9rC1wSZn73lCxwdT5+wb+wUq+3x7IPgnZ7L0r/SF1Ja1v0/1vYCx+VB2YNCXrXZtsxXe6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924097; c=relaxed/simple;
	bh=ktbizW0FXyHySvhdfuOmXCcitVYdRSlzBxtZCCjlH60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSFrC0BCFAYarorKnsZuAlQVr4UvLPKKK8bL/EScNWRB13yyVaJtjqWycJgd2QysE4Nma2NYmPLE9aFXx50ERYOJQOWPOxqsXwH9bj7Ptw3C41VkbQDI4M275CVBTTDHP/nCYdLppVqksysOhq0UsfKEq/fvfu+agceh8VZMnBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M8/tjKRe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lMG9jPjl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M8/tjKRe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lMG9jPjl"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97BD67A00C8;
	Wed,  8 Oct 2025 07:48:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 07:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759924094;
	 x=1760010494; bh=jR/bczK87KMuThX8FF2HAns6C4gjE5LJGS1KmQCUKI8=; b=
	M8/tjKRe2ZTAGdFiEos9Pz29UuCMTTpiKjX7T9LEYFDMoQsPcC8RXU2WKcWf1hrO
	+GUztzWCvd9zVGIoiJNK6qqltDt4l3bGLcNbWnNeMdVQQ74eJEGUoDQTfL/GAFyk
	IBGFWj4+e3tVb2L8g1AApSN3XQ9xjEPyaBRROF0pOn2byRBsz+DH3nOsWw/t2jOt
	AoyqXwaY0/d11274W5g5zUWeOW1LvKItQPWqltcADHCRGTTHnSgetCFUKQxVwy6U
	SDP75mg+me828Eu/UFfxfmqwgZIhdx9wTPR1PHIZ2pnU9jm+p5XmWE7RPc5UR0eE
	MOHB0KqH+AszD9eidzp13A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759924094; x=
	1760010494; bh=jR/bczK87KMuThX8FF2HAns6C4gjE5LJGS1KmQCUKI8=; b=l
	MG9jPjljeBg6D3NgcWQIb9JbhOMy+zs0joiIaSpBQhD4LTHNSppN+q6qDm7pH3YF
	H3a15ByddUSYPD2SxM78cT181+Q5m2a+N/RSTT9T8nE8Dj5zm7tai0ZqqfivKivu
	8/Hi0o882Ft/uY7PBapSjcvxXxjC0wS1iVMFhsZvmzbSzZFQyqFravCSlpwW3Px/
	p+ifrEZ4eOUvfF4bgkUjUxItl1kOf8OIBbbZUHcQUrYyBnH2BbDX02pKNJMPFCLh
	jdLs7DnJBQVEi5Y4nOcIahVcwkUtc76B+aPRm2QLB9TiFW/wRe5fDfjOiccwPmD3
	aWUqUzIhjSsKYWN2n6qow==
X-ME-Sender: <xms:fU_maLJjWIQhfZKQjEYIHsLGl3E4mc8kXiLpU8BAmAPJNgR2KiAGTA>
    <xme:fU_maONZtZU-fuKl-RC6AKt9FS57eY1Y0NNHLCt8bx8kfZcoxbDkb6old3tJItd_a
    MsC89oZ2DCKb0TODKdSZyumaeMBlyebTEKFlfn8raprU-lkw17z>
X-ME-Received: <xmr:fU_maJ71yfcxp3215X6bFn7OqpDm5E0nW3-EMCr6zIYY2oMjNGkmQ2Z6Xs2febA2sZVBVIU7CsYbDUMgKPEVGoGK0BOIAE5fj0cRExBp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmh
    hilhihrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:fU_maA6mOtpWdB6kCcqI06yagS-JE_KgeTHZlsAuQC38LAGZg9BPhw>
    <xmx:fU_maHHWT_02rn8nxEHKsFg25H_B1bulj6A26WitEohM1fA2Eg7SWg>
    <xmx:fU_maAXSiySHV-zL5aBEkPKVptNqFJyTi35d29wftBDGKwJFbyPpQw>
    <xmx:fU_maLU6mKOlHJYFhfUfCS71f9QePH6OCIuFp7dGoZotFUerLRn5NQ>
    <xmx:fk_maNP-z8SPXrclRqQ5KUmIlLDFcN932tz2Spbc3Wvu36L_07rMc8Cx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 07:48:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9eb97230 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 11:48:10 +0000 (UTC)
Date: Wed, 8 Oct 2025 13:48:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/5] doc: git-tag: stop focussing on GPG signed tags
Message-ID: <aOZPd0VqdulySIGi@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-2-christian.couder@gmail.com>
 <aOYPRKoexRtYUDsh@pks.im>
 <CAP8UFD0UJt+L9Ri4VyWJ-1M4Si2q=i5xG_=a315G9m1NFvXnQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0UJt+L9Ri4VyWJ-1M4Si2q=i5xG_=a315G9m1NFvXnQA@mail.gmail.com>

On Wed, Oct 08, 2025 at 11:52:44AM +0200, Christian Couder wrote:
> On Wed, Oct 8, 2025 at 11:21 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Oct 07, 2025 at 02:29:54PM +0200, Christian Couder wrote:
> > > diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
> > > index a4b1c0ec05..9117754ffb 100644
> > > --- a/Documentation/git-tag.adoc
> > > +++ b/Documentation/git-tag.adoc
> > > @@ -236,12 +241,25 @@ it in the repository configuration as follows:
> > >
> > >  -------------------------------------
> > >  [user]
> > > -    signingKey = <gpg-key-id>
> > > +    signingKey = <key-id>
> > >  -------------------------------------
> > >
> > > +The signing backend is controlled by the `gpg.format` configuration
> > > +variable, which defaults to `openpgp` for GPG signing. To sign tags
> > > +using other technologies like X.509 or SSH, set this variable to
> > > +`x509` or `ssh` respectively.
> > > +
> >
> > It might make sense to use a bulleted list here to list the different
> > available formats.
> 
> What should we say about each format though?
> 
> > On the other hand, we could just as well refer to
> > git-config(1) so that we don't have to repeat any of the information
> > here, but instead have it at a central place.
> >
> > That might not be worth it though. In the end there aren't too many
> > different commands that write signed objects.
> 
> I think this CONFIGURATION section should talk only briefly about the
> most important config options and refer to the git-config(1) doc for
> details and less important config options. So I am not sure what you
> suggest exactly about this.

Yeah, I'm fine with referring to git-config(1). I mostly want to avoid
that we have N locations that we need to update every time something
changes here, as those are bound to become stale.

Maybe a solution would be to only point out the config keys without
going into much detail what the respective values are? In that case we
woulds imply refer to git-config(1) and call it a day.

Patrick
