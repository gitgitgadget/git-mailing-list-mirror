Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF56153BC7
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743552; cv=none; b=UROXU9QCWB24P0qRotdBSZNdBzzFf3vOMPgmwGlSHnPHAKBSgXEIx/xojKXJ5LX44QaCIpahbvZzre+yZarob1nEnMI/ieF610oBW5RWedQl3zoJv62j7XjbyOQJbO9unnzhWKuD/hc4b1fNaq7Q8OX0fNLixKqVEt907wYkbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743552; c=relaxed/simple;
	bh=iu9YX4al7GWHHDDaBiJg3wBZIv0MqBNSBDWtS5P8X/4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNjhgIkh/9Kabhk9+PNja7P9BRQb9uB3OIH2u19T9+20cZqIoyZzmBf52WlCXMv19uzQhIjyv3KGsMYg0hw+H9+OYDVT3K+TRKnKhaLaezYsju0I22skHENHnvhZxq4aPBv5GKEibKPb+CSbo6tfIs5ZFyVhvHm+i2ayefwRPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yk6zajnF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IStM4FR9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yk6zajnF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IStM4FR9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6379913801FF
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Jul 2024 10:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721743549; x=1721829949; bh=iu9YX4al7G
	WHHDDaBiJg3wBZIv0MqBNSBDWtS5P8X/4=; b=Yk6zajnFumxIswzTZX0d6D4oL3
	U6XQwr13N+5Shl6pz/a+T6pO84cHe1sYDkTDB1QgNRxyPXSdIbJsZLBqpQHF6xZw
	bYzXIl5Rq4hyi4pQzX6wNMgBlDerGTUw1Yie13v7lPpi9My7vCWSF12ruJD3dJZU
	2x2qJtMfobMaLsltUTs/+1CLnT8Q1kC3bRss9D1JZTcnOcWpZ50bVhe2sxtbbcXD
	8mQg2M8/v3w1UpbeS5QZFnWINlWezjAipRuc0EqPDcRgyGxcNlT42Q0SzHyKuWjJ
	QXWVkf/JBhnn4bhKewG7y77rGB7I+rypmFvraZ6ValBMTMEqezGea4ChpVDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721743549; x=1721829949; bh=iu9YX4al7GWHHDDaBiJg3wBZIv0M
	qBNSBDWtS5P8X/4=; b=IStM4FR9j1rirv11NwtJMS3FIY9QkcD/rGEXjTbl/saS
	36z9ixutaeLinmCmNUTT6UBrZatUoQ8ZD3no3lzh2bkZEAQJ3fNyAT8QtQfMb4wy
	ebzCiNfDGAr5Oj/c2C8F8iUR6KR7Xl8H6ZrTC+rEIclZHqmVokkcjnlVjl3y5p9S
	1BW+ntJl09esoZeizhgNP5WvMHZseWVU1c9HOXJScs3vNVwJ88YgJXFLDkKEUIgz
	YXVZleX8tjqYXPj0Y2/1fqhu0D7sGELiioPMn7RFLHPjMe6sHkaTtbDwBcEMXeQ8
	fJF5fQYL8Zah3+I7umstWEUrvwZTxQG7FkF4qbFDVw==
X-ME-Sender: <xms:vbifZvwxkLQhx-x5JKsye99u64w6ewYG9-Uks5zOhgsca9yywK_evw>
    <xme:vbifZnTMk1LxRwnncw2MihuWWriWR5iPEeo6VHGVnOSkCyzQF2n_R2fNOr7TfAYrr
    s1uyW04vefw5LgfLQ>
X-ME-Received: <xmr:vbifZpWd7vym_ugfbbhSKxeQYysP7IPLVDxTEiwOi7BRyO0ANZhpexXFYPAEe83zhs9oDPrLq9Xv5aSytafraeM0-JrV8qWsOdZtQyJ5pUB4iqkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeekheekkedvkedvheeguefhvddvkefgvddtfe
    ejheevtdetuddtgeeutdduleetheenucffohhmrghinhepphgvrhhfohhrtggvrdgtohhm
    pdhgihhthhhusgdrtghomhdpvggtlhhiphhsvgdrohhrghdpvddtvdefudduvdeludeghe
    dtqdhrrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:vbifZphibNPa_oXZm8zPWkzOXteZEuVqZ-2kD179YmSg4xaTXRkYWg>
    <xmx:vbifZhBPHlZqz0dMTcZk7KAUiTy-lQLI9FFTjCGWtjARAG-4jXNijA>
    <xmx:vbifZiKmlilCYTDQVphJJsCLNuH2neDoUT0SPPlZCPSD3IxoSQ0Kuw>
    <xmx:vbifZgDaXCRJjm1umiLvY-u_IOW1kjYKOul5bzn1pvkIANK53jrfxQ>
    <xmx:vbifZu4ohFVNv51PItAc7y1g6v6iU17ZsPLJRVtTRNFyP5owt_Tlnmzk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6d6ee2a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 23 Jul 2024 14:04:30 +0000 (UTC)
Date: Tue, 23 Jul 2024 16:05:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/3] ci: update Perforce version to r23.2
Message-ID: <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
References: <cover.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FItOZVQ0t3x3P+9A"
Content-Disposition: inline
In-Reply-To: <cover.1721740612.git.ps@pks.im>


--FItOZVQ0t3x3P+9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Update our Perforce version from r21.2 to r23.2. Note that the updated
version is not the newest version. Instead, it is the last version where
the way that Perforce is being distributed remains the same as in r21.2.
Newer releases stopped distributing p4 and p4d executablesas well as the
macOS archives directly and would thus require more work.

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
2.46.0.rc1.dirty


--FItOZVQ0t3x3P+9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafuLUACgkQVbJhu7ck
PpQSOQ//WzVHZqjeskvbQnHYRkpELS5KMMCf3Zr496OS/O/7gdsFmLHbpd9tJT/u
aiYIxw33nDxePNGwSV3REJG9P2lBTpymaBO7aJG1GBai7xeJ8jwwDphMtM3CrRyl
sutFonm6zgT0H0gYLiBHHS5vTkhDRUxiKB74CQccAiYQz2CmBF7iCCk3NRQ0HTTB
bCLgjUPLfIFZj3WX2tW4Q7zwNZ8AFCn+H34jyziRWKPKvUhtSyQ3bCybccNxcQoz
uXzrg77yX7cZJDOnZhm9S95odKZkR5Su36vRrJjBft5FBdUg9ByTjsvFGDvCSfj1
/YZA2AxUR/IrRUPE3Ct3CPIn4pWL17vA2IctqrL9wBWZOq2c8stLqKdZX/ijftHm
rxLwdWEPQDPC5eUfBHGsmEUKCVBBPURZJ28bf6paBGm3ad+dFFdrvnCXpEJvgCpJ
dLj6y3nB+Cr1ELAmxfyAFEZnnNgB/qNxTu5jgK51ePem/g7qI3BGEnn3dFT8/AQA
tiBGeTbpZWC/aXwsBd1iqWZVJhGfaZw7RERxqQxFOsiKLET8zoOVfxXdMXR6wcjr
SYfwq4wzgHl1/kb3UeGUUklah1cqH/d/BykQ2cY2GZOKnIISn5qfGujardjFFDJt
oxeLHGKCDmK8TH2Gby/wigUWde2fF7rScu9rDwYVn/wc2uIB9E0=
=pmoK
-----END PGP SIGNATURE-----

--FItOZVQ0t3x3P+9A--
