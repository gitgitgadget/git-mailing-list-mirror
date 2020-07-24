Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA15C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 14:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B25D22B48
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 14:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="asR3QJv0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tq0Gt53W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGXOUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:20:12 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45395 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgGXOUM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Jul 2020 10:20:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3E5A2B12;
        Fri, 24 Jul 2020 10:20:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 24 Jul 2020 10:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=DnOQObKUqmRlzDEBo1WLT7Tf4W7
        XICtuUMTiY5XPC5A=; b=asR3QJv0xQIfTnPPpVtLQKHqEc/Nw0WI386CVVkM9b8
        nlfL+YAhLh71QDEw8CMT2z2zGiTuqOAeQXGCwH8zFoWjeFSQIO3Vk8EuU7AClN8l
        UoqnBblR4QtvbC88EkCVzqBh+SDvCn7sOUTtI6F5kOjLLX4qUUDHaqN4CW9ugZpM
        4JxTAAEB1L1pF012S9XGoHj7uGdH4pbDeRGZWxvYoUD9n99zf3SwzRlro0EtT0M1
        pbMT2bBHkCGwtEM/GUOUSevhxsLaXw6VMiwq84Og9fPw7l5mj/q7sPsEsZhsovK9
        nKw3iwSfyZodUmY/V8CninkhgKKlqH+zwcq23R8q3Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DnOQOb
        KUqmRlzDEBo1WLT7Tf4W7XICtuUMTiY5XPC5A=; b=Tq0Gt53W89JLDY3FWxSh3z
        AOLQoX5TiKmXDuY9RmQc/To1TU5w/XkiH91ypteOs0MyvGj7yLnPqzeySE5yB070
        pqO3Qf/J8w0zODBv6lORkZAyElMb4VqjbiQkm8W9b447+fF5/7GsrTfvpKuu9xWv
        V8gcewBB7qAd3oQ1WNWhC1DQ5lBBGccep8D/SyQ0napZVcDGAl2TuXVtkJVWvyIc
        uIpLZd4/OHEuEJxBC+OD5HtIwBMtsPRoDF14pQDYQYry+7z0SicWmv3OtUw8XLCG
        pgJEtV6Uwmtabu53OylfhOtrPFO2vAGLhJkUdKpX71QEBy5AV6GnwNV2jGXVLFaw
        ==
X-ME-Sender: <xms:Ge4aX0Q3mMSwDymK4mrF40CJ_iDK-X0ri2VisvHBLMlKFEgs6bBvWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheefgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfdtvdduleegteeghfektdduleeuleeilefftdevleelveeuffeihfehfeekkeeinecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepjeejrdduledurdeghedrudekle
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:Ge4aXxy8HKlTrUJlwViI-A_1K4M8zrr2hYnMkM75w1fw4Qb5GtFMuw>
    <xmx:Ge4aXx2YbXu_1ywnuPizQ83vej_AuqbZc-W6O-gJPJham4Y4W4uyWw>
    <xmx:Ge4aX4A-86kNbtchXAx4WzAm9mfFfLB69egGs6mkXauKxf6ltncEdQ>
    <xmx:Gu4aX9aZA6AxRbZyVMnznzyDi_4_ZWyqphcdEJqdOsMiznAK7Jbxlg>
Received: from vm-mail.pks.im (x4dbf2dbd.dyn.telefonica.de [77.191.45.189])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04B81328005E;
        Fri, 24 Jul 2020 10:20:08 -0400 (EDT)
Received: from localhost (xps [10.192.0.12])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id abcf244e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 24 Jul 2020 14:20:07 +0000 (UTC)
Date:   Fri, 24 Jul 2020 16:21:56 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     starlord via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        starlord <bojun.cbj@gmail.com>,
        Bojun Chen <bojun.cbj@alibaba-inc.com>
Subject: Re: [PATCH] githooks.txt: use correct "reference-transaction" hook
 name
Message-ID: <20200724142156.GB1032@xps.pks.im>
References: <pull.681.git.1595599077623.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <pull.681.git.1595599077623.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bojun,

On Fri, Jul 24, 2020 at 01:57:57PM +0000, starlord via GitGitGadget wrote:
> From: Bojun Chen <bojun.cbj@alibaba-inc.com>
>=20
> The "reference transaction" hook was introduced in commit 6754159767
> (refs: implement reference transaction hook, 2020-06-19). The name of
> the hook is declared as "reference-transaction" in "refs.c" and
> testcases, but the name declared in "githooks.txt" is different.
>=20
> Signed-off-by: Bojun Chen <bojun.cbj@alibaba-inc.com>

Indeed, thanks for catching this!

Reviewed-by: Patrick Steinhardt <ps@pks.im>

Patrick

> ---
>     githooks.txt: use correct "reference-transaction" hook name
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-681%2FB=
erger7%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-681/Berger=
7/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/681
>=20
>  Documentation/githooks.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 642471109f..31b601e4bc 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -404,8 +404,8 @@ Both standard output and standard error output are fo=
rwarded to
>  `git send-pack` on the other end, so you can simply `echo` messages
>  for the user.
> =20
> -ref-transaction
> -~~~~~~~~~~~~~~~
> +reference-transaction
> +~~~~~~~~~~~~~~~~~~~~~
> =20
>  This hook is invoked by any Git command that performs reference
>  updates. It executes whenever a reference transaction is prepared,
>=20
> base-commit: 3d20111cbd42c9ef3116bb629838bcbfea508cda
> --=20
> gitgitgadget

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8a7oMACgkQVbJhu7ck
PpQF5g//Tn5k33U797quFVB1yJoHtfiJtJbdPR2YYALcxtFQElM4YrdFCabKzPZ6
8r1yTO4KBMwR1hgT1ErYnbAc84vNgdu4h/cyNXUsyEC0VZo+iW4ZnsUJle2fnh0y
FevW7j9zGfw/MIIE5I/NBdJIL5nrEpdHuC5hvIfyInSkU67ltEy/M2JH/VJnXoSX
e9r4DQbFUQZNLAhzSyth5ApYo8LeY1yIjAhSwORHCAMtCANitmhSLIqIONCfsOmk
CHha7wqEPe7Dsmb0CetS3NqgBG3VemXukqroAaQIkt/u4/jmeKr7lrVBos6A1b/u
4OfFJsmj8XKxwNcmOB+DIciU+d3eiF+lvYC6m3hYfwO9QagDmv7BAA7PajubinoM
ZnSrjLk8MlcAgSnluhIwDwOtOuwzbTNTGLO7HWipHXFKVLymyhur3+MnKwsl6SxT
p8813FGbAOE2oDh+Z1Grs8w5UGn4vAgN6oIHeNUALKhN8m6KKs9TPa1WDkuI6LC+
lj8czEUnuAEzh/TiM2jmsPAgUws4QFH352neUcZIlKwtw9dOJYLzurV8Y1wUGnBn
YgA571jMIINZx1Tr2os6S6dRaKJnrRvaqaCOK8Olfg6ag1ak2LzDiWqqVvUu7XTo
tLpQ2EMHLqPlLCfYYeyWiwYpk2/6HN757XU4Lki8MCkIqZrQkco=
=JdZ0
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
