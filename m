Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A652C1AD
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523866; cv=none; b=B9y2XHJ1t1KnNEtQwAR4D6ZJuhO3pDNe2+VYraA6DohiTQFYw3OA+32uzxMXf88VZBDnrAri84EBmNRFGimJkj64OGDFHUE9iRbJLQ6yM4RKqS0otpwv9zW/LyYEq6uEk4C6IxiSVUmSOEUi+OwN1rP22V1RFlzPrE4koNuJPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523866; c=relaxed/simple;
	bh=ojH/BMobw4BHOIqmAXeLMFwDP1G8ihe25tk2qa8Lmt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8DAzzEecmriqndKAXWjH6gB8bNVkBFcfL1V0/iYQV+qG9PvKZPiiJe3vLDEYRck4KM7fENGyihNOpXvcEaBpoS+d8+JC3SL5Tqr02m1nkGBaPiIKcgmoimoHo0OhYF08pjFzJ0iLsfVUGDfCo+mLnMTDOA9ZhG4g2YueCvc8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WxsVYm2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=emHsZo5y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WxsVYm2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emHsZo5y"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 17D0C138016A;
	Wed, 27 Mar 2024 03:17:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 03:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711523863; x=1711610263; bh=LCuJfvlNct
	eQpvDSLNgLJb4rI3AIO2DCkmv78NFWLOU=; b=WxsVYm2GuWzGb6/i9bl6/gMhxD
	TohJ7nf4KW7xQhSsgeEdoP62lIJ1+8heBa/FQ5tU/dD+/+Qh+DB5enIBgMMblSFE
	31X79f7IRETkzgSrK219lRivmDrzGMq5QqLgfWHqE/7vf5BqrmfKv1iF7ISbCcbZ
	fQQ2brA6cOe/nwzFhzFZmYyP+wZMfKGbCiG0qETP5J2oopWq7JOw4WR6jQ4wMM/4
	vD78UU3zivt43sukk6GbHmD1V681ewOMRUZtnlAnAq67pyfMZCo5Z3zHUht97Xsp
	9gMTpEtLjAn/xNSrRLVCppr2zQ/jLipuDiV5uZdM9bwJrH2gPKwFVtfwKZ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711523863; x=1711610263; bh=LCuJfvlNcteQpvDSLNgLJb4rI3AI
	O2DCkmv78NFWLOU=; b=emHsZo5yBXkun34vOtcGHnttdRmMSk6kwa+NvIo1REdx
	m7RIdfpKhvp7rvn9IQ7QDEEJOw3tlGpluHlROMe/EW9UnIaKQU0sYvfOfxZNG02t
	9Ut5sNY4QMNF+Ew7nMjh0jTowbO2lltSkjcVOsOqLTYEzeZpt3PMoTdYbtkupbuI
	4H8sCxx7yaj+V0UkGcNHaKE0FdOruccEx6m4+NfEHcMcWLYBlZBDM6JjU7VmDNd2
	MR8+FoEh6CD1Pljd6gT2/FecbEeftWasN4fOcYxplh4q/b1UrpRq1P9QBVu3Qxwk
	9dY76uMpvCvDAthTOLgBOv3SaWnJdxh9C6mrKAbkSQ==
X-ME-Sender: <xms:FsgDZgMq6frpBQHwG2HAt7Ve6TAB5lcpP1wjj1a_Xy6PAG9puIFvDg>
    <xme:FsgDZm-xv-0Vym47LanZo9ikMaqhs8hChF1Zr3Ca6TzeIFPeRIy5YKWTfDKWPCCg4
    av2XV7vodrR_IULSg>
X-ME-Received: <xmr:FsgDZnSevD8pBg4M7lY5e56auTfuI7DPN4tBleV7QS7xZk0IOR1vWb8m-8pgWVuLWX3ordweEDe2lie_nqdX2axyCBlOiDbYIOQ5oatbxhKZ0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FsgDZosbf4nvP6pRccaav9BQH-3FgfyhFoZN822Jw0sjyfnRaWzg0A>
    <xmx:FsgDZodgRejis5idHNfx3tr6aSAq_JY5ZFl1BzhFT2UiQgK0xIXoOA>
    <xmx:FsgDZs3_ncmfyD9akvexdKc41Ll7ww1C9rRqAYq242z7OUXDdtgA5w>
    <xmx:FsgDZs-psdUdOer0gokSgy75Z46cpdlKldoHh1tN77jJBbu4gRjsXw>
    <xmx:F8gDZtGmtP_IiwUoyAvkVRl08vrX6Fb9YQKP5ge24I6rAhR2copTRA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 03:17:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4dd9276 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 07:17:26 +0000 (UTC)
Date: Wed, 27 Mar 2024 08:17:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
Message-ID: <ZgPIEgFGVokYWc-H@tanuki>
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g>
 <xmqq8r27nhwo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wa3M6mnqFwJUGupl"
Content-Disposition: inline
In-Reply-To: <xmqq8r27nhwo.fsf@gitster.g>


--Wa3M6mnqFwJUGupl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 07:51:03PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > I am more worried about how the file is used and maintained.  Some
> > things to think about while in the "spurred discussion" I can think
> > of are:
> > ...
> >  - Is the project big enough to require this (especially for the
> >    purpose of (1)), or would
> >
> >    $ git shortlog -n --no-merges --since=3D24.months -- path-to-file
> >
> >    be sufficient and more importantly the value that it will keep
> >    current automatically outweigh the benefit of having this file
> >    that can go stale?  To answer this question, we'd need to know
> >    the turnover rates of past project contributors, of course.  If
> >    it is too high, having such a list may help for (1) and (3)
> >    above.

I don't think of this as "big enough to require this". I rather think
about the onboarding experience for new folks here. Sure, we can ask
them to "Please run git-shortlog(1) to figure out whom to Cc". But if we
instead provide a nice script that does it for them then we make their
lifes easier.

It's also easy to include this for example into GitGitGadget in an
automated way.

> >  - How binding is it for a contributor to be on this list as an area
> >    expert?  Will there be concrete "expected response time"?  It can
> >    be different for each area expert, of course.  I'd expect better
> >    from those who work on Git as a major part of their job and
> >    contributes some part of their work product back to the upstream,
> >    than from folks who do Git as a hobby.  Is each contributer
> >    expected to volunteer to be on this list, with self declared
> >    service level target?

This is a good question. I don't really think that we should enforce any
kind of "service level agreements" here. I think people who are deeply
invested into any of the subsystems are mostly doing a good job of
replying to related patch series already, so I don't see an urgent need
to enforce something here. I would rather assume that we have problems
in areas which _don't_ have an active expert, and I doubt that the
introduction of a "MAINTAINERS" file would help here.

I would thus reformulate the proposal from "MAINTAINERS" to "REVIEWERS".
Instead of saying that person A is a maintainer of subsystem B, it would
say person A has a keen interest in subsystem B and would thus be a very
good candidate to Cc in all your mails touching this subsystem.

> >  - With many good reviewer candidates being employed in companies
> >    and doing Git as part of their job, how would we handle folks
> >    getting transferred out of the Git ecosystem?  Unlike in a
> >    corporate environment, nominating successors who have no track
> >    record in the community by the current area expert would not work
> >    at all.  The successors themselves have to earn respect by
> >    demonstrating their own competence, which would take time.

I think that this problem would go away if we reformulated the problem
to be about discoverability of interested folks instead of setting up
submaintainers.

> So here are some more from the top of my head.
>=20
>  - Corollary to "nominating successors from the group at your
>    company may not work well", it may be hard to self-nominate
>    yourself as an area expert if you are not confident that others
>    consider you to be one.

I also think that this becomes less of a problem because you don't have
to be _the_ expert in order to say "I'm curious, please Cc me here".

>  - How authoritative should these "maintainers" be?  Do they have
>    the final say to even override a concensus in a discussion if
>    needed, when clueless discussion participants are drawing a
>    conclusion that would hurt the codebase in the longer term?

Do we actually need this? I'm not too thrilled about people having more
authority simply because they are around longer and have been appointed
as a maintainer. I think that discussions should be decided based on the
merit of arguments, not based on the role one of the participants has.

This is also based on the assumption that experts of a subsystem would
be able to highlight why exactly something is a bad idea and argue
accordingly. Thus, in the ideal case, no authority should be needed
except for the authority that their inherent knowledge already brings
with them.

>  - For whom do we partition the areas?  "For revision walking using
>    connectivity bitmaps, experts are ..." sounds (at least to me)
>    like a plausible and reasonable way to define an expertise area,
>    but the description of the area may be understood only by those
>    who are reasonably familiar with the way how "git log" internally
>    works, for example.  Is it OK to assume that the reader has some
>    basic understanding of how the system works in order to use the
>    maintainer list effectively?
>=20
>  - The above worry may be reduced if we partition the area primarily
>    along the file boundaries.  If a set of functions that are not
>    logically related to feature X but has to be in the same
>    compilation unit for some reason live in the file whose primary
>    purpose is to house implementation of the feature X, it may give
>    us an interesting project to figure out how to separate them out
>    and give them "correct" place, and the end result, even though it
>    is a side effect, would be a more modular and readable code.

I think partitioning intersted folks along file boundaries would be the
easiest. Also because...

>  - If we adopt the file format from the kernel project, can we
>    leverage their tooling as well to query the maintainers file?  I
>    thought they have a tool that reads your patch into and figures
>    out what area is being touched to spit out a good set of Cc
>    candidates?

=2E.. the tooling from the kernel project already works in this way. They
do have "scripts/get_maintainer.pl" that can be invoked with a set of
files that have changed, and it will then spit out a list of folks to Cc
as declared in the MAINTAINERS file.

Patrick

--Wa3M6mnqFwJUGupl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDyBEACgkQVbJhu7ck
PpS/sQ/+KZ+ZCXM7ViVS4WZ1MLJC4F5yn2SOB8o0jzUlBeXYDJqvC4HN08/7wbHx
4ehuaDPfqKI66El1esOwkDb70kBFb1XoqvfZ0PBJGImNU89bW7PAr4xiD5RSZrFI
WvBfZJS+1bUQHvaqpOfam8GBat2pOM6XQKqsBp28x6cYb4vaHbDhpQd02IZeI8aE
SWpB+wV4JdV9+DJPDyLW38rvx5ywFrd9EOqNx97wJWbLf8MxKT2oHB/OhjM1mhEb
oQjB0lXTpqEUU7dv8h/XecVAgbGsCs3IkB0cx+qQFzFW765eKhUX33EJrqHKexcF
mydSZ6XES4GcGaNAGPnDYr9jHjYe34hiXQvqB7pOc3unHhaYPfOm91ypAFVE7XLE
9MFfe4Soe2OR/aUUjJsAQr3pRWbXekmMUJWzW3q14VdSuc9RkH1PYddTqYmN1s9b
yHuflgbbgiIFIi0rOh37d/HOSY+1eI+cAzFPbCiWWWjOsM9g5TROUhNGCieMpuQC
13VS4YNgm7BSwhauKD5jaDU1HSyX9JwkeHnykkARoMzcp8WLykufHMfuEkRVVPZ2
z0NaAGl0t7jq2Xhpjy4+pTttW6UloUsPu+xWpNOdpZ1OoGuuVfHc3DpCwPLAb67d
X7GxWIN/UtBqQt3vtshgYYZvcw15q2LIp4QnL7en21drVS75688=
=VZOJ
-----END PGP SIGNATURE-----

--Wa3M6mnqFwJUGupl--
