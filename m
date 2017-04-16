Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A8220A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbdDPGm1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:27 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57714 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752200AbdDPGm0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:26 -0400
X-AuditID: 12074412-4a3ff70000000b04-b4-58f3124e9367
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 73.94.02820.E4213F85; Sun, 16 Apr 2017 02:42:25 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN2025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:21 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/20] get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
Date:   Sun, 16 Apr 2017 08:41:23 +0200
Message-Id: <4dcec6af523a14bbdb398437a9ca0414321ee2bb.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqBso9DnC4MlhXou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAldGy4cWpoInAhWnXx1namC8ztvFyMkhIWAi
        se7gZ6YuRi4OIYEdTBIzji1hhHBOMEnsmjqJFaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwGMm
        ib/LuoEcDg5hgXCJSctZQGpYBFQlDs3ewghi8wpESax/+ocVYpu8xK62i2A2p4CFxJS7G8Dq
        hQTMJbYfv8o8gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQUBPa
        wbj+pNwhRgEORiUeXgv/TxFCrIllxZW5hxglOZiURHll/gOF+JLyUyozEosz4otKc1KLDzFK
        cDArifAms3yOEOJNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuD9IADU
        KFiUmp5akZaZU4KQZuLgBBnOAzR8K0gNb3FBYm5xZjpE/hSjopQ47w+QhABIIqM0D64Xlgpe
        MYoDvSLMyywIVMUDTCNw3a+ABjMBDWaY/AFkcEkiQkqqgZE5V4jh5aGHCwIyXF8137j2r8L2
        QGXG2n7P62Jlk8/s5HnolmJoqvJcWFLRxyXrgbrUz6lHGj0Ws4clZq00r69lsL+vZLC9VaFN
        qI/Nvz31cfJBb01hsWWZumbP9645rfndxtP0iKfxSfNGq7uL7nPMsr9X1HMv68C+WZ+tRHZt
        vfExLEiLQ4mlOCPRUIu5qDgRAB55FHPgAgAA
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
index 4d705b4037..2a0538dea7 100644
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

