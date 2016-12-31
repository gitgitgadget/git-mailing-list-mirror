Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D5320956
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbcLaDNm (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:42 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55421 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754683AbcLaDNi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:38 -0500
X-AuditID: 1207440d-8b7ff700000009ba-a7-5867226171cf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id AF.21.02490.16227685; Fri, 30 Dec 2016 22:13:37 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uF010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:36 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 21/23] try_remove_empty_parents(): don't accommodate consecutive slashes
Date:   Sat, 31 Dec 2016 04:13:01 +0100
Message-Id: <c7a89febcbf7bdffb44f8fdf63a43f11339a0289.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqJuolB5h8O2skEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mg5P/85e0Mheced+B3sD41rWLkYODgkBE4nG225djFwcQgKXGSUuLJnFCOEcZ5KYf62f
        uYuRk4NNQFdiUU8zE4gtIqAmMbHtEAtIEbPAREaJaVsugSWEBaIlduxZDmazCKhKHG48zg5i
        8wpESezZPJMNxJYQkJO4tO0L2FBOAQuJxZ/6wOqFBMwl1u28xDyBkWcBI8MqRrnEnNJc3dzE
        zJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJDQ4d3B+H+dzCFGAQ5GJR7eBzfSIoRYE8uKK3MP
        MUpyMCmJ8lpapkYI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFdKJceIcSbklhZlVqUD5OS5mBR
        EudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuBdqAjUKFiUmp5akZaZU4KQZuLgBBnOAzS8F6SG
        t7ggMbc4Mx0if4pRl+PA+xVPmYRY8vLzUqXEedcqABUJgBRllObBzYHF/CtGcaC3hHlrQUbx
        ANMF3KRXQEuYgJao5SSDLClJREhJNTAqPnj5zSJ3BXeDPbNiZdIWIc/v8Y9ZJv/e/dR66lbJ
        D6+Sfika16y2X1yneqSXafKJCWy3+/1K/X5xLd760WLb/9PR9xhZm73mP94gIT3RJOxZzxQZ
        j+0sX7VXGs+Mf2q/NmKHqztPzG7/YgePiVFB2bdqvbexsC0QDBCct1OwIaJuxqR/x48qsRRn
        JBpqMRcVJwIAgTjU5NQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"refname" has already been checked by check_refname_format(), so it
cannot have consecutive slashes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index af5a0e2..397488e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2294,15 +2294,14 @@ static void try_remove_empty_parents(const char *refname)
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
-		/* tolerate duplicate slashes; see check_refname_format() */
-		while (*p == '/')
+		if (*p == '/')
 			p++;
 	}
 	q = buf.buf + buf.len;
 	while (1) {
 		while (q > p && *q != '/')
 			q--;
-		while (q > p && *(q-1) == '/')
+		if (q > p && *(q-1) == '/')
 			q--;
 		if (q == p)
 			break;
-- 
2.9.3

