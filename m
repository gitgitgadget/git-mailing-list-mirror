Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942414A4F7
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723641; cv=none; b=WDqbliZlvcuumsc5C6P68YCc3OURCgPBwDUSB3e5/wyujm9TETa1U/BVRrnR0OgawD1eKhBNs+uxDi3pqAX7OTdMjd9/2lOi1KU8vjmLGNpsgqRQU2slsitPdtFA1sFL3rskxN2IL93gRVicgxSv/cYtrnP19C6vloQszVocss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723641; c=relaxed/simple;
	bh=N+vG1A4c1+IxuL8Pt/FumNcvUTh536wMhpXI8J3IhRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWi6A+saCl161TdeQl44pqUG2rry1QIqpJyxq1n4ICaA22J3oJVnvK8ltrEvVltkF9ylO3EkOWjX9Hh6HKupvi8ETJ0hcNSr5dUsgZszQaHDf4IF/oTifflqn8qYfLNxJtx/eTl5GTfA8riE1ZTevyHnGNHH1pTZ6M6yxHRr0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b3UAOu7N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aq//zmdV; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b3UAOu7N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aq//zmdV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5E01818000F9;
	Fri, 29 Mar 2024 10:47:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 29 Mar 2024 10:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711723637; x=1711810037; bh=TqN0JF9ikk
	6fQv14yj1FcNbAMb255TPwY7I/KwqGa2U=; b=b3UAOu7NdlacihSgLFn36BBF+U
	m5w2bBNMJkrfcuNv7X5CVrW4TDpKiflTGIbsK6dYf5tlCMYrr/y/RYsMBnX/MTgE
	E5qSX75ldsJDR6bUZhDWCCcolLMUMCW1g2vQf7UWdEKFzJaIpGu3hdAWQe6Kgvuq
	JhqeXPtY65BtptJmmRqNUqIL69kzrcm0fPN6aQXp6c5VmdfWXDSJlV/PYf44ddVa
	lQylrK4WxR31+KUNhQUP1mu4UFFQNGmKXPOS8upzzVkdbbN4+2wkkunw+WEuHhg1
	X+YCqD+BnEk8+AzCWTEWGzWhU8UYlBcrg+5TqlNzW6x7lyp80PJPzPwykbUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711723637; x=1711810037; bh=TqN0JF9ikk6fQv14yj1FcNbAMb25
	5TPwY7I/KwqGa2U=; b=aq//zmdVRh7GtI8h541MFdgjyqKJxK6kVA0HLMLCp1lY
	tgb9XGQ6hrx146bVHG8VKWXceEAil+Uk5zHgMX96YL8MHodtBQev4PMdZTp1EA6U
	mU31q+U2A6TD7fro10XycBXW4NYz3huCgI+6JbLJ/fJINqmIMqxs1jO8lIFFx5Pj
	CuDKL7zm9TLmKTKVgZyNQl4AGR5qMG8cWwfFkmJvKjlZLov3E07c+GKNAzGR1Pv1
	6G3lvzVWZHHwGeYHP5bX2Zgb1exqYpUWMyISRb2HiwGvct9PTS4oMu6JstvdIWWU
	vnlU/mvCImo5t75LeM/zPfdkD7g4zu/VqfPlvlLSiQ==
X-ME-Sender: <xms:ddQGZkeRxcTYntn9Xr3clWSR4fjlPaiHsTYwjMZnEhGk9T2afkKdwg>
    <xme:ddQGZmPBDhBEljpGIwYVzMbQPsnEqxFzoyBt_e1wkvWZv3ejQazdlr_DWoB13CBtC
    kT4hfvsTvJVfjNy1Q>
X-ME-Received: <xmr:ddQGZlihqzBPdqYCVljtp5LJtImO0BiRYMlJxY53FbzR7GGkBXEykqM_TCusAY7OvJuY0TVeOg9gxOkIFNKbQnWsUysg9i2JZB6bqXa2ufpi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hushgvrhcuihhnuchlihhnkhculdeitddmnecujfgurhepfffhvfevuffkfhggtggujges
    ghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceoph
    hssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdfhleetieduheejteetgffhuddv
    uefhteehjeekjeevvedvtdetgfduvdekteelnecuffhomhgrihhnpehpkhhsrdhimhdpkh
    gvrhhnvghlrdhorhhgpdhgohhoghhlvghsohhurhgtvgdrtghomhdpohhrrdgtiidpghhi
    thhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ddQGZp8uDD4iLvTHYsg1pE7jj08klDex5mNBfhGiNgWMOHuoqqvgdA>
    <xmx:ddQGZgt46nUleuBGHgYYkEAT8JQVK5mWjIBsiVHk_8auvtfQksh-jA>
    <xmx:ddQGZgGbuZE95bXLYbWiI36QA_ekwhuWUled7rqXwNXi-Z67Iioj6A>
    <xmx:ddQGZvN20wJvbQi4FElkSh43KP3Bot1OKQROC1OBEVYDFUkRE8XWGw>
    <xmx:ddQGZuCPZQZtVi1Sp74VezX-koEyStBLS2IfE3N5knUwy8L7iaaAtdvy_LQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 10:47:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1661a688 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Mar 2024 14:47:11 +0000 (UTC)
Date: Fri, 29 Mar 2024 15:47:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Olliver Schinagl <oliver@schinagl.nl>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/2] cook: update mirror URLs to use HTTPS
Message-ID: <a7ceeee328f1303eeaffe3ef2dc94955e0d2e47f.1711723543.git.ps@pks.im>
References: <Zf2B5oksaJRDH5WT@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Psr4QoL0UUHpMB3e"
Content-Disposition: inline
In-Reply-To: <Zf2B5oksaJRDH5WT@tanuki>


--Psr4QoL0UUHpMB3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of our mirror URLs are listed with the "git://" protocol even
though all of them actually support "https://". There is no good reason
to prefer the former over the latter. Quite on the contrary, given that
the "https://" protocol is encrypted it is a safer choice.

Update those mirror URLs to use "https://" protocols.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Announce          | 2 +-
 cook              | 6 +++---
 whats-cooking.txt | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Announce b/Announce
index 8ac01306e3..db0bedcdb0 100755
--- a/Announce
+++ b/Announce
@@ -113,7 +113,7 @@ cat <<\EOF
=20
   url =3D https://git.kernel.org/pub/scm/git/git
   url =3D https://kernel.googlesource.com/pub/scm/git/git
-  url =3D git://repo.or.cz/alt-git.git
+  url =3D https://repo.or.cz/alt-git.git
   url =3D https://github.com/gitster/git
 EOF
=20
diff --git a/cook b/cook
index 5fb2062574..b5450936a2 100755
--- a/cook
+++ b/cook
@@ -394,8 +394,8 @@ repositories have only a subset of branches.
=20
 With maint, master, next, seen, todo:
=20
-	git://git.kernel.org/pub/scm/git/git.git/
-	git://repo.or.cz/alt-git.git/
+	https://git.kernel.org/pub/scm/git/git.git/
+	https://repo.or.cz/alt-git.git/
 	https://kernel.googlesource.com/pub/scm/git/git/
 	https://github.com/git/git/
 	https://gitlab.com/git-scm/git/
@@ -409,7 +409,7 @@ are not sources, they are published in these repositori=
es for
 convenience (replace "htmldocs" with "manpages" for the manual
 pages):
=20
-	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
+	https://git.kernel.org/pub/scm/git/git-htmldocs.git/
 	https://github.com/gitster/git-htmldocs.git/
=20
 Release tarballs are available at:
diff --git a/whats-cooking.txt b/whats-cooking.txt
index 24e9fc51df..14f306df36 100644
--- a/whats-cooking.txt
+++ b/whats-cooking.txt
@@ -23,8 +23,8 @@ repositories have only a subset of branches.
=20
 With maint, master, next, seen, todo:
=20
-	git://git.kernel.org/pub/scm/git/git.git/
-	git://repo.or.cz/alt-git.git/
+	https://git.kernel.org/pub/scm/git/git.git/
+	https://repo.or.cz/alt-git.git/
 	https://kernel.googlesource.com/pub/scm/git/git/
 	https://github.com/git/git/
 	https://gitlab.com/git-scm/git/
@@ -38,7 +38,7 @@ are not sources, they are published in these repositories=
 for
 convenience (replace "htmldocs" with "manpages" for the manual
 pages):
=20
-	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
+	https://git.kernel.org/pub/scm/git/git-htmldocs.git/
 	https://github.com/gitster/git-htmldocs.git/
=20
 Release tarballs are available at:
--=20
2.44.0


--Psr4QoL0UUHpMB3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYG1HEACgkQVbJhu7ck
PpTQYg/+LKMv5XkWxr+uVZaFubCX2YqAkhSFJQ+QwQtdhz7SkCQ2x0lbS1p+NdsW
V7W0hFQ/4Waf94286lS29W3DpQVXRAuPvmjuN7H3Q5zn4ER8drrquKIBRw3EFW2v
6LBvUBWxfEGT+0n1tGlgXGGK8VnQ0xf9wODY7j+Wfj4/6ngUx9+pJLwjc6GZGVeg
B72SNN1E+U2v1vOh3Ju6MnDs0/8UE0FMfc5Q9cL1eYwkZKiJUcgVvfMUzuOK/Z5W
b0sKAuvRqRIGdbcJ+NFVHbARxp8sdObKkOqvF/rb28UPrHwGNPUI1rY+AX8oE20U
ggPf5Z0EQtBn/yN2gRj+V5Ft1Snt0rT9lGkh+CngeBRDX6cUMt4At9TccAlfbhQY
gDFNskhnNv21OtiBUzDKmooXLg0XIUw2CDPCxTtO2kd0fzu4COZrt2OdV7OGvkPr
ipq3ttWO6mVRa6Xe+6M7nCWGc/XPAFra7/dXQc+uYltE3Vlh7r3AlniS/ZwPKrRR
ViRmtT97laGnVdfg+xWDh2c+Qs7H4IoVeI7dAhHd3eRZorNcn0uRxxEQ/zty/86b
jbq1RPiNTwpMpZix79jW9HXJPuArh/wp4CxnWrcSxuBWDrbM24hBtrCiqTjYUIMT
zO478P2jourgshc5cNhb59xfTEQu8OXpH9TdtCFz6YR7xI0Fheg=
=iqnv
-----END PGP SIGNATURE-----

--Psr4QoL0UUHpMB3e--
