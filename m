Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54368C0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHEOjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEOjD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:39:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021544234
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691246337; x=1691851137; i=l.s.r@web.de;
 bh=hzLnnDdMawi2LP+OHDOk5nDU1jug8q3Z5u2YwwWUgKA=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=QmmXwynl6D735fRSC4VELfVNx8cs3WryuX455NB2QCgPcaaaDbX8OkAWZC7SDT36/aGlgCG
 aa3n8H4ZVhx9gKn6feAGZvcE//f0/dPLiQucUlaUbIG3xYpyd3q2go/l9J1FYlT6hdK6Mem7P
 XpcTCijaOy3FIuDy/AXeCpUmgiHfcyeSt2Dk0DGl0iiPsdJmiRtIyxDJdpOXfvvfNbLpkuSwj
 6bFjeQusGKZAfVYSaKtU/TlgVge2xQIF1vk9m2YJP4pUK8DZetQB5nLpcvx15FiTYpgPuKIUP
 3Jc83RVaoygvlWvRtus5wcjmhvaQQ/qs8GmvHrGfOKQml5FcsjsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8mzy-1pn85P1L2k-0166EF; Sat, 05
 Aug 2023 16:38:57 +0200
Message-ID: <d5df2863-f925-7a1b-9e82-c6f55d8cb931@web.de>
Date:   Sat, 5 Aug 2023 16:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 3/8] t1502: move optionspec help output to a file
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
In-Reply-To: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o1LZj+HElyLtCrjw97/rPBpjRn/yEJllyqkn74N536gPVTnhsaZ
 jPpzDMorf9rryLxROlUJeMkG853aMXPn5Y3jTGvCMI17qjLrYuRanq5nCRY6xrNJErs2ERB
 RR3dsgCJiq1UVs3gPDO03aF5abeYoAQcY0ujms41FftRPiLC53C8UCiyoEZ412JBlf5ABzK
 bnMi9/xyOVtEAKjWMz5xA==
UI-OutboundReport: notjunk:1;M01:P0:wMPWNaRk4i4=;5iMw+Fff7nUx/Hi6dFOMtgI4MjI
 hCsmW8uOFUniraX0oPeEkd64tAxlDphb38Xsce2MD/jbOrdlkhaGxeEhvZHhse82HPBYhONby
 UNBG+HPRD98yzdZSPtuv5KqDvlTxPGq1YzEo34gQZ0QFu6Yf8fxvLALhVC7R+8AyiE3lykfHE
 7NIVRvFICvgmvlz8bWi5/pDvoXWlQdYdIO1b9kO545b8UDkKXKJsaXuu8Anm1rBQMIpYVlEUT
 gXqmwDo61EH2+aY3JEHAZZrusI+SHUJ7ZdN6TQ99Drl+jZeixYiPZAye4j5C22z7TQ0UFm8TV
 gJFQ7Fu3XHWJIantj5Z4Ybg5SNx+O4RxG6g7MUORDOfGoLd0rEDHspOqtOcuHPOoNU1C2pvrH
 R2hwW1XlgYVd+irX/30NWSvYadzxV7F2NWPkDxR1gpTvaJAVetHYIQOUOm/sz4yQ1ZOByEdMo
 Q9rs6iiRpen9G1Vk8VtT9fL+c5DHSfNnILn6Z7GsPU4cDn+/MqyKlGOpeczEQh+hJuYJvh7ua
 +UP+FQm9tfS7amwCQGgfzm3hB/WYfmo3ypQNCdtBEYE8H3y554nI2zRU0lnhZu8EHM3mXbxCS
 WpSL9D6r/ckWzMwIB5szBM+0Rmp9wPjT9//LSPUim/llmB/hV/LTaauHlzH7M4pO1tLvKmnjN
 TI4opHN1VXm1S90S3I+J1WmEtIaQfIbgTdcOT42tQPIBc9Nr02dNxOUcClh26IaIkMDRx1dgD
 clkQmG8/L82N+trdlUHzqZREWmfj4bASyJU8jgBXKIixcMAKrgxmHO2e1igEEvd7rFdnbGdv0
 6MCbE3mi7brZ/j3lrYXoVmj4yGf/GBpglTIVdfrduZHjFoHDY/TZ0foQCRV50zLdWv6MbuNzo
 VvHRUUULzs2Ej1/DWyYTdnbzC8LhsHT9lGCjOERU0RdvQqtGPHggHUx93T2K6xNQ8FnCdmssR
 4gjlJg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git rev-parse --parseopt" shows the short help with its description of
all recognized options twice: When called with -h or --help, and after
reporting an unknown option.  Move the one for optionspec into a file
and use it in two tests to deduplicate that part.

"git rev-parse --parseopt -- --h" wraps the help text in "cat <<\EOF"
and "EOF".  Keep that part in the file to use it as is in the test that
needs it and simply remove it in the other one using sed.

Disable whitespace checking for the file using an attribute, as we need
to keep its spaces intact and wouldn't want a stray --whitespace=3Dfix
turn them into tabs.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1502-rev-parse-parseopt.sh | 79 ++++-------------------------------
 t/t1502/.gitattributes        |  1 +
 t/t1502/optionspec.help       | 34 +++++++++++++++
 3 files changed, 42 insertions(+), 72 deletions(-)
 create mode 100644 t/t1502/.gitattributes
 create mode 100755 t/t1502/optionspec.help

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 0cdc6eb8b3..813ee5872f 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -58,44 +58,8 @@ EOF
 '

 test_expect_success 'test --parseopt help output' '
-	sed -e "s/^|//" >expect <<\END_EXPECT &&
-|cat <<\EOF
-|usage: some-command [options] <args>...
-|
-|    some-command does foo and bar!
-|
-|    -h, --help            show the help
-|    --foo                 some nifty option --foo
-|    --bar ...             some cool option --bar with an argument
-|    -b, --baz             a short and long option
-|
-|An option group Header
-|    -C[...]               option C with an optional argument
-|    -d, --data[=3D...]      short and long option with an optional argum=
ent
-|
-|Argument hints
-|    -B <arg>              short option required argument
-|    --bar2 <arg>          long option required argument
-|    -e, --fuz <with-space>
-|                          short and long option required argument
-|    -s[<some>]            short option optional argument
-|    --long[=3D<data>]       long option optional argument
-|    -g, --fluf[=3D<path>]   short and long option optional argument
-|    --longest <very-long-argument-hint>
-|                          a very long argument hint
-|    --pair <key=3Dvalue>    with an equals sign in the hint
-|    --aswitch             help te=3Dt contains? fl*g characters!`
-|    --bswitch <hint>      hint has trailing tab character
-|    --cswitch             switch has trailing tab character
-|    --short-hint <a>      with a one symbol hint
-|
-|Extras
-|    --extra1              line above used to cause a segfault but no lon=
ger does
-|
-|EOF
-END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspe=
c &&
-	test_cmp expect output
+	test_cmp "$TEST_DIRECTORY/t1502/optionspec.help" output
 '

 test_expect_success 'test --parseopt help output no switches' '
@@ -140,41 +104,12 @@ END_EXPECT
 '

 test_expect_success 'test --parseopt invalid switch help output' '
-	sed -e "s/^|//" >expect <<\END_EXPECT &&
-|error: unknown option `does-not-exist'\''
-|usage: some-command [options] <args>...
-|
-|    some-command does foo and bar!
-|
-|    -h, --help            show the help
-|    --foo                 some nifty option --foo
-|    --bar ...             some cool option --bar with an argument
-|    -b, --baz             a short and long option
-|
-|An option group Header
-|    -C[...]               option C with an optional argument
-|    -d, --data[=3D...]      short and long option with an optional argum=
ent
-|
-|Argument hints
-|    -B <arg>              short option required argument
-|    --bar2 <arg>          long option required argument
-|    -e, --fuz <with-space>
-|                          short and long option required argument
-|    -s[<some>]            short option optional argument
-|    --long[=3D<data>]       long option optional argument
-|    -g, --fluf[=3D<path>]   short and long option optional argument
-|    --longest <very-long-argument-hint>
-|                          a very long argument hint
-|    --pair <key=3Dvalue>    with an equals sign in the hint
-|    --aswitch             help te=3Dt contains? fl*g characters!`
-|    --bswitch <hint>      hint has trailing tab character
-|    --cswitch             switch has trailing tab character
-|    --short-hint <a>      with a one symbol hint
-|
-|Extras
-|    --extra1              line above used to cause a segfault but no lon=
ger does
-|
-END_EXPECT
+	{
+		cat <<-\EOF &&
+		error: unknown option `does-not-exist'\''
+		EOF
+		sed -e 1d -e \$d <"$TEST_DIRECTORY/t1502/optionspec.help"
+	} >expect &&
 	test_expect_code 129 git rev-parse --parseopt -- --does-not-exist 1>/dev=
/null 2>output < optionspec &&
 	test_cmp expect output
 '
diff --git a/t/t1502/.gitattributes b/t/t1502/.gitattributes
new file mode 100644
index 0000000000..562b12e16e
=2D-- /dev/null
+++ b/t/t1502/.gitattributes
@@ -0,0 +1 @@
+* -whitespace
diff --git a/t/t1502/optionspec.help b/t/t1502/optionspec.help
new file mode 100755
index 0000000000..844eac6704
=2D-- /dev/null
+++ b/t/t1502/optionspec.help
@@ -0,0 +1,34 @@
+cat <<\EOF
+usage: some-command [options] <args>...
+
+    some-command does foo and bar!
+
+    -h, --help            show the help
+    --foo                 some nifty option --foo
+    --bar ...             some cool option --bar with an argument
+    -b, --baz             a short and long option
+
+An option group Header
+    -C[...]               option C with an optional argument
+    -d, --data[=3D...]      short and long option with an optional argume=
nt
+
+Argument hints
+    -B <arg>              short option required argument
+    --bar2 <arg>          long option required argument
+    -e, --fuz <with-space>
+                          short and long option required argument
+    -s[<some>]            short option optional argument
+    --long[=3D<data>]       long option optional argument
+    -g, --fluf[=3D<path>]   short and long option optional argument
+    --longest <very-long-argument-hint>
+                          a very long argument hint
+    --pair <key=3Dvalue>    with an equals sign in the hint
+    --aswitch             help te=3Dt contains? fl*g characters!`
+    --bswitch <hint>      hint has trailing tab character
+    --cswitch             switch has trailing tab character
+    --short-hint <a>      with a one symbol hint
+
+Extras
+    --extra1              line above used to cause a segfault but no long=
er does
+
+EOF
=2D-
2.41.0
