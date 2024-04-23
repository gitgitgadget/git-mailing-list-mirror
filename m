Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB3E17BB7
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853904; cv=none; b=Qws7tg4qTBAKTUwiU+jU4ZzzlUnDfj6g4Z1XpS3gmRXoaKZVC72yc7uzTWdzi79s2oquWCzJORuMlbjUIGLHMy28pZztgI1qrByznytueQTF9/iY7sI9lEsgyBjZPh+ZmQ9etGkMycuINipLGIUKcfUlmqJDLMOd4FenWsYMhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853904; c=relaxed/simple;
	bh=DpUg7+01a55Q+4Y1UrmWcWv3MJiCUmDPw6617rLQX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFEFA1d2jfuVmmReKAer1cNee48KFLZxAllqghaeFFyv4qvSSFmeLKb5kZkushFS0C9KBgGNZq/HxcBGU70dn93iUH8F+SAAloRDjKNqXKBFwT2mr1TZa9tmdANQEDmJYDmwjM7vSDOPk9h3ZCpxxDiLof9OxHIgSiydq6Hwxeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aAuZsM7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=You7E00B; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aAuZsM7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="You7E00B"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id CADDC18000CF;
	Tue, 23 Apr 2024 02:31:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Apr 2024 02:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713853899; x=1713940299; bh=YyZO94Tvx2
	XzJ4S6GjtTZWT3XMz8ccnnFq59UF/eIvg=; b=aAuZsM7B3+AZqz4vopxCF5xQ7y
	mWINMrnu79Tb1T4lSymyP73HiXoW1RN/6d12CwxEIRFtHn9waFv1RBeSdO/u0MYf
	4UweigSBk8Pjs9FnYY6ZhzISAcz2RjLI2BkNVtb750D61XjwCGJpeljc8y2zKA5H
	xqR7+RmmWi1Qd6mFdSs7p7oaE9gQ2ovISzUg9gLSC7XM5CMRiiKO6Pvm7fad+V9Z
	QadqXk2/utNn7xEkSZIIwnQ/6Y32IlFzvsVDt2hjLAevmTiNCn9hED7f9BJbtuZp
	wbXe4JZBYv5V6OXeai4wp9+43hl6bQaH/ejEbG+cWlpiSreWmKbOE4tISjUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713853899; x=1713940299; bh=YyZO94Tvx2XzJ4S6GjtTZWT3XMz8
	ccnnFq59UF/eIvg=; b=You7E00BjcQgzpu2ZGeBKvLzyaewSJ6TqTuqNr5HwEuo
	aBtYvtYzOm1CVgefzPN3kY5J0rz+2hq9U8DP1TQJEyMomqlOyPCTITG4Y7Zdv663
	yTYL53Wi3iCMZzkvt4KZlBjKAGvck9XBY/cmvqfSvrUMeYrTtNE6BbOhkdGl1V2Y
	8bBEqlbbYle33/aSaRAE+2ZBhW9n8vAwawMbYeq1OrwzvztohYPbdooo7IelBryq
	FWoc56/HnS0TAeod31CcOEmGbAX6GlJfIpHfSSsC18S2EK2buZ8uSa+nWdnHXs6P
	b6zdiOA8EwW4cHdhct5OpmJe/0Sz9K8C5OZhS8d+YA==
X-ME-Sender: <xms:y1UnZkiHrWj0-ZVcECAdJOlD-bZSuY9xnAUkI0a69HobM8b7pnVosg>
    <xme:y1UnZtBlw-e4qLaU88Nd1n9FmTGnpVgUQp1kSroWCm7Ih2wb36sMUez5jTOQXNMWa
    IsIsy5HM0h4lLa8Iw>
X-ME-Received: <xmr:y1UnZsGRy25lCwt9g3GZD2z1dAo3ZYGRWBFZIzl1dLb9y_5enSnszakbcsLWVjWHTPuQTErMMFljuqTX6l6G5a__rIfWEjokuIcvnCE_Td8JcegQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:y1UnZlThbxJ8OpBcUcAzXWUWnez-MAHkQuy-Amq-a3_CufEdvrc3RQ>
    <xmx:y1UnZhwtyCuM-mJXfYB-BxH_KfztHhOcMAgEAKPGlCINawuxSqvM1A>
    <xmx:y1UnZj75eNuhDja-SnB2ccv_R8BT7glBs-DXaIWaMXcrsswm_ygOmg>
    <xmx:y1UnZuxkNR4Zb9tRXSOAYxzFHuFbQx5FgCU1sbcoB3R2tMCMJ3XgZw>
    <xmx:y1UnZjslno0PGIcB7WcptZ7GEyb7uj3JMLo8accHukpQp7MPKMy74et0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 02:31:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id badddeeb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 06:31:27 +0000 (UTC)
Date: Tue, 23 Apr 2024 08:31:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <ZidVxMcTOd9ga9TL@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com>
 <ZiI8AfkJL4O3K7Xk@tanuki>
 <CAOLa=ZT8=1qDbsHhk2gnVfgcGOLv11+WgvyB_DtuB7=hPL+jyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TYNeakJp45m1fq/W"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT8=1qDbsHhk2gnVfgcGOLv11+WgvyB_DtuB7=hPL+jyw@mail.gmail.com>


--TYNeakJp45m1fq/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 01:09:39PM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Fri, Apr 12, 2024 at 11:59:02AM +0200, Karthik Nayak wrote:
> >> From: Karthik Nayak <karthik.188@gmail.com>
> > [snip]
> >> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> >> index 56641aa57a..4c5fe02687 100644
> >> --- a/refs/refs-internal.h
> >> +++ b/refs/refs-internal.h
> >> @@ -124,6 +124,19 @@ struct ref_update {
> >>  	 */
> >>  	struct object_id old_oid;
> >>
> >> +	/*
> >> +	 * If (flags & REF_SYMREF_UPDATE), set the reference to this
> >> +	 * value (or delete it, if `new_ref` is an empty string).
> >> +	 */
> >> +	const char *new_ref;
> >> +
> >> +	/*
> >> +	 * If (type & REF_SYMREF_UPDATE), check that the reference
> >> +	 * previously had this value (or didn't previously exist,
> >> +	 * if `old_ref` is an empty string).
> >> +	 */
> >> +	const char *old_ref;
> >
> > I think one important bit of information here would be how to handle the
> > update from a plain ref to a symref or vice versa. Would I set both
> > `REF_SYMREF_UPDATE` and `REF_HAVE_NEW`/`REF_HAVE_OLD`?
>=20
> I'll now remove `REF_SYMREF_UPDATE` and add documentation around the
> usage on `new_target` and `old_target`, where if either of them are set,
> they take precedence over `old_oid` and `new_oid`. The `new_target` will
> ensure that the ref is now a symbolic ref which points to the
> `new_target` value. While the `old_target` will treat the ref as a
> symbolic ref and check its old value.
>=20
> `REF_HAVE_NEW`/`REF_HAVE_OLD` should however never be set by users of
> ref.c, this is set internally. See REF_TRANSACTION_UPDATE_ALLOWED_FLAGS.

Should they really take precedence, or should it be forbidden to pass
both old target and old object ID or new target and new object ID,
respectively? I'd rather claim the latter, and that should be detected
such that there is no bad surprises here.

Patrick

--TYNeakJp45m1fq/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnVcMACgkQVbJhu7ck
PpQBYA//YZ5EVhpSvh1PtNjQdyo7lMYhmLVD/E/vKgTNFaStHy1UTrZFP/BaqSJN
Y8H2G0gxU+C+llsFVY4aY3Jpl1WFsLb7alAd3L55zkLePEEfQoPAlwmStGqKwo5U
7NeACueOq6D2KTzYhcH1jfDPJxTlh1Yw9SmgAfN+Y1i5nurIFqKH7ZK3coik2mIH
53R7PpSxsUV1hPmsFUaNnKSnKgVww+C3DarVxM4my1imbvLOUslSegx+ucXb/0AW
/CmdDS459vMzBc6X3q3G4+8qO41IXMjWXlOtYilL4Rpd7KkZ5Ea6RD+sy+/G9R8u
7mHr/zZGDegcB9EetswoExl7PEI6ZpxNivY6wqZIXej1M8Eaa6rwkCGp7LFDPVu8
R+8gsg4P1pDTTnB7Oon+A6frVFyq+Oyc8spO8hnRgmy628TUQdglbmNyJvRIyXPC
nBsFReW7QFlevKhYpLD/YCKyV86W1X7t7uLWBRW+Zjgc2fj26XCpaAugMnmlrF5D
9iv9OfRiA5EZ/DVZI5dAHMNwUvB3Ms5jfEAZo5D0PgSzrCYSd5m2bgWvV1IC4NSN
HEb+zTDc+X7ujI/J8wPMRORD/Q4jPdz2w16JCAtfjOQZTysoIZl5HMTnfjDyc4CN
Azf3W8AiNit9Gp8P9mQeinJbxEfkoOmeBOu9dkMcp36iocf3gCs=
=v2qM
-----END PGP SIGNATURE-----

--TYNeakJp45m1fq/W--
