Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73B1474C8
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590023; cv=none; b=HYg64BvfVDCTKPDMv7gWaoIpwu+yfC47s63uVmu/2Y6RVgSy6UXSDg4Km5u43C4Bw81KgGcBpjPOIoPiu8nu1aKLikTquuD+OFQTmpdZbh+gghyGO1PnUQ/goeIO0ZGBchBaTu1/6Yi4DTEHUI0odKM6UOBmb6ZjPxhfMqT8E6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590023; c=relaxed/simple;
	bh=v/VweuLejAp75EaGLeKSrYic2nVCcnjh2FF784FKcas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ2IU1SVsDPPmFf29sLMLaQypywOt4ii5Hel2TiStMvT2uekgo8SAVGXl5JMwoMc0qql1fSKfAEGyLdUTxmkz97zsHXEY2KBYao+Dv6Q57MpoRT+YGE3HRnF8IvE7RO6SaJEeM40dDBKMcwroDXuSYQKmASm3ydIR5IwcMg+Dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R0LweNCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6JtUePB; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R0LweNCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6JtUePB"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 31C041C000D6;
	Mon, 13 May 2024 04:47:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 04:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590020; x=1715676420; bh=03Uli0bxTz
	37bdPDpf5ipzSMwDsi03jcn9g0HTe5UhU=; b=R0LweNCwSf+yp1VVlVtANysaQ/
	vICVfOmLLfMeV61zO+yHjzxDtwmOqhkXIWldkG2eiW+I91mjX7rkj3lPZInCyhQN
	LonfJQ6gQa0kPO6R1N6w7Q6RdE0jxJ1Bs2ji4GEMZgV7k+b4zLwrrQFRMmLvVUMH
	CM/5SQOyhvVsxcIzdVDC4etFEhFb2ZUp/yx9Rg4F2aIdmteFPnCqfLcyHz2etYY2
	Lo3QRmI9bV0jI7h34czansjnPzbcx9RzX2MOAqxYs09er9d8wSHjiEaD5mw39Jb5
	0P5L2wx0DJPCR8s3ZfGqmZvzM5zOMZi/G/nN4svI2+5EMkY2ZP16ndvvaxGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590020; x=1715676420; bh=03Uli0bxTz37bdPDpf5ipzSMwDsi
	03jcn9g0HTe5UhU=; b=k6JtUePBXqLyl10yWsLFO+qv3O6rdXITUqjl2Uc7Urb8
	2mi2+83F91aQRGqn86KwaNo7Js7CvVw/kpDgJwsiTQ7yZ+gzZcqxFlg9Yf0oJ+Z1
	HAPAtIXOXBMG2npT1FSqmRxwJ3ZKe8dGU/n5Y98tpEB3ulXNlrjcEfiV5b9JiQby
	yvaYj3zvpXLBY9peI+jJwoVnYYpA+8E5T4DfGvtoUH5uj3YqLN4wJ/Tz4c2cVzlv
	62YbLBRtp4kvI1VzQJNxzVP0nLRF0QxnZ6fvobk9A2L66FsPaail9LWPtt+HoOa/
	JltCxGhtw8gW4CluyO0B1reiAB32XOo/uvWYrGrrIQ==
X-ME-Sender: <xms:hNNBZqjmBpjM9mBgVijQGt3oLhS2fr7ymdPYcAwtgrxpV0UwxSEy-A>
    <xme:hNNBZrBBAYlbo2AFFKBae8Oyq5ao6mnpE5WfR7RpNz82fVodwa4lnWYgFkgpMzyVg
    zOo7TPU4Okl4nE2bw>
X-ME-Received: <xmr:hNNBZiFwLZwblCToFMjizCXD0GY26RUFXTbWjwznpxfMm8JRclPU7JDB4QON6f9luhMyUGAM2wkc7NcWAXbPR0S4v1sMXQ9KvnSrtScmY8YPeew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hNNBZjTQZZNXTSrv1ZPE2rnn7KNcsgC51-0dK-x3UYcvow6ymZgI_w>
    <xmx:hNNBZnwinH_7V8d75GDxzWsVeEuuajDR6tghDG5gzNww-8c9dEWn4w>
    <xmx:hNNBZh6zrG9aOkO89eZUaNnkeSQgaK2uGu2fbN1aIrlzjSZYcSoLLw>
    <xmx:hNNBZkzJukuNybV9uRM0yQfZszW85GzO2Ma9-r-DnxLYt26n1hB_0Q>
    <xmx:hNNBZn8egROvSSVfejYyXjkPnyUEnn4yzlPOkgkZEkxGQPy1dDMX4a-->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:46:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bf3d1e30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:46:40 +0000 (UTC)
Date: Mon, 13 May 2024 10:46:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/13] reftable: prepare for re-seekable iterators
Message-ID: <cover.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dml54KRLpgjkSy6Z"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--dml54KRLpgjkSy6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that prepares the reftable
iterators to become re-seekable. These refactorings will eventually
allow us to reuse data structures by iterators and optimize for certain
cases.

Changes compared to v1:

  - Various fixes to commit messages.

  - Fixed a copy & pasted comment to refer to logs instead of refs.

The series continues to build on top of ps/reftable-write-optim. There
is a merge conflict with the in-flight ps/reftable-write-options, but
given that this series has not yet been merged to next and because Junio
has already resolved the conflict in "seen" I decided to not pull it in
as an additional dependency.

Thanks!

Patrick

Patrick Steinhardt (13):
  reftable/block: use `size_t` to track restart point index
  reftable/reader: avoid copying index iterator
  reftable/reader: unify indexed and linear seeking
  reftable/reader: separate concerns of table iter and reftable reader
  reftable/reader: inline `reader_seek_internal()`
  reftable/reader: set up the reader when initializing table iterator
  reftable/merged: split up initialization and seeking of records
  reftable/merged: simplify indices for subiterators
  reftable/generic: move seeking of records into the iterator
  reftable/generic: adapt interface to allow reuse of iterators
  reftable/reader: adapt interface to allow reuse of iterators
  reftable/stack: provide convenience functions to create iterators
  reftable/merged: adapt interface to allow reuse of iterators

 refs/reftable-backend.c      |  48 ++++----
 reftable/block.c             |   4 +-
 reftable/generic.c           |  94 +++++++++++----
 reftable/generic.h           |   9 +-
 reftable/iter.c              |  23 +++-
 reftable/merged.c            | 148 ++++++++----------------
 reftable/merged.h            |   6 +
 reftable/merged_test.c       |  19 ++-
 reftable/reader.c            | 218 +++++++++++++++--------------------
 reftable/readwrite_test.c    |  35 ++++--
 reftable/reftable-generic.h  |   8 +-
 reftable/reftable-iterator.h |  21 ++++
 reftable/reftable-merged.h   |  15 ---
 reftable/reftable-reader.h   |  45 ++------
 reftable/reftable-stack.h    |  18 +++
 reftable/stack.c             |  29 ++++-
 16 files changed, 378 insertions(+), 362 deletions(-)

Range-diff against v1:
 1:  ca86a8b58d =3D  1:  ca86a8b58d reftable/block: use `size_t` to track r=
estart point index
 2:  bdbebdbd36 =3D  2:  bdbebdbd36 reftable/reader: avoid copying index it=
erator
 3:  716863a580 =3D  3:  716863a580 reftable/reader: unify indexed and line=
ar seeking
 4:  91db2f18c1 =3D  4:  91db2f18c1 reftable/reader: separate concerns of t=
able iter and reftable reader
 5:  4d498ef342 =3D  5:  4d498ef342 reftable/reader: inline `reader_seek_in=
ternal()`
 6:  5a10a11584 =3D  6:  5a10a11584 reftable/reader: set up the reader when=
 initializing table iterator
 7:  21b3e3ab5f !  7:  12c10fd366 reftable/merged: split up initialization =
and seeking of records
    @@ Commit message
         To initialize a `struct merged_iter`, we need to seek all subitera=
tors
         to the wanted record and then add their results to the priority qu=
eue
         used to sort the records. This logic is split up across two functi=
ons,
    -    `merged_table_seek_record()` and `merged_table_iter()`. The scope =
of
    -    these functions is somewhat weird though, where `merged_table_iter=
()` is
    +    `merged_table_seek_record()` and `merged_iter_init()`. The scope of
    +    these functions is somewhat weird though, where `merged_iter_init(=
)` is
         only responsible for adding the records of the subiterators to the
         priority queue.
    =20
    -    Clarify the scope of those functions such that `merged_table_iter(=
)` is
    +    Clarify the scope of those functions such that `merged_iter_init()=
` is
         only responsible for initializing the iterator's structure. Perfor=
ming
         the subiterator seeks are now part of `merged_table_seek_record()`.
    =20
 8:  f0f42cd56b !  8:  31bdfc1e34 reftable/merged: simplify indices for sub=
iterators
    @@ Commit message
         reftable/merged: simplify indices for subiterators
    =20
         When seeking on a merged table, we perform the seek for each of the
    -    subiterators. If the subiterator hasa the desired record we add it=
 to
    -    the priority queue, otherwise we skip it and don't add it to the s=
tack
    -    of subiterators hosted by the merged table.
    +    subiterators. If the subiterator has the desired record we add it =
to the
    +    priority queue, otherwise we skip it and don't add it to the stack=
 of
    +    subiterators hosted by the merged table.
    =20
         The consequence of this is that the index of the subiterator in the
         merged table does not necessarily correspond to the index of it in=
 the
 9:  859b399e71 !  9:  3e91c3830e reftable/generic: move seeking of records=
 into the iterator
    @@ Commit message
         The second and more significant downside is that it is impossible =
to
         reuse iterators for multiple seeks. Whenever you want to look up a
         record, you need to re-create the whole infrastructure again, whic=
h is
    -    quite a waste of time. Furthermore, it is impossible to for example
    -    optimize seeks, for example when seeking the same record multiple =
times.
    +    quite a waste of time. Furthermore, it is impossible to optimize s=
eeks,
    +    such as when seeking the same record multiple times.
    =20
         To address this, we essentially split up the concerns properly suc=
h that
         the parent data structure is responsible for setting up the iterat=
or via
10:  727b8fa432 =3D 10:  b0641dd800 reftable/generic: adapt interface to al=
low reuse of iterators
11:  f688f8f59a ! 11:  0745951650 reftable/reader: adapt interface to allow=
 reuse of iterators
    @@ reftable/reftable-reader.h: struct reftable_table;
     +void reftable_reader_init_ref_iterator(struct reftable_reader *r,
     +				       struct reftable_iterator *it);
     +
    -+/* Initialize a reftable iterator for reading refs. */
    ++/* Initialize a reftable iterator for reading logs. */
     +void reftable_reader_init_log_iterator(struct reftable_reader *r,
     +				       struct reftable_iterator *it);
     =20
12:  68cc35919b =3D 12:  51480c4328 reftable/stack: provide convenience fun=
ctions to create iterators
13:  be4da295c6 =3D 13:  2586e93c44 reftable/merged: adapt interface to all=
ow reuse of iterators
--=20
2.45.GIT


--dml54KRLpgjkSy6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB038ACgkQVbJhu7ck
PpSdJQ//XuaRhc4A5FHUY//pgSvGTNbYiNwvD8+lUZCNnrKAX+3Z/lwvrB8ezIsH
sBLoLLF/kqPDREpazDqRiEQ0pemItmlsA8Xv8W3nm5U7yQp5nwRXehJc/KsOdhnz
pexXh29t+G23Ko9ciqI8F3cNHxVAyEtSEmeC9fJSl+w78hpp2dxyXgnkM6gbXNoi
2qCZEMITs7FQJnQ3WdW5Xe0o0Xs98bu4GagO8hupi8pNp8LdnLZ3ZQi2YY518djX
iROwjFzkP/9sU0lQMg4NbgQhhQGYyQ2cGjnTIBmz0E4xM/Rw1TDzWRQ4JMtCj/zY
xtlI+18ek0iG1TroXjimVI3miNy5WW9IHX0cdbA/b3bFNrW/AnCypM2UdAGJ2gng
vP7edcgEV675g4Zf8WAuiajLwIh44QON7h8TeyZu/Z1f1BeOXkXhaUTnspd7uP9g
ZMDbYHCGFwVz9JL1lsyKaG1DYELClKojoJjVoz5fq1MUu4W6tEV6eaW5f7sX5aaC
y5ytFnZq1ZQyg6LV3aYrZwcnV+o76J2v+D+2C5d2jaXpOegpUcdO2nWg/PnQRp3O
ecJB2IN5NncTsWXgDHXcVLT5MjF4czRt9jjf6d3+Xwo3PACQzw1zgsu4dpnFMfQD
Wsec6x6/FTvDzZt2uj0r6eTYQIvlXvh0Gjap7PDofa6zeu6JvXs=
=+4+k
-----END PGP SIGNATURE-----

--dml54KRLpgjkSy6Z--
