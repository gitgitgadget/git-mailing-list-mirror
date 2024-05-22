Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002DC823B0
	for <git@vger.kernel.org>; Wed, 22 May 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376041; cv=none; b=s+HvHYS3E1IZ5uIjniwIhL3zWAclG1j2e8HA7BWfZyE/X6oPw2o4a5baCtP/LFskNC2nk6veByiXodSzTdH02lp4tf74mewCjbgDacqfIqfNOQci1eiolE/TnDKv5jWMfn9Wt/68eLVcWTzgoPTFGlUP6jp8lJ+vYtZ2yqN57XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376041; c=relaxed/simple;
	bh=zfP5rzdQa8dNF1wgpjTtjrnU70wAPL5HFz0ypo11zTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCUfEcDSsSwjBsFhGD7sakKCAo+kMIf7Ow4qYZmW2Y/lVB2FOVe+JiUzEtqmkbrM7N50RGLir94VwZp6rc5y7zXkoR8cB+Qrzac2YtaN1SI6YcCG3u7GpDh80y0raRjupXwrYLzpXPg6R9P3y6AjOQ9eAlJmYSyAVef/dng4vZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DiMG0nDF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=plfKKZbJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DiMG0nDF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plfKKZbJ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D96CC1380128;
	Wed, 22 May 2024 07:07:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 May 2024 07:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716376037; x=1716462437; bh=E4+d/+A7bN
	wIwT4m7HBlIk7r4j5DyzRevBjNQG+7u/w=; b=DiMG0nDFyb0k5T+gVwcWaGuiiu
	LZEuZ8LDiucu3z1k2gXc7cYe55eCKYw7nKqoagL0bK18tF+abiOGNZZ89qdWBUfE
	usCp/bDvZAihyb8g7WldKwZh5p4T5750XUaTI7zNWW8NmAhPBS2hPda10Edzl8+n
	9xbBPg10dtx2033ilEAz8/vOKzAgX0oqmK2gO76PBxVld+pFFmy2rG//CNEHh0v2
	DUeKV1BFSjhMrFbbt2UpGuFFQ9EOyeKVgCHovi/wNI/mBhcHEKLdBtSGzCCQOcxf
	Frra+aaPuMocZlDrxy8KD/bv9UdNZyqblH7IpZtAA1m1MOaAuzTkrWQfce0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716376037; x=1716462437; bh=E4+d/+A7bNwIwT4m7HBlIk7r4j5D
	yzRevBjNQG+7u/w=; b=plfKKZbJ5q+sEg1bi4LDuq75XyfuLR6xmjxm/FqOTtY2
	wdLoj4H2XTVtqRGXF96lE5ZQ2Cnx5boPEPz0Rj3ySzjFVUv5qhXbcK2+AxK946FD
	tJ+TseNGjZLHBA3CJXAggcjR404befl7idM4EU/XkUkYIp/DerUqidh8Ysy6kSSh
	pqjwA1BXwuIYmIiw1DLIhuwVE8JjGE9IlzNeneoOVT9rlJ7T1+QMTBQAlySHJUyA
	7fF9F/ge8QGcnHsA8QhAog0MBPGq7Vm26Zy/kT4EwX9GM5hw4EDGF3rpK8nHLW3W
	wF809096QoUQYadXHbopRsndMJU3Rn7i+X+hoFNzNw==
X-ME-Sender: <xms:5dFNZtC1mEI4OmjuCKEmevMpvMM3rDsEkAgWOtI-UpKh9gcGDtY9PA>
    <xme:5dFNZrhlFNIpHKt8A8g1-L31JKAW_SuOauMtmKOxhzbFO9JMOIU9_1WDeXiRYTuS4
    HFC0ffUq8LRaLKabg>
X-ME-Received: <xmr:5dFNZon3EhN33Mg9bXOfgF6LMHi7YVbDQ2eB_E17bfrf9k9QVUUpKyBy_pAeFMdgosfxvpWhZvRNUhr3cswKf5NRgZ_kTxew8LFLGGLeja_3eqvf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5dFNZnznp267UTu6rxQdqPY539vzL5EXSqNhFC8qyjeohH-n7Yt8qw>
    <xmx:5dFNZiS8CiJvL9GBbz3lm2ov8v-DORUVMD0RO4KoyIFvHyAUuuIoAQ>
    <xmx:5dFNZqYPsU1CiCNyq6QmoffcYBTLzX3mV8OatLw-nG7NPWilwDv1ug>
    <xmx:5dFNZjRfGPx68aP1a6cJgefNAyPNwjaaja0xLpSlO11Vg4qLxEnBwQ>
    <xmx:5dFNZgeEMT9pxLvkBYfKqFH4tp2IstD6omFboupSsMmmT8Xq-EGdCzrK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 07:07:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cc2b9348 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 11:07:10 +0000 (UTC)
Date: Wed, 22 May 2024 13:07:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
Message-ID: <Zk3R4MuCWOYVz3_B@tanuki>
References: <xmqqr0dvb1sh.fsf_-_@gitster.g>
 <xmqqh6eqiwgf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0n4mX9a8OTALlQ18"
Content-Disposition: inline
In-Reply-To: <xmqqh6eqiwgf.fsf@gitster.g>


--0n4mX9a8OTALlQ18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 04:20:16PM -0700, Junio C Hamano wrote:
> In an "git add -p" session, especially when we are not using the
> single-char mode, we may see 'qa' as a response to a prompt
>=20
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
>=20
> and then just do the 'q' thing (i.e. quit the session), ignoring
> everything other than the first byte.
>=20
> If 'q' and 'a' are next to each other on the user's keyboard, there
> is a plausible chance that we see 'qa' when the user who wanted to
> say 'a' fat-fingered and we ended up doing the 'q' thing instead.

I think it's a good idea regardless of the layout. There are tons of
layouts out there that are very esoteric (I for one use NEO2, which most
nobody has ever heard of), and I'm sure you will find at least one
layout where characters are positioned such that you can fat finger
things.

Another argument that is independent of fat fingering is that it
potentially allows us to expand this feature with multi-byte verbs going
forward.

[snip]
> Keep the "use only the first byte, downcased" behaviour when we ask
> yes/no question, though.  Neither on Qwerty or on Dvorak, 'y' and
> 'n' are not close to each other.

Just to prove my point: Workman layout has them right next to each other
:) What we make of that information is a different question though.

> diff --git a/add-patch.c b/add-patch.c
> index 79eda168eb..a6c3367d59 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1228,6 +1228,7 @@ static int prompt_yesno(struct add_p_state *s, cons=
t char *prompt)
>  		fflush(stdout);
>  		if (read_single_character(s) =3D=3D EOF)
>  			return -1;
> +		/* do not limit to 1-byte input to allow 'no' etc. */
>  		switch (tolower(s->answer.buf[0])) {
>  		case 'n': return 0;
>  		case 'y': return 1;
> @@ -1506,6 +1507,12 @@ static int patch_update_file(struct add_p_state *s,
>  		if (!s->answer.len)
>  			continue;
>  		ch =3D tolower(s->answer.buf[0]);
> +
> +		/* 'g' takes a hunk number, '/' takes a regexp */
> +		if (1 < s->answer.len && (ch !=3D 'g' && ch !=3D '/')) {

I find this condition a bit unusual and thus hard to read. If it instead
said `s->answer.len !=3D 1` then it would be way easier to comprehend.

Also, none of the branches othar than for 'g' and '/' use `s->answer`,
so this should be safe. I also very much agree with the general idea of
this patch.

> +			error(_("only one letter is expected, got '%s'"), s->answer.buf);
> +			continue;
> +		}
>  		if (ch =3D=3D 'y') {
>  			hunk->use =3D USE_HUNK;
>  soft_increment:

I assume we also want a test for this new behaviour, right?

Patrick

--0n4mX9a8OTALlQ18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZN0d8ACgkQVbJhu7ck
PpRIJA//S+B7OumwDrMh0V/4CFUUnHP9DUwZEU7oJrWxaq44q6uFz9yf8aPPBclV
+Y9f07jv92kilRYE9fNOGMbBBQ4j8ox5qQGdMl3Kk6hbyyaxpE+BuSReXkkDSqK0
n5vAD08X21ewDIvpYc3XkOBJ4AUvtgoejsIbkFX5G9BZKkci9Upcb368nxG43gb1
ikog5e0eTjo+LU8OGtFfhMTSqsEjjfe6vFY7B0DyB4gio2LT6ZZZRwXcn9zgCXAB
MRJtFUxR7+dmqKqjDbd2UDkjjpf0LdHPSdXNp4rJpZ0KkSCusEh48WejuRYAW+gP
I4gAedkZv9QxD4rcsPvcgxIJJrKvBqv0GvsnXat3GWjV7hJ5/gnBlWgaOcP3zgb2
xKbg5oLCsI2nlbJc41FRPC9v6eTyPb8Tna0LUm3JJAgVj6VOoSHLOe+oTbwimnVo
gOgfEKMk4JdWcFJaWTrAyTsbCnnUhgumGkKNsDqq9XqPj777C3p7Ous6PXM7ZvNI
2RF+mPc7j0sLy45dbrtQmvN9O3LENQ4Cl9VA+ifESzV+IExC1MJlQssHS07x+gdX
z/kfYbM5+V2tz3c9txtjd76eR4/O0eIZwbU3SjpuzbP9ISoVy0XMXwSDr/VvnDD1
nbk5t5SyHOhiFZHffRQIS2hy0rTadzPeUefRgaAHrQBwkqJB024=
=qFUY
-----END PGP SIGNATURE-----

--0n4mX9a8OTALlQ18--
