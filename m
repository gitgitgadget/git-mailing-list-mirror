Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5B3C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjDSMcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjDSMc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:32:26 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB6A167F7
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7220E32002E2;
        Wed, 19 Apr 2023 08:31:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Apr 2023 08:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907514; x=1681993914; bh=dD
        MHPNvwaXQf4RY9h1marCRFPTtAg3XCiPzp/CyB9ss=; b=R71/Oo/wmEcm/iMyVU
        v1zsSPnQr69gHwGea5w5AUs4E0BeDT2PyYavo4lUjXMIPD+J6t3XR2aYRxY+2/yf
        e8OpQGIA46ULxN+y8mv1rLzDCVqn7Ar2iFjrcG56gsBGXEvNKjFGo1fX0N5GZRQ+
        mhf1GNGbponrDPMAwbHNVSapbXSJz9CKOwR/ejTkjJ4IIPIhC+79UNeMt1DBPS8+
        8uogKmMxdWi4p6G/ZpAip0QJdMhX5I4OrWC+d5LHFqHUskE+kAsts2LtS21O2xiH
        uvOmxOijrWVf8wqORZghhLhan5rpzCvrKLkJo98yWFK0tLhhcAr8o3Vnh0I9I+jK
        KwPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907514; x=1681993914; bh=dDMHPNvwaXQf4
        RY9h1marCRFPTtAg3XCiPzp/CyB9ss=; b=iiLAyEusbYGwafIPyHmMqib6DsOiT
        eRlicC2uzf3GK/dhMGt4PczFuqWFUgloNOZYgpZxmR3HtVgrkZxItEmXrNdoTQHX
        X8OItkUmdCXldaYrr0zEtBCjmHgVUJplpkam6X9GfX9W1cer5xtFTeq1bH4z9Fg8
        hj++OpbJfBk2ltMQss9ri5yxIqu3+G6+rRv+d81RKn8ApaTV7TCBEMeNE47vyngV
        X3OEMd1WMTQ1+SdAnq3ZmO3QSyDJu4tP4a00UQyYYjEGu3+X8NH4cvH9RfRlXKof
        67w6EzNCxQSwXsH6/IXELmxPEOAqJe/x/Y+U3tO+L61JQW/6dClgVZWPA==
X-ME-Sender: <xms:Od8_ZMeJMfJ0hGamm_XqmPZ9tJe-NPuHt929k3jA1Rw1DJSl9enp1w>
    <xme:Od8_ZOOPSn4J0jnsI7PzX29uGTYPNVoLkB6yrj6jvrkt6HSgJv_zrOFOShGLhZIvL
    7MMYm0IcRU8lBVIdg>
X-ME-Received: <xmr:Od8_ZNiNqTme8fqUmWhUQYw5W4tVvgiO6hyCvjb1qi4PZ-20oRXUKSEWyO0xywuOHqpOZ5D7kMlnPvN8TY-IwpnWHWHGCZwuUmDmjha8cqzTdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Od8_ZB_hpDr1Oie4YsLRGciLLPGbVEn2QqXReT_oy559RkLR94a9sA>
    <xmx:Od8_ZIt4TcERAZNeVVSdN1jo8OOhs28xulxpqBgDkN3-QCAf6FsEiA>
    <xmx:Od8_ZIHRUxMhn3FZ8WDUmCgx6_YJhxKsdAmZHubJSvLghsG9O85vaQ>
    <xmx:Ot8_ZO2NeY7CEXngDEIJlSiiIbl2PztutYV5FulemnMg7vfj1OtZnA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:53 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 7d198abb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:40 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 7/8] fetch: introduce new `--output-format` option
Message-ID: <3b2cad066a3b3446fc335d6944a62bf79b0779bb.1681906949.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ihoAQ71d/qAykSkD"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ihoAQ71d/qAykSkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is only possible to configure the output format that git-fetch(1)
uses by setting it via a config key. While this interface may be fine as
long as we only have the current "full" and "compact" output formats,
where it is unlikely that the user will have to change them regularly.
But we're about to introduce a new machine-parseable interface where the
current mechanism feels a little bit indirect and rigid.

Introduce a new `--output-format` option that allows the user to change
the desired output format more directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fetch-options.txt |  5 ++++
 builtin/fetch.c                 | 17 +++++++++++
 t/t5574-fetch-output.sh         | 50 +++++++++++++++++++++++++--------
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.=
txt
index 622bd84768..654f96f79d 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -78,6 +78,11 @@ linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
=20
+--output-format::
+	Control how ref update status is printed. Valid values are
+	`full` and `compact`. Default value is `full`. See section
+	OUTPUT in linkgit:git-fetch[1] for detail.
+
 ifndef::git-pull[]
 --[no-]write-fetch-head::
 	Write the list of remote refs fetched in the `FETCH_HEAD`
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 81581b0033..22ba75a958 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2050,6 +2050,21 @@ static int fetch_one(struct remote *remote, int argc=
, const char **argv,
 	return exit_code;
 }
=20
+static int opt_parse_output_format(const struct option *opt, const char *a=
rg, int unset)
+{
+	enum display_format *format =3D opt->value;
+	if (unset || !arg)
+		return 1;
+	else if (!strcmp(arg, "full"))
+		*format =3D DISPLAY_FORMAT_FULL;
+	else if (!strcmp(arg, "compact"))
+		*format =3D DISPLAY_FORMAT_COMPACT;
+	else
+		return error(_("unsupported output format '%s'"), arg);
+
+	return 0;
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	const char *bundle_uri;
@@ -2101,6 +2116,8 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			 N_("dry run")),
+		OPT_CALLBACK(0, "output-format", &display_format, N_("format"), N_("outp=
ut format"),
+			     opt_parse_output_format),
 		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
 			 N_("write fetched references to the FETCH_HEAD file")),
 		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 55f0f05b6a..5144d5ed21 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -24,14 +24,37 @@ test_expect_success 'fetch with invalid output format c=
onfiguration' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'fetch with invalid output format via command line' '
+	test_must_fail git fetch --output-format >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	error: option \`output-format${SQ} requires a value
+	EOF
+	test_cmp expect actual &&
+
+	test_must_fail git fetch --output-format=3D origin >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	error: unsupported output format ${SQ}${SQ}
+	EOF
+	test_cmp expect actual &&
+
+	test_must_fail git fetch --output-format=3Dgarbage origin >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	error: unsupported output format ${SQ}garbage${SQ}
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'fetch aligned output' '
-	git clone . full-output &&
+	test_when_finished "rm -rf full-cfg full-cli" &&
+	git clone . full-cfg &&
+	git clone . full-cli &&
 	test_commit looooooooooooong-tag &&
-	(
-		cd full-output &&
-		git -c fetch.output=3Dfull fetch origin >actual 2>&1 &&
-		grep -e "->" actual | cut -c 22- >../actual
-	) &&
+
+	git -C full-cfg -c fetch.output=3Dfull fetch origin >actual-cfg 2>&1 &&
+	git -C full-cli fetch --output-format=3Dfull origin >actual-cli 2>&1 &&
+	test_cmp actual-cfg actual-cli &&
+
+	grep -e "->" actual-cfg | cut -c 22- >actual &&
 	cat >expect <<-\EOF &&
 	main                 -> origin/main
 	looooooooooooong-tag -> looooooooooooong-tag
@@ -40,13 +63,16 @@ test_expect_success 'fetch aligned output' '
 '
=20
 test_expect_success 'fetch compact output' '
-	git clone . compact &&
+	test_when_finished "rm -rf compact-cfg compact-cli" &&
+	git clone . compact-cli &&
+	git clone . compact-cfg &&
 	test_commit extraaa &&
-	(
-		cd compact &&
-		git -c fetch.output=3Dcompact fetch origin >actual 2>&1 &&
-		grep -e "->" actual | cut -c 22- >../actual
-	) &&
+
+	git -C compact-cfg -c fetch.output=3Dcompact fetch origin >actual-cfg 2>&=
1 &&
+	git -C compact-cli fetch --output-format=3Dcompact origin >actual-cli 2>&=
1 &&
+	test_cmp actual-cfg actual-cli &&
+
+	grep -e "->" actual-cfg | cut -c 22- >actual &&
 	cat >expect <<-\EOF &&
 	main       -> origin/*
 	extraaa    -> *
--=20
2.40.0


--ihoAQ71d/qAykSkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3zYACgkQVbJhu7ck
PpQq6Q//cAvGsjnv/tFOCiClbMp1KW/7doNJgku7ow+Kmlcw/BBU3pof6g8dJ1pW
KJ2HaVkSm82x4t4YwPnMQsXqBDCOB8oS2TpmFUodUpnWXbfAC3q3ceh3ZdO3nxwo
fhFU3FU6bop7mM4TkMBpWxAvl7Cq7uHOEXR/104AZFsAGQxoBlp8VhEgHYKJF8qI
e4kO0z93SPZjxUSggxPEBJAS64sHOYuwxJxTIGaqDpc1bA+reu3Tc7QsBof6m/Lp
tD9t3653EwomhJDkQ9AVS4xFwjTC7xG5ypGX8VyXEY3GKXIC+TM2vDgG9Yg63JfI
CtImmAeJvV3oyeJ4kplxFAgQWBHcUV2LIszlL4XRVkFG3+8vL/8BPGmiXEEEXY6t
8E7nRTMKni6Unyj1m/SIvgiKKrOMAGWuqiz78XyyBD61Tb7+T2iAwQsN5O4Rq7qd
ZLQzTrlHkXOlifNvRnjczjwtjL38/mQcRVe8BLBW9AoKcj7aGUs8QTYMvzddM/e4
UE/ppEQWZIzU3Ukb9ivJ4cZ6eCdOVf2mD1t0eCIGqWM7Zl/wHxNDKafL2MHLPqZV
3u9VkvOzGrGsd9dywGksVYuU809NESME/g0xQkO6hNpKFUs2Q+CZTADTsD6wO5rx
GaVj7wuMc18+PNfI++CZsammoq0ef31lxuOU0jocbZ8891pq4hg=
=5ejb
-----END PGP SIGNATURE-----

--ihoAQ71d/qAykSkD--
