Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B317624A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097695; cv=none; b=gYIlr17lsPdAZxVB9vHWtf239BspApOY1CEkT6GyPhSqHs4FJOks0ZNQw4Kd032legKXEdoPsVY8MGtgik8ETRXDP28k0uMpH3gDTMyviRGAunQe7UhSuXEktTfCt9UO1eFPmE7E3i+tKkgccRcBRFSUPUUUgtgDsn3tHRUZoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097695; c=relaxed/simple;
	bh=17fx1JRgX8O4CpSuaMkUsRCZLptneKTMp6Kk2rM3UTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxHRdDDoWZGaT4O2MaI+8JhcUJUzrXK7//A+rsegnFqJMQ+Ls7OXjCdKZLNtKAv7L1P1weGbmn/QBEYKnKRo5N2Pl0/nhgt+doUyraondiyyQLIFFXD6e37vRusKswLFyYNvlXmAFdnmPgrQ/G3HEsiSbKec8eo75FEZyPgQS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lBfEUI75; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9hRuXyS; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lBfEUI75";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9hRuXyS"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 14CAD1C000C0;
	Tue, 11 Jun 2024 05:21:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 05:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097692; x=1718184092; bh=xN+cCdeCbV
	B7zzBJprljUDCeBE9s9dz58g245hT2Yeo=; b=lBfEUI75DkVzofmbdxtWa7gjVu
	6HDkWO2clDeF7s0plsKyYolpFbQdyUlCpKLb+Ekzs0HWRMzAOdVE4Qkdxz9CSfLC
	I46kNp48d+PFDjc+pI3Eg9msnAXkJaDkcNaIpr3b+3nR9/yG/DzZVo1tOP6YcROJ
	oppkSHGdpo59kKQyOxpGVNfoeTtOV7XG2HOIz+5XznQJFIeifvGaBOFTkDR7u7P5
	H6CYG6rbYPk/iYjyX4/u0tIvRZ4TcSr7CYZU+y+GabJIR03mffp2mSoWbUS00BM7
	8DNhM7UgtS1lcz6yjMkllR2QSjjQeE1GAp2SLNQwDmqBQm87H4PK96t9E4sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097692; x=1718184092; bh=xN+cCdeCbVB7zzBJprljUDCeBE9s
	9dz58g245hT2Yeo=; b=e9hRuXySGSCYGKJD7htqLQfJI2WEXu2KeOz2IvkXvZZ3
	SkUY7LnZSoLtwv2wuC2jbDzU9vtyixuzUnsMBF/3x2jGhYAHaRbu915belOLYMAp
	QUaIYDewk5DoG3BFUBjIegcUttGXAVWEOfSN7GcWaU3rXb5djamEBIg06A8y5i3N
	GAIldKXIbS7mYCWOeI97ZzN/zuHromI28VsZtOPnX95F53ZPuAnh59/9tzr/PRKF
	hAJg3P3t93o7mA4/OVI7MyLJwuB+tXZOkiKe3Esq5p1V6R+AglKZB9Op9D8Y7mMT
	sKNyApLaN6Dfb6qLgIopwmYDrOaxYecM4pchOU8qeg==
X-ME-Sender: <xms:HBdoZlcsbyTiREO22m8R2LklCBnoALRX2WDuj97FZWMBK_1ZQ2jglA>
    <xme:HBdoZjMnVv-d7dO0UU9o9s3xvee2G1uwvFXYavHN4QhcphpuvkbA8BIV-0pcz6-QY
    15AEg0uPUNoofPnnA>
X-ME-Received: <xmr:HBdoZujaSnPYxd9mkWLpeTp6KhhRbah0kQk_ANFljxidC7ITbC8Fb8LdT17WXdjJ8MfVxbYGrkCSrXps4scGd_6V_tG8aojMU4wDJsk7iLvt0kwRXqFP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HBdoZu8QT5re2W31dNLuTODeJmo4RPF8VgJYSjzD0UoBRfxDzQ_9bg>
    <xmx:HBdoZhu0eNflpFA32zi5BZc1UyCNT0yA0x1_K9Y_7FYIe10SKYgO9Q>
    <xmx:HBdoZtGN_yN_ZzMovtQvO1CwLCs6yCR6AnSDbBNbmTC0ykg0jNC-7g>
    <xmx:HBdoZoO5glo-flqYLwSmI53LgkUi-PpXf3QsWWtaudqv8ddlE5MT6A>
    <xmx:HBdoZpJ845DTYq8Er7GxfTQ08YEhC0oJt7yMs3CCoz2cV_zFvleMhnxb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:21:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de92a3a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:21:23 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:21:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 29/29] builtin/blame: fix leaking ignore revs files
Message-ID: <5d7007e724b0ffaadacbe1e661d0a0ff00faa36e.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X9/CfOLr3/VexJor"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--X9/CfOLr3/VexJor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When parsing the blame configuration we add "blame.ignoreRevsFile"
configs to a string list. This string list is declared as with `NODUP`,
and thus we hand over the allocated string to that list. We eventually
end up calling `string_list_clear()` on that list, but due to it being
declared as `NODUP` we will not release the associated strings and thus
leak memory.

Fix this issue by setting up the list as `DUP` instead and free the
config string after insertion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c              | 3 ++-
 t/t8013-blame-ignore-revs.sh | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 17694410ed..702fe4fb94 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -67,7 +67,7 @@ static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
-static struct string_list ignore_revs_file_list =3D STRING_LIST_INIT_NODUP;
+static struct string_list ignore_revs_file_list =3D STRING_LIST_INIT_DUP;
 static int mark_unblamable_lines;
 static int mark_ignored_lines;
=20
@@ -725,6 +725,7 @@ static int git_blame_config(const char *var, const char=
 *value,
 		if (ret)
 			return ret;
 		string_list_insert(&ignore_revs_file_list, str);
+		free(str);
 		return 0;
 	}
 	if (!strcmp(var, "blame.markunblamablelines")) {
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index dbfbd86e83..d33788d867 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'ignore revisions when blaming'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Creates:
--=20
2.45.2.436.gcd77e87115.dirty


--X9/CfOLr3/VexJor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFxgACgkQVbJhu7ck
PpS7Gg/+JL1kr3LJCn5Rlrlz/U+iAQeyLVnfCynMN4tmwERf7BV2uc+GcdegN4S1
bo8I1MQsOfL41tyeCLdMSYZ8YP0r9EBqrY48Wznqb4MAKI5yeOugIOEzV4mXN6Gt
SDyNeh0tLD23oMP+FlP0Q0ipy+wxfjcdtjp44egt76lJtmSPXNliuIJb91lnBIi2
C612Yy7cob7j0UlsAQtidLNw6F6vSVCAARwJ+kke1K/w/bfTitUH3pDCbq1stAkb
fVmiOQlyON2+5JWnH7On25njypwwrXkJG5vY6k2tzLbW1XdxyCx2bIH+tvjDGlQA
ibzvutEXEXTzEyUw8/xSAmoxzBFSHkLdOfG5Pd+gOc0O0j7E1nDeTbrbEgJNulj7
2kuSuw5S1Xovlc+l96KnpdC5GY2k72ziZOPaPSa1mCvQeUBuho0mOGeJ7VqK3T1p
OsehxzhLJKafb848EKnyB71bfArDkXJTEzQb6x9Miwd0GH+6M9W0Od47XDdW5+zo
AuafYq0ZmOjrJCgXyEFKX2C5h1QD1vF/9DpqtaLp5NGHCmDz+65CDnvo14fyQiyZ
OB3EuFroUoE9eYHpQo0ll5NHecIMJvW9xueweRF3PFuMlTHt1FNVBYcINXy8IfWs
blA/TEHEOL6QCpBkpACEn11+HMVXLSVbFHLwLQlKAqKVI8lych4=
=wh0V
-----END PGP SIGNATURE-----

--X9/CfOLr3/VexJor--
