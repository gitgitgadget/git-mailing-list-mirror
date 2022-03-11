Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACBDC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 11:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbiCKLKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 06:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiCKLKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 06:10:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E77086F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 03:09:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DE455C0224
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 06:09:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Mar 2022 06:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; bh=Y
        56/sNXGleLQ9IZAZ9fApp0cThlbRf8lGxtcXUL8Ivc=; b=mrhWE1Q2eTFSFuPUR
        8N0lqddVQwV6sLSmmSOY0kgekaFRknYVVtpn9zBCpOArU52BnRoFJAY9NiX0Bmeo
        k6om7/Yej0UWlBb9XnpKueenRF1PDeyZDs064VDtjVkXoR3HycIEm6n0EH5pMfR1
        derVQhWTnPi9RuIax5d/UDtksQqQUZmnGBbBmUre3NNyIQs73wJ45QNSil+BdJYV
        JenOrBAp6ER/x1NOMHQiDGjaFn0lEkiubidRSLO1xQrxJODZmTzNOYWwV6aaWsOI
        ecnZw/3sewOX+vXLNBB4h6EttyDT2zQVfaxmvpjQsbuLXqXZ7jXfE2gUDKo3/oMF
        TunrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Y56/sNXGleLQ9IZAZ9fApp0cThlbRf8lGxtcXUL8I
        vc=; b=F37m6chzSjqavRcZn2MZLiWneohc29bDXSlLZ8jUhU9MeuPyXmXq/rWzb
        Jq04CcWp6lGpbM+KyUVPlwA1tszT+z+4u2HsWN9XhsWkncr3Okpa+GWyyRQE1RUq
        rpbUBeAG+qJLy0wjjsnzpL32W6fyqYfwgD1z7Kbxxr/MdPGB3lkw4ey7LHNp1XaC
        96EQTl5c/E4dBjnkdLDBcA32sSelT60V/rRhqaEepVwZ4oUvYG65eS5E25un6tHc
        Tce9ENx6ZC/wmJwV76/oTDENl0icD2hqTvM6PLws1OPOivuQN7tAPehGY0ylqwwt
        yq/oz+Y+QrydItdMfNg5y8Gv07iKg==
X-ME-Sender: <xms:7y0rYjUjQcaey_eHKtEviPRAKkkG3F1qz6h11VuvmBAljmQ9cVivoQ>
    <xme:7y0rYrm3L6K6IjtRdc3L6DA4C3RWF9wLuk9TMu5ABY2VKoyND0XBR-1ZqIUQFOdet
    0LFDD8c_60drcpI4w>
X-ME-Received: <xmr:7y0rYvbHTbGiw7m-W-mgkGTDHu1u12blax9YGeFSsoWvj-ZI6UqMLuMYyGnYsx1QxXNGzZdaiT73DAqTRYczlTN_UTtH2tZ3ls3DuxHxS8vCbDLhOli_epGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7y0rYuWTcE_muOXq4aeVBEFPMLgsfvecWuoJTLVfIJyIaiuqbBSUPg>
    <xmx:7y0rYtl6LiG-336REe8xmNQ6Cghq8Nardi1hWeaBxliBpDB7c23mTA>
    <xmx:7y0rYrfgG9Kh6Tj0rHdHZ5s75OA0Y676t0orIa3KCll5mtgjEvUylQ>
    <xmx:7y0rYrTIw29UoIOa9NT-MLObhb8PWf4tNQMZqTvueHWd4JAL9x9QPQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Mar 2022 06:09:34 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4c7a1548 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Mar 2022 11:09:31 +0000 (UTC)
Date:   Fri, 11 Mar 2022 12:09:30 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] repack: add config to skip updating server info
Message-ID: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oeZpxCDeQ3nV83S7"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oeZpxCDeQ3nV83S7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

By default, git-repack(1) will update server info that is required by
the dumb HTTP transport. This can be skipped by passing the `-n` flag,
but what we're noticably missing is a config option to permanently
disable updating this information.

Add a new option "repack.updateServerInfo" which can be used to disable
the logic. Most hosting providers have turned off the dumb HTTP protocol
anyway, and on the client-side it woudln't typically be useful either.
Giving a persistent way to disable this feature thus makes quite some
sense to avoid wasting compute cycles and storage.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/repack.txt |  3 +++
 builtin/repack.c                |  6 ++++-
 t/t7700-repack.sh               | 47 +++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.=
txt
index 9c413e177e..22bfc26afc 100644
--- a/Documentation/config/repack.txt
+++ b/Documentation/config/repack.txt
@@ -25,3 +25,6 @@ repack.writeBitmaps::
 	space and extra time spent on the initial repack.  This has
 	no effect if multiple packfiles are created.
 	Defaults to true on bare repos, false otherwise.
+
+repack.updateServerInfo::
+	If set to false, git-repack will not run git-update-server-info.
diff --git a/builtin/repack.c b/builtin/repack.c
index da1e364a75..3baa993da2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -22,6 +22,7 @@ static int delta_base_offset =3D 1;
 static int pack_kept_objects =3D -1;
 static int write_bitmaps =3D -1;
 static int use_delta_islands;
+static int no_update_server_info =3D 0;
 static char *packdir, *packtmp_name, *packtmp;
=20
 static const char *const git_repack_usage[] =3D {
@@ -54,6 +55,10 @@ static int repack_config(const char *var, const char *va=
lue, void *cb)
 		use_delta_islands =3D git_config_bool(var, value);
 		return 0;
 	}
+	if (strcmp(var, "repack.updateserverinfo") =3D=3D 0) {
+		no_update_server_info =3D !git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
=20
@@ -620,7 +625,6 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 	const char *unpack_unreachable =3D NULL;
 	int keep_unreachable =3D 0;
 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
-	int no_update_server_info =3D 0;
 	struct pack_objects_args po_args =3D {NULL};
 	int geometric_factor =3D 0;
 	int write_midx =3D 0;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5922fb5bdd..f049120022 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -381,4 +381,51 @@ test_expect_success TTY '--quiet disables progress' '
 	test_must_be_empty stderr
 '
=20
+test_expect_success 'updates server info by default' '
+	git init repo &&
+	test_when_finished "rm -rf repo" &&
+	test_commit -C repo message &&
+	test_path_is_missing repo/.git/objects/info/packs &&
+	test_path_is_missing repo/.git/info/refs &&
+	git -C repo repack &&
+	test_path_is_file repo/.git/objects/info/packs &&
+	test_path_is_file repo/.git/info/refs
+'
+
+test_expect_success '-n skips updating server info' '
+	git init repo &&
+	test_when_finished "rm -rf repo" &&
+	test_commit -C repo message &&
+	git -C repo repack -n &&
+	test_path_is_missing repo/.git/objects/info/packs &&
+	test_path_is_missing repo/.git/info/refs
+'
+
+test_expect_success 'repack.updateServerInfo=3Dtrue updates server info' '
+	git init repo &&
+	test_when_finished "rm -rf repo" &&
+	test_commit -C repo message &&
+	git -C repo -c repack.updateServerInfo=3Dtrue repack &&
+	test_path_is_file repo/.git/objects/info/packs &&
+	test_path_is_file repo/.git/info/refs
+'
+
+test_expect_success 'repack.updateServerInfo=3Dfalse skips updating server=
 info' '
+	git init repo &&
+	test_when_finished "rm -rf repo" &&
+	test_commit -C repo message &&
+	git -C repo -c repack.updateServerInfo=3Dfalse repack &&
+	test_path_is_missing repo/.git/objects/info/packs &&
+	test_path_is_missing repo/.git/info/refs
+'
+
+test_expect_success '-n overrides repack.updateServerInfo=3Dtrue' '
+	git init repo &&
+	test_when_finished "rm -rf repo" &&
+	test_commit -C repo message &&
+	git -C repo -c repack.updateServerInfo=3Dtrue repack -n &&
+	test_path_is_missing repo/.git/objects/info/packs &&
+	test_path_is_missing repo/.git/info/refs
+'
+
 test_done
--=20
2.35.1


--oeZpxCDeQ3nV83S7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIrLekACgkQVbJhu7ck
PpRWnA/+Iw1gAFhM9iG0HOvtkuh4QHMBNSD0HOKUwR0UnXyJG4H8soCEXnB/DtL1
XHPu0hALLsv6mV2sSsH0YJINkcVXrFpOkc+mHwoBFQJ1DxS5QBPIf3fIOwyw7+RM
h+CLufFaLBPBwD0JnhfSePWTKUWkDhGTXUY1f4Pu0PHVBa2Qqiuyaoaly+q/W3i4
6v9+3e/9oZhOXmUex+ry6p6eVHs9rP16vhhqFbejNBIwnd8mJQlrENEBMd9eUbnS
MBdDNMdd/Kr86n7S2Dg8Im6XqqTXFJ2YxGJ2VCOWBPovrVzDykjPJ0fShA56MUf5
pLxOrnFYTHoLZGAk6rID1Kz/oSh2HZyXzzbswWOeUmQLtXq7UQFUJPPYoLf+lRrg
TtdRoSfb2yonTgrtpVY/ont1dQvaaydHlOUyb0E0V13hXNDDgS/u/pN6kBUWF5lp
oVoEDJRVb46MO7P47V5RErMoJ4BdNOKD2E+Ekuzdu56UC8ZJ+H3B2q43/SmevZSq
E1c0xNQEYDIjJhNgRvy2X97J7WfVGqUKtdREZyyd3xVAEpELI4hK5j+n/CdKpU/F
GGO6YFU9evXyyaQPbpj81U/RSsPdheMZ3cYWo4I/zWbps2NwyALBhq/3gjhPPq7C
Np5OLjI2u46K7IvG21djwlB7yyh3R8gwaVjy7fZvZTcehpZ0qSY=
=NK2+
-----END PGP SIGNATURE-----

--oeZpxCDeQ3nV83S7--
