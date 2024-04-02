Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B414AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078148; cv=none; b=hcdIWUaPtYiYWosGii9EKLqf07e+pFCrDMMObWt5iIH7UD3DFKdOeV8O5LuSFfQZcvls/OZ9j7tI2uz4Cd+REwPqKPPV02HZtnYFHudYZM29GoPgjUotLrMhAZbzocZoK+tZ6fvJlUiHkwqgdDlQyjc2aP4nxAc4Yh/Yj0vQ4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078148; c=relaxed/simple;
	bh=809f2qJ45t5kmbkIdmaff4jdBIIB+Zsh5a5kXNOgo28=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITke6pl8zf1ED6VU83gTJD8Qet+pir+GHeyELKjeGpH1a5eZtUNoIFb8ZKCdcEMBxOxkiOhRzZfPWSgLIQRNyR6Hl/2AKEQwGLdeBPU4oRyuRjn82VSnlviuCFnu8X2BfUERoUiK8q4PZwbazcTsbgfkOOoN36g89RmoZWKAzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kCr0K+Uk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=giuaGV66; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kCr0K+Uk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="giuaGV66"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 042B01C00074
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:15:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 13:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078145; x=1712164545; bh=+p4SGjWvYR
	JxWPGVO9L1n+sNMromHEnhceA5/ZrZ5D0=; b=kCr0K+Uk2VE6gVBmLZXWi6Pm8+
	h6tORxNmBKd1mUZPnkDsPgAMHiRlXlCCYnnadTje2FZN/skTZgmL6vBF7PvtLgVg
	C/IdwwtywNQ+lil8oTpm1/uJ2+EX98aF58l528ZVIKiR0jRXjbUoY7EmKh3NTLG/
	q8QlbNpx1DhBLHVAEk+im9cmFu19/bk+FGnB754lhxi8EAkXIptKcHznWNE0o7GS
	rIHRMH9gGdxLBbTZSaGdWHE05i5TETmf9BHAj8OH35eO+updWM+t4AEq47OmapgO
	cMGXEghnWFbTWM4zee/Ufnme9FGFbjQA+mZR8ylSbcH147xR5HOC9figG1xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078145; x=1712164545; bh=+p4SGjWvYRJxWPGVO9L1n+sNMrom
	HEnhceA5/ZrZ5D0=; b=giuaGV66z6Bi7UcaHh0/UD3KnziY7CVb5dZ7hW0YtOf+
	Yi4cF+SiwciImHVQ9bj2yjZvC1sRQGTyXwU9VRIrR/dSu8g9CXiGnYie54YkwMyX
	S/J4rs0iB8OTrOhYtLO70lh7Ygsf6cTxZy4TXr60EFkJ7JOI6A7dC4V2xeSaQLYA
	dQ26mcgU4DwTo96BZi7UIn4GMY6Omf566lS80owTs+oTHa2ohuKgRsq7cv0AQFX6
	B02C+RW4HpAmLDF75CEWWRqyErvDExpX6fdDPztcR4wrza9BRnRvKBXHG8hDVof0
	wvEnY0454ZD8mABCsMQeQNj+JQbKEwDjMkM3Krb2nw==
X-ME-Sender: <xms:QT0MZsD4cCeEkdsCCxYjM0fkJqUJHSIVE80RPtiakVkk7hOqpDpBDw>
    <xme:QT0MZuiFjGOt9nWTE4wX8E_jcbpZ49mYhiAwcNrte279gkaCv-1z3pBRSK4UrCCvZ
    Mx7IFt4QPdxmejNow>
X-ME-Received: <xmr:QT0MZvnLYzw5yebk_DiHaq7NgtOOsw80Hc63qNuFPt9q96aAeRwnvnTf3c34c7SLB7_a-f3gXxC95jfM0TPRZk3YiH0fSfTc0aYatcM7hjuTGxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QT0MZiz7LpwTdRF5IsGxAZxWB4qX-G1d7eBPIToBZOeg-ktwDUDkTw>
    <xmx:QT0MZhQ-fqZQ22k9ZSHDhi8o8vhxOYoTA31zhVOKXdmxlEhHupKiBQ>
    <xmx:QT0MZtYC3WKaaOvNbqZm8Hzkfn5j1H7Vm0-__DzCM1MYjLo2lRzXFQ>
    <xmx:QT0MZqQKjExcb8b987CIPP1tATm0fv_rHKQAnBB85Vs3JO8EatiDbQ>
    <xmx:QT0MZsd5gwBP-pmpfCV2mcr0ye3TtQCZzRwj5sfNSJOqcu87oCheedOb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:15:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba4011a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:15:35 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:15:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] reftable/block: refactor binary search over
 restart points
Message-ID: <Zgw9PlgGDcmwLnDB@tanuki>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <5e20d93ae000359f2231bf950a930cfc4898ced2.1711361340.git.ps@pks.im>
 <45v2z6uszlkanwl5qhvio4ikrrytztohbmdpnmdwiefyznclum@xhbvlvnfmkmq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NT6QsR4i6q0Fohvy"
Content-Disposition: inline
In-Reply-To: <45v2z6uszlkanwl5qhvio4ikrrytztohbmdpnmdwiefyznclum@xhbvlvnfmkmq>


--NT6QsR4i6q0Fohvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:42:29AM -0500, Justin Tobler wrote:
> On 24/03/25 11:10AM, Patrick Steinhardt wrote:
> > When seeking a record in our block reader we perform a binary search
> > over the block's restart points so that we don't have to do a linear
> > scan over the whole block. The logic to do so is quite intricate though,
> > which makes it hard to understand.
> >=20
> > Improve documentation and rename some of the functions and variables so
> > that the code becomes easier to understand overall. This refactoring
> > should not result in any change in behaviour.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> ... =20
> > -	i =3D binsearch(br->restart_count, &restart_key_less, &args);
> > +	/*
> > +	 * Perform a binary search over the block's restart points, which
> > +	 * avoids doing a linear scan over the whole block. Like this, we
> > +	 * identify the section of the block that should contain our key.
> > +	 *
> > +	 * Note that we explicitly search for the first restart point _greate=
r_
> > +	 * than the sought-after record, not _greater or equal_ to it. In case
> > +	 * the sought-after record is located directly at the restart point we
> > +	 * would otherwise start doing the linear search at the preceding
> > +	 * restart point. While that works alright, we would end up scanning
> > +	 * too many record.
> > +	 */
> > +	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
> > +
> > +	/*
> > +	 * Now there are multiple cases:
> > +	 *
> > +	 *   - `i =3D=3D 0`: The wanted record must be contained before the f=
irst
> > +	 *     restart point. We will thus start searching for the record in
> > +	 *     that section after accounting for the header offset.
>=20
> To clarify my understanding, does a restart_offset not exist at the
> beginning of a block? I was originally under the impression that the
> first reset point would be at the beginning of the block (or just after
> the header). If this was the case, the first restart point being greater
> would indicate that the wanted record is not contained within the block.

It wouldn't make much sense to include it as a restart point. A restart
point is a point where the prefix compression will be reset such that
the record at that point can be read without reading preceding records.
This is always implicitly true for the first record in a block as it is
never prefix-compressed. Consequently, writing a restart point for the
first record would be a waste of disk space.

Patrick

> -Justin
>=20
> > +	 *
> > +	 *   - `i =3D=3D restart_count`: The wanted record was not found at a=
ny of
> > +	 *     the restart points. As there is no restart point at the end of
> > +	 *     the section the record may thus be contained in the last block.
> > +	 *
> > +	 *   - `i > 0`: The wanted record must be contained in the section
> > +	 *     before the found restart point. We thus do a linear search
> > +	 *     starting from the preceding restart point.
> > +	 */
> >  	if (i > 0)
> >  		it->next_off =3D block_reader_restart_offset(br, i - 1);
> >  	else
> > @@ -399,21 +429,34 @@ int block_reader_seek(struct block_reader *br, st=
ruct block_iter *it,
> > =20
> >  	reftable_record_init(&rec, block_reader_type(br));
> > =20
> > -	/* We're looking for the last entry less/equal than the wanted key, so
> > -	   we have to go one entry too far and then back up.
> > -	*/
> > +	/*
> > +	 * We're looking for the last entry less than the wanted key so that
> > +	 * the next call to `block_reader_next()` would yield the wanted
> > +	 * record. We thus don't want to position our reader at the sought
> > +	 * after record, but one before. To do so, we have to go one entry too
> > +	 * far and then back up.
> > +	 */
> >  	while (1) {
> >  		block_iter_copy_from(&next, it);
> >  		err =3D block_iter_next(&next, &rec);
> >  		if (err < 0)
> >  			goto done;
> > -
> > -		reftable_record_key(&rec, &it->last_key);
> > -		if (err > 0 || strbuf_cmp(&it->last_key, want) >=3D 0) {
> > +		if (err > 0) {
> >  			err =3D 0;
> >  			goto done;
> >  		}
> > =20
> > +		/*
> > +		 * Check whether the current key is greater or equal to the
> > +		 * sought-after key. In case it is greater we know that the
> > +		 * record does not exist in the block and can thus abort early.
> > +		 * In case it is equal to the sought-after key we have found
> > +		 * the desired record.
> > +		 */
> > +		reftable_record_key(&rec, &it->last_key);
> > +		if (strbuf_cmp(&it->last_key, want) >=3D 0)
> > +			goto done;
> > +
> >  		block_iter_copy_from(it, &next);
> >  	}
> > =20
> > --=20
> > 2.44.GIT
> >=20
>=20
>=20

--NT6QsR4i6q0Fohvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMPT0ACgkQVbJhu7ck
PpSehw//R5G2IZkPg9ggKi4O61kB6Im8lKDNDQqs9vq1IhT84h0JRvCW0wu0p9KF
7d1NSPwXoLpN2vztx9C7/agkPjvlgB5WTltjhZXz1oIjMIS4c63Nr0zZQxL2OiYk
K6Vmctpv3BM22vxipag3aPALSgguhGXRjKb5rhPo7J0YLmkjFewtBOo4G3b+rml4
cnY4ELI/YJH+k26/EYkqOfT1cvIbW9jkQZ+yO+2/EgNsj1GFG0hZUUk0bnoaGoy/
GbjYE7FjmyEXpXfSN6etb0jLzs+zbr+x/WC7aiVQLjvWeSusjGRNPS7I8wRo5kyU
zCVEuxWtUq/xl7vS4lCctfZoz24tJL/37J8DsMXl9VL/W6KtyVQiIdnavORBD7rh
OJWn6CCaWd6jXYToJI58OxgbO6lUghxdyjDlUG7hvd6f/IoCZDgBIhJmoZWyjgZ/
gGdRd9T+6uR4sy9jqk0/J/TFRo6dOiSyhn+mI5f34bGFeIQtColVG1QJWCAoc/XT
iErXeXXyqB8zPmdJKifRSaOPgKwANgjab+kVygemj2D1UNboub0AFnOFUZWv2zZW
5QESc2cLGKU2Ik6xBaBfLX8jhYfitBQepiswyN2kn6scDXnX6Hd+cs4b9nLWKNTa
1KoZkeZ2YF46JYC8YaDWQwGUVfWA6Lpwne4APteWtjOSGRWMO7E=
=GIKJ
-----END PGP SIGNATURE-----

--NT6QsR4i6q0Fohvy--
