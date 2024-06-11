Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70C17BB3E
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107113; cv=none; b=MAir7DDn5P7SpEivsKJpS548T9+WftyXnCv1druxzxFy9AHDBB7B2Zf73sm29b1MO2HP+SBWjGAWtsHEPewsIBhnyUY97APRPHqbqJqCm8r7eXEtYPWPE/D6hkYxFMyvxiHQc90Ze2qBRqXjTT0k6MfFFiNFm63QnmSzmTIHJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107113; c=relaxed/simple;
	bh=QO07YH1+VBGlZRBvhyBH1q8PrEIZdG5cHVt0NaD2Wbk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpEzUDEEelr56PUw/XmQKHTEhrbvIBDj6EHtaUTu01A8ncAWMmN597f3L+wylVG1+PAo34lGWMZnofKF3L652Jp1x+6IjpWEWJFqjpWr7rOY/BOe6UZX5DWrvsdWh1dUy9pY9OIKMvXjA1/67PP1zlDlSEOEsAdbFzJ5JY/N1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V/7qZszP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKJDF/yl; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V/7qZszP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKJDF/yl"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 97B851800060
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 07:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107111; x=1718193511; bh=fAeU979ZNy
	vyEebLJwTVLv/Qu8FL2i5dH7FxKyA3OfM=; b=V/7qZszPZr52ribUko3D1eHrE+
	KVVwHxiUNmNOqD1coHrVXilfqRy6t3/VcVXU8GmcnFSF6xf4Q4virWdcuQmZWEF2
	moTDJTtBn09b00rUMxf1EzGlQ45/wfCwR24yAjbkcQHm+V/M+Fn8N2MlUI0FJeuU
	Tfkq98BAOBwopcf/A7BoOGtrGfAyfs8wfm7c5BfmpVnhb0tgq9ydplYBcixHV5Al
	eYrGkdKPwn+a0hWfNbVMXZRaIhbf6KDXB/cN4Jp8v0pi6ZXzRm07uVROaug4h8Kj
	Fp7cSLthLaPM/DnU9rRomMw2q7YThdPvzn3gHfl1FmZUFU6tdUBwPr+jyJPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107111; x=1718193511; bh=fAeU979ZNyvyEebLJwTVLv/Qu8FL
	2i5dH7FxKyA3OfM=; b=AKJDF/ylp7E043gt6ESg2oyYHSMdi9VvZgML2bouUQ8e
	p1Z5qNyuVeosUJHSFzx1OCZLLW9shDiJn5/BX0HaXLYQ8UhvfmGg7Y8AdYaxuZn/
	4mikSmRv+13H8oqJYbHj/FFejiSiRnIB596ANQApuEJ3GSDoxggozlUrEQ8ppkY2
	VD81S0eF1L/FCyA0guktdTPFGtvqkaHg+Xl3qLqQG/rhVO3JRLQUkT0wuBjRVhZK
	k/ZXJOz+fyOSIGEleJz33qhbEix9pnAza5EZJ7hLQiRNQHaIfUBdgymN1MrwWGDs
	LmkxbWHMlm7urYf7pnFs83OjUm7Gc/1g2WoQBIKsDw==
X-ME-Sender: <xms:5ztoZg4MAvTyhjMIhudw-vWl_L0Zdn87sJSpkwogk4mHvkposNsbeA>
    <xme:5ztoZh7SkUTziRZRVFLqx68D0t_OOmF9-LYLtat1uEN7PttZhPHwtVa97EXb7viop
    -Nvur6p988kpsnJhg>
X-ME-Received: <xmr:5ztoZvfC5ePKU7qXPy3NuLJt8AjJJKxHPaFbbqBCgki8o_JyNRFWqRcTPwlZlQhFP5Fq6bkX17N4WD6sHawTzuB-IyDz9x9M_HEhr9Z9WZ23xDl3otPH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdfhkefhtefggfefjeefteffteeivedtte
    efieetteejleejkedugeetgfetvdfgnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdq
    ughumhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5ztoZlJZlaizPKQNws9gB09X-xsisRr3t4nexJl8bd7QbuXPb9-lpw>
    <xmx:5ztoZkJ4sqVUbjASgJs5xmUkLbxDbuZUxBPiCqpHg5JBnUuvvxXZQQ>
    <xmx:5ztoZmwcx36Oa9foHDFX23k1lTcGq6KqV56VP0BUk2OWJ1005CM3nA>
    <xmx:5ztoZoKzfSz04qWMtGDRVPPHb9dLvWVSHpHo-3LkHiul_jyOmoMZ0g>
    <xmx:5ztoZuh862_P5hNVJjpUDwCgdkIyRAbk_Ygdpg-S77g_bgzNi4Y8Y6cE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 266d69f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:21 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/21] http-fetch: don't crash when parsing packfile without
 a repo
Message-ID: <b47fa99f3d9b5f4edbeb681dcac56ac2ae26e894.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5B9Ujm1PuF174lST"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--5B9Ujm1PuF174lST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-http-fetch(1) command accepts a `--packfile=3D` option, which
allows the user to specify that it shall fetch a specific packfile,
only. The parameter here is the hash of the packfile, which is specific
to the object hash used by the repository. This requirement is implicit
though via our use of `parse_oid_hex()`, which internally uses
`the_repository`.

The git-http-fetch(1) command allows for there to be no repository
though, which only exists such that we can show usage via the "-h"
option. In that case though, starting with c8aed5e8da (repository: stop
setting SHA1 as the default object hash, 2024-05-07), `the_repository`
does not have its object hash initialized anymore and thus we would
crash when trying to parse the object ID outside of a repository.

Fix this issue by dying immediately when we see a "--packfile=3D"
parameter when outside a Git repository. This is not a functional
regression as we would die later on with the same error anyway.

Add a test to detect the segfault. We use the "nongit" function to do
so, which we need to allow-list in `test_must_fail ()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-fetch.c               | 8 +++++++-
 t/t5550-http-fetch-dumb.sh | 6 ++++++
 t/test-lib-functions.sh    | 5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/http-fetch.c b/http-fetch.c
index bec94988bb..d460bb1837 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
@@ -127,8 +129,12 @@ int cmd_main(int argc, const char **argv)
 		} else if (skip_prefix(argv[arg], "--packfile=3D", &p)) {
 			const char *end;
=20
+			if (nongit)
+				die(_("not a git repository"));
+
 			packfile =3D 1;
-			if (parse_oid_hex(p, &packfile_hash, &end) || *end)
+			if (parse_oid_hex_algop(p, &packfile_hash, &end,
+						the_repository->hash_algo) || *end)
 				die(_("argument to --packfile must be a valid hash (got '%s')"), p);
 		} else if (skip_prefix(argv[arg], "--index-pack-arg=3D", &p)) {
 			strvec_push(&index_pack_args, p);
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 5f16cbc58d..ea8e48f627 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -25,6 +25,12 @@ test_expect_success 'setup repository' '
 	git commit -m two
 '
=20
+test_expect_success 'packfile without repository does not crash' '
+	echo "fatal: not a git repository" >expect &&
+	test_must_fail nongit git http-fetch --packfile=3Dabc 2>err &&
+	test_cmp expect err
+'
+
 setup_post_update_server_info_hook () {
 	test_hook --setup -C "$1" post-update <<-\EOF &&
 	exec git update-server-info
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 862d80c974..34bc7d7da4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1096,6 +1096,11 @@ test_must_fail_acceptable () {
 		done
 	fi
=20
+	if test "$1" =3D "nongit"
+	then
+		shift
+	fi
+
 	case "$1" in
 	git|__git*|scalar|test-tool|test_terminal)
 		return 0
--=20
2.45.2.436.gcd77e87115.dirty


--5B9Ujm1PuF174lST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO+MACgkQVbJhu7ck
PpSTJw//eLGctvJcBDqW/5KdrHz6+dEcdKSt1UvBTYumf1wei8aCWtqV5ZnBE+B4
KEHd3fym8BSRqRKomDmHccYI63ts8/xdhfk5+GdoLcH9TeQ88KVL8hMkl0wThezv
4v0XMZaybvLOYzdkvth6OYMRRFulWD2Hyr6pXoy/AZbuv6Ru/JkycEztSKeJAwFj
KWc0ltjsyv5jp8Va4+R6Kv+AdlRf5DsbUyOIL+IBZ4CzX125WOPX0/rC5i1j5OCG
0FgJWOEiO/IO0FyqUt5rpiw1yr78/0AJZ2/oegXzQqXUaioi7dQ1Q4Xs5sBcWokp
XuWaOPeVmloQdPDvgU8FjfwaqV00nUzOvp24gqO6LBtTjGQii8KukKQ3S1eDsAEv
QgSea7FN2wtNOjWRNixH8UUyJqQrKYIM4FpFFol/1/ORV5rFKpPhTCZomg4eYvIE
m06doLXDhaeNiWp+7WMelxIHysO/kkkP6Ru3gj8WSK6tAn4gQyUGPVgjE8GjgClL
YdqfZDs3t3rdEIz2qD8Xqd3vap2H5o28av83uuNwKO8U4gvcWmnqM3+eaBixIZJW
tr9iVVMCo2dGsuisJtOFZiuHwMksggVI4SH/IeMUdOljGyTw6D1HTHv11XUCWgHW
AXjUgq8jxVKQeDN8X5Otc5Y6KCwOya3av9uGXq1Xp/BpH07/TBo=
=W/y8
-----END PGP SIGNATURE-----

--5B9Ujm1PuF174lST--
