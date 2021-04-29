Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BB6C43461
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B5361423
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhD2Myj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:54:39 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59997 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237260AbhD2Myh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Apr 2021 08:54:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 06C78167F;
        Thu, 29 Apr 2021 08:53:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 29 Apr 2021 08:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=g+dBJuXNgpnRiy3+xQWlDuNgQHX
        SgE7PqkDp9/gNfII=; b=UyZrtbpwk7w2x6K+5WNDyC/2r2GU3JS4z+X/8HlmthI
        z3g2nOvZu28y90MhbZ0yx+F2D/RBMImjhCn3rsaaMcHVrF7r92rkx6kXYf1TTOVg
        LbLLDlHCe2qOhdt6tWUjNSMvqHULBDdwpa6QMUZVY0PyDGI7N+04mOBN0SijTCxq
        27c4Vn1KP06xFPQlt0nAWLOTuFqbeMNZk3UK57hWguDuUI7GMKRW5x4WLdDyUJBy
        0iXW4ON8Mj9Vtu4Ime1LJ64eju9ZdeW0ueJh4JtdISIXcVJTfLj4OvLwAUJJtUmJ
        7/aE71CIOsh7qS8H9yfP6NQ64QoQVJJvkTqzI+bkEPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=g+dBJu
        XNgpnRiy3+xQWlDuNgQHXSgE7PqkDp9/gNfII=; b=TMjxlT7TbJb6kUz3JlN27X
        p1UeWQGj7exqPKfKKRUp6dmARw4IGUfgRIuWmDuE3A99kvg9Lb8C/yGqjeYD5Nqb
        36C+A15XbYE1pN2uG0H/PMJP/CJtVlftZho9OsHOrbkf6GHaGhifhlqZVV8Dm7wX
        /yM9xqZe3cEp7lItj0aLz6C+JIWwYJXKhIhJiuRjOtjSy/K9KoukX/etADG11p/V
        o4GKwhTcu5MzsWeztrrwSgvvBY+njH8IR7Jc3lSQNikLRvRqcxXFvdn1jPZbFZOJ
        Sa4+2ebQXeDXMal1MO/ZpzzeYG+3DjaZe7If1jCzozDRB3R6kWXkP32e1+x7PIRA
        ==
X-ME-Sender: <xms:XqyKYEDdJdV6phMZ-fWtVaITVN7u16Bs-wUp41H0AsSQvuW60EHM_w>
    <xme:XqyKYGjQ3ISbGO5RbZW99zXHaL-0mvN-n373JsLhJEahvKWgQQ1YvU5lVicF7Y4HS
    KHh_5tESVlXhWPYgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejkedrheehrdefgedrkeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:XqyKYHmEgjwXG2Tma_LlwFnhBm8gqtwB0tmzpiZulFxeV_BoI1KEfw>
    <xmx:XqyKYKyJBllz6_w1ypUtrc5UQV8xinbAdh05FAjmFPXma411_ZZy2g>
    <xmx:XqyKYJTqTBbNdEWAljruHlh2uv02kk8iV4rTAAxg4PZVijUAJ3MgHg>
    <xmx:XqyKYK5X5FEgtwHDVaC9Lir-vAKAw2aEYPlV_XOyJXt-lKTyOwN8-A>
Received: from vm-mail.pks.im (dynamic-078-055-034-087.78.55.pool.telefonica.de [78.55.34.87])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 08:53:49 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2e9a5f11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 29 Apr 2021 12:53:49 +0000 (UTC)
Date:   Thu, 29 Apr 2021 14:55:34 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] git: support separate arg for `--config-env`'s value
Message-ID: <5264fb6fa7e05b55ab48d02265d8611536dc93f1.1619700731.git.ps@pks.im>
References: <cover.1618847606.git.ps@pks.im>
 <cover.1619700731.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UOAGMSt9OD9nBlur"
Content-Disposition: inline
In-Reply-To: <cover.1619700731.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UOAGMSt9OD9nBlur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While not documented as such, many of the top-level options like
`--git-dir` and `--work-tree` support two syntaxes: they accept both an
equals sign between option and its value, and they do support option and
value as two separate arguments. The recently added `--config-env`
option only supports the syntax with an equals sign.

Mitigate this inconsistency by accepting both syntaxes and add tests to
verify both work.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c             |  8 ++++++++
 t/t1300-config.sh | 15 ++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index b53e665671..ad365c05c7 100644
--- a/git.c
+++ b/git.c
@@ -255,6 +255,14 @@ static int handle_options(const char ***argv, int *arg=
c, int *envchanged)
 			git_config_push_parameter((*argv)[1]);
 			(*argv)++;
 			(*argc)--;
+		} else if (!strcmp(cmd, "--config-env")) {
+			if (*argc < 2) {
+				fprintf(stderr, _("no config key given for --config-env\n" ));
+				usage(git_usage_string);
+			}
+			git_config_push_env((*argv)[1]);
+			(*argv)++;
+			(*argc)--;
 		} else if (skip_prefix(cmd, "--config-env=3D", &cmd)) {
 			git_config_push_env(cmd);
 		} else if (!strcmp(cmd, "--literal-pathspecs")) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e0dd5d65ce..ad4e6d0cfc 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1374,16 +1374,29 @@ test_expect_success 'git --config-env=3Dkey=3Denvva=
r support' '
 	cat >expect <<-\EOF &&
 	value
 	value
+	value
+	value
+	false
 	false
 	EOF
 	{
 		ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config core.name &&
+		ENVVAR=3Dvalue git --config-env core.name=3DENVVAR config core.name &&
 		ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config foo.came=
lcase &&
-		ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool foo.flag
+		ENVVAR=3Dvalue git --config-env foo.CamelCase=3DENVVAR config foo.camelc=
ase &&
+		ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool foo.flag &&
+		ENVVAR=3D git --config-env foo.flag=3DENVVAR config --bool foo.flag
 	} >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success 'git --config-env with missing value' '
+	test_must_fail env ENVVAR=3Dvalue git --config-env 2>error &&
+	grep "no config key given for --config-env" error &&
+	test_must_fail env ENVVAR=3Dvalue git --config-env config core.name 2>err=
or &&
+	grep "invalid config format: config" error
+'
+
 test_expect_success 'git --config-env fails with invalid parameters' '
 	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>error=
 &&
 	test_i18ngrep "invalid config format: foo.flag" error &&
--=20
2.31.1


--UOAGMSt9OD9nBlur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmCKrMUACgkQVbJhu7ck
PpTR3w/+Pc2KFkIqacuC+/QmWmHc3RdaWSYZm2RitZ8ExMLN9UMMNHnStcmWgcoj
C+Z4vRQret7L70O8fn3SskPEhcoS8yn0Qq+BCQgWYIAzG65pga3oaUiqrvTduuIP
0GgwKDMVYv26NIBGLd+cszdrS9Ye/CFmUX1c/PpelJhkvYKbshrl2o5MMvZe4L43
yH3eyztmuTI4raAsHac57EViyI8FLUFaBnx7CD/JQmd5+TLhyD9kygOcET7YMsF3
cyaO6Lp9iWnzpaMtZw5lkwIxAQ6yHd23gXnegLKcAeNI4KvsETwQ9/PpNAYq20rI
/eu3xYlXGhlbfi6X/v12s2plnwGO1hEsrxqEtYXuulwyXCFcFo4cNBOYQgcQO3kF
tXJAZNMZEiscKoF3q7dYOtXYN06N2WH4AvySW2ZtK3ABEmMA+FO4EQbwbtA5/Uqs
VB+G0kGxQg3fMUMArj1h66Zt07LgqAjvHHaXfL9iqpEf54MjYNFgqiZRvjtFmr3n
Vsv91TEq/vrk4efjcVs+tJMneiqq1R68jzG8WfUK24H3pprZ+vDXqLbJ4Nl/8Az0
/b2elHt0dNkQiIPiz8+tF/8F4d3aP5vjqJfZ3pscbNYn0JPGszms4VWIoLI7NLt+
6LmejFKOoatBg3ZSg5qbKHEQYtseDFALwjTY02wti5BWt00NT50=
=Pkck
-----END PGP SIGNATURE-----

--UOAGMSt9OD9nBlur--
