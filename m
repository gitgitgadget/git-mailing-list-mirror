Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1787920373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbdCMULv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:60165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbdCMULt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:49 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4jbN-1c2GJN3Eqb-00z0OG; Mon, 13
 Mar 2017 21:11:40 +0100
Date:   Mon, 13 Mar 2017 21:11:26 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 11/12] t1309: document cases where we would want early
 config not to die()
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <6ee7c8c03f0f537a8ad9da733be1494fbf2e498d.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lK1RJkHGqW3dGxPCudpxoiKmKHZV/YegQ5RBCe3XXXCadbllGrz
 C57ui7Bu50TmOn6Ila13MlM3H2Qar5/1lJl1F4A6X5PMNnBfWyNLtidKGFWCIINUuux60Yu
 upoEMU/azcs7bR45H9M9Ap3vDUvKqcWCrvEeRTbxEa4PAIPYDgOEJKah0QFSc7btrIriGnA
 uYL297OjfQgRY5xHwRn9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NUT2PUJm59M=:a8i97wkJp0PSTU3C7P26Kj
 x3dGrWFdQTpEbHW6rh47NE/vpEqhUl/CX+HCvub27cHAOjfQfU8IFsnc5V8PN4BThvf0BDVgK
 erJEPSPmxOHxmWDD/5AYdugnIVlYkpFjpbuPFP/LcYGLzC/SRblkyAPQQVb94Va+QcRr39jSx
 qi9INRVQClBwmVpznaM9yk4Vw9I07f6QA1nitCHPX/U/7lFK/J3c/dqDZyEjbaS6aH3cBH9vE
 nxUBV/bMhR/GdNd1Qd0cFZkBGu0iIHU0WefPzX+PDSiGW+nukhZjhks+H5I62RFB4zJdn00gC
 qiApf4cx7Q/hKVukkOqp1s44Zcg0rqd6nbEARJFLPEupylOcUYEJti6my7wDyFg6GMIeZ1HQv
 EZfh52cdDp8SqZoNrBRVVsVyqF0TMVs/345KWAdMXhdEQBSkHo0cCiPU3g9ITu2gR6BGQFrpt
 80pF/g4kPH7NhDGgZcSTN7kHDiuhjSalzM1o/BqKgDVtwwl4h1f5bLVaz7uJeAfsba+eP7ync
 PPTZQ2ZPQ+3C3izmCoZ9gb65XCijkrUfeuWhKmVlNCfZtAn4Tcf+pnuzuAItQw1EjiKqmJ/tL
 OGDIebLawlSe4vqkToZxOr3ea011OKuD4a9MmhaVsFhGPTeiMVztCgylZbaqG/yevN7d4u9+d
 MU8WCHcccXUCzLYOlnUXQamBQvedP4LWUboVY392LdlDPw1Z48NuytO1mpucFoGHOVqyh+U8y
 UBwEUaMnE1+jkwVVVbWbtQC7FZCOvTSNBV3Du0MjinifqqDydfrbSdwntJQjlSTtpW6JGSEk3
 C7HnX7o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King came up with a couple examples that demonstrate how the new
read_early_config() that looks harder for the current .git/ directory
could die() in an undesirable way.

Let's add those cases to the test script, to document what we would like
to happen when early config encounters problems.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1309-early-config.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 0c55dee514c..027eca63a3c 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -47,4 +47,29 @@ test_expect_success 'ceiling #2' '
 	test xdg = "$(cat output)"
 '
 
+test_with_config ()
+{
+	rm -rf throwaway &&
+	git init throwaway &&
+	(
+		cd throwaway &&
+		echo "$*" >.git/config &&
+		test-config read_early_config early.config
+	)
+}
+
+test_expect_success 'ignore .git/ with incompatible repository version' '
+	test_with_config "[core]repositoryformatversion = 999999" 2>err &&
+	grep "warning:.* Expected git repo version <= [1-9]" err
+'
+
+test_expect_failure 'ignore .git/ with invalid repository version' '
+	test_with_config "[core]repositoryformatversion = invalid"
+'
+
+
+test_expect_failure 'ignore .git/ with invalid config' '
+	test_with_config "["
+'
+
 test_done
-- 
2.12.0.windows.1.7.g94dafc3b124


