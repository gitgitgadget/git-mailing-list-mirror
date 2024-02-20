Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9906D60BBC
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423005; cv=none; b=YPJDQeYlJfwW4IxLKg01XuWrSTI4u5h8Atkds8kYU7DvjT+y8Mqgow80dhdGh4WFRLWY9Ag/fvY7e+2fUhgGTI3yXIQVf8/6Xp7qbgcnkSL2qGn6R2jBWqBWAyo5v77i5DyUGiYjO2X+0XD5MXsX7u2xJpOXnx5eaD52oNj9Bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423005; c=relaxed/simple;
	bh=mdtFoUIvgY9DlqbS8tr35LU1bT/tEU2XSSdNdnUHSJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4WR6lgaUQX7kXLrkStwYba23/uUe/1qenVOj01bbLveQ9x2uhLZ6g9SGoElsdxBH4Zocw7rzY4iiQvyt6zwZuJ6pm2JWoQ8V4BRWsSZ8KYLXeec8mY81e8dQctPYbgEai+LwaYXDfY+e3N+nVhubs6BYv3SmHdv3P50xBRblDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=np+U2ilW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7QZidzM; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="np+U2ilW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7QZidzM"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 2B1C01C0009F;
	Tue, 20 Feb 2024 04:56:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 20 Feb 2024 04:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708423000; x=1708509400; bh=JKR9HZfX26
	KmctKtTV8nXUl7tDVZowmHc3baOnfjH5o=; b=np+U2ilW+JZ+I0i+J4w8+CzIvo
	eGB9dOToTEKLajzy0HY+NtctJWSc2otpAQ9O13limx3PFHb+aOpxG+oDZ0kOZBfh
	MmygQIK/TOkOyDf+VQl+qNvGK18+za8gxNeD00hR18dDen7rAtCp2S71sXGfY9d0
	k/Wq0j8OpVOUERJPEKDYhmMiPgoaw8fuN1QzV1xh8E12+/EHyfDbKL7nA+9q6BBz
	hix0uAJgYZST7KdxhLT4HDXM9a4u2rafTPdl7d0UcNbhA8TW3cfIijmbXaahRLvp
	83Y9ftCiknipRshboY3DZGmu+fBju0kWRZVlda3gjlceL8voNHcpcRqTcVFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708423000; x=1708509400; bh=JKR9HZfX26KmctKtTV8nXUl7tDVZ
	owmHc3baOnfjH5o=; b=S7QZidzM81FZXcf0yaVanK5SiNegC73NaEHixTiAqR7j
	7agUBCXXbBZp3ZQfNVohW1yV6w5CpYL8WiFv/LmLIDEtP/euxJQL0xGEiB4O88Tp
	bNdvkHM3uwDalQJ+nQAtgIqJWIZ5ZQufPw29vdLBfwBpZKhRXU2ovFY7Z/FVURaY
	hYungRh7UNryRc3oaSfIKh3EkFRWQVQ9hBJkOCqK1W6JSkiA37fdfuUA2oXPNLQZ
	covF4zqThLwXGmXWRiPQYWhQrUvV3ULJBXTFNd19SGeRoO3IVegLmjHCiH+N+bWQ
	D/9l34/NxIZe3qW4vTIK87tR4BsQ+pFG7wKzQJNHuA==
X-ME-Sender: <xms:WHfUZfd9HMVkKg8Aj7OpeapKzv0CgLtlQTuZPlAs_wuS19Y3Axx7qA>
    <xme:WHfUZVOo9x_2oVagN6rHVQjur2aMCOzgr2-rd1IWs52N8Xdpl6iBVwoicZ3p-QcA7
    1BVQTLRGFFCP8NzKQ>
X-ME-Received: <xmr:WHfUZYiVkTu-9CqRA7Q41-MgCduF_tHDh5T9rmDegrRNXpYjswoRSIA9KnOXk_JsbJIqGKjX7Hu96HmnhBqXeq6AhBZ4AEybJU7d-GfKgy8cRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:WHfUZQ9HmDdv7PI98Mf1pY9mY6bG79YJb9uaAIaAQcmQ80UV1zfEvw>
    <xmx:WHfUZbt_xTurldIhugSj3vlBB4Mp-D0AA3tfBHUkMy28RABr0PU-Ag>
    <xmx:WHfUZfEAJE949OiYJV3fTDcziYiDLTw5fbDgun16dvjlO0K0wWkhmA>
    <xmx:WHfUZVKOHv4zUvTGAuGTs_ekfzRH-S6-bBCnU-BItrTD7HMSQgd5BZ2wM2s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:56:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e511761 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:52:34 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:56:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Jean-R=E9my?= Falleri <jr.falleri@gmail.com>,
	David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] git-difftool--helper: honor `--trust-exit-code` with
 `--dir-diff`
Message-ID: <ZdR3UlDf-Y_pokd0@tanuki>
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
 <c071e44c52171b9b19a04d91666be48d762d19bf.1708072576.git.ps@pks.im>
 <xmqqttm8i8hb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z/+W1eJIq2chPoS7"
Content-Disposition: inline
In-Reply-To: <xmqqttm8i8hb.fsf@gitster.g>


--z/+W1eJIq2chPoS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:12:32AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> > index e4e820e680..09d8542917 100755
> > --- a/git-difftool--helper.sh
> > +++ b/git-difftool--helper.sh
> > @@ -91,6 +91,20 @@ then
> >  	# ignore the error from the above --- run_merge_tool
> >  	# will diagnose unusable tool by itself
> >  	run_merge_tool "$merge_tool" false
> > +
> > +	status=3D$?
> > +	if test $status -ge 126
> > +	then
> > +		# Command not found (127), not executable (126) or
> > +		# exited via a signal (>=3D 128).
> > +		exit $status
> > +	fi
>=20
> So these errors spawning the tool backend are always reported,
> regardless of the trust-exit-code settings.  OK.
>=20
> > +	if test "$status" !=3D 0 &&
> > +		test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" =3D true
> > +	then
> > +		exit $status
> > +	fi
>=20
> I found this somehow harder to reason about than necessary.  Just
>=20
> 	if test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" =3D true
> 	then
> 		exit $status
> 	fi
>=20
> would have been a more straight-forward expression of what we want
> to happen here, i.e. "if we are told to report the tool's exit
> status, we do so, regardless of what the exit status is".
>=20
> Not that the construct in your patch is wrong---we will exit with 0
> at the end even when "trust-exit-code" thing is true and the tool
> returned success.

Fair point indeed. Looks like I was a bit too lazy here by simply
copying over the construct from the non-dir-diff case. Over there we
need to special case the 0 exit code because we don't want to exit the
loop in that case. But here it's completely unnecessary.

Will adapt, thanks!

Patrick

--z/+W1eJIq2chPoS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUd1EACgkQVbJhu7ck
PpQ8kQ/+MgPO3jWu17yb8jC2BoYNWIjp3b28U17jyQg3MvoKTdM7xL0RM4wRiaS3
361xEPEWfUSK20A/oA8VSccc8M9mN1jzWwtwgrMFZZeFQgl66R3VVVk9cEpTGGm3
mZG+Nrz0/bLyNZpor+r4QT86nDF9vlfohI6YIq1hD5UXS+XZ1DHpA/AKlQhfEsap
mEFAYFz5MYOr7154lM9LIE7OrTc7m+ByeHxI9qJrlPk7jlTu3Ab/Gx7us2qROqi0
t8x9g3/K3CiYDM2kwNCz93LxfaJI9INgBBZSSbn/W2kXkjBTVHoh1awykPjqz5lJ
a4BOswvrcTgR0WzrL06/TauOSxb9EdsvO5luDhLtUq/J3/VznC2sdlrVFHd8r9+J
Lpew5L6Ea3bZf5muZ/0aXsAnK5CJVhuDvP0LlZlBuPlbe2rUYA9pbOEHmNTearIw
ZrgO/llbK+eLZ3MrR0ioC2307pkFQ6Cp6XNsQBU+ZwBArsTpeieVvPd3r2fjRSIq
DSn/+Yfsl7ybEm2PDM3c9b9BCh5WOnRRwqvxbwiXdExB9sThn3rRAlgjlgN4bW8c
PIctxkT5Y93/id2jHwgAxnqgkCM+guFDzSercnSVhQIT6DVAfOaaYB0SA98vOiOH
zOadt2UgzNvEFlx5RhTgDIw/Qysv4Ei+qU+WgFa16AEHiFb/nBk=
=ZZVK
-----END PGP SIGNATURE-----

--z/+W1eJIq2chPoS7--
