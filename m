Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E945C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBMVK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBMVKz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 16:10:55 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851FDF76C
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 13:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676322646; bh=Xf3NLivsPKxkA9WSNkn8ELP5dt02eEU0ID+bFAFOdSM=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=w3yiVERWDgC/D09YxC2iKgQwQAUr4ioAWzEJU9PivNvVHgUTuBO7JzpKrbjvfra1t
         lnZuJLz5JEctpC8O764R/ExLtwyAzhJTVPrOoVZ052QE64Ek6KMBx79jkBA8VSmTvx
         vUbvhu8f2Q96dvbqFT63+lJzzaeFlucw7xYIUrR7TNMCjC4YuOo44ys9XrB1k3lzXI
         tOJ52kgtdJe8oWv1gf0N+VZzr1LCuHUDMlAuxTeqzieFItEHWChER4dCeiObIPNx+j
         jYT/fYakKzORm1Dnab1P7nO/+V+ugpdykJEqRD1qkms4GXROuujgm4CobSJIwcSRaI
         L29gxHB2MBcOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1okbaM1jWu-00jHD2; Mon, 13
 Feb 2023 22:10:46 +0100
Message-ID: <ed877364-51a6-187d-8d37-17e82677c0ff@web.de>
Date:   Mon, 13 Feb 2023 22:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH v2 2/3] test-ctype: test islower and isupper
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
 <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
In-Reply-To: <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T7y9IAi8Cq0D1q3u3Zb+33VAUawBDAy7p3CrLOoe8U70zlXIXPE
 oVup8wND86uqRdGR6Y9Tte83iVVVi7PuDSeH6elc+ns0n8VV84CmxPZLb+uYxUa6WffpJvo
 CC5rqVvZ9p795kHme9yk2tY/+PP9TmNOMkgfuaqka5bgWZKCsJw7BQa5QpnjekaRaqMj/fK
 ACZLuRjuRJuAh5kWGqBTQ==
UI-OutboundReport: notjunk:1;M01:P0:qvM/XzdD/Gc=;ec1ggVPMLpevEbMXd8uvIge01WV
 HbbwP8mIMrtU34IhKXAyjJJkisIxuDlzqraMXftNaEbLeSZp+Mxyt6dnbgC9pfOe6aBAzcVE+
 O41f4o8IP5KG7mri+rddeRlN0sXz+BUOO7GjO0O1tIug1coPry5bgy5PIxylfhm4C1jR/jlC1
 y4cQgcIAzVn8k9stAjUnDMyEt3Nng3a7kvp2RrqmFiFwLjbrxnhylt/iTHrlZBMs4YwJjn/HS
 SfW5X+WmhppqFFSHUNUw7GfKC9cXsagXPn55i3wV3zQJihN88MosRhvuqEpbejEkfU9N/34Z6
 ajlL0z5T9ybb60eGg/hyufqhQVrma5V/P/8ob+BGoLyy1FIlgFd9VC+fYOZ68m/Zu8wNa01Qm
 0USl9ZOGTtxNQFp3Qb3X5B5gbF45O54XwXqcWdAqAO8tWhgVz0kxHU3ZC93nW0F0OaqbAQVbu
 tSbzMs8lQAtWH5opCc/j0cTltsx4wcviU1+LbDlwJU3oLITo5E4oeyvMFBbiWJhhFTaDgCkId
 a8O0s1CbPak3BWKZWy+3WNCZCTiUepc5JBrgAkhc+7l3+hkJg6aa+5Q6CAyrI1Y+AB867CxL9
 F7Iv28JIB2TjXafD+Rpyk2mlWKAFpv4536uoXKDMqKbM1VQUsiQ4ujJZxju22AtoJTIzaxw/M
 5Q6McVvp431UAJKhmQuZJPJjc6F4x2uZHJp+fHezQoHktNhCflYrgVy6J8D6AQBDJi6hHfdQh
 iE+Km4J1SrvMi66j2D/0ojM1r2t5qQYaHg7hEhy7nN4leJ3UpRnGR1k4YKTQWuRXwzlaCSjzY
 HPcZ8qWEVIY6DNRtyvuH7bMYyunooDjltlyfBOelG/5hEUEWIZb/o8EpbH2/CYBDSLbpFpg8D
 PQKWpky+WBrRenH7BJP5Q8rPADlHm5zZ46Uebs/sv/M2jRaXQSomrpEbl5f+OoWcXaO8PPMDK
 QuNkPaVp4mBb0nvaZJPnOnQrIcA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the character classifiers added by 43ccdf56ec (ctype: implement
islower/isupper macro, 2012-02-10).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index caf586649f..8ac76e93e4 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -53,6 +53,8 @@ int cmd__ctype(int argc, const char **argv)
 	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
 	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
 	TEST_CLASS(isascii, ASCII);
+	TEST_CLASS(islower, LOWER);
+	TEST_CLASS(isupper, UPPER);

 	return rc;
 }
=2D-
2.39.1
