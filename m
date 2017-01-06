Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356821FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967333AbdAFQXT (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:19 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46911 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967276AbdAFQXK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:10 -0500
X-AuditID: 1207440c-e53ff700000009a1-01-586fc46d00b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.00.02465.D64CF685; Fri,  6 Jan 2017 11:23:09 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX0023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:08 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 10/23] rename_tmp_log(): improve error reporting
Date:   Fri,  6 Jan 2017 17:22:30 +0100
Message-Id: <787c14104716cd4dc007076471a2ad17c437ccea.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqJt7JD/CYN12VYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKWPNpMVvBUvaKmVOPsTcwvmftYuTkkBAwkfh94Qkj
        iC0kcJlRYv+MvC5GLiD7BJPExm9/mUESbAK6Eot6mplAbBEBNYmJbYdYQIqYBT4wSvzqnMUO
        khAWcJbY/PAtWAOLgKrEsQV/wabyCkRJnNhymA1im5zEpW1fwGo4BSwkGnd9g9psLvFp4mHm
        CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBBjPDsZv62QOMQpw
        MCrx8EZ45UUIsSaWFVfmHmKU5GBSEuUNc8yPEOJLyk+pzEgszogvKs1JLT7EKMHBrCTC274X
        KMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuC9fxCoUbAoNT21Ii0z
        pwQhzcTBCTKcB2j4KpAa3uKCxNzizHSI/ClGXY4D71c8ZRJiycvPS5US57UHKRIAKcoozYOb
        A0sMrxjFgd4S5n0MUsUDTCpwk14BLWECWiLoCbakJBEhJdXAKBdsLL+tfuX76S/3Pgvv1tES
        tIibV/NOYJWgeKJD5ufrLFGhu87tf872zLTA98gbJXEXbdULvw5f6/ZoUDtt0rH+2/0XPuHy
        tvnZ+qt9o1lsXtjHcq0sr80ol1q1ctH7yJfbvWbx3C8KzNvd1pq0+x7TsiVfHrOK6InO4ug9
        63nJej3PcYs3SizFGYmGWsxFxYkAE+mHoecCAAA=
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

