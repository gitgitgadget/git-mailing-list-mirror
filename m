Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44053207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 01:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965303AbdD1Bxo (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 21:53:44 -0400
Received: from avasout08.plus.net ([212.159.14.20]:33597 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938480AbdD1Bxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 21:53:43 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id Ddtg1v0031keHif01dthoH; Fri, 28 Apr 2017 02:53:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=uB7kYdrsbqqjdOBfUUAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in path'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        GIT Mailing-list <git@vger.kernel.org>
Message-ID: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com>
Date:   Fri, 28 Apr 2017 02:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit cf9e55f494 ("submodule: prevent backslash expantion in submodule
names", 07-04-2017) added a test which creates a git repository with
some backslash characters in the name. This test cannot work on windows,
since the backslash is used as the directory separator. In order to
suppress this test on cygwin, MinGW and Git for Windows, we add the
BSLASHPSPEC prerequisite. (see also commits 6fd1106aa4 and c51c0da222).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I built v2.13.0-rc1 and ran the test-suite on cygwin this evening and
had an additional failure, over and above the failures reported for
v2.13.0-rc0, namely t7400.20. This patch elides that test for cygwin
(and MinGW and GfW, so it would be good to hear success reports from
both Johannes).

Thanks!

ATB,
Ramsay Jones

 t/t7400-submodule-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c2706fe47..0d83153f3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -273,7 +273,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	test_cmp empty untracked
 '
 
-test_expect_success 'submodule add with \\ in path' '
+test_expect_success BSLASHPSPEC 'submodule add with \\ in path' '
 	test_when_finished "rm -rf parent sub\\with\\backslash" &&
 
 	# Initialize a repo with a backslash in its name
-- 
2.12.0
