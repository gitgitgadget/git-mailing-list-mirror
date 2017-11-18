Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E675E201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966889AbdKRSKh (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:10:37 -0500
Received: from mout.web.de ([212.227.17.11]:53588 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966794AbdKRSKg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:10:36 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvXZ-1eIbXn44Gv-002TUW; Sat, 18
 Nov 2017 19:06:19 +0100
Subject: [PATCH 4/6] t7810: improve check of -W with user-defined function
 lines
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c89b1e5f-0145-ec93-c7fa-53fac1d429da@web.de>
Date:   Sat, 18 Nov 2017 19:06:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fjngfQFfBiLzwZunt2kCScKgKIE0F7JlowFwpP2XQEpEB9cP4eO
 5jTG5MJaPqHk9pFg6FmYg6qtLpawdj2JLOoUIy+LUkOkIGJTDcOjllnou3sDH42AwJIz2F9
 /GJzE8tL/76k7OvgU0j5uA+o9VZBLzoMBHlxrC7smmbqp6y5fI1EVhrMWeg3OrXLf9tPma4
 WWpOaJf+Z1V+fCOVSjdMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3sOgBzvKlMo=:amDNVTf+NQmv3YfZCmoMPf
 AbN8TRAo4RAu3EeB2cwSzK9Y/avwJoAyjUc2olzECeFfc2N5rdVuHw8eKLyD4gZ0xPAqdJIvQ
 /dXlCTJRbET7bZIoD0YHs/lDX6ron+PACL8IJ/sci3b61vhblssaNFOEvilmO7KbR87kws7jB
 dZbuAw2redz3zpcEVBzNh1pLvfafMUM207JI28mqR262AWuvk6qSmqSiQparJtz0dXkNmatMQ
 6PcHgNeSU/C70wghMRCnEgHYF1ug9gki727Orn5eSnzKyO863OPePc4rMEyw25RxyZ4N6aC4V
 UAoB8tpjnZR4zEwVn2DlgoynmShRyDKy60LSoftiGdMnO81HtRkQcYtoznSxBNRFiivllb+rE
 rb8yidTkEXySgdMnfyCZNz0VzlhJnFLL45/5Guji99He3BApLk4X2E7wXHZQ8qY2wqA2qmgxl
 aBt0qKpN/oZIomzCN80TnKRsVe5nKGo/I1/dXTKyjZVNX3giaRzye+GW0lKIT2RxuBKgrWe2p
 3T2QGvLTf1DfIQpB1tl83e8KR7rXupo/6NkEBv7vGMOUs6KoxCwWj5X5xxKkymBcc9RyrcIXi
 tKBSzJ/kPPLN1y5zKGCFZuPAB+2ponjw2hzLxzZTqu7jlgHK+debyzBB9wpzunf9XunkjnrhM
 22N1EUC1rZnzgEOcfuZI8Yc5FKATgBwR4zEpz2gYaDGk/7+znR8emo/GlY5BuTuXbd9C5pxVg
 cko/HXZrnWA7aTP3bjDdeWYc5+jMzD6X6kaGz+zHnlsNLkuTC76RIuEQDojXh/rU5WRFe7xAw
 pQ4rVj6GsI2vA7dzpep44n5xRb4COx8++s0JIQ7+NMQM2Gb2rHVkEzUt6b2FVvkK2f9nK0sxh
 G5+PrR+8B/H52zv7wmlu0cgW+FhFxLgVARrpUyVDcOg75ozzTNhQlS6+KBf6cjMSMVFnbuiJr
 3NSou+SJtQmGtGE1ooAtxM1OrlO/i4DKNe3hAVjYgYLTlnB1OX+Psr1Xfzn2ljI2ohki8qU2s
 ug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check for function context (-W) together with user-defined function
line patterns reuses hello.c and pretends it's written in a language in
which function lines contain either "printf" or a trailing curly brace.
That's a bit obscure.

Make the test easier to read by adding a small PowerShell script, using
a simple, but meaningful expression, and separating out checks for
different aspects into dedicated tests instead of simply matching the
whole output byte for byte.

Also include a test for showing comments before function lines like git
diff -W does, which is currently failing because that functionality is
not implemented for git grep, yet.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t7810-grep.sh | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 2a6679c2f5..632b905611 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -60,6 +60,18 @@ test_expect_success setup '
 		echo " line with leading space3"
 		echo "line without leading space2"
 	} >space &&
+	cat >hello.ps1 <<-\EOF &&
+	# No-op.
+	function dummy() {}
+
+	# Say hello.
+	function hello() {
+	  echo "Hello world."
+	} # hello
+
+	# Still a no-op.
+	function dummy() {}
+	EOF
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -766,18 +778,27 @@ test_expect_success 'grep -W shows no trailing empty lines' '
 	test_cmp expected actual
 '
 
-cat >expected <<EOF
-hello.c=	printf("Hello world.\n");
-hello.c:	return 0;
-hello.c-	/* char ?? */
-EOF
-
 test_expect_success 'grep -W with userdiff' '
 	test_when_finished "rm -f .gitattributes" &&
-	git config diff.custom.xfuncname "(printf.*|})$" &&
-	echo "hello.c diff=custom" >.gitattributes &&
-	git grep -W return >actual &&
-	test_cmp expected actual
+	git config diff.custom.xfuncname "^function .*$" &&
+	echo "hello.ps1 diff=custom" >.gitattributes &&
+	git grep -W echo >function-context-userdiff-actual
+'
+
+test_expect_failure ' includes preceding comment' '
+	grep "# Say hello" function-context-userdiff-actual
+'
+
+test_expect_success ' includes function line' '
+	grep "=function hello" function-context-userdiff-actual
+'
+
+test_expect_success ' includes matching line' '
+	grep ":  echo" function-context-userdiff-actual
+'
+
+test_expect_success ' includes last line of the function' '
+	grep "} # hello" function-context-userdiff-actual
 '
 
 for threads in $(test_seq 0 10)
-- 
2.15.0
