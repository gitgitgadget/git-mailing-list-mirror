Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5EE152791
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327311; cv=none; b=YinuoH1gNEh/6ysSwBRMxHV83hOVNJup0iN8HIQzVODcn6XSYZEUQdhqe0dvURowj7aF0PZM2fK/Ki352mOTx9j9w+FJbpwP/zz8CSVUQvqNLy9uLy+WS9ti3lN+Uv06noWJe7eQourCjzhYCv7n6kJFdev1a6jr9NeOFsYQNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327311; c=relaxed/simple;
	bh=DLkjStK97WoB075sJeWlrz1ih7ti9oBQfk8v2Dj4TTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdJB1zJZGIIATAXTLWoEOPBe+NuRL5tmw8ULvhF8CSJ0VYeZZB3UF1fGD36tpl16l7WDAaJymEhVIFBdL9XEEtru+4g5++WsYfdnvqUl3eilUynw5u00LxDu4E6f9366kCo4RAu0LeLuz1UBn6qY/CNWGygbf07PR9lHWEkewC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=peu5tIJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=asq70YIy; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="peu5tIJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asq70YIy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id E4CBC18000E4;
	Fri, 10 May 2024 03:48:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 03:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715327308; x=1715413708; bh=gDYfXa1rtA
	cUM/8mQqs0oIVvqmFAzTU33GBXplYwFVA=; b=peu5tIJci91hVFrUsimYezYXLr
	FBcCfdiZbTUdoZrqy3wG9Jkzoi0LJoZ2FymQAmchzlbvzo08RkELF49Q/uDjIeEs
	8J9lhoyOEji3xd3UWw81i5IHAyFSGFU+SfAIXQv5XB/bXk146CmMMznUm8k/blpW
	1LNjMVfZ9yIuchTGLhXvv0+b5V/VGGviNLcKAOiXWyX4dOE31I2HavX3tnuCvK7L
	ov3cMRFUDjoGP7K8hkM+T3HLhZXch9M1i1A862XjcwyQan9/eYdloaWzj/vkPtx9
	lY0Ml1/uBYbJ7ozZvcQV/ikAsJFg7BvdNtyHmOf4100xqFsKHObRTsb4zO7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715327308; x=1715413708; bh=gDYfXa1rtAcUM/8mQqs0oIVvqmFA
	zTU33GBXplYwFVA=; b=asq70YIyW87lN0NBpA/jPHMIsUIeFgSR01d3ikeFcrUe
	Vc3SQc+dpyz80BHWvbWkNXiD0+fwltcCvmKj758JZ1RpgttqovbFHjZhSnX3qOjs
	hSRTGckDjvSVHMQr91R0Iit3aejCdUbOBuqCc5Sds0lYSaxd5Wuy4OhYpy1P8rp6
	Dv790X0li4siHWIt+UwKlxu2+JloMAJxbcOhwpMyvaWRV01HeozRK70MNqaGbT8G
	FDn014X9Tpl7Jr3+hCVrT8ql3G7f5cYFWyw3fpfi3CwUuuDFoIgIOzl5TXAR4T8a
	J3jVNO8tE6sUYxS9x2Zro2C89w+xwyFy8bAcMVnZ9Q==
X-ME-Sender: <xms:TNE9ZhYUBWTrYi1leehho4A7P2Tv768-4Rt5w8ijmz_kfIw3DEdD2A>
    <xme:TNE9ZoZtcwa2rRTIQy0wMm9Yz1LgAx0CKR8dKWZQ5iPSDsTiKq5LdzQC-WvuG_EB7
    7BYNSrRSQmzpFmmkQ>
X-ME-Received: <xmr:TNE9Zj9edJZUnQqa1ukV4hpDLX3RkAk4msY4Y7bCyyjhYDzO_KH_4xtpLHfIpLkn8chnAp5j0SKW6NzBsCDqyNsT03GHh5OGvEomAb4GdTG7ENsoIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:TNE9ZvomMGUcyk84sVpq4AQV8TAur0NK7mIY5aByWIiWkcQzR--3NQ>
    <xmx:TNE9Zsr4QE_vCqTWRvDn4jsQdwGx17Blq6dCe5CsqeV0ElhM4Rkv5w>
    <xmx:TNE9ZlQGTiVteXnnsBLridR1us1SrQVtjtEwM_LMX3XXZMZg_HYLZA>
    <xmx:TNE9Zkq79Rt2PG8K--RyivPDzz2nblZYWhACo7almzaOULkcVcq7qA>
    <xmx:TNE9Zj2V4rkZgpn2jxBl34_dM5ucygxw8dE9X6gnKEq7Ng8yqwGt5uWy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 03:48:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0d198a2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 07:48:13 +0000 (UTC)
Date: Fri, 10 May 2024 09:48:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] reftable: prepare for re-seekable iterators
Message-ID: <Zj3RR-I1v1XwSuJ-@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <xmqqwmo3x44s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Ud/wqMcshD7GEAq"
Content-Disposition: inline
In-Reply-To: <xmqqwmo3x44s.fsf@gitster.g>


--0Ud/wqMcshD7GEAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 04:42:11PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > To address this inefficiency, the patch series at hand refactors the
> > reftable library such that creation of iterators and seeking on an
> > iterator are separate steps. This refactoring prepares us for reusing
> > iterators to perform multiple seeks, which in turn will allow us to
> > reuse internal data structures for subsequent seeks.
>=20
> ;-)
>=20
> > Note: this series does not yet go all the way to re-seekable iterators,
> > and there are no users yet. The patch series is complex enough as-is
> > already, so I decided to defer that to the next iteration. Thus, the
> > whole refactoring here should essentially be a large no-op that prepares
> > the infrastructure for re-seekable iterators.
> >
> > The series depends on pks/reftable-write-optim at fa74f32291
> > (reftable/block: reuse compressed array, 2024-04-08).
>=20
> There is another topic on reftable to make write options tweakable,
> whose addition of reftable/dump and reader_print_blocks interface
> needs to be adjusted to this change, I think.

True, I forgot to double check that one. Your proposed resolution isn't
quite correct as we now leak the `ti` pointer -- `table_iter_close()`
only closes the iterator and releases its underlying resources, but does
not free the iterator itself.

The below diff would be needed on top of what you currently have in
`seen`. In any case though, I can also resend this topic with
ps/reftable-write-options pulled in as a dependency. Please let me know
your preference.

Patrick

-- >8 --

diff --git a/reftable/reader.c b/reftable/reader.c
index 2d9630b7c2..83f6772e5d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -841,8 +841,8 @@ int reftable_reader_print_blocks(const char *tablename)
 		},
 	};
 	struct reftable_block_source src =3D { 0 };
-	struct table_iter *ti =3D NULL;
 	struct reftable_reader *r =3D NULL;
+	struct table_iter ti =3D {0};
 	size_t i;
 	int err;
=20
@@ -854,14 +854,13 @@ int reftable_reader_print_blocks(const char *tablenam=
e)
 	if (err < 0)
 		goto done;
=20
-	REFTABLE_ALLOC_ARRAY(ti, 1);
-	table_iter_init(ti, r);
+	table_iter_init(&ti, r);
=20
 	printf("header:\n");
 	printf("  block_size: %d\n", r->block_size);
=20
 	for (i =3D 0; i < ARRAY_SIZE(sections); i++) {
-		err =3D table_iter_seek_start(ti, sections[i].type, 0);
+		err =3D table_iter_seek_start(&ti, sections[i].type, 0);
 		if (err < 0)
 			goto done;
 		if (err > 0)
@@ -870,10 +869,10 @@ int reftable_reader_print_blocks(const char *tablenam=
e)
 		printf("%s:\n", sections[i].name);
=20
 		while (1) {
-			printf("  - length: %u\n", ti->br.block_len);
-			printf("    restarts: %u\n", ti->br.restart_count);
+			printf("  - length: %u\n", ti.br.block_len);
+			printf("    restarts: %u\n", ti.br.restart_count);
=20
-			err =3D table_iter_next_block(ti);
+			err =3D table_iter_next_block(&ti);
 			if (err < 0)
 				goto done;
 			if (err > 0)
@@ -883,7 +882,6 @@ int reftable_reader_print_blocks(const char *tablename)
=20
 done:
 	reftable_reader_free(r);
-	if (ti)
-		table_iter_close(ti);
+	table_iter_close(&ti);
 	return err;
 }

--0Ud/wqMcshD7GEAq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY90UYACgkQVbJhu7ck
PpRqLBAAhPz+J7lRgT8w84pWuimUqYP7f6vuGRoFQx6kf9OSZGHcAT/c8gwGtCgF
YfuV/9Uq7ABRyCrBh6ogLKP7j/ehhUH0tsgPR50pSBeVUMwcI2h0cn9OCy7LpVra
OIG7QhMGYJ232YBJIragF8PRX1e1oAnUFVflf/XXpqCRhQ+Sc/H0gE1dkuZx7OY0
Hnouv91Jq2GGPziWt0500guPqgVlLMBDA4CA4dMqewEgxYTPFiQDkFd6ioZsM9Lq
2I8EdvQJTRs9bAe0++1xKeEiqFyqIK0Yhd5V0SmI4n/3A8FS04SMlc8/z7EylzX5
bH8vBEtrnZS29jngzN/utrLF3kzsybnSSZTTxzuqsOcboiDtNEuPDfxGc9T3dtEP
n76834z9DTUPETpfBkEH35iwlB1m/Gshw5QbRZGPT2s2QxK6CfpfjjcRNcQZVeHF
7oueCavJorbvkvyUxe7ofXi/NuEiPQnAoQYzmMCGikbq6ZRtmb0kSbPYbb/WnDhF
cM2Zoi0Rkno60bjmeoACR2ILpc3GIYVpKKVS86KwFLgcJSBto94GDAf0R1EbJfXR
oZ0nFxsLSayE27nStTm9R12zc33FkOW7xOIa43NtBclfYbvMeWPiNcE5PZfpWHRu
4c+4K7hvx9v5zKnwyg20i1J2mbAIxKmTCgCo0IWbl+9ZYXdaqnA=
=rWLD
-----END PGP SIGNATURE-----

--0Ud/wqMcshD7GEAq--
