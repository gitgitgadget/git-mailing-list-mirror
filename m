Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD8C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 13:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBKNNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 08:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKNNA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 08:13:00 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3411EB5
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 05:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676121170; bh=zMin3KHULZT7qzyTMP6HegCQeHJ4kzRGt88VkudGSTk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=GTkYnGN6mk23AztndVnI3sghVF3449s5TDbdm0PDqlxOMp5H2ZkbTwsVsfeu6VPF8
         wA8F0zVQkY1up4I8N9OsUQgdJLZ1QPtmXZKKIF4HhATNQ5VBytw8I8hAdC/ioeiFqG
         4++w8KPoo0V0Ok3FxFbsQA53sIVlnXmcRbV/kU6I1cKxiN6gcL9CNu4Mu+ugxHvU/p
         0NNhsvTLEDk0zP20PiasBO0S9YtP+Ji4ISD0PAXSAQO7HN6GAeLLlz+tFGe8lpnj18
         aE+VrvBoUJDcsw6boLg9kqhKyXzFm5C3SNS0620YyhHvj0qRqEYp3jtv+mQZ78GcSg
         oIRMlddpvb8JA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79NA-1oWgnd3bZ6-017VWy; Sat, 11
 Feb 2023 14:12:49 +0100
Message-ID: <21f316ab-714a-58f6-a8d2-466d738b4ed3@web.de>
Date:   Sat, 11 Feb 2023 14:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH 1/3] test-ctype: test isascii
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
In-Reply-To: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sT6QzRqbavy71ZKDDKlQZ/S4IZ+doXV4bmtr30dhB9nTl7mEIWx
 qGNmxdzLDk7igDFk0amrWwMEUwUJU3+iRjApGYD/1xFyEQdZ1dNHBMEzNmayjP7m4utQRlF
 tMw/N6Mi9e65BYAvFkYyCMlsATi/9Oio7z9kV09hQXKP0TPBsUB46km6Vty8ox+1BFHtAgU
 2TUua/qpqY2PMAH27sxHg==
UI-OutboundReport: notjunk:1;M01:P0:buVFTKYC8vs=;ZdouMYILITPmm+Vx8uvbtI044ID
 HWSChjgoIKpncao8LFkLZQa6WrvDt/S97W7y11ILDiYzxvDPb2uxD4BAr9O/vPfD6b5NDXbhN
 0USDYFr87qcgiUGAavvBhd7BfIJ8SRBzKYbFVuadDKe+/yDEDuhep8/6sqgU7IHChnAfiaHd2
 K9RoZdoG1fu5m1TWlofau39zqoFsBCe+GzMHb9OrJnAaRgztbkpc2Y+7thTPyekqC7j8VaqUo
 fAFs/phK7CWNbp8v+Y/aiNUrqz6jZK/M84mBVIlKPZ6H4Epa2UPS/kkxRgBipQV78YidYMSrI
 BuDrQbQkAVzLbu/V/n8NV6mW0uUSPdk22pxZ55BHIEsJlezs68/pzoGcG16WhhwtVjLXIBV2s
 RvyriIOwBpt8FUpVN0/beIf/ccqhwHjS0BDWLvA+bfsS4NSen5/jcoh+U0Sw+Q45+6nFGjheC
 TkSFNfDZ/uzlQXnOxFO5YGW0P1U0KCqMKmZhzP/3an/JnbQ43P/UM9uTizCSbyYMls2MaJKPZ
 CaibW+fcpQEodHKecqSVDx0ktnNQMUcH7rLc3MuF/h89K0IMCmxM+vcjpOFMMBRZo3Zy6mXr4
 V+2CKcZIXe6d0yVIIpmBryDyIG8V3CENsSzuf/OVp2ObuHIqQcCpyx8RfZ45/KTo0HOSn4N3y
 tUyt3/If4wxhNAPWD/zifHJInAtZtfX3pKbNkBQjagQyDcC6PiQA9ZoL1sSHg/5r4q3A27n9K
 hoJbkolnYOokXdCcBQEnNmdbAUewS4tL2RhN3H7DSGaQYxArKvqjH1gWMWYZqk4vDl/ufMXDY
 qYWcnxxm45Xpn0ij5OCfm57Vsl3ESgER4zq1WTU68mlkwfl9iabszP+2UdYAjDScxh8lbgwk3
 bbHynrCjvjVYIyRd9JVP1U6FH0dY6KKIoGz1es6t9tVrArN8o3oEL3ZOrqvCA/iyJtco38LcV
 dgwXj8iqTzSLjpHLowBTBxNgbGA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the character classifier added by c2e9364a06 (cleanup: add
isascii(), 2009-03-07).  It returns 1 for NUL as well, which requires
special treatment, as our string-based tester can't find it with
strcmp(3).  Allow NUL to be given as the first character in a class
specification string.  This has the downside of no longer supporting
the empty string, but that's OK since we are not interested in testing
character classes with no members.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 92c4c2313e..caf586649f 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -11,9 +11,14 @@ static void report_error(const char *class, int ch)

 static int is_in(const char *s, int ch)
 {
-	/* We can't find NUL using strchr.  It's classless anyway. */
+	/*
+	 * We can't find NUL using strchr. Accept it as the first
+	 * character in the spec -- there are no empty classes.
+	 */
 	if (ch =3D=3D '\0')
-		return 0;
+		return ch =3D=3D *s;
+	if (*s =3D=3D '\0')
+		s++;
 	return !!strchr(s, ch);
 }

@@ -28,6 +33,15 @@ static int is_in(const char *s, int ch)
 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define ASCII \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
+	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
+	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
+	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
+	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
+	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"

 int cmd__ctype(int argc, const char **argv)
 {
@@ -38,6 +52,7 @@ int cmd__ctype(int argc, const char **argv)
 	TEST_CLASS(is_glob_special, "*?[\\");
 	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
 	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
+	TEST_CLASS(isascii, ASCII);

 	return rc;
 }
=2D-
2.39.1

