Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2327A20188
	for <e@80x24.org>; Sat, 13 May 2017 16:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbdEMQAZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 12:00:25 -0400
Received: from mout.web.de ([212.227.17.12]:58013 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753989AbdEMQAY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 12:00:24 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MY6sm-1dVcav1Coi-00UrZf; Sat, 13
 May 2017 18:00:17 +0200
Subject: [PATCH 2/5] p0004: avoid using pipes
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Message-ID: <f6d4d434-1f55-ef7c-3c7e-55b56fe96361@web.de>
Date:   Sat, 13 May 2017 18:00:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8NbD6p2itgL3ngaJ6phY+mlI5/SxnIuNcSV4ULWHP2FpUB2jBCo
 UCOj8DPpgl/Tp/rg2t4lIpOUcUnRIrecAsKT1qG+niekfuIN3f1kUT4NS7a7Qz+4UPJz1mw
 1TUF7tHqn0j2KmL1S/TpaOpoIZoHLHEfkbDiicx3pBJMauS9yD8BPgVT4NJBSjO4B3cj/4Z
 KlkTloza41rP4S/hHvHbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HFxeMdpgCbY=:Bn/IPeLeAadCk3UMiBALrX
 v0mKmhZY9bTeI/wM/aLqnuvWBr9nvEROpfcE3vTEL5Bezyc/o/CUvx2S9FEjE4rxxCu/Cx839
 1+d4q9GSvBoy7sFT4bO6aC9vr5mSwAY8kTOYzdnsneUIQxl4CmQYRSMGYpSfCLCoojdkyrZRF
 l+ExtJtrvr/kpecUMNFwjAJu2h/2SkEs8SuXHQ5xqrNTW54FoK0sUy/qQV7hI8dZIQpQigm5J
 HXGKCjv8URF628bOQ0KD+AmbAEor2xyn9MKhrRYBx9KvXSB3+lRapjgr1zKe3StaXwLJJ1oFq
 8RE1ucJGwqSw4yAsBL9E2ZQWeBGJpvUxmoF5AziWLxMgJvKgeBYN7E+bIqRzIFznOiX+drDQv
 0N5LpglMgltNvlm0WJDLS9nGBW1rdLLf1bHHxHoaQc6/VmFrRJPSuxaf9FeDq/OMRw6mtHoh2
 25Vukvko3dYA3LZRteV/q4q5p9OMwcBIYOWcqt81fPb2Z2S45Tk0etXqsTw+YLtGbj5IPenFu
 Pbn6cJBnY7PWIv3BPAzFkPlxWy3gmT31WfIYd567WCvu/nB6KsCkMaYGU3g0dp6N7CVnOVPjy
 146I5m7MDzzjoFX9iFtlgmJQbAYscVTSD4ChLzq/ttndrdfhW5NU51KRCF88cpHyNNbIT3X1x
 6n0WnKjbfJZG1orHUHJezhBH5drR7J/wT1To0zlHvqFceYfFJYbuS19HAZu9movqruCguTDcS
 gRejDkhyy/DDGoCPVtXQWZoDMmWmsfJ4+FGoBikA8BpGQJoAgoUTeBQsFLusa3SJMXwcGgTfS
 Qaugf94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return code of commands on the producing end of a pipe is ignored.
Evaluate the outcome of test-lazy-init-name-hash by calling sort
separately.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/p0004-lazy-init-name-hash.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index 716c951553..576bdc3c4e 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -7,9 +7,11 @@ test_perf_large_repo
 test_checkout_worktree
 
 test_expect_success 'verify both methods build the same hashmaps' '
-	test-lazy-init-name-hash --dump --single | sort >out.single &&
-	test-lazy-init-name-hash --dump --multi  | sort >out.multi  &&
-	test_cmp out.single out.multi
+	test-lazy-init-name-hash --dump --single >out.single &&
+	test-lazy-init-name-hash --dump --multi >out.multi &&
+	sort <out.single >sorted.single &&
+	sort <out.multi >sorted.multi &&
+	test_cmp sorted.single sorted.multi
 '
 
 test_expect_success 'multithreaded should be faster' '
-- 
2.12.2

