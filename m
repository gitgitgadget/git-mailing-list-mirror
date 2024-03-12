Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B77811
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246927; cv=none; b=eeO+Oc7ngb/N9o5fQEko1Dm67OqBuOj/1RziCQSrOYmzaY5Mo1U5akjV4//Oa1gD/VErIeeGTNTAImI21Rjtuzm/EtvfS2aOJnXlySd1JP6LGotmv/2QLouxqYA4Ndcn0Ep3V3y+nBipcwjCDsaKMC38KCiGi16GxGNomXgJRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246927; c=relaxed/simple;
	bh=yCGbheSBDiziIQpbaJTAIWfXhpU06CVGqJa7s5EwH/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/SPRCh4jlS9QWUaElPBtiZSjJKyRT3uJnYdDDZXePM9/NTm9OmI+n0+Z60P9E4H7IjUJZuYP/LtcrAIoFNT1Ppow2TSMG5SokYHs1xYMkJzaT4nMOkL5hLwKdvZLaL9lWgNmDkpUMOpOIWW5ELwW0nU2nD397cUYstu4e/fvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qzdr/J61; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jToEyMVX; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qzdr/J61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jToEyMVX"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0A69C18000C5;
	Tue, 12 Mar 2024 08:35:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Mar 2024 08:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710246921; x=1710333321; bh=p5UBJhAlm+
	HBND5AAZ5hYYd5Jv/nimBqZepsAVa0ca8=; b=qzdr/J61zEeJjgDbSuPTaHkxlC
	8f2t6x+TLehalt0lJCieIITmraJaQdYBIiQzJ/8MmkYjHM04oaGwR5MYYf6V8iyr
	f2CGypR5SfwdlqBxKqvfuxnO/O46+nPGboWabDUvGcS9Ol/E2xmKIE8lXnaqHBJc
	quFxgDqzQ6DcJa9gU8HANvrAu8endA4wu+tMxsM4G/Q/TXKdK3YT0oRho8fQGARm
	ro9toAMxgNkm3SCCpzWy08lwuQKSI/BsasUHxMQrCFq8BPsruD/U/tVX2wmpiioM
	Qp4fbwf2fy8BFjyzHMfH8z8/iikTQQa33LJ18Ur59RxUlOfuQWSIkFEOvfng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710246921; x=1710333321; bh=p5UBJhAlm+HBND5AAZ5hYYd5Jv/n
	imBqZepsAVa0ca8=; b=jToEyMVXHrrfu7UUHUrRyrtCb0bADMb9yQJxfRxDR5cS
	CUBUga2YlPjk0TrjIzNtQB2XORWUuRJSh8Ql+NBNEiLotAIhcs8bjG+8b+vDCFfF
	hrb46iYwetLfuI4MsByOy9qmaaVriNSGwuU6w5oVjF90Lj03u8UyP5LMdLQbYX/F
	t/Wyc0leq+j8bRzHTGkztNFQhu3j3/UuiEb9Paefn8Kd+AbLKh1OoT9bsqnvOJW+
	EMSQLpwvRVs0ZXdzQSXp/ac+EshtjJRLpGSeTqPjtEtVYCei4HejAXAOy9j1Q4Io
	r8nufEO9TNlzT7TcIR1G0VfjzAhfZklBB6+gPFba+Q==
X-ME-Sender: <xms:CEzwZfz16Wd0_uUD_dVGoZ4sJwCy27TaMsHCO8DGVMyb-sUFiec6ew>
    <xme:CEzwZXRA5AW8927RdNLOmwfrAZJFDKoPVLqqTn63fa9WJYiyL672Zcjd95838_lOR
    IIFY4WVcDRd3VAwUQ>
X-ME-Received: <xmr:CEzwZZUBaI7yNJeghpQcoSc1WO7jbqZTYB5AwE9JrngKXx17xMITcrH-_KFVpRG8GgUOoNiSNZXOZPKrkawQ2NaVwRNYvLQChZ-oQ7XVZRRikeFO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeitdehtdefhfdufeehffefjeeiteehjeehffeiieeghfeigeejheelgeegffekffen
    ucffohhmrghinhepvgigrghmphhlvgdrtghomhdphhhtthhpugdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CEzwZZj28wPBkNNWpeZzudPYnCejF89FTDfZ3MPRGFk3ZN_PXhY-Rg>
    <xmx:CEzwZRBT0D4YgA2qfbUnMOq8RTxNISku6RegiitNKLDLSIZhbIth3w>
    <xmx:CEzwZSJa-tyjElFEFtKK_JyUoKLVw8J5XyOhYvuqVNlY3r00GBPCUQ>
    <xmx:CEzwZQB-iAmBCFSryrkN_siIV9ZV6onYRikkWBwxjl5BUWPPFUsuhw>
    <xmx:CUzwZU4k5SQ1usuQKo35WERuOubIvFuZPtbxUgmJnDz0RCmrYkfBESpyNxE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 08:35:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 31719b89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Mar 2024 12:30:37 +0000 (UTC)
Date: Tue, 12 Mar 2024 13:35:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH] t5601: exercise clones with "includeIf.*.onbranch"
Message-ID: <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TgPymOZwbaw9TmZw"
Content-Disposition: inline
In-Reply-To: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>


--TgPymOZwbaw9TmZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It was reported that git-clone(1) started to fail in Git v2.44 when
cloning via HTTPS when the config contains an "includeIf.*.onbranch"
condition:

    $ git clone https://example.com/repo.git
    Cloning into 'repo'...
    BUG: refs.c:2083: reference backend is unknown
    error: git-remote-https died of signal 6

This regression was bisected to 0fcc285c5e (refs: refactor logic to look
up storage backends, 2023-12-29). This commit tightens the logic to look
up ref backends such that we now die when the backend has not yet been
detected by reading the gitconfig.

Now on its own, this commit wouldn't have caused the failure. But in
18c9cb7524 (builtin/clone: create the refdb with the correct object
format, 2023-12-12) we have also changed how git-clone(1) initializes
the refdb such that it happens after the remote helper is spawned, which
is required so that we can first learn about the object format used by
the remote repository before initializing the refdb. Starting with this
change, the remote helper will be unable to detect the repository right
=66rom the start and thus have an unconfigured ref backend. Consequently,
when we try to resolve the "includeIf.*.onbranch" condition, we will now
fail to look up the refdb and die.

This regression has already been fixed via 199f44cb2e (builtin/clone:
allow remote helpers to detect repo, 2024-02-27), where we now
pre-initialize a partial refdb so that the remote helper can detect the
repository right from the start. But it's clear that we're lacking test
coverage of this functionality.

Add a test to avoid regressing in the future. Note that this test stops
short of defining the desired behaviour for the "onbranch" condition
during a clone. It's not quite clear how exactly it should behave, so
this is a leftover bit for the future.

Reported-by: Angelo Dureghello <angelo@kernel-space.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5601-clone.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index fb1b9c686d..ca43185681 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -776,6 +776,18 @@ test_expect_success 'batch missing blob request does n=
ot inadvertently try to fe
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
+test_expect_success 'clone with includeIf' '
+	test_when_finished "rm -rf repo \"$HTTPD_DOCUMENT_ROOT_PATH/repo.git\"" &&
+	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+
+	test_when_finished "rm \"$HOME\"/.gitconfig" &&
+	cat >"$HOME"/.gitconfig <<-EOF &&
+	[includeIf "onbranch:something"]
+		path =3D /does/not/exist.inc
+	EOF
+	git clone $HTTPD_URL/smart/repo.git repo
+'
+
 test_expect_success 'partial clone using HTTP' '
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
--=20
2.44.0


--TgPymOZwbaw9TmZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXwS/4ACgkQVbJhu7ck
PpQ9Vw//dqfJIp52ykPeZrYoz3fQ/qmMCfiSeIZgJ36Foky+Dc8608gBKR00g8Po
Z/YDr42fU5GImVyXQ60zAlzqC/sDYEzarzUWd9dYcGSC1gjbEX3frZ9BhADLDFM8
9tTc+JDYgGyi+VDq9sKuiEWzaxSjJN1bBGzOzuFCCUzIJTGt0TxxLGMyRU+SGcpB
fAGqB28gMfBFh/cxZTx3RUxs6YspWfAk7d5k9WPpiW/6XVy16uGa/q+Eq2kFy3C0
NI3YWYexofipcSkK/Kumb+QFqEp2f4HOjUPDuXqwBLqmj8rlHPFxwfr8US6/wtIz
P5IvohB9kkNTPI1fP+sMmFtkq99NSbOLWJRwpkLdXOMOARxB43W+f1Bvt5DUkUUX
KeIWZgIYxI5Q4Y3SkKSomIxM7Xkq3ra1xRc7cTQtSXHZiiPCpSrnLlv6DdvFhBEx
bDOHZ80OB5QmWEOvWnuk8oPuvH2dzNoNVddDke4IgSYh5Nf5EuOufMI6J6Nhjomp
XRfuM/VwjCtv2Tg7MOwRjM+Gr+SJ0C/jgHHqdUTKtk8BjPjwTnNP6gv/mC0BIUXf
QHKu6otR8XQK2exlEJbl/9FZ1+CifnRDXZ7aVjdK/7Rz2+uTZ01feN6s2HgEb2Do
BA8E4h+mkINLEJnpOS3QNtQa0R4E8R+xnlMXt3rJFrqY27LrqFc=
=QXsX
-----END PGP SIGNATURE-----

--TgPymOZwbaw9TmZw--
