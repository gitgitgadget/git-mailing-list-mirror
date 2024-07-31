Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6B1B3F18
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435317; cv=none; b=tXgVwqCBZkCV0iM1qGJKp1gA07lpGm603YhRhk7nybqCmqdoIZYx7b4LzEVjF8X7+G/31OmalXoYHX/bJwlDQkagdNVkTHCLWd9P0QWPwMpM2Aab6aK/qg63OqGl5c7Pi/KqRPH1LaWFr4krpgWvdYnEekdnpZt1X5XoeEj4+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435317; c=relaxed/simple;
	bh=cgfNmv0J4ZDCut5gq9EFCnl70+1Yx6fuyWl3ByIKr/w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufnYSaW2BDjTwNC0DwMMttBnmFsWpVbxqYLI2RELMR8rvSR1/Z4EWelM1CFo8U9Y6qzDnYFzLvieA6xKxF+NBro8JX4dP6RsNbWZkFFmKw5mQR4Ddr9gS/yajPS1fpvZqd7mLdtjIO8djGbgNAd/nr88d8uDRLoU2CMkAPTuGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kr4NaAsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSTJfylo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kr4NaAsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSTJfylo"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 90209114061B
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 31 Jul 2024 10:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435314; x=1722521714; bh=nNKBzdbZsX
	DHAHbYWCRNWwfre2rwOy3tplxWmhXiMsA=; b=Kr4NaAsX11qsMbxx9EJjKc0oL5
	kDsy7URpruck8TU1t82aoKmoOQDkIocDfjnTp2yP8wZthdpx199+/98SesQNpuHt
	gsEZE9LHm1fKPuN5L3g7XJEM5sVvB/XzzN6cmmRXPxG48BcvleoWjb3H246pAK3d
	xnx095BFDVY1qK6gHrocdHCVfE+nODW9tFZ8q5KfNvqGsPzLQeZRp2cULo95yUt6
	LnlcbbpS3JN8hynts4PHYQfnv66I7oJ6H9Kj7FV+E+sTR20SBs48pGDbZmxMm+6D
	JcOBJBYCb19G1b99Ui+0I4fGLOw81SFu3/kBdVBUL0JEv9XdCiXjfGrdx94A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435314; x=1722521714; bh=nNKBzdbZsXDHAHbYWCRNWwfre2rw
	Oy3tplxWmhXiMsA=; b=hSTJfylo4IaR/graPCpg5pd4tdV4DHkb5kKhQgtQGXll
	kAzGdOq9aPmM8sT/OgNZfpx0SSbwyx3owBIlsp9Jym5/jg+ICpCPQ7sGldpNc5mA
	fbBZxgmVEJ/Fv6DlUI4lwI+bRpiEaiMrZadNdyA8Qt1JPxqDB39dR8K7WbHOunAA
	Rg8Ul6BVdyRMqLEeMmHdO8fOI6VAYo4I1sTlFk2EiyCRWFy86ZCX+3noYuPJ96eT
	awa4NdKRGH+aMltcRc3AaljXXE8GaX/8tnYQTy871XHOa9+b8llRpUAASEA4gYft
	dqrSuT8eASj3shzQAhQqkW9q71OIIrbGiqiQ1AhLTg==
X-ME-Sender: <xms:8kaqZsyVrUIV7VBS_cihZ8Fr0tMdYC9aWlCSQmqY2VCa7e3p91aLVQ>
    <xme:8kaqZgQshKDOWSWdXXFLPCoGnlpPSBBo2-JmeJ37w5cQoWB2abJ5NMU1oYkFVRIvL
    96zaWbmClAZ4lAWDw>
X-ME-Received: <xmr:8kaqZuWt4hrGYVZmU0xuIrC0Sg7rlW-qeyDzzNNt0PEVFdPTXnBl6OmBh8hKIq6lLqa3qYwgFo9jUxgFrFWt1lRhwnu6UCAaXKfHcSaJHFszqQ5d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:8kaqZqg0v0TPwI_UuvBb3tRisu8Ovc0BqizWVITx1vsMc1lC55KCgw>
    <xmx:8kaqZuAf3IXK7DidCXiYbXTR3cZFuEzmS85uWz6Lj9nmr9q7tuyCCQ>
    <xmx:8kaqZrJuw-Zgd3UZw6foZ2D3LREjknCUOSonfoULaZlh13pRMsVPdA>
    <xmx:8kaqZlCfX7F1HNHXlZ7KHrBmZdwJ44ab8QvzmxC94M0jt5pAfbUbbQ>
    <xmx:8kaqZv4s-a0gglHfTqsVX-f3-lyVmqgbnlToN5519ktpEjZmEX--7lwU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 714f9d61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:43 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:15:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/8] reftable/stack: do not die when fsyncing lock file files
Message-ID: <9233c368941ebaf52f0aa9cd2d16c4334e8eefda.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TgMt3P+HhhQjct2X"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--TgMt3P+HhhQjct2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use `fsync_component_or_die()` when committing an addition to the
"tables.list" lock file, which unsurprisingly dies in case the fsync
fails. Given that this is part of the reftable library, we should never
die and instead let callers handle the error.

Adapt accordingly and use `fsync_component()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 07e7ffc6b9..9ca549294f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -674,8 +674,11 @@ int reftable_addition_commit(struct reftable_addition =
*add)
 		goto done;
 	}
=20
-	fsync_component_or_die(FSYNC_COMPONENT_REFERENCE, lock_file_fd,
-			       get_tempfile_path(add->lock_file));
+	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	if (err < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
=20
 	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
 	if (err < 0) {
--=20
2.46.0.dirty


--TgMt3P+HhhQjct2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRu4ACgkQVbJhu7ck
PpRGZRAAg+QfSC1KVs+MvtRWIoLdQA+wMoI5zxmOW/7xMt7gzm1VflB4JQogLlte
JdZo8stj9vAh3S1GlYaszQsFysCFEbemrCE/9nEgrH94X0W/IHOzwV4ccoYJynhU
SWE/xVuAFmGv0ki9nIO3Xxp8CZle2WDw9YtXOrGSOOqn/FZh2LBAII46tNiLMwf5
PRQv5us+g/+mw3Jl5KNThpxYWBXT8H7ZOm6x4uefaidF4kSbod6DNRqtVQRc3PII
nthgdUGo81T8YFSF6igaDw9PfXblrfdqa+A7SGqV0O1RjXdxPbiegURvBjxq2Xjo
MNIoe/yhGASaEubS6/q88HxXLiqE6quEdQGgfs99+hgnbN0rMYZsbzr85oQkZ/yN
BohEeMXNop1KF9rj2vCN7OlGEw7Gmf5h7LPZ26nRxSaxYd3j59uYfckaDfIeuqHG
8TJcqP7blk5dLiGh8SrPDuC+h9s8ErVHyYTgS5cZNPydEKClVfI18FpqvTx80dA3
B9QCiI52/bjii3HSApsH9mAKkbNVu7RppLOH186zshFlEF+zQLq5+c970retbg5T
lPrKMu4PLUEh7+NUU8ZqneZNNF0mXWB+xl1wBxL8zawwSDqJRekbD+RmxAU2fxte
e47V+RhAK6AVjvL/U1AaebESeexs2HBunATXJLVkMhIbZrnSH64=
=5plh
-----END PGP SIGNATURE-----

--TgMt3P+HhhQjct2X--
