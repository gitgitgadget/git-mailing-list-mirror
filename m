Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB60374FC
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549330; cv=none; b=KwS8he/TXR6T5R25WfbiNqaoCZHEBi/ofI8tMn9nurvepLmlQVUQQWC0vvfSSIEpqTRxvZx4gOtK52EqAPdxAGArzIbCpLpz9CNNj8B+i+P7Cu0+yI6HvzzsN+ORDmnWlGnXcbUlfKG7QaFdUpByFuowdIipZTzaqwg2lmAMVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549330; c=relaxed/simple;
	bh=zQITpu8mcI6r1M9HAFT0bvpjkPp/WO+n5IbKMj4KvfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/GD9U4wNJY1bLs1fx4Ce8sEoRy2PbYfHcc+eUgzdqt84pX2cYy8IO9oGc6wZvoHtbmHaCVF3Cjaml8B9Nykf3GC0HliiMC9nOQKMriZAertQxOopZ5xmg3bfFWOVWH4WvO+kQMuTdsM50RpMMGSzNoDGzEULCAkCVV6omfiS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ghn3EZJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyTtCbVV; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ghn3EZJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyTtCbVV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id BD5613200302;
	Mon,  4 Mar 2024 05:48:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 05:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549327; x=1709635727; bh=JHOe3C2vlk
	/Xv+Jsx7I6ZS3j8dzh/ZxX/HCTUVvIg4U=; b=ghn3EZJkhfitImLG4NeBXBaVCX
	hGyKkFCTk2UU3BJZkH23xL1sDeZDxUWs2pBMbDQE8brDX5zwpO63pZ7Xk9hyivSg
	bqgX1DLyiW6GePJm3aVyg8ik00FMLybjHlyntgpvg/slfpz4EXv77MgAarGZf6Jy
	Q56A4PkZrROFKD59sv3BJnv5bOmcIpizhyaKmHmwesDJkUDnpxfqtgMiPoMAztGh
	Ac3Ob63Qsgjvr6QsNATj6QjV8ROQNfvjiRFCnqsDVKpSqDykpD3TErF6G7f5EY5I
	OBeBFyqSvXb9uy6o9Nw73jGMXBw+2KJEW4glAiCEobsof/8FXzbuw6yVy+sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549327; x=1709635727; bh=JHOe3C2vlk/Xv+Jsx7I6ZS3j8dzh
	/ZxX/HCTUVvIg4U=; b=EyTtCbVVVemc/IBRnIH5mtTCfuEfKweDNZT9LVlt0r1U
	xOgudQX3SFiOuqhYA0X93Gqa5jPv+ewgPRgtpdGRL5jJmY8z2RLCHddgGNG0+DFX
	45qSYCNXZHb6jqVVEQI6CS6a2jlgoJr6LzfkVfbEYQXz831vqpDDZ9x6fwI8486V
	dORS6ViNIjLIRHCfRAfcLFLFFl2RvVdhQXtFvPVsI8hZlCxpos8uCTwFLye2dgPA
	pdfLsmxRL90Y+V5bFdNr+cG7rdKdNjXLpPsaVNfDttW1xQ8nbzcJlVfb9ZpU2/EI
	en340yPgtMOeHHGM46DZvBlFD2hwEg6/2GEd466YXQ==
X-ME-Sender: <xms:D6flZYPR1568Oi2lCbrvKbdoEeN7DdoUn3pWZyqyWTMMQnHPXVLzDQ>
    <xme:D6flZe8C2o5QUGRG-LFKDYoJBBrB-LR_4eIfuo7IB_WPuSPJqraRVeGN4a5AAQloE
    RQQouS6tSwZ0eh0cw>
X-ME-Received: <xmr:D6flZfRRKp_jizqLqbcU51l7VmFewacnEScQQJm-EzSMh6L88nxDfNM8Wu9PVSKy6L_MjCue5BAQwW12Hh9zufR-_Og8jO9dmd_JDu4kSCpPy0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:D6flZQuJeTSPEikyWV79w503gUt-H3MvW5VGba3kPPA2uKBAs6nHbg>
    <xmx:D6flZQcAR6UKdzqu1JBrBVwmNqwcm_CrF8Iy0NrQqbCs3BYYJ_dxYg>
    <xmx:D6flZU3pm8IPUOcwnWyIGpgLvByaSqD2pf0kxo6ndgfUdYPGJR7XxA>
    <xmx:D6flZRpn-X3Gz1U1lef0tVMEIgoAHNKtp3SEXNQ0FeJJ9_Uw4LkDEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:48:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 363ec7f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:20 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:48:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 00/13] reftable: improve ref iteration performance (pt.2)
Message-ID: <cover.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YzPrmv6+zAND9PmV"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--YzPrmv6+zAND9PmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that aims to improve raw
ref iteration performance with the reftable backend. Changes compared to
v2:

    - Reversed the order of the second set of `SWAP()` macro calls.

    - Fixed typos in commit messages.

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

Range-diff against v2:
 1:  292e5f8888 =3D  1:  c998039333 reftable/pq: use `size_t` to track iter=
ator index
 2:  95e1ccafc4 =3D  2:  cb144e28a1 reftable/merged: make `merged_iter` str=
ucture private
 3:  0e327e5fe3 =3D  3:  1bf09661e5 reftable/merged: advance subiter on sub=
sequent iteration
 4:  494d74deff =3D  4:  9aa1733aef reftable/merged: make subiters own thei=
r records
 5:  0adf34d08b =3D  5:  b413006159 reftable/merged: remove unnecessary nul=
l check for subiters
 6:  01152ce130 =3D  6:  0ab1be740e reftable/merged: handle subiter cleanup=
 on close only
 7:  370b6cfc6c =3D  7:  2199881d47 reftable/merged: circumvent pqueue with=
 single subiter
 8:  1e279f21e6 !  8:  04435f515c reftable/merged: avoid duplicate pqueue e=
mptiness check
    @@ Commit message
         down the stack in `merged_iter_next_entry()` though, which makes t=
his
         check redundant.
    =20
    -    Now if this check was there to accellerate the common case it migh=
t have
    +    Now if this check was there to accelerate the common case it might=
 have
         made sense to keep it. But the iterator being exhausted is rather =
the
         uncommon case because you can expect most reftable stacks to conta=
in
         more than two refs.
 9:  15a8cbf678 !  9:  92f83dd404 reftable/record: reuse refname when decod=
ing
    @@ Commit message
         to the required number of bytes via `REFTABLE_ALLOC_GROW()`.
    =20
         This refactoring is safe to do because all functions that assignin=
g to
    -    the refname will first call `release_reftable_record()`, which wil=
l zero
    -    out the complete record after releasing memory.
    +    the refname will first call `reftable_ref_record_release()`, which=
 will
    +    zero out the complete record after releasing memory.
    =20
         This change results in a nice speedup when iterating over 1 million
         refs:
    @@ reftable/record.c: static int reftable_ref_record_decode(void *rec, =
struct strbu
     +	SWAP(refname, r->refname);
     +	SWAP(refname_cap, r->refname_cap);
      	reftable_ref_record_release(r);
    -+	SWAP(refname, r->refname);
    -+	SWAP(refname_cap, r->refname_cap);
    ++	SWAP(r->refname, refname);
    ++	SWAP(r->refname_cap, refname_cap);
     =20
     -	assert(hash_size > 0);
     -
10:  35b1af2f06 ! 10:  eb600f3bf3 reftable/record: reuse refname when copyi=
ng
    @@ reftable/record.c: static void reftable_ref_record_copy_from(void *r=
ec, const vo
     +	SWAP(refname, ref->refname);
     +	SWAP(refname_cap, ref->refname_cap);
      	reftable_ref_record_release(ref);
    -+	SWAP(refname, ref->refname);
    -+	SWAP(refname_cap, ref->refname_cap);
    ++	SWAP(ref->refname, refname);
    ++	SWAP(ref->refname_cap, refname_cap);
     +
      	if (src->refname) {
     -		ref->refname =3D xstrdup(src->refname);
11:  d7151ef361 =3D 11:  f7915f1df8 reftable/record: decode keys in place
12:  99b238a40d =3D 12:  527c15e5da reftable: allow inlining of a few funct=
ions
13:  627bd1f5f7 ! 13:  de4a1e2239 refs/reftable: precompute prefix length
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(st=
ruct ref_ite
      		}
     @@ refs/reftable-backend.c: static struct reftable_ref_iterator *ref_i=
terator_for_stack(struct reftable_ref_
      	iter =3D xcalloc(1, sizeof(*iter));
    - 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable, 1=
);
    + 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
      	iter->prefix =3D prefix;
     +	iter->prefix_len =3D prefix ? strlen(prefix) : 0;
      	iter->base.oid =3D &iter->oid;

base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
--=20
2.44.0


--YzPrmv6+zAND9PmV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpwoACgkQVbJhu7ck
PpRD2Q//a4lkt5C/VQHdUurwuesFlgN76jQzmbUHiwk1duVssEBxglsHitNJS9tz
PAglMEF9WTP7jCEfE2TfheZvxJG+oO9N460Ojkt2hVeYQhWosuHKUV3eSUFJ7zhG
W6qd32bnMynQvPfNfgzajHnHybMKU+uLioQFymJwQTH/CeOm1IH43ahKxRt0gg4x
ZJVaObiYRqJm3i20BzBwARVqqBOmtgPHchrY5to5nOSdAKZcNbDrIMJfJTSw0vD5
QlanlG+JEzbRA8mAEX1dFt851AVFGjVfGQrfz+cd0mVvt5z3Ywr6ydBmbRaxEPNy
IHhTll1zpzoUYxwBLsinlMY9WEAUV84u6zhe16x7gX5hCJ1hayOscblvv1z8biPj
TWB/3SEYvOnyM0lzS8pdRzrhTkKTbUGzWxODA1OV/ndzkcPY2yHpTA7Q9jeUzc/f
jBuvLIaI6bEqpV6vJFk1rt/JpARtzYLaiH95Q6ph5IzJWOuiwiMd3hN75qap6iU4
WOWAQWGmx6OvFTwkbXXN4eQaDqBHe8YdjHw8ZHfkjF8U+YYz5VhzGOV77PjM1Gzh
PzRVpUpAlshMlSWhTLeLqda12ojVoNcz7EmA76OXE1zFFcKYqTcMstu1yTGEJWgW
t1qqFYIhxdhOAHg6ws6MNCuzEnjANUnlg/Nr7oN+Q05IwwkRmWg=
=XN5w
-----END PGP SIGNATURE-----

--YzPrmv6+zAND9PmV--
