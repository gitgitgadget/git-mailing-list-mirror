Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E08202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbdCHPoK (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:44:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:52597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbdCHPn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:43:56 -0500
Received: from virtualbox ([37.201.192.247]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO7im-1cr9X239T2-005YZs; Wed, 08
 Mar 2017 16:43:36 +0100
Date:   Wed, 8 Mar 2017 16:43:34 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] Demonstrate NULL pointer access with invalid
 GIT_WORK_TREE
In-Reply-To: <cover.1488987786.git.johannes.schindelin@gmx.de>
Message-ID: <c107001ff39e41314e86af3612922f687eb73dd4.1488987786.git.johannes.schindelin@gmx.de>
References: <cover.1488987786.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gbAN4HKdU1HKYPcsTCLUJcYufd3OOto85vMx7lrihWFXlxDjD8W
 Yo6dO/3se/BpthhwY+hRmXCmefP0WOf1I81/EAHVmz7TKzBObGIYgSB8cVyabl/tBqMRJtU
 PXkrvAWnqFe75LVlAkHzZv6iHN1X6X/mQ3rOXVwRZMN8bzj9fgMdNn9lLoquAOoHgV/UFL1
 7nK8b47hpY6H3gmPTTVMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cbtfUoEiW9s=:eDLNzNNvXLiN1pvvwPCOY+
 FVvCRE1q72Hod8Ec5DgVZna+CaJ/5i7DYrfFeKEbu6tcH6O0OM+GnVzBpI0oXP/S101puqO9P
 Y/X9zWjjWjOjBY9o0QtygBnIXBAVi0M/BdTfkN+6yYBHYB8nMQSu+xOH3nymDWzoL1xFg9arL
 3dNEpRO1eprsLBM+DPXm0reD1nPcfKN3LKETrKV2DswsLJJXhLTFjdklklY+1kCP1ZDLpzifx
 6cvLXnQ6iOExqUfq7hw8nawbMzoIVXn2aUSOIelntaWgzUJnHzmctuHT1momfU7KA+bbQIrrN
 8UF8AqX9Gh0zg2Y04vzT5jE9sX6eAfdxVizpI0lFXmCIFl+0q/P/VcANuwesey+CIJnLmPQF7
 +uV7Samk4HKAJuRE2hX4nC7DfVaschqCSwUZThHY2E57GhwMfUjxoCo79DlHbxusIqoOIF+28
 i/6UZCvZ7hMn4fWXJdbyACyZXVcbWKU5wzHfrtFHSY8jGnFW+SGyFFE6ob3E4uOOOKKWzGpV1
 +2T6dtfWeg9bNcu8p1Kati6NemyK3dUOcdW45ZK5xyYdMQFqO/UsqeVA55joYd8kHgXCU2H+X
 3l5vNWyBDFwf1Fd6GkW371xnbGhTCtfevgxBo0VG4zBz6RnrPra+PWdBxndGsbcHkUt+dmA75
 P5NA+wstuvqZoduDdXPCAxhQidSvKRsiTol6D3Uqtyg0YkV2EQbSnRj1Hx07IFP9xKvvb2WCp
 pQInCrlLiH+HXQ+8ZyV6dyo14UMOvZsCpAD+eafHMHl8xoBOMgFuft6BChhFJrV63XUV+3VXK
 8UmNp30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When GIT_WORK_TREE does not specify a valid path, we should error out.
Not crash.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1501-work-tree.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index cc5b870e587..046d9b7909f 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -423,4 +423,12 @@ test_expect_success '$GIT_WORK_TREE overrides $GIT_DIR/common' '
 	)
 '
 
+test_expect_failure 'error out gracefully on invalid $GIT_WORK_TREE' '
+	(
+		GIT_WORK_TREE=/.invalid/work/tree &&
+		export GIT_WORK_TREE &&
+		test_expect_code 128 git rev-parse
+	)
+'
+
 test_done
-- 
2.12.0.windows.1.7.g94dafc3b124


