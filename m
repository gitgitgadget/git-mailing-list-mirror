Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C2C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 21:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiLAVsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiLAVse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 16:48:34 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB60A322F
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 13:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669931304; bh=HaWgAv2na7NNYbSyAt5J84R6Xb7AL1UKatVA8J2Wzto=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=D+MJPzA7NvuFVVP9d4pbtOMTvIflcOQMJD2e8HYgEwa89OVNIxB6Yo7xJXfRvgqLo
         LLH77pUbo0hqftCcCd5HCAJ0J0gihIDsOKJLpXSgYpmRh0YyjcQPLMPbzw3mWki5UI
         ukdIj7rsuaFJefVLoEOjXn+GKB9WkUFdc/Ym9AbCY+Ss1Hn83mjboqDN4Vq3Qtg7tX
         EBGA6+PCh63g3JoruuG3ZOoMuDeUMTWlKMGyW00pBAGM0Eg91IRFTRDV+A8GH3ZgDd
         LSl0JwAb9dYgAJhxWEc+um6sxcNZya94Jr9YNd8mCCacX7Ulu49CvGIPWLr8tIEN+I
         om1/avLr1jNUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1onLoE2obm-00zQ6b; Thu, 01
 Dec 2022 22:48:24 +0100
Message-ID: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>
Date:   Thu, 1 Dec 2022 22:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t4205: don't exit test script on failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:znt/i5Qy1gBMSeL6vWXx4UguUULmsAOGFMd51vGl/+tWwrn7etx
 HtEE3Tvb+O14bdh5WXISUnpQmXQhBTnPVC9IvPpmtsMqPKxHxSt6CdS+keq2YW99nmCSASj
 W5YrXFGT+UE8DCHdzpdglfU7CJAm343YEAffKzR0FFniVX6Q4+UOgPur+mtEyzQASSN3XLf
 Q9ByXlACNICfnKu8IlSng==
UI-OutboundReport: notjunk:1;M01:P0:uQ01j4ZZSLk=;BTUW4Sc/Kx2GCqxNL/ah2THD9E4
 TMtWyiwADU4Ym0gMLxiRZjSfDn4UtsxSXr3JLNdBNIWi9/kBEMDTyeHe77sSE2EboU/byONoM
 cIf3FKcQDwtpL3TD9oTl/ZOiCFHaEUVZA7fzff7c6srsK6RbdaqFWEoHTwh9QjQMGaeXbd2ry
 oNTGaWluKiLN7WFKeOiN8g6U4YTZXNHrGe4bdPaIGg4Dp4xde7T38YtwCoY1ks2IdGbBw90eE
 Rgv6zogmbBaLfPVJfx9Q2BoV7FqG530yCie5XWtRHYCo5MAzTcz4EKexTpH+obNweuC7wvZiC
 9TjStgTiIavlE9KYzUg2bmCd+xm1Dt4fs+rgzsXU3z9tcX7cSNcWWv+dnBw4hnqF32BBOXDbF
 DGt5lb3+n8znQFuxQ9ZaaqJjsmJR2VQTso8SqhG3hcZ6GSNn+QcTccJPZjhEN09erEJzzUAEX
 oQ+Bb+95erxZf8/DbcZeJnw0rOSWUCXuSCy+sef2U5R1UBJ/n8lbAkVv6mhs5Psdx/UMo/L3p
 EMuRvUY2ULIbDB6j7brW7DMplmIPs1YuT/kej3kS71gwtSYkGlA1FByRH0fNESf91aXnkq92V
 DythIpMMuqrFtWjjIeyUvBya1plpKYcDsdsCErUZM437sXG42xD8sB29N7SKfpS2u/a2GG0T5
 TpOxuM1PCAbi2gxb/QyjUjEynhkpf8Axxz8GuJs7s/RdjDhQsWNdtSGX9OA2Xe2R9YyCDAGdd
 uHCo3yXHLYYO2y0WTSKz44ks+qPl27Hb7XBELJeFVfM/jUGvUb0mRn6BNsrzcQm13MByYe6ZL
 4giNZz6VMesPXbxlbCgB7ABow1biVo8Wp5lmMxqZFK3aPrG09W+nIUgCODdeZ966w6x66oixb
 yxaw5jIfcTt8XilOmyP2KbkogC38JFxpDP82bnZRQNVLHIQuZxwa+da78vwEPzKiMn5Nr9t2c
 MroMvUN4pUcPXpr4nPtGngSOKJ0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only abort the individual check instead of exiting the whole test script
if git show fails.  Noticed with GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with --function-context for easier review.
ac52d9410e (t4205: cover `git log --reflog -z` blindspot,
2019-11-19) added the exit call.

 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e448ef2928..0404491d6e 100755
=2D-- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -154,12 +154,12 @@ done
 test_expect_success 'NUL termination with --reflog --pretty=3Doneline' '
 	revs=3D"$(git rev-list --reflog)" &&
 	for r in $revs
 	do
 		git show -s --pretty=3Doneline "$r" >raw &&
-		cat raw | lf_to_nul || exit 1
+		cat raw | lf_to_nul || return 1
 	done >expect &&
 	# the trailing NUL is already produced so we do not need to
 	# output another one
 	git log -z --pretty=3Doneline --reflog >actual &&
 	test_cmp expect actual
 '
=2D-
2.30.2
