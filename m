Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0E1586C8
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772777; cv=none; b=fOMJWX4VhUrnwAVPDbzeFeU1AGpXal+OGXCD1t4shk6abX9E326yZ4FuEG0Xrju9lVz1w6zVCNOntBGHZ2jNAOEQvtTsF9HK9unb5QBGRwp3GArHWzAZDwO7aJSrumlge/eCCkrvlSOqMUZ16TsgMBbLhSH3T/gSK5y4J0/1CHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772777; c=relaxed/simple;
	bh=q/iHTUOZ5gXT+hHXQ5pSCzoDuXqESveE2CcF0mwTfYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvcaKhz9LGv9JLClY7aFinKbkkmowCwAnbZbbYVxlWzB1S5RswScfKbsMRLXt/vZZswTH4nNHKvpeH3NIcJmWeBIjz2T3XuadYZMdmqqVbQa30ofM0VZ/NSSW8NJMG05zGJzB1fGw51YZdb/VLVlYrzwlfATJzlGMjFSmgeZV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sCHBXKOJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPHWAG3Q; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sCHBXKOJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPHWAG3Q"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 701531C0007A;
	Thu,  1 Feb 2024 02:32:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 01 Feb 2024 02:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772773; x=1706859173; bh=QoyjWFHiQc
	CZiIuMG2/RMJPOXUwfqQx9M6HiJwNqiz0=; b=sCHBXKOJlPww452zF0dyLnvVKi
	z+MdIMmo444XXRbSZMHyUPguwcuE2pnocWegzX5Dw4wRyViVrNg4kKogTcaZSeZ8
	SwoUYNIdHslNQN7exAokcTT9wwoGuoLDcrOCTwTT+IHRhE9OomID0y1r9Y/ess+f
	VSetflXvI2snEz2ib0g/a4/ebv2MI77aSsJdaAH7u8WDt3q6yXqHU/rtSb3uinef
	j0uzwP/biJw7bOCH2/dRnsytMpClnfJMkOwpgdad1KfYNS1OKQEbfmzbidgB6uXm
	nlpxK4EFzUhG16jhKQ/EFIVIg3lpERCfhm9V6i+RBgve6PvkhfhcdpqZP6Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772773; x=1706859173; bh=QoyjWFHiQcCZiIuMG2/RMJPOXUwf
	qQx9M6HiJwNqiz0=; b=YPHWAG3QSbJgEW3/QLTy9H1GKf039G0NXCOksvqwHuAe
	YHwx7LtjTU84dvnCjEmKzrj0KS3jYvfYOhMIfw2LIQ36cPGnQyPY5Fh21WCREsgv
	Q1M2v5RDYRNUQvI4wJREexQzsD1c8iUAGVeOimub6kTGfHFZiAALoCpqb01ejDb/
	GHRDlvCWAm2WhG7JyFcFJ6imGdMlB8hO7X5DoWdjit94il6bsO879ekIHmRTsfK4
	GYci6UYa/oWyR5Vh35WfVHIFUEpC/yB7X+PEa/chX4QaLHdyyhxvio4xkK8gJiu4
	bp5nMl8NLcyGnWeXaDFzYBa8nKGuDbDNyru+gFegxw==
X-ME-Sender: <xms:JUm7ZZ8HMSl6vn4m0dAGjNZgruV9PDup8ogFjhquYjza6c0V2cwOjQ>
    <xme:JUm7Zds0Q8cNuNf9WPqQdqxiHgpfW-JcYMyhmpX25CMZeOBmPW1qAYQ47WhcAp8lu
    ylD-KtpO_r452anPw>
X-ME-Received: <xmr:JUm7ZXCbXtSnL7R0T7BTKM_t4G6oBu8n6a9YTmb6bGRMOoB1yXD4ShTSQp-d-HPwDPcp3ZmV_OEQRYqxZQNniqn0qfQ_SZufEytcqOdS8dOZhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:JUm7Zdc6EhwLoKOzshwg9bDWSH_QYoqZiWQFYjsgR3VAWxINS-jLmA>
    <xmx:JUm7ZeP7F0GmqatoahWwNQzfUTwQE-N5N5Fl9xBuf_fp6PhKWC4A2Q>
    <xmx:JUm7ZfnNrtNtHW678dM2RYqIcc7-MLndU7TwoU9y6bKuRtPd8Iknbg>
    <xmx:JUm7ZbqZGy1oLPvjGGpBsOHksD8uUMTgZFjDEtIWK9IR7ir2InbRLuooltI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:32:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30857285 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:29 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:32:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] reftable: code style improvements
Message-ID: <cover.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPsjsrBUQxUYzv79"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--ZPsjsrBUQxUYzv79
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to improve the
code style of the reftable library.

The only changes compared to v1 are improvements for the commit
messages. The edit for commit 1 should hopefully make it a much more
compelling argument why we don't want to use the default growth factor
used by our own `ALLOC_GROW()` macro.

Thanks!

Patrick

Patrick Steinhardt (9):
  reftable: introduce macros to grow arrays
  reftable: introduce macros to allocate arrays
  reftable/stack: fix parameter validation when compacting range
  reftable/stack: index segments with `size_t`
  reftable/stack: use `size_t` to track stack slices during compaction
  reftable/stack: use `size_t` to track stack length
  reftable/merged: refactor seeking of records
  reftable/merged: refactor initialization of iterators
  reftable/record: improve semantics when initializing records

 reftable/basics.c          |  15 ++--
 reftable/basics.h          |  17 ++++-
 reftable/block.c           |  25 +++---
 reftable/block_test.c      |   2 +-
 reftable/blocksource.c     |   4 +-
 reftable/iter.c            |   3 +-
 reftable/merged.c          | 100 +++++++++++-------------
 reftable/merged_test.c     |  52 ++++++-------
 reftable/pq.c              |   8 +-
 reftable/publicbasics.c    |   3 +-
 reftable/reader.c          |  12 ++-
 reftable/readwrite_test.c  |   8 +-
 reftable/record.c          |  43 +++--------
 reftable/record.h          |  10 +--
 reftable/record_test.c     |   8 +-
 reftable/refname.c         |   4 +-
 reftable/reftable-merged.h |   2 +-
 reftable/stack.c           | 151 +++++++++++++++++--------------------
 reftable/stack.h           |   6 +-
 reftable/stack_test.c      |   7 +-
 reftable/tree.c            |   4 +-
 reftable/writer.c          |  21 ++----
 22 files changed, 221 insertions(+), 284 deletions(-)

Range-diff against v1:
 1:  0597e6944a !  1:  12bd721ddf reftable: introduce macros to grow arrays
    @@ Commit message
         Throughout the reftable library we have many cases where we need t=
o grow
         arrays. In order to avoid too many reallocations, we roughly doubl=
e the
         capacity of the array on each iteration. The resulting code patter=
n is
    -    thus duplicated across many sites.
    +    duplicated across many sites.
    =20
         We have similar patterns in our main codebase, which is why we have
         eventually introduced an `ALLOC_GROW()` macro to abstract it away =
and
    @@ Commit message
             + 16) * 3 / 2`.
    =20
         The second change is because we know a bit more about the allocati=
on
    -    patterns in the reftable library. For In most cases, we end up onl=
y having a
    -    single item in the array, so the initial capacity that our global =
growth
    -    factor uses (which is 24), significantly overallocates in a lot of=
 code
    -    paths. This effect is indeed measurable:
    +    patterns in the reftable library. In most cases, we end up only ha=
ving a
    +    handful of items in the array and don't end up growing them. The i=
nitial
    +    capacity that our normal growth factor uses (which is 24) would th=
us end
    +    up over-allocating in a lot of code paths. This effect is measurab=
le:
    =20
    -      Benchmark 1: update-ref: create many refs (growth factor =3D 2 *=
 cap + 1)
    -        Time (mean =C2=B1 =CF=83):      4.834 s =C2=B1  0.020 s    [Us=
er: 2.219 s, System: 2.614 s]
    -        Range (min =E2=80=A6 max):    4.793 s =E2=80=A6  4.871 s    20=
 runs
    +      - Before change:
    =20
    -      Benchmark 2: update-ref: create many refs (growth factor =3D (ca=
p + 16) * 3 + 2)
    -        Time (mean =C2=B1 =CF=83):      4.933 s =C2=B1  0.021 s    [Us=
er: 2.325 s, System: 2.607 s]
    -        Range (min =E2=80=A6 max):    4.889 s =E2=80=A6  4.962 s    20=
 runs
    +          HEAP SUMMARY:
    +              in use at exit: 671,983 bytes in 152 blocks
    +            total heap usage: 3,843,446 allocs, 3,843,294 frees, 223,7=
61,402 bytes allocated
    =20
    -      Summary
    -        update-ref: create many refs (growth factor =3D 2 * cap + 1) r=
an
    -          1.02 =C2=B1 0.01 times faster than update-ref: create many r=
efs (growth factor =3D (cap + 16) * 3 + 2)
    +      - After change with a growth factor of `(2 * alloc + 1)`:
    +
    +          HEAP SUMMARY:
    +              in use at exit: 671,983 bytes in 152 blocks
    +            total heap usage: 3,843,446 allocs, 3,843,294 frees, 223,7=
61,410 bytes allocated
    +
    +      - After change with a growth factor of `(alloc + 16)* 2 / 3`:
    +
    +          HEAP SUMMARY:
    +              in use at exit: 671,983 bytes in 152 blocks
    +            total heap usage: 3,833,673 allocs, 3,833,521 frees, 4,728=
,251,742 bytes allocated
    +
    +    While the total heap usage is roughly the same, we do end up alloc=
ating
    +    significantly more bytes with our usual growth factor (in fact, ro=
ughly
    +    21 times as many).
    =20
         Convert the reftable library to use these new macros.
    =20
 2:  eee6580c84 =3D  2:  2dde581a02 reftable: introduce macros to allocate =
arrays
 3:  e2d05f7c38 =3D  3:  f134702dc5 reftable/stack: fix parameter validatio=
n when compacting range
 4:  b8b2cce742 =3D  4:  50dac904e8 reftable/stack: index segments with `si=
ze_t`
 5:  2f6a69aa14 =3D  5:  a5ffbf09dd reftable/stack: use `size_t` to track s=
tack slices during compaction
 6:  1ee9a4477f =3D  6:  55605fb53b reftable/stack: use `size_t` to track s=
tack length
 7:  00aeaeee63 !  7:  80cf2fd272 reftable/merged: refactor seeking of reco=
rds
    @@ Commit message
         to read and does not conform to our coding style in multiple ways:
    =20
           - We have multiple exit paths where we release resources even th=
ough
    -        that is not really necessary
    +        that is not really necessary.
    =20
           - We use a scoped error variable `e` which is hard to reason abo=
ut.
             This variable is not required at all.
 8:  31864740e9 =3D  8:  8c1be2b159 reftable/merged: refactor initializatio=
n of iterators
 9:  fd8a1ce99d =3D  9:  c39d7e30e7 reftable/record: improve semantics when=
 initializing records

base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
--=20
2.43.GIT


--ZPsjsrBUQxUYzv79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SSEACgkQVbJhu7ck
PpTSKg//ZBAQC8bAQhf8VYbBz0w+aPNzY6tyFJvcsy51Js4TC8HYX3oYrmfVmd2a
xZyYdTfGvlbzyHlxmbe5DvDfYGMfwIAahl+m0EtoUP6ctoOBzTfZh9RcnT8aZyJi
a0vySdjEdoRGUgZ/RSSa06qXvirm8w4E2b6zuiXCwWYtQyRRUUPw5m+hQ87A+uwz
Fapvu9dBwoVfOUlnO+wsB4LwHVVnaLL5xI6KPcJlhmNBW4WIWNLb9g1U4n8hbHK2
iJRvS4dIRA+rttsVqgsFQODSN4FirL0ptf4BOc72Dh1/S+YrS8cyoRnN282uXoD+
xzLCwU1AIq2lxUVA+QCDI/WxeLt3BPtruiXGbQqegYtaXe7w0OtH/nI8/i6i0id2
vYhBfL4e9xgCi8XT1Mxl4kcSatu3fq+1cf9KDpH7rA7pxIJsrsKrepoPIVpFrTZE
aq8eWLOsD84mY30V7hLARMSqytvTQ03z9z7RXByg1yGLF2L5hBJhKKQr5W/GWhYx
aOEAvqZEwFZL8r/oqr5pwE0q0VoR8R1ajB04VTYamyWKBGGp12GRp6IJkdrYDrrB
WJV0RkZGvBAYKo1KmRrQJGJF6PAma6q05hy49YXlBJbIbQZ8d7H1NLRKbpNLRvH0
t3rMiPvmMYEOel/cK/SC+loO3bOdhF6nCW/K6bQyfrzFagwlXmw=
=K3TV
-----END PGP SIGNATURE-----

--ZPsjsrBUQxUYzv79--
