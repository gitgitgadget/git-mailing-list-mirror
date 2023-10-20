Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1D12E50
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B5AD49
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:27:10 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 243BD23F67;
	Fri, 20 Oct 2023 05:27:08 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qtlmd-qgl-00; Fri, 20 Oct 2023 11:27:07 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: [RESEND] git-rebase.txt: rewrite docu for fixup/squash (again)
Date: Fri, 20 Oct 2023 11:27:07 +0200
Message-ID: <20231020092707.917514-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.42.0.419.g70bf8a5751

