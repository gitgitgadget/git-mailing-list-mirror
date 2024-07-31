Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFC1AAE13
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422271; cv=none; b=TuXYAFucf5mc0pgnp5vFANSM+GSbvBQVmlrF+C5zH+oaiUl1ENZdWOhkOluK2TWlua9fik5nMwlq4cUV1JbavMGlhm6YWGCKroMOLpCRqlLrPxaLnKAyrDSQvhqMJK54IzStAuABatf37CaNV/L7y5o+CA17Wvae/WWI4eDLB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422271; c=relaxed/simple;
	bh=ZPacNASHAPXrvwaSBh74D44vrA4Snx0+/Qa5pkmqgH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/dEcczW3+3RwbO4jxq3tjNtnSN5uZk0GXY+0rbaww7V8FWIOjt2pyZ6/Revzsu7Jh+mJBB7mbRmDqnaGqdisUrL+wvs/0cyxr+2PcKbQRNl9ta67dmOZvG00DbRDD32xXEPA0jzKSwncsMgAXLOkSU4pDiKS5H23GbP9iOIze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WzG/xZsi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAx63eHf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WzG/xZsi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAx63eHf"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C3C2E1146E15;
	Wed, 31 Jul 2024 06:37:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 06:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722422268; x=1722508668; bh=ZPacNASHAP
	XrvwaSBh74D44vrA4Snx0+/Qa5pkmqgH8=; b=WzG/xZsi/sR13e6RFvFetJIAmd
	8nvEbgnQdLFp6P3oNJZxpWczzIoGaf/bbieUZEVXhvHSgHEhL7MWYClioNN1U+Q3
	lVcmyyHnch4g58Oms2LbvmmEZ0JOtRskY/WOK2kVnNMAPhoGruMpEylRSqiTIMV5
	RoWIPKbLEDJgppI25yQ8CiSBybnU/+o3nqXEsTOWdHAtc7xDgbASnOd/ks8sv4iX
	vfXKDdrZCJxyJntt9gJ8WzQbqkvR+qQS+kReAXjxZGZC1f8foYI/nkYFxf3w0o2+
	d9HTsPClGi8r3v1zuKK6bXlPzNTGgmBMnGuhqh+nP7eAquSWUzPdNwk8It7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722422268; x=1722508668; bh=ZPacNASHAPXrvwaSBh74D44vrA4S
	nx0+/Qa5pkmqgH8=; b=oAx63eHfwbufeKtckBvPVssGO7kNskE9WsrXIJegGgNj
	57m/OzqMHNGch89hoeudPZJ2Kiywcejcb4p/cUGGk3LYPfrS+xN30rmczU6ol9iR
	sNF7DNMifpws5QWkzIe4Fvr9gWoTF2v0BgUMQtGOD8r5KuVHeJ48+IEzLhicyCwR
	LiHZNltWKvPV8x0j0w+sBazMNldEL2z2DomFY/fOCa+odrHUcrjDAdfoPv8wzBmZ
	PeYoPLZLY0nvJ//WM25AV5TmLAuoggauTjT0mgVQojS0oP1OFEOEwM/lTDEO9CLG
	rh9ndle8oyAJcyNuJeQO4DuuFOqtEjAeVdsaT9r0tA==
X-ME-Sender: <xms:_BOqZtzjrOa0Mtd7HwFSYhdZg8nIV4lC1CJKvpCfjF-5ufCqGKVxXQ>
    <xme:_BOqZtTIGqv9RTMiH_CoVXQF-N0N8T47Ms0bRorwbP749ZlAx0Jd8NE5mOH4FPshv
    mq-bPEB50v5J5iDTg>
X-ME-Received: <xmr:_BOqZnVSpt2ey6EFiY54QLjUzIO8lcOB95OtP6fxuZsEg1a-Pk36wNOkdsETlqGgr6MiEjrVYkWar9Titbp16b26gqg4b9ijFGzI3MF_laNBZdlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfdvuefhudduffeuudffgfffheegudegiedvvdejuefgjeduieekvdfggfetieen
    ucffohhmrghinhepphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhdpvggtlh
    hiphhsvgdrohhrghdpvddtvdefudduvdeludeghedtqdhrrdhshhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedt
X-ME-Proxy: <xmx:_BOqZvilpYx08pp-NHEMx4S4MTS9qM99ExjWDcPeAUeAyv9SSgtQ5Q>
    <xmx:_BOqZvA-iAK4Ay0X84CqZ0zpFBZDHYZ91pG4jsl2zyYVcvwmsuC4iQ>
    <xmx:_BOqZoIItSKKsg7E5QCUOshqMc5M-AiXP_kMbL6p2wKPt_SuUatJTA>
    <xmx:_BOqZuD8LnMq1WOrpPK_XrPvu7_nhVHxGHMJxEkkJSff1_dWj2OGUA>
    <xmx:_BOqZq9HbwmEi4vz3ApaOz6jZWqxhTjR4PAHLJBaC0qCn8baSGI0dujO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:37:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b6a2d535 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:36:18 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:37:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] ci: update Perforce version to r23.2
Message-ID: <f41473d991e197bb5722aca877b8fa72354ea770.1722421911.git.ps@pks.im>
References: <cover.1721740612.git.ps@pks.im>
 <cover.1722421911.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="blZ+ldv1iRrB3PFo"
Content-Disposition: inline
In-Reply-To: <cover.1722421911.git.ps@pks.im>


--blZ+ldv1iRrB3PFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Update our Perforce version from r21.2 to r23.2. Note that the updated
version is not the newest version. Instead, it is the last version where
the way that Perforce is being distributed remains the same as in r21.2.
Newer releases stopped distributing p4 and p4d executables as well as
the macOS archives directly and would thus require more work.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6ec0f85972..b59fd7c1fd 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -7,7 +7,7 @@
=20
 begin_group "Install dependencies"
=20
-P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r21.2
+P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r23.2
 LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LINUX_GI=
T_LFS_VERSION
 JGITWHENCE=3Dhttps://repo.eclipse.org/content/groups/releases//org/eclipse=
/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.=
202311291450-r.sh
=20
--=20
2.46.0.dirty


--blZ+ldv1iRrB3PFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqE/gACgkQVbJhu7ck
PpTyCg//b/4NJbnMORzfAworEY/o6Fp0Ul3yuRpbDmEUZPnFQQqMMaB9Qa/+nPpn
Su2qtBE7UE5xc2TZRSqt8SildyffhEcJOXf8b4DBVq3j8CXVtYNQYOMEnfDj7Y9H
v9G3LNmWOGmLaxEhWLXQYG39kftnegIk3Y4rtkmF/bmiJSdOnG1jlm/3hGx0xN8k
IJ4vwZvhhfkxGk9lawgFSCSY/kWtsmAK0lD9aY/fYtuLwTuGuWrP6HW0NWtAfv79
WlDKcVU4iTHiPJ1Dx/PMkuTMacVJZrv7vaAL7qScNO80oSG2tLzwg95p/1W9kJog
duGH/hDB+brq8vKEOlEisnCGPUSVLDbHx92WStHAaF10cK/1TY8re6zrcwvlwWng
I2HsMkQAf0fGd7WFK2tOg+9HBA+vtLlAWloYbDNqUIcaJaMR6gK6qH0W2/F1GKbg
pXWnX6DvHSIXCWJfA0tsfK2KuPbbkrm6QOiYknBxyCpB1keke+3vIsHJEI6TrN0k
GYDR7LBMxa04v7cryzFlh9fWdG/eR1aBFJIeNefNW7FxekMx600da7hlsqxdgCXP
umTqm6D39LkKg5F3JEpAGR6LN3XT7j8nlEeN6q5nufFVyh5RoJYW90U3Eicq8X0M
jN4PXBS7YWm63xL1zfqmEa+RsferLTQVPTLqfVQbNKglBhIel/o=
=SeTy
-----END PGP SIGNATURE-----

--blZ+ldv1iRrB3PFo--
