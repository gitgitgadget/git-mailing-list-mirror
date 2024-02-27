Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46513AA38
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046381; cv=none; b=pMTEcnpfT6iZ2FkEAkZb7herTTo+YBpXmoj7sJXrFYFOWsroQhGrgY04+B/4LYIEZMR12wWcraADxBkYqKmJpqt1kIbnctnDBRCKHDJSaFb+PFB3g5hRV9DOsT3Zpl3SqDOmURXOiRDTYA4ZvI1qmN2v2lET6nWrgr9jdqL94tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046381; c=relaxed/simple;
	bh=O+v+CoYhlftCzPtlzM9TkHKo8Wfjt5/moPnluYB8Ga8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo91wjIomGPplym92zJhQyggkOFz1kFcOHgsvw0svpDbde5y4WhVPL3UIHJzfdiLymmz+w+n6HlXjKeM2kt0KY38NXx7foYg1+ksoAE73tEOGlb5M3sCQVYpp544iG/CpVnCHGz8LuyLP2Hv6cWCVeelZ5JyNcPJH6pUH8FHilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UYIXKpZe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEENdyFR; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UYIXKpZe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEENdyFR"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9E60F18000A7;
	Tue, 27 Feb 2024 10:06:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 27 Feb 2024 10:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046378; x=1709132778; bh=FyDRkA3ZJB
	guChc3WJR0SOdsi78nslVlhdR0/L6gTiQ=; b=UYIXKpZeL5xOlCJynzga5c+5xK
	Ad5N6ZphMUBL2ZlakUSV93dDHl+bvqYqfgyfMTnUthjQa7JH/kfUmX8FJKqSh02r
	c6wsMmazRHwdEKJ91oW1SMXlK+ITHJMr/bb7MW3ZEVj6NhQ9Hb9rftsCR8MjwavV
	nXRBOu2Njv+39hhAb9MI09FPdSwXF46PGGH1ghL7guxiWB4VaCqViYCzKYxaGSvv
	chBL0ODWybfHab7o1WotFo0QmT8qtdF5JUOgACymBDnPsis1/8tVJmT1ljtqeg40
	k4ysjyijs+4cEr/DYrvqBsfGTuZVDBY8GKtOQ1i5a9nAgnDBkxXyRdtlXeyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046378; x=1709132778; bh=FyDRkA3ZJBguChc3WJR0SOdsi78n
	slVlhdR0/L6gTiQ=; b=PEENdyFR0rC95UWHsODlp+C4CbpCPK3TpoR9mpJjwkbR
	A29ws7sEXrzkbb7HZ/sHwwYqnV7lTCLN5Uwji+PKF+a6QlCIZfB6DWem/KXna40n
	qPJwotxn0NRCPf+A4+eV7nDI99GecxU4n+YxVzr1CTCrBTfJ6UTrqwAlgIhUCF7L
	qinbRmuF+JKHGVISSb7Jn4GzKMxfEbvvxNQI9Ue1NQjga1LLo+YE8dupCdUZvzIT
	iMH0Z8ES6ad18ZxHNIeCfumkMjnO/2Z3cDlugtPnV0CIC3JcWI0GP+OWIhTr6pSW
	uottn5jQM5A1EuW5eot5T2oJ98ASm2BoVOq8u3TEDA==
X-ME-Sender: <xms:afrdZRhV86ZPPLkF2ibIzyHJsXkCDYrMY5HyzFyeMEXPAMiAbCqT6Q>
    <xme:afrdZWDnJD79sBVK6zCxryttjXDIbzxzJh_uxHleNz17Q1j8wHodoCZHmMfm-aZDK
    CAPrlgBr6y_rV4PpQ>
X-ME-Received: <xmr:afrdZREcdyFE5bBvD3UdSdljr7kwb7GuvlNCJpwsoh41EbL5cwdX6HaHm_EEwErN-JEfi1UA77rPe3RAJ26kXybS7iYLgLW-VYr8Cb7POMMqOMr6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:avrdZWSlfSUR1WjQypDtMPC_ld3JrbFVpPu6oqy8mTS6P4ZN72o9tA>
    <xmx:avrdZewHi0X9B1s0jqxzumy9ohb154j3IOAHSpi_lPv1zmFy1lRYCw>
    <xmx:avrdZc4Dx_u_8_zSHTBaiEElRP1Kjzd_IWnY56ERI3nsYpBqle3Dxg>
    <xmx:avrdZZ-mvsZcxfrVYlDzKn1doO4xHIP48RgMN6cJ13M74nQ33-DR9me3rgs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2c86b30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:01:58 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/13] reftable: improve ref iteration performance (pt.2)
Message-ID: <cover.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Av1tN0eCcNrpMOJ7"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--Av1tN0eCcNrpMOJ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that improves raw ref
iteration performance with the reftable backend.

Changes compared to v1 are sparse:

  - Adapted an include because we don't need "pq.h" anymore.

  - Some commit message improvements.

  - I re-did the performance benchmarks in patch 12 as I noticed they
    were stale.

  - I also included one more patch to avoid re-computing the prefix
    length on every iteration.

This patch series is now based on "master" directly at a2082dbdd3 (Start
the 2.45 cycle, 2024-02-26).

Thanks!

Patrick

Patrick Steinhardt (13):
  reftable/pq: use `size_t` to track iterator index
  reftable/merged: make `merged_iter` structure private
  reftable/merged: advance subiter on subsequent iteration
  reftable/merged: make subiters own their records
  reftable/merged: remove unnecessary null check for subiters
  reftable/merged: handle subiter cleanup on close only
  reftable/merged: circumvent pqueue with single subiter
  reftable/merged: avoid duplicate pqueue emptiness check
  reftable/record: reuse refname when decoding
  reftable/record: reuse refname when copying
  reftable/record: decode keys in place
  reftable: allow inlining of a few functions
  refs/reftable: precompute prefix length

 refs/reftable-backend.c    |   6 +-
 reftable/block.c           |  25 +++----
 reftable/block.h           |   2 -
 reftable/iter.c            |   5 --
 reftable/iter.h            |   4 --
 reftable/merged.c          | 139 +++++++++++++++++++------------------
 reftable/merged.h          |  11 +--
 reftable/pq.c              |  18 +----
 reftable/pq.h              |  16 +++--
 reftable/pq_test.c         |  41 +++++------
 reftable/record.c          |  64 +++++++++--------
 reftable/record.h          |  21 ++++--
 reftable/record_test.c     |   3 +-
 reftable/reftable-record.h |   1 +
 14 files changed, 175 insertions(+), 181 deletions(-)

Range-diff against v1:
 1:  eeaaac9e07 =3D  1:  292e5f8888 reftable/pq: use `size_t` to track iter=
ator index
 2:  be807e7650 !  2:  95e1ccafc4 reftable/merged: make `merged_iter` struc=
ture private
    @@ reftable/merged.c: license that can be found in the LICENSE file or =
at
      	for (size_t i =3D 0; i < mi->stack_len; i++) {
    =20
      ## reftable/merged.h ##
    +@@ reftable/merged.h: license that can be found in the LICENSE file or=
 at
    + #ifndef MERGED_H
    + #define MERGED_H
    +=20
    +-#include "pq.h"
    ++#include "system.h"
    +=20
    + struct reftable_merged_table {
    + 	struct reftable_table *stack;
     @@ reftable/merged.h: struct reftable_merged_table {
      	uint64_t max;
      };
 3:  38d4599566 !  3:  0e327e5fe3 reftable/merged: advance subiter on subse=
quent iteration
    @@ Metadata
      ## Commit message ##
         reftable/merged: advance subiter on subsequent iteration
    =20
    -    When advancing the merged iterator, we pop the top-most entry from=
 its
    +    When advancing the merged iterator, we pop the topmost entry from =
its
         priority queue and then advance the sub-iterator that the entry be=
longs
         to, adding the result as a new entry. This is quite sensible in th=
e case
    -    where the merged iterator is used to actual iterate through record=
s. But
    -    the merged iterator is also used when we look up a single record, =
only,
    -    so advancing the sub-iterator is wasted effort because we would ne=
ver
    -    even look at the result.
    +    where the merged iterator is used to actually iterate through reco=
rds.
    +    But the merged iterator is also used when we look up a single reco=
rd,
    +    only, so advancing the sub-iterator is wasted effort because we wo=
uld
    +    never even look at the result.
    =20
         Instead of immediately advancing the sub-iterator, we can also def=
er
         this to the next iteration of the merged iterator by storing the
 4:  2c51c60d16 =3D  4:  494d74deff reftable/merged: make subiters own thei=
r records
 5:  f1156dbf51 =3D  5:  0adf34d08b reftable/merged: remove unnecessary nul=
l check for subiters
 6:  4e50ac6550 =3D  6:  01152ce130 reftable/merged: handle subiter cleanup=
 on close only
 7:  cd65d849a4 =3D  7:  370b6cfc6c reftable/merged: circumvent pqueue with=
 single subiter
 8:  68bd687113 =3D  8:  1e279f21e6 reftable/merged: avoid duplicate pqueue=
 emptiness check
 9:  3ba697036c =3D  9:  15a8cbf678 reftable/record: reuse refname when dec=
oding
10:  d7311598c0 =3D 10:  35b1af2f06 reftable/record: reuse refname when cop=
ying
11:  f0663c1d62 =3D 11:  d7151ef361 reftable/record: decode keys in place
12:  56ec654932 ! 12:  99b238a40d reftable: allow inlining of a few functio=
ns
    @@ Commit message
         can be inlined. This results in a performance improvement when ite=
rating
         over 1 million refs:
    =20
    -      Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    -        Time (mean =C2=B1 =CF=83):     102.4 ms =C2=B1   3.7 ms    [Us=
er: 99.6 ms, System: 2.7 ms]
    -        Range (min =E2=80=A6 max):    99.1 ms =E2=80=A6 129.1 ms    10=
00 runs
    +        Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    +          Time (mean =C2=B1 =CF=83):     105.9 ms =C2=B1   3.6 ms    [=
User: 103.0 ms, System: 2.8 ms]
    +          Range (min =E2=80=A6 max):   103.1 ms =E2=80=A6 133.4 ms    =
1000 runs
    =20
    -      Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    -        Time (mean =C2=B1 =CF=83):      98.3 ms =C2=B1   3.7 ms    [Us=
er: 95.4 ms, System: 2.7 ms]
    -        Range (min =E2=80=A6 max):    94.9 ms =E2=80=A6 126.2 ms    10=
00 runs
    +        Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    +          Time (mean =C2=B1 =CF=83):     100.7 ms =C2=B1   3.4 ms    [=
User: 97.8 ms, System: 2.8 ms]
    +          Range (min =E2=80=A6 max):    97.8 ms =E2=80=A6 124.0 ms    =
1000 runs
    =20
    -      Summary
    -        show-ref: single matching ref (revision =3D HEAD) ran
    -          1.04 =C2=B1 0.05 times faster than show-ref: single matching=
 ref (revision =3D HEAD~)
    +        Summary
    +          show-ref: single matching ref (revision =3D HEAD) ran
    +            1.05 =C2=B1 0.05 times faster than show-ref: single matchi=
ng ref (revision =3D HEAD~)
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 -:  ---------- > 13:  627bd1f5f7 refs/reftable: precompute prefix length
--=20
2.44.0


--Av1tN0eCcNrpMOJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+mQACgkQVbJhu7ck
PpTQjQ/9F8ZUSsJ6pqXIzqjddXmrxnj7zkYMND8p89SI/iwp5anej02OXInkRKYy
jcl+8324cRW7sk5iq162Zyf7csKpzujyJsveC8l/0vkegKvhlExGFSRSnC/YjPON
e7u2n8weIFSB9H2Jz3M6n7KivysOcIEibA/5g0T5alJALguXqmHCpRnROrcUTBRF
/y91DBiZ1J07ZhTqEOs6qvDkMV3cwfSaLhd20gYCKUnFoDATkc6am+qaspTJdopt
yekpbvWFxsN6jr9sNMUUldpYTy6tIaVYVE/09e8xYTQxjyPGz8ubMg3HoyJ6UCUG
JQfa4FMnavLYiygMdtSMhuSlCfJC0QTxCKAkLAmaxaIPM0fWqhEZ+L4fdbjm53/N
j5KNN0tAXMWeTX2IiZq7+1A+Mvar/lYQ2KjVfVbspmczHcSSc6VQUeSonVlYT2rL
nkzyDR6MzS2QJ+4J76EnhlHVAgdE76P1CsE6VoZOoerTqDIepF9Ty8EzTbWUp6v3
D9R5LwvYruKKPr9ExIVDmwo0/urVKzMHa9C3YyVBBvUHfMEqtgnnv756e3U/twkr
LpgWzTc4rXvyHFGU7be6/hLLEIs3p3PBvJTZElIFzMJN1nfSfLtyGxqH+dRMy+tT
dKvSoOzby3iwBc8cyQ/zoyvxIOZze2QNBhNj/dwrx6NujfccT8A=
=1e6G
-----END PGP SIGNATURE-----

--Av1tN0eCcNrpMOJ7--
