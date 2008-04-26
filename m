From: Richard Quirk <richard.quirk@gmail.com>
Subject: [PATCH] bash: Add completion for gitk --merge
Date: Sun, 27 Apr 2008 01:32:14 +0200
Message-ID: <1209252734-10861-1-git-send-email-richard.quirk@gmail.com>
Cc: Richard Quirk <richard.quirk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 01:33:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpttE-0002LT-M7
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 01:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbYDZXcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 19:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYDZXcV
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 19:32:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63599 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYDZXcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 19:32:21 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1664874nfb.21
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 16:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=O1OdEEzwyaZ1M0UOdP2uFa6sMZ11ulFFlmHU9WHxS+g=;
        b=BH9hQjIbf/t7g+pxYsJErneXynC8OfYzrjfGwK06c2QQrGvvgKXkuKekPl5cI5aMKYEgbZkhXnyjxsGirNG63pDCcQYnj3f5nzRrvKkL8MOkO+RfnlJq38kIe+Mq0ILb6957CDaGttYUXo/4mCpsmw51BHCm51yUMKA751oVsow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=m/Hmk8dGdiWSeaLA0cTuGQHM1yRSoQwJ4qcPRFBMa17BRA71tlU9KA4FrkG8pFhQgASUGyFeWbxvb5My1YCqUnW3Jc0+j2BXOZHG5tyh2U5AA/BpL1JSqIDbQv33Fy8gcfh7AibmIqRmRWoclf+gA8FON0x28Yvg5GscmWcXwsQ=
Received: by 10.210.118.7 with SMTP id q7mr4174029ebc.198.1209252736060;
        Sat, 26 Apr 2008 16:32:16 -0700 (PDT)
Received: from localhost ( [84.77.18.6])
        by mx.google.com with ESMTPS id 6sm33920494nfv.5.2008.04.26.16.32.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Apr 2008 16:32:15 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.79.g57cf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80399>

Option is only completed when .git/MERGE_HEAD is present.

Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
---
 contrib/completion/git-completion.bash |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 665a895..2565aa6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1346,9 +1346,14 @@ _git ()
 _gitk ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	local merge=""
+	if [ -f $g/MERGE_HEAD ]; then
+		local merge="--merge"
+	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--not --all"
+		__gitcomp "--not --all $merge"
 		return
 		;;
 	esac
-- 
1.5.5.1.79.g57cf
