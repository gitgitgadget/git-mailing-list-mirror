Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446FC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC72075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 19:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="miEyBQap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfKZTmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:42:05 -0500
Received: from mout.web.de ([212.227.15.4]:41507 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfKZTmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 14:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574797319;
        bh=CvE/Iw9Zlcq82NeWptTiOwEGT0OBNjXihFb3AmCbZ38=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=miEyBQapgW56BceI68cKBhDhfyF1QlOpsz80SL0G9ymuzzS+xr2BSjW5+x8cnN4al
         G6Zl4C5j0oBv8+W+9zeM58bmTRSbDg3U0NcOc9XcdBPvEbu2A0To3PVkizJ9yfp0Rk
         N8QZtQPGdZQ7ujCrrkH8vf1ZqrsynQpNYtxHkuNQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGAB5-1idK1x3UJz-00FA7Z; Tue, 26
 Nov 2019 20:41:58 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t1400: use test_must_be_empty
Message-ID: <ad30f426-4b9e-431c-b1f6-63ca2bb0fa3d@web.de>
Date:   Tue, 26 Nov 2019 20:41:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rdwsLvm7E8NF5hHpiAPXLA/mDVrOG+TfUN/XCSLyJS3e6QWDn+P
 ITR8SfoW4Yzzuw5+U1nCRuofjdDo0bGvM9Z5FltiNx0EN6eBuC5JK66mez2VZusAF/S0iBp
 Q4RxeVxJd4l2ei01ARoqxYBYIk9qNfTFKnsZsDp9KwWMKlTUl+CGbsyLatz/2d23As5Mzwi
 LMVYHBBbpCVkewG3eWjhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xwWjBAEKIeY=:2R3Y13FW5/BWIdlBEhH43w
 fDvWn3Cp+oqSmoeeFC5kzRWGlT/hsFBgO4clkPQKleUtDtrtjK3C2CPhpvuoldHkRKLyDvoqm
 4YmS1DUP9wu4oamrSDcXVhORxDVW4SaKNTCPC2pN/x37fDU/5YDJBA1vM9b0ap9tWZW+OUQkL
 BJObeMko304QmmHncl6j7XTBcjujb/DvQqyXP1lS0UgL2uzaJLjHW2gx210bHckijBZvZksLR
 VubfJDORUrXgN7eDDupLSwrmjQkod20PFBgNPUUdnqYC3WWI0gPmTIAKB/z1EoXKFmsA+r9B0
 v6J2Hb5ywJuGBxcHn74eU4PnlBa8zkYd6MriNuEQ5+ehF6HUJebkuY0vaVa7kFfsSSA7VUhsA
 9H1fYRl6YPNY0NGG144IvpqFJGAOnBzDH+JwVuO8RM0gaQTQ1ggaWFLKSSZ2Lbk/Jqm70we7S
 EYh7EPqwzoYaIEPhUUne1aBkqjm+wDHTdD52sEVdkCznpgZ2/V9cCJaqkEe2pVEc46ZL3FKwL
 qJYU4ZBDsM9VDfIrFfuUr2Gipi4bZKwf8VBhqhTYfYdWkltIqp5CYATKjRgtoaicvy9DdHE/P
 i1qxeWIBrQX5oNbl/1PZIOIiGl7tRAC10F2B9YkZCly2Z7Apmvit70lqogzngUXVNnaiclxUg
 ar3FE+E7HfuKlUwilNikJN4+fCMzVVCk8iWsu0bC+kEJ9ZBBsjbw1YucElkmH3sfOQSxcwR7C
 0gKMwf80HXRYXrKolhiqiQRJJPtM3dGo6HhqarIvfIY1BkVF3xvXIJVlPEJbmU5ElAqaszVjp
 3BvweZuKExZj/U2mxAo8dh8RJlq0f/4n5LJAN5Uyodz4o+MP21uZ2WQcfdOQWDKcALdH6qHvL
 cNjWZcoFacYf8CoBf6H9PFFZLDnPZCJ7t98t49CNZEvwfmHpdoN1sZ/f5jN4OxID1vIW/YBaI
 07ZXnN62axpe1LCFEE8Ezbyv59ogBTpO+q3GVrsucVnsW/EghmLBAP+s/LrRhUUuNbsVFTd3j
 sY5j7drdSWfY1clm++lV8K2vFwYLmygx590FJBl0eNduRXWJ0Dnvgfkc0M/QXI9sBAu+alWk7
 b0mUFnLwn9ooUY/vJ61BxHE51UU4X7Xd16EpLXgIHdyz4TdxpQ6KWMEJUwYnSMujtuUpJTTgG
 33XCiZcBcmHE9jmYn4SGBRgLtqUJsBrwrjVoVCBeiFE/ylgqnjSwKodtESSopWpg4hTM2TwxY
 FKmHCGOKyDVlwthxNEh6Q4paVLpuC0g44tx0AMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_must_be_empty instead of reading the file and comparing its
contents to an empty string.  That's more efficient, as the function
only needs built-in meta-data only check in the usual case, and provides
nicer debug output otherwise.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1400-update-ref.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1fbd940408..ae8e2fcf3b 100755
=2D-- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -378,13 +378,13 @@ test_expect_success 'Query "master@{May 26 2005 23:3=
2:00}" (exactly history star
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
 	test $C =3D $(cat o) &&
-	test "" =3D "$(cat e)"
+	test_must_be_empty e
 '
 test_expect_success 'Query "master@{May 26 2005 23:32:30}" (first non-cre=
ation change)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
 	test $A =3D $(cat o) &&
-	test "" =3D "$(cat e)"
+	test_must_be_empty e
 '
 test_expect_success 'Query "master@{2005-05-26 23:33:01}" (middle of hist=
ory with gap)' '
 	test_when_finished "rm -f o e" &&
@@ -396,13 +396,13 @@ test_expect_success 'Query "master@{2005-05-26 23:38=
:00}" (middle of history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
 	test $Z =3D $(cat o) &&
-	test "" =3D "$(cat e)"
+	test_must_be_empty e
 '
 test_expect_success 'Query "master@{2005-05-26 23:43:00}" (exact end of h=
istory)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
 	test $E =3D $(cat o) &&
-	test "" =3D "$(cat e)"
+	test_must_be_empty e
 '
 test_expect_success 'Query "master@{2005-05-28}" (past end of history)' '
 	test_when_finished "rm -f o e" &&
=2D-
2.24.0
