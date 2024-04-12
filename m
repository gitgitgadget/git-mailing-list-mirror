Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC941C6A6
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897073; cv=none; b=sqw/cIf1VIweojfHMxsnkmLQBio94rfJDgFjDUnEG3YPAgX+qGDyocm+wT605nIVhK7kOHVMuPM76dNO/aFjT8d0G+D3FmVIthoNGsKLcdfhB/uvqTB68Kj90oBXzP/OOpi+GA3dsb2mbb3fSJC8WqDOgevuyspP+vVEp1gf910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897073; c=relaxed/simple;
	bh=YXb1wbEfkL6YD8EFiigXxpsrVBVhgx7JOWECpuz4/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgi4l76+GyRc84Ae2j3ExFiosWn1XwhGULWWMl+g7ncuotFn4I3RTogXM0Wb0YyDUl7avWE/08qMoD2mRZss7eZ8v4V3zwuE6LxO5yvQBqZOHqHQC0rsWtklsttx+Y9YbwmehCAufi64pSgeZtnzENim2TrxVssnkgpQonjV/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D1n5X46W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZ4maJ1C; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D1n5X46W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZ4maJ1C"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AC32011401D7;
	Fri, 12 Apr 2024 00:44:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Apr 2024 00:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897070; x=1712983470; bh=g8YDcIxG0H
	IRrsZLKSGpb9LIPFoJ/abZgLCbVxni9PE=; b=D1n5X46WNIINCpreN+i1+qI8gP
	7O93pM3a5072seVnselyg2S+30kwI7WN71TcyOGJJSvp9KdQuuXK0DcWr/1l19en
	q7hiU0YIcVkwQYI9rhQzVTejHLRCStD1hPiCVF0sKvWFR3qtcRwFWea2NH1hCoq0
	souwJdQ4lnilUbBNALZvPc0Lt2TaUK1JSDcvxUlsuGfPMHvy5LH6TAZwsCKErOq3
	CW85dZA5O/mRuBAs658gE9LFVXqgJE0R6r1CmC3D9E15e6yGLK98ggR4gkDGNZyj
	ED03ktVJaTGHpprZw01EjLXcdK484UDmkH8e9qzNqSq3b/JAo6+aouFzGyRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897070; x=1712983470; bh=g8YDcIxG0HIRrsZLKSGpb9LIPFoJ
	/abZgLCbVxni9PE=; b=jZ4maJ1Cmnp42yq0LnHgsre2jHZvgM+r973ZUwN0E5hT
	sGuKlaw7yovjTT0B8QJHq7kUixS2DZFc+Hfi1A+Mv1F6lzsaoU8AkDXhGcAQdNCJ
	1ZKd/Rsu6vapRiHk3CoTgfPZTm8nCRvcJmokFRuc+ko/M1PJgmCkZ/yhAThEKQ4o
	ZvnHWu34X276CP229AI1P+7qPEBklA6SdQFZNkHUQYd6Urt18rF2JgZg3TF0UOMh
	Fb78G6/26kX4Dqv++NOY09VDDlK3kumL+TxTh2yXvj+rs3iotajD/1mycE1HX9AH
	W1vK1a/khFzNyt7LlLH1Zckz+AuoYKgFuABB148siw==
X-ME-Sender: <xms:LrwYZk8PyIFMpQktPPOyNNR6z3iEXg2Af7qARQ53utYWsH_sfRnoeQ>
    <xme:LrwYZsuauebAlGf_1K_J198r8uU_hsPv_UZAmygjh79vis9HYU12QO9p8sv0-RTLE
    X56qJCDNKtQbllvDg>
X-ME-Received: <xmr:LrwYZqCinbLZBI7-UoEYz06wFFEdDTE99PlUR9d6CU-IR527phrE9sI7YELrQ3_EVUpjbaiHsL-fZ_Rf-yCWNAja3Ql9robJj2OB-7V42CJbyeDNpa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LrwYZkdqnZ3uPel2lbEnUkssOqzGYkTdqvhdi-YYFhX9oSsUzTebfg>
    <xmx:LrwYZpPOOVFsfmqHQp7IXmhW_B6MJcMfsBFclkQIfaK5P-oOC_YndQ>
    <xmx:LrwYZumin-8-hM4dykynsEgsuRCzJeTek1HGYNb-Yrb9PkOe8LFjhg>
    <xmx:LrwYZrtEvyKOavpb_qkpDW_YaPF3aY4_vDsbBSp7QLGs-ucz2pzSDw>
    <xmx:LrwYZsdtuz609dbQRblpHlkb1Gu9fbGOoqcwhGuXeBq8HYX-y7Ckbu9W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 27b59c85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:15 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 07/13] ci: fix setup of custom path for GitLab CI
Message-ID: <9fc462b578b74ecc34aaeda5a1c8bcf3e0ba66ff.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZBw+y4g2OGkT84wi"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--ZBw+y4g2OGkT84wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Part of "install-dependencies.sh" is to install some binaries required
for tests into a custom directory that gets added to the PATH. This
directory is located at "$HOME/path" and thus depends on the current
user that the script executes as.

This creates problems for GitLab CI, which installs dependencies as the
root user, but runs tests as a separate, unprivileged user. As their
respective home directories are different, we will end up using two
different custom path directories. Consequently, the unprivileged user
will not be able to find the binaries that were set up as root user.

Fix this issue by allowing CI to override the custom path, which allows
GitLab to set up a constant value that isn't derived from "$HOME".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 ++
 ci/lib.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0fa2fe90b..3a0ef4d4d4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,8 @@ workflow:
=20
 test:linux:
   image: $image
+  variables:
+    CUSTOM_PATH: "/custom"
   before_script:
     - ./ci/install-docker-dependencies.sh
   script:
diff --git a/ci/lib.sh b/ci/lib.sh
index 4cce854bad..473a2d0348 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -350,7 +350,7 @@ macos-*)
 	;;
 esac
=20
-CUSTOM_PATH=3D"$HOME/path"
+CUSTOM_PATH=3D"${CUSTOM_PATH:-$HOME/path}"
 export PATH=3D"$CUSTOM_PATH:$PATH"
=20
 case "$jobname" in
--=20
2.44.GIT


--ZBw+y4g2OGkT84wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvCoACgkQVbJhu7ck
PpRt7w//SQInmFwwHnehoi8dhbczKZRbaPDi9HOcVP5VFWW/gTpB+M4+LrEjPoD0
x5dMLiAlB5akBOkTfeGBsuE1a/36cZ6SotbgAp3n6qhFdpeBPIwvZ1FcEoYBXrfA
1Urj9gMFwGBY2hCIyczLv572xaP6QpasHQTs96bgaX41hDHa4aYVYcQkm32/o4oC
JMz5c0pnZ5udHAY41fkD5Uam8fhj9AjfNcHTOHZTTMpcgfDGeB4gCfVF1Yslo6Yr
mfTdmqOCwHXXwMJcXvXT6/dI1aoze5cqwpHW21qTDD3LQsdPQHMDfiALYl4OzsBf
62XE2KfbDz7qyIUB8KFELiwf5RRMgrOuyTypL5YQhYvXcT+BEseViDZwKtwD2gvZ
gdcLLuLRRbh4DjkxftHHzLwcHQMoosNzzpzs+zpRMP1FwJFfqfFVtXHucGS+sTVf
wAnOzCEHnXG/LQh8UOWU5PJDEmZ+hZYxv8DMsu6HUvsK+UOhCbA0+nOMNjAN6Spk
IlHvY89wDi6efkEy89V9WcfTWhrCTR5Y8PCuEnYUbDUhj/hlkaZ8fEx1j99MiZRc
9VTWwhfp2gwxVRuL2ig1PS3qw+IPDxDL3uW4dCXQqWf6ls/WsZS7Nfsu/HMnPCAh
utTyPHc91pl3yItf9gFIJXOzi51+x0xgDxZV/2ZXNinhPsmEljg=
=vuwY
-----END PGP SIGNATURE-----

--ZBw+y4g2OGkT84wi--
