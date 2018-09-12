Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5901E1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 10:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeILPOj (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 11:14:39 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:63187 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILPOj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 11:14:39 -0400
Received: from lindisfarne.localdomain ([89.242.190.162])
        by smtp.talktalk.net with SMTP
        id 026Ygd54KdJAe026ggxHB3; Wed, 12 Sep 2018 11:10:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1536747047;
        bh=3nrcFIDVEwVz+Vs0/qDyBgOJqv+mOVLVPRO2DGILMGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=npHCisJGs0sPAjBn4+xVOIJ608JEdyYBPGZ6iTJnF/0/0ELnPFCBX1dQHY6LQeebL
         s+rhI9GocmSdpXiKYeuUtbrcROE+xKTKNQb1uvgicgT9QNq6MSjhm7nNXiNXIDUadJ
         U+1ZoKQ74CPKC8ZKoLSnTlkvqTBOHni8sgFCqLVs=
X-Originating-IP: [89.242.190.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yWw/b5KBQb65dAU66aqL/Q==:117
 a=yWw/b5KBQb65dAU66aqL/Q==:17 a=evINK-nbAAAA:8 a=jAbL0x3HlbHIGo4u6YsA:9
 a=9cwk9Okqd2CfRaF0:21 a=q43gRipxSBSK2way:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/3] am: rename read_author_script()
Date:   Wed, 12 Sep 2018 11:10:27 +0100
Message-Id: <20180912101029.28052-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912101029.28052-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfG6gRX1GqTBQ0/GE0ijBJ4yx/Grydn9JQ9Lp9QiwJ6GmF6HJ98xvylyKLP0ur09s0pur2ffmh9ZWgJ4fOjhlVdXskRQExBxOZ3EQjDvyC7BtFDzxbDf1
 2scAa6WDx05COq59zNWK43c2Uq1xEGc0OleZkaR4/doYRiittDzr68DNpw69dV2Hib22tv1sVD7icav90q3HzJ/Kp7YVQUwJrptXZMSmS8P1tSUHWZT86zQO
 vIimjtnsKpaXEEoLBVbpx10wtoXBg9INNKOlKBe6cFMCFC/nDUD/JG+69OQ6ZqKB9EtpUDR/3+LF9aOdyLJN/RM3LW0Me5YecymQPrzeg9c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rename read_author_script() in preparation for adding a shared
read_author_script() function to libgit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5e866d17c7..8c165f747b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -302,7 +302,7 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
  * script, and thus if the file differs from what this function expects, it is
  * better to bail out than to do something that the user does not expect.
  */
-static int read_author_script(struct am_state *state)
+static int read_am_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
 	struct strbuf buf = STRBUF_INIT;
@@ -411,7 +411,7 @@ static void am_load(struct am_state *state)
 		BUG("state file 'last' does not exist");
 	state->last = strtol(sb.buf, NULL, 10);
 
-	if (read_author_script(state) < 0)
+	if (read_am_author_script(state) < 0)
 		die(_("could not parse author script"));
 
 	read_commit_msg(state);
-- 
2.18.0

