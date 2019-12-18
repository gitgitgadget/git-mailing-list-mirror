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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D0FC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812E821582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="kRh3S5tF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLRSMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:12:09 -0500
Received: from mout.web.de ([217.72.192.78]:54375 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfLRSMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576692725;
        bh=CcTv2II1WhMPva4dzfR5YU2YxVToLRFdYX20U6jexRs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=kRh3S5tFzqViCUVKjtqQ4fr55RJ4a4BEI4ptzyb2f4rOoQ+uPb7fQrawtW6oLKkKs
         Xo887aCZam/lUah53Q3xMUmWtFDe9nuS58RriiqC6sTu2xT7c0FACcgo23nYCTdKgi
         d5fGOxbU7vWCVIw00RvCp5JimuF7z8EHDM5MKVA8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.27.9]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9XQB-1iXQOA2s1f-00D3D6; Wed, 18
 Dec 2019 19:12:05 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t5580: don't create unused file
Message-ID: <aee0203f-21c1-b24d-41c7-27484db08327@web.de>
Date:   Wed, 18 Dec 2019 19:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w9tuPzbs/zyFl9ZcATA/Ns8wbmcUCc5Yh1CKSDaltRTWZo9XD0U
 vHCXA5IrWgT7eWffVUU9p1gwMwE1ol7FPr0l/9DA4R7xwbMm0a2BifE7YB8qWalVRv2nqs/
 RVDj1msnrvClWfhHNDerv4yMnQtcfqB9cfUwEt0MKFFVyxn4lLrJ1YgRzsc3PZwKKECRkGJ
 o9J3TL28WSMfzpGCyiWCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FH1YNUSsHqo=:DyZ4pZHirP8thSTKPqAcA/
 fNvjEZPJAV403/xwSrPktlpLNBMP+st1+TvyRuwEEmgF2YoI7F/JcgwXrpg+jHYjKrND/pGiA
 +b5pAS9U+XwCuMLubUYkapUxuvDBO0yL2V9XNTcaQnaO/tzjHriBkBYnOcYS2mcXCxVFpfhWp
 YbARZP7IrruoXKvw03JaOK5e7aVtCasOgMrSmKp7PIFfDvCjhrowrizGvstUtpVjqJNKEwKEc
 zlJ0mmV6eiPW3TDLoQbWD2uLvgWRcUu8TTXCH+sUQzEDsiBDP53yAkehZ9wwmwVj14YhNlBJd
 yP9t7qSTvqvRx3Zsl1zKFVNfbBsxsfmbvMdOxtxsMWTuO6itObRQnSGW6GZA4vx2rkJcU8hyc
 yJ2QOvjHjmMvZnlQoj+RXpN9NzlbMxjIOwOYg0NUVEPpgiYBBsGe/OaUoJ31RlHFKJ+GWsPNC
 3p4NAMpf13017S7FLGA+wnR+Ue8HvlIq8Zv8ALe3+P9aWuqV+703DJRugnSJbDVD/6sfl1U9D
 Umf4qY56SVmwG9BlfI99zp9K896O/lkyVwxt3ZDvydkhE9WFMw8XePh0U5hCk8ZV1FGm224Lg
 DDCXEvIZuYaU1qDgmioBMmeQWLGpqsaGjEg6EUB5SdAT/aPlh1WSfduJdn7qwv2bIfxBedgVG
 L9TkFw1LGTDDPA7g1ULDIVgrfvTxcLjRDhtBFF4C74pqDTJT3+RHAR3JqMtmgGIgCi+C0ZU6N
 N4PO+Mv95hqzIM+Iv5nkIB0s1vb9rOboV71smugkxXkhXSFBfhExXMToETmPJpUkOJTmepjqq
 D+LkvQ5/PI9sMsX0FcHuNJinqsMbKnXeheRkHvobgTjrDtbMMGDPgSgPrvKrtS2FSm3SWIa0h
 45DePoZ0z/HMUP+5I4zTj9osgvAIfgtv9k0KjiizIeiSvsdkrKXrEvSAyPEGsrZZFQ9E5ZVnC
 LaszPqVXegYU6Nvtclik9uFTdK7gbs9DLkJghnN5S9SmaKttyP7LxmKyfGTtzGNMv6njnXO5I
 toh9rvK2CrtQhFt7zEaCYDBXEN9LzMpv+hYY1hpohiL103BwTIZt+44J6VzoIPQyuXpHM74Mb
 a0K7iTygyGZ8OQGb5i+G5lSEPR6YYnkBhdGsUFxgYfQWajOsMfqol6XVK04JXH1cVHGcxp4XZ
 autJEend4t8tcNqP0S/MT6kEbGXCQKixlHWxmgrcLLhO87fSF9GKTQlkDfruglFYcdhifpO1E
 6o4oyJeA7zUiKDjMhW664QoEugalbgNNIwdrSWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file "out" was introduced by 13b57da833 (mingw: verify that paths
are not mistaken for remote nicknames, 2017-05-29), but has not actually
been used then and since.  Get rid of it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t5580-clone-push-unc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index b3c8a92450..01b52c195a 100755
=2D-- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -58,7 +58,7 @@ test_expect_success push '

 test_expect_success MINGW 'remote nick cannot contain backslashes' '
 	BACKSLASHED=3D"$(winpwd | tr / \\\\)" &&
-	git ls-remote "$BACKSLASHED" >out 2>err &&
+	git ls-remote "$BACKSLASHED" 2>err &&
 	test_i18ngrep ! "unable to access" err
 '

=2D-
2.24.1
