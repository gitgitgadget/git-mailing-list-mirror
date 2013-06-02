From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] completion: correct completion for format-patch
Date: Sun,  2 Jun 2013 19:33:40 +0530
Message-ID: <1370181822-23450-5-git-send-email-artagnon@gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 02 16:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj8vI-0000ue-Vt
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab3FBOGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:06:13 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37178 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3FBOGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:06:08 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so370874pbb.36
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4+iQX1MzFaOEToMd7BmiGwmAhqh9D4cTmO8HsJMCwAI=;
        b=UG2xSpdamNIB7FtJ4mj03Tvlo76L33ZQhJ3zVCz1xmUa3/+UaaMlQse7M2hky4tQ2+
         yuSWqJt6EcnckkJQc3sQfKC+5e3JqUFdXQgx27A3qDfVfBbS8fQ10RBxI70SuTWwzahK
         WVCG5KcW6GmB8yYJAcOg4SHfD04+1u4l9cSjVCliDhQJYHCTOLUdA3Bu/dmSL3xqea+I
         7EIabWMN5gJO94U8edgfLvZragIom5VUsvDDPvhZ/mq+6ibCse5DpBsUYZ5arDcYRimV
         DvQAWtcQruqSlYRSCRLz09PZieJytMbtMKhRLz5/tFMHa4BnCA9tz3S9T4k9eiJ+g4m6
         U83A==
X-Received: by 10.66.139.8 with SMTP id qu8mr16856444pab.132.1370181967348;
        Sun, 02 Jun 2013 07:06:07 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id aj2sm55150689pbc.1.2013.06.02.07.06.05
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 07:06:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.457.g2410d5e
In-Reply-To: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226155>

Currently, the completion for 'git format-patch' uses
__git_complete_revlist.  Although this is technically correct, and you
can

  $ git format-patch master contrib

where master is a ref and contrib is a pathspec, just like in 'git log',
the usage is unidiomatic and undocumented.  'git format-patch' is used
without pathspec filtering most of the time, and it makes sense to
provide sensible completions using __git_refs.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a003b81..f46964d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1347,7 +1347,7 @@ _git_format_patch ()
 		return
 		;;
 	esac
-	__git_complete_revlist
+	__gitcomp_nl "$(__git_refs)"
 }
 
 _git_fsck ()
-- 
1.8.3.457.g2410d5e
