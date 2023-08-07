Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE12BC41513
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjHGRJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHGRJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:37 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A4B1
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:36 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id A756624289;
        Mon,  7 Aug 2023 13:09:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-nsP-00; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] t/lib-rebase: set_fake_editor(): fix recognition of reset's short command
Date:   Mon,  7 Aug 2023 19:09:33 +0200
Message-Id: <20230807170935.2336663-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
 <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... in FAKE_LINES.

This has been broken ever since it was introduced in 5dcdd7409a
(t/lib-rebase: prepare for testing `git rebase --rebase-merges`,
2019-07-31), but it's not actually used, so it's a cosmetic defect
only.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 t/lib-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7ca5b918f0..e6179ab529 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -49,7 +49,7 @@ set_fake_editor () {
 	action=\&
 	for line in $FAKE_LINES; do
 		case $line in
-		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
+		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|t|merge|m)
 			action="$line";;
 		exec_*|x_*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
-- 
2.40.0.152.g15d061e6df

