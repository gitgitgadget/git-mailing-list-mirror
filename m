Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D227BF8F
	for <git@vger.kernel.org>; Sat,  3 May 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746287114; cv=none; b=F3I1basJQen+mvsBZzeNwh1exPdnNwX8nMy4NIz/DfqqoXY5XFsKONKCdEdfV67zPpVuAtamK7dPNQr+jO13WIocWa2Sh5rE7J/VyPqoyBRbb8Ge/cvRwN9YE0JgRcgjJSyRUvH03PiXfKz3/OudTLQNtAQUcXRVz8Won3FbDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746287114; c=relaxed/simple;
	bh=sPnTRSAzV8eBpXnM2ieuADgwOFPewZ2LovmBJlLSBqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp7sl4VxnuBU6fibhczYnmKEMTgRcQItrpIiHy5OWqUtOT7pi0GNHiM33Lvkc4urDule70Oj7/RtnKoXm+bETd1L4MFsb7iJSUxpTRgND1XNtbyJI6Jl/2kD0s3q3zfXA/nxo3Z+6oGxAszkA4usI7D07DAgqV1LkhQdvjmal5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yvULwJpS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yvULwJpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746287110;
	bh=sPnTRSAzV8eBpXnM2ieuADgwOFPewZ2LovmBJlLSBqU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yvULwJpSB2DBzMJp6TIKZpuh5QW7MzQJdpMv+jvWy1PwWG8EmykUvzEhu1cuJrP3X
	 1O/mWyw3KqnOT82+QAblZuPVMgtT6T7ZVVbAV4sZlZU3h9nBF4zfAlpGwjiBarMILR
	 rRhRPYIkq4NtXrrX+kfD0CoEloNP6OFRHIQB2J+XKWQ8D9Rv0ofPZxb4cQoey9nqmQ
	 L43IWxO9OnWqYHYiLUAZQ/TMU8jsjqMHY0EmpCVYzzpZqa8zBknHJI1eLbrrWARF8B
	 6bFw9bs+UJXudMymw+dAR+5yE5CEQ3q9llevBQkMPetLuSqmtAeuRmLuLnrna1LJi8
	 smU3HrdhzbafnfUs8Q5EPuXxo7n5iumYjFd7sUqblt/7r9S0keoaNSimoS7+1YyP3b
	 aUU3S0VTwuz4l6eCu7NMdRHHfRxDf/3CWxiyt9wNAaPNp82hW15RAkhVvl074GXEvr
	 DotQF76wzPZe4b3MT3WyaTm4XaRfjaxen5yEnx1eyxp7j0d7mym
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 089F220114;
	Sat,  3 May 2025 15:45:10 +0000 (UTC)
Date: Sat, 3 May 2025 15:45:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] wrapper: NetBSD gives EFTYPE and FreeBSD gives EMFILE
 where POSIX uses ELOOP
Message-ID: <aBY6BPnuSfslYlYt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <20250503041718.42195-1-collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7BEJ143A87clfw8b"
Content-Disposition: inline
In-Reply-To: <20250503041718.42195-1-collin.funk1@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--7BEJ143A87clfw8b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-03 at 04:16:51, Collin Funk wrote:
> As documented on NetBSD's man page, open with the O_NOFOLLOW flag and a
> symlink returns -1 and sets errno to EFTYPE which differs from POSIX.
>=20
> This patch fixes the following test failure:
>=20
>     $ sh t0602-reffiles-fsck.sh --verbose
>     --- expect	2025-05-02 23:05:23.920890147 +0000
>     +++ err	2025-05-02 23:05:23.916794959 +0000
>     @@ -1 +1 @@
>     -error: packed-refs: badRefFiletype: not a regular file but a symlink
>     +error: unable to open '.git/packed-refs': Inappropriate file type or=
 format
>     not ok 12 - the filetype of packed-refs should be checked
>=20
> FreeBSD has the same issue for EMLINK instead of EFTYPE.
>=20
> This portability issue was introduced in cfea2f2da8 (packed-backend:
> check whether the "packed-refs" is regular file, 2025-02-28)

Yup, this looks good.  Thanks again for the patch.

I'll just add one resource for people who might like to look into these
kinds of things more.  https://man.freebsd.org/cgi/man.cgi is the
FreeBSD man page viewer, which lets you view manual pages from the BSDs,
Linux, and some proprietary Unix systems.  It can be quite helpful for
finding and fixing portability issues like this or just seeing what
command-line options or arguments a certain Unix supports.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--7BEJ143A87clfw8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgWOgQJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5XvT2TsaaTucytSDvd/jCjtJd7p2ZG2Gy2Um8QiifWs
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAFKLAQCWReabdz/mnK8RTGvu0RXIF2lB
Q4wA7u/fRGcTNm5xEAEA8qVFqqV07tFRGzMIZjEAn9HcSkAFk13pjF/gaBP5dg8=
=K5XL
-----END PGP SIGNATURE-----

--7BEJ143A87clfw8b--
