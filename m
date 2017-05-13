Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBBB520188
	for <e@80x24.org>; Sat, 13 May 2017 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbdEMP75 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 11:59:57 -0400
Received: from mout.web.de ([212.227.17.12]:59457 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754199AbdEMP74 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 11:59:56 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MV4TZ-1dWQoq0LLJ-00YQAb; Sat, 13
 May 2017 17:59:49 +0200
Subject: [PATCH 1/5] p0004: simplify calls of test-lazy-init-name-hash
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Message-ID: <02f4218d-857a-3615-cc3a-d03ecbf35e67@web.de>
Date:   Sat, 13 May 2017 17:59:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:CK5/adfDtqUj5MfkAvmo/9zkyb9iBssxQjb453nqkj17ak7ZDgq
 9p1GJbFIVeNkmZVhgKViLUFsUlU1ffoMHvV+8NMhWVUQVoUccoYkKO0aBL0YakFQme3G7S+
 l32v175mkZt+cOCmBach+fhvY60zKcOrPj59HXrx1Kc2UuapekpzoSBFsIKruJ1caya/8Xe
 5ED8c7kC2RJenqTx0oNxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:57kAJUHjhv4=:ongIpen8l5EBo5T4BgqjfQ
 wG6L+W9CiMquFVRurUNKJtAUzX7NDd7KDQfXudJSFIO4ZDPWICFhdkOyYW95GXYIHxIULrc3l
 EGvWJ5Nc5HDaB/Y/wpfFrGuxF0yhxN+SDEqy/sJkrItWsdUU+Cqe1GeNuoNS7xo5zdQMemWjb
 bet7T8OsAEFs3tqCdUSF1NdirLEaQeuuFBxO5gBGIBiWIylFaJRLlxj2DYXAuWRD3vivM8ybs
 6cSrv+qZbQfw+RJqreflY2pC/bjT1pruDV9kdx4kHrpGnS7X1//tzc/9j19W2uWpNPCVJGB+/
 MQT51pxfG0kQkDUGSUMzhGCe3JHKaLmstywDyVRMPtWzfcqIXraA0pkaUhmAO92fZNj5k2hT9
 w8man+EXwsoLtPBBo7lSlv/LuyQQB3oURXXl5YRhbUbTcrJQ2AcBkKFYvmqab8SxXPxPLUIw8
 LI/zx+B6NLOV3JH9MI0QKJaGdYr6At9AgApqSVjP2/47t/SPdUtE02Vcx8PR/xByTuVtDcnSP
 qhiAZBKw54u35cvzx/BLnzNqAbLwMy0TFvo4pZ46DxrYWWTp4+OKkAeccfG+ydVZ5xl0em7cC
 DGkPgvIjCzLCiW/XGuWG1wRjBkayQRaFe01Xgxfj30zNM3/lnAnv1eTBSJTmRpu6uyn3kdmGw
 WVPwiNmT4/PCTNZUqtsDhpdihpH5PxzocXdyLfuZ6f25+97ZO4uaL1F3hwxhflqRQItZGAHS1
 xlLXmHPEAZnptamrVUdRDfaiMfdXbwPqJhVvJhoAukKXf/YavlRbXmij0H/yY/A0Um2Wr0skC
 Gg+JT2b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test library puts helpers into $PATH, so we can simply call them
without specifying their location.

The suffix $X is also not necessary because .exe files on Windows can be
started without specifying their extension, and on other platforms it's
empty anyway.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/p0004-lazy-init-name-hash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index 5afa8c8df3..716c951553 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -7,13 +7,13 @@ test_perf_large_repo
 test_checkout_worktree
 
 test_expect_success 'verify both methods build the same hashmaps' '
-	$GIT_BUILD_DIR/t/helper/test-lazy-init-name-hash$X --dump --single | sort >out.single &&
-	$GIT_BUILD_DIR/t/helper/test-lazy-init-name-hash$X --dump --multi  | sort >out.multi  &&
+	test-lazy-init-name-hash --dump --single | sort >out.single &&
+	test-lazy-init-name-hash --dump --multi  | sort >out.multi  &&
 	test_cmp out.single out.multi
 '
 
 test_expect_success 'multithreaded should be faster' '
-	$GIT_BUILD_DIR/t/helper/test-lazy-init-name-hash$X --perf >out.perf
+	test-lazy-init-name-hash --perf >out.perf
 '
 
 test_done
-- 
2.12.2

