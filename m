From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] remote-hg: don't push fake 'master' bookmark
Date: Fri, 10 May 2013 05:17:00 -0500
Message-ID: <1368181023-10402-2-git-send-email-felipe.contreras@gmail.com>
References: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 12:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UakPn-0001xR-E6
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 12:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab3EJKSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 06:18:36 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52844 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3EJKSe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 06:18:34 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so4678612oag.5
        for <git@vger.kernel.org>; Fri, 10 May 2013 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=snFYfKFtm9RkK67tSeiRRoofYqHNlBMBZ42ebdqijsc=;
        b=yQuIlk0sYJWkeXNYlIta+m3Uam/65xldw/J1yNrk/tQTjdzsY5yz7gSVcT0shrWkgg
         X7rTEy8M+E2gHDz1seb7if/EWkgPJgVj1yuwyLr57J0fvThqKxTBAow6YuMzK9Pjfb/4
         2Op01kQTcFSuFdzrX4D8JARpRGyxNP2IEyiGua1Gh4YY9/B9J2+TbO7JmmOwlEuVTKoB
         14syfvBIY67c54YB2HKMzVNFEa7+CdzUCRKAPA59LUx9pSBCN+XyiK8oinU286Cr6ZI2
         0QOtaFiyEusPlEC7kfldR3xdJTooh2dR8jWzZ5G1RLgFWhwsrfchWuVd7FgSSEe1xRzp
         JYdw==
X-Received: by 10.182.129.129 with SMTP id nw1mr6603204obb.100.1368181113906;
        Fri, 10 May 2013 03:18:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm2153530obb.7.2013.05.10.03.18.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 03:18:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.555.gd13b5a0
In-Reply-To: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223827>

We skip it locally, but not for the remote, so let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 96ad30d..5647ed5 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -867,7 +867,7 @@ def do_export(parser):
 
         if bmark == 'master' and 'master' not in parser.repo._bookmarks:
             # fake bookmark
-            pass
+            continue
         elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
             # updated locally
             pass
-- 
1.8.3.rc1.555.gd13b5a0
