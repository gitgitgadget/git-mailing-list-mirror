Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5236BC4332B
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DD1230FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAGGiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:38:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49707 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAGGiE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:38:04 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 191735C00C3;
        Thu,  7 Jan 2021 01:36:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=k1ZdIyCHQOscgcPn2wPJB2WHGIn
        JiIE+ah/VWynsW9c=; b=EqNV5Bt2D5IRTRbeIfcjtp7VwKeuFSkgPo1htvJpWtt
        +19WwhWUxTIIAUXIck+sOW03/JS4+EK/oNZCHe3PlUVuvz13q8QBFAjSjStIjJei
        HhepWXE8pUSlbvOaSje8PvweQFXOlGWQYaFGdZdTwYAs9md5WvGGfdsIqEj7bv5B
        MvwhmvYv08/Fecbb6pQzpUuB1bK48uyq4zDxSCGNrMd+u5BEeC+AZWzpfvi81YLB
        jBD9F7OuNQ4ahLaDMtchhCGdvbdZhTIruJDyMDTDPklcaqvfjxEiHqCsrNuapP0K
        8KOSyPegIsbkFoEdwp5XCwquXq3aA4g4BeYlXyij43A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=k1ZdIy
        CHQOscgcPn2wPJB2WHGInJiIE+ah/VWynsW9c=; b=SkGS21ttIsLuTT/39vUnCB
        XFCLMP8i31kfxPIV/Lf9457065XiN8pK8Ae5N5z1RyNCPBZD4B1UL2Y8aOLbFjuO
        T80Zna53LRNIR7ZYUiolesDCfBZj3k6sPnhZWRNAsuh6ZydNAwvOMHldu8l96vDG
        cCBUUyPVGk1pOI5DFba8Wy9gm/PAaMGa1wXOcOJcEhYER6AKdb/mYCUb7g5n1lJR
        dcTN9dNbNf5JqAspSH28HSXqR6WUifAeQazbUNtcigpzs1oUzxe5NMQfcpO98u/Y
        CmY3m0Y766HY08mdvHs4DRHt2jIrep/rWW44VQvgehu0ImMes6/JFj1p3055MGSg
        ==
X-ME-Sender: <xms:CKz2XzEFf0GZDf1TvU9hWp0koMYj5GYS_uUpKq9QBWGxURxJiCpIJw>
    <xme:CKz2XwVY4ZCc5j9KH92BoX74u4uddpzyPdz_njcmzkRIlliS6TrqV-D5CMhHzs5gd
    I1iJvuHAXago00-Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Caz2X1JQA5fT9JIlPOFFKR6Rs2fjhWlsM6UY2P5EkHRg-NZgqv2fpw>
    <xmx:Caz2XxFLDrP_ClK5Xj-NXN3orWWU8_Xa0HLvmt0n239LYdxfDoRzPw>
    <xmx:Caz2X5UAd0IhyxwaTwMkoOUiqxMFy7gPsO-en_TEcvQx5-ml_JGAOQ>
    <xmx:Caz2X8R0IiJAcewy7dPLZRoKKU4xJy6fKftz5ht8_zs3U8z8kCj_pg>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0DC7A24005B;
        Thu,  7 Jan 2021 01:36:55 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 380129f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:36:53 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:36:52 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 2/8] config: add new way to pass config via `--config-env`
Message-ID: <9b8461010e641369316d00e2fc58c16e0e191f42.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NGVL8eNSqFPAHwY6"
Content-Disposition: inline
In-Reply-To: <cover.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NGVL8eNSqFPAHwY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While it's already possible to pass runtime configuration via `git -c
<key>=3D<value>`, it may be undesirable to use when the value contains
sensitive information. E.g. if one wants to set `http.extraHeader` to
contain an authentication token, doing so via `-c` would trivially leak
those credentials via e.g. ps(1), which typically also shows command
arguments.

To enable this usecase without leaking credentials, this commit
introduces a new switch `--config-env=3D<key>=3D<envvar>`. Instead of
directly passing a value for the given key, it instead allows the user
to specify the name of an environment variable. The value of that
variable will then be used as value of the key.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt | 24 ++++++++++++++++++++++-
 config.c              | 21 ++++++++++++++++++++
 config.h              |  1 +
 git.c                 |  4 +++-
 t/t1300-config.sh     | 45 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index a6d4ad0818..d36e6fd482 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,7 +13,7 @@ SYNOPSIS
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
-    [--super-prefix=3D<path>]
+    [--super-prefix=3D<path>] [--config-env <name>=3D<envvar>]
     <command> [<args>]
=20
 DESCRIPTION
@@ -80,6 +80,28 @@ config file). Including the equals but with an empty val=
ue (like `git -c
 foo.bar=3D ...`) sets `foo.bar` to the empty string which `git config
 --type=3Dbool` will convert to `false`.
=20
+--config-env=3D<name>=3D<envvar>::
+	Like `-c <name>=3D<value>`, give configuration variable
+	'<name>' a value, where <envvar> is the name of an
+	environment variable from which to retrieve the value. Unlike
+	`-c` there is no shortcut for directly setting the value to an
+	empty string, instead the environment variable itself must be
+	set to the empty string.  It is an error if the `<envvar>` does not exist
+	in the environment. `<envvar>` may not contain an equals sign
+	to avoid ambiguity with `<name>`s which contain one.
++
+This is useful for cases where you want to pass transitory
+configuration options to git, but are doing so on OS's where
+other processes might be able to read your cmdline
+(e.g. `/proc/self/cmdline`), but not your environ
+(e.g. `/proc/self/environ`). That behavior is the default on
+Linux, but may not be on your system.
++
+Note that this might add security for variables such as
+`http.extraHeader` where the sensitive information is part of
+the value, but not e.g. `url.<base>.insteadOf` where the
+sensitive information can be part of the key.
+
 --exec-path[=3D<path>]::
 	Path to wherever your core Git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
diff --git a/config.c b/config.c
index 1137bd73af..cde3511110 100644
--- a/config.c
+++ b/config.c
@@ -345,6 +345,27 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
=20
+void git_config_push_env(const char *spec)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	const char *env_name;
+	const char *env_value;
+
+	env_name =3D strrchr(spec, '=3D');
+	if (!env_name)
+		die("invalid config format: %s", spec);
+	env_name++;
+
+	env_value =3D getenv(env_name);
+	if (!env_value)
+		die("config variable missing for '%s'", env_name);
+
+	strbuf_add(&buf, spec, env_name - spec);
+	strbuf_addstr(&buf, env_value);
+	git_config_push_parameter(buf.buf);
+	strbuf_release(&buf);
+}
+
 static inline int iskeychar(int c)
 {
 	return isalnum(c) || c =3D=3D '-';
diff --git a/config.h b/config.h
index c1449bb790..19a9adbaa9 100644
--- a/config.h
+++ b/config.h
@@ -138,6 +138,7 @@ int git_config_from_mem(config_fn_t fn,
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     const struct object_id *oid, void *data);
 void git_config_push_parameter(const char *text);
+void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
 void read_early_config(config_fn_t cb, void *data);
 void read_very_early_config(config_fn_t cb, void *data);
diff --git a/git.c b/git.c
index 5a8ff12f87..b5f63d346b 100644
--- a/git.c
+++ b/git.c
@@ -29,7 +29,7 @@ const char git_usage_string[] =3D
 	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--inf=
o-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects]=
 [--bare]\n"
 	   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
-	   "           [--super-prefix=3D<path>]\n"
+	   "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar=
>]\n"
 	   "           <command> [<args>]");
=20
 const char git_more_info_string[] =3D
@@ -255,6 +255,8 @@ static int handle_options(const char ***argv, int *argc=
, int *envchanged)
 			git_config_push_parameter((*argv)[1]);
 			(*argv)++;
 			(*argc)--;
+		} else if (skip_prefix(cmd, "--config-env=3D", &cmd)) {
+			git_config_push_env(cmd);
 		} else if (!strcmp(cmd, "--literal-pathspecs")) {
 			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "1", 1);
 			if (envchanged)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97a04c6cc2..46a94814d5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1316,6 +1316,51 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMET=
ERS' '
 		git config --get-regexp "env.*"
 '
=20
+test_expect_success 'git --config-env=3Dkey=3Denvvar support' '
+	cat >expect <<-\EOF &&
+	value
+	value
+	false
+	EOF
+	{
+		env ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config core.nam=
e &&
+		env ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config foo.=
camelcase &&
+		env ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool foo.flag
+	} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git --config-env fails with invalid parameters' '
+	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>error=
 &&
+	test_i18ngrep "invalid config format" error &&
+	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config --bool fo=
o.flag 2>error &&
+	test_i18ngrep "config variable missing" error
+'
+
+test_expect_success 'git -c and --config-env work together' '
+	cat >expect <<-\EOF &&
+	bar.cmd cmd-value
+	bar.env env-value
+	EOF
+	env ENVVAR=3Denv-value git \
+		-c bar.cmd=3Dcmd-value \
+		--config-env=3Dbar.env=3DENVVAR \
+		config --get-regexp "^bar.*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c and --config-env override each other' '
+	cat >expect <<-\EOF &&
+	env
+	cmd
+	EOF
+	{
+		env ENVVAR=3Denv git -c bar.bar=3Dcmd --config-env=3Dbar.bar=3DENVVAR co=
nfig bar.bar &&
+		env ENVVAR=3Denv git --config-env=3Dbar.bar=3DENVVAR -c bar.bar=3Dcmd co=
nfig bar.bar
+	} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
--=20
2.30.0


--NGVL8eNSqFPAHwY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2rAMACgkQVbJhu7ck
PpSDbw//awrvCH49Udmxlq/9sTLO6leARoU/eXZyOzEj2TRrfuBFTOOxxucekO/B
E1peiZE3b+Gbge5SW3sEjJthsBoM+zKRzHHJzRKCIXXcj8diSUwOcJZgw4W2Fojt
TE6yQo8JC/7rcXlY968JmBwG3QgbUrhh/f7VX9nvKx4v+HMpyHtKWM8LtEFDVI5T
PACnT3C+gJLemucwpGnrUZ+j1NQ8H6MCDBr4h5AHCWCSni++DwrSuv1eteidD1vp
0pUI1KcRuSb58sLMPu39fXjn/F4Q0T4Gdu2oVg2020qJxAVh1nU8/+yY+JNI6TPM
ijN+qiYFjpWpaURvv5E49DbHqRersiHrXz8PQFUglGAVSokxY+x0UdNauExF7Ydq
lDuiElxtThsyGrGsI8HVmNgelLtpKsES8kpFi8a0UQI3f7JICokTwwGU/iXOM+Fx
4geIyNo6rDEgyBOtlqvvfwZ+09bVFMnHvnlKA/RWqAAXabfchB1xQP2qxpWMU4Jo
/j+zssP/UflFqBto+iedPkjtS5+z5snBZ3i3GtpX8goTyR2bQi8S3Fi3ECxiA8fU
aYvRmxCFl1Flxmy6wB8rdzrWM2y8dgZTJm7twCcpQs4WmbZUvu41xNnbBVg39IRk
eLK4foRM2VnTtZOevdHq9NAYk9iiNgviR98MDoiwXXyMVhi5HYI=
=W+3F
-----END PGP SIGNATURE-----

--NGVL8eNSqFPAHwY6--
