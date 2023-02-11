Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BCFC636D7
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 13:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBKNNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 08:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBKNNF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 08:13:05 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC72D15D
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 05:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676121176; bh=U2D/1Nq2ut2FgKUGyNznId4fcWTH2k32WEPmj4pJYq4=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=aMtTRivjqoZPlXCdLJxvjoTT/fue7AsNpTSJAbmzGz47f88gLh/SWiXt2ab+UnifU
         zlaVcw/u0p0ww7fDSX+ey2+sw/L0kpRn8WWkrzCA2zU93edYa4ba70EN+mW7uWkCkU
         TNYKLp1zwWXjI9AkKcxAKPjTlGPGQ3goLE/qoy/ChQMc3tzdVrt67IxUkUerQU8nh3
         /EXIGwRoMvdtHkfQuSW5ycJipAghXKLu8CeF20nZoVG16lxGGsI6zWRt3pJ6+y5q1J
         3bSEs7dqK558Hb8ZWJrYG/2qYxJ1doxWsjQdW5C5EvUXBbOFwzcCi8mIFBBFol7daE
         hkeJk2hC5BNxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKM5z-1p9aJb22Dn-00LnGG; Sat, 11
 Feb 2023 14:12:56 +0100
Message-ID: <d1796664-a6e1-1178-d887-46a095daf121@web.de>
Date:   Sat, 11 Feb 2023 14:12:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH 3/3] test-ctype: test iscntrl, ispunct, isxdigit and isprint
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
In-Reply-To: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8cPRvO/NFjJBwT5Wuf+O51a+y8AjHbxGDg7WeJQuB6K3QQxgC/T
 Xo+PJ6P3KXiqPKuSH1rODuZFheqkWgiGzfLNf0957/Vf9KnZt+VQk7LYK2cydFaryegX8dM
 NguG4uwaTGdpeZJoW6jREU0Ngn50rNkEVGtjULcl8g5VW3h7US+dKwzxb8zo07u50XznwWQ
 /W1yqWHh8p1uhVCF/PI9w==
UI-OutboundReport: notjunk:1;M01:P0:1uIbcwB4uYE=;sTnFutQKoZ7oYnI3RKqpO6RQHUv
 dHburOQrB86H6+qZtcip9OGAhWCLBlq9nYFJTMjCNc5hL+usdmzbUN7slF21MJdRmnY6d+YQB
 5PEvt/KHKMkWNMpvcGbTuaePDFQyBOgp2icUvzuLLzkgi+KIbTT69D/AfQJA1AQjFsOUOt0jo
 6JznZgi+Cu4m/usciAE/lrckR9cfi4XDLkqG5UvePpR/W73AY53FS6KerW1ARMMd2+8nlPxxk
 AlJDW4/MLlfHA9YZOxOjxM23slTqnEZ/p847celrJhLLK8EH3d8TBHLxllI7uehMPg3DJDV/j
 PWudz7wFsN/7ucLQ58OgMv/aN18wQnRQ8WfrM7ix1z+22BEWjpg5iDb5JVUt+SmCeiBKLrXrX
 uo4FFKXwBfRz5A36GKVuC9Tjc19IfM1v2d3Hm7F3ruVyw3i1qOB3sf6KzCmV6NGGlR81pWYcR
 2eUD9L0v7L4HZ7W5IUT29WL/cWAWCJn2KYjxPGjwlDdDeJVbj3agvRqtiedyYdVhPsOKC8u+W
 2lCDq8HuKOpxVlawjG5nFbAyVFSRG0FvShgyn7yALDOUyaPDLg4/xACFSU69sLOdGp9fucjfn
 SZmIt9qe/hSo0nJ4beamGpxes3lCPS1vx+3UJwEUOpkic+v04XMohUUd7ENKBlFzstIbn6Prw
 8Fx7NMZOffHTUL/OYeIVO5ouqwLNX/7iTgaxfzYwGhAE+/aDxLJU+jAk/7m+paB+EN0z2V3SS
 wc1rUtShTPI9poDhk2ayKWvA1hCZLvDvoAM8zx2Ze+TA1st+DHLX22vmLmGko0pTgWEMHER/Q
 taG6hi+JHAQTifYLxogEJZfjQ/5ZQNsTGN50td6ZswSBvpRBuy/WIJ8iRqpHZeVCyxqoe5dn5
 QAVCbm1FG6ZE3xhlRCjCBxFi/zCWiStq4oquW/1rBT6u8pc0nghhgiMfr/M9iIfsv0G1ntIJD
 2soMKg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the character classifiers added by 1c149ab2dd (ctype: support
iscntrl, ispunct, isxdigit and isprint, 2012-10-15) and 0fcec2ce54
(format-patch: make rfc2047 encoding more strict, 2012-10-18).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 8ac76e93e4..d04da0d465 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -42,6 +42,17 @@ static int is_in(const char *s, int ch)
 	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
 	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
 	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+#define CNTRL \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x7f"
+#define PRINT \
+	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
+	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
+	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
+	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
+	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
+	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e"

 int cmd__ctype(int argc, const char **argv)
 {
@@ -55,6 +66,10 @@ int cmd__ctype(int argc, const char **argv)
 	TEST_CLASS(isascii, ASCII);
 	TEST_CLASS(islower, LOWER);
 	TEST_CLASS(isupper, UPPER);
+	TEST_CLASS(iscntrl, CNTRL);
+	TEST_CLASS(ispunct, "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~");
+	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
+	TEST_CLASS(isprint, PRINT);

 	return rc;
 }
=2D-
2.39.1
