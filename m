From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase: only show stat if configured to true
Date: Tue,  9 Nov 2010 21:59:00 +0100
Message-ID: <1289336340-28337-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 10 03:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG0u7-0004lX-Vp
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 03:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab0KJC7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 21:59:15 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47755 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0KJC7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 21:59:14 -0500
Received: by qwi4 with SMTP id 4so22302qwi.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 18:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/qZHqZJgg72RJNzkbS+uSe3rFE4Z0v+a76yKB/lKmpo=;
        b=iozv6XGvsmFAWXCp7Jfb7DydOEQv23ZQdWYWZ7wadKF5yWfiIq+QoUypq/xndVtfN9
         7RlhRv59UETRF2UnOqn2P+ty7g2lEY1qcax3eUD5jJSE9T27npZCDs13Y7jIC4DBRnNa
         6p9Rbs3GgOQJiZZePPnJ325/uy1HPiMtwCHcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Nn81alRGLFE2jOpRImps1KrsM65DeSdZzvtgXu8V2ST8axOVEaaU4kBnTkOXM0Hvw4
         PTON7St/bX82haBbtUMXaTqI9bx5OzeKO8cFYOGX8fDBcovf8j/SIrLol7X8rIxP3i3M
         1mY7z7snoAC22vk9TF0MQxGB2UQSjtGMSiSvE=
Received: by 10.229.225.213 with SMTP id it21mr7152128qcb.90.1289357953709;
        Tue, 09 Nov 2010 18:59:13 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s34sm156039qcp.32.2010.11.09.18.59.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 18:59:13 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161125>

If rebase.stat is set to true, a diffstat should be displayed. If it is
not set, it should default to false. However, if it is explicitly set to
false (or other value), a diffstat is still displayed, which is probably
not what most users would expect. Show diffstat only if it is set
to true.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e5df23b..42c0628 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -49,7 +49,8 @@ do_merge=
 dotest="$GIT_DIR"/rebase-merge
 prec=4
 verbose=
-diffstat=$(git config --bool rebase.stat)
+diffstat=
+test "$(git config --bool rebase.stat)" = true && diffstat=t
 git_am_opt=
 rebase_root=
 force_rebase=
-- 
1.7.3.2.167.ga361b
