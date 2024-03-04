Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89770374F8
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549359; cv=none; b=o6V/HCNxjE0a+VEwTy5ubiTSwM4nUem+XVlAO09QoChm9o5yOk/ek9wCK1Q7j5LxyLV8RRfaGX9YHYpPQ/IJ2jQmvKbSwFmgFGcqbVCFRD8UY7nctInTy3YPmNMx+1WYXGL/gnudAC1ORCfNbTl9SMrxN5imGBOnC5+QEH3nJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549359; c=relaxed/simple;
	bh=jprqBRiHZQeD4dt8YC4pC3WKH1vF1yr94H8jKwui/rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBUTp4q5sMdPqdn3zYbfjHZJO23VBcJil7wyB+HK6QFHfP+ZbT6gW3eO6vjE/20TNn4TQmuDk3MqUhlhqokSalA3/jqe4dvyAQJuMUNh132czssduG2BGS2joZ7JUMCH3z4yfmbFEcVBWodMevkNKl2gdHkCBfcJe1X9tnNNN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OvYiSNYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYSovR6H; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OvYiSNYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYSovR6H"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 905D3180008C;
	Mon,  4 Mar 2024 05:49:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 05:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549356; x=1709635756; bh=hR9/6YfTYj
	JitXsJZvci7vvH08zF41FJJ+3ouQ/0slk=; b=OvYiSNYfok4RMuqEBdin5Geskj
	fk7rqFFNtbsBVM+14KHrbCjKbSHT2fH72tBpXnv8ynvJiV3QoRGhuHo6f1MS/tet
	dds3yXPdvUxmiOqezLLR/VhZvPfH8Uf1nTUpRSxsajepvcZ9YreM81wE7sShcGje
	RJgWAMYvwAu5wAj+FaI8MZoZ0HRyp1S5R02axOzP+JH9+5uysKcalLa5zZlNC3/Z
	U5GFWbG5+/rL2jIqJZ5pjD3HEeN6HdR3enLFsfXN94aCw9c+SZeJ0XHRPcTnamq9
	prclnqSRQYg2Hr54TCmODmQNcoYAdT575LOEGP0u0QYF5J8Hu+Jy4x1hC0QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549356; x=1709635756; bh=hR9/6YfTYjJitXsJZvci7vvH08zF
	41FJJ+3ouQ/0slk=; b=nYSovR6H0lGJK9C1scqpvt8ibbhwDsRiid/2l8EYu/Tl
	MCx6sdCQtFdIRGZMkKsK6c0eR1eoO8ZgaL2N5MAthMyXL8nBSQAoKRb5/rJ0V/GH
	K82Z9a2QgVw0S5UC3JlI7kocci4DiroxWeh4fqRbAsUEAeNBivSJNmywRkX4UrOL
	JHtOPtuciEFwBcPuEcdtynRcN9uZ0h7qNvv35jmuoG6Z8eEhDcgm9KyZXqCAXhqt
	iUr/hn2kOgD7HHktBkY8xpx3YpPaLF0dojKKK01PUhA0PLo88ukmRVHJIsYkQWGR
	Rg3Dcw+4H95H7qA/DhNW8dL5Cg9rl8IE1csXqq9S/g==
X-ME-Sender: <xms:K6flZbs4I6VIFUAR5zoTCGKHSZMV0X14QMXBFFv8-R9LwpmxLpn5gA>
    <xme:K6flZcdFUbOH5YJMD_OMOZXw-AVNn0rRYnEFV1VbMNhx9uIgXRfKHOEWdyRftlYGs
    hl4jiH6qYZ4IoI5zQ>
X-ME-Received: <xmr:K6flZezXHzuY_-h8MzeEYQdJaLIiIkoZkS1p4GHhPb6vhTA7hmTVrQV80fDrF848H72EE2HCSQKznzAYFLAnYxgfkefXfbe6n2NBIaPhIt8kOIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:K6flZaNjAMO0QOFsVMp66vVNWCr226jZA-cNKGJclOS45Tu_gt8yjA>
    <xmx:K6flZb-iNtFtcsleMVGJ9JzpJREsrqWJDxWmhEE_CvBHQ6iGk8451g>
    <xmx:K6flZaWBdVW43Q7KDDFE6E9hi-hmmG9FRIKiDQmZanUqaxVmkskrAA>
    <xmx:LKflZeaWLB1ByqggORhhH5zQqdwoPMhSj9-RmIMe19gKuFFlA03tEBwmLg8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1dca5edd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:50 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 07/13] reftable/merged: circumvent pqueue with single
 subiter
Message-ID: <2199881d476875d37bba0a510e3d74a594b8c61a.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9psO+PzW2DVcflSP"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--9psO+PzW2DVcflSP
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


--9psO+PzW2DVcflSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpygACgkQVbJhu7ck
PpSE0A/7BRzJ5JSkHbeQ0d0kyF2T22u2g67Q3im0yvPU/3+YHI9oARu60/1rmj9C
2aq8rBJJWikSsb3xXTd+GjFGkTXs+GWk44Ttgw4TY6OvrFFR2OLw2tvigxMJ1Wcr
fG5wzvvr2w+lqqbowgg/dh5iIMvSXrYXBo/4fG5Mn2A4KT4Ii2bwPJ9XrI/a93s8
zhcBBwYpWyY8Y58pYg0Ujyf9fvEvoSfSfaNClWkxIwPf6DzckO804ZbmvdWUedN7
X4I7Rg5uDnwV0xvnohbh3xRfncm0bFRhR5N7Lh1kIwQ6ZIKwPV9W+f2/P4giTvFi
BAKQZ6QPcUzEKj96b6/IR6yWiVDM2hZMQkj33tnZp9Iz/cW8u4jic6ifvtJYcApW
NAKi1Xd2BCWoCwJ40rqPvmjKjrUU2M61dPL9Zi9B9pq+Z6+SiQMGebU/bmuprFFe
RpQhBxSxgYozRSpjnnalZaI9YdMklidl0/U06rcFLK2TIbzxODjfPO+Bu00T8tzC
RcoRCib/wEj5TDHOkAwt0F1Uxe/96ccVCfw3X8G/oU2G43dK/zYI/7uYeWx5l4He
hpYMZNUHMtvJizhY7zu028NVy/hniDtBICzPL6qHHEZgELxD9iIVWiqrOn7qzYOJ
RZCedfoQXSE4qzc0QEGL+kwyUDIgNIo9SPRo3/DLG9T3ebLRyVA=
=7h7F
-----END PGP SIGNATURE-----

--9psO+PzW2DVcflSP--
