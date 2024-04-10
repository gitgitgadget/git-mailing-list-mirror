Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EAD3EA69
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770328; cv=none; b=C+MvfhcQ8ToBUraU4/v/9db5S6XC7pn6Z1zER1W/NyNTIleyPUukuNhKqo81r0Lfn3UJSJCIjjHYjn3CWUr4P9tKGyWPVTK4C9fcwv/GKn3zX390x3GIMy9GwWgzS30016zH5UlEenYbvKtp8LSSDy2yHeKvVxZFkDLriEkZF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770328; c=relaxed/simple;
	bh=GeCygkpOtNEG2imtcrng1rOeudDmhuT7XXVkPhznCSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txcRuVoelmCRRcCV0skinySgSazG3oLXMzEutL49eYZy3/p8qBLWlLSptBYc13RVDyfnsTM2Kh8TlLj5syyAl+inKMwy+0XDfajtT1x0YOyU78DwX45GHUa8iytWQutCwsOMrFwvvSave787Ku+n2ogo6TwUDhHxAU6yrRJqJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qeyAyhMC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ViIQ8pHw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qeyAyhMC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViIQ8pHw"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 244901380058;
	Wed, 10 Apr 2024 13:32:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Apr 2024 13:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712770325; x=1712856725; bh=BUO7t7bOgG
	D+9H8+Ox/RRO8drCZ5jeVQt1E9CTKebLc=; b=qeyAyhMCVouoQvPHyQhT1LJw2o
	5FbGA6k04cBDkL92h+JarWcfKY8myag5G/NrHjlFh2s/PUddFbTtcgPB5+nSEQTd
	T82JicZVGehWFyUptHrrsHoFV9zu7rqQJrQNw9HkqPvwBUO0ywhUkGBBjTAcIDh2
	KhpjSC2P6rSW5AEMVThUtK1fl74Y6JC0sLaym4ImzhDhwd4axDT+18SSfBl/xRKf
	QRb3jfpekKiBQcSYbFYuYowV3EUSo/J2nBR8GkCQS9yxZSZBhmEDlqJb2DOMoSxd
	6pkCKzl3FzA21Dttmazw8bQWiwkKqT4SUwtIkPL2r2zvBPAwZDf5QEU2Q8+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712770325; x=1712856725; bh=BUO7t7bOgGD+9H8+Ox/RRO8drCZ5
	jeVQt1E9CTKebLc=; b=ViIQ8pHwdHfVyjKlIUp8HG6SI0IS7/URX6QvvwjYRKrP
	lg9cji25QDNMFoTR49CjfE6JbSvvDtVqQuAUlG/jOJyRkANvP8OEtwmrpMlYFic6
	pPuuUUVVPUx28S+KQ2K8yhBfpAqh9ePswyLAfrhTmzdZMPwd8RYJsHIjFfsDqBsx
	cYulnwA/eP9p+0eyeEEawUEf1vNjsXxboHBrOdUGbtSYmQAnwu2Ur3jil7bptCFg
	Bc3hG8n1IlcBXW/96vfwXRJ6j1jm9Vlud3bYuEtokER6Wl3LUmKVbNR69hMvJ2eB
	bJjGMHFXuymZC2pqPilwazDR9N2SqacGBrNWUfo8UQ==
X-ME-Sender: <xms:FM0WZst4m0LuyDyJ7UbTYxCd3qoHEw5SGabsMUJrsGSva89VzDYJ_w>
    <xme:FM0WZpfs0rfB9_bm2gGAtJx8pZGHJiaWQqU5ryLFmdxVaYCTaKqfHVeUWU6EeFn4V
    x8EQapovpQaUl1Fhw>
X-ME-Received: <xmr:FM0WZny-8skPtxA0Wj3iO1Isd-fnjHuJn2EhvfGys66b-kl4Affht4sx31enjKpuHi4gasl4s0O3ig36nHA28SZJS2i7SW4a1mSs6Yu7JV6SBBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FM0WZvPusXp3Ifzdk19qHahIWn-GQUxQDN6U7SYGrUhvjrsqqY6nig>
    <xmx:FM0WZs_TuFggqH48E03bT2zWA3dRuiteyDcZ42J29h4elTb-CXuV5Q>
    <xmx:FM0WZnXFuBrRCpHTFH2GMi7zJRkMg9WFk_mTg587jlYB2wwfsr-L8Q>
    <xmx:FM0WZlfCjFIvKc2_sCxT2E0AVzEw5gTro8k1c0fjZLQ-aGc3I4VfKA>
    <xmx:Fc0WZgalXYWShCy8soh9AM7yXS7r-XTrBbjk1l3BMhr5dS2mTEkDaYBp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 13:32:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 33f4e1c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 17:31:50 +0000 (UTC)
Date: Wed, 10 Apr 2024 19:31:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
Message-ID: <ZhbND7flvT7INnrz@ncase>
References: <xmqqy19yf40l.fsf@gitster.g>
 <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
 <xmqqplvadmeq.fsf@gitster.g>
 <xmqqle5xeun1.fsf@gitster.g>
 <Zgv4H66NmLZ_o1IC@tanuki>
 <xmqqil0z7m5y.fsf@gitster.g>
 <ZhUsrolJ0_HOH1eU@tanuki>
 <CAOLa=ZSmDZcM473c2dNB0FTv79Vrh92YRTnVR74jOfzX1naNRA@mail.gmail.com>
 <ZhYTe2zpJyHJ8iIT@tanuki>
 <xmqqzfu1w6ay.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I+VCeoMHDJWJ1W3q"
Content-Disposition: inline
In-Reply-To: <xmqqzfu1w6ay.fsf@gitster.g>


--I+VCeoMHDJWJ1W3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 09:06:45AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> > I might have missed it while scanning through this thread, but why
> >> > exactly is the zero OID not a good enough placeholder here to say th=
at
> >> > the ref must not exist? A symref cannot point to a ref named after t=
he
> >> > zero OID anyway.
> >
> >> > In my opinion, "update-symref" with an old-value must be able to acc=
ept
> >> > both object IDs and symrefs as old value. Like this it would be poss=
ible
> >> > to update a proper ref to a symref in a race-free way. So you can sa=
y:
> >> >
> >> >     git update-ref SYMREF refs/heads/main 19981daefd7c14744446273937=
5462b49412ce33
> >
> >> > To update "SYRMEF" to "refs/heads/main", but only in case it current=
ly
> >> > is a proper ref that points to 19981daefd7c147444462739375462b49412c=
e33.
> >> > Similarly...
> >> >
> >> >     git update-ref SYMREF refs/heads/main refs/heads/master
> >
> >> > would update "SYMREF" to "refs/heads/main", but only if it currently
> >> > points to the symref "refs/heads/master".
>=20
> I think that would work well.  We need to explicitly forbid a file
> $GIT_DIR/[0-9a-f]{40} to be used as a pseudoref, which I think that
> is an improvement.  I do not know how the transition to move to a
> world with a stricter rule would look like, though.

I thought that Git already refuses such refnames anyway. Otherwise it
would be impossible to distinguish a ref called [0-9a-f]{40} from the
actual object hash in much of our tooling. I certainly know that GitLab
does refuse such refnames, and thought that GitHub does, too.

But turns out that at least git-update-ref(1) is happy to write such
refs:

```
$ git update-ref 1111111111111111111111111111111111111111 HEAD
$ cat .git/1111111111111111111111111111111111111111
cf6ba211cd2fce88f5d22d9f036029d502565509
```

What does it resolve to?

```
$ git rev-parse --verify 1111111111111111111111111111111111111111
warning: refname '1111111111111111111111111111111111111111' is ambiguous.
Git normally never creates a ref that ends with 40 hex characters
because it will be ignored when you just specify 40-hex. These refs
may be created by mistake. For example,

  git switch -c $br $(git rev-parse ...)

where "$br" is somehow empty and a 40-hex ref is created. Please
examine these refs and maybe delete them. Turn this message off by
running "git config advice.objectNameWarning false"
1111111111111111111111111111111111111111
```

It resolves to 1111111111111111111111111111111111111111 because it's a
valid object ID already. And what if we try to peel it?

```
$ git rev-parse --verify 1111111111111111111111111111111111111111^{commit}
warning: refname '1111111111111111111111111111111111111111' is ambiguous.
Git normally never creates a ref that ends with 40 hex characters
because it will be ignored when you just specify 40-hex. These refs
may be created by mistake. For example,

  git switch -c $br $(git rev-parse ...)

where "$br" is somehow empty and a 40-hex ref is created. Please
examine these refs and maybe delete them. Turn this message off by
running "git config advice.objectNameWarning false"
fatal: Needed a single revision
```

Doesn't work.

So these refs essentially cannot be accessed anyway. Restricting
git-update-ref(1) such that it cannot write them in the first place thus
shouldn't be breaking much, I'd claim, and feels like a strict
improvement overall.

Patrick

--I+VCeoMHDJWJ1W3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWzQoACgkQVbJhu7ck
PpToRxAArlCTng1pCMxmbH5EWLWNtaeJ3EG9Qwf9H0vr4rnC4J4q8nsPIOdEAd+c
6SUXhSJ0F52j7zzbGCy0HPycJrnRNAFjiBzkfkdNwlaMM4wNbyZzdqT9AOvo8vu4
n63BHbIYk7QoTJPfCNmJF4Wubz+y5mmLTSYWVfZo0aXVlqjMOk3/iGteG3rsRWOH
NEqP03QB8Z/OWTTtLDWkmQEebDSMySr1U+/45/KeSFNuNredqOQgER8RtAuyM+M0
JmQ2HAHOJxZeca65dTCaCvdXGwBN4hyzVIinUS6R4xYY/XA3sUUNIbx6AicBvRzj
El4vyQU6FQIpFP4SAJ4jfpqQiTm5UYqZqdpoW88Sc7zwL1rq6OYN2tSH/HZ/ygpY
Z7s+pKEhgAkRH4GNmQLwbVoA233ymGqykMFQuGwA6DIagSC3rbbWnqlMvP7uRuHl
dIiNy9X2nON/JrdhnAzFKHbPWZNYSM9o5TFEdrIkyHkjjl0LKehVvM8ZdXWHDBcz
5WTQTWufh/OWPBglcbaTLnFgusjj4YrjH0o3m143rKll9/WN7f09afS19yCBVM46
LsduuJWwe95J4b90eyroyMaiO59HHvip8WRxy2zHGrdHR6J7OPGGf4zjGkUbUSC6
8n1qGnH+PaOokXpSoFxILY7EO+zipl5MEoGwAYIt8M0MJ3W8CFw=
=aGKw
-----END PGP SIGNATURE-----

--I+VCeoMHDJWJ1W3q--
