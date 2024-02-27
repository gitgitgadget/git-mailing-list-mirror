Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9A145324
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044066; cv=none; b=pX0p29fixz/74d0jDdCUyjILZ5cvt12aUVFEbYnV1LEx7GZnuydp0AOg9Jrc+N0syU6IpkHcnmhI0CwltDXWW36BkeK17/JfIVMS6c8wmp8ypzZJWNpqYKzlNJ24Ab5+DpDe0N27xJ6/Shb68w9Iw24PxBp6lVK7yqPwmSYcN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044066; c=relaxed/simple;
	bh=khe10dPzRnyDtlmQH1CT6jj1NQpNy8J6u94wNVCK9W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as2MPiIJwW6qtIhzwWWc9nJb/XDQQpg5Qwe9bJaYql3cKu4jC7hs2PudEYb9HJXGxn3aBMMWZCu/ZfW2F9R2Leg2P68umdahnUmRGXYBir7LfHBPtZ946D/qe9VBcJuvS5a6qtFd0b/UOAMqLPscyRlmFSDWJF20HzD+cW7aF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cqXrX9bM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5mPQ6HQ; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cqXrX9bM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5mPQ6HQ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 0B85B3200ACD;
	Tue, 27 Feb 2024 09:27:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 09:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709044062; x=1709130462; bh=qyz5nbtqGT
	4AuWMXO/un61WXJIn8ZeSO3so2fgzZLSc=; b=cqXrX9bMGTdK4x7JonG3daxPNT
	dAwHC93wFerML30CqfPRjQ9XZtV020MeK0+jpTmdZ/p1o8qquv8uOxhbShMrMXg8
	m1aHIKrQD5Nkoui0VScnHQfegoZF6iUtR7n9GmL4pmJPj8HGhqbnBQ049U632jyp
	aUcQbax5EocyNrSyLtYDJ/ThUy1FqIG36UYaSfcvBBGdeoonZoeqFY2zFSGPAkge
	gD/cVBT0NF4lQCsrnXsFHyTyjC64JI/dRRAZ1izpkdXBSF1DTF9jdkOuXgWrIJ0Q
	+4SIynrLZVkXr05F7SI4CI3asvd6tEbODYNORuiw7Bc/Jcg3fr8IYi1ezgwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709044062; x=1709130462; bh=qyz5nbtqGT4AuWMXO/un61WXJIn8
	ZeSO3so2fgzZLSc=; b=O5mPQ6HQc1tfgsNPV4ilEEhNMNCAHf2prhH8/kGSxnLQ
	/u71agC3HTLxPPU0Gd9ED32cZJJTxJYC2spvRlkB/drMvjrFMqQUKl3iq+7KKlhK
	ge+/jvKmFZuDOYgbtaFyfNGBNNwMci4z56D8/z3NovjPsje+YTrUbgyyQoAdtny7
	zFN7AAbe/qcEzMzzdoAJLkNkLOp28zVRwWyp1vBXbnF97qpNMBt8DxWv9TyYmby9
	eCPbA4GNR6cSLB2iHsDxhN0Nbigbp8BfIqTmdd2XaPqbgrMtLUGqduAA6ZMzp7ME
	gai7QttCj3fGX2rcASqe9gX5gcsUzhSuj0HGBwKnPA==
X-ME-Sender: <xms:XvHdZZ_yFEzGgCVr15OYpRhg9tp4zCQmv0ZuItCClh6C99DGglF47g>
    <xme:XvHdZdtDcAssIuDXDI-EhUl2_g0IUsT1xLl0aW7f9xEuvbjWarwjsPShg8bD6EVfq
    rfOYqXifIiBZZtaCA>
X-ME-Received: <xmr:XvHdZXD-Bytoh9Efg9f0bIkQJk_Nkbi-ShlCFBrRFqZNFYVTvnpCTq9BF1GFM5O_TWBFQJHFgip8u-w_PWYMyPkXYs49m-h807xG6SdyCZVNSJzN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:XvHdZddhI3WjObKs-w4nATYMHRZkbLz64qbK7Vav4cmRQfRWCxp-Gg>
    <xmx:XvHdZeOWb4qjHPrWt6PjY7mstEANDNgAmJZ0me6YGa2bG8ea1A8TQg>
    <xmx:XvHdZfnMPadZ9LD2-Qo5yflilmD0P8PrNaDM0iCzxAIuXG1bsVGUvA>
    <xmx:XvHdZXZ9s69gj1p6Dlfpu30g5n4UgP1xbmaTz0nw0agKD_fJ5qA__Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 09:27:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7876712 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 14:23:24 +0000 (UTC)
Date: Tue, 27 Feb 2024 15:27:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/2] refs/reftable: don't fail empty transactions in repo
 without HEAD
Message-ID: <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
References: <cover.1709041721.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sGw4FUBG77/hgvym"
Content-Disposition: inline
In-Reply-To: <cover.1709041721.git.ps@pks.im>


--sGw4FUBG77/hgvym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Under normal circumstances, it shouldn't ever happen that a repository
has no HEAD reference. In fact, git-update-ref(1) would fail any request
to delete the HEAD reference, and a newly initialized repository always
pre-creates it, too.

But in the next commit, we are going to change git-clone(1) to partially
initialize the refdb just up to the point where remote helpers can find
the repository. With that change, we are going to run into a situation
where repositories have no refs at all.

Now there is a very particular edge case in this situation: when
preparing an empty ref transacton, we end up returning whatever value
`read_ref_without_reload()` returned to the caller. Under normal
conditions this would be fine: "HEAD" should usually exist, and thus the
function would return `0`. But if "HEAD" doesn't exist, the function
returns a positive value which we end up returning to the caller.

Fix this bug by resetting the return code to `0` and add a test.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  1 +
 t/t0610-reftable-basics.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a14f2ad7f4..45568818f0 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -821,6 +821,7 @@ static int reftable_be_transaction_prepare(struct ref_s=
tore *ref_store,
 				      &head_referent, &head_type);
 	if (ret < 0)
 		goto done;
+	ret =3D 0;
=20
 	for (i =3D 0; i < transaction->nr; i++) {
 		struct ref_update *u =3D transaction->updates[i];
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 6a131e40b8..c5f4d23433 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -328,6 +328,19 @@ test_expect_success 'ref transaction: writes are synce=
d' '
 	EOF
 '
=20
+test_expect_success 'ref transaction: empty transaction in empty repo' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo --no-tag A &&
+	COMMIT=3D$(git -C repo rev-parse HEAD) &&
+	git -C repo update-ref -d refs/heads/main &&
+	test-tool -C repo ref-store main delete-refs REF_NO_DEREF msg HEAD &&
+	git -C repo update-ref --stdin <<-EOF
+	prepare
+	commit
+	EOF
+'
+
 test_expect_success 'pack-refs: compacts tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--=20
2.44.0


--sGw4FUBG77/hgvym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd8VoACgkQVbJhu7ck
PpSbvg/8Civ88zcgm0CCSaO/eBZOXcGsongF8lQki2oV9r8xKK7R+ClGJ4OuQbEj
n6ELka8UZ4kD4IOpD+Dsiocx36EYFFIsZsblCufYrBQz2K08gOGA6S8igiPHBXf6
v+gqtl8Onnva/jEMKJXFIP9ADbwZzuNVGmz5m2LDxgQXZcCkYx5fq7YiPDGgp/nZ
Nha1Mg5Evkxq+sOFTxcIRn+cl9bpeThxhXj/XEa8mA5lgV6jtESPMK8cNe8lJWAm
isJMQJEvrOsQqQzW+tZARpQzS8TBDUyTnqUJluvhDqEKj/15afI3bfuqIYxIMD2q
5cvRPKvmokfa6/hG4htRACK7vbc6arRPgZqE9bavwtPEMtaNTv0R8VuGAMWsuH/0
hs02EbSLTdSolg6HcIfyEOeYS0b/kocM8oLfn3nsWKubtrDUtpADSKjCDAzbDgCF
4wWCdMo/ndqmO8+ux6FUEgZhwbWCrtM3YA2SOdtaovV4s5mktylVxSpvmQiI9vQi
HW2NUrt/Or+lyzGml57f8dueqatJ4d3ioHk1Yr58oXBjPfCZ08W1xkXbktD3QU9X
lCVQVoQR7X7/ULt1eaZFdOyNnsk7+moGj3PRinZrPG8Whrm+EwQCLiF2WMvA3zX+
VunQlr2lhxWP6ygevTuVSL7P1ey3nloHNwRlNzVStR4YYvBaI1c=
=jwXe
-----END PGP SIGNATURE-----

--sGw4FUBG77/hgvym--
