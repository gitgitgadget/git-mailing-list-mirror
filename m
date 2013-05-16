From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Revert "remote-hg: update bookmarks when pulling"
Date: Thu, 16 May 2013 07:43:15 -0500
Message-ID: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 14:44:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcxY9-00026L-GJ
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 14:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab3EPMop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 08:44:45 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:45413 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3EPMoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 08:44:44 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so3578033oah.40
        for <git@vger.kernel.org>; Thu, 16 May 2013 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=SBBsqoQj4CTVcdQwLGnZuqYELN+RaiDxlvh6uhtviNE=;
        b=uq99qtnSBWIYMgC++21u0KDJcok6wCjh5EknFOPLTCEd6nnEqfsPelTTrS/rD4l3hf
         tbgQEY60BVdSlxbDzmxRCEIOr7E51iBSi4wrUyF0kghDAhhOuchzfOkQzF1UeuTc75AE
         ylsygCv9rHFbe7HHDsPGuiBACaEf93PeUkotf3aaHqh8yGC1D9rrWJYlWCJrxRPFtrfA
         xlCoWKEiiGSQbCIlXeDYTxECg6p6nAJJGSWqnHYy/f0HTyJicExAs2oLsSCLX7yrJOJ6
         3FzD+UoobzHpFVXsEt0HiFsKyW+TYhbqvSnm1SrEKFGLXQsfjIr89Dmm3YnEebCdiV+s
         pTeQ==
X-Received: by 10.182.118.226 with SMTP id kp2mr12947034obb.48.1368708284376;
        Thu, 16 May 2013 05:44:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qj8sm7756639oeb.2.2013.05.16.05.44.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 05:44:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224559>

This reverts commit 24317ef32ac3111ed00792f9b2921dc19dd28fe2.

Different versions of Mercurial have different arguments for
bookmarks.updatefromremote(), while it should be possible to call the
right function with the right arguments depending on the version, it's
safer to restore the old behavior for now.

Reported by Rodney Lorrimar.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Intended for master (v1.8.3).

 contrib/remote-helpers/git-remote-hg | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index dc276af..beb864b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -363,9 +363,6 @@ def get_repo(url, alias):
                 die('Repository error')
             repo.pull(peer, heads=None, force=True)
 
-        rb = peer.listkeys('bookmarks')
-        bookmarks.updatefromremote(myui, repo, rb, url)
-
     return repo
 
 def rev_to_mark(rev):
-- 
1.8.3.rc2.542.g24820ba
