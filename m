From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] rebase: use -f for checkout
Date: Wed, 10 Apr 2013 21:11:24 +0300
Message-ID: <1365617484-5181-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 20:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPzUj-0004ub-TO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935623Ab3DJSLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:11:37 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:65017 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761894Ab3DJSLh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:11:37 -0400
Received: by mail-ee0-f49.google.com with SMTP id l10so366311eei.36
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=YuZLlbFYt0VfwAtsFcNeOKD2u6uGGaPl2s6wEp9y4go=;
        b=uvBdgof2czBnFFkhOZ6ufkXfsb1hUviHYiq3C+9exkfe5UQBddcJTSOQZ9d4C4FE0F
         9pn1Fj8DvPq7OPfpGSFgI4tCzLrOLOu6VzXm2cwIpSvEZ0OR1pUucpf+oGXx8SXD7buR
         nI8Mm2nRFWTdw7YP4EB75DbjRWsEhG2j+OJvvpQ3cyUHto/D11l/rDW7jQmygFcRHmNu
         twiepOcaWMt+dhHwiLsjWRPMkUJmNteE22SXMa8T31eyvc/SRDMyQXzhIrU+gBtRS97Q
         xDAoWk3oXlfcPy4ogg9Jxn8E5F5dCSKGSGMVZ4P70e7luEM+STUauS7gsN6bKIJGAo2O
         Bdzg==
X-Received: by 10.15.35.193 with SMTP id g41mr7761709eev.45.1365617495812;
        Wed, 10 Apr 2013 11:11:35 -0700 (PDT)
Received: from localhost.localdomain ([77.127.168.32])
        by mx.google.com with ESMTPS id s47sm1217393eeg.8.2013.04.10.11.11.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 11:11:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220711>

If a file's case is changed on rename (Foo -> foo), rebase
fails on Windows because the file already exists.

The change is safe, because if working directory is not clean
rebase fails before checking out.
---
 git-rebase.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b2f1c76..28fdc32 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -522,7 +522,7 @@ test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
-git checkout -q "$onto^0" || die "could not detach HEAD"
+git checkout -fq "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
 # If the $onto is a proper descendant of the tip of the branch, then
-- 
1.7.10.4
