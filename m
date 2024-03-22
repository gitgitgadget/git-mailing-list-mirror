Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E16376
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711068282; cv=none; b=oMzRbFppLvf90RidSONIYuzbohUyB63g/8qID6F749vgp1kOce7OcJCd8GaOxeC3i/5CITeGp6uXDN8F0pO52ATIpuPrxyW1ogdCBNSLujs9rwiSvvbhPQhAuYNi9VdrG0gvQS3L9KHCPYPezyhFEsTwzMZZPZGx6snbeHTMP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711068282; c=relaxed/simple;
	bh=Pf1SN3kfo8BO7D12PRweZwvaGoo+AbdyJiOdeWczUkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz/UQgO3P3Tf0Oht1u744m+zVSASSqXzBlpPG0jjd4TnvLjpHC7AjS2dg1kqCAqbrE1OAsEUjxJj7d1fgEGwxFE3awcG08dIolYcglgEMWJGxPX7FdwucBoqXlSrIZmTUhq8YfS1iEa3EVk7cNM7rDdOdlD09j/kr+rmKUuQl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lfV6g9dh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIfpZ+KT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lfV6g9dh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIfpZ+KT"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 25BFE11400D4;
	Thu, 21 Mar 2024 20:44:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Mar 2024 20:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711068278; x=1711154678; bh=7eXgwzL9Lj
	rmHQPwtFrhW8VlMryJxQm5XvCA4A8ziVU=; b=lfV6g9dhIPP3VpbQb1Mz/FcWkT
	u+zsMARA0NVaAJMyHtBsUjESNAfOuNxMHgZW80+oF6GZxrszj4oKoA229g6TNms3
	ZgC6D47ms8dNkF8JhdvfSmJr7s4gdlw7GaFf9KV3RAmaFtISyAvudVXr0YKqYK1+
	apodrsM18CVoiORNLIPjh9WT6xgFEGRSAO0EQoGnmYUAGGfWqH2i1d7ELTmM8YhX
	ihYRYBaoiEyZ9OHnZWSdynjWyN4iuh2tDGBGaLDa+zmRyTAtK60JVVUPOX8RbtMa
	hBkA9wsmzEa2eteiZhn9LrjzOljivP4rJxXdcczlzGiOafekllMhzJmLNVPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711068278; x=1711154678; bh=7eXgwzL9LjrmHQPwtFrhW8VlMryJ
	xQm5XvCA4A8ziVU=; b=oIfpZ+KTfv2OTpD/c8SjpYjpoIje2Ma57VscSXX5LnNj
	fTlfHN/Uz5op4HtWFfSglGlU0hWyqojoY4BCPRenvOaJx83BlHVVPpSzDxGaHXSu
	Rb3WExL972/r+ToQUOicbsTLQUBpxJANROgbnAq9xVWakQQp8yU6Eu80PoUEorL+
	I6rRrKImZ3L9s/806tE+j1FGfhnNtyb+NM9gj+roO17eYlT5xZWPuhe+uNYJJblN
	E0Wk6knIQvsNjNkSVQqvpqLImi5870rftAK/1z1aP5LxR+zmVT7MfpZw7gOiQLb1
	eQIMul+mKQWjP0hyq9D72JUA64RYx+EeLhQLasBViw==
X-ME-Sender: <xms:ddT8ZY7JKmvOg_VnB4PeIsEtDZbl89d0c9bUj_fO94MjVQIbZZurWw>
    <xme:ddT8ZZ6BK00e76vKG3-9xjM_4s-M5AP1UzCd87l97SYP0TFXwwoBqbtr0lJZIHxSz
    dWWkRPBmpRkfbV8dQ>
X-ME-Received: <xmr:ddT8ZXd8Ams2nHMAAXIq6Hm2iYQ1S-u_o9y4zFyTv2vTP6QBDcisYMiNg_dydf4VMLhhEXYdOAOTcMy7BugfZTX4xlUs5xRVGo37v6H3qKSiUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleekgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefhudejueeuleekteeffeehveekveekfeeileeljeduhedtgedtveekhfelueduvden
    ucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihhtqdhstghmrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:ddT8ZdJUeQAeP1RQssQ-Js9TDbZBEv2B5N3Vi-2lgpC91qd6Mi5wmw>
    <xmx:ddT8ZcKNub8aj9u7d-27rzqk7OybOjVT49FHkFg_tgOFC_QJhTZXiw>
    <xmx:ddT8ZexDHMMDHTiOuiTAvjfUjySp360v8_Y3-saB3H6GE8De7NT06g>
    <xmx:ddT8ZQKFPDB3PAJL7kxg4ZAZv6O8uyVdqaJlEMSLJ-3ojpAR-fv5cQ>
    <xmx:dtT8Zb9wNW46ZZifNc4xA_cJPgU1Tndwn0moTFKh9ruo75afD50fwA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 20:44:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 204fc432 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 00:44:29 +0000 (UTC)
Date: Fri, 22 Mar 2024 01:44:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com,
	Christian Couder <christian.couder@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
Message-ID: <ZfzUb9HkZLq1UIed@tanuki>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework>
 <Zad1S3vCuv4KYIzx@tanuki>
 <ZfwY_h70OeuRT7mk@tanuki>
 <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QJ210snMWHe1WAuV"
Content-Disposition: inline
In-Reply-To: <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>


--QJ210snMWHe1WAuV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 11:27:07PM +0100, Olliver Schinagl wrote:
> Hey all,
>=20
> On March 21, 2024 5:34:25=E2=80=AFp.m. GMT+01:00, Junio C Hamano <gitster=
@pobox.com> wrote:
> >Patrick Steinhardt <ps@pks.im> writes:
> >
> >>> Circling back on this topic: https://gitlab.com/git is unfortunately
> >>> taken, so it's out of question. I'd say the most pragmatic thing to do
> >>> would thus be to retain the already-existing location of the official
> >>> mirror at GitLab.
> >
> >https://gitlab.com/git/ sems to give us 404, though.
> >
>=20
> That seems tot indicatie this is a user, not a group (gitlab is more
> advanced then github), but I could be wrong. In both cases the user
> has set this to private.
>=20
> My guess is, someone set this up as a bot-user or something the like.
> Maybebgitlab could check activity (internally and confidentially) and
> see if the user would want to talk. But I admit is a bit hostile.
> Other we have no way of reaching out.

I checked with support folks and it is a private group if I remember
correctly. Whatever it was, it's not available right now.

> As for my mirror, I started my mail with I'd me more then happy to
> transfer ownership. The name I post cked as a reference to
> git-scm.org, and never intended to keep it for myself. As I initially
> wrote, I was just slow and lazy to sort thongs out ;)
>=20
> I will transfer and relinquish any and all control of the group once I
> know to whom.

Okay, thanks, I didn't quite remember :) In any case, unless we get a
hold of git-vcs/git, we have two viable options:

  - gitvcs/git owned by Olliver.

  - git-scm/git. I just discovered a few hours ago that the git-scm
    group is owned by Chris, so we can set this one up easily.

I'd personally rather go with the latter, mostly because it matches our
git-scm.com domain. I also like it better than the current git-vcs/git
because of that.

So Chris, would you mind adding me (@pks-t, my non-GitLab handle) as an
additional owner of that group? I'd be happy to manage the rest from
there -- setup of the project, mirroring, CI system and changing our
docs to point to the new mirror.

Patrick

--QJ210snMWHe1WAuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX81GoACgkQVbJhu7ck
PpRIFg/+M4pDDPFtZZcTrzoyd0uwO388FZmAg3uaASiyYysDy65eHw83ZX3MpJi2
DHVfl2iO9UooOdAzempcxQ8DSqgEYh02/eRgJH7gvSMlQiBhu4wq+gt2YKiLx94B
zWOIc9MhKtK62EXBFMXqJ4ffE6GzFsNxYDTFNR3sVy7C0Z3/uk1GHI5gtoF9awGK
sK6mlNpJMeJjJNy2oZJXJNNlnM13qoxYFNTVgqItyzf6GrJYWjiZNewnQQ7FyxUe
+6EWIFBy3PsYTihw5lYbM7niwMkb718cRX8DHGVuNucI7dEIhG3T5YtpXhX9DLfU
WZeHggyuOiaz+AB/+VOi6Y6DLbVzrbWyML/bhCpl1r67oyTN6EyeWHLxhGg3FIii
Umn8yxcbuwU0GJblf65OTRQi03gBbSJ3UlsGO2eA2SwksMX2v9vhKY0lX5HNHm58
uDeV9T9lWnqCdB7xgufIvkOkqqmEWN7vr85QW3/9TTZhJ2nl+qaxxKLeBuWAPbsk
4649xtytrpt4SqNHALYMuG2H42Dniarh8+BOHNnPE2JSDzYyFDuNQTz73MqfLBdx
GUwNp3TnLZ2NOHlwbrfjthCVUgHr3bBl3xah3d4+YmtTIhSSddfmORNWneE8qIbt
w3i0N69It0nskD9l2uAR2u6aSAfkLtZCfi6hj8cwTSqkFxitXTM=
=PLDb
-----END PGP SIGNATURE-----

--QJ210snMWHe1WAuV--
