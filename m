Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9F01FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbdCaOMI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:12:08 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45182 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933261AbdCaOMH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:12:07 -0400
X-AuditID: 12074414-7efff70000002bfd-c9-58de63b02f88
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.1A.11261.0B36ED85; Fri, 31 Mar 2017 10:12:00 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBv010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/20] get_loose_ref_cache(): new function
Date:   Fri, 31 Mar 2017 16:11:14 +0200
Message-Id: <fe76ca723956d8285dce8ad6e6845031a974ac36.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLsx+V6EwalNrBZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6MjraygumcFZtvtDA2MD5g72Lk5JAQMJHo
        nHacrYuRi0NIYAeTxJMpu6Gck0wS9w7sYgapYhPQlVjU08wEYosIqElMbDvEAlLELPCGSeLA
        ll8sIAlhAVuJRSvXgdksAqoSn/sesYLYvAJREl9+XWSCWCcvsavtIlicU8BCYt3MQ2BnCAmY
        SyxYO4FtAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSmlmxghoSayg/HI
        SblDjAIcjEo8vCe870UIsSaWFVfmHmKU5GBSEuX1DQcK8SXlp1RmJBZnxBeV5qQWH2KU4GBW
        EuFligPK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8FYkATUKFqWm
        p1akZeaUIKSZODhBhvMADV8AUsNbXJCYW5yZDpE/xagoJc7LCpIQAElklObB9cJSwStGcaBX
        hHmnJAJV8QDTCFz3K6DBTECDLb7eBRlckoiQkmpgnPOsfla1fvqHfu6LC9Zflv6gn+Zrfcbg
        DuPHn9KPheL9zs0rZZVgPm5X8H6ReN3iUE+zR20Vk/v89lZmi886uM02Yle0juW7mzdye3iv
        qM54xBa81PhHeFOO+o6FJU8OHLB5ff110m9536Z2NzHrh87NkY8uhATcaZ/tabfz2kOfa1lS
        Wx/HKbEUZyQaajEXFScCAI5zWnLgAgAA
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
index 0a16f6196c..fefc29433a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -525,7 +525,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	}
 }
 
-static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		/*
@@ -545,7 +545,12 @@ static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
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

