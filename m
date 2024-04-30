Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91936481DB
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462217; cv=none; b=B66WSAx5QWk0FyCRn8Jc9nvCS3VUVVF+obiueEzCUPt0wNmT6p87M4n115TuXpSqbRIVMxwD1mDPlaBkJE2JR8VqLv0y641AMHyYDddF8kIMLFieF+E9PIpQyd4xj96MC34krok7Lb2GSFLkv72H1+a+ZeQXs7ds4yEUhzDkKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462217; c=relaxed/simple;
	bh=1XYH8Lzu2urHjAxdFYhKqt7jSCDd7hzjEjZCx2xGDvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbuMfXyYIBpx26EojoscnStNHE+rNa9yfdrIAGOPzbEHw4K8/eaetDmgE95ehApL1uwL205nOoGWbPEVCr0UVSHa+IMlBHywmRdILaaPteRohIbuw2jdHDMAsCO8iiwoVH/6hgPCZipn5nDelIUauaOYq54q97Jlto5+Y/l5+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nGx2/QxT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fqsw0+lB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nGx2/QxT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fqsw0+lB"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9BD1013808F9;
	Tue, 30 Apr 2024 03:30:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 03:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714462214; x=1714548614; bh=1XYH8Lzu2u
	rHjAxdFYhKqt7jSCDd7hzjEjZCx2xGDvU=; b=nGx2/QxTmUhJSwZaMVLLe/HmX6
	d7LQ2E4bkOHTH3ArOhs2EVTibshYI3NQDLHLZlvbyU1wPPCPrFhqNJ20JkUYDAUc
	wQ0TFbkqlN7P437u0pbxX6z+TILLmYshpHZuw4yNDskQL3coBWENZ0D2nuVddcbX
	lT/VKTJS2WWslmc+JRDRYQlq/qjIk6V3+0EuMvAT9VWPjC+xF8RucMpNTV+fJh1x
	2p881+qdtCJnCTLwLamWvR/CizoPM9xfAx8AThbSTHXJ41LCQUlh0o5AWsTnwPge
	R68IcJUVMI0i3mkvrDGPhI+qU+omImtGJfUbTt4MpLcftWxnstB0gYTMOM7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714462214; x=1714548614; bh=1XYH8Lzu2urHjAxdFYhKqt7jSCDd
	7hzjEjZCx2xGDvU=; b=Fqsw0+lBueMrm0PYOppOw1ymDu/PPtcDRbfejJGyV0je
	EfqpPmcl4jxY5pRwuIOEJcpxlkDTqyPlHRhHi/K/M6hCyVglzqyGykBu3FnpGSaZ
	QZXh5wAFiDXS9E5suzKJ4lUI19lnLTbBnep+tHSIBOYeeGZBdZ7E/gAbjtcwd59k
	9aXwy8O1r9tUOQ+JWSrhCxrk8mCJcPATrJWGuJX2x1OxkVPfB/r7OpSLEbvShzHH
	FSLHvJ4KDz4V3hcewtyvlN+za/Wf5iGvIqfvdJCXbaKXZo3CmtvLrRFayCGVRrlH
	OG2rYF732XoECmwL6GHPWeFBV7QzuzaMZGdB8g8lDw==
X-ME-Sender: <xms:Bp4wZiP7-UqnCCcttNll8iTf5m26mi53tCyX7D6US9kvuGyowiEh8w>
    <xme:Bp4wZg98S6qseBetWRJyRYylGaGbdvqCVl6xzDz8qHN1wjo3Bw6UoxVsHNDFXkoLo
    qlM9FoEIYV4ud50lA>
X-ME-Received: <xmr:Bp4wZpSkzaow8SpDmBYE-rubs_p0OiNkmdUhd2omg2g29WjeeVQ4QMaBe0_3U6TLdINKtp_gM0SBp0xJMENLdathhPydXUUpx9u3Pw3QA9rK2c772a7W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Bp4wZit3v9A92tEJtMzis0ue5_pNomhU-QYdQ_W5poMMVdp1IcG19g>
    <xmx:Bp4wZqcjfkg0Cs12QuNAIWVKTr0lYYSS33t4WsurSPnkyFoCItJzog>
    <xmx:Bp4wZm3Ul2KTdXfP1vWFEYjfHp1X7cvqIDCqtTqHS0nuWyz6RSrcvw>
    <xmx:Bp4wZu_xmDCriPO8iJ9b34YmUqpgTX3gnCYKJ3Zid4-dwvcrVnptWA>
    <xmx:Bp4wZq56605kzCmUYgr0NiF0H7yliIsLsHlLGIyaAIEu7hmoHV-2DiAY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 03:30:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1a65e6a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 07:29:52 +0000 (UTC)
Date: Tue, 30 Apr 2024 09:30:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] refs: fix segfault in `is_pseudoref()` when ref
 cannot be resolved
Message-ID: <ZjCeAxbL9bufwGEN@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
 <CAOLa=ZTCCgtQiQbm_GU--1+Yq-qYJANzTvRmvVrqNmzchkVevw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zaX3781HnskLgFLi"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTCCgtQiQbm_GU--1+Yq-qYJANzTvRmvVrqNmzchkVevw@mail.gmail.com>


--zaX3781HnskLgFLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:57:53AM -0700, Karthik Nayak wrote:
> > It is somewhat questionable in the first place that we declare a ref to
> > be a pseudorefe depending on whether it resolves to an object ID or not.
>=20
> s/pseudorefe/pseudoref
>=20
> [snip]
>=20
> Phillip Wood <phillip.wood123@gmail.com> writes:
> >> via the uninitialized value when calling `is_null_oid()`, which causes
> >> us to segfault.
> >>
> >> It is somewhat questionable in the first place that we declare a ref to
> >> be a pseudorefe depending on whether it resolves to an object ID or no=
t.
> >
> > If I remember rightly Karthik added that check to avoid the files
> > backend calling a file with a name that matched the pseudoref syntax a
> > pseudoref when it wasn't actually a pseudoref.
>=20
> Not sure I follow. I think it was strictly done to ensure we don't
> consider symrefs as pseudorefs [1].
>=20
> [1]: https://lore.kernel.org/git/xmqqfrymeega.fsf@gitster.g/

And that's fair from a terminology perspective. But honestly, I really
doubt that any user will understand that REBASE_HEAD is a pseudoref when
it contains an object ID, but is not a pseudoref when it is a symref.

Anyway, as I've said in parallel mails, I want to change the definition
of what a pseudoref is. I just think that the current mess is understood
by nobody and doesn't make any sense.

I'll thus implicitly address this in my v2.

Patrick

--zaX3781HnskLgFLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwngIACgkQVbJhu7ck
PpTWSQ//R1Eh1YiXbt7dA7J+rTEVG0do5OxqAkkjI/EKSlxpMeztStVGsfQzWOnY
lZZr3odpEEdiy5LNxhEfl40/POMKtAjL+tzjYISmn8vgX9D+4JzavXuKKAC6Jpgg
vZ0P4spjwQoZQXAZM5XHgsfb1PQpDQ0kYtP6oMHOzpcrMRLMOO6uC2okg1/AmFy0
ic2pOJ8TteeCOHMwP0xwrhfHrRROVZu+18YL+RKMk/+PnkXFWqntJTAlz7h45O50
+23jWu0gMJ7SSx88N6ae1HCqzECQxWQkNdClI3bJhNM5GAHQaCmz7ZDJqWGo4BJO
AogDv9lAFedRsZZJOT7yJ5CvsimOG0agI6V9B1UyNzg5ID3ujXK0oUdTZTXjpERT
RR9GqiaYjB/hsURDUFuJofN5vMhY9DFTgTZ4YQlVEG3frSYWc72WVlQ8XLcrkyD9
/ml5zzyt2vo+8to+jV6trpzBXbloXtnfB+tWjzVnmjC2zB7DuHDfEIjXurbhIkME
Z2piTZfreCuA5wSamz6Ps4dsIAvgu4ziSby32ee+WRXbpX7IOdP10GfvA6C7vRou
fuOc+JITq53WHR5kctjlpAu+si/12p4+NR4XL/mqpkZAxYQ5VJL2CyJAyLRWBB+2
voGBlRsM4UxAPqsJ/EjvbaS9AFQwm6vtUp97SWFE9jdmUNenQyQ=
=c3ry
-----END PGP SIGNATURE-----

--zaX3781HnskLgFLi--
