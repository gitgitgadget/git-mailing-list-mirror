Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADAD42070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbcLaDNP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:15 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43001 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754570AbcLaDNO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:14 -0500
X-AuditID: 12074412-5f5ff700000009b5-13-58672248917f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 68.F7.02485.84227685; Fri, 30 Dec 2016 22:13:12 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6tu010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:11 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/23] t5505: use "for-each-ref" to test for the non-existence of references
Date:   Sat, 31 Dec 2016 04:12:42 +0100
Message-Id: <ee090187391ea0c7b39514698be8a7ed35a0c885.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqOuhlB5hcPmNmUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mi6cOc1cMJe9ou/jc6YGxha2LkZODgkBE4lbU+cxdTFycQgJXGaUmHBlMStIQkjgOJNE
        24FgEJtNQFdiUU8zE4gtIqAmMbHtEAtIA7PAREaJaVsugSWEBeIlVn7vYASxWQRUJTZ+/sIC
        YvMKREksmtgAtU1O4tK2L8wgNqeAhcTiT31MEMvMJdbtvMQ8gZFnASPDKka5xJzSXN3cxMyc
        4tRk3eLkxLy81CJdM73czBK91JTSTYyQ0BHawbj+pNwhRgEORiUe3gc30iKEWBPLiitzDzFK
        cjApifJaWqZGCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhXSiXHiHEm5JYWZValA+TkuZgURLn
        /blY3U9IID2xJDU7NbUgtQgmK8PBoSTBq6AI1ChYlJqeWpGWmVOCkGbi4AQZzgM0vBekhre4
        IDG3ODMdIn+KUZfjwPsVT5mEWPLy81KlxHnXKgAVCYAUZZTmwc2BxfwrRnGgt4R5nUBG8QDT
        BdykV0BLmICWqOUkgywpSURISTUwzlm806fWWN+t+N2p9uWRGyYIRp9keX/wi6PVIqPi/uNT
        J7ffmZfNMdUoxvHGrzXeHmuPxU99kuH75PHVcyeSgx3aN99jynkccfP3Kc8Jk6QlS3mj6oQ4
        CrdJ3BFJUU5cMH2mQkBz4CLl1bdLF/ivXCkQlOOWf94rsmTBgdPX8248m3Jzr6dvvBJLcUai
        oRZzUXEiAMvJij3UAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of looking on the filesystem inside ".git/refs/remotes/origin",
use "git for-each-ref" to check for leftover references under the
remote's old name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5505-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8198d8e..65030fb 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -725,7 +725,7 @@ test_expect_success 'rename a remote' '
 	(
 		cd four &&
 		git remote rename origin upstream &&
-		rmdir .git/refs/remotes/origin &&
+		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
 		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-- 
2.9.3

