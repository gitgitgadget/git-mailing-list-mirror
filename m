Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E72A3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996075; cv=none; b=QyM78jsWaZCi3c3cU3/SNUs3LCrNYkI5uTYuZ3+lIkg6DwiDt045dzwDyLqIQlaa/hBhBqL17L5d1AFLrRG4ojuqwijiEI7OrevpB5Q3i7Ztjrp5mDc+cwTYlPAD7WYdfuWpjkVw8fkAIcstbT/dT6+h1UFgnuMHoG/pOQVd0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996075; c=relaxed/simple;
	bh=Lc1dzyvbtE2d8hVcLI5MPOrPJzlNDS+w26EiTwMacsU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oore+1ZaGJSUG/E/uI0Dyk2EQnwNWwyU/ik69W3DG5TN8pvL0Z6kwLVAjXot7WiR3G7TlYljH+8utdh5fXa5VBU5s6GPJ3oqZ427oPVRI8/W1ElVCs2Yfu9mse9s4rwzEp70fArimTpX9Z6dSHdK+7nrq0akGYLSNpNBXsg+2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLjywYMP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PF6VfZkH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLjywYMP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PF6VfZkH"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AF1121140257
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jul 2024 08:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996071; x=1722082471; bh=ZkEp3QTdeO
	GFUWiZHkip1/hGAYKGZjRcogD+AOCX690=; b=YLjywYMPOafsoQtIKFLDGk2ViH
	x9HGhU82PMIvSyiR8I4Y2cANwnz0k6cy8dvsDy8cC8uJcYfx3ZNboCM3HCOy/TjO
	83mnqEJZ8T0AqB/VB7bj3ob3S8eGttIovpDK7eFqC9SQvfGEparzDZ4mxf3PxOYa
	lwpMfoM0QO2DeEEcWnuoSUhDrfWcRzLp9RHZ8OccTWm42gus/hc3pzG4nLTixhRp
	+FefszpWR0nv2CE2dElmFDhYK9cueJu1QNK8Wi/bt/HPtMtcDSVKmuagEu9BaOv0
	ceuLOnQ8lc2yYPDdhQ9UuyLADhL8ANi7xBSX/HfNtEIE9F2tFNxNgUJeogsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996071; x=1722082471; bh=ZkEp3QTdeOGFUWiZHkip1/hGAYKG
	ZjRcogD+AOCX690=; b=PF6VfZkHv++hVLf89x/Ape0UPyNL3ouftamr3baQaQpu
	53euPV9S7kiUl5k/6cVltVGFKh98VIIxg9NYlb4BVO+q1D3XWlyD6oqLlk0yL6J+
	ZepGGPDoHHXa/fihWDzHT7LtreWxPmNiKnN4QXLlO/MO91uNleBku/OPsLvGELk/
	fCGhxdxEQXe7Y5bsoKQamYiliRe+6W56tSSohvsFro0+VrDfF6WkRRnFTpQyiB10
	lT++EBHWSZl6qOHHwoojWtYL40gUqcOxehfLxyJFZLrtDMoF+NVHQKxUi4pASUSO
	IE1uYM7WGToUtjT0AZ8932liTx/sKp+C5MA+eYN2sw==
X-ME-Sender: <xms:J5OjZuXetkJpED5i5Os8zi3yp9_0rIJ1rRbVUVInwAh1yGlpNFlTBw>
    <xme:J5OjZqnBMA2D4aPSiV50ChT-RIxgk1lzcB58LVT3WRe-M7H56f55EYsmswzMqFWeh
    0BPLPWtPUxOhkmJKg>
X-ME-Received: <xmr:J5OjZiaj7HjAPrYFz-5OBRULXXiNllihgd5RnqHlo4owkKFfDttXSHFLv0YsAqbtuvJou2SDOTWWiTPlwrvv3ck6Pft8vPAQ8B7wJfBcXnR3zcv5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:J5OjZlUHQbdJTn-v7Zt3lWc1frsxvokKpYQjfERl0REQMlWX7Atfmg>
    <xmx:J5OjZolB5idLowDsfVlBCPjoTMytG6xkhzFAeckbbXTVR5hls0lyQw>
    <xmx:J5OjZqeZHZX43UyLpfoi9YdCPZ7UqrWp6CEd0czqLKjYrLqtGIPtQw>
    <xmx:J5OjZqEHOADhAPhlyF4YzTOFkNxkc2f59dG12FlqxDF84o-wBu328w>
    <xmx:J5OjZkvIj_gk_5qs_LxUDwBzCJJFveKxx9NwvYWP6HUYNaxwD-nrB5KJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:14:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b13d68b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:13:10 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:14:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/23] builtin/describe: fix memory leak with `--contains=`
Message-ID: <08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ao0DZ0kySnShOnSA"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--ao0DZ0kySnShOnSA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `git describe --contains=3D`, we end up invoking
`cmd_name_rev()` with some munged argv array. This array may contain
allocated strings and furthermore will likely be modified by the called
function. This results in two memory leaks:

  - First, we leak the array that we use to assemble the arguments.

  - Second, we leak the allocated strings that we may have put into the
    array.

Fix those leaks by creating a separate copy of the array that we can
hand over to `cmd_name_rev()`. This allows us to free all strings
contained in the `strvec`, as the original vector will not be modified
anymore.

Furthermore, free both the `strvec` and the copied array to fix the
first memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index cf8edc4222..4c0980c675 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -619,6 +619,8 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 	if (contains) {
 		struct string_list_item *item;
 		struct strvec args;
+		const char **argv_copy;
+		int ret;
=20
 		strvec_init(&args);
 		strvec_pushl(&args, "name-rev",
@@ -637,7 +639,21 @@ int cmd_describe(int argc, const char **argv, const ch=
ar *prefix)
 			strvec_pushv(&args, argv);
 		else
 			strvec_push(&args, "HEAD");
-		return cmd_name_rev(args.nr, args.v, prefix);
+
+		/*
+		 * `cmd_name_rev()` modifies the array, so we'd link its
+		 * contained strings if we didn't do a copy here.
+		 */
+		ALLOC_ARRAY(argv_copy, args.nr + 1);
+		for (size_t i =3D 0; i < args.nr; i++)
+			argv_copy[i] =3D args.v[i];
+		argv_copy[args.nr] =3D NULL;
+
+		ret =3D cmd_name_rev(args.nr, argv_copy, prefix);
+
+		strvec_clear(&args);
+		free(argv_copy);
+		return ret;
 	}
=20
 	hashmap_init(&names, commit_name_neq, NULL, 0);
--=20
2.46.0.rc1.dirty


--ao0DZ0kySnShOnSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajkxkACgkQVbJhu7ck
PpQOcA//YYacRE3dl59Px03vUvpSlIbffLKR1d8evpBpTYLGq6PoCapWq9dDLbZw
0FRG8E46FTKSJONjk5/cyKu1LcnK2GIh8khEg6hJ4VjGBVkq+f3b+bZcm6L3qe9t
t2zY7fTfHZAJkI9v1LzXF5B1ZTyxLv21w9ugfFhndx5SqLRQKo3n/XqqEWZHGWJE
CM2wnrGT76H7bc8yXnVcerMHiizDf5edPkWT791nBIpd9RlAZhoONRKh2GG3B89O
hO9zlO48YRaQgDDON/wOplG4LGmaKBH3OYOeA966Uv/zP+9nF/TEm0s+4eQep+eb
n5BbH1vK/rR98K95dMCitPWYLJM9QU1shdWgZtU/ANGgMXNsWl4JbNPO/Dh+zPGz
bOuDhXPaBQ1bkFyl/KH6IN3K0ddm0aTillEQdZ+xpvVB5hi0uE4jA4Bptvkz9sSx
4cdNDvUbATFZZm5eBATjNkrOyG2qH4Fm54vrlstZc0rFp8oe7sNyKCaJbYxjg2cv
WvE8Y3LUed+I0lJfSj8QDE7ag6WI5i+zT8FRx7uvlN0t8wWO0GTEe4wJwBVTm3Mk
7xrGaUnat5slx1/QH5Q1WrNraS5nIo9VM5WG1LjWRFin/4fkJhFZ46p/PvqkIaAK
r2m0VKNN7CxlNAq/Y0eO7ADWGEPsYDfNfldSuvkzG5r/OXr4W1Q=
=a2hK
-----END PGP SIGNATURE-----

--ao0DZ0kySnShOnSA--
