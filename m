Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5B11FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967408AbdAFQX2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:28 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48251 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967288AbdAFQXL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:11 -0500
X-AuditID: 12074414-78bff70000004a85-b4-586fc468dbf2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E1.EF.19077.864CF685; Fri,  6 Jan 2017 11:23:04 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWv023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:02 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 07/23] lock_ref_sha1_basic(): inline constant
Date:   Fri,  6 Jan 2017 17:22:27 +0100
Message-Id: <7649c885fc567b44fbf1a858a6a69e7850357b9b.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqJtxJD/CYNd0GYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DK+HfxMFvBEY6K/v71zA2MbexdjJwcEgImEnffTWfq
        YuTiEBK4zCgxfe4nKOcEk8ScpuWMIFVsAroSi3qamUBsEQE1iYlth1hAipgFPjBK/OqcBTZK
        WMBBonvqZaAEBweLgKpEwz4LEJNXIEpi3xsViGVyEpe2fWEGsTkFLCQad30DGy8kYC7xaeJh
        5gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISXyA7GIyflDjEK
        cDAq8fBGeOVFCLEmlhVX5h5ilORgUhLlDXPMjxDiS8pPqcxILM6ILyrNSS0+xCjBwawkwmt3
        CCjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTB23gYqFGwKDU9tSIt
        M6cEIc3EwQkynAdoeAdIDW9xQWJucWY6RP4Uo6KUOO8WkK0CIImM0jy4Xlj8v2IUB3pFmLcH
        pJ0HmDrgul8BDWYCGizoCTa4JBEhJdXAqLCbTWBJ0pTf7JeLd0zbccHsWNiWlt4rnzrdXDmr
        hfp2rTuQ+YMlJvzsb0O1zGnRlfd9Mry/yf/UmKX7ZcOnzuPR3p8bH81d/mfSo1t/59rFbXxk
        FiXPsIrXXko4TvrwieISX8/IR1+VP1gaHc67bK76sPV93jnvi2aKTds8hbPlDsqumVndp8RS
        nJFoqMVcVJwIAJuYEIPaAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`lflags` is set a single time then never changed, so just inline it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index be4ffdc..7d4658a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2000,7 +2000,6 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int lflags = LOCK_NO_DEREF;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int attempts_remaining = 3;
@@ -2083,7 +2082,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (hold_lock_file_for_update(lock->lk, ref_file.buf, lflags) < 0) {
+	if (hold_lock_file_for_update(lock->lk, ref_file.buf, LOCK_NO_DEREF) < 0) {
 		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
-- 
2.9.3

