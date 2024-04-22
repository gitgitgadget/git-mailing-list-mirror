Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD841391
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767717; cv=none; b=h7/cYmRHecOifb5EmYPHVIrThjHfViF+A7UHft87FAcgZ5YZiPbVluVTTySz7/iBKwXuYe0j6aoqyF3TThSBXJI5Afrbg2JpdaIyXBg2a/UYAGcO8Wdyf+XSdvoLdyQLCEP/U+Mzr/0PeP+CcFf5S5BAeyEGLj0ocbBINYWG1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767717; c=relaxed/simple;
	bh=JlIG5KXpOdBSCyQzAvn9u5+JEtdgxBAZVsZLyX3/XB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUc8EgII0KAQ+JgB+PQik8XRDP9/JHq0+RclZp3TFnYYPH9Ri4lHVSSHcKSEuunbvvpm0lfchCBZ08jFSATnkFcU0HFhDaCafqoKhTOBNBrG+iwi0JfiAW0Ho5e94kKZFvIV37mw8rNMJgpy+r+ZaxGhbuOxcVpVqX1Cs0ntR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qoM7WCQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kaAVLa7N; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qoM7WCQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaAVLa7N"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0151E18000F5;
	Mon, 22 Apr 2024 02:35:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 22 Apr 2024 02:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713767714; x=1713854114; bh=zNHm6y9V8/
	adio9kO4OTwL67jOVnNkKINSq1NZMka/A=; b=qoM7WCQMNfy3y+5s+br+L5ebXm
	0k/0sCyeqJpClHsffgq+EICv/MLk8cm1z+PnfAH45JYPIuZfdx/Pli2L6LceI5On
	FawYTeW66l32n8Wqiw4ahzLCBIyJcqZIpldeA0CfIM4f8sbWBdCm+nSt5FKr7KAj
	Q22hbTAVF5xsNLb8xPr2COJXJAQFu4QvExFvUnPgHCZJKODUtcc7IlPVLfFz+wWx
	z7Vg3zJe4/W5h6k9al/7Frx8hLQ2gmtEiKN6WSX9hffYisb4/pYMqITeIrVCS0B8
	cQe88aZvk9o9qe1GXPxcK4x5DyfAgBMIAqAsHHFQg9UXkqYp/EvYacQ88zbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713767714; x=1713854114; bh=zNHm6y9V8/adio9kO4OTwL67jOVn
	NkKINSq1NZMka/A=; b=kaAVLa7NTvQKGQecs4G5HnCK6eTsGWoDhDAsKByJCTqN
	xUmOhulEqw1npzQXqWFB4SJ308eeq+qSR4BZUg/xo8DVvTN91X8BWlcru8NNyhl1
	MvWCBhanDhkQg3gNFBdvYk/ENjk0eZSAJ140uWAokm0ileP/HW0tL9ezwq8KfbCX
	UYAYWOPx4fWSax0mtRsr0nr0OikjUvBoF4p2k+1Wsiegg6+fqsEukP7feOePx7Kp
	Aa0jxK1YdN65heihTBquCCWJaITLrmEz8TbIUxQKBXghddNLUOoHVKGGOHgTrTz7
	04wLUcz4q2MtKEVTnmHyK58k4vEtxDb194WJGCx6TQ==
X-ME-Sender: <xms:IgUmZmWsGHBtrvlp5MrXe_2adVswCznwApu-kvxo0NWgoqT82ijPIg>
    <xme:IgUmZilBdrAe57EGF6M7dK5DCMiI3VbEGRUTpau-1fRmBovDkuKZewW7osrUOYP9S
    IvchLUXYqhOMOemWQ>
X-ME-Received: <xmr:IgUmZqbsEPjIgx0wWidcIIzHIxlO1mnaQb1jecTVMRBtKmuhqmeewMvYmNP6W9gRS57mQfOMcsqO1HGo4_uFVATGB1ksnVFClVWOIl-STcQnfhfP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IgUmZtVSvTWDXIlhUyW4IKv_xyOZM0jeH1XOoi8LutliPQTVXQTM2w>
    <xmx:IgUmZglnp0ho9tgPCVk-35gTenjAp41Flqm-y6tFb5ODraQzN_v5bQ>
    <xmx:IgUmZieRC6FURVb1vlYu39VEH1uDinZa4tSz14sdUghACYb0TifT1g>
    <xmx:IgUmZiFp5wpDLly7avjcDy0rtMAzk6w-1aZpTnLLn3fcqxrhZvL-hA>
    <xmx:IgUmZlzsqo6H0pYicZnZatuWDazhJk_urYslJesFevHvxW71qaCtfriv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 02:35:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 26d5e16a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Apr 2024 06:35:08 +0000 (UTC)
Date: Mon, 22 Apr 2024 08:35:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] docs: address typos in Git v2.45 changelog
Message-ID: <fd1386a694322c0de534d89a8a359f7ffb9ea6d2.1713767605.git.ps@pks.im>
References: <cover.1713767605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w9YEDZoMF+AUFJ62"
Content-Disposition: inline
In-Reply-To: <cover.1713767605.git.ps@pks.im>


--w9YEDZoMF+AUFJ62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Address some typos in the Git v2.45 changelog.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/RelNotes/2.45.0.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.45.0.txt b/Documentation/RelNotes/2.4=
5.0.txt
index 0fc29bc3ad..d4c9e9d93f 100644
--- a/Documentation/RelNotes/2.45.0.txt
+++ b/Documentation/RelNotes/2.45.0.txt
@@ -250,7 +250,7 @@ Fixes since v2.44
    This has been corrected.
    (merge 199f44cb2e ps/remote-helper-repo-initialization-fix later to mai=
nt).
=20
- * Various parts of upload-pack has been updated to bound the resource
+ * Various parts of upload-pack have been updated to bound the resource
    consumption relative to the size of the repository to protect from
    abusive clients.
    (merge 6cd05e768b jk/upload-pack-bounded-resources later to maint).
@@ -297,11 +297,11 @@ Fixes since v2.44
    variable that is no longer used.
    (merge 72a8d3f027 pw/rebase-i-ignore-cherry-pick-help-environment later=
 to maint).
=20
- * The code to find the effective end of log message can fall into an
+ * The code to find the effective end of log messages can fall into an
    endless loop, which has been corrected.
    (merge 2541cba2d6 fs/find-end-of-log-message-fix later to maint).
=20
- * Mark-ups used in the documentation has been improved for
+ * Mark-up used in the documentation has been improved for
    consistency.
    (merge 45d5ed3e50 ja/doc-markup-fixes later to maint).
=20
@@ -395,7 +395,7 @@ Fixes since v2.44
    configuration variable used to leak, which has been corrected.
    (merge 0e0fefb29f jc/unleak-core-excludesfile later to maint).
=20
- * vreportf(), which is usede by error() and friends, has been taught
+ * vreportf(), which is used by error() and friends, has been taught
    to give the error message printf-format string when its vsnprintf()
    call fails, instead of showing nothing useful to identify the
    nature of the error.
--=20
2.45.0-rc0


--w9YEDZoMF+AUFJ62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYmBR4ACgkQVbJhu7ck
PpTvlhAAlCWTnzOHsI0AW4bN/KmKbLhOE2JF4RvdVcWWYxrgPu/TvIpoHKMXE9S/
tnMqxg07UlGSVko3OGjNLisuUkNCbYweIxd/Oo8B+ncISgRpzdf/Sc8K2qBP/+Lp
A3UEAsGduw8pK1EwqVbTpZmWvfSMQ/rU84k/1715VKKEuUGBPacgbZ2qcnahOguD
z/aalBaJAPBp5+gFtFGIbz0JuSsQWUsIIruM9hIKzpZHu2gwIJZeEQS27FOR2a12
Yv8W92gV960FIsHaTaNZyz33a2G3FnlUl8QyinJM6KLLVRFikAvS3zNJraC/vn75
QFUMvX7wHuZnt6cOecM8L/VYvetxWpQbRw4q1MyAVVPj7h6O8sS9i4Sum79BxET/
K1rz0BEkWdkvAMDvt5N7q4m4J1ZiCFreMMx4287g1L1QWNLMqAnMenw5tauPk0yp
dw09Kq1VuEjTPgdYn0fn0UOMDPTCj71vzNFNGRNynpoj2HFYKEEtjn1XkhRTihdq
9gwFhM/UGVmA+yIB0uniDTblw6wdDLX3uKLmiTuntq09tD/7UvRPRSJ5Wrn6GVpa
RGT2f4RId0Z0cCsYO+bbzJd7iyKx7hmKHldgGPED2PKGWj25F+YVrDqvC0oGubPP
mF9T0WfAMpzO7huTE+mIzOWEx/L8hjdad3V5boodkOkGNFRFQDQ=
=wH4w
-----END PGP SIGNATURE-----

--w9YEDZoMF+AUFJ62--
