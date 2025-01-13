Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549A1CAA87
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776604; cv=none; b=CigRd9nZcCfEdmClBlaf1aTGPw2EsWp1NGknL4Wzj/rFwRvh81/KpnXX36Ah0hFFhvu6+U9zXBSv2H37oNEgk+m4aR2QWRPSoQzY3oxNXwx2VMGHd+zFpcOcvs4glFE6WiZBKe9/4JXzMmVfD85fBIU/U83EKHOD5WOP66RTCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776604; c=relaxed/simple;
	bh=cNtX7zR2llR6EDkdWKUU89eaWV1oyZEZxaYQ7yPlpCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sHL6sYkRYLVz4XmHtUorrPhkfKX1BfJJTHt4dMPWW2PsdVXBlXent5XkWjpWEZs+hrZzINiMSOBW9BOPRtbQCIXJ4tOpF6ojaPGMdn/eRTWcDp994L3+Y97dFjYgS/Jzt9wlrT2OOeZg44Mm8GeoSRDgplIa8GOoCxXvmmzVhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ESgc/qTo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ESgc/qTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736776594;
	bh=cNtX7zR2llR6EDkdWKUU89eaWV1oyZEZxaYQ7yPlpCM=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=ESgc/qToaM/v2TXsmja9aLWoRjXei43tLrM4frIwsQcC8r4lK08DuhKT0bZoiK8jd
	 /QikbD9XxXITvpgft11YEDbRTSclioXkQ3qJOYtgeo3gYDFzWBwuOqImmGsXMxurXH
	 dIwra0Dgc0wPZAYFrF9hLKiXkfvuSQ2z3TW1GVhyIEFrbpecIr+9mUpFuKSupbN4Rk
	 PQRmiPRH/d2QZ6mtsp4yQFPjfUFTa87ymGbCNHRbMeXdkQhwN1swDY6fCgRayJEtlC
	 hKK7Kkq/W6kSdiSRqjMPsZgHrLOMYmjLwhdsIj5A+TNgaoRha4mJPUahYLDaynTNyQ
	 I3oac7gC5YmvM3yJE4EKzwWmXeBLTZ69zTOEerTh7iEd340nAYXgNiD8r1WpahOzwA
	 6BWp2Zwt0OfL3AWqZF/FwAvATyL9BVRcm/1k2VjXwuso/fN6f8W2WtqTXXTEtZIG2x
	 bnH7ai5g5f5XauZpem8/Kjuc5C7H7E3hG6LHymoobjfYI1ZjMul
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:fba1:9a5e:92fc:edf2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B978A20008;
	Mon, 13 Jan 2025 13:56:34 +0000 (UTC)
Date: Mon, 13 Jan 2025 13:56:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Bug in 2.48 with `git refs migrate`
Message-ID: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NWLNA4LoaZILOFDG"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--NWLNA4LoaZILOFDG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that Git 2.48 has support for migrating refs when there are
reflogs and, as promised at Git Merge, I decided to try it out.
Unfortunately, I got an error:

----
% git refs migrate --ref-format=3Dreftable --dry-run
error: reftable: transaction failure: corrupt reftable file
----

Here's a small reproduction case:

----
#!/bin/sh

rm -fr test-repo
git init -b dev test-repo
cd test-repo

# start first block
touch foo.txt
git add foo.txt
git commit -m +

head=3D$(git rev-parse HEAD)
seq 5000 | sed -Ee "s!^(.*)\$!create refs/heads/ref-\1 $head!" | git update=
-ref --stdin
# end first block

# start second block
echo abc >bar.txt
git add bar.txt
git commit -m +
head=3D$(git rev-parse HEAD)
seq 3000 | sed -Ee "s!^(.*)\$!update refs/heads/ref-\1 $head!" | git update=
-ref --stdin
# end second block

git refs migrate --ref-format=3Dreftable
----

I can also reproduce this on the latest master.

If you remove the second block, it does not appear to reproduce.  Some
investigation led me to the conclusion that the difference is when
max_update_index is not 1, the header has the value 1 for it but the
trailer has the correct value, and so we flag the header and trailer as
mismatching and therefore it gets marked as corrupt.  I believe the
reason things work when removing the second block is because that value
remains 1, and so it works.

I haven't done anything else to investigate here, for which I apologize,
but I just wanted to mention it while it was fresh on my mind.

In case this is helpful, I did see this when attempting to migrate two
work repositories with lots of reflogs and many refs (the smaller has
2983 and the larger, 44832).  I obviously cannot send you these
repositories or things in them, but I'm happy to test patches against
them.

Please let me know if I can provide more useful information.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--NWLNA4LoaZILOFDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4UbkQAKCRB8DEliiIei
gdDTAPsF3SjyD7N1l9lLr9++B+t1DVCVJpZoXZSE1Vd7lBsfcQD/XDNnYEnXAhFp
q6o43a25rm6ly2nW9r+gLJAZbU8ERwM=
=sb5c
-----END PGP SIGNATURE-----

--NWLNA4LoaZILOFDG--
