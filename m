Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2EECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 12:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiIFMcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiIFMcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 08:32:06 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3451FB
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662467493;
        bh=BQRAUcy25RphMFO07Vg4abgTq5JiRW/WzWKtmOuffvs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cQJWhSVRJdgS1eTjybUdq9bk/pChe2AAbNxGQRFjYBobKXJZKwS4t3gi7u3xKNdlD
         +9ywwCi8CTF4CnAJODAHcLgSIikoRfAlJssVnF+qaFAGLGEUV/5R7xZy4UAx7F2AVn
         ej08hjY7upGmQ+LSsvbXtyzLK0Y849S2TKkfdN7Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.144.123]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3Yg-1pMXtk3WDo-00qucy; Tue, 06
 Sep 2022 14:31:32 +0200
Message-ID: <df5f8305-79d5-2c12-bdf0-961428c0bdd1@web.de>
Date:   Tue, 6 Sep 2022 14:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: [PATCH 2/2] diff-no-index: release prefixed filenames
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> <xmqq8rmx1saz.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8rmx1saz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzDmdmkeTB4fsQHZJG5r+TN09IEOhsKSajp43e4IUS0U3uMgv/2
 HQwyEom1uGnSAu6ir3skaWuN41pRFPYKugR7vJJx/mG4ZDXRgt/7DozVP3IiaCjK6HdVGpq
 CeoFhSIEpSmrewGgljcch4RWDel80+/bdeSGjoD4YMj3pGaWgFySV0JdbuZ/mgT1k35tdlx
 PHJLelkRc2AfKA6sTzaVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yI9jWqpmB88=:hjmhfJEDzMSf0n1X3ZJ15I
 1ecDTVrBmwErTxEcYDYezPHVUJ5Q/5Cdkxgt4Slf/bI6I1BFcZFV1wSUAbMCBNm5yzP1BPm1P
 PXTFOSPikNOLiAVav9k6gTeN7+MJNPeSN11Xleq4s+k5K6WYE6qbMz+XKMdXi3tP5rSpdPsFq
 P9CIvbr2otx7Lb2AgbxDChrHccKMk8vFr2DSy+bYoGgLByr2MA9ix0StW1vVHpYlDgJFr7v8r
 zpNrRB2qRNy3gwhjbEvRyFMfcrBesZrV41LZ0uHjndDsP8PFZP0up72pSeHRJiz+dCZGAw+Yd
 OYx1wV2qRjZMwdlvXka8ZS+jqyVQjLCrJwGL50yzCEJtsuVW3fpzosQ5CbcdE+U7AwRAy/YYG
 UwzcQtX1SN4AVIx+TODpIC+bcFU3DfcI/uVD6VD1RR2jn3z5uf9ANr1K7oOXkoKzVrI9e6PBu
 v3HPEJzmIyrkYpUv1qbkMz0hT708H/zA6cdb0OVHQ+hDWiHkzH7oE5sWB8g9rWOh9TFf3O1Zf
 tYi+yvkuc3Q8bvVGDtEecNoeHN9QJ3ikVXYn2+B/i5zFfhjUmOWsRXCK/x6znHw+KtvZwyyNp
 8u/s8t+V+rjIyEhILNEJVqzAUoRTER5EsKgQoKqMJl9sTxlz2yW2F4X7EYClBZQo0Vdj0+Mft
 VXvEtcjqHiFqBR3Ij5sBeCpDhNQKVr/+jXCM7cPPdkj9WoKc0GZXmzvykOQ4llRLFZIAdVBuA
 /eDt/UGxwE/kK82CtA9bjUdHDKZ57EaYFKi5IhhD30FvcMbGhNsqzgZxMbq1ezWmbT7a/YSnK
 OBGCkILfG2NW1X0tpKrL0pmuWhcGZZcvgaHkMpC4AgpWw32dJ/1tGFmxLA/p4sapwlmF7/ynb
 JwIT9gfhQLXYsjxtE3/cSh75gp87P9Vs4u+jikAvtHIEo6hlY+M4t1FOCha1lXAfeFYHvEx6w
 jQWceaDVmo0YrqbnYFXOy40KmBUYh1VpGzMl/XZnz53PbH60+LcR229jgWpK/JtvrDER+SB9V
 QdhUpfrZ1Uye0gH1aAvIrjogBMsofObIebhIfQQOtrdRSKZey2Glzf6oOEF5jp6QtKOFgib9Y
 rJiDalWZ43UCMYGuo411FCBFtsmlzhqtV4hfmQQocqfcGh9f5Y2RlKQHrU1hCINNYl6OZBXo1
 si220=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers of prefix_filename() are responsible for freeing its result.
Remember them and release them to appease leak checkers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff-no-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index a3683d8a04..35809f26d7 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -245,6 +245,7 @@ int diff_no_index(struct rev_info *revs,
 	int i, no_index;
 	int ret =3D 1;
 	const char *paths[2];
+	char *to_free[2] =3D { 0 };
 	struct strbuf replacement =3D STRBUF_INIT;
 	const char *prefix =3D revs->prefix;
 	struct option no_index_options[] =3D {
@@ -274,7 +275,7 @@ int diff_no_index(struct rev_info *revs,
 			 */
 			p =3D file_from_standard_input;
 		else if (prefix)
-			p =3D prefix_filename(prefix, p);
+			p =3D to_free[i] =3D prefix_filename(prefix, p);
 		paths[i] =3D p;
 	}

@@ -308,6 +309,8 @@ int diff_no_index(struct rev_info *revs,
 	ret =3D diff_result_code(&revs->diffopt, 0);

 out:
+	for (i =3D 0; i < 2; i++)
+		free(to_free[i]);
 	strbuf_release(&replacement);
 	return ret;
 }
=2D-
2.37.2
