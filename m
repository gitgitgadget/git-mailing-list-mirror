Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD461C286
	for <git@vger.kernel.org>; Thu, 30 May 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068671; cv=none; b=QNjQgM3FfpxKntECCG03Zp+ipd2qDSMMa3ZJf4oBfoB+ZAnY1/mk7YIr902Qh7C5KAbmoAEcIWJydExkH7DHXxX4G9HoVClZb+s30D33aY613K8VrQip9GfYbC5PVZvf2K2Do9I4lIYXtx7kTpwbURYhSmRahhNJ8psWMeKBKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068671; c=relaxed/simple;
	bh=6LzfTZWREcLRxli35Dvcl9RV9rOFlbCpExoru5OBDvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKQy8cGPPl/KU9exX8IleL0uuZ6idVhVGl5C2x3Y3VzdrQyW1Yzsn00fLBG7MO+YoNo8ZCQe9MMN5JJNYCOnFUC+ZmXGEp8l5gHKTfHAKsjBNN8WlJrnudB4JeFDggFBSm+MSmMKKn8+LAJw2lkMSbTMsc9Jt5U8ex22+8IEOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RuWuH69v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqX9i9Ad; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RuWuH69v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqX9i9Ad"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 670F913801C4;
	Thu, 30 May 2024 07:31:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 30 May 2024 07:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717068664; x=1717155064; bh=0zucVS5Yqe
	fJiC9RRfrdxnqwFk+b8RRqABKGwFUnIAw=; b=RuWuH69v04HIwKBiFuWvZGUwPW
	8DefoeMNAX3o7yvBdNm1l/i89kTkNj8Fh7XQMrWI0jI/367XAViKAsoHJ/znOeWH
	rITaqbjbah2YNKIdAPMKYc2CsbhLxqZJuKfUWw6DqRWFnlEUZZ0B2uIWWQpvTZVO
	wxh3WFHnx6VZc32yNvs43Nk/o6ZWe+TmKcGdiUzoWYEDgvNBezcM9c4/sEd10wtZ
	Ltp3XrggNi3xgsBYuY/6B4XrCLytHxvNWyeD5+mu1q4Q0bzQeQd1NMGEWPErZScl
	10wC992PXFrebCHvuNGw4YDoYj0LBh3sRgaqYR3zdF0gH/2Uu9rv+3LAafTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717068664; x=1717155064; bh=0zucVS5YqefJiC9RRfrdxnqwFk+b
	8RRqABKGwFUnIAw=; b=OqX9i9Ad7OE1ymUNOYHIbS+ljwfuCCc+zqQhzmsyOat/
	JKzsnuvCW+9pQ5fQv/LFePc92kpf5AeXLGKncEFu1GzeBvmasPaHVUFyQtK+H7mG
	cGvXIMqzHMQQlTzRaLI6jYS5zjdt//r4Ks4jXmHbykTqKyffTiBQJjQQ6B2rBYOz
	s8H0Uj4ch23e/RM/O2FDNcPs6PY9qtHCbo/PYquAf1hMPye7qnhTYooFe0XnV/9r
	Q7V56A8SumqIpOQTNd/A7/ZqNUBcwjm63k2DuLIDotyjsWeIFznmvoU7pMQFCqv0
	T6YLG4ciOewZ5ZULHLNhWQAMT0/t4IJfdK/W0dQjAA==
X-ME-Sender: <xms:eGNYZsrZRVt-91EGSQuZJFoot_rKbpQZZWuHyfs5MF8UuKxF2KP8eg>
    <xme:eGNYZipTl9js-DzglwZQ4bE1s02eQayMh_FlkcBXbaYjgnCvj3wqg6y6NftPduB9L
    htDNoQx_T9GSozCqg>
X-ME-Received: <xmr:eGNYZhN9PjtmHRc-ZAQQoXwsvu3SBE_xnRBrsK_L_yR9HOdszmWoBUAd5G5CFTvQ9DyiYowd-DLNiX7RDeMpS9_C_66uq8ngtt3Z_CWxIRv-h9i1kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:eGNYZj6_YWqFiIEjNBHT63eYcBtquBRcaL1D48omVF4427sbL-w5Uw>
    <xmx:eGNYZr7l22q1cqcAScisjQb0ygCwm7s775GQnGAkwzkbjQE_wogIPQ>
    <xmx:eGNYZjgiGCC7OW0wPg_XFc58A-DJPBHt0dJjsnpdU_pBqbVCQ_sF1w>
    <xmx:eGNYZl5zQuevmde3t5vdO5P1IqbjdxN_zLboYMkvT1pMKYV5N8kUqw>
    <xmx:eGNYZtmWHcDJURZDC58LCjYFT8-fP9uZMtyidWtcM-O_EyJnTYLkVngV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 07:31:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e63024b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 11:30:46 +0000 (UTC)
Date: Thu, 30 May 2024 13:31:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/19] imap-send: fix leaking memory in `imap_server_conf`
Message-ID: <ZlhjdPkEEwg7Wog7@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <357d69fa8b538baba23cd110b8d16174234a58dc.1716983704.git.ps@pks.im>
 <xmqqle3suymm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uf1/4FQRAnRetIrw"
Content-Disposition: inline
In-Reply-To: <xmqqle3suymm.fsf@gitster.g>


--uf1/4FQRAnRetIrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 01:55:13PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We never free any of the config strings that we populate into the
> > `struct imap_server_conf`. Fix this by creating a common exit path where
> > we can free resources.
>=20
> This is more like the previous step got rid of the anchor that made
> these strings reachable, so we need to turn around to free them,
> which is sort-of Meh, especially given that the leaked pieces of
> memory are small and very much bounded.
>=20
> The main benefit of this change is to allow us prepare on the
> constness change in the other (read: API this thing uses from
> elsewhere) parts of the system, which is a very worthy goal.

That's the motivation in this series at least. But I also see it as a
good goal by itself to get rid of the global state that we had before
the preceding patch. It may not be necessary, but it certainly helps me
personally to reason about code better.

> > While at it, drop the unused variables `imap_server_conf::name` and
> > `nongit_ok`.
>=20
> The removal of the .name member may be correct, but I suspect the
> change to nongit_ok is a change in behaviour, and it could even be a
> regression.
>=20
> > -	setup_git_directory_gently(&nongit_ok);
> > +	setup_git_directory_gently(NULL);
>=20
> The general idea behind &nongit_ok is that
>=20
>  - Usually setup_git_directory_gently() dies if NULL is passed
>    instead of a pointer to &nongit_ok.  Most of the Git command
>    wants to make sure they have a repository to operate on, so this
>    is a reasonable default behaviour.
>=20
>  - Some commands would want to work also without having any
>    repository, possibly with limited capability (e.g., "git apply"
>    may want to work as a better "GNU patch", but obviously it cannot
>    do "git apply --binary --3way" without having the object
>    database).  They tell setup_git_directory_gently() not to die
>    when outside a repository by passing a pointer to &nongit_ok, and
>    instead tell if we are in a repository by storing 0/1 in it.
>=20
> The idea is that a command that is willing to work outside a
> repository can disable selected features based on what it sees in
> nongit_ok.  In the case of "imap-send", there is no such features
> that it needs to special case, perhaps because everything it does is
> supposed to work outside a repository?
>=20
> So the short version of what worries me in this change is that we
> used to be able to operate without having a repository at all, but
> now we would barf if run outside a repository, no?

Oh, I wasn't aware that the parameter being `NULL` actually causes a
change in behaviour. Which nicely demonstrates that we have some missing
test coverage for git-imap-send(1).

In fact, it's not only "some". We don't have any test coverage at all
for git-imap-send(1) as far as I can see. Which does make me rest a bit
uneasy. And I suspect that it wouldn't be trivial to add given that it
kind of requires something that talks IMAP on the receiving end.

Patrick

--uf1/4FQRAnRetIrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYY3MACgkQVbJhu7ck
PpQavw/+O0ED370shaEPZmkrmV6RQaUsADkq93mgGVIr+lkLx2SnT1q8SIpKkouV
3kG91DxZSoWprZrTJT/czYbbCoPBHcQnmUcngq7QTdp2o69QJYlK5C7OYF9v7qI1
OCuZFIzcdMVVyYHGsfoc3HI6SckzXRIWSMBSBbEmTnmz5xiblwFwQUEUK/X3frjP
t1w6WHbujdGls31kBKfIj42KPG1KVMO9KMSouXIwT3eqjotW0movNQKf2yaLT/kh
a8sAgW+O3ucV0lYXKmffdmITj9+kCRNjG4lYHHXzz7WIvTC16aGl1ts+gWvXp6rQ
KPtJDu5/i/zEDIPgBJ92VDx0dR5P8k0t53D3YBM/qg1TrtX8yXO0taFSscJFCgrn
5nvagGN0S4t1Q61T5UurhzeyvaJeNVGCs0MMlz5nr5EsL77/c8SXgxJEsNNdTh8O
TtUy064fJwV4S0YloySafP5cZXa8cgVCAgAyB9rXtPe2MHAvyyBUEzqp9kzQQ/WF
fhlM1rMN4zoeaX2gI2XypBC+FhAtBZQziHJD+27HWClaLxCysyKiVqyAPF5B1HjI
0hdn7pxAHSWaL7pFlOYQUwYqMHqmeHE29Jy+Pq1jTTZ2ze0AA98qb9j2kxEmzPa3
XwBY4365/xrHXPYNThu1r9JzC4Me9QmrLfZvMJLbDia644AI76g=
=BLjP
-----END PGP SIGNATURE-----

--uf1/4FQRAnRetIrw--
