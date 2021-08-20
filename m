Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC0C432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C277610F9
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbhHTKJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:09:19 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51725 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237971AbhHTKJN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 06:09:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id D90F25C0113;
        Fri, 20 Aug 2021 06:08:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 20 Aug 2021 06:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=uIjpf8tR+6ibddGUl+f3r7X7lPV
        eV6i1QGmt+3Jh2C0=; b=jRlq3SnIwSNnTcyeo4vOsXapDDAQa8wcQf9R4AICb+V
        YMJp6oubH8rssnDII+kQYjLNEuVdCIvmkvhxNZ4b0JORTJ7b9e89DbZAk80jqXgF
        Q8iXiMckOx9CswlZy7dtEyLySE8Woiop3Ug1Y+hi167A9weTXIFb6HyYx/zHnrME
        Q5h+yuUYV/jG8/8+VBVZvboVkxtkyoK+rmD1Bj/YxW3udj2yWODUMC8q8KL5PwyG
        9rGTr6aqW/xyGqgPniRMltfEpRkFF0YQ1aoEkiwc6LS7JHjjq5njdNnyhgfqgKuK
        6wYY2TrAeDta2wWsCJRG3+x1A4QYmF525tPAOcdEqIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uIjpf8
        tR+6ibddGUl+f3r7X7lPVeV6i1QGmt+3Jh2C0=; b=gKQbW0xxZP6Rh66vLLn/mD
        iZBCn49eGKPdabY/Jgc+ZPOhocyHJ/lRsgLnAG+D5h0ngL8Meudw6g5uQs1JwniZ
        Ad42Banumsftyqt9RR5Wb9xeH+iPI0+2wam4snwtxCziB0KQrMLj49VOmnd9/CWI
        qWipTVZowkDCJxGORqaKqKwcJ86/mTkvqBH5Vz5YRYCPIXZfhL0RFWX3wHLnMsmO
        eRQ1fU38Za1JECOww4Z2Yxy5jBXcHqNhK5U5tNxcGazpPT7YyjYA7cYyF6/DcsZB
        jhkUtKzEAGZPjRwc7wwmGpHLnEhYKMwMvtKP4HCNKlRWnXoWFYdM9u2teGEyhqtg
        ==
X-ME-Sender: <xms:I38fYZlBuk8qRHRKHzOvxtCw9kdTHnar7a8Qjy4kmxKOwdBu55WavA>
    <xme:I38fYU2AP7jSCznxE7IheBtWrB2RyJijCjQFiWDdlFT_tf1VOeX3cBddEFgiOofxk
    XkuCsoNOVqlrXN77g>
X-ME-Received: <xmr:I38fYfomq4Qcui4KlvGYLYAnIhCzWCdoSnteCOyHHR_EZ5IDyfPEEFiRK6mOWxuKXMXoyAzZtaCA9rbbHYiT29KztD9G6fYnGJjvETlXDsFA3AFarvr3WPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:I38fYZmgP0E9o5Umnbpc1VBh8JS5zXUOhbabaXBE8LCP_O4DupHj7g>
    <xmx:I38fYX2bsOn5rcdeFaRdGIS0S_cd4pt9g7jEmxxW_hr4TMpK7u5E_g>
    <xmx:I38fYYseB2oBeB5mlB8EL14f6U05bz-9rFZrONu_T3W1O47giewxpw>
    <xmx:I38fYVC7MqkFyaj2azqi1wW3TfwtsCT4KduUpSSvE8N0mnv49anEaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:08:34 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ea9f842d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Aug 2021 10:08:34 +0000 (UTC)
Date:   Fri, 20 Aug 2021 12:08:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] fetch: avoid unpacking headers in object existence check
Message-ID: <d3dac607f2235c5913621813c443aa10b99c8fe8.1629452412.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqv1BW5vOjVgQZBt"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lqv1BW5vOjVgQZBt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When updating local refs after the fetch has transferred all objects, we
do an object existence test as a safety guard to avoid updating a ref to
an object which we don't have. We do so via `oid_object_info()`: if it
returns an error, then we know the object does not exist.

One side effect of `oid_object_info()` is that it parses the object's
type, and to do so it must unpack the object header. This is completely
pointless: we don't care for the type, but only want to assert that the
object exists.

Refactor the code to use `repo_has_object_file()`, which both makes the
code's intent clearer and is also faster because it does not unpack
object headers. In a real-world repo with 2.3M refs, this results in a
small speedup when doing a mirror-fetch:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     33.686 s =C2=B1  0.176 s    [User: 30.=
119 s, System: 5.262 s]
      Range (min =E2=80=A6 max):   33.512 s =E2=80=A6 33.944 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     31.247 s =C2=B1  0.195 s    [User: 28.=
135 s, System: 5.066 s]
      Range (min =E2=80=A6 max):   30.948 s =E2=80=A6 31.472 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.08 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 73f5b286d5..5fd0f7c791 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -846,13 +846,11 @@ static int update_local_ref(struct ref *ref,
 			    int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
-	enum object_type type;
 	struct branch *current_branch =3D branch_get(NULL);
 	const char *pretty_ref =3D prettify_refname(ref->name);
 	int fast_forward =3D 0;
=20
-	type =3D oid_object_info(the_repository, &ref->new_oid, NULL);
-	if (type < 0)
+	if (!repo_has_object_file(the_repository, &ref->new_oid))
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
--=20
2.33.0


--lqv1BW5vOjVgQZBt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEffx8ACgkQVbJhu7ck
PpS02g//WjSL54PcchpW47MOeW6x47LkKbfBVbOs+IpdTJs0x9tVAkrz3/7NKLHH
qzgNO8vkz+K2MFe30rTrkf0PN5Ft5X9/xVAJnpWCsPYAnc5DgfRYc0uiOqunuCda
ZIFewzjMtiEFrsaJmz/yCYjYrliBs34wvNr29JGqs8FqwE4eBhWAXjnsVXfznpO5
pFZsuLCkTiOiY6vSsyAP7wkZ560ZSbtTHoPyukvWs3lFxOLa7Kj7jKzOoOxQUqFe
kakjYjanw7d8zEr7UBRzRTCYpYGSU2SHN/sikMlS9+Bp0YYzotSy5o0l046AQW4W
Y9SRwdtBV5Fd/p41KH+fW+OureY0F6CV67Nw2azfLOnKF01vnKjmfIT3nB0PGGXN
7OasEs2FRwUVTxmZj4wEAln5Z1DOSyqbNyIsI7dRnzyNRmQFzf5P5qThpamTO3E7
N92Qs2yNwG0eFrTZn4n47s+RmZQHjul/Jc4+HJ8bLWlEElZ0gFLLYRTjDxCBo9f5
3/12qRT+32F1F1xtZ5DbW0v0VlLf85M1lM8LAaMgoxYNpVjpEH34Yxu8jQ7GxaHM
w1qgntw/k59AOq5Tc+vcf/JYJrsQccyhRw0CuSXfxn+LAYRa1BgN+gw2Z1TFhemi
uFIeMokononXat+GNkej2XYmLze/H1sY54ReU1h9SbFHXEvPuR4=
=Gp2T
-----END PGP SIGNATURE-----

--lqv1BW5vOjVgQZBt--
