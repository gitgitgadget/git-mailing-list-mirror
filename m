Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA7749C
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743817128; cv=none; b=UtJZqCigkp6HCyU5IIMoSmVU8AwJS5edeZFTdF8PLG54K/fpu0UI8k3KL59bMMvTuiXMBEbTK/hQcqSf/c5OUzx4wDhRKHhMIN6qFfudLNhe2vNUiG/yENmSV2HDzj9F94up5Dw3n14ZY9NDvKHpJVo7efT3nQZwXXy6xZqLgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743817128; c=relaxed/simple;
	bh=ujhCxxaRiRKy3onGq1a2Bx2BBvouzlmXdCUlvM4mGoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2WNRxH62GvIL9ugwUN812KwxDU2Sdbps5aPdYMmkWUeb4HCScKrE15NjmncycQsz1oQxPTm6tYs8H7GgzpUVcGCKWzdqMXd9wpd4jGbGtvYjvFoiTTLIUHhmcAICYIvELi2L7q4W5UbZkfHJj+dg4LYD8VQsMtOfGlyBXuBAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Joo/C7Zh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Joo/C7Zh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743817118;
	bh=ujhCxxaRiRKy3onGq1a2Bx2BBvouzlmXdCUlvM4mGoc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Joo/C7Zhu65fMS6FLB1m3h2Lw5kFatokF6WMub9sSgYTeH90RhEMZ1kF2dZGPbwK7
	 PsCB5+c461ZaBwSRsC88QECKaPkTxuq8AzuprHZ3dY/pFUfU5FKFV0zbxnPcpKSjOp
	 NztC7JexsUySNdteewZw7D5wo2CEUPSvyc0EOPmyZcQnlUL2v+T3urRSRThujwPsPJ
	 ZUxx2exjxcChq9Pf7hTpEIEIretEvoJGCUarhx4y7WD2ZZaj8AWn8pTPqzEkq4bDCw
	 S1gDeCB0uAkQGD85zDwlCbKNxr9nyDU/XiXFjNcDqjQ/XKpoJBswtqlqeMjK7SfN+8
	 /VayL3fsuSj/ZLfcViBw2bsI6iTN32O6iVw6TuErW9wfhLBwy81lQIJZW4KMiH+IyH
	 EzPu+dFuRHDOLROjRHcET2OQzBUSBnKCnIcAt+03DBasmnpKhnukxk0+HQMIL+dd2q
	 77NmKu20UzWlWKlE3CcXSZhcRAdCiodP+HUHvushH2Skc8CZx4U
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 12D0F20104;
	Sat,  5 Apr 2025 01:38:38 +0000 (UTC)
Date: Sat, 5 Apr 2025 01:38:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] refs/packed: fix BUG when seeking refs with UTF-8
 characters
Message-ID: <Z_CJnBWReJeZKC9x@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
References: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>
 <20250404205740.GA780449@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/LVG5yaSOkUCtyw+"
Content-Disposition: inline
In-Reply-To: <20250404205740.GA780449@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/LVG5yaSOkUCtyw+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-04 at 20:57:40, Jeff King wrote:
> On Fri, Apr 04, 2025 at 12:58:38PM +0200, Patrick Steinhardt wrote:
>=20
> > But in practice the check itself is misbehaving when handling unicode
> > characters. The particular issue triggered with a branch that got the
> > "shaved ice" unicode character in its name, which is composed of the
> > bytes "0xEE 0x90 0xBF". The bug triggers when we compare the refname
> > "refs/heads/<shaved-ice>" to something like "refs/heads/z", and it
> > specifically hits when comparing the first byte, "0xEE".
> >=20
> > The root cause is that the most-significant bit of 0xEE is set. The
> > `refname` and `prefix` pointers that we use to compare bytes with one
> > another are both pointers to signed characters. As such, when we
> > dereference the 0xEE byte the result is a _negative_ value, and this
> > value will of course compare smaller than "z".
> >=20
> > We can see that this issue is avoided in `cmp_packed_refname()`, where
> > we explicitly cast each byte to its unsigned form. Fix the bug by doing
> > the same in `packed_ref_iterator_advance()`.
>=20
> Ah, good catch. I think this signed-ness issue has come up before, long
> ago, but I don't remember the context. In theory any stable ordering is
> OK for sorting, but of course cmp_packed_refname() chose to use unsigned
> in order to match strcmp(), and the standard defines it as interpreting
> the bytes as unsigned. One of the enjoyable quirks of C.

I'd agree it's a quirk, but I'm not sure I'd call it enjoyable.  Anyway,
this does seem like the right solution and I agree matching strcmp is
the right decision here.  I also think unsigned byte comparisons are
more intuitive, honestly.

> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index b4289a7d9ce..7e31904bd41 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -980,9 +980,9 @@ static int packed_ref_iterator_advance(struct ref_i=
terator *ref_iterator)
> >  			continue;
> > =20
> >  		while (prefix && *prefix) {
> > -			if (*refname < *prefix)
> > +			if ((unsigned char)*refname < (unsigned char)*prefix)
> >  				BUG("packed-refs backend yielded reference preceding its prefix");
> > -			else if (*refname > *prefix)
> > +			else if ((unsigned char)*refname > (unsigned char)*prefix)
> >  				return ITER_DONE;
> >  			prefix++;
> >  			refname++;
>=20
> The patch itself looks good to me.

Same here.

> > +test_expect_success 'list packed refs with unicode characters' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit --no-tag A &&
> > +		git update-ref refs/heads/=EE=90=BF HEAD &&
> > +		git update-ref refs/heads/z HEAD &&
>=20
> It's possible some filesystems might be unhappy with this character, but
> I guess we can see if anybody screams.

I very much doubt that's going to be a problem.  Windows uses UTF-16
internally, so it will have no problems with Unicode; macOS only allows
UTF-8 in its file systems and I know it gracefully supports emoji; and
other Unix systems don't care one way or the other because it's just
some bytes.  Even ISO9660 with Rock Ridge or Joliet extensions will work
here, as will FAT, UDF (used on DVDs and some hard disks), and 9P.

Certainly somebody could try something very esoteric, but I expect other
things will break as well.  I'm okay with favouring testing things we
know many people _are_ using (emojis and Unicode) over things very few
people are using (very esoteric file systems[0]).

I could imagine a hypothetical encoding issue in the Cygwin or MSYS
layer being a problem, but if it passes the testsuite in CI, I'm almost
certain it will be fine.

[0] I think I'm familiar with a decent number of file systems and I
cannot think of any available on a modern OS that would have this
problem.  I'm sure some must exist, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/LVG5yaSOkUCtyw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ/CJnAAKCRB8DEliiIei
gdFGAQDgsdg/u61oHWFsKeRvJ9YCtplugkmXeTKSpkw94ewLuwD+LmUXo7i0hxck
6zNX0DmcFwtI6JKBra+P2tRL+wNX3wk=
=/FNG
-----END PGP SIGNATURE-----

--/LVG5yaSOkUCtyw+--
