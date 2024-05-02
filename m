Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118152E85A
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637836; cv=none; b=XNVG0FfRCwa/cVqYTAYlUf1YxAZ5gc9lDOaS4MWQwoUyqubbY6HiffqQYZhQ1gaz3eMDA7sWfMlFV3lg1z/gGYlmKR9nHvWGSlIM28QJp0rKwQ3f+89fPi7PjsIXiqq3c5rpYgUd2xUhnXic0oaCzGm0kAG/4UWSQ+W7HRIGf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637836; c=relaxed/simple;
	bh=3z0+W86WTH7nMuL6UP4dpWNBS2/EGKQJke8ZBzEWs7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCzo9MUsq/a7w2F9yRbCnLTE9K1AfMKRXxDM4EBtZkFcR5wU0c2b+Y1rJX5VJwFbCCNFuiZUnllbYwC+Ro0dlRVMh8k5NtpL3xJfdm5RWByGYPUmPb4Qceua1asRSMcUgcAWGJL4BPz3T6NtDScSv9/yKG21nNUEnqinxtRlXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QwlhgA+j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQvOe0pG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QwlhgA+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQvOe0pG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2C83013805A3;
	Thu,  2 May 2024 04:17:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 May 2024 04:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637834; x=1714724234; bh=PF+p/8ntRq
	mgnyf9Z9gdV52sP6geygHyThCtnx2Kn/c=; b=QwlhgA+jRUqpFIS9KQd8pl2uYp
	yHsAX2KcJpH8L33Qo3Q4Ok4MzP8sRyc8l49qKYgek+1WIThAYV1J8TLoIvi8U0Fs
	k7lT6vQ0QihVB5JiflLeefkOUW85i+09JT9AQcGSZpF9IRAPFX0ONu+oxv/31vTA
	vN655fz2WXW0gwwwY9kVKwt4MGxljPxYSeJBPmigA9VaK3IH7vZ1aOgcDJzgxvGl
	IDedY3GrX8tVyaVbnmT+BZ5HbmaKWbYS94A9UdrLJ7tHLcrTBMqBFvczN733e46l
	DhlNeoEzt6z0V4ATBEmaG3JTACADdTV7GonuNyV08+GXHWZyDa8b18GnVRyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637834; x=1714724234; bh=PF+p/8ntRqmgnyf9Z9gdV52sP6ge
	ygHyThCtnx2Kn/c=; b=WQvOe0pGyX83f5TGyRS8c29hvy+/XWTuETTaSTlCNV4/
	sUMYuPjx5xAKvelUx7WyJvvSVwQnjrSuFlqNFXErFYknyrxpParnuaSY/LvTd5sJ
	PRhjaqWzGoMuJIMqAj6jlh8QPNmknkNpAsuuSWsyrKBJsLvzYzikMEw/sluIMY1E
	yU8KJ7FFtKlohvAAvlAFMLXgqhAE1j06a1I3Z+NCvF4jtsZ4hFCDtVKjsVf+fg0+
	sIuZvSLkopf6Sk937dI7cSgeHeyLlTwlUsywpdNi954SIQU3UMScxppun8q0LHw2
	X4iEnQHAFYhfBPTQxyggdmSPfi452IITpx5WCXAoJg==
X-ME-Sender: <xms:CUwzZqIh9T2y4O9PqB6p-ttSLG3cAmI770CpOkRWQOaN_IniIaAw9Q>
    <xme:CUwzZiL65GI3TxQeUj287DkdPCOMgdwZ8gZHVH9V67o4_jo-q63iTK3GaXL83g-G0
    W8k5834HMbeCKSUYQ>
X-ME-Received: <xmr:CUwzZqtk8d7ZihoSQ7uCHTnKsfH-vAwArPCxmk8O2m9inRiEp5EEVfA8CEOkB41V3j7m44SMQD6PKqC92CTZD2bbZiAJ1JLNSHfILFKt9YPUubk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CUwzZvbqwCkftZY3uRr4nb65f5BE7w_VXvNBJp5MtB3W9swlx251_g>
    <xmx:CUwzZhbTSEWzuwOOZMZGaDTNfqL-1pZ5rgE-AytSunPCi8w0l1oX1g>
    <xmx:CUwzZrBA1ho2VIPVGZx5qJozqzLqr-Cj4v-t_xyC98b8AiNqENToFw>
    <xmx:CUwzZnY8NaDierqPPUe712UPJJRQCzFPpLZD9CHBz45jnCV1rm712w>
    <xmx:CkwzZt5Q6e-S61qtUNSRkBzwqGhqHWIzOCFxtPPC4rR9Yd-bDLR58msk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 85645ecd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:16:45 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 00/10] Clarify pseudo-ref terminology
Message-ID: <cover.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mIy7KDAWoyDlSKzJ"
Content-Disposition: inline
In-Reply-To: <cover.1714398019.git.ps@pks.im>


--mIy7KDAWoyDlSKzJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that aims to clarify the
pseudo-ref terminology.

Changes compared to v2:

    - Various typo fixes.

    - Added a note in the first commit that we're about to clearly
      define rules around "root refs" in a subsequent commit. While this
      patch series will make root refs act like "just a normal ref", we
      will still have strict limits around the naming policy for them.

Thanks!

Patrick

Patrick Steinhardt (10):
  Documentation/glossary: redefine pseudorefs as special refs
  Documentation/glossary: clarify limitations of pseudorefs
  Documentation/glossary: define root refs as refs
  refs: rename `is_pseudoref()` to `is_root_ref()`
  refs: refname `is_special_ref()` to `is_pseudo_ref()`
  refs: classify HEAD as a root ref
  refs: root refs can be symbolic refs
  refs: pseudorefs are no refs
  ref-filter: properly distinuish pseudo and root refs
  refs: refuse to write pseudorefs

 Documentation/glossary-content.txt |  72 ++++++++---------
 builtin/for-each-ref.c             |   2 +-
 ref-filter.c                       |  16 ++--
 ref-filter.h                       |   4 +-
 refs.c                             | 120 ++++++++++++++++-------------
 refs.h                             |  50 +++++++++++-
 refs/files-backend.c               |   3 +-
 refs/reftable-backend.c            |   3 +-
 t/t5510-fetch.sh                   |   6 +-
 t/t6302-for-each-ref-filter.sh     |  34 ++++++++
 10 files changed, 205 insertions(+), 105 deletions(-)

Range-diff against v2:
 1:  2489bb5585 !  1:  e651bae690 Documentation/glossary: redefine pseudore=
fs as special refs
    @@ Commit message
    =20
         The original reason why pseudorefs were introduced is that there a=
re
         some refs that sometimes behave like a ref, even though they aren'=
t a
    -    ref. And we really only have two of these nowadads, namely "MERGE_=
HEAD"
    +    ref. And we really only have two of these nowadays, namely "MERGE_=
HEAD"
         and "FETCH_HEAD". Those files are never written via the ref backen=
ds,
         but are instead written by git-fetch(1), git-pull(1) and git-merge=
(1).
    -    They contain additional metadata that hihlights where a ref has be=
en
    +    They contain additional metadata that highlights where a ref has b=
een
         fetched from or the list of commits that have been merged.
    =20
         This original intent in fact matches the definition of special ref=
s that
    @@ Commit message
         definition, we can drop the "special refs" term again. It's not ex=
posed
         to our users and thus they wouldn't ever encounter that term anywa=
y.
    =20
    +    Refs that live in the root of the ref hierarchy but which are not
    +    pseudorefs will be further defined in a subsequent commit.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## Documentation/glossary-content.txt ##
     @@ Documentation/glossary-content.txt: exclude;;
    - 	that start with `refs/bisect/`, but might later include other
      	unusual refs.
     =20
    --[[def_pseudoref]]pseudoref::
    + [[def_pseudoref]]pseudoref::
     -	Pseudorefs are a class of files under `$GIT_DIR` which behave
     -	like refs for the purposes of rev-parse, but which are treated
     -	specially by git.  Pseudorefs both have names that are all-caps,
    @@ Documentation/glossary-content.txt: exclude;;
     -	they are updated by directly writing to the files.  However,
     -	they can be read as if they were refs, so `git rev-parse
     -	MERGE_HEAD` will work.
    -+[[def_pseudoref]]pseudoref ref::
     +	A ref that has different semantics than normal refs. These refs can =
be
     +	accessed via normal Git commands but may not behave the same as a
     +	normal ref in some cases.
 2:  1f2f8cf3f2 !  2:  66ac046132 Documentation/glossary: clarify limitatio=
ns of pseudorefs
    @@ Commit message
           - They can be read via git-rev-parse(1) and similar tools.
    =20
           - They are not surfaced when iterating through refs, like when u=
sing
    -        git-for-each-ref(1). They are no ref, so iterating through refs
    +        git-for-each-ref(1). They are not refs, so iterating through r=
efs
             should not surface them.
    =20
           - They cannot be written via git-update-ref(1) and related comma=
nds.
    @@ Commit message
      ## Documentation/glossary-content.txt ##
     @@ Documentation/glossary-content.txt: exclude;;
     =20
    - [[def_pseudoref]]pseudoref ref::
    + [[def_pseudoref]]pseudoref::
      	A ref that has different semantics than normal refs. These refs can =
be
     -	accessed via normal Git commands but may not behave the same as a
     -	normal ref in some cases.
 3:  9659d7da3f !  3:  243d616101 Documentation/glossary: define root refs =
as refs
    @@ Documentation/glossary-content.txt: The following pseudorefs are kno=
wn to Git:
     -Different subhierarchies are used for different purposes (e.g. the
     -`refs/heads/` hierarchy is used to represent local branches).
     +Ref names must either start with `refs/` or be located in the root of
    -+the hierarchy. In that case, their name must conform to the following
    -+rules:
    ++the hierarchy. For the latter, their name must follow these rules:
      +
     -There are a few special-purpose refs that do not begin with `refs/`.
     -The most notable example is `HEAD`.
 4:  3d7ea70417 =3D  4:  0a116f9d11 refs: rename `is_pseudoref()` to `is_ro=
ot_ref()`
 5:  e6b6db972d !  5:  484a0856bc refs: refname `is_special_ref()` to `is_p=
seudo_ref()`
    @@ Commit message
         defined terminology in our gitglossary(7). Note that in the preced=
ing
         commit we have just renamed `is_pseudoref()` to `is_root_ref()`, w=
here
         there may be confusion for in-flight patch series that add new cal=
ls to
    -    `is_pseudoref()`. In order to intentionall break such patch series=
 we
    +    `is_pseudoref()`. In order to intentionally break such patch serie=
s we
         have thus picked `is_pseudo_ref()` instead of `is_pseudoref()` as =
the
         new name.
    =20
 6:  44f72a7baf =3D  6:  c196fe3c45 refs: classify HEAD as a root ref
 7:  e90b2f8aa9 !  7:  92a71222e1 refs: root refs can be symbolic refs
    @@ Commit message
    =20
         Last but not least, the current behaviour can actually lead to a
         segfault when calling `is_root_ref()` with a reference that either=
 does
    -    not exist or that is a symbolic ref because we never intialized `o=
id`.
    +    not exist or that is a symbolic ref because we never initialized `=
oid`.
    =20
         Let's loosen the restrictions in accordance to the new definition =
of
         root refs, which are simply plain refs that may as well be a symbo=
lic
 8:  bc82d7ae65 =3D  8:  8bd52e5363 refs: pseudorefs are no refs
 9:  95d7547b2e =3D  9:  cd6d745a01 ref-filter: properly distinuish pseudo =
and root refs
10:  b2029612dd =3D 10:  6956fccced refs: refuse to write pseudorefs
--=20
2.45.0


--mIy7KDAWoyDlSKzJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTAMACgkQVbJhu7ck
PpTs/w//cjkh/9NllgkftM9ubPMYYcnTI00K5l9+4yC18jtpHVqytc0hXjtfcIvH
mPcGFYWYObucxPMjpxdXuc9gIXety+2Izj71biepG+M3By8QIO3G3PDoDIlGGjfL
6dLV8kTnKxkx2NRGYevz3WYEqWbJ/Ndz/ckAlJ2AWj9lYeVtXxgpRmAE87Y9IEAv
ESa6lqirouO7zxq7iCDBmkIYTimEc3pzD5IjzcRgzDZCdh3KDAGrks29C2aWxmee
Lqmn5//qZPv/hCVC89CF/vjmLXYPgsyY4OSHWFJlcxaVosIGSUhbwwr2DV9l95SO
n3+q8PU7Ua3jObRHQXm59mWXwgaO4uptOlHveeNh5ByaVBnf0qFWx4squildszSZ
rsL4yezy3VYNGFmVm2IHYRVqLymR9cK8Mwg3+ylkfu7mGEksOmnCk7AUu1WbIihc
XiCMHc2ZNVE7xpcGNezAd5qpwYnVn/78gm0qYx3LMjlMKXM08Y0YAF2NqU1pYqzp
pNB2+Xze73osQzbDP7PELpYlwNa5TKm/32wXh+VH5nzJQRMISCgLVIGgTDCBbEHL
NEH0c2rlUavY2OQVEtU7/jrBFg7/61WyxUA/oMPcRi6l1ujNDkxphe/YmrqYbYCQ
BEeCElFYNbfp41EapnluZ/b63xrfzzeTUvOa4wijDpT2bIzFRjM=
=Ld1W
-----END PGP SIGNATURE-----

--mIy7KDAWoyDlSKzJ--
