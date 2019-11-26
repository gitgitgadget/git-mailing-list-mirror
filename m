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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CAC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034E32071A
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WS8oZwJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfKZSWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:22:00 -0500
Received: from mout.web.de ([212.227.15.14]:35453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKZSWA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 13:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574792515;
        bh=6pRNjMpl7YxCSMi+NAre17qjYpfNxHm4ZgYO1fcs8PQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=WS8oZwJ+4kMceq6KuhJ2ODk8gwvoNUS1fjYIEoQ7U4qBjtLC7ufMfmF94+3NzX5OI
         gmBWZm3jbyHLJFfD9o2HAglHffQOEx/uZj3wywUs189GXCEM5UW8XFLVcWerAou8HI
         uu3k563wHn3mJADI/ituWvrFvVwxJ56l4zgtH2gw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdVty-1i9vRR1eXC-00ijsL; Tue, 26
 Nov 2019 19:21:55 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t1410: use test_line_count
Message-ID: <5b872979-b29d-b120-870d-1cac807363ed@web.de>
Date:   Tue, 26 Nov 2019 19:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dXmxFY4PE4n3sKsczeR3iqQ9W0zKP0adSjhZ1MPSQNiQATnXW2U
 bsfGft1t34f0aWQMBuTH7IBlm+a1aq3wpEG+LOQjrrJfrF8ueC95VSs69P07dUHhDoz6Rf1
 6ljHsgJ1RGEXx2n9P16brir9lr8EG0aRJ84/tsXI5s5/J1uTGkYAHsICYM/9kWrOhB3MvV1
 yjhd4Xd8xqnIe5lhmI3OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1KerQPWsOIM=:gtBRKMot4Umv0TB90b/5cz
 acwS94prXlps5KnInTuhdFgCLoci81wxhtF8lsL0pwILtu+TSJ/u7lkjNMI+ERuTF/USHK4qY
 IaQBxr+wk5y/BNz926iC/wa8VF5xkX43I6TJiwWjhuqYSzGLtd4TTCr+ZTUQsBQP4aVLSEJVn
 GPXPB1YTGZfVop4sEO6PCEmQjlTdx5NE6KjhW6PZt87M8lWhDwhTN67o27xTBrwYHa4gmIMII
 oojo5Tu9gBx07T0Noi/PrBZLIJOylucJ2y4B91SLCYrH1oB3a2NpQEODEfx6xUd6xljz8NLT0
 aDV5TEwCqt1zUJvLwjc7tNMyG4KBRDJvetO7erc+T5Geq7pTZeInN0Cj/NBlfC7+5NqEg6cAN
 eeThyqcCB9Q+lTD6kxOQ0/U30Te3vdOOmj1e0amL1z+/02O9tZnaAyLzJ83mZ3px8eGhSE4YQ
 Vo3G+G09LOmKmqm4u33JjAy71ziJkL9WeIuoxspuLCbaoWk5b9SgUtSHAJyE1ndZMf9b4Aw53
 ys7Q30cWZl2AROInMw7vYlYPrmlvoGXUG+P18Hl/KCICHt8TQ2gCQ3BulQ3Nt6JeSWcv8JlQk
 SbP4qF9gFRDOp5ZU2fQwfKFvKBpZsnixObc6uC9rQPzngblDePa2ssOMwWlt52In8FrBgFTCa
 vIHST7Zu54BLXcXbkiseb/H6VDWIe+JXvG64Uq4KAm9SRUiOzxxd5vbt5DKP4BcdKDbqLFkjG
 E0tVIJ+bcdPMJlLrR4nQMmLQS8jV6kUqbhSChjSqjmuwwmiATpD/Syw+Cm4+dxFvmjJ+6RNyO
 u7tWxrJFye/g4S22XkKOsE6i0I2rxAMeezgIe1BVOOkyM1+KH5I2FiZ7b2rp5isChMqJdOtom
 cdLkxkUqGfNW4LT1Zd2qjpdQXq+bDmSvI0TazVgKAzWIVL7SDhQy4Df1J62jn1vhUBWRWMwZR
 YReepU4QznzWyXR98NIISJxdHLnvAmKgcnXjQszzXQwgRYtJOzSJi7Z95dm6qcW1WCpa9mN69
 wkPcE0Nbp0ZSmDDgoI94UcOxEQHXAY6GOaaRjb+hrVtUp1OCK7hwSsIeHe77kq3c6pBpRp348
 bLGIa5HwhQiXJqDE/Epzq8lnIMbESUoBNDEOz1MdwnvnntRpqs/J/tRdx+jv+Yg1w0hYWXkeH
 YX6h+5bxePZhtLxuQHBBBiKwg6d1NFhD4mtHaBAcg2hH+Jn/55iHDVdC0CYufbd5NQYD9s5lL
 0xRRtjBzh6/+nKO+CVwBn1MA3Ip2Hv+OyPP9gHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_line_count to check if the number of lines matches
expectations, for improved consistency and nicer debug output.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1410-reflog.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 82950c0282..76d9b744a6 100755
=2D-- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -195,7 +195,7 @@ test_expect_success 'delete' '

 	git reflog delete master@{1} &&
 	git reflog show master > output &&
-	test $(($master_entry_count - 1)) =3D $(wc -l < output) &&
+	test_line_count =3D $(($master_entry_count - 1)) output &&
 	test $HEAD_entry_count =3D $(git reflog | wc -l) &&
 	! grep ox < output &&

@@ -209,7 +209,7 @@ test_expect_success 'delete' '

 	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
 	git reflog show master > output &&
-	test $(($master_entry_count - 1)) =3D $(wc -l < output) &&
+	test_line_count =3D $(($master_entry_count - 1)) output &&
 	! grep dragon < output

 '
=2D-
2.24.0
