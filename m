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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD5C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9985821582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YO15Uamf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfLRSMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:12:05 -0500
Received: from mout.web.de ([217.72.192.78]:45785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfLRSMF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576692721;
        bh=0DNz3umSex4/YibIxONLfsex2USqEjebUyWbVUgXE38=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=YO15UamfTh2Kb0+XfOf1az4V16UXnwCV6zCrRyrTGnSF8qWnV1dpzwI0JzKLp4f9D
         oMP+mOFWp7pfxgfSikaz5zTb4ni0hSjtGSmZcHKmmJomqTFV51nj58105v1fHJvJTt
         dLS4riN1O0g6DO6jvNJYd4qVh1yIDj4fOddn152U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.27.9]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHkw-1hc2Vb1z8Y-0181NH; Wed, 18
 Dec 2019 19:12:01 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t3501: don't create unused file
Message-ID: <43395a82-34f9-30d1-b468-338e81467f39@web.de>
Date:   Wed, 18 Dec 2019 19:12:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DOkR/0Rbso/KnX+gq2UmV5kR2N6sXgT/tOMVE6RUynAwxweIoEd
 id7pqskOiqnBEoqBcSrwikmmQN/KYxN6K4T1Mn7sCWGhI7EcFdfYWS4J0eauzjJczBbcLjo
 YdFm8UU1PKnl9ko4sM9KJOHv5fgUNwifY95AeVufiJr9K3DCVIy3AcmLjgfsHG4O7ju5zyR
 hNYqYfRHItUubMbBTay7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wmOoU4KbhA4=:fsa3MIhqzrE13N0bXJgafR
 B5QBPILqtrgut0tLOExWyTLWmeU7n0bzuqhAhmtoXWDe5nJe2b5AmBU6RbqGkZvhJH86l50uC
 4RnIXcCb9T3vUbhhGgDNG2m/nCxUE4d8x3cE0TbPgQrBD25L+AKYcLV5nqMUb00xpyl59N10c
 0lS5U+4xT9rEpQM8ixI4aSNMhnQ34WWvhUYyB1zjE10rt8DMbLzU38wnPu+NFQp4u2y85hDY6
 kYqlKMkIdJsy2A5QaE2O9agtrCyHq3WIUcWry7596y/dardvCC+jSpwWpSbYwEFUnKV5dn1qr
 omDXx8Qx2ncWgpU6btCTYqEnjHpS/jDLfFSwiipm1gtXld4RdzAFPWnpdKnFAw5dgBo6zS4FW
 b6RC356YhWPubU/reZH3TOlJA6ShcwgN2YTqmcQHk/yNrqMzG6j14tXA9QDaxe6pwydP7xrYF
 LwR0bJV0veq1KvAB+5lS3rRvGnRrxS46sFeufA5bezZqzUjsZXNWSCE14qE1OHbFtvoC3MdtW
 j1LyBXqACky8wEHqwlRyg7TTQVeJb/MxuyScQIlYYoXLCfxeogrg7hiyxI2MYucAFWdJ6ZKAN
 JPo5UXaAjmQUlhVbVNFCE3a/ypT7xK2GzF6TdBsz4L3GtRLAcWrVa/zm2ImAMhaij8X+N3cB9
 kAqcJT9KcDLvc7EuCB0MC8RMa/d0WWjbIKVKJJaD9+vqbP1KYuyqMHTWKSZyiT/l7VcXp6uf6
 Y68MuFs0MVj+WRLpJNX0qxbVS1W9mXt1+kyK+Msui3rai0oLXwyvEJp4XqlWXxGFXjLWMcVBe
 AuPawiYOs6H2D0j/olkrVKTPhTdFHd8GgNbbxCmMd3tljhQ6C4iJYKHA4YY2tg0E6zA/hJPdq
 I2nDl4Xf56kw0g9yfr5zWEWzduueZux3Jhu51dDcWdP0UfUUwr+wA57TONyITY8e0/wHMu2bo
 A7sLyBXMfjUrOElqm9R6pRqWBHVr/Ik6gHCRVIZokAIaBKkUijdMda0y+eK1H6WCYlOrpu1Mc
 jlYyZKayDhsGoT9f+IebxHT4PHijxl7J6ek6Mwocqth+5DPMm75ciQkEJZo706yuCKOCPZpIC
 0RYuYL6G4f9DcgmFD51Kv42OkJroaAr1++o0gqwmEENy3Tyg1GWO7g+uncBYkRd0G1oNi7oC5
 XxfMTCOObbnerfHD1GwR8XmLR19Agz48pgNd3mLqhOMLNNy6w8gWKtw472Zal53vVzhqPDO9z
 F/eJ6FmZ5AXI8T56gP5K7rc4jz7Kkm0KTI+wtXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file "out" became unused with fd53b7ffd1 (merge-recursive: improve
add_cacheinfo error handling, 2018-04-19); get rid of it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t3501-revert-cherry-pick.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 1c51a9131d..7c1da21df1 100755
=2D-- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -150,7 +150,7 @@ test_expect_success 'cherry-pick works with dirty rena=
med file' '
 	test_tick &&
 	git commit -m renamed &&
 	echo modified >renamed &&
-	git cherry-pick refs/heads/unrelated >out &&
+	git cherry-pick refs/heads/unrelated &&
 	test $(git rev-parse :0:renamed) =3D $(git rev-parse HEAD~2:to-rename.t)=
 &&
 	grep -q "^modified$" renamed
 '
=2D-
2.24.1
