Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68408C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 09:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiKHJW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiKHJWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 04:22:22 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C23E099
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 01:22:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5342E5C0072;
        Tue,  8 Nov 2022 04:22:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 08 Nov 2022 04:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667899337; x=1667985737; bh=+jMrEt2ozV
        kybrm/TiXfG+7q5P9uOKmUacqUHk/oL0M=; b=qkK+9sAt3efiqHTQIMB43TA1NR
        1CjwCs5WGyMM6kGOlrgeWn1AR2zMub1eZCHPIn+x7UAJUf4EFhhqg1anOj4LZhU7
        WKsYUloWn64qPTOv87cwgRQDaxfSFbVwqJpT1xNmxB1X2evWJU2/mbZLh7yjR59C
        +gSudHEC+qnZFijxQ3Dth19yZZR6kn9B+evOGRD2jXlrrdl33p2iLloIdTlAwfcL
        cRPWx21WR1PK16r4dYCnu7fNXoVfJvrl7+W+ILvnmIOEQnh8WmMhORX7qkip1wOv
        EcaUtIsceMZezVN1vkJTZtM2UjMBZFw2nuIV6VHi5tr7xFtJ0gXb32O8gOdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667899337; x=1667985737; bh=+jMrEt2ozVkybrm/TiXfG+7q5P9u
        OKmUacqUHk/oL0M=; b=uGpVHkEi5Qjn7t1U+lE/hU+8fTZVxWbgK+g36O4QPvuS
        nzZzOjvA11jb5DbQxobnzR1eRX6+zsPmm4l840xzy+nknM5HXFuxoGkhq0+AR+p2
        /sfGZRAyikqcSdLkQLnVlocRS/rF/OqEFTarQo9BU9EwmW0F3NKPZWEiSiyGqK+f
        1Wwc7RFvJrKQlipRAFE0I1Mhlhb30/JPcQtbRpN6+oDPl6MNxPM3i/aeCHQDAm1v
        JILO3t8KlWXlIbyOgYcoSv3NfXxo484K1m21PQwb/mngMQ2h0cb3fzOk6UnmHaGW
        9IdonbSPPY+RgZXLfEEJXtZ6qOdZ+YxqAQdXSzE9LA==
X-ME-Sender: <xms:yR9qY_KPdpZuAfi_MvAhC5k6CEZnyFV_xrJ39HQhUEK2wlv-eQyZZQ>
    <xme:yR9qYzLS3GxPGTu0JjCd7dgaQIpJSnsu_x8U6Rc27_bw6PEq-eB9RFDDXPNn4liGm
    JpjrR7Bm0Fgu0cnzg>
X-ME-Received: <xmr:yR9qY3vDVtj2zYMlHU_43hBNRN1zMW_vjSnK5XJFtDWH6ER0cxQghuTyBqViHgJLgP3PZOzJDVLo4qxFsWfmQxv5_hPhFc6VZ6lBTZb-Jf_B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekkefgff
    duhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yR9qY4Yp2TTRwTUGMB71h-AugSe95tsw4ZMiOtBew-SRHHJrlvzriw>
    <xmx:yR9qY2bWkFMhxmSt-spJzZ-XSgRJpPoWnx95LqJpHQa0czRreWdlkQ>
    <xmx:yR9qY8CJOVCalviJ1V1VGKuuaFXrm0QsyqXS0xgI370bK8v_lL9CoA>
    <xmx:yR9qY2FnYSKLWzOIWRa4CTQs1tlL4T6ytAbEIvuufiGgsLwoxMYVjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 04:22:16 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 491b6487 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 09:22:08 +0000 (UTC)
Date:   Tue, 8 Nov 2022 10:22:12 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y2ofxE5qY3gnZLpe@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
 <221107.86pmdyx4me.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvdgSM+YcAADpNjr"
Content-Disposition: inline
In-Reply-To: <221107.86pmdyx4me.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pvdgSM+YcAADpNjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 02:34:45PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
> On Mon, Nov 07 2022, Patrick Steinhardt wrote:
[snip]
> > +	if (strcmp(section, "transfer") && strcmp(section, "receive") &&
> > +	    strcmp(section, "uploadpack"))
> > +		die(_("unsupported section for hidden refs: %s"), section);
> > +
> > +	if (exclusions->hidden_refs.nr)
> > +		die(_("--exclude-hidden=3D passed more than once"));
>=20
> We usually just ignore the first of --foo=3Dbar --foo=3Dbaz and take "baz"
> in our CLI use. Is it better to die here than just clear the previous
> one & continue?

It's something I was torn on. I ultimately chose to die though because
of the difference between `--exclude` and `--exclude-hidden`: the former
one will happily add additional patterns, all of which will ultimately
be ignored. So as a user you might rightfully expect that the latter
will work the same: if both `--exclude-hidden=3Duploadpack` and
`--exclude-hidden=3Dreceive` are specified, you might want to have both be
ignored.

To me it wasn't quite clear how to support multiple instances of
`transfer.hideRefs` though as there is also the concept of un-hiding
already-hidden refs. So I wanted to avoid going into this discussion to
make the patch series a little bit smaller.

By dying instead of silently overriding the previous argument we retain
the ability to iterate on this at a later point though to implement
above behaviour, if the usecase ever arises.

Patrick

--pvdgSM+YcAADpNjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqH8MACgkQVbJhu7ck
PpQByQ//Y4SrI3PHp+06oWRRGmlL4QJYZ5gdbqGdL6z9ezteHPrPjFqFliHPcEE7
Dnq9I6iKRLLQnyeHTFWkEsRqX1T3kPdZE7DuClbBfi+JErHepfvVV4cU4qbDu3gv
Z6i8xBQ0csJ3bdqZiSmgoRKVxGpPxKUzEaFuTN/r3d5OqqTIfk31hRadeVg+ZKYG
mma3IK/o7ovUWxhApvlFCHz9uTXX6mQGQue+0RegfoN7CpY4Qwm4zg4+LnXCQle7
YjcKWkCcD+DTK3zwJiEeK3CQnoMVNu3ewEc50UKIxLMIXYJVw8QRuhArwKlNEo34
J6fd/wHkLT9yGfJxWt9Ab9v/BfgwFZTwhwtOqiWTJH66JpExu9zfQrQHgekSfNZs
QWtz+MCUdXGyctasRE+cPX9op7axh++/XAyB8YK0kR7kTwjjrHhCvYxUZf48Cl0c
tb5BHfXvjZL/6h17GxmnDIrfYeW4Hhz+5LQBrDjLrC46WNWwCqpXHLMLfsuaFdsP
LAtxMy5iVpAC1zPKFDE6LBxqizKH+3QmAs+Iwn5bQodpNeeEupvW8GbFiBiOLBpe
kxVkf5nRRCWzSVh83YCnQxqEZic/WvuiierwD1BOvTF9upkbT0S1fq9SW7VTHVSP
yn9+EYSVl1QC9TyXAjeP/xPkTFoRgcn9Qh6PkwBYwYL6EQHxyOk=
=64sH
-----END PGP SIGNATURE-----

--pvdgSM+YcAADpNjr--
