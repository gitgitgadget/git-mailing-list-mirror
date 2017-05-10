Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E9C20188
	for <e@80x24.org>; Wed, 10 May 2017 16:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbdEJQOg (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 12:14:36 -0400
Received: from avasout07.plus.net ([84.93.230.235]:40922 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdEJQOf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 12:14:35 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id JgEY1v0071keHif01gEaQX; Wed, 10 May 2017 17:14:34 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=HP2zLslv c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=QkUOtHvLYzltmqQDersA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t6134 test failure in 'pu'
Message-ID: <361a3331-4d48-9ad3-42d4-3bf4b97dca22@ramsayjones.plus.com>
Date:   Wed, 10 May 2017 17:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

t6134 fails for me in 'pu', but I think it is just a question
of merge 641f3ad90a3 dropping the last line of the test from
the change introduced by commit bdab972153.

In other words, this fixes the test for me:

$ git diff
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index 6d5df294a..c67066840 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -26,6 +26,7 @@ test_expect_success 'error message for path inside submodule' '
 
 test_expect_success 'error message for path inside submodule from within submodule' '
        test_must_fail git -C sub add . 2>actual &&
+       test_i18ngrep "in unpopulated submodule" actual
 '
 
 test_done
$ 

Thanks!

ATB,
Ramsay Jones

