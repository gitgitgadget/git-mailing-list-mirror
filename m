Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00356C04A6A
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHEOiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEOiD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:38:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12599E7
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691246275; x=1691851075; i=l.s.r@web.de;
 bh=rg3hHKbmblaAqeFHejpMjna9demRDMkie2ad6duprgo=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=I3qOhPGKqO/1EVddGrvHDoWGB7stONt7CzQkJku2UszR6JRWd11GVdSD0+Fe/VkplXf88w6
 PpnB9cJOeMCOOt4JY6Taoaduq7zLJ8IIashtezLquNzWFlxBRnB/b2yT5tLt4NpHCAjbWhp/F
 JNB6689iGyh+exRc/4Khv6NGPt+DFzwg32lsJXVICafhrc9i8VBHJwtglyoDp1tdtT8Wsf5HL
 dFuzmJJFjV2ihf8NC1ovmvvKCJXbJiU8sATF3lfWTeECGfmSxlDudQJY2I9fnQjLb5NdLltfl
 7WyFe31WVqygNLSjNMmxLxcMyDkzbNRigtT/lZF3F8kCX9d3R6aA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mxpmc-1pc5LJ3MAo-00zF6L; Sat, 05
 Aug 2023 16:37:55 +0200
Message-ID: <b8339723-ce30-b87e-041f-eb4c130c2fb1@web.de>
Date:   Sat, 5 Aug 2023 16:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 2/8] t1502, docs: disallow --no-help
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
X-Provags-ID: V03:K1:h103kZbPBwbumsUi2R2F9tkJdLzRyiMeoysKoOSEEJcBJXjzo4S
 7450KmhSwe5O811Jkzu0ov3C+7QQSQsg2bBrQZr39yTqps/t+cBZwGNXwrNPyGy6uPsUbx5
 6jr9jPkrXmdJLX0p/rzYOQBrHpWm3mwQ+P/nyA9YmDdpWOHgdLOb7aKkITBcHibfoXjnErS
 r4MvGRGejtQJi2t4CNevg==
UI-OutboundReport: notjunk:1;M01:P0:YWGGAp4UmyI=;cScmKGjczRot+7QNXvYdBnyNO97
 kaY1ValG6HcQ0OaZud3n6uJFIHgYEBcnxjOfjj7S4LIvgeKKBdEV/5zI1KUyniygkFc7QnJZC
 aVmiS4DNE1Hk04IWYKGXMeTc9FBcwEV4I0hlA7vNgHdrbTlpmXPtg5qrwcqAILz2lViSy+iWB
 oIepqMJJxa1OjbrO2jogvnsoMP3FAG6v87I2GlKw9H+ZWi93uqlZssz9NeBhDjfUwammFcYmM
 vAHGAdzJ1Wg4/r+M+6G5eCbLdqZdMc57JTC/ytvrXOCrE67JU0MOECHd6frqVXt03hFbIDMtl
 Z0w/Us9WuTf8nzGNDHIE0HwB1tJ3dlTaWF/z7+mAK65zLShW+T/9veTQg023lbgBb5A2eOMa2
 hTSGRls9nXpG8D07BlB/ilQXy1KpXaqfkhtzVCnma9i2U0wP37fIMLtz8bh5pouTxUzcJW6j4
 3pE/JSxTxKvExwtVI1ybzEAdW826nzTNg5ogfj/uz7picxnpxAl617irifiqQh/mOMVjG/SBz
 68pwOoxTeoVk+lzAzgVYX8AoO1r97ou5HnmL+fJPcW09Y8E8SbtckJ3tmyOdnjPR/quzloNuS
 hqYbfIsco/PhvHV02qacDsTxVZoEfjeaJs2xHpEs1jS3stYZRfNaIZRuvEbw9AZ1JGOdAGR7h
 ksp6poIO2Gui5nV1OWC1xaFcUHiVuGgwx2Mt8Lp4Z/rvAM4GEofs1z1lBenx0xU8oJt2M2rEP
 6DHMvBZEnqNEaEOGcwnpvyYj3mfGQ3lldwsHTsPGzSwGuxuTs55P2+Tm69lUBepXml8qjyAau
 8BwnMP+IfEISVdNHPR2RqhcgqMlgMxEYP1xiv466cD739sn8O9NtAKYZofw/tqgI2jdF4yDRd
 XmbVJFweq4IyiCuxliH9dq9R9pAZ74HflihVawEk1FcB3rgDC1Cg8G5qqQ9aJlCCm4O3sIIcA
 3rmbEA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git rev-parse --parseopt" handles the built-in options -h and --help,
but not --no-help.  Make test definitions and documentation examples
more realistic by disabling negation.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-rev-parse.txt | 2 +-
 t/t1502-rev-parse-parseopt.sh   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse=
.txt
index f26a7591e3..6e8ff9ace1 100644
=2D-- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -398,7 +398,7 @@ some-command [<options>] <args>...

 some-command does foo and bar!
 --
-h,help    show the help
+h,help!   show the help

 foo       some nifty option --foo
 bar=3D      some cool option --bar with an argument
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index dd811b7fb4..0cdc6eb8b3 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -9,7 +9,7 @@ test_expect_success 'setup optionspec' '
 |
 |some-command does foo and bar!
 |--
-|h,help    show the help
+|h,help!   show the help
 |
 |foo       some nifty option --foo
 |bar=3D      some cool option --bar with an argument
@@ -288,7 +288,7 @@ test_expect_success 'test --parseopt help output: "wra=
pped" options normal "or:"
 	|    [--another-option]
 	|cmd [--yet-another-option]
 	|--
-	|h,help    show the help
+	|h,help!   show the help
 	EOF

 	sed -e "s/^|//" >expect <<-\END_EXPECT &&
@@ -322,7 +322,7 @@ test_expect_success 'test --parseopt help output: mult=
i-line blurb after empty l
 	|line
 	|blurb
 	|--
-	|h,help    show the help
+	|h,help!   show the help
 	EOF

 	sed -e "s/^|//" >expect <<-\END_EXPECT &&
=2D-
2.41.0
