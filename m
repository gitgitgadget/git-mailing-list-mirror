Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CD22339
	for <git@vger.kernel.org>; Wed, 27 May 2026 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779851371; cv=none; b=hPtTMYruj348AiDfVcf0s5L91ozASB5iDj2Dx66TrAm518eQfa3qPkssjwz2CHUxUEAYhUWcwtfBEwFRL8+b89IyyTZzyqpKY3nK8Ernki6zvO3bW4lq4cV4Nuwo4tBlv5Cyfpj+e/11Ds1g2+Ba/VpCzsEBweGv5f5EPKccAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779851371; c=relaxed/simple;
	bh=UBj7HQ8jOt5xh9oor6WtZbY4gVeFA5JcEzaxloT6GRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bx483I/Gjf9cFN25vvVEJM40uByGWBYb3TixGQshHNzhlT08qEtl+12zKf27mp35TmbGNk1lEGw35EkT3JJz6vysaAzEliCA8YQek7HaybaEEtll47K1lH2Cyi2i1F5rDSQyGQpP5KhwWxtyIE190Om+Fkde/CjDX79onTNggnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YublGeuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=veTtb9Sk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YublGeuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="veTtb9Sk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41AE41400081;
	Tue, 26 May 2026 23:09:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 23:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779851369;
	 x=1779937769; bh=W8KPl4J2x5bWm0PbTDsESjUJ1VRQ+yNR/HkHrEQqohA=; b=
	YublGeuY9mYZ6oCBadxVCyJqzHOPTHjLjJZxE+fzaPOw6L6ue26/n1DNkJNYYvlM
	YZA/XpSfXEvsNpgqQqIGEVcyG1MBxISTrnoGehB6sKtRd3ApU5inA/AUGUZTAjll
	P//EU5kOHPTG74ixAACyRD+fa8BW8hqnLbzShkhgU+QkIO7KnDNlNpXBbGk2ttlQ
	rK3mBDDdJhgpO3PuONebcVime9gX7Bb/R/Nk5jB9/x8UeXrx3Rgy2glELt4Jw261
	oP/cRgM9Pa/UDotzm3hRf4AGMxcCqSur/9kg549o/ioEpFKpoNaEAdnKigcXib+A
	uTv+GRYTCjFlwRC3tt/w0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779851369; x=
	1779937769; bh=W8KPl4J2x5bWm0PbTDsESjUJ1VRQ+yNR/HkHrEQqohA=; b=v
	eTtb9SkkpivnHDeb/kmpNwe/iCEZTelIaw8aZpQ+3oB4Cy8LiGyfWYVikHDjBfog
	WyTJdZBIKePCIIwO6OvTvpLDv1afG4cVsk3iFpqBIVTmY+0ecG+LMtD0M7Hawvgn
	jMPEEVyWwX1jhXE0IuDpwq59HPmQQ59Echho1X+hPfnCYvyPKO0soYGNwcR0NRaX
	+sU67iGoTdT58Ohf0lFuhRCSW4WlUqjqH1X2FI+2cRQlQCeiqqZAq3DfPyTgS14A
	orPzcQP/sWRiu13AANi6JM3To/MuZuuBPSIXqhmVwExNs0uQvHeEC2pVPHQxT9ZI
	I/oMmn1RUjSXZUzsB4ZrA==
X-ME-Sender: <xms:aGAWascrHf_yfoEaM6RArOqFCqaGtk4ZylwJXKVAYIsSpSMpRol3ww>
    <xme:aGAWaox7HjBNh0giy6FhwdWMpUPbggMyvHwDn1gVRA0xiNJcdNRLWCROVUlDi7oP_
    l3H6gglQgZx-L0oAqOmqVMzBG83hi6fyxOyxday0_Vdgkgm2Y7ruHA>
X-ME-Received: <xmr:aGAWaqFwKgaEZjLlUhwUvxz4KxshBd_iVXr1BEGCrAIV_Z-C5F5OI7u-kLTeTzDzOPbuU_jXo6_TGL_vx_LU1BQ_YSr1Me2Qgqej>
X-ME-Proxy-Cause: dmFkZTEDRO0BI/K0lNXQOcs7hNIiK4eN0RpeOjXzQvE6g7hZol+WNGJ7oWfv4DXLrSSWAF
    UczsNDCnMlZU1+3iZrfjp/BmyKW+0fVFjtV147GwEQh3j0ft4WFDdYxWpDED3ydyfigTga
    q3KWBdbLc1FPiL8RY/QlyVCebUS8Kk1AlooFcHzKCcyKC/j98gbukR297sp11+x48X07Qs
    TS5Dd7q56F3LS7XXnYclH4CZabeE5j4U/GRCYmd9CaQ/JWqpbtC+biZWL+qRBrmP8MkCtG
    /Z/Bd/nqHfJyESQisnubRYotPJeBg/rAlvvnO8g3iK+cB6JoB2ZIkBLXCvGYzp2fjuZ0oY
    pe4aZW5HE1KwgZtlDdVhWeSG487dvI5Vt1705n6F5OjOxLhrRd2iMQCRFMombf8aXJgEnt
    LcJd7hw4pgZN04ufPLnAdY8BO8Ffb538a/iMr7JUkby58iTc10Fqn0CvNBi3ujUUwdf9eu
    DvH5dg7vgNNpeuczQW+dz+/iQxy6G83phStt9xMzNwyC9r21M+AZ9CUsrkHsiaWMX1dMxw
    u2DU34moTtqyD9thZs3r/G/LWrTpI40akLeUJmvioO6iQGwMuF/VliX/PYXIXgiqB7rP++
    kCrWcVPZMVAZ5hGxdroWuRr45A69BvWeio+Wsl702LJjnbr1w7Qi1VmDW51Q
X-ME-Proxy: <xmx:aGAWakzQ7-BQgFpLPnFScqfOFez01vQggOM7B4X8YjSlZZbh1VG0eQ>
    <xmx:aGAWajtG5ndfEZhad3KFiGpkRdi_Fo6JGnLcHXFr6X0LizF4CdZyXA>
    <xmx:aGAWap38c2BtPv95xQpH5-v2oaG9fxgltN3vjGWZJvVzheHiV6kQjg>
    <xmx:aGAWam-DQGgqmKPU3GE9CTRSaWLKomLkCNC9bdM4qz1ZCXoKsD-LZQ>
    <xmx:aWAWahsr9OTFQJhXUmIn0vFvIvN4uWTkyXwCcZv4tqCCHVFHEXWHthRg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 23:09:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Frieder Hannenheim <mail@fhannenheim.net>,  git@vger.kernel.org
Subject: Re: git mv after the fact
In-Reply-To: <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
	(Chris Torek's message of "Tue, 26 May 2026 09:40:43 -0700")
References: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
	<CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
Date: Wed, 27 May 2026 12:09:27 +0900
Message-ID: <xmqqy0h5lfa0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chris Torek <chris.torek@gmail.com> writes:

> On Tue, May 26, 2026 at 6:18 AM Frieder Hannenheim <mail@fhannenheim.net> wrote:
>> I'd like to propose a new flag for git mv, that updates the index
>> like git mv normally would but does not move the file. ...
>
> You may already know this, but technically no flag is needed:
> you can just "git add" the new name and "git rm" the old one,
> with the same effect.

Correct.

> A flag for "git mv" would be convenient (and slightly more
> efficient, not in terms of storage but in terms of CPU time
> spent discovering that the contents under the new name
> already exist in the object database).

May be convenient, but I do not get the "efficient" part.  Do you
mean that for two operations "add" and "rm", you need to spend two
index writes plus one file contents hash, as opposed to one index
rite without having to do any contents hash?

> But Git will discover
> the rename on its own in the usual way regardless of how
> you get to that point.

This is not incorrect per-se, but it is a confusing thing to say to
somebody who does not know the equivalence of "mv" and "rm + add".
It would not be clear to them that you are not talking about what
happens during "mv" or "rm + add", but about what happend during
"git log -M", "git diff -M", etc.

There is "git rm --cached" that can be used to recover from an
"oops, I removed the file from the filesystem without telling Git".

    $ date >new-file.txt
    $ git add new-file.txt
    $ rm new-file.txt
    $ git rm --cached new-file.txt

I think the requested "feature" is not all that outrageous.  It
would be a similar value as a morning-after correction measure for
"oops, I moved the file in the filesystem without telling Git".

    $ date >old-file.txt
    $ git add old-file.txt
    $ mv old-file.txt new-file.txt
    $ git mv --cached old-file.txt new-file.txt

Thanks.

