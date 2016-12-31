Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E82B2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbcLaDNZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:25 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47943 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754626AbcLaDNU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:20 -0500
X-AuditID: 1207440e-7dfff700000009ec-1c-5867224d520d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B0.C9.02540.D4227685; Fri, 30 Dec 2016 22:13:19 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u0010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:16 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/23] lock_ref_sha1_basic(): inline constant
Date:   Sat, 31 Dec 2016 04:12:46 +0100
Message-Id: <811abb3cd507ed7bc0a288bebbf7f0e4d9a2cd37.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsUixO6iqOuvlB5hcGKrjEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mv5dPMxWcISjor9/PXMDYxt7FyMnh4SAicTp7n7mLkYuDiGBy4wS8/69Y4VwjjNJ3L11
        hg2kik1AV2JRTzMTiC0ioCYxse0QC0gRs8BERolpWy6BJYQFHCQOPHkB1sAioCrR3/UGLM4r
        ECWx9toeJoh1chKXtn1hBrE5BSwkFn/qA4sLCZhLrNt5iXkCI88CRoZVjHKJOaW5urmJmTnF
        qcm6xcmJeXmpRbrGermZJXqpKaWbGCHBw7eDsX29zCFGAQ5GJR7ejmtpEUKsiWXFlbmHGCU5
        mJREeS0tUyOE+JLyUyozEosz4otKc1KLDzFKcDArifAulEuPEOJNSaysSi3Kh0lJc7AoifOq
        LVH3ExJITyxJzU5NLUgtgsnKcHAoSfAuVARqFCxKTU+tSMvMKUFIM3FwggznARreC1LDW1yQ
        mFucmQ6RP8WoKCXOu1YBKCEAksgozYPrhUX3K0ZxoFeEeXeBtPMAEwNc9yugwUxAg9VykkEG
        lyQipKQaGHu+aSQ//9n10+iceCB3UP8m892ZhWtOTHRlO7jMeLuFG0ek2ZEPR9NXpjolHOQ7
        oeuy8p+wwOK0mY+OGL25EvV5yTTO1abyDAyJtdtUf8WlcV4K0Z1/9gCTbzNr/p3Hp6X/qd++
        dtJKMfN4WmQKQ+nkcIPtt5en/rix6rXoJ7eDK2auqV+9mlGJpTgj0VCLuag4EQAVhh+uyQIA
        AA==
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

