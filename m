Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC931F453
	for <e@80x24.org>; Wed, 19 Sep 2018 20:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeITCd1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 22:33:27 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:44930 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbeITCd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 22:33:27 -0400
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g2iqS-0001yi-MI; Wed, 19 Sep 2018 16:13:08 -0400
Received: from amenhotep (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 7CD0F3EE5A;
        Wed, 19 Sep 2018 13:13:03 -0700 (PDT)
Received: from frederik by amenhotep with local (Exim 4.91)
        (envelope-from <frederik@amenhotep>)
        id 1g2iqN-0000GS-1J; Wed, 19 Sep 2018 20:13:03 +0000
From:   Frederick Eaton <frederik@ofb.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Frederick Eaton <frederik@ofb.net>
Subject: [PATCH 2/3] git-column.1: clarify initial description, provide examples
Date:   Wed, 19 Sep 2018 13:12:30 -0700
Message-Id: <20180919201231.609-3-frederik@ofb.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919201231.609-1-frederik@ofb.net>
References: <20180919201231.609-1-frederik@ofb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I read this man page I couldn't figure out what kind of input it
was referring to, or how input was being put into columns, or where I
should look for the syntax of the --mode option.

Signed-off-by: Frederick Eaton <frederik@ofb.net>
---
 Documentation/git-column.txt | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 03d18465d..5bbb51068 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -13,7 +13,10 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This command formats its input into multiple columns.
+This command formats the lines of its standard input into a table with
+multiple columns. Each input line occupies one cell of the table. It
+is used internally by other git commands to format output into
+columns.
 
 OPTIONS
 -------
@@ -23,7 +26,7 @@ OPTIONS
 
 --mode=<mode>::
 	Specify layout mode. See configuration variable column.ui for option
-	syntax.
+	syntax (in git-config(1)).
 
 --raw-mode=<n>::
 	Same as --mode but take mode encoded as a number. This is mainly used
@@ -43,6 +46,34 @@ OPTIONS
 --padding=<N>::
 	The number of spaces between columns. One space by default.
 
+EXAMPLES
+------
+
+Format data by columns:
+------------
+$ seq 1 24 | git column --mode=column --padding=5
+1      4      7      10     13     16     19     22
+2      5      8      11     14     17     20     23
+3      6      9      12     15     18     21     24
+------------
+
+Format data by rows:
+------------
+$ seq 1 21 | git column --mode=row --padding=5
+1      2      3      4      5      6      7
+8      9      10     11     12     13     14
+15     16     17     18     19     20     21
+------------
+
+List some tags in a table with unequal column widths:
+------------
+$ git tag --list 'v2.4.*' --column=row,dense
+v2.4.0  v2.4.0-rc0  v2.4.0-rc1  v2.4.0-rc2  v2.4.0-rc3
+v2.4.1  v2.4.10     v2.4.11     v2.4.12     v2.4.2
+v2.4.3  v2.4.4      v2.4.5      v2.4.6      v2.4.7
+v2.4.8  v2.4.9
+------------
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.19.0

