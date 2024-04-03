Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262914CB4E
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124238; cv=none; b=PJli9QTrLbJq4Ypwp58fcFP/1G1Qd654mNHKVVAKm4PwdW/NdjLW3N+UqNXjpjg/tuJe0qIzMaNVAQVLsfTYhyZWd5hWxxQ3oBRDGAx3o36pPxAjOCn9ZQB8gWfhiJp3GUofj3SrVEOH5R45hVLTXjeOw7ouGzQNCZzNzebqsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124238; c=relaxed/simple;
	bh=Lk1jgJCZPLPdiCGMvVbsBLrGt5MDt5ZzwwFRr3e/PPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8mQ2Em1hMrIOLgVXWrBgYeSUCOMwId3bHb8Iw0Q6tJSrlvQZkoIRwHG0V1UB+H6EWe1t0xXmKKidUVswS+KpUvHVaDqEmhd81FkqY8cDxK22SQke9RTA1jUNnM3nI6x7R/uePzw41bnigNBgkmro+SpLfDkJHyt3KTLiGc9dy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XBeRlkGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tF+iKgKj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XBeRlkGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tF+iKgKj"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 31E841380085;
	Wed,  3 Apr 2024 02:03:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 03 Apr 2024 02:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124236; x=1712210636; bh=ndFblUH1F8
	4HFwaXCuu6IeG4eiimXmdIg3NBgKdwwtU=; b=XBeRlkGsGsVli5bjNFZ7WwGUpL
	fytqjMLEpgi/C4IrKKysPVBDgIc4Ijp+0GoY2gGJyxl2xuxQWZV1+Dlz9QrDaZJd
	WLSy/uKyOM0gfaYgu3EGlY082FfCI0aU02CagbMwbgaR+17+7w9u5a2npQH4d8xg
	2eWfyqWmxq1yWNKbRAox3Tw8Ynt4KGdXcMAhemcyyH4I7/t+Hty/9RoJA5eff0bb
	ntWs0mCS1ediE9Aq4ig9j1nrQPbcVjKOw+qmdnwGd0JHmyIypwoQvJsH437d0dF3
	EQpHUb0z2uHw+UP0gZu+EbQ4Y+1os1tUz+wZrhMmszdzTczScYlpeM+JDxAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124236; x=1712210636; bh=ndFblUH1F84HFwaXCuu6IeG4eiim
	XmdIg3NBgKdwwtU=; b=tF+iKgKjYrhQ144OPqfKKACU/JF0ImafBEYEneUob9rD
	kjjZnvwhu6zKbSsd3gls3ZT5Wed3guUmZbCZh0id4OLALJ8kiaNAjEHE5cs7ogGJ
	N/oIjG2atsT5pbqt6Fbam8QmvIIWo+ETH99x3Hk7I5+eagZs998N5ZUuklrCzxzE
	msdIIY1KPweDTbqPy2FKl7AcCfkXHM5uXbF12SzuYmF2wvdb2PUjCYgU/xeTNhTK
	jabX2h6MJl8PtoovDfbWB+9ggMTa22JPLWFDkt9uGRZU2UpCVPG87t8g7wuPul8F
	iMYX3CPStlOwiJkTDvWpDf3vWZhXx8G7Im+WQ1xhAw==
X-ME-Sender: <xms:S_EMZvdqHoXQ_NZb994GOUEO1YCnCzlLpSNg9HrDzxEMsn6iisoJeQ>
    <xme:S_EMZlORtxfokKE8JV_C45r_45C3QImNlb5GtAcOPDI4fadmaS5dCrSMer7kNtm0g
    B8sr3gKeVBZv8Ft-w>
X-ME-Received: <xmr:S_EMZojKne9UqK1MIp4entfSvltFX6uMcr73Mxb9Uezj0A3Z59ahL4w8Cs3h7CIigirLVqZXjuIAGzjsWqN9LDbJrm9bJOJ7xpvKpgsWVRWnmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:TPEMZg_YaLRPz-8lmdFqq1vie40OofRXAFVHxn8e8qfiimrJnCcqyA>
    <xmx:TPEMZrs82W4b9WcaXZ5TJzOaHHwW8uXUCeFr6rfslYxT0jRQCRKYXQ>
    <xmx:TPEMZvF5WQZEp4kMuJLw7vr3hUJ-hwh7ZZyqSvdlhbnc4ekOFJxHkA>
    <xmx:TPEMZiMDcfLo2_zm5CqA5cTKlkjPA4l7nDdHZn_fzvkpBtqVpFYVPA>
    <xmx:TPEMZrLMwpj9nWBO0XTxvlC-SaD_R5WCJw8YU6BV2jg8nKhT78amEEWn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:03:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8783c466 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:03:45 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:03:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 0/7] reftable: improvements for the `binsearch()` mechanism
Message-ID: <cover.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AbhMkzSQMPIeGFXF"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--AbhMkzSQMPIeGFXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth and hopefully final version of my patch series that
refactors the `binsearch()` mechanism in the reftable library.

There's only a single change compared to v3, which is a fix to a comment
that was misexplaining one of the cases when searching for the restart
points.

Thanks!

Patrick

Patrick Steinhardt (7):
  reftable/basics: fix return type of `binsearch()` to be `size_t`
  reftable/basics: improve `binsearch()` test
  reftable/refname: refactor binary search over refnames
  reftable/block: refactor binary search over restart points
  reftable/block: fix error handling when searching restart points
  reftable/record: extract function to decode key lengths
  reftable/block: avoid decoding keys when searching restart points

 reftable/basics.c      |   7 ++-
 reftable/basics.h      |   7 +--
 reftable/basics_test.c |  55 ++++++++++---------
 reftable/block.c       | 117 ++++++++++++++++++++++++++++++-----------
 reftable/record.c      |  34 ++++++++----
 reftable/record.h      |   6 +++
 reftable/refname.c     |  53 +++++++++----------
 7 files changed, 182 insertions(+), 97 deletions(-)

Range-diff against v3:
1:  baa07ef144 =3D 1:  baa07ef144 reftable/basics: fix return type of `bins=
earch()` to be `size_t`
2:  cbc2a107c1 =3D 2:  cbc2a107c1 reftable/basics: improve `binsearch()` te=
st
3:  f5bf65e0dd =3D 3:  f5bf65e0dd reftable/refname: refactor binary search =
over refnames
4:  435cd0be94 ! 4:  6d4a79f3e2 reftable/block: refactor binary search over=
 restart points
    @@ reftable/block.c: int block_reader_seek(struct block_reader *br, str=
uct block_it
     +	/*
     +	 * Now there are multiple cases:
     +	 *
    -+	 *   - `i =3D=3D 0`: The wanted record must be contained before the =
first
    -+	 *     restart point. We will thus start searching for the record in
    -+	 *     that section after accounting for the header offset.
    ++	 *   - `i =3D=3D 0`: The wanted record is smaller than the record fo=
und at
    ++	 *     the first restart point. As the first restart point is the fi=
rst
    ++	 *     record in the block, our wanted record cannot be located in t=
his
    ++	 *     block at all. We still need to position the iterator so that =
the
    ++	 *     next call to `block_iter_next()` will yield an end-of-iterator
    ++	 *     signal.
     +	 *
     +	 *   - `i =3D=3D restart_count`: The wanted record was not found at =
any of
     +	 *     the restart points. As there is no restart point at the end of
5:  8d8abfd290 =3D 5:  52c238ee9f reftable/block: fix error handling when s=
earching restart points
6:  f87f7ad01a =3D 6:  ca41ad30f4 reftable/record: extract function to deco=
de key lengths
7:  f53bf9e1cc =3D 7:  632f725dde reftable/block: avoid decoding keys when =
searching restart points
--=20
2.44.GIT


--AbhMkzSQMPIeGFXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8UgACgkQVbJhu7ck
PpRVpw/9FvDFRvTwn/U2iBtY9nlnshykkjmgas4tIGy7Zo+tsSFc9E0viZUIW2lq
u+iInIl+r2xCWNsJRjFUU4qA3Wxmg+JCbkfZ9pmhKrP6UvvE9AC0PzqZFozqrK+a
4+UNdc/WZDeFUUEraGmUXbXBEkWWvE/fcm+XHaO/aEm9jDzPh75bYXnMTI5hIsiU
qIoEsB2RoAexvQmgh+jMr1n3yBUZ+Vy1JE/N25P3k/0HKaR0sDqzOkBlS7KlcpOd
BaW2uDj6HtlKWAJ9VAbG+wRL4WDaTT7xB0HXFWNJNwf4A3eeFS/ULdNedB0ECDR1
52Kd0a53hKKWWzeeVHbZZO2+HhjHnCyHoyXu/KJ3BWzeuMOStn+DtG/nanb0z6pu
FYpAVTCwayventpT6alkwFgv323wKU4oXpMKQynDqCi9TMXMgQwXLZ90QYsmOKuM
zQ7LGMUFMbU/vX2NFrr9sj/c1NmkKO39zTxXsBJyEnfkTkm1WT3M788ewKEPW8No
0KraP3z1POhN2JxZ6z0Dt6Rd4TaISMcyGDu8tECZF6rXw37hvKPkmaoGUk6p+SXK
2WCwpaD2t/5QBEaI7M0tFER+/RQ9pOBPTj6cImWfSOkqU4js7SLi8C1LNzBgUxoM
MlJjTWOuA47iIoV6yIDPlhiKVeUe++LYygQ6kkDU5Sq7Y5HSDUM=
=5zBl
-----END PGP SIGNATURE-----

--AbhMkzSQMPIeGFXF--
