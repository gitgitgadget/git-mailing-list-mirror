Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F67420A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbdDPGnE (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:43:04 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44179 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755390AbdDPGm6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:58 -0400
X-AuditID: 1207440d-029ff70000003721-55-58f312718c12
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.53.14113.17213F85; Sun, 16 Apr 2017 02:42:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNH025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/20] get_loose_ref_cache(): new function
Date:   Sun, 16 Apr 2017 08:41:38 +0200
Message-Id: <216c53d1fa1ee0a751fbe1775cef5d479210d6c1.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqFso9DnC4NVbOYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGqknL2Aumc1ZcWnCMuYHxAXsXIyeHhICJ
        xLyTd1i6GLk4hAR2MEncm/KXESQhJHCCSeLcZhcQm01AV2JRTzMTiC0ioCYxse0QWAOzwGMm
        ib/LullAEsICthL//iwEm8oioCrx9f0JZhCbVyBK4tDD1awQ2+QldrVdBLM5BSwkptzdwAKx
        zFxi+/GrzBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAk13h2M
        /9fJHGIU4GBU4uG18P8UIcSaWFZcmXuIUZKDSUmUV+Y/UIgvKT+lMiOxOCO+qDQntfgQowQH
        s5IIbzLL5wgh3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE7wcBoEbB
        otT01Iq0zJwShDQTByfIcB6g4VtBaniLCxJzizPTIfKnGBWlxHl/gCQEQBIZpXlwvbBU8IpR
        HOgVYd5aQaAqHmAaget+BTSYCWgww+QPIINLEhFSUg2MTCf+/eJPrZ1+rHkPo3h/TFDiJ5b0
        n/I3z+ivN9LSeyB+y9FA4m6F77W1U06k7RI8YW2W8vRxKE+lWVdax3dH3n0y9y1/Vi84qJmp
        zXI09fnfg8FR+/f3OhvWXKx9vdz501rPZIOpwU/Vty+sltqt5rJoxro9j5T+ui39IT9//sZz
        Xkv8b6htVmIpzkg01GIuKk4EAPRezvPgAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function, `get_loose_ref_cache()`, from
get_loose_ref_dir(). The function returns the `ref_cache` for the
loose refs of a `files_ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3beab0b752..7ae7c6a1b7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -524,7 +524,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	}
 }
 
-static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		/*
@@ -544,7 +544,12 @@ static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
 		add_entry_to_dir(get_ref_dir(refs->loose->root),
 				 create_dir_entry(refs->loose, "refs/", 5, 1));
 	}
-	return get_ref_dir(refs->loose->root);
+	return refs->loose;
+}
+
+static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
+{
+	return get_ref_dir(get_loose_ref_cache(refs)->root);
 }
 
 /*
-- 
2.11.0

