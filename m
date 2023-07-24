Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9AFC0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGXMio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGXMin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 08:38:43 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1087E4E
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690202318; x=1690807118; i=l.s.r@web.de;
 bh=KeMwsfXHsn+Xwmw/6VQTFU072VTn8A2xSW6+bP2utws=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=ZmGR55Jh2go6MrvGMDHN8YkyKTt9Nb5NedSm0gMbBkbdCgh4utBTA53NAeLc27aoJD3HsSD
 15Cq9BpOINqP9n7X+SdivRPNIIgW4UQTvVdXpjitLO7PuKtdXMiklwiVuw9Em0+tbZriPNXl9
 gnIfuZFSput6nuA89ee3J90RE6SDQxuZ+GD0RtmgiZsyhuU65fquW6qD2Am63FQHTI/ePbhIL
 CQ3c4ihLugTOP3Wc3E5PsdLvfMBG93Vlf8rylokagq2fK4K2Z7oJcmgZ2XS+kTCYeXM0++BVj
 gd1T9NSZHVlty6GuYOr3fw5SAa3F4n4/HbP9keePqeU0a3B0Wc2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJNT-1qVFDV2B5L-00S5Xx; Mon, 24
 Jul 2023 14:38:38 +0200
Message-ID: <c4840046-118a-cadb-a0b2-3fd7081778a6@web.de>
Date:   Mon, 24 Jul 2023 14:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH v2 3/5] t1502: move optionspec help output to a file
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
In-Reply-To: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lkce4Bs7vXB6DlniU1ClNGHr6bEyRJtQZAE/ASrYRlj9X2qx5VD
 DpguNYHv4kctq8UcBtnW8Oxo5zs2V1IJYxX2D/LfH6j7WrugpuZr+CduuZMIy6YRSxDrg9P
 NffY4HVklcPzJKvSxLL3tyYSauQfuIxaL4nVXdjZi2d/QnfelEloJ6IBzqubscp85hDH668
 CNZF6HLLFonTeHxV1KYJQ==
UI-OutboundReport: notjunk:1;M01:P0:b3KnM48c8bw=;bBZP48BgUw3K/fu7o24/g1CZW+u
 970bN/1XoRLrYwYsGgw5x1FAQaR0LwOqWL6dMtIosFWi/Tv5vnEtJ1jWqEE5+89BhvbpvQKIJ
 BjjOwinMsGRD5dW2tWWjQBxoMnPqIRbmC4NsJ++kIkpK1NiCSHkr+g2Bx51QHqY855XW7jGJh
 yBGCFOL8e/QBP9zOy6vlaBrZp88BHKJwAT70moB7HTsJ0mTmRBZM25rG+kbXSI6sU/jczNDjd
 2nKpbOM6Tkf33E6c9pi5BOtUP5/apFnsF9yCj86RdUCLwaA4swh8ADAZQ2gHlDJi8K849/Wyk
 HUvzSkBQMy/8/WfMdmL+A6Sdsk7abqJBBp16bPBPpj466nzqAIMEd8h16zI1ubHCw31LXd0By
 vXRvAU6co31dKigGK09VdUksTsvX9cMjmNjHvc4Pn3Jk/0BSigR5e5AHpzaY7rwjYM0GRsOWh
 dthBR7ZLQJ3FCAJGm3R27+kfqRftO17AK4UPKMFrrldLbQh2xzQBUb+N9cn/2WXgVKpqJ5f7M
 GdvORcIEQk99MKeVvBbsCCZR8uXF3XkYzlXjofCEXFNYWLjYITLZ8yuitiq0pKE5y0MWX7mdZ
 KtMuKoEikPZoZzcgPueB1PNpZ3tJlehmFsGwFygB6dkcvMgPX3X/7hDS23YY3y4LZPJjCmzLp
 GdKGMy/Ki7COvGix8EzsA23L8b7kLnhzjQRmwPEB7KO/47jMKouviec50E/tiBy2DMkaV68PE
 Ah6cKVZ35lD3ai7jRInMl/9KvkxCwzmaf+AycXdfEcaexLOGqJKiO9QsVu47Xm0OrYi2W5xX6
 eKuqtPAIhR9OjuyjcgHKEh8G9G4k9FgoYZi1fO6XMqUVOz1HEOX98WuZapJ0eG2lr3qA5N0Ej
 x50Qw85hKzviQHZg1jn6aKmMSU6sqdXh4bzqGX7Ocv3l5eNeD5rgMEqxhEKzJD8k3jlVcodbJ
 t3W1Ig==
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
to keep its spaces intact and wouldn't want a stray --whitespace=3Dfix to
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
