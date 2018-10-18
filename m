Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337DE1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 10:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeJRSBB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 14:01:01 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:9293 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeJRSBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 14:01:00 -0400
Received: from lindisfarne.localdomain ([92.26.121.144])
        by smtp.talktalk.net with SMTP
        id D56VgJF7wbZX5D56hgkniX; Thu, 18 Oct 2018 11:00:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539856844;
        bh=iClE0U8zxAwkrx86q1LMc+Y/ukuPArfwyTYJ7LEzm/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=fDCfMagXS0IgyZRdWi9xcn43YBE8oJ1dLQ32m7XkIYl7fPAZgLridb6u60L7OZE+W
         c32f+sYmXSSCmNJIF6rtGPfpaw6TS5ebpY7JmrxpnteEu0QkwB5eAl2JufHoFYyxzO
         nY0l1UtEVMxDXhRgS2aaH8f8k3hfaZLI6j8pZZ7E=
X-Originating-IP: [92.26.121.144]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=AM9PLn0bJgvrHi3wmEITIQ==:117
 a=AM9PLn0bJgvrHi3wmEITIQ==:17 a=evINK-nbAAAA:8 a=jAbL0x3HlbHIGo4u6YsA:9
 a=ayfHRXvC4A7m-KMB:21 a=q43gRipxSBSK2way:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/5] am: rename read_author_script()
Date:   Thu, 18 Oct 2018 11:00:21 +0100
Message-Id: <20181018100023.7327-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181018100023.7327-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181018100023.7327-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAsVYKTc4CIZIgAUreipP67Poo4KBGci1jdjD51Dka7U9ae+tnAaI0ur6bJ2si+xvUG9A6Sn1LbpRebcJ5/bYnqo3/Tz33/Cgr2xFsF/tVDK6SH0WIA7
 ykUrTIXLGkLtmt+rwNI/xhhAXBC0pSw1y1qTqGtEVZTHZEh3/UGMj3qeWHsFx7S+BhAUyIsxXzmNzUxehrpWnO1hLSUMoskF/wsi1I2iWFB9sHYyVuGhDAuM
 BcVdxGs/faQ45G+hfDV+uiw+uBHguPC5pMb1VbZCVp2qg8ahHvI9t/cNTFU3erH2xIbrsPgdXUDbAWtECNWWOEeFlVsx7PzJ4gJ//Sy3J2w=
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
index d42b725273..991d13f9a2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -306,7 +306,7 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
  * script, and thus if the file differs from what this function expects, it is
  * better to bail out than to do something that the user does not expect.
  */
-static int read_author_script(struct am_state *state)
+static int read_am_author_script(struct am_state *state)
 {
 	const char *filename = am_path(state, "author-script");
 	struct strbuf buf = STRBUF_INIT;
@@ -441,7 +441,7 @@ static void am_load(struct am_state *state)
 		BUG("state file 'last' does not exist");
 	state->last = strtol(sb.buf, NULL, 10);
 
-	if (read_author_script(state) < 0)
+	if (read_am_author_script(state) < 0)
 		die(_("could not parse author script"));
 
 	read_commit_msg(state);
-- 
2.19.0

