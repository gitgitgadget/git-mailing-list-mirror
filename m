Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86E7F7D1
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407150; cv=none; b=PAiW3zi4R3+P8uYXcMpDyK3x5WmPWawNhXTC7X8xpqm+/e0b1dNJk90URW3Vc5pM3l4JPwKJw2JYf+IhcjE+fPvaMc/ppukg57ux8Y5v9rrkUGnEfSv1CgjoGqKXZo/ok3WDCVYiBElnsT/w01dI75LLn6F00KIBPEmQsMzI3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407150; c=relaxed/simple;
	bh=78AK5rjdPPGSWukkvXUUfR9hTgvUG/f9toHAmh2HnBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxaGv1wr9jyYSzSF88/xNwbchU7Vc65GMkOoOEzVtz5ga44r6tuzXSiJVl9G5NF/5VzCzvwO3iVuLnKYIBhj+eEvxSEpsgnQLTFA3K8fvULA+sBmFKP4ZgQP8P9AO2hYVmtD/q2XcQh2QJ5xl+gL+lgD1Ph3ICW+QEBaSMQqBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=arwlqmw0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBNLBb1t; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="arwlqmw0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBNLBb1t"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 992831800076;
	Mon,  3 Jun 2024 05:32:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 03 Jun 2024 05:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407147; x=1717493547; bh=mQLQdIXQlu
	jMbCH8xyaTihpvb6HGRdqu6uWpi6CgtBo=; b=arwlqmw0wfH56I49JfmV+ax1dN
	lK4GsfLHZmrefNYOGdb5oTasvUN6c0W3GDZebH3KHFNcLQ9q6gyjvYrORJcJVuZ1
	5mv4TI1a4iASNzG4doPCkvUR/Nk1ZciDCBzgPN9I4n0cwg/BlB3ht4ZAd48TjNkL
	xavl6IgaBGrCQPb0vMI+zbicjOaqoSCReepo8Qo+Rjuz3ez/uRn60qA5gi1G/z/9
	pXgV85LMj3Cx5mppXsXsoIN+BSiP52G8iNR3uDhqbBuhEt6bzpRaM6rcj9Up2HHW
	/3zWwtz1b4BdrB/SFHvCbjc8ckQtDMNUjEPtqrELcHAh7ep8TPNsAcazAVrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407147; x=1717493547; bh=mQLQdIXQlujMbCH8xyaTihpvb6HG
	Rdqu6uWpi6CgtBo=; b=gBNLBb1tPsHxvToFo0C02wsDcRy850mR1KUbJTNF2Hr6
	HqJYSDmqOhOonnQwi+pVRYMFrZpNv7GFU5aSWQA0z0CT3qPykR9Mk+uggildfxHm
	J5J9vv6GNOUGcnyEuFMWT6WunoPeq8TCPG9kNfJphGaSlu/EHK+ha3JdafRHdOw/
	wdFk6ia66d1EhdyJ7Tmzm/tuzfQGFDFSwV8ge8hP/zqRsgLvdF0kFGQ49DjqJQPt
	39dl5pFdsSjF+2Vkg1/8lsEcVJ3T88U9JBN4mhDKSsU3zI7CbXxPN7y7Gzy8er31
	+pNSppbg+LDkIIYQcu+Jjngf8RW0t2QT038+CsKwWQ==
X-ME-Sender: <xms:q41dZhCdGw7kUACSWOuFNVfpzZHg4DdUTQsySwCXYpIL8oTcFoouJw>
    <xme:q41dZvhblMN_-ZE47sw-SeDEnFXWROhkWFPGC7QMWt2eH3i4sIHBmWfLdrRSKNZwg
    HLgUinj3hJJE9ndpQ>
X-ME-Received: <xmr:q41dZslQzGCtmhZedmu_kLbsnBbaoT_hQisVCljVGLDK_0e4ntG8KqWOkFinE2e9PHE4IPwZihyhK00gXNmgEWvIk7owl2mVUtz4CVuqMU1LC5NB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:q41dZrxnwtMeRGtSbQTJX0XgcXhm31BZ6n3JB85eTsQx2Gf8L7sqVA>
    <xmx:q41dZmTXjLjjy_Z4ndwi7De46N8H7j7NEj4JzsltMxxks0VU_YNIBQ>
    <xmx:q41dZuYpkuYa8LDXaHQ6BdyAD1uDs7tvpnBJG1pprL7YhIdMnjwkHQ>
    <xmx:q41dZnQMhgTXXCkrzbGGrPLafS5sy-rMbOmHT8HtmtOK9WXywydV5A>
    <xmx:q41dZjTULHDMuUBtr-4J1kS_mU86B1-yEKPUkVa136kk34Xgbho59Ktk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:32:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 09fe8c9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:32:00 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:32:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/4] docs: introduce document to announce breaking
 changes
Message-ID: <Zl2Np9qNcA6Z1q5U@framework>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
 <993b9363484627cd828362e39f15c4905ecaf3e2.1717141598.git.ps@pks.im>
 <xmqqr0dhgc1e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pB6Eal0a0PaM5sZd"
Content-Disposition: inline
In-Reply-To: <xmqqr0dhgc1e.fsf@gitster.g>


--pB6Eal0a0PaM5sZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 09:51:25AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +Regardless of that, due to the age of the Git project, it is only natu=
ral to
> > +accumulate a backlog of backwards-incompatible changes that will event=
ually be
> > +required to keep the project aligned with a changing world. These chan=
ges fall
> > +into several categories:
> > +
> > +  - Changes to long established defaults.
> > +
> > +  - Concepts that have been replaced with a superior design.
> > +
> > +  - Concepts, commands, configuration or options that have been lackin=
g in major
> > +    ways and that cannot be fixed.
>=20
> The first two are easy to imagine.  If we change the default, people
> may have to retrain their fingers or rewrite their scripts.  If
> "log" that came later is so good that even those who were using
> "whatchanged" have long switched to it, there will come time when
> nobody even notices a removal of "whatchanged".
>=20
> But the third one is puzzling.  If something falls into the "cannot
> be fixed" category, is it still one of "These changes" that "will
> eventually be required to [be made]"?

Well, for a wider definition of "change", yes. In this case the change
would be that the broken concept will be ripped out of Git without any
replacement.

I'll clarify this a bit further.

> > +The Git project will thus irregularly release major versions that deli=
berately
> > +break backwards compatibility with older versions. This is done to ens=
ure that
> > +Git remains relevant, safe and maintainable going forward. The release=
 cadence
> > +of major versions is typically measured in multiple years.
>=20
> Releases vX.Y.Z (0 < Z) are "maintenance releases", and I have been
> calling vX.Y.0 "feature releases" instead of calling them "major
> versions", so the above use of the phrase "major version" can fit
> in, but a more descriptive name, e.g., "breaking versions", might
> convey the intention better, perhaps?

I was trying to stick to the names that semantic versioning uses here,
but I'm happy to adapt this accordingly.

> It may be more assuring to cite the last time such a breaking
> version happened.  Was "Git 2.0" a breaking version?  If so, when
> did it happen?  Were there other breaking versions in the past?

I would definitely call Git 2.0 a breaking release as the changes to
git-push(1)'s defaults were quite significant.

Other than that I think lines are a bit blurry. We do minor breaking
changes sometimes in case certain behaviour is deemed to be buggy, and
fixing such buggy behaviour may at times result in user visible changes
in behaviour. I wouldn't call that a breaking release though, because we
certainly want to retain the ability to fix such bugs without bumping
the major version every single time. Going down that path just means
that the whole versioning schema becomes meaningless, like it has become
for so many other projects nowadays.

I'll also include a sentence along this line.

> > +The intent of this document is to track upcoming deprecations for the =
next
> > +major Git release. Furthermore, this document also tracks what will _n=
ot_ be
> > +deprecated. This is done such that the outcome of discussions document=
e both
> > +when the discussion favors deprecation, but also when it rejects a dep=
recation.
>=20
> We seem to focus on removals and changes; will there be a case where
> an upcoming addition is equally disrupting as removing an established
> thing?  If we wanted to avoid focusing on deprecation/removals too
> narrowly, we could tweak the wording below, with "deprecate a given
> feature" -> "make the described change", etc.

Hard to predict, I guess. Let's just rephrase it to be a bit more
generic.

[snip]
> > +### Changes
> > +
> > +### Removals
> > +
> > +## Superseded features that will not be deprecated
> > +
> > +Some features have gained newer replacements that aim to improve the d=
esign in
> > +certain ways. The fact that there is a replacement does not automatica=
lly mean
> > +that the old way of doing things will eventually be removed. This sect=
ion tracks
> > +those superseded features.
>=20
> As the title says "superseded", to help non native speakers like me,
> let's use a different and easier phrase with the same meaning in the
> body text.  "... tracks those features with newer alternatives",
> perhaps?

Sure, makes sense.

Patrick

--pB6Eal0a0PaM5sZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjaYACgkQVbJhu7ck
PpTCmQ//W3OHQPpnyxHZQeoxh8NRpx+i1CwLvO5pgGniKUvZdK+i1LTkvZguLn1e
tPX8lAr7vaiLIbioQ4Vu8763j0OqDrKxs2tsLvQdaU0ZMzS4s16GdnIcIaOu58pw
44mnXyaDg2VXMhEErAF9vV7KGStsSqeR3cOj9+wUupzfVuSbCvfex8cASLghFGmy
JB5xqqfwB4Fzk5PNc9pOkvX8iATM5kKcujq7wM/dtT2BsibDn5tZ6T3z3FsbmpbR
HTbfwjx5GnM2Z8C6mHvVWlpLmRTLjugMoLDWUa2eAD7Oes4kcPrM7PwWyZI8Ktuq
fki3bMpix+JazTPfpInnIbPNAFxw4/blFsyp7dBVUovhXpTpNEeKJGq40ILtnNTJ
BxtTwF90++NKYh87xMJA/oLbligRdYimNKasZmFHcSNtroHg3M8n37pnNgHwjddj
g5cIADH6m+906bWvPXgyllXW4L51x81qNCdnLKOlKYq5N/wWJu+pNWGrYbXHjoEt
Km5nXNQPKCVTge9xnleoE4LetQAdBcmA1IUvWANmNWvrzGkuo5/e9fh+0jrjEjiy
NMWIQSlhulvYycaoujQwxa05rfj761cPyK+6zfPcD53MB89YdyMNghYvS7dRhT5Z
lPLPrfWsrClt99ndS9m78ZQiY9oK9oYwf9zKWXqTZecnnTG4Zzo=
=jf0h
-----END PGP SIGNATURE-----

--pB6Eal0a0PaM5sZd--
