Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B151FC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhL2OCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 09:02:50 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:8648 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233228AbhL2OCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 09:02:49 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c5e0:3de3:cfd4:f8ca])
        (Authenticated sender: jn.avila@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id A72BD7802C5;
        Wed, 29 Dec 2021 15:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1640786568;
        bh=BEbFzmrueg8lWFy72HncKRncOCrNUIMXqx8LNRvzwYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DU478JWjW35y9C9sovhNT37xNaeSB1MuiKmQt8gfz9ig5McfbiN6BtdQC0a2+s4Hd
         QLRyTAwNh/C2fJcYMkOFQ8qWmTNsat6m44cXPVaRZIj3Tfz4SG50oSyTgua6kF3fn9
         vvMQbFLaTdrb1aP3x3qDoA7qXrXHYtHnZR6QaKucvl8yaJuC0PyB7YzckDqOJGnkEr
         +KMBlm1ZMoLrbW/ntE9NBglTenuVlxJDnrBNEulc5kENhJMy9cn3l2DauMjKeFs2A0
         bdQtjtiBY5jTrWkKv2EKyUT7ZIiK44GMO6NAbXpH2kmBf150DEEWm2e58jZcJTbajJ
         /gSNcfABLl2yg==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 06/11] i18n: factorize "--foo requires --bar" and the like
Date:   Wed, 29 Dec 2021 15:02:38 +0100
Message-ID: <1840905.KUPFNGqlj7@cayenne>
In-Reply-To: <2a540fb3-df24-3b95-1088-f2ee228d175c@kdbg.org>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com> <f83ed5cb7995e2ce3c9aac9eb4971f45bcf94e89.1640647438.git.gitgitgadget@gmail.com> <2a540fb3-df24-3b95-1088-f2ee228d175c@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, 28 December 2021 08:01:30 CET Johannes Sixt wrote:
> Am 28.12.21 um 00:23 schrieb Jean-No=EBl Avila via GitGitGadget:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > Signed-off-by: Jean-No=EBl Avila <jn.avila@free.fr>
>=20
> Two questions:
>=20
> - Is "%s requires %s" already used elsewhere or is it a new translatable
> string? The commit message should clarify the choice.

%s requires %s is a new translatable string. Will update.

>=20
> - Do translators know that the two %s will be substituted with options
> (mostly)?

Indeed this is not clear. So we should apply the same transformation as for=
 "cannot be used together"

>=20
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -297,7 +297,7 @@ static int find_common(struct fetch_negotiator *neg=
otiator,
> >  	struct packet_reader reader;
> > =20
> >  	if (args->stateless_rpc && multi_ack =3D=3D 1)
> > -		die(_("--stateless-rpc requires multi_ack_detailed"));
> > +		die(_("%s requires %s"), "--stateless-rpc", "multi_ack_detailed");
>=20
> Here, the second %s is not an option. I hope that does not invalidate
> any translation of the string.

True. So let's use "the option '%s' requires '%s'" instead.

>=20
> -- Hannes
>=20




