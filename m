Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB1168CC
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896773; cv=none; b=OWo0q6X2U1ldeMArql4Cfrrf3TsUWOvObR+2LMI9AVEobJfgqXVE5Jk8OMwo3L2o2uYtIK1Tml/bDWY7hMFjyxN6bLCYba0OlgSjr4i+PZ48+lDeOqgBi1I2IjLh/248+Ofn9o/tvhGXPiTPZUQkr947Ck26cG2e3uH1MOJU+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896773; c=relaxed/simple;
	bh=ANFbczuAsCzg3JpM40ngEaTDRSFc5RBYMWnTVXL1/VY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmKDVXe8EThgu14xqaDZt/TLeqPW5EbKXSULb/B9WVFjCp/cJTeyrepjn2dSezfMglrghy4ht0eFT66zKHXIRwM/QK9uOYLW3DMexQHf+NsE607C9hc03oJqCfDKBYF7LVGfQerocgC8x2wz2pSn40untTfPeqyCa3JtA+p8arE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qjxz9Zyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPncGkl/; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qjxz9Zyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPncGkl/"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id EEFDD180008A
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 14 Feb 2024 02:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896770; x=1707983170; bh=6DNwQUAe0G
	bsWIc89OIwzmdkzQv9bPfw1VVZk+fdVNI=; b=Qjxz9Zyuc5ZYclRIBNmsjGvA6B
	UCGs7RaMzj1vW7zpe51FpevC916w6oFUKsDINWNBkqjNNrD5oGRgt218+Koy2ZB7
	+1B83md+rTYkysTIRtpo1dpvhgUWnjkzegsn9QvCs3sSeBdms4NGoM9PQDJ1GUFd
	b19x8z8v6gFFGEE2rUxXSuBRqILSh8xZD+ak1SrIY+9mOVKG/jo52YncT0gjjVA6
	0WQaqtpwr10nviBmK5j60RAKzKYAmdNINkXjaUsNbpLzNaFwp7TN4ubHeTGIybqm
	KyNyGAEsEVKQgZUObGj8zhuPOhk3I1hYZO8EM3d7hkWvJ2Dv5/1hKMyEIz+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896770; x=1707983170; bh=6DNwQUAe0GbsWIc89OIwzmdkzQv9
	bPfw1VVZk+fdVNI=; b=NPncGkl/5NxXHIw9RqRfIS/k86elg5UoE6ccKdYSGRku
	5VOvL3WNO96rMhr/vGM+X55uh/+3POuKLmVjPo/3QBUg6dQ0Cvc3vSXSWo7CU9pP
	eeIGzO1woVY1vRASFWw6Z14hAJWzAGbBmC577Sh/b8s3rO6R+F5kcutiIMmFI2Z2
	f9a5CGLO+MG8+Gb88Z01gwQi7qfW62g47+WCzZpI40cxYG5lqe/gLqt8xzni2BXs
	Wx3RPovgypIzilylFcHf40XV6imKzrwKTV+JL2JOqfVS9i1K1TFYSH1pLekd6zGx
	Lscb+Rk/qk58JHFdKSzKLhhEBUjbL9cHbEdXNgdLWg==
X-ME-Sender: <xms:wm_MZXPifX6gI3yI4PSkSz6vfquXoj-44lUS0WaNTq2D1sxC-74POg>
    <xme:wm_MZR_ZBrlFgcq3NMui3Y431BAkdU5nj2aTykZSHXSVBfLsMLW5h51DN0cdCPEUQ
    3hXTIotV_03QYhM0w>
X-ME-Received: <xmr:wm_MZWSk8PB2flZFCSsCaXbsb7BotsVJR0EoRRvJ6NCNa3HAJsnLQ9FEgfCVjtdJcCiP8TEMzKmE4vbLEmZ3Gq0Qc0m4movySaKUybyVEmRBtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wm_MZbtCO1OxijJuqjxRyZRfhkldEnfidIVsPQBQjpIdD1s4BSSteQ>
    <xmx:wm_MZfcv15gN8Nm7E2XfE-GlAvX8GxF83C7jlSPe3wqZ_NU0XYqNQQ>
    <xmx:wm_MZX3yUVPF3R1A6D65qTOOp8_uB5OgHQ1I0_h-XPf_HyUuaE2EZA>
    <xmx:wm_MZXHKc27w02w51_lIblb7o0ax3T9igIUCX20zHD9Bzj4FnHy0qaaHew0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:46:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 761a623e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:20 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:46:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/12] reftable/merged: circumvent pqueue with single subiter
Message-ID: <cd65d849a4372636a9827de64b6b35237fd4801b.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LFlgtzcwQQ5+m4kf"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--LFlgtzcwQQ5+m4kf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The merged iterator uses a priority queue to order records so that we
can yielid them in the expected order. This priority queue of course
comes with some overhead as we need to add, compare and remove entries
in that priority queue.

In the general case, that overhead cannot really be avoided. But when we
have a single subiter left then there is no need to use the priority
queue anymore because the order is exactly the same as what that subiter
would return.

While having a single subiter may sound like an edge case, it happens
more frequently than one might think. In the most common scenario, you
can expect a repository to have a single large table that contains most
of the records and then a set of smaller tables which contain later
additions to the reftable stack. In this case it is quite likely that we
exhaust subiters of those smaller stacks before exhausting the large
table.

Special-case this and return records directly from the remaining
subiter. This results in a sizeable speedup when iterating over 1m refs
in a repository with a single table:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     135.4 ms =C2=B1   4.4 ms    [User: 132.5=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   131.0 ms =E2=80=A6 166.3 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     126.3 ms =C2=B1   3.9 ms    [User: 123.3=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   122.7 ms =E2=80=A6 157.0 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.07 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index d9ed4a19dd..29161a32cf 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -87,16 +87,36 @@ static int merged_iter_next_entry(struct merged_iter *m=
i,
 				  struct reftable_record *rec)
 {
 	struct pq_entry entry =3D { 0 };
-	int err =3D 0;
+	int err =3D 0, empty;
+
+	empty =3D merged_iter_pqueue_is_empty(mi->pq);
=20
 	if (mi->advance_index >=3D 0) {
+		/*
+		 * When there are no pqueue entries then we only have a single
+		 * subiter left. There is no need to use the pqueue in that
+		 * case anymore as we know that the subiter will return entries
+		 * in the correct order already.
+		 *
+		 * While this may sound like a very specific edge case, it may
+		 * happen more frequently than you think. Most repositories
+		 * will end up having a single large base table that contains
+		 * most of the refs. It's thus likely that we exhaust all
+		 * subiters but the one from that base ref.
+		 */
+		if (empty)
+			return iterator_next(&mi->subiters[mi->advance_index].iter,
+					     rec);
+
 		err =3D merged_iter_advance_subiter(mi, mi->advance_index);
 		if (err < 0)
 			return err;
+		if (!err)
+			empty =3D 0;
 		mi->advance_index =3D -1;
 	}
=20
-	if (merged_iter_pqueue_is_empty(mi->pq))
+	if (empty)
 		return 1;
=20
 	entry =3D merged_iter_pqueue_remove(&mi->pq);
--=20
2.43.GIT


--LFlgtzcwQQ5+m4kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb78ACgkQVbJhu7ck
PpSbRw//QMXIm0xMShlcEzESpvG52msrIUkHQLMgC/UPdV7E+864RlTtNnwOwaM7
bcDZTRzMjirdS4l+cZuJSerB4p0ngJ0EyT8D1dWK39gXmf67dFLBI9K6BP5aF7eK
T1+p8Dcc8xYauLswXuaLYKhqirJ64tkJscyQtnAD2BNNSUGkijRQLkxierlspfzH
ySkzTYrMS4dKsD0r+x7f13ekFk2Y/9Breld2TlqpUGr0BHboUWjPRkvhIP7pWldL
2XCvcDqdaitQc/2pnlJtyb95bdfAfdIgpuRVYmpw1s+yTaR+qcl4BKiydrnIrHsc
wWF72IsJxu5M1AoEgv9U6BY0duzo6UHdBJY2hQuS0rxcqt6JQsFVTWgUZwMuX+4v
5HkwLqvuPUlTb0DKbz1xB9jFGNZdNLlicJhYZbLjxSXAu+SFo68rtIBK3mOJFEYe
E6CvANSCzZEks0A7Bl2QIt6Ifc4kScgpmgwpjvlLD9rGEBdHvZTiHCq8H7XEzLz6
j2ArlKwlaashYdjhyi38qUOz2csELGa1NW3sTCZzbMe4v/adm6QZvUKTn7pMh0YB
e0lDS0nX/fNXjGIx18E86Z7YYmqfeIUaRZ6y+ISzH4wBKzexeZ/NFTYK26iPtrXG
tIhkM3J0YQiCeIX87jZcrFv1aUmLVZZNU62LWmbFHukK2P2d320=
=tTlt
-----END PGP SIGNATURE-----

--LFlgtzcwQQ5+m4kf--
