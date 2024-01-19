Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0483CF56
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660829; cv=none; b=nVc1VuEcdNFbGhOyf5GZvWusGx4fwjKRHUtQORmwut/zWyv3MADGDSGifZSgS0mWqy3MWcaMZ2/3gaZyRsGGXvT8s7nzLl115UIcnO2qboZZ3PSRvpGizbm5xZ7QnzVYIvkao24tPlcHbQ8/mk9EJEfWvcSi32W5ItTmqNa4dEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660829; c=relaxed/simple;
	bh=O1URfq7fd3SxfgZAY6QhNUjcdo1k6oZkWc95sIxag8E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItPY+ffFkGTkieN9kMMIdbsQN2rj/l9VU6lMeh49Da8L0bXvuhkvJyOClxzNgfwIWexda2fOWUguDQ7olTjHamoTJ5bBuunfCd1dwxCfiEuKKJrR3g2vzQA8zYUmj0S75MDvTex4dZ9R5mmbNB/gAEJi4yFMuYdVXGHhrKO4geU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dfd4kk5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vr/1n64Z; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dfd4kk5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vr/1n64Z"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9B94F3200A6C
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 05:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705660827; x=1705747227; bh=6jHpCeoQjt
	nTIE0vDd730Ad1DMEbt0LP8YtxDwNpu+0=; b=Dfd4kk5C86n9vR083yvDThwsK0
	cJer2KwxV7DrybGR0fK07L7dmp0sMCS5NKdrCSZ7ttQ08rw5yvlBFvp8PwZvsfxf
	K3qKTtTZtIuSJYsmxHeJ+yGlzKDLvKvhlnngtqg8dwb0YiBI7g1ez9sOpo5XwC/C
	6nWSkNVkyj6srz+2XXnpfs/MrYfJwJvNTwpxoOZO4y32Idg3HbghUo5qU6zaeH5P
	jdHNtYRGx6p/LoIFSMKAJeGW6DAlSKKATkfvZOqPNrHipNLXMuYdDwWstSc3hfI0
	42vgLzOeb/FkDUQJRcIsf7wevhUV1BlIhw8wsqCFTTv9xlWJqyjTp+5DEXZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705660827; x=1705747227; bh=6jHpCeoQjtnTIE0vDd730Ad1DMEb
	t0LP8YtxDwNpu+0=; b=vr/1n64ZrQyzbmqSaFRZ8+Qz+JFgNnUYitp22etYR98q
	TGEtADfTCvyP0KZIHIGuztTG0hwoh9EtXEos2d/b5yWteIf8LQOgkdeVqLbJxzPb
	EhbzvWIIdN70NCUX1UpXns9E4DyXJsoRxwmXb3RDdqO1+eTAMnaP5aGqauNtD4EC
	lVVfdS5ljicXUpZKuFXpbDc08+4XXnW0d/qChHDOU7aSGxJteuDzRrAQ6Zei2ec4
	2KW29rUN02TTPgurICnlkm8D/gsfaNfb6KYrVWDg3ItGJneauMWclKTzV4oH0HEO
	A3ZACaDWEx/DfTEHKhcGLtGttIhAL8zn7krq49C8GQ==
X-ME-Sender: <xms:mlGqZVwIxx5afSlfbQef2gH0F5Yxe03-wJQWmV3fMwkLBla3HNk4wg>
    <xme:mlGqZVRTB7FLU5GZ5ZUrrYT-rz9Rauj9FmPl9RDbKd2PGPsPIBgyFqNS25refvVRS
    mGupmwr5ail_1pKzA>
X-ME-Received: <xmr:mlGqZfVKzJVWkXc6RJHIm-JnTCT59Nf1KfvZRZusuZsiCwwABC6ti9Ff6M8JpNos9CrrOErl3yPMKP-q8VLdAAKd6M65OM8wEGzeatJIvvmQl2os0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:m1GqZXh0Eyi6uDvngN8ts6SOa2PGBUPUf6la4004eZcP2gZlMQ-flQ>
    <xmx:m1GqZXAr0DXCAQdMOdyzbpqxkWqSpPcRxSaXbYMqLKxH3ccC5uvnFQ>
    <xmx:m1GqZQK7z5wTrLW892LN4XlCEFmvbyLP7CwYQIzqbzj6lkR9R7pO_Q>
    <xmx:m1GqZa8cmwXN80rT8F-IaTDzYo_9UO_fWFo6TfodkviC07DuUmOlfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29d95943 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:37:29 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:40:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] refs: redefine special refs
Message-ID: <a4b4dd51f81fdf65f79b9afc3bd85109817ea128.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tGOWRQnhj7vnfTTL"
Content-Disposition: inline
In-Reply-To: <cover.1705659748.git.ps@pks.im>


--tGOWRQnhj7vnfTTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now that our list of special refs really only contains refs which have
actually-special semantics, let's redefine what makes a special ref.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 047c81b1c1..08a900a047 100644
--- a/refs.c
+++ b/refs.c
@@ -1839,13 +1839,10 @@ static int refs_read_special_head(struct ref_store =
*ref_store,
 static int is_special_ref(const char *refname)
 {
 	/*
-	 * Special references get written and read directly via the filesystem
-	 * by the subsystems that create them. Thus, they must not go through
-	 * the reference backend but must instead be read directly. It is
-	 * arguable whether this behaviour is sensible, or whether it's simply
-	 * a leaky abstraction enabled by us only having a single reference
-	 * backend implementation. But at least for a subset of references it
-	 * indeed does make sense to treat them specially:
+	 * Special references are refs that have different semantics compared
+	 * to "normal" refs. These refs can thus not be stored in the ref
+	 * backend, but must always be accessed via the filesystem. The
+	 * following refs are special:
 	 *
 	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
 	 *   carries additional metadata like where it came from.
@@ -1853,25 +1850,9 @@ static int is_special_ref(const char *refname)
 	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
 	 *   heads.
 	 *
-	 * There are some exceptions that you might expect to see on this list
-	 * but which are handled exclusively via the reference backend:
-	 *
-	 * - BISECT_EXPECTED_REV
-	 *
-	 * - CHERRY_PICK_HEAD
-	 *
-	 * - HEAD
-	 *
-	 * - ORIG_HEAD
-	 *
-	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
-	 *   rebases, including some reference-like files. These are
-	 *   exclusively read and written via the filesystem and never go
-	 *   through the refdb.
-	 *
-	 * Writing or deleting references must consistently go either through
-	 * the filesystem (special refs) or through the reference backend
-	 * (normal ones).
+	 * Reading, writing or deleting references must consistently go either
+	 * through the filesystem (special refs) or through the reference
+	 * backend (normal ones).
 	 */
 	static const char * const special_refs[] =3D {
 		"FETCH_HEAD",
--=20
2.43.GIT


--tGOWRQnhj7vnfTTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUZcACgkQVbJhu7ck
PpRkFw/9F/Etaqs5hQcH4sgTQRwIx1eLI5Cf7a4BA2ODM97U5ZAwZNCjD0qUQv58
MvT99VCJhicd/4NdneJk1UmkRMXxMcwm/5WFva+AuYMLzXISXoDYSl9MyeeOp6H+
qYbBbRRjqBOmpyvosRznWG+Iuc2Pwj/cdOAdkY2Sb/gtgf7yY/BDDi2s2t6QmmNU
IroTN/4xWlF3DjmRuMVMsecc6ed9sDE7BnbsPhQqCtNx0JDIgV2/+MrmGy/0pT0d
QlLolTpv3H0xPWqQbWxAn3wCIsqZvkTjJhNNV/N2gEBidfcprxKXV/zF/Vz9ouvw
Kh26d21oVjVTJW5jWlKLHh5PGhw9A2xyJYrnRFK2Gw8Q5jdOVxAWUFcCLwI6EqOv
jV1UT/FtGgTD6kWv4yNgs4yyzA9VcHwYsx+j9Khq2Zf+U2qBhriqt58/Szl/NgHJ
Q4psrR79glEJ4Hn151RsUuc2tNfkDzfDKUXvfuQsUmhhk0wGINC161zvdIxGMt62
FIShDPMp9Lzd6TylnTha7ht3IUUuRaiqjDxob2sdNs7y7sc1gR+/gObFcgmI5bG8
Kb0IaZLyxp/kdZ0Ugnvhn1RIhueKHWWnsQoEn0MbJejR6f0rLrAGvM8i5NMKDKNU
g1YLM+UGNSe5WFY8Rbabqkdl0HzA+pxVX8dwBw+SXGEkjM6/cKA=
=81x3
-----END PGP SIGNATURE-----

--tGOWRQnhj7vnfTTL--
