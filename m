From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Fri, 13 Nov 2015 07:03:19 +0100
Message-ID: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 07:03:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx7SP-0004Gq-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 07:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbbKMGD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 01:03:29 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35951 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbKMGD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 01:03:28 -0500
Received: by lfs39 with SMTP id 39so46792031lfs.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 22:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DFQZP60jYTOqpZHMPFC9BMSY30Khi9wLmbwLBUfhjaY=;
        b=w74BdbjrV5EvGp6cvwjkdmZfoQ4DmoVFmP26x275/sGEQ2+IIFLChNn9IJNx4v7wkV
         9RVu/FXjEvkx7uuXxMRVtBzntXm46pddKVjy2i8+mcH9FPglX7n5JVJTfpX6kMWY20/q
         qyXdnGbFmZA9fawL/lb15ZMZk+nn74xb3MNkj7g9qQtgYnxsEvXLt7wV8iC+0VHxB6Th
         FC52EOlKu6vIwM2moiV/zNSpuPKjJn175jol5GZuYQwpTuTxF914D8SP12ZR5JL5a7Ux
         WODKo3RVqLREfVufdJ4OIoriknxrpU0b+STJnwUU8OgUrdaTJPqOflQMGqzd6yJLNIeN
         9s2Q==
X-Received: by 10.25.157.85 with SMTP id g82mr9393688lfe.104.1447394607317;
        Thu, 12 Nov 2015 22:03:27 -0800 (PST)
Received: from localhost.localdomain (c80-217-115-60.bredband.comhem.se. [80.217.115.60])
        by smtp.gmail.com with ESMTPSA id l67sm2853709lfd.43.2015.11.12.22.03.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Nov 2015 22:03:26 -0800 (PST)
X-Mailer: git-send-email 2.6.2.468.gf34be46.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281240>

On Windows, when Git is installed under "C:\Program Files\Git", SHELL_PATH
will include a space. Fix "git rebase --interactive --exec" so that it
works with spaces in SHELL_PATH.

Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 30edb17..b938a6d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -610,7 +610,7 @@ do_next () {
 		read -r command rest < "$todo"
 		mark_action_done
 		printf 'Executing: %s\n' "$rest"
-		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
+		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
 		status=$?
 		# Run in subshell because require_clean_work_tree can die.
 		dirty=f
-- 
2.6.2.468.gf34be46.dirty
