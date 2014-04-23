From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git-rebase: fix probable reflog typo
Date: Tue, 22 Apr 2014 19:14:44 -0500
Message-ID: <1398212084-16304-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 02:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcl02-0002N8-IJ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 02:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbaDWAZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 20:25:09 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:61264 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaDWAZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 20:25:08 -0400
Received: by mail-oa0-f50.google.com with SMTP id i11so254191oag.9
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XRdlXh/PJ9kXnrAmKSEcYqW//je0NdygTav/UoDPFJU=;
        b=VN4q9MyiZAqFzNUk9oKe9Oeei1Ai2v49uyKEBGdoEniohjLP1ly1Hd+F33El2hjvDQ
         mGgHKvOISCJmBDNDUnRJ5UlrBd4+H8HWSUhZ6UoF2wn7vp00O6Xph7jRWGQoyp8WOpad
         itL2bG9+IZ4WEn9Ys1uBsMPk9QItlJkP6UYoRITdSDSu/SVl1QWXlQ9OIFBKA8RD4XNk
         zd3Cu/QHD32XHAfdBvkXz3qn77aoZq5c8aOoT4DiORToqJbZG4/43pedchBbqhWIirKT
         VW/6NU3iHGsqwllapAx6sCRSQNPqwEQG4fzOYP5mUafvfWLzBoem0wiO+lf3XiKFNOjR
         4BLw==
X-Received: by 10.182.144.194 with SMTP id so2mr34805259obb.31.1398212708052;
        Tue, 22 Apr 2014 17:25:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm184193603oeb.10.2014.04.22.17.25.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 17:25:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246806>

Commit 26cd160 (rebase -i: use a better reflog message) tried to produce
a better reflog message, however, it seems a statement was introduced by
mistake.

'comment_for_reflog start' basically overides the GIT_REFLOG_ACTION we
just set.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--interactive.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 43631b4..5f1d8c9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -893,8 +893,6 @@ then
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
 	output git checkout "$switch_to" -- ||
 	die "Could not checkout $switch_to"
-
-	comment_for_reflog start
 fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-- 
1.9.2+fc1.1.g5c924db
