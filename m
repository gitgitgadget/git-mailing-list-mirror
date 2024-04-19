Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66E7BB01
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520276; cv=none; b=uqVTbAamTU7q+N/Awhmrig8Q7ql+xMX1B7X3U6pHgCIX/XaKwEyy7gKhtLe1HtwTkj2Bi/41n+o8kbjJKuhxSYekGmBmY5d+Aph9MA5wc1qcK6+DbRdVu4bkt2a/Drg/CS4vGWC4znyyriWTP69n0TXU3wgbZW1FikrqpFw1cNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520276; c=relaxed/simple;
	bh=BQcyCJAdnCIWQd1Gl1uede934WjBtMmByH9nTZf5pIQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WumA8Z7tsxE/+8ewXMM5oPpjrDzZ9q+B0GXPyIKkESjrIVsVVZeo9gCgGpW9/Qevtiqh5FLn6qXL+cwtH+7B7uyj5YhHeJcyndGyk90bXIehcKxyOL734TPMPRpQ1g0NlXc/AbXXv1RoRNxH6cjh1oMt73Z8fzwEXTKWgHrMoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E9zuLhY9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H7DGWbWm; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E9zuLhY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H7DGWbWm"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id D45561C00148
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 Apr 2024 05:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520274; x=1713606674; bh=wJq9K7g/wj
	Sy+aiO3mwHEOfHWBCcq6riUgB8PR/85FQ=; b=E9zuLhY9sw556ad1mWnM+Z1mIy
	Bb5PPU1ihrHyJsMzeZt5OIWLnx817WpwOJGjgHQGnvB3xzLOzPyuw8Jle2Zz85QZ
	3LR/2IbDzo8x8NW6ZnPzsF4tVMRSu2UiumY59kBl6RI9Z+4B2iUtwnO5qHwV7RHC
	d70WETAy2qLhUvfvXPggdCP2xz7UmZYitHebi6JKkslpdwRPbQKUhI4gzDUL1Kf3
	Dbz3kqMcDT25wsYN5DO6P77SXHdA6YQsROGRLfGGhc9XsDEx2lmK/VYwJFuqgua0
	jlDvm6i1CuXKJ1oOl+epINwODs75UGVNoCnCwyAXdrGdeLkCrWJjNWJ/+o2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520274; x=1713606674; bh=wJq9K7g/wjSy+aiO3mwHEOfHWBCc
	q6riUgB8PR/85FQ=; b=H7DGWbWmTkEJKugkxXn5pC6aFQn8tl5FQ6seS66aEru1
	NhJ+3wtkRBs/YeyWlqH400ZZv3I750rGr+EzqY1SSaEaWk4kVXEnRIDUNw6vLthb
	8qcip2jvDBudNolfp9GxtVd4zxatNkxTU4L4xA5qJh/nZc63o2u5NfriUByqzIld
	2L78E/CEx9zHEALjawFHxvPdjSNTjHNcFG+O0Wy7miAHSkq4n++bspql6by/TsvM
	U485mUS9uQWmRU+RUab46KYjOGxRn2MxVFUqMRK9lP4xG33CXCqJRlIFstyYy8sZ
	SzhlaRcMMTMBLWhD6exmxhyZFAePEZ+6yn4tfV512Q==
X-ME-Sender: <xms:kj4iZqU-2glsgK4n00mAVTN49sipLlpjlyClh2DBcNJcbozAjiwOPQ>
    <xme:kj4iZmkGR2SK3XzrY7wsxDgrFXsiBVdoEYflSveJplhuuxRXZSogYILm_VE0QWVR9
    odtYmQcvJDUT82tqA>
X-ME-Received: <xmr:kj4iZuZoLHDQ0p7_Mh0wAg8ZYe3K6BOzALUp8WaGVSRFr_ShZPl7Fbfc-T0uM8in48V0pV-WTu484cmR40s1oDFLirDHr4kYFWatz_PRVd3C9CcAqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kj4iZhW6EhZSNIe98WqxrODA39WsTbLMklIHlBx-2CwpA2m45oEePg>
    <xmx:kj4iZkndxzYzJ0gVFm3WwloLCs7yAvKusL27-1c5465YKGetVFjodA>
    <xmx:kj4iZmdqG7KNqeO5xCGTGM149W2sfT2vHVeAA7Tlc4LqFHKnb4RuhQ>
    <xmx:kj4iZmFp1lJmDsIstneR9aNaIu7Qvdl8gfPSACIJMkSXUIxQGhgz8Q>
    <xmx:kj4iZgsTXYXCTFJiek3kLrQBhY70RxoVxxAr2xuxbRdY1ax6kN7ktGbJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7fb2e957 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:50:46 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/11] path: harden validation of HEAD with non-standard
 hashes
Message-ID: <aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g67hNP87/bIvSHvX"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--g67hNP87/bIvSHvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `validate_headref()` function takes a path to a supposed "HEAD" file
and checks whether its format is something that we understand. It is
used as part of our repository discovery to check whether a specific
directory is a Git directory or not.

Part of the validation is a check for a detached HEAD that contains a
plain object ID. To do this validation we use `get_oid_hex()`, which
relies on `the_hash_algo`. At this point in time the hash algo cannot
yet be initialized though because we didn't yet read the Git config.
Consequently, it will always be the SHA1 hash algorithm.

In practice this works alright because `get_oid_hex()` only ends up
checking whether the prefix of the buffer is a valid object ID. And
because SHA1 is shorter than SHA256, the function will successfully
parse SHA256 object IDs, as well.

It is somewhat fragile though and not really the intent to only check
for SHA1. With this in mind, harden the code to use `get_oid_hex_any()`
to check whether the "HEAD" file parses as any known hash.

One might be hard pressed to tighten the check even further and fully
validate the file contents, not only the prefix. In practice though that
wouldn't make a lot of sense as it could be that the repository uses a
hash function that produces longer hashes than SHA256, but which the
current version of Git doesn't understand yet. We'd still want to detect
the repository as proper Git repository in that case, and we will fail
eventually with a proper error message that the hash isn't understood
when trying to set up the repostiory format.

It follows that we could just leave the current code intact, as in
practice the code change doesn't have any user visible impact. But it
also prepares us for `the_hash_algo` being unset when there is no
repositroy.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 67229edb9c..cc02165530 100644
--- a/path.c
+++ b/path.c
@@ -693,7 +693,7 @@ int validate_headref(const char *path)
 	/*
 	 * Is this a detached HEAD?
 	 */
-	if (!get_oid_hex(buffer, &oid))
+	if (get_oid_hex_any(buffer, &oid) !=3D GIT_HASH_UNKNOWN)
 		return 0;
=20
 	return -1;
--=20
2.44.GIT


--g67hNP87/bIvSHvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPo4ACgkQVbJhu7ck
PpRYWQ//Ue1BnG3JmFs1YX4HP7cUP3df0JNogaegGdbTh3ZrolutJjMPaDGEXUbg
xHQmLnKdEsajF123oOyA0noSgRC2PCVcA815FqlTBen95JhuflWGCXs40HobIJPK
8pN5Cves8mSOVugxhQtNWBzV/iP0wel27xhVKZe2qJXbEqIcnaFLGwWvYby9sbSx
xLAULozlqHo9EHxP+WevutfTkwbtesyQ6qgV+5Vlo4KNqfzMkweBJ9PA0ZU6fLZ6
ownPGKPK90VCaUzEVRiz6oGosAXGZLwG/IO5BHrY09KXrkIMCue6KkZ3sCSs38ht
sSJeiByR8ftCRfxaUrvPl0Ye/crnU7maJjT20iWpRvU3EvPhhMnqhYlIYeQ1g33U
uohwy1vHF2xFTwNelMRnSvQsr5HjPqmINvowiLQjNdsEbcc6rzq1YXPjkvC/bUrM
swP64AZvrc5CIRaz7/FsedyN8XnBcTjO+G0OzuSBiP3jHn8DtJHoMrLreOWa8EwN
upTmC97plFxCX3sX2ZuoVFoOFylK65Bbe/VxvMdTYPis8/yWxuuXhLRQ4Fy+CFjI
VuCGiMm4jQi/ODClEpoeVWO8JFfdoTIUcz/giyBgvwp5fdNCxsE44LGoMqD8vYwg
002klS6wit9w5ke+IG3s4QzB/tem4L3jU6T1qDt+aqaP8Q7ZYFg=
=jBdY
-----END PGP SIGNATURE-----

--g67hNP87/bIvSHvX--
