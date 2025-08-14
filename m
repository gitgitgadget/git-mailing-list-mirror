Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032723B0
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133771; cv=none; b=M80w7cBkLv2vrcat2utyCxMIQUHBBHWZWxguIo8xd+bE/B/0G2Q5N/ia5GZVe2M5mboic0QlIefEeHogt+NFlFnkAk4uQtQwLQv8+6iqgbHlmHCjftZB9FOPWGgxTi+lrkMaIj5ZU/RkS6pJq9+XILUiCoIcE15sDWtHQybjE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133771; c=relaxed/simple;
	bh=cCwiV4fxVzwDhM7x+fQboWdCcvuqGF2imtulc5CtDEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EE0Qq9Qn1QIX/t+Y2BkNrgcy5/bNV/z9IX2NWey4kEOVEBhMOQS3OmwFnhT6+3wAH3dQuw5AlbXbJZo/MeaL3pTeYeP4zrpfyEu8o5PNKzkuvRX7AnQLvx4woRdK0azcsAQcX0K19yoYoYK+P3vqdK23sMWS/nRNCEUoMvdZ2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kIbkjbqC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kIbkjbqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755133767;
	bh=cCwiV4fxVzwDhM7x+fQboWdCcvuqGF2imtulc5CtDEw=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=kIbkjbqCNWKDCe6R+WRhN+gQzK/nHqeV/9cucsirIkXPzN2As0wXgDf0aqBN7Iaow
	 KL2fKe8RCIMUuVCGmg4Ux1yIs7hVZlaIYC2dA/982Nq2qpBemlPSUEQOMXHuES6roX
	 rSq/dHFrngytAOAdzHyEN5o7/Fbu7lKdPnDq/DkiuV7l11KN8wbPVeSGmHTZBztQqE
	 a+qBz4Vx8g6Ypl6o6b/yQuZwDcFae8rNjiaFJsY8PPt5iFqBSN/SdesEuledkbC4ED
	 2ZQ7UzvQcvV17u3dC0/cTfE/awwI4/Ul89K/45Q6oCXPMiIpXnV+WgTc0mvM/50H/H
	 vb6NdoEvPaPLL7V8+tY+jXI56MjQ/ln4kvGUEKslh7ZaBcQo4G9BDsjWY1o40CZM/K
	 8D0w+gFUP+ggEMBvCpuM2fRyZpIz3DbLJkaruZbWbht+g0NOTzjiqkWhPV/DVRn01n
	 ytYYmA2ZOoGLMneLpnQLa5lJ6TZtBx9ttDFKtQIl/VImcglCiz1
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:dcf7:b1e8:faac:b3aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 52E46200B7;
	Thu, 14 Aug 2025 01:09:27 +0000 (UTC)
Date: Thu, 14 Aug 2025 01:09:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Efficiently storing SHA-1 =?utf-8?B?4oaU?= =?utf-8?Q?_SHA-256?=
 mappings in compatibility mode
Message-ID: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ljCcHdgvTCLMGBDH"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--ljCcHdgvTCLMGBDH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

TL;DR: We need a different datastore than a flat file for storing
mappings between SHA-1 and SHA-256 in compatibility mode.  Advice and
opinions sought.

As I've mentioned earlier on the list, I'm working on some of the code
for interoperability between SHA-1 and SHA-256.  The good news is that
it's relatively advanced so far.

Right now, we have pack index v3 (so we can store both loose and packed
objects) and it's possible to clone and fetch from and push to a
single-algorithm server if the client repository supports both
algorithms and there are no shallow clones, partial clones, or
submodules involved.  Those who are interested can look at my
`sha256-interop` branch[0], learn more at my talk at Git Merge (which
I'll be giving remotely), or talk to me at the Contributor Summit.

Our approach for mapping object IDs between algorithms uses data in pack
index v3 (outlined in the transition document), plus a flat file called
`loose-object-idx` for loose objects.  However, we didn't anticipate
that we'd need to handle mappings long-term for data that is neither a
loose object nor a packed object.

For instance, with shallow clones, we must store a mapping for the
shallows the server has sent us[1], since we lack the history to convert
objects otherwise.  Similarly, if there are submodules or we're using a
partial clone, we must store those mappings as well, since we cannot
convert trees without them.  We can store them in the
`loose-object-idx`, but since it's not sorted or easily searchable, it's
going to perform really terribly when we store enough of them.  Right
now, we read the entire file into two hashmaps (one in each direction)
and we sometimes need to re-read it when other processes add items, so
it won't take much to make it be slow and take a lot of memory.

For these reasons, I think we need a different datastore for this and
I'd like to solicit opinions on what that should look like.  Here are
some things that come to mind:

* The format should be fast to read and relatively fast to write.
* We need to efficiently read and map objects in both directions.  This
  is required for many reasons, including efficient fetches and pushes.
* We still require an in-memory store because we stuff entries in their
  without writing them during pack indexing and other operations, but
  that doesn't mean we need to load data from the data files into the
  in-memory structure (in fact, we probably should try to avoid it).
* We want to be able to write small updates to the data without having
  to re-write the entire thing (e.g., `git add`).  We often know that
  we'll be writing a whole batch at once, such as with shallows or
  submodules from a clone or fetch, so many places in the code will be
  able to start a batch and then write, but we shouldn't assume that
  will always be the case.  (In other words, we will write more
  frequently than we do packs or indexes.)
* It would be helpful if we can determine the type of object being
  stored.  For instance, if we've stored an object mapping because of a
  shallow, `git gc` could remove that mapping if the shallows have been
  updated and the mapping is no longer useful.
* We should try not to assume only two hash algorithms.  Pack index v3
  allows for effectively an arbitrary number and while much of the
  compatibility code assumes one main and one compatibility algorithm,
  we should try to minimize that if possible.[2]
* Being able to mmap it would be convenient, so if we can make it
  relatively small, that's nice.

Some rough ideas of what this could look like:

* We could repurpose the top-bit of the pack order value in pack index
  v3 to indicate an object that's not in the pack (this would limit us
  to 2^31 items per pack).
* We could put this in new entries in multi-pack index and require that
  (although I'm not sure that I love the idea of requiring multi-pack
  index in all repositories and I have yet to implement compatibility
  mode there).
* We could write some sort of quadratic rollup format like reftable.

I would recommend reading the pack index v3 format documentation in
`Documentation/technical/hash-function-transition.adoc`, since I think
it's helpful to understand what we have now.  I have implemented a small
variant on it (documented in my branch) and will send some documentation
updates before code, although the differences are minor and not relevant
here.

I've taken the liberty of CCing some people who have worked deeply with
our existing formats (packs, indexes, reftable, and so on), but I've
almost certainly missed some people and I'd love thoughts from anyone
about this.  Once we have an approach that we think is useful, I'm happy
to write up a document for it and send it out.

[0] Available from https://github.com/bk2204/git.git.
[1] This assumes that the server also supports both algorithms to
generate and send the mapping.  I am implementing that work now and it
has yet to be pushed to the branch (because it presently doesn't work).
[2] We might find that SHA-256 becomes weak well before SHA-1 is
completely dead and we need to deal with a third algorithm suddenly, so
we should not mortgage our future unnecessarily.  Cryptographic attacks
only ever get better.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ljCcHdgvTCLMGBDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaJ03RQAKCRB8DEliiIei
gU1sAP4zQWyrDQL66EEXdmUiZjT+IpkekL+3X51f6O6lyKQ7wwD/dADOX+a2udA9
68ibKCpgIKENhDBH8KvGYwHDxxbywQU=
=gZe8
-----END PGP SIGNATURE-----

--ljCcHdgvTCLMGBDH--
