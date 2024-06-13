Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6301369A7
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259300; cv=none; b=NaokBnBm9TWLuRm2VpZYfy9VYRhxodOmyfvOmrU2Rp/t77FU5hDNwvFX3BhdOVPeA8CCkrRw1FKayytB7NRWnz5HxbhLjk+VTRVsa0+xQ5GHCIhqTzaS7QhZHp1zo1w5Ae5jF6SjSrtftdqHUvtFHNKHMa3iql11xaTd6v600wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259300; c=relaxed/simple;
	bh=7R6WhlSHDxQK+htA98I0tvckYBgVoTTPRK7nLhmPKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ2sm0RmaF5dOpUtEN1xTREdJQUIvSilVHZouGtkbczU0N60UhL+x+Ws5Lapg0LVg6A2ugosOqG4q5ueqUqTET/1IyGJ+KzNDLcQVXnjc26W+UYcE9hSwVf2BnJt8YMdg1E/67M/ZONnejZYtsjFIpIGEXomSCkgMF2o4nx/RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oDctWsXi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOnVT/Zp; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oDctWsXi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOnVT/Zp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 2B5A01C000A6;
	Thu, 13 Jun 2024 02:14:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 02:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259297; x=1718345697; bh=VNFzFU5+aV
	uv021wcXxbYy6i4jrvat9DIcmn0tWAdes=; b=oDctWsXimLEVPBIMp/KGsTuUY7
	j/9+fxWm+9m4Z8KqgLONWKFBpcHSpJ4Ug5rtn+4XK6jTJ3ISL95frewuFZnLVacu
	lFGjpknRXPKNxKxjEI7UlymSksbBhGxA1sPOUn3wzUfZouJ1TjItBTT5LzHqEWnU
	UsLAXWPwTUKbelYCqKHbI729pqyhxQtHwGvwOktBKqqszZb+mBHTMadCvGlChpFW
	RPPXoX1gy3LIw6s+wDyu83rgbfYD9ur2hlIvO8LBJgjn+nV1I2eHdjhTef7G1vBB
	pmdwkWJEX8q0znKr6gh9HBNSIQIXmHaquoi/75e39jHYaF3t8I4gCJ6sCn6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259297; x=1718345697; bh=VNFzFU5+aVuv021wcXxbYy6i4jrv
	at9DIcmn0tWAdes=; b=lOnVT/Zpw2uFaZubmYnaia2my4IG+51xVrR+HS/fukL8
	gy1v95ZAb0tDeRxCGiQABnkUEKBiDu6vPBhcbWTpzL8G3VsayahLWK40D7+9o60c
	ell/qCK1AMT0gk7wU62feo02+u4VwrryG8nZQFYeG89NDpk3VIOryKKA/TwqzjS/
	ktJbmLeUUgJWBhb5WBaO5BnQXMqKe7RT+x1bHcXkw6S/Y9zLoIx0D3Ewemb5mOeL
	cuVZ602KcdWHp+hjrWFjJKAukqb/BxBAGNEj+fsqbwlqQi0quOjGSCQylKLp5Wn8
	fQ26fCt8JjA51qarTysHSKkg3+csk0oJ4XSsRUsGcA==
X-ME-Sender: <xms:YY5qZkNjTjrph1awthtwHfK2fJ2Bqp1m6jXZaa8wd8lCGMZ1E1VOJg>
    <xme:YY5qZq-RSCRrUPjVEnpuitS9NiPZaYe9arWJtsFEI_vlhPEvoULyivlFKdwKZDXwM
    h0-xMwoRMM-PrFrng>
X-ME-Received: <xmr:YY5qZrSZfaywu4_njTwIuEcZ1B9cYED9qqBPNTI1KlYiER0mkZ5_EqSHQV4AoglPBrGAwDnnmuEH0HxOH-u_4-i8Ypx7vzmxRLGTwzPmQsS4zhv6ZuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YY5qZsuVZViXW7OBW2GWVy_Bgn46dqC4EQXM6KZndBFxhI28GkoWlA>
    <xmx:YY5qZsftPEWzg6MIkzPeBKJ1GGvU1G0uIhkysNyunacCJDdkKgyb8A>
    <xmx:YY5qZg2k7H6CWeeRn42scl9v3KlRVvHvrAwGkZgWkEcJCjwIsnrZdg>
    <xmx:YY5qZg8Zv5qFB6MZ7jNe696FqEIx7UAjPlu4DXX9XjepTmxxyn6v3Q>
    <xmx:YY5qZk6e7gTGd4TjUi9z-bsHL3y0N_pXEBSm29lvMxhYAYEDCkqrB59X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 797ff8a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:43 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 19/20] t/helper: remove dependency on `the_repository` in
 "proc-receive"
Message-ID: <1f0682fc7dfa63a50838316bb85717b576274289.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bTp1+pdmfQyZkfMi"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--bTp1+pdmfQyZkfMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "proc-receive" test helper implicitly relies on `the_repository` via
`parse_oid_hex()`. This isn't necessary though, and in fact the whole
command does not depend on `the_repository` at all.

Stop setting up `the_repository` and use `parse_oid_hex_any()` to parse
object IDs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-proc-receive.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index f30022d222..29361c7aab 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -3,8 +3,8 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "setup.h"
 #include "sigchain.h"
+#include "string-list.h"
=20
 static const char *proc_receive_usage[] =3D {
 	"test-tool proc-receive [<options>]",
@@ -92,9 +92,9 @@ static void proc_receive_read_commands(struct packet_read=
er *reader,
 		if (die_read_commands)
 			die("die with the --die-read-commands option");
=20
-		if (parse_oid_hex(reader->line, &old_oid, &p) ||
+		if (parse_oid_hex_any(reader->line, &old_oid, &p) =3D=3D GIT_HASH_UNKNOW=
N ||
 		    *p++ !=3D ' ' ||
-		    parse_oid_hex(p, &new_oid, &p) ||
+		    parse_oid_hex_any(p, &new_oid, &p) =3D=3D GIT_HASH_UNKNOWN ||
 		    *p++ !=3D ' ')
 			die("protocol error: expected 'old new ref', got '%s'",
 			    reader->line);
@@ -128,7 +128,6 @@ static void proc_receive_read_push_options(struct packe=
t_reader *reader,
=20
 int cmd__proc_receive(int argc, const char **argv)
 {
-	int nongit_ok =3D 0;
 	struct packet_reader reader;
 	struct command *commands =3D NULL;
 	struct string_list push_options =3D STRING_LIST_INIT_DUP;
@@ -154,8 +153,6 @@ int cmd__proc_receive(int argc, const char **argv)
 		OPT_END()
 	};
=20
-	setup_git_directory_gently(&nongit_ok);
-
 	argc =3D parse_options(argc, argv, "test-tools", options, proc_receive_us=
age, 0);
 	if (argc > 0)
 		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
--=20
2.45.2.457.g8d94cfb545.dirty


--bTp1+pdmfQyZkfMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjl0ACgkQVbJhu7ck
PpSFxhAAjbm+pN5AJ5EcjqjzHXA8/zl0XQ+oyKwjRZ+hwHLjrzq0uIQVmscxsB0j
5NvhESdfAexXyPSFcmi9UJu6VNDRTHisOjZWMJuAXMkVhLEYlKof+PYqVISBchUz
yvBcwZ3gNHy4C5iS8g7X7xXY9Ey1LqSjoYjkWXPWUN1Y8wpXrN/DwkV0vq1SRSxt
OHpWPRFmQWR3R+vWgfB8yHsiC738nqyxk+Yh+KdX20h07M8xiA9XNr374K+vR1uG
vJIV7K3EhyIcvN7KxURC2FkO2lktz0l9hJ5p+RsOkAXmU2/eqx1vBBWRq6vKfs8k
EoG8XWGoE55/gZPFqrVhqFfwOD3WjPgFVG0vseUEccztE9iEUJcC+QTADxVrFKAn
GXah1Y2MYjdMrWrSbZAAe4fye67z7RYm2+NeNyTKcQ3G4GmsWnyqu1/YeMf4hPKC
jRSCGoRvGKYH2Bi+pAcSBkev+BjFIhyBRA1hWNw+0/mF9/GVXmw9g2tAHp4VlheA
DUEyWJdcxy4jKILU36GV2ncrK346/Qf84Hqf6sPP8wESGqv97Wu75cKGSoTe8+Xf
oNfQ9yhRaXHabhAPjILyw8MDIV7N5ymMYrJaUbUImqcOZhgRG+t7ah5qww4eUXif
mQkTzt/xCzb0yKw0sJodF6/F67P3o/+EabKSGunenJBT0rYxuUQ=
=tjJC
-----END PGP SIGNATURE-----

--bTp1+pdmfQyZkfMi--
