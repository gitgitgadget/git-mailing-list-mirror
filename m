Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0843EA77
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509964; cv=none; b=bxA9mRzmPRTyMR1TLaZ9UGwQQbj73qvepRkxnHvu4YLTKxv2rQggAvQfp2uWqT6BazCLf0nbiJt+1ZO0I+FQLYOIaBvGudu2SJPA/XDnmWISY+UGmJ8aKA5knH6M0JL9Scu/CxoegD3Ox5Y5O1PggASq+CF2qDrEOqpGVNedFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509964; c=relaxed/simple;
	bh=ZqklWq9/U1IhSueSbGZnQd0r4xs/om4lbKV1tkUPHd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2j8DlwdcFSBymXIubS5bGJ/erQ0CYkPCsoDUAPLciCWvZCeJuN/oyygamKMD7F5OxlJNav5kndQ8PflWA2Gcn19Y44YGaTBtyyU5P1SCHqwmLew6dw3HHumUuv5y4+7jlxKELoIv/ZLjzYLzxYBh5hnxTEYGWMe7+2OzC7S/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MujI5Kjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HHy6K4aC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MujI5Kjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HHy6K4aC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D7456114008A;
	Wed, 21 Feb 2024 05:06:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Feb 2024 05:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708509961; x=1708596361; bh=ZqklWq9/U1
	IhSueSbGZnQd0r4xs/om4lbKV1tkUPHd0=; b=MujI5Kjx6S9DKK0j4clyznlF+K
	mo40Sn9Mw6XBravSrEul2fWBXSxTTA6Mpe78KroxPMs4UvCobHuYjCwZkEWL1kXr
	jm59uj1Hs58xolx2Dz02qPGYc9jRTDwQaBAUKXsy1pu81s3GtVHQAt+7W2xchOz2
	Wx4JeJokXt+Or9e9kQe+hnv+0pSwBkDEtqo1+6tHa/IMCbyuqAPXIAx8tSdpfkSh
	3o0aHQg7f2cht2lWYtAnARxc/68T+3tjtSqd3vmzYhz+EvKPEA2tqwxTVnu38YiR
	SXnKNCTbTYevComC9GHKFng3pfOR24dLxO88aQ34OtniZT9xISQiE/1IupSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708509961; x=1708596361; bh=ZqklWq9/U1IhSueSbGZnQd0r4xs/
	om4lbKV1tkUPHd0=; b=HHy6K4aCz3hR2bbyjNJEYWlC5G3fp70IxCh4BomXvAtj
	chJ4pF4j+H2qYZ4Fc5DyYAM4xIvCXcJQYnPy67BY/zHqwS8snBrEuryBmkzsCHVW
	fT77PPQc9PH6KiCjHwJD/600lcv42Fd94OPMIVgF2HcULGep1VRq6+RLXQo8JMhV
	qxesuGYu9/ivlio4FJWXjrbUGEoULjn101ypeUMvZYVVdE9BQU+3HvxpkFK4v2UA
	Zy0/e9WZqQam+DU0UO7xf7hvXfS9JKONmRVy7x4DPZ41HLxK0Hfofy1JuS36DT3a
	nPp4G8siCUCoH/sjqrtlBdQj/eAGvLsKdJwjoNj9Tg==
X-ME-Sender: <xms:CcvVZTH2FTi1KxJ70Qx8nIQu5YEsqOxATxaBlWpwkoKlrow8zg92mg>
    <xme:CcvVZQX1q1ciT11s6duDtQ-Csc7v6rgqEakEdr5AmGsBKuWdFCfT3aYDv11x_kRkO
    dVA-oEcQq7ejNJ0JA>
X-ME-Received: <xmr:CcvVZVIpVgDuAYjdkgtJXYodfb7AuSlB8JP32DbdlZPyi6aUYGFpc5NM79INLBOXv5YX3XneySExpzMAxMeJTQ5rIxlORmkYwmnH6wXVtixj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:CcvVZRGwSgZUnkuhKm0vH9Gx7XGQgRQE72HyDNmOOYmvuSiQXuhfuA>
    <xmx:CcvVZZUB7BGQ-ejDsaXWaJAyK4bTqHmtFoqu0u7fN_j45k7QCds37w>
    <xmx:CcvVZcMmK9c3cyTrDmr6tCITFuqPq4ozh7dvsxhJuOstxTmL0NaX1w>
    <xmx:CcvVZXf0qBgedttQrqeWE8aq1OsSlt7YGc16e5jmLVXQ_21_yn-N8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 05:06:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d36caaaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 10:01:54 +0000 (UTC)
Date: Wed, 21 Feb 2024 11:05:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
Message-ID: <ZdXLBIv1vLjhQUgx@tanuki>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <20240221084250.GA25385@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/E4+M2fzuCGM6pDV"
Content-Disposition: inline
In-Reply-To: <20240221084250.GA25385@coredump.intra.peff.net>


--/E4+M2fzuCGM6pDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 03:42:50AM -0500, Jeff King wrote:
> On Wed, Feb 21, 2024 at 10:48:25AM +0900, Yasushi SHOJI wrote:
>=20
> > Does anyone see a segfault on `git show-branch --reflog refs/pullreqs/1=
`?
> >=20
> > It seems files_reflog_path() creates a wrong path with the above command
> > using REF_WORKTREE_SHARED.
> I am still trying to wrap my head around how it can get such wrong
> results for show-branch when asking for "git rev-parse branch@{0}", etc,
> are correct. I think it is that "rev-parse branch@{0}" is only looking
> at the output oid and does not consider the reflog message at all. So I
> think it is subtly broken, but in a way that happens to work for that
> caller. But I'm not sure of the correct fix. At least not at this time
> of night.
>=20
> Cc-ing folks involved in 6436a20284.

Ah, our mails crossed, but we came to the same conclusion. Things indeed
are subtly broken here and work just by chance because all callers pre
initialize the object ID. So in the case where the reflog is missing or
empty we'd use that pre-initialized object ID because `read_ref_at()`
does not indicate the failure to the callers.

I think that this behaviour is not sensible in the first place. When
asking for the reflog, we should only ever return object IDs parsed from
the reflog. Falling back to parsing the ref itself does not make much
sense. I've thus sent a patch series that changes the behaviour here.

Patrick

--/E4+M2fzuCGM6pDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXVywMACgkQVbJhu7ck
PpRVyA/8CM5EwyUx3MI3JnMihurv1Z+Pn3aAZ7CbsRRMQ9vMGJ8rGSKkIkFHzBrR
2wXOjMrqnJMsQT1Ws0dVlf3EyEb5zSCcKTRr09/xFGAKSHbSF10lUs89BeoR/lCu
tMqopJcwJdst1Z0fL49MCU3FJGwYGIDnO3GoOO+dcDYjUzKvC6RxCClKWGQ55m71
JKrACd8LCe1WdtZ+kY/kPyd32BuGF+jofM3DendCYzr86PYyOhx5bFYc9QiiAIzy
H+4BiXLcZIj8NG1+X8xxVuMmaprGpjYjZN7xc7InDSY1TSVdDlZVSilim7gg+faX
JAa2al+vODd2U4yMwtxCfkPk35q52d1ukwCKWC+lEqT8G6dx7QEq+HddulglEXKr
aNadJoryX+6h4QeXIMaI86EuPtd2T5IbTmh1q/JbGC4jCxcB91Oa+cudEH/p//U+
mGx1VECyJO7SMMbNZLChtfqstmKviRFkNwpoeCTnu+Z5kt+yP4/M6vgT5fbmIiFr
C9kXcvcwS1wtb7wuvpg0OVDR/LfZsm7Jybn35bC+MQDWNvEwEZyKPw0r0VdnxWjX
JBLwFZHEfnsfKKXF7j2AyZg1IEuQMWui/zr7A8DGlu4cGNBwNV9EOzEW6/O2lIzA
2uIoMpXX6xmAym3EkFxnVyzBbfe4AdsL9RPbuqiUGCSS4ej88gQ=
=Va7l
-----END PGP SIGNATURE-----

--/E4+M2fzuCGM6pDV--
