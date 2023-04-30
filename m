Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D63C77B60
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 10:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjD3KAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3KAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 06:00:09 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850219A5
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1682848802; i=l.s.r@web.de;
        bh=KssUWx106CIrdvFTddyQymBkkh8LZipsSWoOgUiFg8c=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=NE8Z0ZgSQIckmc00izdAtGm3mgsbXFNP0g2ufOUJU8wx2djw1GQCKFJ7l19i3Db1X
         FRgXGmGnSHUZ6HvXwHIo8gpCHET2C8uOgBA0Wh5OucWRc81RjmSKncLqduwfYx6FXv
         xaNtxhJT14xadzFmZ2n1IboAEIIoEUKzKiQsYvX4xiAWy7k0l/sMXX7RTj1sQMGO2D
         3RxWYbkcgAj2Gf1mz1lAG22OGp/xjDaAJqii/O9DeE6f6/ac6e2mdYGV7l3fqGGA5d
         arwQeyW0jTKzxJaSCZLRL9KNIu13yxC4co9X9bSLiopPL4EA9p7cSPw0JgR8ZWEqdX
         VEu27qliV7L6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHWj-1pnqnX16gv-00WG39; Sun, 30
 Apr 2023 12:00:02 +0200
Message-ID: <cbc7feb9-7e15-77e2-b3e9-1fa194b4d4fb@web.de>
Date:   Sun, 30 Apr 2023 12:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] test-ctype: check EOF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gOwcN4BnTMiMtc7fTxTINYyfAGlKE7fbyQf7t1ZBrgnIjnJM9Ew
 ETxb2ZZY9y7mbVc8HsWNxmk7ZA5gF06aa3RRUmbvLG5GkMGei+aFX2+7EED9M3pbci1HX3p
 F2SdLMffHf9yiSnTSma0GBq0UWyKWgGf9NXOCcGddDYncxdh6OXDsmC7uuP8v2fux1VAvot
 5d3PhjSBHRmz9KePsA2Eg==
UI-OutboundReport: notjunk:1;M01:P0:cb/LsWjBc+4=;x91zNsyitON4fbVeC46cvk6cbdV
 mLt63owlxU2eSv5L4Wji8qdKI6+gOQE1tjT4APMJ2bSAaCH84rNpSH3zAeeZ97IPlP8Gfkb7V
 faQnzqan01NzAu5M2ZWJrwkqUywYquWoKhMtBTtrciHCvYDGXAvwkkZOsDlKK+J6ihpBPiWgr
 q6S7QuiOIxUpsYktz89x1mNiKJzhZA+6GzD9kW+EZfYZpwqlSiarAodh82dFM7d1V1yvwpuD8
 hMJI4G6dBOxpBoWAofsyHrf6v2ra8VZhm/6fzcMsXwvWzPuCCsazHCUYddbvpPUs1yMJVxDPe
 OWKGIqknW97MWFOzDLfHTjUx/a1G2OLOZWcuq2UfwTECzt+2wMfqIkq+VSiCk1GQpWLh9GBoj
 vEWNVdKHwQ/u3u0Fr3K3h8pcqHut24HoclB8GrcR1eGonfj31cud078MVUxmuAuAfJk2Ib5Mo
 Xd6qjPvTf8jLck5cygEZnCF+vZsw1+QMoAvfFiIBiJ9Ak36YvujS6g1iwCFdWIUWciqS5N4ef
 sJco/8BD8cnH/LtkKsUiOfE0MvrHiNoQZ12hqmbqYoxkdELL01RsHedzGV1ezl7hRBpCiO62q
 MjEfHvJ0DjVCuqOw2WQw5FKTTVDeR/htWgpxTGBHbVp8S+GaZ6GmwG8OKOHV7nzMUuIRkrols
 wX/F1ko615DAuCYD/Q+OBNhBaIAGPF3aovdS3DghbAoBLOZbfXi1eN0VihWOOZ9N6tvaIjtg+
 ExfJ4FkL4QAUQGpcE2dgJeSBoxQ1oOF8hzJ3+rOQwzep3EmjFVTsjG/11nag1BKE1zruUfJuR
 hxOzM9hPZYOCMmKvPVNh4uU1itirbV1ka/dt3HhcVa7ZsrUQiGa6cNPUUW21ecc6DD6b+zzTv
 mAu7IA9PwzOKtTUQKaPOXOQzTSJOchArB2Nk/QJCG51Wss4W0cZ2DSMOcy7VDc7OCSkbA8j+q
 TF+BgA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The character classifiers are supposed to handle EOF, a negative integer
value.  It isn't part of any character class.  Extend the ctype tests to
cover it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 71a1a5c9b0..039703ee72 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -2,8 +2,10 @@

 static int rc;

-static void report_error(const char *class, int ch)
+static void test(int ch, const char *class, int expect, int actual)
 {
+	if (actual =3D=3D expect)
+		return;
 	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
 	rc =3D 1;
 }
@@ -24,9 +26,9 @@ static int is_in(const char *s, int ch)
 #define TEST_CLASS(t,s) {			\
 	int i;					\
 	for (i =3D 0; i < 256; i++) {		\
-		if (is_in(s, i) !=3D t(i))	\
-			report_error(#t, i);	\
+		test(i, #t, is_in(s, i), t(i));	\
 	}					\
+	test(EOF, #t, 0, t(EOF));		\
 }

 #define DIGIT "0123456789"
=2D-
2.40.1
