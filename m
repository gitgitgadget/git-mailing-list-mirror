Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C75C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 17:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C701D61A51
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 17:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhJBRqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 13:46:13 -0400
Received: from mout.web.de ([212.227.15.3]:44561 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhJBRqH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 13:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633196655;
        bh=IUiTagGnryxYTG1+yIM6nkcpmSCuKkhsUB+yXyMNzDc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=f70VGdu2ug8z1ZDa5v823SgHt2mrDMYeTEUMUWCSmZMLT0lw3CcXfeDJr+SQVvJn8
         y4j0g8NnNtXl9zvt+LTA/Wnhc0zrXswWWRCFKz2CljprwhbSVBkUOGtIFYq+HBRyR0
         +k6xCTt3okkSoRcdAgVPv6+Rawc7H7sJEYHPsqVM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MapFS-1mDXD30cJO-00KRGt; Sat, 02 Oct 2021 19:44:15 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] p3400: stop using tac(1)
Message-ID: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
Date:   Sat, 2 Oct 2021 19:44:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KMUoGNcL1EwAMiOjLtTJWQt7z8AJHeiy0c6AizBBQNmasZthsJp
 fVf8mVsb/GxV9XxSARa9Xtv9CwF4hPH3lgm/zUZX0OkPxsbag0cTc0bYH7gS8lS3So/1sq4
 oi4uk/CS4EIAiXCCdEThPT01Dj4Bkp8eiI6QxbcgJS6d1IGnRoc7+2dWkdPM5NJzqyXTIMA
 DS0h+20ZQFzcCLGOV/Bqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nAxyiK64WTA=:cY3Dg689nD7yC40cY8hKG6
 HMHYuEt8oYLU2isnNwplcz5awCgo3EGP7zTwIuTwUc5kiiGBEgYUk/o/hGQDvTNdZMHe1gqI/
 uCbztkcc8k0dwpWU/0r6+nh+aPsQHCI/vbCt+VbwFTVhS13Bqq6Vk7l5pbJyptZzX+s5FLy6G
 EqMInaEkxkyULb6zJkZYnCraAt7ew0+ksJZXqBNPfB9Wx5EPAF0n/gGWflDqSK7AsF777cDUI
 M2Qum1dJPh5kvJ92KjOXVuvPgudYb0FqctV/UrVFoGozH0xM/7Iy+ujC9cvzXTcYG12lcrsEF
 tRNjYvKlxlEH/4zypO69OfQI2xl3DlRx+0siC++NpjlXSfB9TVGiZ4xO4gsbwfkVz7Lx+T7/0
 naPYucC0qpmKF/bJewVf3xOMKctqiYRRvbtJNxBKG08msvryHq8K/Mylz0YElWjUcBQ683T51
 dbm8ctcecCK3snrgi919eeJFgJbZDrPtc2X9VF9Qg2jrZl5sWh3qnVVsZ/9fdJ+WmbeiwsMB0
 3MbrvAXfiNwdhnXrt3PWayxSxNYOIVM1iE/79c4cmnIzVwZ+WFxveyfy6I4bAMgEfYcuxJRhS
 xkAwakQ1Wbg2CpGQxW7ZxMF2aAKgkzCGdPKaB4TC30+aKgJLGzky706GFTgCwocepYOei26E7
 jVIIjKtfnYb1bkG2Unq1Rvg1BP6oLY32Y88nMo4phxDArN0G7xXGALwMwuyGYxf90Q4SY/P7I
 0aZrNat/Z7V+ArUgl6g0ImKjqzNRjELSp/yRorgoPLEHU9NlKbB5yJm1ZmaNwYze84C/YXnyK
 Y8553CZkUMzN3I96nqWVJyMZvdJZw8I2YJ3Eq82W+epekeO6d2cTFGaBFoFNvgGdi8if6t2wu
 DVY7kgoilgFlI3qN1NLuoBYt8Ls+gmOSHiCkYfazepkGQ10wVQKLy1DJVYRQzj9KHW5WBvyVS
 AiHCSurT3d3soP8P+GHLnvhKHu3oNbFVwokw1qhxSCgK84GKI+bRD/z43iCjnCSi2Hy82WPCO
 GM86qyeOtlLWzmkL6tUcph8pMIai6A+O4ShnlBQiNzJvGzuozOvm7V5NZIPZRghEDA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b3dfeebb92 (rebase: avoid computing unnecessary patch IDs, 2016-07-29)
added a perf test that calls tac(1) from GNU core utilities.  Support
systems without it by reversing the generated list using sort -nr
instead.  sort(1) with options -n and -r is already used in other tests.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/perf/p3400-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index 7a0bb29448..43d5a34e8c 100755
=2D-- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup rebasing on top of a lot of c=
hanges' '
 		test_tick &&
 		git commit -m commit$i unrelated-file$i &&
 		echo change$i >unrelated-file$i &&
-		test_seq 1000 | tac >>unrelated-file$i &&
+		test_seq 1000 | sort -nr >>unrelated-file$i &&
 		git add unrelated-file$i &&
 		test_tick &&
 		git commit -m commit$i-reverse unrelated-file$i ||
=2D-
2.33.0
