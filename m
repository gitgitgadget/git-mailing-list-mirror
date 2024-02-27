Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FF14830A
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046412; cv=none; b=UZYGQKC+jhU2AYRwTCYs1CtlUrafi9GSqhyVtxuO3Jsu4DYnzSnu2T9SRnKZrmtc/zuBrY7Z+PqhMeQ4yt6WO7g2swb9g8K30GWFJj5Chderg8NHeEYpP4ET848lvSFX36IiuZDe0NTx613/0PiQm750NCwC9XtPu3+bbsYfjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046412; c=relaxed/simple;
	bh=pNVd3O7/FQKDAPNf2SsDT4MCBoF2Ma/xfsXLHZNX7f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIOpFFE5JscyTWcRSnHyDUuy1Ywk402biFn9+tLaXADcZl+N6+tnNoyj+xQ3zOey4OLdwIuqj61JqwA59PnGWOz+TF+hGEA5Pcgp/4bPftfr+M1CTnWAB2JuiXEUu+T3JkcN5NiKHV2cexAoe3AT8hBPkgrUC27HLPgjFCPR3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lBdDsaGv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LqpInepo; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lBdDsaGv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LqpInepo"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id E207D1C00084;
	Tue, 27 Feb 2024 10:06:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 27 Feb 2024 10:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046409; x=1709132809; bh=LfOgqeANsG
	qH3NddLTVOFmK5symbnIxnjHwt00f5JmE=; b=lBdDsaGvnEUbdI7O04MCw10E4o
	36UX1w/aXQO2tzujbBBq72C328zS5CjqCZ/a/JgK7p+mXPnpARwqH1ck1qskacik
	7WUV68mj1pq+vgvfvoKOzq/WhsLf8oUGuuwnjuCQ4I3GZVeWxL+tgmblBZ8k6X3E
	P5R+aEr8TKK1FRNUKw/p2sQ6l8ejWzTfDG8gcxK2cGhJ9NoaRvB1dxNUln4OfCTH
	0RMpOiMnskJxjvxjZ/m0hXWwF/wFoaCLmUBSuUWzD1RG1lFTrgp2uSE/Y4pypB6t
	ftjEIGSMi688/Z+I04ODgqmeOuCNqC7UlWvtXMYZtx78ubriFuyvslZrz68Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046409; x=1709132809; bh=LfOgqeANsGqH3NddLTVOFmK5symb
	nIxnjHwt00f5JmE=; b=LqpInepod4Q4NVJjdJwVmglN7u2eLKq97IT1W+1GuuwL
	nl2qLZPX0BQwcF7B0AC94OhKDGyqaeec2NCuGmpFgZ6IZogz1mwwzQ0DILhl/rbV
	eZ63hfj9eNVeoyp/C5mL9wP0vgGvf/i4Vc6t0hDLBgf3pV/9a1UNqHHbg7sJUgx+
	T4n49IyyOaPjvpa9+i1gmp0n4zIVllTfMq9dqcEYhDlYMFBZlKxFfjezWaZzlziJ
	asaqDmNp8LwDRIn5e4M1+sYQF1WRDfAZ3CuFvU2My40ScPD8SAGBRxJSpIxFXGJZ
	H+n0eNEp5pC0Vy5OuVrJMnmX4op51/hHQvWr7cf50A==
X-ME-Sender: <xms:ifrdZRRKOSXyFbz6MYlpQR0aW_i8zNVipo21Ev7u1zyk7ty-fbh_eA>
    <xme:ifrdZayeWDyu6xnEFQ2qX9nd4E0Ize56ioPCr6SZ8iiYl-Llhw4CvdNdI_S-aHUMD
    axJa4t7Sm1V_Wming>
X-ME-Received: <xmr:ifrdZW1vOrYGqFFdDjzBY2GdmFgq7u7TO7qfCak9Y7V1F9hSO4u5mfrAHyUXT8f0IpgXudeH4XBlVZqGg5s-85IXTafs_iDeHKqS0ohNb7H5c0bx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ifrdZZDLXJrQ76bYiUsG93qBEn2Sy1iEaXMXrEdSWjEwurjM94ZtmA>
    <xmx:ifrdZajQad04CeC_zLqyAoYvT_iU2y23O6VhxOi5KbHjqnVQ0BlWgw>
    <xmx:ifrdZdpjS-OxyUuG0kCcIfs9imZhoTNl-W62qDsIusmj1SxmDNOXZg>
    <xmx:ifrdZdtKT4BrZtjhVHDHW1ogTqetOmtedRce870aNh2FNCGsfSON21Cs4R8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26610aef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:31 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/13] reftable/merged: avoid duplicate pqueue emptiness
 check
Message-ID: <1e279f21e6b79d8628d5407881cee0d5032d7297.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cetg7FOSJ1StUoWt"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--Cetg7FOSJ1StUoWt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `merged_iter_next_void()` we first check whether the iter
has been exhausted already. We already perform this check two levels
down the stack in `merged_iter_next_entry()` though, which makes this
check redundant.

Now if this check was there to accellerate the common case it might have
made sense to keep it. But the iterator being exhausted is rather the
uncommon case because you can expect most reftable stacks to contain
more than two refs.

Simplify the code by removing the check. As `merged_iter_next_void()` is
basically empty except for calling `merged_iter_next()` now, merge these
two functions. This also results in a tiny speedup when iterating over
many refs:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     125.6 ms =C2=B1   3.8 ms    [User: 122=
=2E7 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   122.4 ms =E2=80=A6 153.4 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     124.0 ms =C2=B1   3.9 ms    [User: 121=
=2E1 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   120.1 ms =E2=80=A6 156.4 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.01 =C2=B1 0.04 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 29161a32cf..f85a24c678 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -148,27 +148,19 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	return 0;
 }
=20
-static int merged_iter_next(struct merged_iter *mi, struct reftable_record=
 *rec)
+static int merged_iter_next_void(void *p, struct reftable_record *rec)
 {
+	struct merged_iter *mi =3D p;
 	while (1) {
 		int err =3D merged_iter_next_entry(mi, rec);
-		if (err =3D=3D 0 && mi->suppress_deletions &&
-		    reftable_record_is_deletion(rec)) {
+		if (err)
+			return err;
+		if (mi->suppress_deletions && reftable_record_is_deletion(rec))
 			continue;
-		}
-
-		return err;
+		return 0;
 	}
 }
=20
-static int merged_iter_next_void(void *p, struct reftable_record *rec)
-{
-	struct merged_iter *mi =3D p;
-	if (merged_iter_pqueue_is_empty(mi->pq) && mi->advance_index < 0)
-		return 1;
-	return merged_iter_next(mi, rec);
-}
-
 static struct reftable_iterator_vtable merged_iter_vtable =3D {
 	.next =3D &merged_iter_next_void,
 	.close =3D &merged_iter_close,
--=20
2.44.0


--Cetg7FOSJ1StUoWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+oUACgkQVbJhu7ck
PpQF6Q//es4jErrqvKPOpJZ0AYLq/5TvcyeEdN6pmum/21KZjwSQnMhHphp7Xxcf
4robCxXdP/siXuDJaebb2i6+9bDRKXVR58mKF76+jGK533AXVbOwuRzkvSsgb6ls
03NiPe7c/bzzZbJnZsv5r7Ueq6N0WWQ85cNv65tx6WLUXNwsaahtJxThqLbfTcAx
S0Q4ioZLc+Uutt3ExFaJ9zXTrCg+GxzXFOHg/4Np9bzmKt9I3GMaSLEH2sudn9mv
ZBH5vpT20Ii9P3LXX48POelTU0r5iMEZ4UaYVOMDYxkXz76DS1wPlWxnkfpQCYDE
wfPw0GOon3RM80iLZET1pB1pwO8dqhaQUHOuANN3K1KvvgzZLB6E8qnkEo1DA+z/
yPRxh7yJzj6bTD19+6DjsM5jnhE5TzmpT4YKC/gjkmu0SWd7fts9Snvm2yEDAb2/
8PVYpX5Fdqymw+sqKDA8TB4ZHme4NShoFeKvQUsmQD/kmM5OfhVCuZwitF5v6LjZ
bcRuBR+ns6oHzud32sjVkjbObjP+GiQIz0l8kK017DcUOVognFRGIwcyiKam31Gl
oY7fuoxNZFYTn6t5nq0NV37Y1xp1GM9MRzGLKfTS5E8Q5GMFAN7uzXF00ooP6wmd
sQewn6AnxgE96/zgexwnr1FBnvlUPozuYt7ynpncmbKI9dM2O9g=
=Ye//
-----END PGP SIGNATURE-----

--Cetg7FOSJ1StUoWt--
