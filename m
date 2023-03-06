Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754A9C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 03:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCFDoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 22:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFDoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 22:44:16 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904DEB75
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 19:44:14 -0800 (PST)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 7EC6B341218
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 03:44:12 +0000 (UTC)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        by grubbs.orbis-terrarum.net (Postfix) with ESMTP id 726E52603E6
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 03:44:11 +0000 (UTC)
Received: (qmail 20754 invoked by uid 10000); 6 Mar 2023 03:44:11 -0000
Date:   Mon, 6 Mar 2023 03:44:11 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Michael Henry <git@drmikehenry.com>
Subject: Re: [RFC/PATCH] bundle: turn on --all-progress-implied by default
Message-ID: <robbat2-20230306T033734-620860556Z@orbis-terrarum.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqpm9pcu6t.fsf@gitster.g>
 <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
 <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
 <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
 <ZAMjkffYmp+DNmr+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ti/BKzaA1nnca168"
Content-Disposition: inline
In-Reply-To: <ZAMjkffYmp+DNmr+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ti/BKzaA1nnca168
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2023 at 05:55:13AM -0500, Jeff King wrote:
=2E..
> I'm marking it as "RFC" because it's undoing some of what Robin (cc'd)
> did in the commit referenced below. But I remain unconvinced that it's a
> useful direction.
> -- >8 --
> Subject: bundle: turn on --all-progress-implied by default
(snip)

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

+1 to at least roll it into a RC.

IIRC this was a mechanical mapping to expose the pack options into the
bundle command; and a cleanup is worthwhile.

(snip)
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index 7d40994991e..978c5b17ba5 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -606,4 +606,10 @@ test_expect_success 'verify catches unreachable, bro=
ken prerequisites' '
>  	)
>  '
> =20
> +test_expect_success 'bundle progress includes write phase' '
> +	GIT_PROGRESS_DELAY=3D0 \
> +		git bundle create --progress out.bundle --all 2>err &&
> +	grep 'Writing' err
> +'
> +
>  test_done

Suggestion: How about adding a test for --quiet that ensures no other
output?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--ti/BKzaA1nnca168
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmQFYYlfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQQjQ//dzbtrqJaRrGR8sQXF+1ToubTQz6jEM4qSX0KdSdys+mTjucppKAlRgiB
UnjVb+3oojeaR5yX3basPGTkBW9B75qd/2/rCAprvdpn85ANYrRwrCSx0540YQhL
v0Egm/BtDJGGfQPfGqJ7IPXtp0BK05gn4hdlRxLmgyvMyfGMsS80HVwjpQbkK3lz
Dbv/aYaR4aAVlAppdPAfZxH4oLmhXlFQfSDpI1BGHOYuBU72y/ds6xY6hnisiVfH
61lCVTv+fJGpTOawKhxp72JeQFOKRHlVFIiIYxh22HVc4JJeOdDFs8x/lqvlibnK
PW+wMBhVlLpM1gfo6RiA2r7IBfja1nM4WaIn3KQ9TDDogoZXdSyfRrRM77dP9lDK
n0Y0RAzIfmWz3zFPE4EJkw1oup1LPEk/W5nBc82LbJYh2BEy5rrojsy+bOYOZKYp
b1T9b79pE841IfUEBnveA/O+Zh1Zj/pHAPPHBQAfJj2frJf73oYjOxYRD0Ayr0Ts
rFhS50hGHnyyo5s774WGxJbITNI9nlWQR/V9IzjrcQ8ACaBGbKLNxpb648bLljD7
OlrTKbei8FHU1+KcWksVLOSb3H4SlmsD3qdX443WSFzGnqMh6ICkCcSLzPupzNhU
40zsB4YYa/cDkyC4w2vsoHCQfUqf8UkyriRO0+3pehmkOBA6Vt8=
=xaSw
-----END PGP SIGNATURE-----

--ti/BKzaA1nnca168--
