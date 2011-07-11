From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Documentation: clearly specify what refs are honored by core.logAllRefUpdates
Date: Mon, 11 Jul 2011 11:14:18 +0200
Message-ID: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 11:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgCZP-0005sb-I7
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 11:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab1GKJOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 05:14:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47506 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab1GKJOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 05:14:22 -0400
Received: by bwd5 with SMTP id 5so3067188bwd.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TqwJy95FMb02ksb9dWo6w0tdCIYL6QBJQ/e5GGKanyY=;
        b=bsSB7eCjJNWkddXf2kMnwFr86cE2xkmtSOJhev4rjCc6nY5UrPXIG5om/fho4nBIb+
         HAYIh3ZejojWIMcMpynjNJIv4S7vQyvoAkPRoFy9BJXc8l031J0yEt/t+CJb2BGm31au
         7vTJB3qKRExDbMML41AvYS4wk6wutMPwIsfdM=
Received: by 10.204.79.67 with SMTP id o3mr2595332bkk.19.1310375660867;
        Mon, 11 Jul 2011 02:14:20 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de [141.30.68.111])
        by mx.google.com with ESMTPS id v6sm962863bkd.55.2011.07.11.02.14.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 02:14:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.517.g10515
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176837>

The documentation for logging updates in git-update-ref, doesn't make it
clear that only a specific subset of refs are honored by this variable.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

The initial justification in 4057deb (Junio C Hamano, 2006-10-08), leaves
the impression, that a blacklist would have made more sense, than the
current whitelist. Maybe we can change this?
---
 Documentation/config.txt         |    4 +++-
 Documentation/git-update-ref.txt |    5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c631d1c..dd44122 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -344,7 +344,9 @@ core.logAllRefUpdates::
 	SHA1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
 	variable is set to true, missing "$GIT_DIR/logs/<ref>"
-	file is automatically created for branch heads.
+	file is automatically created for branch heads (i.e. under
+	refs/heads/), remote reafs (i.e. under refs/remotes/),
+	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
 +
 This information can be used to determine what commit
 was the tip of a branch "2 days ago".
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index e25a65a..18fce69 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -60,8 +60,9 @@ still contains <oldvalue>.
 
 Logging Updates
 ---------------
-If config parameter "core.logAllRefUpdates" is true or the file
-"$GIT_DIR/logs/<ref>" exists then `git update-ref` will append
+If config parameter "core.logAllRefUpdates" is true and the ref is one under
+"refs/heads/", "refs/remotes/", "refs/notes/", or the symbolic ref HEAD; or
+the file "$GIT_DIR/logs/<ref>" exists then `git update-ref` will append
 a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
 symbolic refs before creating the log name) describing the change
 in ref value.  Log lines are formatted as:
-- 
1.7.5.517.g10515
