Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8FD20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdGASbV (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:21 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59121 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751919AbdGASbT (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:19 -0400
X-AuditID: 1207440c-c4dff70000001e54-02-5957ea754f4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C3.2E.07764.57AE7595; Sat,  1 Jul 2017 14:31:18 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBE010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:15 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/30] t1408: add a test of stale packed refs covered by loose refs
Date:   Sat,  1 Jul 2017 20:30:39 +0200
Message-Id: <4b60931d1aa472b0e25450eb6e9ef70d5b11ff6a.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqFv2KjzS4NN9U4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDKuH3/KUrCar2Llu1lMDYw3uLsY
        OTkkBEwkln2cz9bFyMUhJLCDSWJJ8wp2COckk8S7w5vZQKrYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVhCWCBMYtHjdqAEBweLgKrEzUc8IGFegSiJvS2/WSG2yUvsarsIZnMKWEj8
        aVvPDGILCZhLNB/sY5nAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5miV5qSukm
        RkjQ8exg/LZO5hCjAAejEg/vhpCwSCHWxLLiytxDjJIcTEqivCuvhUYK8SXlp1RmJBZnxBeV
        5qQWH2KU4GBWEuHNfR4eKcSbklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQ
        kuBlAkaXkGBRanpqRVpmTglCmomDE2Q4D9DwhXdBhhcXJOYWZ6ZD5E8x6nK8mvD/G5MQS15+
        XqqUOG/rS6AiAZCijNI8uDmwZPGKURzoLWHeiBdAVTzARAM36RXQEiagJcIzQkCWlCQipKQa
        GENPPt30THvXnAVSaR8S7khvsbH8Ob38lFTm9/OHnPdOe1C+q+yV2G3h0xoSx2dm6m8s8q0L
        E1Nec4fHXf9WR96hqnlXZf/JZHOo3+2wfHOJw3h6+5S/V1/YHp2isXeZe+Q1p4eGKQdSKo9V
        i/f9083TZohiV0r7ueSsdkh/huSEjUW5i7c/51FiKc5INNRiLipOBAA59KT58QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It is OK for the packed-refs file to contain old reference definitions
that might even refer to objects that have since been
garbage-collected, as long as there is a corresponding loose reference
definition that overrides it. Add a test that such references don't
cause problems.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1408-packed-refs.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 t/t1408-packed-refs.sh

diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
new file mode 100755
index 0000000000..1e44a17eea
--- /dev/null
+++ b/t/t1408-packed-refs.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='packed-refs entries are covered by loose refs'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	git commit --allow-empty -m one &&
+	one=$(git rev-parse HEAD) &&
+	git for-each-ref >actual &&
+	echo "$one commit	refs/heads/master" >expect &&
+	test_cmp expect actual &&
+
+	git pack-refs --all &&
+	git for-each-ref >actual &&
+	echo "$one commit	refs/heads/master" >expect &&
+	test_cmp expect actual &&
+
+	git checkout --orphan another &&
+	test_tick &&
+	git commit --allow-empty -m two &&
+	two=$(git rev-parse HEAD) &&
+	git checkout -B master &&
+	git branch -D another &&
+
+	git for-each-ref >actual &&
+	echo "$two commit	refs/heads/master" >expect &&
+	test_cmp expect actual &&
+
+	git reflog expire --expire=now --all &&
+	git prune &&
+	git tag -m v1.0 v1.0 master
+'
+
+test_expect_success 'no error from stale entry in packed-refs' '
+	git describe master >actual 2>&1 &&
+	echo "v1.0" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.11.0

