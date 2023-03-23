Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A7C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjCWQru (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjCWQrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:04 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC44EB5B
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4C4FC2421E
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-Az4-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] sequencer: remove pointless rollback_lock_file()
Date:   Thu, 23 Mar 2023 17:22:35 +0100
Message-Id: <20230323162235.995529-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file is gone even if commit_lock_file() fails.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..2da9b9f890 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3676,7 +3676,6 @@ static int safe_append(const char *filename, const char *fmt, ...)
 	}
 	if (commit_lock_file(&lock) < 0) {
 		strbuf_release(&buf);
-		rollback_lock_file(&lock);
 		return error(_("failed to finalize '%s'"), filename);
 	}
 
-- 
2.40.0.152.g15d061e6df

