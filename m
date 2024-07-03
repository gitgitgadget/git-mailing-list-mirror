Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29743747F
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046436; cv=none; b=murtgqwf77OPI+7kOk2eFdBtWDBsW9b50pGw7SMktiV/t8ZeKK9UbSkGCW+a2M7lg0VVnkwXZOKgnI7thqW8NIxY+n19hWeX39wBzm8vcXXw5FH4ejM/LZTvOcv0iqRYUC4xSctHjl/JGINQ0Ja/vSsgOev+UIlO0aOLsjhtct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046436; c=relaxed/simple;
	bh=PuFpoKc3KZOYN/Hz5Rq7HFeRJ7d6r+/slLkA9YkLG1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkLSGReh47VA38bIo2SIy3r9Fc3iihl9/4sET9hbvV8PeWeQk1Bi1tj92Q6FZ1Z3TCMm4CsQyYoJtkChjCEGLQOD7CkEOW+mFCr9+M/GcitajNUSRR0laXjaYSzWqmGfQrvPH6LLjsQuUNmEcQ/3DBoiPTqQCGxJxzuDCcmdBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VPQhkg8V; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VPQhkg8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720046426;
	bh=PuFpoKc3KZOYN/Hz5Rq7HFeRJ7d6r+/slLkA9YkLG1o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VPQhkg8VVG5zsueW9w87n4YXaN4FmwPmobRhbnIqm1LOMYAg4oaZGgxr0mKgF+kBl
	 f5SknmMSzD1ynHpUmXVExYC74DuitzP/7Ak25oBgoXeIFzdiFDmUyDddgJjMpBLGkt
	 jH6mTo5Hk9qMdK/ffnLl7seOXvBl35Ptii3Z/ZtWGpgiF+2KIU2wbEZC8NNesGQr6l
	 kn6an81jjktf60XamJyCfZOu6oI4QvyEUywh4H4pMr4HlL26WFM70fqUzLGADqRDMb
	 vLnSD/r3pU1K0ghPoNOyqZ+q4sL6koEuvNrPj6V9w4RKsCh8zlu8eRKH9c0zoRT5p2
	 pXFABvNuIzYaJE3bnOD59tz8h8ZmekgG2GIx3tfTGPr9YSFItWHReDKT84dbZCRjcj
	 cVrJS4xvKmBQYIJbSfwpPdW1MxwWsmF545e0TFUqxuMgmveE6a3wYEGU4kdvdB0W7B
	 yrZXL+1xl8ZBnH9kogfmNCLSbt6+sVaeLQppEqwqWDoDWBdgxYE
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B56AF20992;
	Wed,  3 Jul 2024 22:40:26 +0000 (UTC)
Date: Wed, 3 Jul 2024 22:40:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ivan Pozdeev <vano@mail.mipt.ru>
Cc: git@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-objects: Fix EACCES pushing to remote on vmhgfs
Message-ID: <ZoXTWECfLzaA-tmU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ivan Pozdeev <vano@mail.mipt.ru>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Junio C Hamano <gitster@pobox.com>
References: <20240703134028.876-1-vano@mail.mipt.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AG6iM2oIgoKpf8iK"
Content-Disposition: inline
In-Reply-To: <20240703134028.876-1-vano@mail.mipt.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)


--AG6iM2oIgoKpf8iK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-03 at 13:40:28, Ivan Pozdeev wrote:
> Creating files with 0444 mode causes EACCES opening them for writing
> in some setups where the creating user does not automatically have
> write access.
> E.g. on a vmhgfs (VMWare shared folders) with Windows host, this causes
> the file on the host to be created with the read-only attribute set
> which prohibits writing for everyone.
>=20
> Change the mode to 0644, explicitly signaling we want write access.

But we don't.  We don't want people to write to these files, since
they're objects and modifying them corrupts the repository.  The 0444
mode is completely intentional here.

What you're reporting actually also occurs on some broken NFS
implementations as well.  POSIX requires that implementations accept
O_RDWR with 0444[0], and we require POSIX compliance from file systems.
The solution here is to fix this in the file system so it behaves as
POSIX requires[1], which I admit may be difficult.

In addition, I'll mention that what you're doing is likely to cause you
a bunch of pain.  A Unix system is going to store different data in the
index from a Windows system, so when you do `git status` on one system
after having done it on the other, Git is going to re-read the entire
working tree, including re-hashing it, to fix the data in the index.
That's one of the reasons we don't recommend sharing a working tree
between different OSes.

[0] From https://pubs.opengroup.org/onlinepubs/9699919799/functions/open.ht=
ml:

    =E2=80=9CThe argument following the oflag argument does not affect whet=
her the
    file is open for reading, writing, or for both.=E2=80=9D

[1] There are a lot of instances where Git fails when the file system is
    not POSIX compliant on Unix.  Notably, I believe chmod operations fail
    under WSL for Windows partitions, so doing a `git init` under WSL on a
    Windows mount tends to fail when it writes the config since the file
    system isn't POSIX compliant.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--AG6iM2oIgoKpf8iK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoXTVwAKCRB8DEliiIei
gdF6AP4nzCgWxM0NEX1vMoeoQSyNBbK9eylHeyu/I7EK/huW/wD/cD2Hwj1F7COL
oCb7c91GlESZtOOomNLhN7jbivVBBgo=
=J1sX
-----END PGP SIGNATURE-----

--AG6iM2oIgoKpf8iK--
