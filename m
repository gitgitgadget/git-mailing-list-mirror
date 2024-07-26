Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43501E57E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996361; cv=none; b=VwyBiE6StCcQlndIuQ1CMnKuh607xXet3ZKrIkUQx2rwyIltDSGrxJeM8PO/0XxtZ0uxtCu6O5h+GqU6AslOjWPXCF51K5zxR6is+Nnv3qWXFHi/JPg58W7mNZ4FLGLN89D3i2nqsQZO4XGUKFKj5SZCmMi0Uk9pBH/COGd7TpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996361; c=relaxed/simple;
	bh=ZIY1ixpdXYcyLw4oWIUVCMnZLL53ib7mQXksKLHk+7A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOVSbDsEo5Y2Sz1SLFa7qTDyugMGllgXbitOPRR1fS2jhsqGH8yde6HTEAzpS21ohO++muNitTjheByPHAK9VfPe+cjkBe8qXB7eKZf8ay9ipCYESDEOUxNKvXIuk1GrllH6mC9WE/AzQ13Gc4Txl+GY0FQby0PfOPyqdg/XoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hkxtizUu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TRgX2fKw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hkxtizUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TRgX2fKw"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4797A114011C
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:19:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jul 2024 08:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996359; x=1722082759; bh=1WlWpc5COf
	SBO47vkPA6pJKIC5F0q7xhRRb/A7Dcouo=; b=hkxtizUuEd6RH9MPosSJ3NX8ki
	iByfJe5L7bQea6EPHnsItYF4pvxjQVfEr4AkE6hS4rgqXi5oMmEWMkLY1HySQekG
	5wUeHLBAqfy941/r+iPWe2G25MbPXEug01RMr2ou8u9GE6e2vpWwCKdC0vLz0/5+
	bcPcsirh1ZMYEQZnLv+DoW/y+u+NuvbqGr9acaf3lByqtuqJmbjIKyIBJ4X569Sk
	d7fkUe5XTOcTVvyfTQignMWcZpBw8rSAFOrScR/LZ26nJMyVrtifM+cAx0jy1wrk
	rJ2c/2YAYN4k5yszDjiaU3hPHHZ8cHg4k8lGCsr2MWXO9gENG9f6q+sX+JQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996359; x=1722082759; bh=1WlWpc5COfSBO47vkPA6pJKIC5F0
	q7xhRRb/A7Dcouo=; b=TRgX2fKwGYfTqt6brBMko3RNqJO2flRmTSi8ipSwjjp0
	QvMKCd6heRe/BUTPcZOzN/t2Br2YIWQcieQNynfg8IRAvLkpnDrlRYuREZ4O/Li0
	tgFFAiPW4nYk0Z+KwCb8TZH60GoQ+E5yRQgZ5NBS+InxxNFG+6FFm9iCx/DWopHJ
	dOwomN2hbSZI9xyjBjQBWlUyLYRywBYs1YLQccu8VGYhCOdiRbS2D/Dy1mpfOPcD
	tS1Cr4CuN/0Ox3Lc4h/8nRlkKQ2Y+ItvKA8nQr44RCxOv+W+A3wN4YyPLE6sOuaK
	YxT4iTfMGfN02IB0WfldcC9+L7Ihw4u2xmPQfKSsyg==
X-ME-Sender: <xms:R5SjZlGlN1wtJogjIDB_GILbCF8eIU7X-mnZ56fdkVoF9dfDpH_SDQ>
    <xme:R5SjZqVF2i6JeABwHD8T3dJPE4HkX86U8ZGGlffVRuniwDgugQKLxmSGsesqBj4pT
    rUvTd2Hcsac21sJfQ>
X-ME-Received: <xmr:R5SjZnI9_k5np0zbZlnTFo5mx6c1drMTEBZX_FV5kXnBPZUcZRk9cZCzBNdi5gnBG_G6pXuTIftVWe59ql3YE-j2KTK-rfncqGUBkXegamyfE7OT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:R5SjZrEBcNOIiGAF7mSeL_hVn_Go7uY9u-m6FbiIsZtDP-OvVDPPjA>
    <xmx:R5SjZrWCpfHZT_x29W8mlnmrHCvc3YIw7TglHDW8L-Tz7Mg1HjuKzA>
    <xmx:R5SjZmPhqYz9-tACYJ3EBF7lo2k9L5uZOSzXZCRBVIrQTMfBnrJ71g>
    <xmx:R5SjZq16tZhTqRlejaT7uoX0gL3mGy6fQG-jGeH6uzQCIYU1s_BBjQ>
    <xmx:R5SjZicyaRs2FbAXRFYXoNGFjAbDQuUqs84eGnZZOw4-If9NTJFVlZOM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:19:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 70fd3aa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:17:58 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:19:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 22/23] convert: fix leaking config strings
Message-ID: <8c2a19994fcda53cc1cb315c8ab87a36838d598b.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k4BJAnhz3WTtK8GK"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--k4BJAnhz3WTtK8GK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `read_convert_config()`, we end up reading some string values into
variables. We don't free any potentially-existing old values though,
which will result in a memory leak in case the same key has been defined
multiple times.

Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 convert.c             | 12 +++++++++---
 t/t0021-conversion.sh |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 61a540e212..92ce04c406 100644
--- a/convert.c
+++ b/convert.c
@@ -1050,14 +1050,20 @@ static int read_convert_config(const char *var, con=
st char *value,
 	 * The command-line will not be interpolated in any way.
 	 */
=20
-	if (!strcmp("smudge", key))
+	if (!strcmp("smudge", key)) {
+		FREE_AND_NULL(drv->smudge);
 		return git_config_string(&drv->smudge, var, value);
+	}
=20
-	if (!strcmp("clean", key))
+	if (!strcmp("clean", key)) {
+		FREE_AND_NULL(drv->clean);
 		return git_config_string(&drv->clean, var, value);
+	}
=20
-	if (!strcmp("process", key))
+	if (!strcmp("process", key)) {
+		FREE_AND_NULL(drv->process);
 		return git_config_string(&drv->process, var, value);
+	}
=20
 	if (!strcmp("required", key)) {
 		drv->required =3D git_config_bool(var, value);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 0b4997022b..eeb2714d9d 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -5,6 +5,7 @@ test_description=3D'blob conversion via gitattributes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
--=20
2.46.0.rc1.dirty


--k4BJAnhz3WTtK8GK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajlD8ACgkQVbJhu7ck
PpSzHQ//XrlHfE/pg3ns5i0WFjVr3HamGcfBYOn/EszC+pFBeqMq/qiv1EOD7tgK
vVAReNW8SCDq28cgmmiGXYiEGzQtTgjSn63MkZs+L9Q36dPPhglEkfLuBsGCrpTA
T0pCM1ZeyVkzb0fSq/P77rSbp4ppTSaAW8iy5m6hsyanB7fZG18f1Tq5oqlsWN+a
2j9OoJOjJEI4lXKUaBZTQC3HW7rt//NCwxRlq32pC36J809zSU6aZNL6R5Lj396d
EXVKayuI9dXch9USv9Oht2h4yd0hKQh4KzTSKQjiNtS7nEJyXzJNedjkGHK+wKNi
8hIbinChThZNygKNVK6t4NpCyLddj1BRpqYeGpz9G3jG4vg15XG9VHoihE3cUtIT
4+4AvS/I2Ed+AC6a9ZycKKAxEOxD+dhkrPGaGfsr3hHkV3hnPDUt8pFV00eTyJ2r
jo1HaCnpVjsP2w8NlOKDkMdlbWwFCgGRfPSEqLJMnecuV4fPZITufPFyS97zg49T
uUI2ioDW+oDuQgHDiawxsEsxspIX5sVPmpZ787pJJ5qcJsOaS/4VvRvOsQT4rQYa
GsezdvJCJ+2morGe+DKe3aUK2Zd/u3Q+TwOuFf00gYOaEi4BNIfRJIZ6JNJwyvg0
fNhSpZlVAWrTSiduDm6Xvr8eAZcOrV2jhEhVckug1pteh3FH+Xc=
=iTjE
-----END PGP SIGNATURE-----

--k4BJAnhz3WTtK8GK--
