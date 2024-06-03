Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E57E77B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407570; cv=none; b=X1lNj0FYWnwglHlUXZU6Jlq+6O0Uy30xzlAwdNX+lZHjq+MTc+VofQjdQ4lL+5c91ygsyv74+eoKU8Ffj0LCNUhPVGBoAXWml7HTgxywWARp+g+u0cz8ClPelpvp0IUPmEK7BGnotNbfjbMEbX4oboIVDbHTRpv5+dYcRD0rGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407570; c=relaxed/simple;
	bh=R4E+xpBTYYk125oTk9sm/fpalXvkfaKu3NHWfvUxfZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4RzVZp8Mt54Su/UaC42ZN4H0SJEw90KXnVPz8Bxq5LNaLCCbbe0pyftHHJ06ytkhVVVFSLW1n8FiGZzC9OLKUFKCcnkv6irAl0fOyDJFP2sjxpo4VNDx8a9KizbyxUloLLI+xSbet44aXlAgPxHL1SRs2OnEmSD7gYHkC+jntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmukjxOF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYZPVDDd; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmukjxOF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYZPVDDd"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4AAB418000F6;
	Mon,  3 Jun 2024 05:39:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407567; x=1717493967; bh=VNRVMQLZlX
	IR2clCiWnjTFvM6zr6DKOp1lTLOYYTvx8=; b=OmukjxOFxqCFOQRE7KfBZmS/QR
	1xgdS2PhzZ3U/noOypA6Vc3cWz9CpjI3FqoScRxC3Ajn1fRHKL/RqoIXSCaTeZpW
	Q4675amnq+h+bNknNwKFgfUV1ATNx4OE3bNg35IFJ0DUF4j5pOy/DqS+OI0yFqRP
	z7e/sVFwcRdczj2n2a+V76HerXtxe9TOu8X0LVTcNmGfrg3L1cFiJ5ciUfqik4yC
	b61452WOGmgXWxlpkj23QG4XZBabZocDZTHipRmKFUxoOOa3oA2nA+j1HHcFFFi7
	Svi5NqhhjGV9tM4nDzgSat0rDwvGztRhu1998OZr/RGod7m2TH0ChPdSZAnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407567; x=1717493967; bh=VNRVMQLZlXIR2clCiWnjTFvM6zr6
	DKOp1lTLOYYTvx8=; b=QYZPVDDdWyf/RWvn6EVi2WRv9CETCO6uGXvHvIEhNKFs
	OohwyWGqwPDkeE4ibN6mSFP7S2ksymIKQzc7WcHBFX90ZNGrhW5VCTaYs0PQiUXF
	rgUG8OnIHLvL2pQf31qYHDiPZRbRUb/PDUqHkfHyJcbyQ+H7rxrOt7Sv+Z46k6L+
	wP8JWxamotabcNS108yzU62QZejEou2ARHGSGEk3KtLHstLn3C6P3TpWbb+fX2vU
	ZNLx67F8+P/dYMTdCGG+FxBW1tPBfmc6T4g4CF9MgXhRV13pyW+vKUkeIYsKnXSu
	AuVK/zRgZkYBVvkFDpvkHdvzOwdoPoMZFEEOSv//gQ==
X-ME-Sender: <xms:T49dZuALZJrSDnuTBb85TzLqrSe2RruCmPKa9hwo7u8buaRqx5WYJw>
    <xme:T49dZohquhm3n-5hwFvDqzM8P4GeroAx-_G6pDpSNg2wHkyy55YNK74P9wJ5CfQGa
    Dm2EpJeG505-9XpEA>
X-ME-Received: <xmr:T49dZhnk1YzLsZaIUjo9xiuE76pNfqOvzBpJnF6SNrUqW-ZAR7DjZKObf36gYyeSnVNBJTmbhtl7q3jLvKHnMLRYV4xgyzcSMu_YAAurLF5TeMx_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:T49dZswA8FtuAUG7quFj1hend-z6-4vOLq6pBfnQfYPqvYMuh0iQVA>
    <xmx:T49dZjRjO6bU7PzgoCyNtUE10Cg4DHLi4RqqkVATS462Qhfe04-opQ>
    <xmx:T49dZnaRQC8VxDKuIxrNz6u4mhxlAD0b1HerdXX_0hfRS1hChxF5BA>
    <xmx:T49dZsSEkwBOqFIrijMoG4aEHojoaWlR2eiborz0KsWZC3rxW0xUTg>
    <xmx:T49dZtdvYWf3Fo_cNH6CCIn5719mBUEKLT4zmJrT8ASetdG0Qnvawf2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id da4773a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:02 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/27] builtin/remote: cast away constness in
 `get_head_names()`
Message-ID: <6a3c8d351e9defcc3b700761e96c8f29f2366df0.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R4NIN6yRX1c5O0Zi"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--R4NIN6yRX1c5O0Zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_head_names()`, we assign the "refs/heads/*" string constant to
`struct refspec_item::{src,dst}`, which are both non-constant pointers.
Ideally, we'd refactor the code such that both of these fields were
constant. But `struct refspec_item` is used for two different usecases
with conflicting requirements:

  - To query for a source or destination based on the given refspec. The
    caller either sets `src` or `dst` as the branch that we want to
    search for, and the respective other field gets populated. The
    fields should be constant when being used as a query parameter,
    which is owned by the caller, and non-constant when being used as an
    out parameter, which is owned by the refspec item. This is is
    contradictory in itself already.

  - To store refspec items with their respective source and destination
    branches, in which case both fields should be owned by the struct.

Ideally, we'd split up this interface to clearly separate between
querying and storing, which would enable us to clarify lifetimes of the
strings. This would be a much bigger undertaking though.

Instead, accept the status quo for now and cast away the constness of
the source and destination patterns. We know that those are not being
written to or freed, so while this is ugly it certainly is fine for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d52b1c0e10..b44f580b8c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -493,12 +493,13 @@ static int get_head_names(const struct ref *remote_re=
fs, struct ref_states *stat
 {
 	struct ref *ref, *matches;
 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
-	struct refspec_item refspec;
+	struct refspec_item refspec =3D {
+		.force =3D 0,
+		.pattern =3D 1,
+		.src =3D (char *) "refs/heads/*",
+		.dst =3D (char *) "refs/heads/*",
+	};
=20
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.force =3D 0;
-	refspec.pattern =3D 1;
-	refspec.src =3D refspec.dst =3D "refs/heads/*";
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -507,7 +508,6 @@ static int get_head_names(const struct ref *remote_refs=
, struct ref_states *stat
=20
 	free_refs(fetch_map);
 	free_refs(matches);
-
 	return 0;
 }
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--R4NIN6yRX1c5O0Zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj0wACgkQVbJhu7ck
PpRXohAAowhjIlr5qhjtjUDereRhrdp0s22n+QsqglsyXC2XFqa9o+bjarwvcayS
22joGinjQf6h5fgX+MSWsOJxBZZbNM/V1Kz6qS7M875WPE5d9bjAmtf2vu4Gr2ub
T2FeWETav1h9MosF1WR+hGUKLB70o0ZM16Ik9d3YT2BqMIC4in9VjdCuzbIksnzn
eamnBy6uFLNcB8w5cCdlZhJ1KyeIcp+8Lu84FH11Bu9GuezZxZN0vN9hIGRmhDDx
zNpi/mR5Qdx6b00U5HR33JfskA8RLhAhwkKnzdNlYGSlvsiYGAzVqZd9cUBfUBM3
DvbSz0acn0kdbAB8PAdVMNn9tEhFtHHq0pHJ5w/rAwgqbZfBpYJb8jSbgjV1BGAB
G7g4voFJ6oEpK2wLifTeU5xB66/tauLNWqGe4qWd1hZE2jus5nzB9JWscRfuFOWD
PzLrA1ctInBN23DyGMAHaIhkHIo9AmrQ7CEU3LeWs3tHol8CFKk6KQxugOvBwCjm
NYhtkgMvRDJJOmw6PUpU3k742x+57o+K+FmBskS4Z8K6e0g4LbCVEqrvnzNoHCUT
bxGgTRV5ZpDQozDGso0BvHd6GemjfOGrkuhqkwp2nnL7V6bFov07DcgVmU6E3Mdb
DanvwT59S4adujRfeHvNDQl8Yac//FZyrR54pYj+0avGok20sss=
=BIR9
-----END PGP SIGNATURE-----

--R4NIN6yRX1c5O0Zi--
