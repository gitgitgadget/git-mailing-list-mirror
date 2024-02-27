Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F71482F1
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046408; cv=none; b=uZVQCX5Og2+qA24MBB+5L2tDnhU7Y+S2CXZVOexCMleyj8KijmxpI1xvEY+aOSXefVa5sPfXLGyhzt4zEr8RbbFsa52U0VaIqUySHsPvnR6JHv5AxpafBlB6Rzv+gXktHkwg80pmKVXSgIEI8alcn00DxX8doPYGRg32X4eEdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046408; c=relaxed/simple;
	bh=AxAvG4XSp/AiugBMO6zPZSQKdR7KeGHGTRCG1ftmIHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPuBLc6QmRGiUw3d5iX8XL0UHM3Ztcwhxm3WfSPuKjV6sSUZtxhPE4Iwne4Tx3+qWudTHKDvHDxf8LqMBs5+WWkThMjuaKjpvrwZ3DqwquFNSBijZqXEvsh5rmHewP/eK23B7QuNQ+CeOUGHdtzUkB51+OL95IiTgeU1z9U/sx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S31HVaS+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Th+cAxJJ; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S31HVaS+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Th+cAxJJ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id E737A3200922;
	Tue, 27 Feb 2024 10:06:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 10:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046405; x=1709132805; bh=dUFuFu1stf
	tnqvcK7jkX5GKZmiMvvRiIImhStLxn46c=; b=S31HVaS+uietR7CilwlHHhl0hs
	AomU8q1kUjlKLKLCFuo9dL5FRgM3dU3UcdAo4ZZLqNKUuikXjM+zTbgMvaX0HtUW
	xAB64C14qPiowM7naqZui09QdUJ2rPFyzn3VkwW5DG+eEmy3oA0v/fXgDfeWAdML
	oTIlR9SvXy74rPrOI/sHoslBBk+GaaGyO+Ym/YO1SHrXBYxyd/IhqFc1dkAbZQnL
	zfY1hoImr27TA73VqD3rO9bHUrbMLV8o5bcHXmisdOcxW6CP/MBsHSK4n5NXr+gD
	jnyn9FM1FBikl7qJ0zi4ZrN8pYq6iXZYJnA1SDBfb1GVD1+fGdX2/EkBGYGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046405; x=1709132805; bh=dUFuFu1stftnqvcK7jkX5GKZmiMv
	vRiIImhStLxn46c=; b=Th+cAxJJRPsPiXDg0rs/wFun9wlIZ6qSL1pjMZSFVvFc
	ZBcHBkKDcQXQ7vdo5Ry4AtYyLOnLdKbSQIfVqli5FPWCSpSROu+IQzk4/lA0bOC9
	b+JOnGHK4+BujzY2xmDAqBD8xS0khM4iDLSl0D4T1u/liJKJsCmrfdE8plKxBm09
	pd/7OCqf7oRt8xccj8d3iKdb26fGa3pR62r0zarWQlFb37VDtx2KOf9U0X70iStC
	nFiFDIsdPfIeAJNkIdqJjj8ydceyFqxORQTIH3+/tdYK4TEvFyWrxJBvbQo1qMUk
	2Dvefj+AKs8aATrBPiSNOI3G5hct3kNXZgeaaBOrKQ==
X-ME-Sender: <xms:hfrdZXoTAn7lXZdZF1nxSGm19jBnmybEC-2CEDj6NTfnh7so2vzBAw>
    <xme:hfrdZRoD0IzLpJCLzaTefK3uMEQswp9Wdf3lGN5V4wEjXJHR6nI-MZNcAoJdFOHZc
    D913R-0JIeY6MZfjg>
X-ME-Received: <xmr:hfrdZUMGszaXtzit3WxQ-ffYWt79xavQ2dAAqn42Ij_as1gDKTnJvBd3LKNieIFPElqWkmM4h9pYTM07SGk4Xt1xwVGLu24XyqvTvIkdW0HpROIX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:hfrdZa5IgUb7rZeYHQFfupTshw7gzt-K7rYOZ92LPRN67iBg78bcEQ>
    <xmx:hfrdZW4KBE1ovMuaGQHIaJkPThv9_D6TYt4jYRvcsoc9vESsqG39rg>
    <xmx:hfrdZSjhZe4CjNKjVfIMfVVwzxU-uKUiaVcu8FpsXP6_aEy9mXfqiA>
    <xmx:hfrdZcR7SxF5-YXcssxkytSBSRrvGpltFlrRLYUXe8b24yLkWmamgA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e7453a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:27 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/13] reftable/merged: circumvent pqueue with single
 subiter
Message-ID: <370b6cfc6cfe8a81684fe4d9c72138cb467fa268.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hhb/B/v6vKbbL10+"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--Hhb/B/v6vKbbL10+
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
2.44.0


--Hhb/B/v6vKbbL10+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+oEACgkQVbJhu7ck
PpRzaw/+I1w/pG1vsQ58SI730DEMI6V55wRMmChCbr+L6XpQ11MSltoQbfv2MAJJ
xyBNKGbjwS214/4NXGdS4M4f8o2kvQcc4ScqSNK7gE/MV7iQ8Z6F+X4pwXXE+/Ac
8J5ihkWVvnN84VI/VnNQBTShsqvGFBGz7iFdwtA/qSiuNEaQggM9XFe4ThVHEVuE
U6Pqej8Qt02IPf7K4xjq+tL5vbO20cHJsidNwDqVNQmy5W5/VFwg9Mh0IMlcLqS+
SsB9zApTlW8QNZtUO7rmev3LATrDkiErT9FC4DPiH+4JlZpU0jqib4ZsSP3uIZQu
gkY8Y0AMPUW361LDMyzdh2bMateV9ZnDzv1C/ny5UVQN5OVvh79ZK7XMwBt2ryFO
75jaEMr46OF9Ae160cn/yTki+yA2eK9il19ET38lC7A08azRcg9sTH7URwls9NyH
VtZurjR5nM4/ovUz48edhtZjHiJmV+NqawEsJMt4U1zihJMdqhXraP205QGi/7A/
TSZm33EvDfwygqezB+tB+RtvW3KFhg45efrNDVJmjm3YMfVbjwMBqMEWHgss6jSp
BfG0bk/9TCTqnLeU7KNqT6ax/enBT9urFE4rEvUhagUBL3Iers1fi3eV2tMPXN5p
cEuTbljCreGfue2lQesSNI9MGTbE+bLysh3mTn9fJvFY2Gi9MBg=
=VgqO
-----END PGP SIGNATURE-----

--Hhb/B/v6vKbbL10+--
