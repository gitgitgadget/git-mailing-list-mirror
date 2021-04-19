Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B49EC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7F461285
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbhDSP4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:56:03 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43875 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241544AbhDSPz7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 11:55:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4F8B710D2;
        Mon, 19 Apr 2021 11:55:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Apr 2021 11:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=UpXBPpEkROKfBi1usARRSuAMxTM
        SdZQMgMByA4PuPJE=; b=USWHz35q/tB/G9DgMGJJDrm62YtRDv20mjTK5a5vyNL
        VnZEeq/qw1SrjXH6EtvNBddcL2e5UqNnhwgIguZSd2/s61ekqCd/NHM+G3ztEFIA
        QPtLMIMue+6uP/flULzA+DyP+bBGWRLJf5CNE9zkbVkvTKPBlWfsSfjdvBAyZnis
        4th5kCkXa3qedHE6lv3c0opZ2iHanJi66z9ztwveVSrPT6+mZkAme4qoKjVcg/lV
        o2VWfja3Qj3mmMKWyGx8Q94r9ID/pBWNyVDU5Wr1UcGawSh4SqpCMASHkPorN7eq
        nwdGNLdOxZhaDMcqfcWnN5VC/QzghSkAJiSQTScC0gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UpXBPp
        EkROKfBi1usARRSuAMxTMSdZQMgMByA4PuPJE=; b=AOORil2vp9VHQ6RWi0NWoH
        KhOyfcE5kkeAKDN9kbtl9ymaQccYGkky/RfSYm+wNBDCn8+C+bkTyBnFrGeIHEva
        nGHgoKiywaW5lHe75jgdMndQe1vKKVB0lF4WvMclbnU2buAV6GRYKsoGr/yoVnoN
        x04eLoFiJMLziKSM/CWh7tMbEEba4tieFXD6h6twYVHeX1VcPrgFaN1k5FvRMSqE
        73lbi7XtxS+zfP6yUVNM1J5Gq6nznEz7QyRT0FeQqs9ff0ebNsT+tQwYAdqlF2Ar
        eXWPjTGZRDUdW0HwT9SOXMpVwlwUovHN+QwP+dB+Sbw5WxUzlrOo2eyLUivgNkQA
        ==
X-ME-Sender: <xms:8Kd9YMtF15LT099NQHk_tKdS3VWEkThqOlN_IliteHOwkupbsYw2zA>
    <xme:8Kd9YGJlK13pHYmCM5gTIewvsmYWXYTr0kfievLy1NykRCWM7v3pe81rt2r6y03wz
    ribstcRTVdpsmsE0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudeluddrieekrdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:8Kd9YLoZ1pRBVb9W34xS5DAGKC7NcQylBcpQd5VYUByvNu5Nt5bZhA>
    <xmx:8Kd9YJUDhFs4kysXl2P9qc8bczYaaBqntJlab01_nYO58fjbRxfCJw>
    <xmx:8Kd9YA2yQN2QVOoZtk80vMiB1Rbo6ygdUV6J2i1uVh6WG9YvXZmiSA>
    <xmx:8Kd9YDKSZ_DhAqTD6dOg5HYpzHrVAm5K7ymRy13fkl-Iyw6v_9L-WQ>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F8A724005D;
        Mon, 19 Apr 2021 11:55:28 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ae84bfd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 15:55:27 +0000 (UTC)
Date:   Mon, 19 Apr 2021 17:56:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 2/2] git: support separate arg for `--config-env`'s value
Message-ID: <d52db89bc2f40a9df5e9fafe4e1bb8c173a7f45f.1618847606.git.ps@pks.im>
References: <cover.1618847606.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rhTDc7k3lKkukEKC"
Content-Disposition: inline
In-Reply-To: <cover.1618847606.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rhTDc7k3lKkukEKC
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
index e0dd5d65ce..18803f9953 100755
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
+	test_i18ngrep "no config key given for --config-env" error &&
+	test_must_fail env ENVVAR=3Dvalue git --config-env config core.name 2>err=
or &&
+	test_i18ngrep "invalid config format: config" error
+'
+
 test_expect_success 'git --config-env fails with invalid parameters' '
 	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>error=
 &&
 	test_i18ngrep "invalid config format: foo.flag" error &&
--=20
2.31.1


--rhTDc7k3lKkukEKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9qEYACgkQVbJhu7ck
PpRYrg//RJcEE5hxlkMXog0Il8yAGlddtf/tRWNK/DVHJOi/JbuVZGIC8RzreH73
yG9ffovzA+iTn2iIZyoODCG98vK226IRfx676EnhFpva4FSIKcYiwtFix4h9S89v
uKSljz7ToMQk3eTd7Yak7fVSJf/+w4W9A36qCHGND7wUI8xmKeaho5YUdQnrOXff
jF5EaLqyj4zWG4QJD1D45afR9fAG55qPJ1EvgoBmgzZVR9Gq9cyd87T/VUJkcRvX
KP0tGReucJSsLFJanU5cfkLivwFXa4D+thOJ1EZKDRVifHcidXeZJTrqAvaVUZ5T
su5eZjjpqULRpw19OQ3gRYRQCwqWMtIg+hmFQJIhx8CjgKO3adEpUWkwDXlhPbIi
sAw/zqivLbfSM0evJwg1VoNDQHSLhkoji/hmnJcoisCrYpH1NCK5AxG65kGQwJgX
ulhBo+lg16UbBIIVBaQSMoS0h5/EsQhQzxL1if95BGBy5V8X4l34Wo+LU+jM/K9S
5JQFtJw1o6eh1z2ZMBLF7uFl4jqh/+4yYNYriPWXdpJFQpC7w42G6PW408RtaIC7
S0hxLBbFQ8UP9w6xVEUFcmlzr3/p9gdiOXA5bjFWvJAL3e0KZw2H/Zd570dFl7+0
BSFqoBm12gndatlQE1zDQq0SQygSdk69jDx76wWnU1pXgSNpHtY=
=p4Qh
-----END PGP SIGNATURE-----

--rhTDc7k3lKkukEKC--
