From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] pull: remove extra space from reflog message
Date: Thu, 21 Jul 2011 00:19:03 +0300
Message-ID: <4e2747c1.c6cae30a.0ff2.29e0@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 23:25:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjeGn-00015Z-Lu
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 23:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab1GTVZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 17:25:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36816 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1GTVZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 17:25:24 -0400
Received: by wyg8 with SMTP id 8so454972wyg.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:sender:from:to:date:subject;
        bh=SJDCUEgRiDDM8/r9Gu5iz4uOhT7kyupYj0pIRmjQfxk=;
        b=MWAnD77SC7hTeY0kSFWNfL2bwCg/XcUPLlTCKEH49y4LfRyxJVJBzMT2sRWHBet4aJ
         ARgJ+vXMhEMJgTJHyZaXpKAItBJGNoSLIIH8kb09tv21dppKBUVh9jxIhpMDqbmA7Z1S
         BKRIePyBeaazlsEIq0cLu88lsNd8nQpvINfag=
Received: by 10.227.36.212 with SMTP id u20mr8191234wbd.35.1311197122741;
        Wed, 20 Jul 2011 14:25:22 -0700 (PDT)
Received: from localhost6.localdomain6 (bzq-79-182-4-198.red.bezeqint.net [79.182.4.198])
        by mx.google.com with ESMTPS id ff6sm514250wbb.15.2011.07.20.14.25.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jul 2011 14:25:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177549>

When executing "git pull" with no arguments, the reflog message was:
  "pull : Fast-forward"

Signed-off-by: Ori Avtalion <ori@avtalion.name>
---
 git-pull.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index a10b129..a305978 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -10,7 +10,11 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 . git-sh-i18n
-set_reflog_action "pull $*"
+if [ $# -gt 0 ]; then
+	set_reflog_action "pull $*"
+else
+	set_reflog_action "pull"
+fi
 require_work_tree
 cd_to_toplevel
 
-- 
1.7.4.1
