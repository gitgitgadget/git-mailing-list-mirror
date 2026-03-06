Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC929480342
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830460; cv=none; b=u36rwTHYiKioUl4JBgOYly0oeg4qc+3dgduZk2ucV1HRLEXqJFQlcEBzGe+nCxeVCNfpXyu5ER66hA9UqvJjLg7lT5updE2x0ANsxmvIA5bmf7/QSGGFerdjvWYNv1Dgkgj2LGnLoKxuolojovY9gmVWfXMWJu1thYlbE9dsqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830460; c=relaxed/simple;
	bh=JDSaQeg+SPBusjknYgXMlNZkySi/X4asSpbcZ5PYrdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFLpBMfzYLTc5f5OVnDvNszyEgqUpSRLtQiMDOAPnj6aVkPDpXB5809QUlM7xvdOjSxkWfRyyp8FMjIn2M8O2UJsBQP2FOhfaESpdI/w9CnkFH0ytaUQoQQBHDgKdDJ+xrIDv2nd3mWbvnaOSeE/nOSVNIqVMvh5x8G8HGWX3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=j57rlB1r; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="j57rlB1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772830458;
	bh=JDSaQeg+SPBusjknYgXMlNZkySi/X4asSpbcZ5PYrdU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=j57rlB1rovg/034LukQ6QD82XlBAnQWaksSBZHVpPlZVPZCNIOLNVP06rqJv43TFw
	 7HMPkjyCZBQ7Aqmdutokhl93opVEmvbuD+L3pjpeZ/SOnq5Sk0RS7t2Ovc6oyS6QDi
	 OVWR2FnDqXhgxzHq3hBB8NsaLCc9OUtsmu9nnZ7KsgRJZ01S/fxK6ZGyP6D2HEnzCo
	 +LbB40OiNUZNVyCcD+6APf7hBdDJbZVy2VX5EbIrsYvpMhE/lH/k6wbPPVQcPe6AZ8
	 531q85ouG0XLDqtdM56TC31H1Ch5rvSCzAY6Pt4zRV/Ytx+ZBVaUgTZf7bx76iaNCU
	 D3v09+XjvM3sQ0KLK2pSsB+d/OSpXQ1V1fINZmYS15h8tI7zyGC/dUYQ42QUWDDGMC
	 NkWr5KfGcbG623Ir652sMyiAgiCaq9njddy3DWo2amqjPc5pIJ611v6U3BMQSRmSyL
	 divP4xB511UvmpeEd6WuEaR+MaIEdfE8r8FYRjjaR3jwSpp3hfD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:941e:963:e525:3a6c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 22F0E20112;
	Fri,  6 Mar 2026 20:54:18 +0000 (UTC)
Date: Fri, 6 Mar 2026 20:54:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org
Subject: Re: git-fetch takes forever on a slow network link. Can parallel
 mode help?
Message-ID: <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"R. Diez" <rdiez-2006@rd10.de>, git@vger.kernel.org
References: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foCTAbiDah/96tt7"
Content-Disposition: inline
In-Reply-To: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--foCTAbiDah/96tt7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-06 at 20:13:58, R. Diez wrote:
> Hi all:

Hey,

> I have an SMB/CIFS connection to a file server over a slow link of about =
1 Mbps download, and a faster upload of about 10 Mbps.
>=20
> My smallish Git repository has its single origin on that file server. Unf=
ortunately, I cannot set up any sort of Git server on the remote host.
>=20
> git fetch takes a long time. If the repository is up to date, it takes ab=
out 25 seconds to realise that there is nothing to do.
>=20
> If there are changes to download, it can take half an hour, even if the n=
ew commit history is rather small.
>=20
> The network link is slow, but not that slow. I wonder what may be causing=
 the long delays.
>=20
> The first question is: how come it takes so long to determine that nothin=
g has changed? Does git-fetch need to download a biggish file every time?

1 Mbps is considered extremely slow for a modern disk.  A floppy disk
was 250 kbps[0], so your speed is about four times that of a floppy
disk.  Hard disks in 1998 were about 10 MB/s[1], so about 80 times that
speed.  That's definitely a big part of the problem.

Since this is presumably a bare repository, Git will first read the
remote references to determine what's available, so if you're using the
default files backend, it will read each of the refs, which may involve
many small network requests.  This performance could be improved with
`git pack-refs` or by converting to the reftable backend, which will
open fewer files.  reftable also uses some simple compression for ref
names, which will help as well, but it requires a relatively recent Git.
`git refs migrate` can be used to convert to reftable if you like.

Once Git knows what the remote repository's refs are, it will need to
walk the history to find out what it does and doesn't have.  If there
are many lines of development, then Git will do more work; if there is
just one main branch to fetch, then there will be less.  This will
involve opening every loose commit or tag object or reading every packed
commit or tag object in the history path to determine what needs to be
copied.  If there's nothing to copy, then Git can determine that from
the refs and won't walk any history or copy any objects.

If you _do_ have to transfer data, I'm not sure whether having the data
packed or loose will be more efficient in your case due to the slow
speed.  You can try packing the repository with `git gc` and see how
that affects future transfers.  If latency is the cost, then packing
will almost certainly be more efficient.

You can also see how long various operations take by using
`GIT_TRACE2=3D1`, which will give some detailed timing information that
will help you see what the expensive parts are.

If you have some trace output showing timings, we can advise on what you
might do to help us address performance.

> However, the git-fetch documentation does not clearly state whether the p=
arallel mode only helps if you have multiple remotes and/or multiple submod=
ules. In my case, I just have a single repository with a single origin and =
no submodules.

Parallel mode does not help with a single remote.  All the data for a
single remote comes in one job.

[0] https://stackoverflow.com/questions/52841124/how-fast-could-you-read-wr=
ite-to-floppy-disks-both-3-1-4-and-5-1-2
[1] https://goughlui.com/the-hard-disk-corner/hard-drive-performance-over-t=
he-years/
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--foCTAbiDah/96tt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaas++AAKCRB8DEliiIei
gfb5AP9D8/0lxerOexBXt8GXT8TaQ86nxfWRwGKUw6dLiMTgJgEA3UEpkkZUonUv
7Kav/dF6nRSyxJ/5tDJyTUpo9thvRg0=
=wBTl
-----END PGP SIGNATURE-----

--foCTAbiDah/96tt7--
