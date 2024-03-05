Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09524F894
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639015; cv=none; b=gW7+PVWusksqtpACjCbTVDYVZtopjm5pEW1IEv34sdNiLuHUQe00H7O6m1CHgCi2xAxuD733deGyemUUVHVdPXRYp4bLPhtfBPsJptu3eh6+1spp77+Pi0mkV60VxyahWnoDINa1TuImvANr78jafjw5akC0JC+Ff9DoaSusFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639015; c=relaxed/simple;
	bh=kLT0sBRd5GGXU4nFBue/6KcFeOlWgWbGh1IYPZPZvH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk/Ws9dqeoOFjJhJ0ryzZ/kiCruHh6t2ufwAjKE0pSn0fQdmsDspttjolfHqNd52F6nBDcufVDuo+tlSo3U0lMErgvzDDvuSWj0a4LYME8PR4wzV/RSY/R890SlqmZG3KT4xQsj4VtFXNEYGEBOfiZCFBDrLWn+EedcxoEE5orc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KMEj0I99; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dEUOTs9H; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KMEj0I99";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dEUOTs9H"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 5A7DD1C0009C;
	Tue,  5 Mar 2024 06:43:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 06:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709639010; x=1709725410; bh=lOThmn9DCf
	nbSwq2oxV8pYu9jic2O9Fz2j5w/hZrPBo=; b=KMEj0I99XaDRxNNKuSTkOXDzJi
	1lyDLCx3wyS01iDJZi2a1wkuQbZDSJlxuhagNXh/MvJfXFS6q2krXOQqZFvf9hHy
	LhlQSeinxawaSCB2KkzOKe1ruN02sXVwgWKWTtyqOaPUVyoB9Oi1fa0Zj7cuO2p0
	6VcDJU17wWB/QBAMYQHj3L5eg9BZP2ODjmtN9uC8DkGJloZaQ9AscE0QwEG6gWrU
	580rpbSyx/2CSsGfdTF4K27lXwk9ZRUNT1HcH1/eI+s1uLjMqOjLZQmP7JVIAJW6
	VMN2a3H4aD5Xdyv/JiHk3CMspFHbWk4/pDzFtDnepwX83/7/S9JVNaaH2FiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709639010; x=1709725410; bh=lOThmn9DCfnbSwq2oxV8pYu9jic2
	O9Fz2j5w/hZrPBo=; b=dEUOTs9HYPJ8L7lZAMgVLs4DAaYCmiiFyMflDxacMq0C
	gl52ADNIaY8GembPGYTE9dA9wOSRQU4JMKYBl+WIGACCPi12IK7Jzt8k2pJKH2U/
	akh5oUph+TuHt9wwLUscIRarIwrJqJo2qQCZbkbSC+AHUUbGPXFdnXgUPPtcPhX8
	QEMPNTnHTdoB2IIgaZ5QDM4N9qa9DG9uJWkiGWQfzUPsJPcFLvLvZxKDck6rhAw/
	4nV6OZzWaB62QplrqU8pzfdNRJOKSBC/+nXW43bNfZv2q3/p0BowT+RZ3VG27UT/
	ujWvizZUAEO99/pLh6C5pnUveDd0EIMOBkky2lFp8A==
X-ME-Sender: <xms:YgXnZTeFW5X4F5HVjfxoWWVBPtx83QWVhzzlJ-I50pW8RRqHqPWkVw>
    <xme:YgXnZZM-UZrpHp6MNsPIMUlWP7_rYUe_cZSepNmkJ_3daxFhYfTVplystjI2ZrI7_
    xKtQPgKRLfJlWBg0w>
X-ME-Received: <xmr:YgXnZcgOtNMr3ekKn-hPyyHrKNUq7E_3A3SiX0AC7h4AwD92gJz8JQ5SY4CstANuB1yEzEJlgCa28fnbrlQao8tYdlDmhE9FPp3Ppz7Cw7T9FUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:YgXnZU9nNT4d6z6lRGmkTD_csMtqhFM4n7lO9Xj59T_scc40XgL-RQ>
    <xmx:YgXnZfu6pXIbHUVEuRtkpCuDWOyuT9iRkiGrzY4DBFmw_gRP3TRy_w>
    <xmx:YgXnZTG72EB-kreffXdbyYG8VctlU3gGoEJ_Cxm3CQtZbD2A6S486w>
    <xmx:YgXnZZLDO6XOWcUbMK7UcYqhWGgfb2x19IWNX8wHC_9GZd_1qthBKwAqVtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 06:43:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c73e39a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Mar 2024 11:38:59 +0000 (UTC)
Date: Tue, 5 Mar 2024 12:43:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] refs/reftable: don't fail empty transactions in repo
 without HEAD
Message-ID: <ZecFXXqUdGEQ3YhC@tanuki>
References: <cover.1709041721.git.ps@pks.im>
 <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
 <CAOLa=ZSycN0iYbBP-rXKW5=tNJLaSd0q8+Vm=CzNfsP2nR0sJg@mail.gmail.com>
 <ZeVtuqEAelfiA2J9@tanuki>
 <xmqq5xy2rmfy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O8ZmD5TUZHR7V/eg"
Content-Disposition: inline
In-Reply-To: <xmqq5xy2rmfy.fsf@gitster.g>


--O8ZmD5TUZHR7V/eg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 08:28:17AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> > Now there is a very particular edge case in this situation: when
> >> > preparing an empty ref transacton, we end up returning whatever value
> >> > `read_ref_without_reload()` returned to the caller. Under normal
> >> > conditions this would be fine: "HEAD" should usually exist, and thus=
 the
> >> > function would return `0`. But if "HEAD" doesn't exist, the function
> >> > returns a positive value which we end up returning to the caller.
> >> >
> >> > Fix this bug by resetting the return code to `0` and add a test.
>=20
> So this _will_ surface as a bug when the other change in the series
> is applied, but it nevertheless is worth fixing independently of the
> other one, because ...
>=20
> >> > @@ -821,6 +821,7 @@ static int reftable_be_transaction_prepare(struc=
t ref_store *ref_store,
> >> >  				      &head_referent, &head_type);
> >> >  	if (ret < 0)
> >> >  		goto done;
> >> > +	ret =3D 0;
>=20
> ... after "if the refs->err records an error already, skip
> everything we do and return to the caller", we should take the
> ownership of what we return (which will be in "ret") from now on.
>=20
> So the current code uses "ret" as an uninitialized variable, even
> not technically so because it is "initialized" to "refs->err"
> upfront, and this is like a fix of uninitialized variable use.

The problem is a bit different. We call `read_ref_without_reload()` to
look up the "HEAD" ref, which will return a positive value in case the
ref wasn't found. This is customary in the reftable library: positive
error values indicate that an iter is over, and thus by extension that a
value was not found. It's fine though if the ref doesn't exist, and we
handle that case gracefully.

The only exception is when the transaction is also empty. In that case,
we skip the loop and thus end up not assigning to `ret` anymore. Thus,
the positive error code we still have in `ret` from the failed "HEAD"
lookup gets returned to the caller, which is wrong.

So it's not uninitialized, it rather is stale.

But yes, the bug _can_ be hit independently of the second patch in this
series. It's just really unlikely as a repo without "HEAD" is considered
to be broken anyway.

> >> So this is not really a problem in this function, it's more of that
> >> `refs.c:ref_transaction_prepare` checks if `ret` is non-zero.
> >
> > Well, yes. I'd claim that it is a problem in this function because it
> > returns positive even though the transaction was prepared successfully.
> >
> >> Nit: would be nice to have a comment about why overriding this value is
> >> ok.
> >
> > True.
>=20
> Yup.  It seems we will see a v2 for updating the test code as well,
> so I'll assume that you'd explain this as an independent fix (as
> well as a required preliminary fix for the other one).

I see that the patch series has been merged to "next" a few days ago
though, and is slated to be merged to "master". That's why I refrained
=66rom sending a v2.

I can send a follow-up patch to remove the useless variable assignment
in the test, but other than that I don't think anything needs to change
here. Or did I miss anything else?

Patrick

--O8ZmD5TUZHR7V/eg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnBVwACgkQVbJhu7ck
PpTisg//bwC5uGs1w59OtydN/faZBbn/sGS+OCQ5ddur+dkAL62pUi0nA0U3Cdf/
h0xZ9MbIU7NcwHHOJ67aod4LMnNTOStWS1YnuuXN98U4Hi2LYTJD/U2B3oM8nuRj
sji7zENMbA6AylAJ2xG0mXdmGdaECrjFQdHxu9Ec/JSDDKpqSJ4DcBvvZuATV6v9
VrnZZSdMcMvFoRSrw610dYsaXlqE6tQl58ZnEKjUuyK6rOwL379PsGuPa+AltPCP
hfbHhQfWHTnHMfsZ7Lov4X1ntDhRJMixrUXI7QjVL3dJ11OAcjug0PxQQRQEo7rL
pv73K+vSLA8BD0UQHe9M6TXnLsJeK3t+HoA11o2A3VJTE7zTZmVWjk9a+av0eHuV
/PSmn/+HHlLAKYyTYxk45lC5h4d8HWo6BJEaPpDukie1IBlDCzxS+z/ViTWpxOno
/Sh5w1M7wuNFOI6nJH/st8nkvFn6TFamC1Y0iQid+dl1kDMIMZMXnzOwV3cu0o3G
bfSRRrK96DzDvD5owyZ8ws4+maaa8A9a+mtLjxMY6NTZBI8AqnUvyv3A4q4iEQAo
qKOmuVX8xE7ukjidJCAe9dx3soBu7kNFyiO53RICJRJyPzOfLlfKfdR8L+S7Uet/
FsQWU2QgQH7qJg4rrP7UyT3TG9JblcbOzJs4CLmWGGdXQ0y7Ako=
=BRnR
-----END PGP SIGNATURE-----

--O8ZmD5TUZHR7V/eg--
