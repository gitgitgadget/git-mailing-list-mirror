Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B2148853
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347843; cv=none; b=LRTelqsoJeBxkd1wMXnzH5rt4/uBl22rxNVi6kH31I7Z933SqgYHT9qRmgcMaDfaIzwXVk43/VqB7Emd7j9h/gxAdjgnZSFbZdJCSp7S9vWG/KcwCqr9pRAp9hQwdBmN2wmuosH0JWxKFG5XkUsSqxG2t5xLGYIsn6HtoFXP4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347843; c=relaxed/simple;
	bh=7zhK3Tyhmf9VLbv677RwFqLdylC2U1ReCFLvQf0OV10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P79f86LvEP9Dy81UJXmgxDO4D++ivd53SR2UoTeC+KYt6S1PSclhOFM/b2j7Ug5nvTmH2ZvyQ94imW4P9TuhawrPkdUaMGhPeyIhNmjh4sDGv7f56HkQa1G9wQGt9rXSURtX6QCdxJRkC7G7FUo4h9FBowprlzG9cTbIXdz13Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mTIzEOmL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8BrHDhn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mTIzEOmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8BrHDhn"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 674DC1140258;
	Fri, 14 Jun 2024 02:50:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Jun 2024 02:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347841; x=1718434241; bh=Hbf8T+7gdO
	L+WxpnBinHPeJPrddTh68LffTBupHXYQ4=; b=mTIzEOmLNd3onuRJL4lWlq1ws0
	UJKXMb2YQvnt5+nVI2CGCslYvzpwi4gNzQz/gSZR+LVBvQuvMFRHYkv4VqfQn6Y9
	BMj4Wmty7/ifz2IPpbU7K3LQZGCdngGAFbeA2Z5ReL2C3GHG3Mn0yHHI97ms8NFI
	diIWcG7F0X+a2RDk06l7h3U5EzjYELK6MVz5tAs5IQvWNIBKKI9Vr1sHt1IlHCjT
	BXleYiKlUrGASicQPaalPfY4OtBcwU3bmOm5WFtCklTOX3ec0n3q/K0PY780R/8l
	61g8t3hsMvb76INqzvGGx8FyXFH4tzmNXLrf0el/P32WFBvwqpbK/XuylYlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347841; x=1718434241; bh=Hbf8T+7gdOL+WxpnBinHPeJPrddT
	h68LffTBupHXYQ4=; b=j8BrHDhna5TeGLrbm6XAm4O591YCmgN6Ei6dTQzsSXYU
	naTjnLO55POYRbkExosYB3C4GkPux1SJgcL7hvtqj3zh1lEzFdpgOQ+0JQ7oT0Zx
	npx8Q0wk0JbbdpleBgC/n2YGZg4vpjRZsSI2ID97S50BNSgPArsHNPcH4fqXvh0z
	2kNhflACrXAE9CTpX3gauBhimSxGBwt3YCtPrX5MUl/0lMeBf6cc+TBwwZA0/2uH
	WlLVCFsdUZ7/UtJJfbgKfz9Qdhofl9/nBTsojG+uwdaWCXMSIiBHUyaFV3vX9Kw0
	qLEAq6MwBN93nh0UxKLoSIuEFbA+nVGZfNDewyuovA==
X-ME-Sender: <xms:QehrZr3pfNeC5L5nek2cZFkouoBCbK9rwhzEbsGaha_vCaChfKMAIQ>
    <xme:QehrZqFvYaI1VVH1TBRQaeqJb2SRbliRWjpDLEs-jYk_Uok3W5QB4mmHcTyUgSbv6
    fnKdXe5tzCWaiz6rQ>
X-ME-Received: <xmr:QehrZr6FkyvmHYqLWWOUFGr-rucHeIDoeWfujvORoBFo5jePrG5nsS6cVFSLvUkuD03-FiTcKBBBXY3MwkM4w0sQ5Tn5_s6_vjab6JDEwqS2CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevieegvddtueefteffkeekjeeuheffudejhfetueeuffehteevtddvjeevkeef
    vdenucffohhmrghinhephhhtthhpqdhfvghttghhqdguuhhmsgdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QehrZg0SBGzHgQlZj5wmredEbb_-bFM_kJYPoaqIQwumWUIezaNtEA>
    <xmx:QehrZuEhM8zCaEd9-1x3POazttCJw0bH_SpTj9vIQGbXvu8QUVd_rw>
    <xmx:QehrZh8viLy2pCi5ii387aw5s4O1nA71Qp9DessCMif4rRNtrA06Wg>
    <xmx:QehrZrl7g2WssK_huU71lPSOqfuA3yWVimJH-dMIuk9LTfMMJFmVaQ>
    <xmx:QehrZrN14b8zuSR62MG7zutdfikHHDF9IOoHIN-8Kx0Y_5fE7m95N8_n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d560a005 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:24 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/20] http-fetch: don't crash when parsing packfile
 without a repo
Message-ID: <30babd8a678ff0aed5a671afbaa7c1ddc062a650.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qiOHbQ4mKFL3u3tb"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--qiOHbQ4mKFL3u3tb
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


--qiOHbQ4mKFL3u3tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6DwACgkQVbJhu7ck
PpTZeg/9G055gf1drz/9GoWOMhiUg96Mwyv2fUci8J7zEIDNs16TXQ/2EEwslGxN
vBWFQhPgLNm4VPmvYqMMBKUjacL43GR0X6LApMbYEyhSZudqRmAcjZx2Wdx3EEhk
A4uTb0XHkGCLGxtPUaCjPkXC+rV2XqwMypw5Mvqx0NyHXe/9Fi/50NtUHqgvVfGc
pROBN4kvL2gxR7tCYny1ro5BDHD+D1XT4GZJS1iY6f+dlVGr6bgduOfeOPGL7aLG
YRd9cf3Myv/3olLyq+vBd3X63PTYXx7bBuaD8cu777NVvX7NMvA8zsEY244ZM3Qy
thXgZQhle+Q9KXJMrj1g80KQux03Cu8ZuUt76OQctTFsR4rkoldlu4Hv+kdOzmi4
amq7WGIZJjVHoyIHFetH7ne+oHOJgOkj9kDttRkJZgbd32LF4ktYSDYJrA/Nptew
EU3y4UHx5DCSVfjmgMD8FibHhZpO0kv/FiJtEpNYKij3dbYJSVPULIkHbHC7t3G3
vNiRd2a9oCunBAtqiGPWU6+c7PfyEFe3a8IKL1m3/RWs9IDSXdk8ufs9HWGS/B+u
EsQkSZogg/RjruNYKHt8p8qpV6T9fqqr9uQ17HE4IVfhhLTKH9lzeXspqbH31WLN
vdr85DSs9VPLXFltOfcVecrEM989bwMXKY3d4XsPicGYW3KQfEI=
=1WjC
-----END PGP SIGNATURE-----

--qiOHbQ4mKFL3u3tb--
