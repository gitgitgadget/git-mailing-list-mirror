Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548DDC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 09:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiKHJtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiKHJtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 04:49:05 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02140446
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 01:48:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3590D5C01B4;
        Tue,  8 Nov 2022 04:48:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Nov 2022 04:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667900938; x=1667987338; bh=E7B5y9pqg7
        Q4PiP8oqx2zxK4du48HZFtt4diuk5eYB0=; b=CPtsWyBnb44/DTg4IaumUUJ3T2
        +MzNzzhfoJkx+2s3f9NjfWvtKIJq/YVVtJ+qv0wxkrnkVzWjbuc2rAdhI/i0ezu6
        QmUXckRSzHNKqUbzUDl61rUJ4rTEGHd34JBTMxYJ9KHvrmr866AaZMMk05gACxRS
        FBZ0H/PVzLIjjZJLdoPkBdQNCAk8W7/SO9F1gZLr48YHC0+1AD8V9T/t4dMX2grE
        ZqVVOVRbjV+lZqpixV7F+3Zm9ZN6mGye7/GGr6Cj6Pd5cDUC+xu2zaIxYFFPdjcS
        jNIWUdxE9a09xymtjP3eDLlxOfqUfypFDlRfSB9tze/JJjeumP43DscWWePA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667900938; x=1667987338; bh=E7B5y9pqg7Q4PiP8oqx2zxK4du48
        HZFtt4diuk5eYB0=; b=qTCIg3q6Gsa1NwhhTPlAJBJEATtFm3sSteTWq5xQCk2g
        9IUL76zw4syXjsVhSR883d2ZvU3SlFjgpM8FrpJxt3wcv6Q5lVR9nm5WGjF2xmNq
        mt5tF9fB9zNY8wElMhT/tQugqWDFXXVbra4FNgADRxrM66IOl6R24kG3lDKSDjul
        vWVP8bE0AM5S7BWjGqXoMI7UbxtpspsGF5Nn8z1mnssB/5JOr7xv3ngviLQSeg6K
        vS7Nk++E6l+AbCRmt3ChH/dyrMMkgKHhCpWHcnE9NpE2Xcr+T5NmSmqneCH6Qivg
        wPGnNiBYKJ/r0RDfUFF3IevQ4MQkXtF13g8rI8qzKw==
X-ME-Sender: <xms:CiZqYw-30cOLN2ZHvmN-q2BikUJzOn8IuFcJWbKRyAFKujQKRF36sA>
    <xme:CiZqY4uHjNbyTxfMsMemTE7nzjOHHQDw72RaIpvgAawnivSPLZthAvM_DFk8DXOXg
    KfAYk5TvaB_HdqK7g>
X-ME-Received: <xmr:CiZqY2DwIBHEkB8VpfafGskGE95jARmK6qkf0QDY00ab4DXNSQDT-tyeEEWjMNQ-irg65H_2_mXWMnAwF9l6gCWZHEP2HBDCRMqVnS4-hg7X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekkefgff
    duhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CiZqYwcFYADbgh_wSnheOoxKEBRCQKIZOuHRwnED-rTfxp_MdEFzyw>
    <xmx:CiZqY1MyHl6ZJnCHsngJNtKMAjbpPYzcacJxw76aiDd-0YmIMOjlCA>
    <xmx:CiZqY6mbfBMeLOeiTNGPj-iCEP9_rjESTYM8lMNDd4195mGDyxNiQA>
    <xmx:CiZqY2pt00OCdqMgYZSdqe2-c5cuq1t7L2atKa31g3GGmmOkiUswvA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 04:48:57 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1555d240 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 09:48:50 +0000 (UTC)
Date:   Tue, 8 Nov 2022 10:48:53 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y2omBeBQl14IxqOA@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
 <221107.86pmdyx4me.gmgdl@evledraar.gmail.com>
 <221107.86eduevgk3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oZhatCdPLvYO3m4R"
Content-Disposition: inline
In-Reply-To: <221107.86eduevgk3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oZhatCdPLvYO3m4R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 06:07:01PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Mon, Nov 07 2022, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
> > On Mon, Nov 07 2022, Patrick Steinhardt wrote:
>=20
> >> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> >
> > Thanks for adding this! :)
>=20
> Hrm, I spoke too soon :) This series adds new leaks, so it'll fail with
> the linux-leaks job. I have the following local monkeypatch on top,
> which obviously doesn't address the root cause. The t6018 leak is new
> due to the new tests you added.

Right, I didn't know it was as easy to run tests with leak checking as
just executing `make test SANITIZE=3Dleak`. Anyway, I did that now and the
issue is in fact in how the hidden refs are parsed because we already
`xstrdup()` the config value as we need to modify it anyway.

The following patch fixes the issue:

diff --git a/refs.c b/refs.c
index f1711e2e9f..2c7e88b190 100644
--- a/refs.c
+++ b/refs.c
@@ -1430,7 +1430,7 @@ int parse_hide_refs_config(const char *var, const cha=
r *value, const char *secti
 		len =3D strlen(ref);
 		while (len && ref[len - 1] =3D=3D '/')
 			ref[--len] =3D '\0';
-		string_list_append(hide_refs, ref);
+		string_list_append_nodup(hide_refs, ref);
 	}
 	return 0;
 }

Patrick

--oZhatCdPLvYO3m4R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqJgQACgkQVbJhu7ck
PpS3nQ/+MfQ+ludFoMNuVQ8iPlKVyH2LoHhxv1JVUB9hQeeSoWalkNWi7Po/mJg4
vCDs9IydTEfDhCDbEPGO27DVff8xXR1vIoESLNBl+XrfLKbJCHNkG6uK3oAjFpwH
yeQ23dOmCVC70CtTSxUI7ap7N5RRPIyEf6okVPNJKlQn/SqW7rlmbDYrBSEVi1HG
EvmhiXN7mzBcnVJuRYheIw0oAIViHsIzDZjgpaoRzW552zHzrs2YHtu3jW6jpcX7
VvwR3Ne23KAw9x8U1ZxKtOoY9TfiDhMQdOJm+SKqm7htOd6ITGd0bs0zdJ3LHcso
ti2il+XOF8nYsmIp///CBaZYtr2x1whKBHJI9LnpWj1Nzryn4VVq4ZM4TyMjBcIz
W+4Yx7ISUrG/p4yKBojgQ4084R7HoDp/fjdZU3FtZRrhjmhRudVIB9PzRLnNDLy5
sS3eDkif9f2j9n9XZj6esh9PUFJfVIqZNqeGFvV5989P2nAhT98nknjw21isAHXB
bOzNLkrX7r+esnIf/oCKbxA3zIzjdEM5x552PrJxThJglWABR5NQRq3iam1DGMc6
W6M+n628UjTA3TdNv7YZAi3T2OKCrMRL2I1n6KGNddaVEP+oREi3t+ZkCWOE+nk4
gfbHvzz8OB7Soq/vp/EwI/BKsZ2gxSmwzXDVQlibq3wXAGH6sdc=
=H372
-----END PGP SIGNATURE-----

--oZhatCdPLvYO3m4R--
