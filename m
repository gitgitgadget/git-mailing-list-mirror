Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E15DC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3195E610CC
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhHBJiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:38:24 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34089 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233116AbhHBJiU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 05:38:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 871733200805;
        Mon,  2 Aug 2021 05:38:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 02 Aug 2021 05:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=93N8ysp77PoML+bln2szyPXQ/9Z
        xtRwBT3iPhy082LU=; b=IdM4qSH1rknNJ3T7uCKt7BAxuXsWG/TjanhRpuZGZOt
        vO/J3I9CrD2EmqrizwUfOobxv9cvaho5cHRtcQ90ROVQb6lzJdNpBKOFFXbN6ms+
        U3kHHHGCGxace568Tqo8HQs+0J3iz2S0V3DZjI/ADK7thJZe1/iCKTEwUDUPn8ss
        JWXHawE9zWwtoSz+xKWTzcLsbYLBMvpVp72FXxL8HZTxiF0SScGLl6LrlRWZ/NXZ
        WAeUcWdmP8oItGDaoOEcu6vh5H75Tc5hOCrAXt7ZprgKit8C0z8CB+tfLF18KtEt
        wTs6IDDlKJf5NyPkn216IgyNO3roESLCnfmX3KDHeDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=93N8ys
        p77PoML+bln2szyPXQ/9ZxtRwBT3iPhy082LU=; b=ULn6PN4JfTbjHVuSNXanSN
        wnoFdK6wPch2wkzwCdpXjRjRgCi49ZWhJqvhKOy4mQxp7WAGObF33NHTCrW/KHhu
        Fnc+Ppz6TCs4QnUSvDptgaNqpHm9Mllahs/RSfmbqSJvbWfoG3a+9zHZ2NsT1WIk
        sFGjhzx0btZWPsdUghoVveqwx6OuE3MNsBkg9K1Mi5I3vkjkVwJJlDu33aCQ4ghL
        1cLclR9HoOIwRk1gfr5eCVbc3uUl7Hu3SC3/zeDxsow9xmPbqGg0El1t+XI7j+3Q
        pVrN/jUv6ZaHbMe4vCWi56HMMBv2DlcN662lh6k1xeTtInAwkDMF3kbRC1dELoBA
        ==
X-ME-Sender: <xms:Ar0HYRjGdrXBvJLo0zcdZwzAomh6CWOcUs7YKr3Y5vtSFGim4gLqYA>
    <xme:Ar0HYWAEoq-N_RIZ-uVCG1v5paIdGIBh1lzyfNvhRlzqUsMJ0a4R6emxS1TbM9b9P
    M4c6kOnz-X45WBpZA>
X-ME-Received: <xmr:Ar0HYRF1ypczOzFDD7UZF3EbyTVOEd16CYGXfSLhoTZ478dgviFQ7Ecj4VrX5y453g5vIRapUqQyP0fv3G_nlWIpWD8nzAip76X5PzuaAB8FSMbIdSrrOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddriedvgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Ar0HYWSK8HQed9ZG8KAiUTKkN-ckfnuAr7gEZYa3A98DRuUUggPvQg>
    <xmx:Ar0HYeyING8fCLhc1otRQq94Pir8IYFIwK6xQykAl-5cqJ0ScIc4rA>
    <xmx:Ar0HYc7w2O4X5WbAJ5a5mxUzGok6CR7gMyTnwQVZQIm_sqmRvGWZqA>
    <xmx:Ar0HYVnhAW82uftlM6uP6fYAn7zhQHdPW4wS38cKPgPNp9UlR4YQEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 05:38:08 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 30656bc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 2 Aug 2021 09:38:07 +0000 (UTC)
Date:   Mon, 2 Aug 2021 11:38:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 2/4] revision: stop retrieving reference twice
Message-ID: <db854806498b316b4f59c33d70a1ea9c1401fdb7.1627896460.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAzoqpYH79JdQWvO"
Content-Disposition: inline
In-Reply-To: <cover.1627896460.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uAzoqpYH79JdQWvO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When queueing up references for the revision walk, `handle_one_ref()`
will resolve the reference's object ID and then queue the ID as pending
object via `add_pending_oid()`. But `add_pending_oid()` will again try
to resolve the object ID to an object, effectively duplicating the work
its caller already did before.

Fix the issue by instead calling `add_pending_object()`, which takes the
already-resolved object as input. In a repository with lots of refs,
this translates in a nearly 10% speedup:

    Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --not =
--all --not $newrev
      Time (mean =C2=B1 =CF=83):      5.015 s =C2=B1  0.038 s    [User: 4.6=
98 s, System: 0.316 s]
      Range (min =E2=80=A6 max):    4.970 s =E2=80=A6  5.089 s    10 runs

    Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev
      Time (mean =C2=B1 =CF=83):      4.606 s =C2=B1  0.029 s    [User: 4.2=
60 s, System: 0.345 s]
      Range (min =E2=80=A6 max):    4.565 s =E2=80=A6  4.657 s    10 runs

    Summary
      'HEAD: rev-list --unsorted-input --objects --quiet --not --all --not =
$newrev' ran
        1.09 =C2=B1 0.01 times faster than 'HEAD~: rev-list --unsorted-inpu=
t --objects --quiet --not --all --not $newrev'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7eb09009ba..f06a5d63a3 100644
--- a/revision.c
+++ b/revision.c
@@ -1534,7 +1534,7 @@ static int handle_one_ref(const char *path, const str=
uct object_id *oid,
=20
 	object =3D get_reference(cb->all_revs, path, oid, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
-	add_pending_oid(cb->all_revs, path, oid, cb->all_flags);
+	add_pending_object(cb->all_revs, object, path);
 	return 0;
 }
=20
--=20
2.32.0


--uAzoqpYH79JdQWvO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEHvP0ACgkQVbJhu7ck
PpTQyA/+L/NmgUW4sIEIkodeewJKVaB2GLxAUsFtmiSRqeaiAHMdyog6VJDeYrN2
oSkn79dNU63SWf4n+rsqX/K2K0XSIvPixRIEnAlcS+niG0HLqJLCLIyZCb9rLV8e
FsnAa297JKRtQf+Tf9funQsJRcCsEcLtGFC4xsaj3weP364JAC3ZLWrUHAY1gDNK
jwCXJ3J2TppNedRJWeodgw09d9zO8YENpbzul327EQM/1pbVbgJ48d0+KnRlwxhF
LdLiMPSBUdmtrE43kgh0CJHOHBwlEYQlJvEantk6oTbjn9IPjS56FEpuPvRJvbm0
Gn6VNLsZubNLdqrXcRNjgvv8ZzTW+ZJ+hLvGCgZrMLTCFBJw457M6lSSsuz6sPnk
G5JlzYBeY6e10DGoKVSj7cinOtTVW3x7FuvjfUK+hGgVrBbnbxBDbBCK1RN1RXJ3
8m9PI4c5nqGrwOGN2f9mDUAVFfGClUcu4jVImxwGoMNyf24rPD+zpiYyJc8JUjZJ
gIMxRbYHk2D1isC9QV9dI+0dgG3+IR1Xi/k0dvaZV7il8EeM4rwB/ZiH/qD7DJVh
HMVG/XVUi3tc9Knpt0CvlS5HORAUuGptPdYBFTMqMChg92dQ5iF7TvTqfsq0+AFC
rGtON8Ix2vvgfBH/g/5I0aB8GSC3ccJPsPP/FD8oSN4RULrIRyA=
=3IS5
-----END PGP SIGNATURE-----

--uAzoqpYH79JdQWvO--
