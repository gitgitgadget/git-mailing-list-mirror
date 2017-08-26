Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2F220285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbdHZI2a (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:30 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43749 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751868AbdHZI22 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:28 -0400
X-AuditID: 12074412-1fdff7000000748d-46-59a1312b7128
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E6.7A.29837.B2131A95; Sat, 26 Aug 2017 04:28:27 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHij004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:26 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/12] load_subtree(): reduce the scope of some local variables
Date:   Sat, 26 Aug 2017 10:28:03 +0200
Message-Id: <c92a4da68db645185a7a3fa2a1584724882ad268.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqKttuDDSYOVuK4uuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CV0XbsFUvBDM6KuQ/OsjQw7mHvYuTgkBAwkZh6PKaLkZNDSGAHk8SfF0pdjFxA9ikmicfr
        m9lAEmwCuhKLepqZQGwRATWJiW2HWECKmAWWM0p0vD0PlhAW8JeYPOkhC4jNIqAqseDyJ2YQ
        m1cgSqJl9zGwQRIC8hK72i6ygticAhYSN7Z+ZoPYbC7R93MRywRGngWMDKsY5RJzSnN1cxMz
        c4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQsJGaAfj+pNyhxgFOBiVeHgjChdECrEmlhVX5h5i
        lORgUhLlddBYGCnEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHeFElCONyWxsiq1KB8mJc3BoiTO
        +3Oxup+QQHpiSWp2ampBahFMVoaDQ0mC948+UKNgUWp6akVaZk4JQpqJgxNkOA/Q8CsGIMOL
        CxJzizPTIfKnGBWlxHlngSQEQBIZpXlwvbC4fsUoDvSKMK8cSBUPMCXAdb8CGswENFhREGxw
        SSJCSqqB0XnnwuS14Ur7Ja98KnFq09kQ9NV7vda9wrR39kl/G7yFvLZHum/ycg1wPK2rmPbF
        1FP+1w0fxtOy2X25S7NWt12bO///558Ge2fP/dXWKGH4yWdB6qHPJZH6E5sn8v/Pk5GS6xJf
        PpcjT8ZnWXS2xKXS2vXT69l1b+1vV5Nu+jG1S2p3YlmKEktxRqKhFnNRcSIAEDiPy8YCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the variables inside the loop, to make it more obvious that
their values are not carried across loop iterations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/notes.c b/notes.c
index f7ce64ff48..fbed8c3013 100644
--- a/notes.c
+++ b/notes.c
@@ -421,9 +421,6 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
-	int len, path_len;
-	unsigned char type;
-	struct leaf_node *l;
 
 	buf = fill_tree_descriptor(&desc, &subtree->val_oid);
 	if (!buf)
@@ -434,7 +431,10 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	assert(prefix_len * 2 >= n);
 	memcpy(object_oid.hash, subtree->key_oid.hash, prefix_len);
 	while (tree_entry(&desc, &entry)) {
-		path_len = strlen(entry.path);
+		unsigned char type;
+		struct leaf_node *l;
+		int len, path_len = strlen(entry.path);
+
 		len = get_oid_hex_segment(entry.path, path_len,
 				object_oid.hash + prefix_len, GIT_SHA1_RAWSZ - prefix_len);
 		if (len < 0)
-- 
2.11.0

