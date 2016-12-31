Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348522070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbcLaDOI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:14:08 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55417 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754627AbcLaDNW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:22 -0500
X-AuditID: 1207440d-8cfff700000009ba-99-58672251c594
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.21.02490.15227685; Fri, 30 Dec 2016 22:13:21 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u3010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:20 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/23] rename_tmp_log(): improve error reporting
Date:   Sat, 31 Dec 2016 04:12:49 +0100
Message-Id: <8fc817feaf8d76980ea33b19a4529a2ed440095e.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqBuolB5hMH2vlEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4MtZ8WsxWsJS9YubUY+wNjO9Zuxg5OSQETCTOPzzL1MXIxSEkcJlR4tOmnewQznEmicNf
        vzGBVLEJ6Eos6mkGs0UE1CQmth1iASliFpjIKDFtyyWwhLCAs8TUZx/BbBYBVYkXt66A2bwC
        URL7Oh+wQKyTk7i07QsziM0pYCGx+FMfWI2QgLnEup2XmCcw8ixgZFjFKJeYU5qrm5uYmVOc
        mqxbnJyYl5dapGukl5tZopeaUrqJERI8vDsY/6+TOcQowMGoxMP74EZahBBrYllxZe4hRkkO
        JiVRXkvL1AghvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwL5dIjhHhTEiurUovyYVLSHCxK4rxq
        S9T9hATSE0tSs1NTC1KLYLIyHBxKErwLFYEaBYtS01Mr0jJzShDSTBycIMN5gIb3gtTwFhck
        5hZnpkPkTzHqchx4v+IpkxBLXn5eqpQ471oFoCIBkKKM0jy4ObCof8UoDvSWMG8tyCgeYMKA
        m/QKaAkT0BK1nGSQJSWJCCmpBsZYsQ75w0qKXcc2KO6sTEj/fOegJ1tFt5V9GOMb7u36NvUv
        VDsbXHbXXEua3RfxXCfFOCDnuOL9YxfPhLhe+eo2ZeLF9iTrX7JfmxylbJY7q3NzmVdW8h/y
        zC1rfnHOTuSV64yLGy/pbPL7IXYn4Lx/2W19wQSD7q6Xu1O7P25qLw2/Y9drocRSnJFoqMVc
        VJwIABfWjt7VAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Don't capitalize error strings
* Report true paths of affected files

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3f18a01..49a119c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2518,10 +2518,11 @@ static int rename_tmp_log(const char *newrefname)
 	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
 	if (ret) {
 		if (errno == EISDIR)
-			error("Directory not empty: %s", path);
+			error("directory not empty: %s", path);
 		else
-			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newrefname, strerror(true_errno));
+			error("unable to move logfile %s to %s: %s",
+			      git_path(TMP_RENAMED_LOG), path,
+			      strerror(true_errno));
 	}
 
 	free(path);
-- 
2.9.3

