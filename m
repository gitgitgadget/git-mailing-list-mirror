Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843AE203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 07:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbcHLHJU (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:20 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:34698 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6Zabadhf; Fri, 12 Aug 2016 08:08:06 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=pGLkceISAAAA:8 a=IFH_yTJTXzaC50ORncQA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 11/12] doc: revisions: show revision expansion in examples
Date:	Fri, 12 Aug 2016 08:07:48 +0100
Message-Id: <20160812070749.2920-12-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCBS9AeE/RGdlUBRsgHYjGrqJ+nRqAzG7WAqhLEGNdSFonVoup6FYFBSfXdhmdi4uiOJnLxZrcEVtwQTecRslicZcCM4TR+WcVHctEVyTzwZ5dA4bxQd
 8XHJlcOc3WVstWuUIjOcAFW6zQErcSaHTLL0tz/Vdn5meYVWI4QRA7euGwULZjWuGBPxJ5t9pplhBmAU6m6h1tn/PE7TsKPx0O3UPu1VNhAIMkXg9huTNKYg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The revisions examples show the revison arguments and the selected
commits, but do not show the intermediate step of the expansion of
the special 'range' notations. Extend the examples, including an
all-parents multi-parent merge commit example.

Sort the examples and fix the alignment for those unaffected
in the next commit.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
new
Cc: Jakub Narębski <jnareb@gmail.com>
---
 Documentation/revisions.txt | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 70864d5..ac7dd8e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -326,16 +326,23 @@ Revision Range Summary
   as giving commit '<rev>' and then all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).
 
-Here are a handful of examples:
+Here are a handful of examples using the Loeliger illustration above:
 
+   Args   Expansion       Selection
    D                G H D
    D F              G H I J D F
    ^G D             H D
    ^D B             E I J F B
-   B..C             C
-   B...C            G H D E B C
+   B..C   = ^B C          C
+   B...C  = B ^F C        G H D E B C
    ^D B C           E I J F B C
    C                I J F C
-   C^@              I J F
-   C^!              C
-   F^! D            G H D F
+   C^@    = C^1
+          = F             I J F
+   B^@    = B^1 B^2 B^3
+          = D E F         D G H E F I J
+   C^!    = C ^C^1
+          = C ^F          C
+   B^! = B ^B^1 ^B^2 ^B^3
+       = B ^D ^E ^F       B
+   F^! D  = F ^I ^J D     G H D F
-- 
2.9.0.windows.1

