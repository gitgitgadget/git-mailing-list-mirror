Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E2C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 05:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41FE60BBB
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 05:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhDWFsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 01:48:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57717 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhDWFsB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Apr 2021 01:48:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DCB7D5C015C;
        Fri, 23 Apr 2021 01:47:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Apr 2021 01:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=hmLArgP04ZSCTFrm4NV6gY+ojZ8
        hg1UEQZLVuQ3i5eI=; b=toaxpDxHrCEmIUhPBNW/e5jNjM90y9kwWN7EkkQIPe3
        3u7tZbUYhkqOvH5YXp0dAuqh+9XVnSs66KVSeH7omhSbr5jxd0Og27Wr7FZMih6r
        WJIwCcEKMsVfiVChXFsdD7c0gWD+Rr3mEBZQtD0gPpE9REI2OISA7uT1lJiQvWX3
        SilyTsmjbNYyrl/SYEEwKIICM3iPjwwW3mZc8YhtNbpX3JAE3nsZnLHd1fAPsxbY
        bpn8G+b7lKPeWkg3N5y8Wlh3cnr83cBVftxXv+zTjGC4Rc473tPM2QxyraxNOJqB
        CfEJ7lxYCJH0fsysHoc2TPQXEnV3kqzPzX6X8aefLGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hmLArg
        P04ZSCTFrm4NV6gY+ojZ8hg1UEQZLVuQ3i5eI=; b=FZpSXgFoUdwobZcSjPab6F
        DSh/s1ge1lIlgrhzLB2sOtP7B003YSlhRfjsV2X76h/vt6y9MLqx/169/bHh7y5b
        PAgmpFScLMG7uLfQ3ioy7yN6yhN9U9Knn9b2padeS/bDTq6nmRaO5/P8FgxxGRaW
        MYMNIlHBmeSs8UyzSDsp0WvCCDqlBXU/VJ9i1n7rmhjxYxdeW6aAl1AbKyFxRwa4
        BnqtyWHCIn1fbjJzysijjfOxtQiuDlvs8mG0NrPO1VES+aDYiHWaXLZOWlR2Qz0t
        URqWSFuw6vrs7Q7Ukxg+3mIypiPrO13pohHNeNmDbdSOhLEVNNVrXY5zuW+JPcTQ
        ==
X-ME-Sender: <xms:bF-CYAKvrPryvpruO_bQe-xNjqNj6N3z7OiAqcAeUF0ZB0_D6lpenw>
    <xme:bF-CYAJskDrZ1X4aiZVqodvT27VYfRY8ku8KJEYJOt0BTCeM3nwyzf_pKvu3iphyL
    mMQ94oMTuonMdzehA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdduuddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepjeejrdduuddruddtgedrhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:bF-CYAshwPVMdlLa3vyYhnd3x45d36gTlKJJ5cAooyC5qyBblNNVLQ>
    <xmx:bF-CYNZfhYX-H6jJKSqc3SQHNS52dceJIDyjrK-btucrwJTPeu4xvg>
    <xmx:bF-CYHbWb9dirKOEIkzrcW9igsouYtV-gBY08bEnJbI80Co9rgkJ-g>
    <xmx:bF-CYGn8dkHYdpA6ncva7KesU0AyAlaF5Y6B9ClRKHFYIzIgpVuatw>
Received: from vm-mail.pks.im (dynamic-077-011-104-051.77.11.pool.telefonica.de [77.11.104.51])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6EFC8108005B;
        Fri, 23 Apr 2021 01:47:23 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d8d4dc93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 23 Apr 2021 05:47:16 +0000 (UTC)
Date:   Fri, 23 Apr 2021 07:47:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t1300: fix unset of GIT_CONFIG_NOSYSTEM leaking into
 subsequent tests
Message-ID: <5b69d9d34e4bdf1c7eb3b172ad8ef0f78542c789.1619156659.git.ps@pks.im>
References: <20210421204637.GA2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2n4nAobNrIp5UA3d"
Content-Disposition: inline
In-Reply-To: <20210421204637.GA2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2n4nAobNrIp5UA3d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to test whether the new GIT_CONFIG_SYSTEM environment variable
behaves as expected, we unset GIT_CONFIG_NOSYSTEM in one of our tests in
t1300. But because tests are not executed in a subshell, this unset
leaks into all subsequent tests and may thus cause them to fail in some
environments. These failures are easily reproducable with `make
prefix=3D/root test`.

Fix the issue by not using `sane_unset GIT_CONFIG_NOSYSTEM`, but instead
just manually add it to the environment of the two command invocations
which need it.

Reported-by: SZEDER G=E1bor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This patch applies on top of 47e6f16901 (Sync with master, 2021-04-20),
which is the tip of next at the time of writing.

 t/t1300-config.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 0f92dfe6fb..ec599baeba 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2092,21 +2092,20 @@ test_expect_success 'override global and system con=
fig' '
 	git config --show-scope --list >output &&
 	test_cmp expect output &&
=20
-	sane_unset GIT_CONFIG_NOSYSTEM &&
-
 	cat >expect <<-EOF &&
 	system	system.config=3Dtrue
 	global	global.config=3Dtrue
 	local	local.config=3Dtrue
 	EOF
-	GIT_CONFIG_SYSTEM=3Dcustom-system-config GIT_CONFIG_GLOBAL=3Dcustom-globa=
l-config \
+	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3Dcustom-system-config GIT_=
CONFIG_GLOBAL=3Dcustom-global-config \
 		git config --show-scope --list >output &&
 	test_cmp expect output &&
=20
 	cat >expect <<-EOF &&
 	local	local.config=3Dtrue
 	EOF
-	GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_GLOBAL=3D/dev/null git config --=
show-scope --list >output &&
+	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_GLOB=
AL=3D/dev/null \
+		git config --show-scope --list >output &&
 	test_cmp expect output
 '
=20
--=20
2.31.1


--2n4nAobNrIp5UA3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmCCX2IACgkQVbJhu7ck
PpTx0A/+NtfLTHvwkUMC2VdeJsbOkjD1OJiXkomSHtwSCQN4kThdy2RVYHnvzbw9
JWlOc6LbdOg96lwjcaVvI4aBmhgLZWSkVlQO/aGcPb1lXl/PyIvCOnPw6WT3LUWH
FhQfTQY2wpai2KGt7/1rgXSTeC5ywYN58ZtAOjOOQn939H53lA6CoNt/aQDiwa5f
RNnenPQ7DwECh7wWv/XPAJ3Va6JEw714WM8MAfVasXZDxv74n5XgA6G6dvN9tWkt
Kl4wF3oeJenOhAkqwcDqz1kLPRPkG2L6rQF7ECFRtgxud+VDRFhfVZccEVE8b6hW
Ix91cUl7g9hjfcv1KQtd71CbJAhxhQUKrhMjddkGcJYS5EfqkfwWwWjkDwzE0HyI
UUJgxctMejbTr/JTAQlWvKmC/Vd3kQDyXUywvG83Wam3xu6ZOMEVPWpEetBTEQ5/
JS8tLc2upKJfVqHo83N2Swh5sATiky0vHOXkTlQYHxgo0HHxQcTECPBbrUuvFHBr
AEgP/QbnBPepIAZA+4MWYIJs1KE5XgA3o9Fzz1WgabsOWfZskVtcDQLU3FZXxmSj
34Bsoq1rY/38SDGMBKD7ArNz8/AXr55IaHQIogtwnWSU2bjRTTAH0D6A9DXtU3aK
kE5Bgpyd8kWmilKCocDdaYeebgyqVVywuXW0SlyHbqA0snp6/wQ=
=J4H/
-----END PGP SIGNATURE-----

--2n4nAobNrIp5UA3d--
