Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ABFC761AF
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjCWQrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjCWQrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:00 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0578BB8A
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:29 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 8D28024224
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-AzY-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] rebase: clarify conditionals in todo_list_to_strbuf()
Date:   Thu, 23 Mar 2023 17:22:35 +0100
Message-Id: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it obvious that the two conditional branches are mutually
exclusive.

As a drive-by, remove a pair of unnecessary braces.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..9169876441 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5868,12 +5868,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
 			if (item->command == TODO_FIXUP) {
 				if (item->flags & TODO_EDIT_FIXUP_MSG)
 					strbuf_addstr(buf, " -c");
-				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
+				else if (item->flags & TODO_REPLACE_FIXUP_MSG)
 					strbuf_addstr(buf, " -C");
-				}
-			}
-
-			if (item->command == TODO_MERGE) {
+			} else if (item->command == TODO_MERGE) {
 				if (item->flags & TODO_EDIT_MERGE_MSG)
 					strbuf_addstr(buf, " -c");
 				else
-- 
2.40.0.152.g15d061e6df

