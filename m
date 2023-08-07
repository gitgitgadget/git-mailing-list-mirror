Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE11C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 17:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjHGRJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHGRJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 13:09:39 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631D1A3
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 10:09:38 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id BBEA6242B2;
        Mon,  7 Aug 2023 13:09:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qT3jb-nsr-00; Mon, 07 Aug 2023 19:09:35 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] doc: rebase: rewrite docu for fixup/squash (again)
Date:   Mon,  7 Aug 2023 19:09:35 +0200
Message-Id: <20230807170935.2336699-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a clear top-down structure which makes it hopefully unambiguous
what happens when.

Also mention the timestamp along with the author - this is primarily
meant to include the keywords somebody might be searching for, like I
did a year ago.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>
Cc: Charvi Mendiratta <charvi077@gmail.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-rebase.txt | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7b39ad244..857e025361 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -890,20 +890,21 @@ command "pick" with the command "reword".
 To drop a commit, replace the command "pick" with "drop", or just
 delete the matching line.
 
-If you want to fold two or more commits into one, replace the command
-"pick" for the second and subsequent commits with "squash" or "fixup".
-If the commits had different authors, the folded commit will be
-attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the first
-commit's message with those identified by "squash" commands, omitting the
-messages of commits identified by "fixup" commands, unless "fixup -c"
-is used.  In that case the suggested commit message is only the message
-of the "fixup -c" commit, and an editor is opened allowing you to edit
-the message.  The contents (patch) of the "fixup -c" commit are still
-incorporated into the folded commit. If there is more than one "fixup -c"
-commit, the message from the final one is used.  You can also use
-"fixup -C" to get the same behavior as "fixup -c" except without opening
-an editor.
+If you want to fold two or more commits into one (that is, to combine
+their contents/patches), replace the command "pick" for the second and
+subsequent commits with "squash" or "fixup".
+The commit message for the folded commit is the concatenation of the
+first commit's message with those identified by "squash" commands,
+omitting the messages of commits identified by "fixup" commands, unless
+"fixup -c" is used.  In the latter case, the message is obtained only
+from the "fixup -c" commit (having more than one "fixup -c" commit
+makes no sense, and only the message from the last one is used).
+If the resulting commit message is a concatenation of multiple messages,
+an editor is opened allowing you to edit it. This is also the case for a
+message obtained via "fixup -c", while using "fixup -C" instead skips
+the editor; this is analogous to the behavior of `git commit`.
+The first commit which contributes to the suggested commit message also
+determines the author, along with the date/timestamp.
 
 `git rebase` will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
-- 
2.40.0.152.g15d061e6df

