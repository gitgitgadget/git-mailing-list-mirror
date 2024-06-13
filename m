Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68413774C
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259265; cv=none; b=BGbDeBExfEXQgZJOY0ljjnTmelkAZH2MEYGXjGkEqbCTym+HJT7EiGl14QEnKIFn0rYuol05CGZPtaYXE9vHYRKHnM95/g8U+WY90SYjltxBORhxW8XSo9bHPa44eT9Ry5DDRGj3eAnD02DHSFHuAJFPImok1USuCupwrAfAkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259265; c=relaxed/simple;
	bh=XnznHRdpzbMltY3ep/DcHVLi6ojwaFwcdtJB3AHZd3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDoM+vscuPYiEkA8ZOlIR6nsvRXYkwKZtTCOiv9widGjbaAUpxtIWxtfR2lpNJdcl4QGjFAuAtZZuNcO2zyhLcpU6XgIIueMXyD0yv+Cd6oyfbQoqQiUpUjIBRkEudazUEqgVD27kIfgKgtqPYbbnh1B7Q+v7yQkiKmpXpwfZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O1QGK1Zj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFLJR3Ql; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O1QGK1Zj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFLJR3Ql"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 6CB841C000D0;
	Thu, 13 Jun 2024 02:14:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 13 Jun 2024 02:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259263; x=1718345663; bh=2CQ+XErx0i
	dzmzyXWs3g7ID0S2gtudKDuZFWfYLhtkI=; b=O1QGK1ZjhWEKUhx8aEVPcdP0r0
	T6IGcSfoKlBoqMM3P8wvTevBKMvXdyKCqS3fhRxeMKE0/y2Lu6Cv31nV/YHIpN3I
	UrMMHgdttwbgysNHC+JKPHNiUU5a679r9JQgGW5FrayqAjCEPxBpRrj/C7u0xx2E
	0ROa52p3KqSKFg3D1cvKmCpJBAGs9txeAZXUMLlcSJUBEJpxiaz//5wyZaJMLAyr
	MHpDH5VkFwp/DODzBbyL7XPoiGraEOHOxafyKVIuTBJR3fhStuUWjLTLquv483RO
	uuMf4mUH+KQK5C9j41pU+Fx28A3FemAuL+isq7O5fNQ+o52Mq4yvbcdmA+dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259263; x=1718345663; bh=2CQ+XErx0idzmzyXWs3g7ID0S2gt
	udKDuZFWfYLhtkI=; b=YFLJR3QlPX7glrPokd3KMHWOeLGJxs+EbRGOBOZnOxpb
	OC3SHj+Nm8givF4BWXeWj/Nt5Bv+UZgbYEIvKmc2IXszAY0FVjKjnGB1U9AEAs5F
	SDLWqQ8vC4+XRtn4tURewfidqPaVT/OrCoXuTd1G1VNU8XcH1uNFApWuBg402NDd
	LEx1mIKxovEnxViQWGRTPcEQF4EhBetxJVKn9VtJInRnBIAbmKBtDqmSTgk7cCO1
	aEzV8WNLSqXgqjREmCJz29CadmXDj+dH/9WoNvKI7/tp8DujSIOVErF5DRMw37xi
	Ddxgu6FOQpNEQiL2qE1ktyWtzWXVdWsi+YTwktccNA==
X-ME-Sender: <xms:Po5qZkZq5aEWdHYBLDnZyOUukeiEUw7n_tSvq540ccJAzME-IXS61Q>
    <xme:Po5qZvY_pwCLe2TWXAqNVjq9j_i7xt0-1jFQV1r7GQfsEzFpoFlH__CU_2Cy2JFmD
    jdKrzdDC-QRLZFjsQ>
X-ME-Received: <xmr:Po5qZu-X1cyM-JZGfM4xeLxhHMh6MIrnD1oHsbiW3CireqE23oM1-VJApU4yTZSMOokk9XnqK4QyEkpWpM7OYqhh-Q04-4DF6ZfhiDevX9bfH9CAGis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveeigedvtdeufeetffekkeejueehffdujefhteeuueffheetvedtvdejveekfedv
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Po5qZurWqbQ0-7wqeBads110UR5ggOAFk-wE40TNOdKmiawzkKTiow>
    <xmx:Po5qZvqBYst-8QCo_38vm6bzQn8C8u1-w6SvI9ypPO151y98jZLD-w>
    <xmx:Po5qZsSPFjmFPW3rd0wPh0dCKBr3rQdYZqmXRehvcQaZ4F7etFcnLg>
    <xmx:Po5qZvrfEocoM4byCzWhhNNCMBi5xIOo8h9OB020yH0Kp_pFtSvtPg>
    <xmx:P45qZuWpL8iTWTnh5SCEqzB4VDHIgpVMvOsumMcFuyDSh4541twAXeY1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f8d3feb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:09 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 12/20] http-fetch: don't crash when parsing packfile
 without a repo
Message-ID: <9178098dd7ae60883c93ace78973c4c0e73bd143.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DgBN7oslQiVB7wsN"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--DgBN7oslQiVB7wsN
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
2.45.2.457.g8d94cfb545.dirty


--DgBN7oslQiVB7wsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjjoACgkQVbJhu7ck
PpQAuw//QS2t0M6MDLvQxTZnd37LFk8SKDDot/TQcjMbR6dDiz5wAWeJY8aNubGx
0PndJoIh9uC8ALpwz+jgvTRB+WyHsczuRex96aMCyITJM6cmVKKsqGjCpgEzOIA3
dQKZ33jvxUoBb9gdoUCv0szVAQNmP7mGW6KEFSaLgCWHO5zos5NHHtBSh47274ww
9zbofQNAC0Ed0Xe9Oo8T4uHhH9Mx6ey/TG4KwF6oyE5rk0dVm73vJRTmF91m5I5d
ZDUFaMjGx+e0i0B0ATY9xZT9+CVgoY083069WXVW9ICABDaP0jZ7csmpDeepGbDO
ha5ppN94LN5Izk4UA/7H42saEBhoGjYOOeJFmaF2ypE4PKEHKGvu6dUMZVhJNWGN
/vsA0juxkPB7xZmoGqkUk+7m/WlgWAb7j4YkcrysWbNNY0+8C8+PJYW754IRjT0b
IsCVnc8O4ATuha8TwKy9du4eseAs8ep1sLwLr4OjbCUp5+E3cJLf9oSr0Vuf+aJc
ggd38FIyIMHNjIvCofWTtxc/lCwwW+LA3CI+eg86mq11qNLG0nT7QrK6gET6YEbU
WD8W7JV8ZUmmALrtUtY234Y9b7pFlrcKNLBDXM0/L7k30uyZdd/PpyE7P9IhSMeo
nSv37mM1skxXi6A3vuOQQEjSWfDYk5UzyVSPzbTo4GRUxueUT4I=
=IdNU
-----END PGP SIGNATURE-----

--DgBN7oslQiVB7wsN--
