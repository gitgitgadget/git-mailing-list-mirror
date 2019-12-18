Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A2C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DAB24650
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="H/Y48Ncg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfLRSMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:12:17 -0500
Received: from mout.web.de ([212.227.17.12]:45805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfLRSMR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576692733;
        bh=kgWdMA2if0GXDR2mW1V0rMPtilZ52EbAFoRHB2Dshq8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=H/Y48Ncg20Rg/j656zbezsYrolSoacEwd2u70lCQlkB+MlDfvck7xy6/JVs3z06Rt
         km9vnMdcmcOPGaViS3r39pfLGYSfBMnapzaBi1ombDPJcj5Zz3/iBuI+JAcFznoH6Z
         H5kBygUFJcKUL+7ONl7yLsdazHPuKTxDKYuJcgvM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.27.9]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLj0-1iB6H51N0g-00Yimp; Wed, 18
 Dec 2019 19:12:13 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t6030: don't create unused file
Message-ID: <9b98d8c1-7847-5b6b-eb74-e3f3c0e809fc@web.de>
Date:   Wed, 18 Dec 2019 19:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ExtwVB3BooeFHqQzk+iMK79uiN3Xsw1BVYO4oQbW29yVfBCxSC6
 E4MATmS98ntdPbmXVdnendGGk9riuCX4z694Id56j0xtRQe07bmiiTaKY8fvoofr+V096Hm
 CgVIZBfINeiQfMDFQdfHhUGlbrGLQvUfWQ+6CiDIDC2ysBdY/NPEnvXyKjO36YZfSuLtxAh
 9TjqwkSAJkZAseht4tNig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CxexHNLD17U=:Iecee2JAPd08cWA+FnJb87
 NBKsyGwGQq2Nas19UHDXnyuVGupkP3/DgoaqrHxasCbjJy1rDPWPzbtbVQZRX7SbaEVdmNcr6
 Sn8q2CxPssigp2xzb84Yixuj7+o07iipa29onSrGR6hMWrMB1Q02JU4VbNw9Xxa4veUO1CDYY
 2kj1ovu/rkR39/pFBnTiK4gj2LYq9OYCvfiCgul9XFxxMy8ml9Exb/kcCYPCDMqp/aUVOs/fz
 NNUpMQdHB1lqxAo7kyL/STmIapRqb5DNrZ8AfYy5S1+6vocWjurUG0U4B7fM2n+qQVlGHAVnL
 p4flo86JoienycP+aCw7vgkrPd0tckq16GFKQY52oICFl/FuOdrTkbBxkfX6ovUihJY7bmhny
 962UhBEMTa+FL9ng40fAfcEJBAfeWDHbr/iMN8h8sQBoA9VPOsg5Vk9gdYHcsgnjMOHrhTKTu
 l4yktcOUMBBffO5RT1cO4Lq1xETB+GiDC98Luxr/SdAsKx7/qv4zLIIpH4L10DtCmp95TZXrI
 LMnfJuALjMUTOAGdNT4q1DdECWnzbKHMkfwi1Q2KZnRnS8yvf7sldcSN/MRpMLgJ2lKovr0+3
 frOTxgwDGGzpkEfvODCb1ByCoKoY/GAft0ftK1sgWrVbXC1BuYis24RPyDC6QHsM7ZXNvT/gW
 x6GJ/T58VBU/VlT/HOBl7CGlmNf160SgzD2AfBf3emjjD3NEZPTvkjWYMPx8/39NUDLKi/Ys4
 IaccLVs+PwVsSNrwZV2HzLLtkZp8rp6EsAy3PNMoOvPjjd63YvLi7ollvZDv4okNAtFGh7jYJ
 PUCB/MeyFrlMSWsUNkec6g80Ew4ZtAH9/153sFE/7phmgb/q7bGO3bhJeGVdqpZP5WtA5H1Ro
 1RVNfSF5gJKOVejoG/OnUqHE6cXYADMv657ZlS8OdQ2IRcJmuQ+JiQrCe8UueakpctHyZnvAy
 LPW5WzHC0iagT2DWzmQUw8mRrtU31STZUXzgL2CpkNLaZpBmdwMQwIjgad5ZFZyw4B+lzx2Ia
 5G1oYo/64yRT5uteG2KNLdMJ6YGlsUPoQ/vKaVltNbLeSAs7vWLqbFrGN1tQL0XikrD71AoL7
 BzbSlPXIhPLX/pnNCleqJyAUCCZqAJPm/ZDzbuVswTLicUr85posQVz7WsWvKqUaIhASZP7AO
 UErNA8Z/mVuw06GqVs3BZIVyZrlrK3x5qTYm6CEUVztg7ghdXthHrxjSeRnV7JlMRrz3jaRX5
 0esSLIZfPyoyyLrelYLBe4m8/GwTgpjkI0n7FxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

my_bisect_log3.txt was added by c9c4e2d5a2 (bisect: only check merge
bases when needed, 2008-08-22), but hasn't been used then and since.
Get rid of it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t6030-bisect-porcelain.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index bdc42e9440..821a0c88cf 100755
=2D-- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -482,7 +482,7 @@ test_expect_success 'optimized merge base checks' '
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" =3D $(git rev-parse --verify HEAD) &&
-	git bisect bad > my_bisect_log3.txt &&
+	git bisect bad &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log4.txt &&
 	test_must_fail test -f ".git/BISECT_ANCESTORS_OK"
=2D-
2.24.1
