Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1664F20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755385AbdDPGm4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:56 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42496 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755313AbdDPGmx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:53 -0400
X-AuditID: 1207440c-abdff70000002e8f-ef-58f3125ff477
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B6.A0.11919.F5213F85; Sun, 16 Apr 2017 02:42:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN9025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:37 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/20] ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
Date:   Sun, 16 Apr 2017 08:41:30 +0200
Message-Id: <d6b7d230b71c9284f38cd0eb8aab81036e28b0ad.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqJsk9DnCYGKnhMXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugStj2o47bAXtnBVLFu5gaWDcw97FyMkhIWAi
        8WDubCCbi0NIYAeTxJFf59kgnBNMEv333rKCVLEJ6Eos6mlmArFFBNQkJrYdYgEpYhZ4zCTx
        d1k3C0hCWCBSYtKeC2BjWQRUJRZu2wTUwMHBKxAlsaBfCmKbvMSutotgMzkFLCSm3N0A1iok
        YC6x/fhV5gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihIQazw7G
        b+tkDjEKcDAq8fBa+H+KEGJNLCuuzD3EKMnBpCTKK/MfKMSXlJ9SmZFYnBFfVJqTWnyIUYKD
        WUmEN5nlc4QQb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampBahFMVoODQ+Dukt4NjFIs
        efl5qUoSvNGCQEMEi1LTUyvSMnNKEEqZODhBFvEALUoHqeEtLkjMLc5Mh8ifYtTlOLT593sm
        IbBBUuK8PwSAigRAijJK8+DmwFLHK0ZxoBeFebeCjOIBph24Sa+AljABLWGY/AFkSUkiQkqq
        gVFctvHnsonzowzuhncFzfnqeKnC5fAOho6tv/8e4J2XfS5rmjN/3ry3zS09N8Im/74c7nr2
        W3r8Io4rK/6u2XdC3+7fahMd+Y1iRSeEZn3Mv75/SWeTGpO10fLWd19LGv+YrY18/OCkffmB
        DxOtJQ3q3p98Y7CJlWGrlH9Wp+rq0K9K9x9OU32ixFKckWioxVxUnAgAzwODKvgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6e08bc798c..f980af2420 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -413,7 +413,7 @@ static struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname
  * empty by the removal.  dir must represent the top-level directory
  * and must already be complete.
  */
-static int remove_entry(struct ref_dir *dir, const char *refname)
+static int remove_entry_from_dir(struct ref_dir *dir, const char *refname)
 {
 	int refname_len = strlen(refname);
 	int entry_index;
@@ -2335,7 +2335,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
-		if (remove_entry(packed, refname->string) != -1)
+		if (remove_entry_from_dir(packed, refname->string) != -1)
 			removed = 1;
 	if (!removed) {
 		/*
-- 
2.11.0

