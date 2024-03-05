Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E57484
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640658; cv=none; b=qJnKVfUE4IszUnmL3j5gkxPW66OK87cKmLWpp0nzUSCsgYIvh+7kQjseFCmhyGP12Ytem6Tt1Wc8Lpu0QVOviGibbZDILbvy2mdT3E/bHVqF2Xg5T2GRupFBQkYUUjfo11NDTftKPeY114bQyUq+2VJHCZy7Xh03Swy52Q7Nl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640658; c=relaxed/simple;
	bh=L7WAhVrjxQwLJ3aibG1bS4BSMT/ZbdXNIMK9tHC39CI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dFB4IYdbzTR43aQBloONaNwfExtqDIEnZtzxeTNA4WeW3wIL80BG3LFczlTxVy2IANqAT3wx3EahQ4ZA3QuX8d7MPK5Nz/nRTMMgvm1B2U8tDj9ejlnOzWXfqkRkWig+htyR2U86ZBBVBTN7r5pIwsaS6hIVXAMSHNe3Wmz444k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XKkfXrHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WkaF8FA6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XKkfXrHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WkaF8FA6"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 23C7D13800DB
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:10:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 05 Mar 2024 07:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1709640656; x=1709727056; bh=URxyDvjZ3GJGgpXa2zu5+a3pbQ2AkoDk
	/fAQRH+EkgA=; b=XKkfXrHNtJ0xGlt/diC3UbjYWCbKFDpGuTBfjxz7SZV9FI/2
	NkcWYncHVs8hg7yRHveYlTSJoiit6x4Tm9bZnmltWkYMK2xYDWFfoRtSZ0rKVs/5
	EIE5zn/DWQ37P7UD4cwo5FAkFZtC4ENoWfn6mB2WII8QCjXKPa85d7Svj/p1RDZl
	DVMua0alqPZPtp2HoisYVtDMab8jOYcCsIguwijdZUoKDxMsP62bTETlKlAzQTmX
	PvfJ5+AbMFG7m72EYzHeUcXXu+zHzX2OCJaiGfL7IwKq0HmmtEp3YK5nCV3iv7eF
	bP2jBR2E/f+6s8r25fG7sqy5i5e9ZZFA2L9c4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709640656; x=1709727056; bh=URxyDvjZ3GJGgpXa2zu5+a3pbQ2AkoDk/fA
	QRH+EkgA=; b=WkaF8FA6YyKfs7TaG68gTuXiHd8khjVTCHzjQQE0hBl7TSVEdP7
	tcwDnJtuuvExdxvc+45iFL6bA6MX5uD1FGG383Kvxq8TmRxyPCKS5lsnR5VCWtTV
	Eb94f1HexZXe3k2qBbFClmxlI/hI/QGw9iETSk8UAKuekZdqwNOzQd0Qq/GHZr2L
	Eyb+UMxTsU2pZ4rXlj62Gz4B0kHGSWWoIrDnG9oZyO8SaVZop9SQt26SVAv12zFA
	hM0e2MSJCdV9YKuAyg6I+wneYZz4gXmTLbkN+6iAJESlZ7fNDeYY2Nv2KJ5RCpKL
	AhTOcXGUhK15Bf7VICoApPDMwEzCZTDR+Qg==
X-ME-Sender: <xms:zwvnZYQwWr6HrLRCK72uXxLqsn5w7kFnPHKURe16cNSVEKgBs0EWYw>
    <xme:zwvnZVxco41dseJ596Djm-DMhVxLKMCeBZCZMmZ97APixhUR_4QBKLQFLymi09U0B
    kylb08btZJlcacQuw>
X-ME-Received: <xmr:zwvnZV1TufcUT5bVUKCQJDdy4Iv_fugeSivxUgCX_wy0zPIDhkM5EEuBFM2PFbQ6mHBwKZuzciDIqTIG5PheBgTIXi2yVXBlNkKyER5H2F8o4Kk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zwvnZcB4bb8fwhclbUluazj1vfnyz2xzZHMJT-wHlGIsg_OpXxCGXg>
    <xmx:zwvnZRiuXOnyYzie35Xu-0uEHYoryqe3Op5cUqYjGRhVX_MH0Oh-9w>
    <xmx:zwvnZYpM5m_tfpcsbsHHyl4xwuPzkUT79xprITYuaJ_B6SsmWc93WQ>
    <xmx:0AvnZRbcMnrvYloiHxggtz_WDB9u40w-lMZYRVN2s0-AIWtRqaEb-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:10:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7631ab8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:26 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:10:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] reftable: memory optimizations for reflog iteration
Message-ID: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F7BLQLs59oDBLJPE"
Content-Disposition: inline


--F7BLQLs59oDBLJPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series does the same as all the preceding patch series that
optimized how the reftable library iterates through refs, but for
reflogs instead.

The goal of this patch series is to arrive at a constant number of
allocations when iterating refs. This is achieved in mostly the same way
we did it for ref iteration, namely by reusing already-allocated memory.
Overall, this brings us down from 8 allocations per reflog record to
essentially 0 allocations per reflog. Iterating through 1 million
reflogs with `git reflog list` thus goes down from 8.068m allocations to
only around 68.5k.

This series is built on top of "master" at b387623c12 (The third batch,
2024-03-01) with Junio's "ps/reftable-iteration-perf-part2" at
43f70eaea0 (refs/reftable: precompute prefix length, 2024-03-04) merged
into it.

Patrick

Patrick Steinhardt (7):
  refs/reftable: reload correct stack when creating reflog iter
  reftable/record: convert old and new object IDs to arrays
  reftable/record: avoid copying author info
  reftable/record: reuse refnames when decoding log records
  reftable/record: reuse message when decoding log records
  reftable/record: use scratch buffer when decoding records
  refs/reftable: track last log record name via strbuf

 refs/reftable-backend.c    |  52 +++++----------
 reftable/block.c           |   4 +-
 reftable/block.h           |   2 +
 reftable/merged_test.c     |  11 ++--
 reftable/readwrite_test.c  |  62 +++++++-----------
 reftable/record.c          | 129 ++++++++++++++-----------------------
 reftable/record.h          |   5 +-
 reftable/record_test.c     |  68 ++++++++++---------
 reftable/reftable-record.h |   6 +-
 reftable/stack_test.c      |  26 ++++----
 10 files changed, 154 insertions(+), 211 deletions(-)

--=20
2.44.0


--F7BLQLs59oDBLJPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC8oACgkQVbJhu7ck
PpRzzQ/+PinB0huahyW+U+OrLA+9iU81+TmZAq7olov0FRjUEaGg9aC9N/aXkjYA
iCkS3c/kLpGi3MGkNmQ9zQ4oS3CQKbIK5ASpzrjJ3bt0rJTJzS1L4xu2/EN5v0/z
EzwACLnOciznKuq6ZtA8KQhkN1MtDBlmDime/mxKYvRzs5j/necvpD0bNOgL+pGK
4jQD/34auBuoxUwNPKutjqJN1JgqSxqljdmaWOyXSAnVmPiLh5KgEVdXH5FJXI/c
loi1B4IhT/gu+myhIdndMCRgQEedfaPXQFN4Lc6hVZ6nR1Fcit4xeJNobrJs5inH
mxQexwL2XVJysAooIa0c3UlThFJOOqyIljEPgZ2lW0+8HUHX9aCoMU/w5SOtU92O
jvfACyBLJ/h2XPEGBufPlPFLPVuzubEMGBPdZODL52vInRz6cgF9Uv7xBbWFjMvz
BDuzNI8ukgtTXdzgE0RXK68Tzsnwjg0Zv0f3GJjYOylCXy3zSjGKaSsGyJm7SgWq
NPfXmKNNYuZX1cE4MfiCni3e+aFKY8ZVFSG6ytTqpFZ5ld7+tsH6U+KQmZWKO8yx
p3Lrt6za4jW5g4B0bKJ7OXozyp03qZMZjooP+ILZKZp466wxlsTYztQ6tXH/Ztpl
i0aQwlfSU2Yaf7rmO0AKLh939TFbjteXhF+9DOEb8rh4uEhSKyM=
=43sU
-----END PGP SIGNATURE-----

--F7BLQLs59oDBLJPE--
