Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1D71FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933145AbdCaOLg (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50187 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933135AbdCaOLf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:35 -0400
X-AuditID: 1207440e-cb3ff7000000340b-b7-58de63946941
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 62.69.13323.4936ED85; Fri, 31 Mar 2017 10:11:33 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBg010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:30 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/20] get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
Date:   Fri, 31 Mar 2017 16:10:59 +0200
Message-Id: <53e0eed5e13a04f502dcaeda83b2cbb3035f1396.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqDs1+V6EwaNtAhZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6M3rsPWAqeCFR0T73P1MB4nbeLkZNDQsBE
        4uzbFSwgtpDADiaJSRvCuhi5gOyTTBLv195gBEmwCehKLOppZgKxRQTUJCa2HWIBKWIWeMMk
        cWDLL7BuYYFwiS/rVwPZHBwsAqoS+/tFQcK8AlESn5+dY4JYJi+xq+0iK4jNKWAhsW7mIXaI
        xeYSC9ZOYJvAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkig8e1g
        bF8vc4hRgINRiYf3hPe9CCHWxLLiytxDjJIcTEqivL7hQCG+pPyUyozE4oz4otKc1OJDjBIc
        zEoivExxQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvRRJQo2BR
        anpqRVpmTglCmomDE2Q4D9DwBSA1vMUFibnFmekQ+VOMilLivKwgCQGQREZpHlwvLBG8YhQH
        ekWY9yBIFQ8wicB1vwIazAQ02OLrXZDBJYkIKakGxqLACKONqyQ4dV6ZTbD68l2+9Yctk7LK
        rNwZj0VeF4nYfZ36+Mo+UzHfXcnCzQwPjwnc8HQKWe37cu2PxfWyiaaHXLYuPqDW6d0effNf
        1bMZOrcfHltewqG+xYpvrUfLzM3pbJwqf9QfpMrfUft29UqSaeGdTR4V5/bfPTNlteoR9/Tq
        R/OCVimxFGckGmoxFxUnAgAJ3bs03wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since references under "refs/bisect/" are per-worktree, they have to
be sought in the worktree rather than in the main repository. But
since loose references are found by traversing directories, the
reference iterator won't even get the idea to look for a
"refs/bisect/" directory in the worktree if there is not a directory
with that name in the main repository. Thus `get_ref_dir()` manually
inserts a dir_entry for "refs/bisect/" whenever it reads the entry for
"refs/".

The current code then immediately calls `read_loose_refs()` on that
directory. But since the dir_entry is created with its `incomplete`
flag set, any traversal that gets to this point will read the
directory automatically. So there is no need to call
`read_loose_refs()` explicitly; the lazy mechanism suffices.

And in fact, the attempt to `read_loose_refs()` was broken anyway.
That function needs its `dirname` argument to have a trailing `/`
character, but the invocation here was passing it "refs/bisect"
without a trailing slash. So `read_loose_refs()` would read
`$GIT_DIR/refs/bisect" correctly, but if it found an entry "foo" in
that directory, it would try to read "$GIT_DIR/refs/bisectfoo".
Normally it wouldn't find anything at that path, but the failure was
canceled out because `get_ref_dir()` *also* forgot to reset the
`REF_INCOMPLETE` bit on the dir_entry. So the read was attempted again
when it was accessed, via the lazy mechanism, and this time the read
was done correctly.

This code has been broken since it was first introduced.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4242486118..e7a075e864 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -191,8 +191,6 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 							       "refs/bisect/",
 							       12, 1);
 				add_entry_to_dir(dir, child_entry);
-				read_loose_refs("refs/bisect",
-						&child_entry->u.subdir);
 			}
 		}
 		entry->flag &= ~REF_INCOMPLETE;
-- 
2.11.0

