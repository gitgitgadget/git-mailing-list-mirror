Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AED20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbdFWHCB (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:01 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50043 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754467AbdFWHCA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:00 -0400
X-AuditID: 1207440d-3e9ff70000001be7-1c-594cbce51e43
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E6.51.07143.5ECBC495; Fri, 23 Jun 2017 03:01:58 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5k001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:01:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/29] t1408: add a test of stale packed refs covered by loose refs
Date:   Fri, 23 Jun 2017 09:01:19 +0200
Message-Id: <4eca5010979e86fa25d95b68d3f266d7f74d168b.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPtsj0+kQXObssXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBlfpn9gLnjNV7Fwzlr2BsYuni5G
        Tg4JAROJL5vPs3UxcnEICexgkrj8ppkVwjnFJPHkRgsrSBWbgK7Eop5mJhBbREBNYmLbIRaQ
        ImaBScwSb68tBEsIC4RJdPZdYwSxWQRUJe486gZr5hWIkng9aTs7xDp5iV1tF8HinAIWEj0T
        l4PFhQTMJVb9Xs06gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdI73czBK91JTSTYyQ
        sOPdwfh/ncwhRgEORiUe3oSz3pFCrIllxZW5hxglOZiURHk1I30ihfiS8lMqMxKLM+KLSnNS
        iw8xSnAwK4nw6qwCyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHhb
        dgM1ChalpqdWpGXmlCCkmTg4QYbzAA332AwyvLggMbc4Mx0if4pRUUqcdwNIswBIIqM0D64X
        lhZeMYoDvSLMmwhSxQNMKXDdr4AGMwENnrEGbHBJIkJKqoHR/sRZh79uPxt11UX3nrc/oPp+
        54Rrx4XnzAxJOfSV4T1byqttx54VCy2wW6s/Re3sYa6rs8yqhJ6+XpcUJFvYVqqtJhHCszDT
        VDv84LE+j7dMV26dcqlTkvRh+Ok8Mahtvd1WxvcPKoTSbhX+v7Ekos36ktG8pe5P/A5rTZH5
        eOMW441XFZ8TlFiKMxINtZiLihMBiiNVC+YCAAA=
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
 t/t1408-packed-refs.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 t/t1408-packed-refs.sh

diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
new file mode 100755
index 0000000000..d3155be206
--- /dev/null
+++ b/t/t1408-packed-refs.sh
@@ -0,0 +1,46 @@
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
+	cat .git/packed-refs &&
+
+	git checkout --orphan another &&
+	test_tick &&
+	git commit --allow-empty -m two &&
+	two=$(git rev-parse HEAD) &&
+	git checkout -B master &&
+	git branch -D another &&
+
+	cat .git/packed-refs &&
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

