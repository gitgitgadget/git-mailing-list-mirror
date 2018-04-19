Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7FC21F404
	for <e@80x24.org>; Thu, 19 Apr 2018 21:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbeDSVoe (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 17:44:34 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:49206 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbeDSVod (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 17:44:33 -0400
Received: from leda (p200300CF2F166A00625718FFFE7F1598.dip0.t-ipconnect.de [IPv6:2003:cf:2f16:6a00:6257:18ff:fe7f:1598])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 6A06226768;
        Thu, 19 Apr 2018 23:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 6A06226768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1524174271; bh=Xf6A8nehLCW7uTdcD4M7/rR47j9UmMcYgQ7p4KpcLE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=UxWYaKMIYJAT3vDpInUut4FGito0xozNWV8nIx8L0M5nz5DkXwZZJW1wyzkN0XvMM
         xqn/duio3Qzypja0v+i6RKEj6rEFuSASVjTlVC1o6R4H2NjaDnjJMMLjyS8i8dACHA
         573tqU/VzsHpQzOpSTmepeO9Ta9dOPuAlvrk371c=
Date:   Thu, 19 Apr 2018 23:44:20 +0200
From:   Christian Hesse <mail@eworm.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?UTF-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Dan Jacques <dnj@chromium.org>
Subject: Re: [PATCH v3 1/1] perl: fix installing modules from contrib
Message-ID: <20180419234420.0dd66dce@leda>
In-Reply-To: <xmqq36zsgpfb.fsf@gitster-ct.c.googlers.com>
References: <xmqqpo3620tz.fsf@gitster-ct.c.googlers.com>
        <20180411065120.9432-1-mail@eworm.de>
        <xmqq36zsgpfb.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YJ.GFRoK1b910YIPajy4I9A"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/YJ.GFRoK1b910YIPajy4I9A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Thu, 2018/04/19 06:44:
> Christian Hesse <mail@eworm.de> writes:
>=20
> > Commit 20d2a30f (Makefile: replace perl/Makefile.PL with simple make
> > rules) removed a target that allowed Makefiles from contrib/ to get the
> > correct install path. This introduces a new target for main Makefile and
> > fixes installation for Mediawiki module.
> >
> > v2: Pass prefix as that can have influence as well, add single quotes
> >     for _SQ variant.
> > v3: Rename target, add to .PHONY.
> >
> > Signed-off-by: Christian Hesse <mail@eworm.de>
> > --- =20
>=20
> Thanks for rerolling.  I should have made it a bit more clear that
> the say-* thing was merely a personal preference "I would be writing
> it that way if I were doing it", not a "You should write it this way
> when working on this project".=20

Well,  it's you who maintains the code. So I am fine with whatever you
prefer. ;)

> I think .PHONY is still a good idea
> to have, even for only its documentation value (it is unlikely that
> anybody would create a file "perllibdir").
>=20
> Let me queue this on top of the v2 queued in 'next' as an
> incremental update.

Thanks a lot!
--=20
Best regards,
Chris

--Sig_/YJ.GFRoK1b910YIPajy4I9A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvYTecfST32gUsBZyVO3JFgm8kYMFAlrZDbQACgkQVO3JFgm8
kYPNAhAAkKCNhzohf3KIBa6S/xrEuOLBQ2yp33wjFR4jwlyp69esLF1dzTfQE10S
wwgxNYe+PD/qIANBjTAlSqbr9fFT0cucujtWzGSZDWirus0YBQ7phL5ZmQKNUXjz
HlFeHR9RMdaKYyX4nOIfT/bfLG0YGCTCGHG+fwP7NZrTNpodiWVjASauJbEQ6TZ+
5xqwIm7jZGWb7LeilHMWVSoqGg3Es52LgYYuz1lTg3+WKk6c4/zU9hMNBAfUKsW2
Eytos8jTn0lzaVKDe5y9kkUK16/CZR3uKZxEJ0JLnSGD+UWMCHSHW+Or3wh+X+sh
AxDTZeWp96PeIZeNh79/iTJhVWlvLMl1wu/UFGtYeBe4vDi/PT/yn/yeJTUeoITI
KW6pr1OPgDO6iNudRaMD0RasRoPFhKP1stLpDHfkKogH6tKVzVX/tAcuYzaJpUr7
BWuIxKnfU6ABtXHtupuZlkr5tX8A9LFS8vr5MMQFna6pPcfINTJwExJIPa0EllNX
RjsaRgXBhZuiSbx4BmPwUXTL2Kd3qIoN/LIf1Eve2F2ZhTHyQ6SVTJMWYsj3GXHJ
jGzLNWj0BqAAeHu1lM8tTgwaK1cNzRfXd+Tcj2QD7V/lzY1T9ZbHq54NzEAnZiku
6tZtrkiyAUwvi1+xEkjJOscBE8LrXRowCNbFw6P019Kyv7QXVVs=
=IM1U
-----END PGP SIGNATURE-----

--Sig_/YJ.GFRoK1b910YIPajy4I9A--
