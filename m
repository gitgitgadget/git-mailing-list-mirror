Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9808C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBMVIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBMVIX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 16:08:23 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA7F76C
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 13:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676322493; bh=hQbhfy/lfz9cZqhMEsFilzqC/soZnCEvI61mSwTjPyQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=SzUFHcsslaNnlXV0cEkAXGGSaNzxTRfibbb0aD4UFwVEhSLzx2LeGAMeYyEr3cVHO
         WYebzcXvhIF0wGwhqhcesAviqniA3DpuIP/ik1zvUtwj89/w7iCIHJCoqHjLRrB0Oi
         c/5kY0VkLOwcdyMekFpSyDgV7HGizLFZQnBMiWDPY6VIEEUcpShTLitj1A9mKBtsQf
         8zOF3M3eEzpqtURHqCrMjyUi0Nvayin6B3hFYhjAnESu9B+ikCIkuOTX/HfMaXI+LW
         GVceHeWWk/XrjVlDSjA+oFnFZAwdyuQk21MRvj5/1LK181cwLcIwKnQ6AxaWe0XaIv
         o89fE7yc0bF3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJnh-1pLLS13ZaD-00Fgkh; Mon, 13
 Feb 2023 22:08:12 +0100
Message-ID: <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
Date:   Mon, 13 Feb 2023 22:08:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH v2 0/3] test-ctype: test all classifiers
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
In-Reply-To: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KRdUUEurZlMchZdXiNbQprEq8Ky9uDEGa/lx3bjrQ+87ddp1LBj
 ehDUaMb7SlJExNdpkWF2BqN1xsEvxKcH/V9H+QUlHHgpWdD6AqcYeMoSJId+1mFlat/IRl6
 tJrYTFzc9MxHyQNp0A6sWb9KKG4pzLg8a/smfeHEv74aCKkEgBfAcyyy5x6E9D3isAzJAOQ
 NAi5eQ41RHq/UZ3wtwN1w==
UI-OutboundReport: notjunk:1;M01:P0:ar5AATxEtaM=;HlLCh66/0y5cElwLcctW7cEj06G
 /bXFQ9aH464pgJreqYkblXkwy7+oX00RNMcT3P2Yy8qYW1s8ngkq6t1t73gXgFPdBHYiewY5Z
 uwR80d9DM5I1QFcaw+zNC68nI35ytXRskYehhle5Qd2+UMi73CFCVv3Xjtu4HnjJFJDvFkdXt
 7jtIS9lVG7t+F5KTWBXsv9riqlOvj6i9AqFrMsRtD7j6cCm1fYjbHu66Z7mSSJBqWOrvOCyPB
 UN6wYi8ldMUn8A+MZ5Q7Ro+3ugakAd5m1dszFEA7IAIx+UGFuFZakVOHIabkryqa70XpL1m5+
 D1cKvZ+p/BYe4oEiW29CPOZX8eF5wb9iryG5TuJMex6WqZFZvMZeHxyWz7iZ6sEiUkXIp/ePs
 k/Ds3KotfPoQod8jwaC91NdBNikifFTcI+epsqDHecRIT1x+uVnc5wiaaVvLYZv06T9XCkOYo
 6A63VzMV4Z8aZO457n7ATOAqkeBqQTqS7tEWKCc5HL3nM9PdDDUlmzRC13LjrBKLTYFOM2HFz
 04a6F44UW6b9/Ojfphhn66LsEp0uCcIB/t7s9NvcQpr1vy65suTL5T+kHiHSSOn4l33xbZjuI
 s1ZASPWN9EU8xHT02v1VLpSlbBLUge03GOR2yYghiwIRMCGQYTQwiTLCZv0J9VnkSwGCcCf2P
 eZ59QhAnsI7qxm3o2xeCc3/ghQnc7Zizm5wK9OSlP3mKkmuVE4or1pkWgbyzEMmT1cXEGxCU7
 Nr7L35PyJv5ScKdvtC92f0lPKMmyG59FKb2gOdCCv4VE+KYdL9C7MEnG96zhrCv/zESArpSOn
 fE0yjM8j9Nf2Yz5uuNK4EgZUj0eO70bdzubfV9yIZYpDAT5gU0Qfn9s1KsiNfGv1k+TyuCeD1
 UD+9/tux7gQVDFo//MHxotFyw5BpG1AeQxLfqwVFHlvqnCKS+yVxBPgvegDlrqPkF1CR3neTC
 /kpSxw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to cover the remaining character class test functions.

Changes since v1:
- More compact and readable isprint() test string specification by
  reusing the one for ispunct().

  test-ctype: test isascii
  test-ctype: test islower and isupper
  test-ctype: test iscntrl, ispunct, isxdigit and isprint

 t/helper/test-ctype.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

Interdiff against v1:
diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index d04da0d465..b21bd672d9 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -33,6 +33,7 @@ static int is_in(const char *s, int ch)
 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define PUNCT "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~"
 #define ASCII \
 	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
@@ -46,13 +47,6 @@ static int is_in(const char *s, int ch)
 	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"
-#define PRINT \
-	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
-	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
-	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
-	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
-	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
-	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e"

 int cmd__ctype(int argc, const char **argv)
 {
@@ -67,9 +61,9 @@ int cmd__ctype(int argc, const char **argv)
 	TEST_CLASS(islower, LOWER);
 	TEST_CLASS(isupper, UPPER);
 	TEST_CLASS(iscntrl, CNTRL);
-	TEST_CLASS(ispunct, "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~");
+	TEST_CLASS(ispunct, PUNCT);
 	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
-	TEST_CLASS(isprint, PRINT);
+	TEST_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");

 	return rc;
 }

Range-diff against v1:
1:  f8a7889fb4 =3D 1:  f8a7889fb4 test-ctype: test isascii
2:  1e0c313b38 =3D 2:  1e0c313b38 test-ctype: test islower and isupper
3:  dcaffe6917 < -:  ---------- test-ctype: test iscntrl, ispunct, isxdigi=
t and isprint
-:  ---------- > 3:  cb50e581d4 test-ctype: test iscntrl, ispunct, isxdigi=
t and isprint

=2D-
2.39.1
