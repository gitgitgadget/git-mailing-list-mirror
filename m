Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CAF20285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbdHZI21 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:27 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48900 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751868AbdHZI2Z (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:25 -0400
X-AuditID: 1207440d-86bff70000000f42-80-59a131281094
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.8D.03906.82131A95; Sat, 26 Aug 2017 04:28:24 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHih004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:23 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/12] notes: make GET_NIBBLE macro more robust
Date:   Sat, 26 Aug 2017 10:28:01 +0200
Message-Id: <df9d90032a9bc36333b4c5d19edf7135bf862c19.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqKthuDDS4MUVG4uuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CVsfftPOaCjWwVf28/Y2pgnMTaxcjJISFgInFi/ke2LkYuDiGBHUwSh17eZ4ZwTjFJTH20
        nRGkik1AV2JRTzMTiC0ioCYxse0QC0gRs8ByRomOt+fBEsIC9hJX1/8Ga2ARUJW4OGEhexcj
        BwevQJTEp+uqENvkJXa1XQTbzClgIXFj62c2EFtIwFyi7+cilgmMPAsYGVYxyiXmlObq5iZm
        5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQO7w7G/+tkDjEKcDAq8fBuKF4QKcSaWFZcmXuI
        UZKDSUmU10FjYaQQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4VSkA53pTEyqrUonyYlDQHi5I4
        r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE7x99oEbBotT01Iq0zJwShDQTByfIcB6g4RkgNbzF
        BYm5xZnpEPlTjLocTR+2fGESYsnLz0uVEuedZQBUJABSlFGaBzcHFvGvGMWB3hLmlQOp4gEm
        C7hJr4CWMAEtURQEW1KSiJCSamC0epHXbKV04sBNHpbiC03H3vXUTvz64r3ao4x3nS4h205L
        vLj26+KEDRPcFB/dC+FIy00/FxZ55XVzjYnR5nfPPKq+Ct0v+nXPawHXJVa1jFKB/j3sv8Jy
        3Xp2PArXnLByQ2d4hN6uJUfFq1vcDJTqdP/7zd3y++MFsZc3Qu88vlIYqn1x7aVZSizFGYmG
        WsxFxYkAXYMzvNMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Put parentheses around sha1. Otherwise it could fail for something
like

    GET_NIBBLE(n, (unsigned char *)data);

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index f090c88363..00630a9396 100644
--- a/notes.c
+++ b/notes.c
@@ -64,7 +64,7 @@ struct non_note {
 #define CLR_PTR_TYPE(ptr)       ((void *) ((uintptr_t) (ptr) & ~3))
 #define SET_PTR_TYPE(ptr, type) ((void *) ((uintptr_t) (ptr) | (type)))
 
-#define GET_NIBBLE(n, sha1) (((sha1[(n) >> 1]) >> ((~(n) & 0x01) << 2)) & 0x0f)
+#define GET_NIBBLE(n, sha1) ((((sha1)[(n) >> 1]) >> ((~(n) & 0x01) << 2)) & 0x0f)
 
 #define KEY_INDEX (GIT_SHA1_RAWSZ - 1)
 #define FANOUT_PATH_SEPARATORS ((GIT_SHA1_HEXSZ / 2) - 1)
-- 
2.11.0

