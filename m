Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BFBC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjCWQrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjCWQrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:04 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF884D52A
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 57FD523E74
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:34 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-Ax4-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] strbuf_stripspace(): rename skip_comments arg to strip_comments
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162234.995405-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That makes its function much clearer and more consistent with the
context.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 strbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 1c57ac6574..49e8beaa4c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1118,10 +1118,10 @@ static size_t cleanup(char *line, size_t len)
  *
  * If last line does not have a newline at the end, one is added.
  *
- * Enable skip_comments to skip every line starting with comment
+ * Enable strip_comments to strip every line starting with a comment
  * character.
  */
-void strbuf_stripspace(struct strbuf *sb, int skip_comments)
+void strbuf_stripspace(struct strbuf *sb, int strip_comments)
 {
 	size_t empties = 0;
 	size_t i, j, len, newlen;
@@ -1134,7 +1134,7 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 		eol = memchr(sb->buf + i, '\n', sb->len - i);
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
-		if (skip_comments && len && sb->buf[i] == comment_line_char) {
+		if (strip_comments && len && sb->buf[i] == comment_line_char) {
 			newlen = 0;
 			continue;
 		}
-- 
2.40.0.152.g15d061e6df

