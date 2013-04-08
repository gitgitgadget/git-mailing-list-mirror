From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/7] remote-bzr: only update workingtree on local repos
Date: Mon,  8 Apr 2013 12:27:13 -0500
Message-ID: <1365442036-25732-5-git-send-email-felipe.contreras@gmail.com>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFru-0001Hy-D6
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934752Ab3DHR2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:28:30 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:33457 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934447Ab3DHR23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:28:29 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so6549659oah.14
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gxEH7GG3JgEX9nswbS8/l/E+pDph8NJ8ZizVqnRtqy0=;
        b=y4DduKdk52IUstKOMI32KtKmNJ+6YKTVcPmvbt+mEL3sPbfd0zaZQ9NxiQR+2P5D2A
         UX2DyS2FEv1jkOr4/RmPFrEBpHSxkI2dCyFa8kkTWeyjZGLHBiB6yhbXkpGoy75a+Rd5
         zbSBszJ6mEsock1bAhVNH5HNghCwupVZtTtFfGyMVGMn6PK9SxdpvDF0LMnJJlvYrBO/
         SsPYzNA+KEQumr6XemgBvtzLdTFQqMk+3lHgFEOlN8DAAnFjG+BMeACAIU7Y92i04pFx
         qaW5plXa05zxuLM9xYNT+A9px1GDM5LaCzX0eQjzQ0ylGNCyyFVW2+yiD5+mERKhXLpE
         7PLQ==
X-Received: by 10.60.131.98 with SMTP id ol2mr15727999oeb.37.1365442108930;
        Mon, 08 Apr 2013 10:28:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id v8sm26180416oea.4.2013.04.08.10.28.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:28:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220468>

Apparently, that's the only way it's possible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index a99a924..9466cb9 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -630,10 +630,9 @@ def do_export(parser):
                     peer.import_last_revision_info_and_tags(repo, revno, revid)
                 else:
                     peer.import_last_revision_info(repo.repository, revno, revid)
-                wt = peer.bzrdir.open_workingtree()
             else:
                 wt = repo.bzrdir.open_workingtree()
-            wt.update()
+                wt.update()
         print "ok %s" % ref
     print
 
-- 
1.8.2
