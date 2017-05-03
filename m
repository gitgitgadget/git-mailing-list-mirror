Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0AB11F829
	for <e@80x24.org>; Wed,  3 May 2017 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbdECQaJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:30:09 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:41815 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753275AbdECQaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:30:07 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 62454200416;
        Wed,  3 May 2017 18:30:05 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 1/4] usability: don't ask questions if no reply is required
Date:   Wed,  3 May 2017 18:29:28 +0200
Message-Id: <20170503162931.30721-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described in the bug report at

https://github.com/git/git-scm.com/issues/999

the user was disconcerted by the question asked by the program not
requiring a reply from the user. To improve the general usability of
the Git suite, The following rule was applied:

if the sentence
 * appears in a non-interactive session
 * is printed last before exit
 * is a question addressing the user ("you")

the sentence is turned into affirmative and proposes the option.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 help.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index bc6cd19cf..4658a55c6 100644
--- a/help.c
+++ b/help.c
@@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf_ln(stderr,
-			   Q_("\nDid you mean this?",
-			      "\nDid you mean one of these?",
+			   Q_("\nThe most approaching command is",
+			      "\nThe most approaching commands are",
 			   n));
 
 		for (i = 0; i < n; i++)
-- 
2.12.0

