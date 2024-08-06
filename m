Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1711BD50E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934859; cv=none; b=m4jmREr0NVnomeMNuZnq73GaBq/layv8wD3gEADanbXWyB6K2L/o+gAOgmelJ+Zz8F7i4r3Mfx0PbW7u5mUf7GkH6TJqDHBe3QIDJ2tZOSk7JoHJdcoMiZRO6NWgmbfN+qUO+sna9xXFGwW/a8Q7Hgz9Bb7zxerhDx2K/vh8KLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934859; c=relaxed/simple;
	bh=cjH81uPF44ZA/Z7apOCOmJ7XDFYulO2y/ZxmHIFw6Ew=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwtTjq0Mjn26uhRtHzPdUJb9LWsaGLw4iusZn2ojPsPiWIueEy63Uxf7NCtECpe5le939w3BvuzBhiJnj2RzOmX0th+6fkcf+V+O1d6yRa71K/zu0A6itpi3tmyPkJi/xfbSggBN1mGi9CaqOA3l9cKI6KWiaPx8AreZgRBVUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C/plcnC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aNzz07e6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C/plcnC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNzz07e6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5D0C1151B49
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 05:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934857; x=1723021257; bh=KedPxlBv+I
	Hm/Hc6kcL9fpPraYVC7Z93lWRaSb4x8IM=; b=C/plcnC4l82U6q3w0bZjERs8KM
	T06k862NJwpJNa79uxJtC4nh4jh6cSxiiBfObryFrhvtagB21PQVDnAMsw5zTqKk
	wZao9Ii1d4ITFo5G6fMtjOs25em/Y6p9tgUaI/WZ/TecvVp9rnNgqwqdNDmc33XS
	ME1gRkpa2yIx6b4IzC9FkXdvCHQp1orWQgadk2fwnyEczeZPyHCAf8ebb5JEIqgS
	lk+Rkh1sJkwKsLb5TXj5AWq+ftpW4cKhdKs4x0LM0csAcg6la65I3VD3NUUKfhbl
	FZ97piFs0NlcckTW0PgC7BMm3d9yNaBYsUQP+CAXsTZOYZ0XQbalicYAydZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934857; x=1723021257; bh=KedPxlBv+IHm/Hc6kcL9fpPraYVC
	7Z93lWRaSb4x8IM=; b=aNzz07e6z4gCyI3K00b4XSlqFGXthb4RQfXEyVCQqyPb
	dbyrej7XFF34MNlB7SqnOsNbL9s+p5pktJ5xRiLdSBPDxtphlSKTHQ6Hld2H3b2t
	6A5wXeOZZ6gCsC20wzKkDZfl6d2xeX+5gJNWnT568MZMwR5EYY5cn59SbT1PHdDz
	kxSX8yilZ2uwXXtbrNG4c6v/pnwGOuj6qTTWoBMqpQsfZWJ+aiNRRy1A0rdAqkkl
	AMEWOsJCKMjtqF12xNHMtDIiBrqn2Mit0NqpppFAHs7BLxIvYxlpDMEKXb0BnVLh
	t47SjVlB0O76lB0WylfOm2pvOXrfSLjYIbW/ocrWew==
X-ME-Sender: <xms:SeaxZtcMc4DRTYrAzZ62N51VuVO2scjhEqoLtqDnIRM8UhKa2H32VA>
    <xme:SeaxZrO9r55xxOW1fACKVe_E56_B0U-cuJEBONf9cgu8w6HQXsRAeY8ZpgcnCrGIh
    YuiKKIEnkZpmR2DoA>
X-ME-Received: <xmr:SeaxZmjvpoc7VGQvyAnKunH3bxxbnSSGhPTbSqIsC8PMwWrc-t7p1Qr_8aLFQoJIfQV4RDCPJMKo-s-nM_Grmv9VLsBR_tflUIG3Jxot7QY->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:SeaxZm_L7uVYaefv_59fISVxF25G9CB4RkM2JIHt3bN5T6szcZKjUQ>
    <xmx:SeaxZpscCnrdFAVFk6mI2hUyZ2d_QHc00mY5vMjrhVDJskj2F6_h5w>
    <xmx:SeaxZlEMzFXAvZwFPnfqQ0n9BwBS6-rJq45jlsnY60VTSbsTbVMm6A>
    <xmx:SeaxZgOWO-aw7_LcW1kBqaEz7rHE_RRb1kfENGs6XXJ0NOFUkV-E3w>
    <xmx:SeaxZqU1hGf8GypScDnMg8I39wVd7_bq_kpCOYOZtKmPxKvSIdc_9__6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bed146b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:54 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/22] diff: fix leak when parsing invalid ignore regex option
Message-ID: <c6db8df324b4a33a73e97071c99fc9df62471cd4.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pMCmDmgvXK3/XWe"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--7pMCmDmgvXK3/XWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When parsing invalid ignore regexes passed via the `-I` option we don't
free already-allocated memory, leading to a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                  | 6 +++++-
 t/t4013-diff-various.sh | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ebb7538e04..9251c47b72 100644
--- a/diff.c
+++ b/diff.c
@@ -5464,9 +5464,13 @@ static int diff_opt_ignore_regex(const struct option=
 *opt,
 	regex_t *regex;
=20
 	BUG_ON_OPT_NEG(unset);
+
 	regex =3D xmalloc(sizeof(*regex));
-	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
+	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE)) {
+		free(regex);
 		return error(_("invalid regex given to -I: '%s'"), arg);
+	}
+
 	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
 		   options->ignore_regex_alloc);
 	options->ignore_regex[options->ignore_regex_nr++] =3D regex;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3855d68dbc..87d248d034 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -8,6 +8,7 @@ test_description=3D'Various diff formatting options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
=20
--=20
2.46.0.dirty


--7pMCmDmgvXK3/XWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5kUACgkQVbJhu7ck
PpS26A//e990M4e7ljzJm6LUOOg5oucRRpymt0lurSN+Kg+V2Iyphr7b1Zq8l7ee
nsxqsQvb8sBnZ2ssiNqQLskyUN1mOTRAYi6pv/X/n3/OtQTGksOFqW48PO8AEgPL
wZSeoiMuaE7nmBvHUzYk2p75C1UFb7hfXMtjagPRjU0DXoYFhhiNLJApZIq13FLp
obu+AdJwulPn8OBh3z8yw9PVpQEaks86o1hhCWx/Swc/LoCdrf7XUVT+AcyRcnhX
BcYPjq41XpsRWG1FQZPom5dTh8Ol8tOa3+NW46YujvB04HQH0Oi+Qw3yaZ2UHd9c
K0DIm3/bjAy3gCSUDS0FiNnlqaGNmWyLWfRcfWx/yYSjinKhWJmTmO+d8S9TcCFv
4szBjzJ0pUmgtt4DdBhPjHVYdxD8Md1OwU1iKRz1VSSazftAG78empKjv/mLH/yO
e8dmLvGxzH2Y5kwlYv9U484ZW9LiR7dNc6l4A//X/RIrusjFrHEJU25P2iKJGc+l
jLVROVETIvG3BibYlzsUWfGYd4r667cdB4JcLUORKv9sLTD8UNu2eaIQHIC2U+y6
HfRfYvNwKAriVq8SFBxKEVCZTZJClvlrUauLLZcVC27TuoFVjoOt9i8/EjHd0LJ2
ijFpbbM/hLWNW8XVa1a9pNWhf+COEYlFF3/mdeC1s+twPicNwfw=
=LfBt
-----END PGP SIGNATURE-----

--7pMCmDmgvXK3/XWe--
