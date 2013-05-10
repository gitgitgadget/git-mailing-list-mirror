From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] remote-hg: update bookmarks when pulling
Date: Fri, 10 May 2013 05:17:01 -0500
Message-ID: <1368181023-10402-3-git-send-email-felipe.contreras@gmail.com>
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
	id 1UakPn-0001xR-Un
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 12:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab3EJKSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 06:18:40 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:51175 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3EJKSh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 06:18:37 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so396586oag.14
        for <git@vger.kernel.org>; Fri, 10 May 2013 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dYPkes5P9drsTV7dQJILUQ5Bgx35tQuhqdIqZwmUdF8=;
        b=eOOoyMRAJNVvWPAtQzIk/Evoxz2YB3IO4d8PcQHNCZ6QTveVGa0vf4fiFbAVcbM4Dc
         kw7KdMjO9pj8FTIzw6cSUfZ5ekjx/GHihCJMazjLU3sS5E93alFXCRHmeH/yeg63BZg6
         Eq78yiBjmpz2q5ePPihojQgI9PbTzsG6beKH/HLEzgLLGDznNMGz0W0DulhUbzLKcRI+
         O/U46w9DVdWaAdfZuX3tpWO63EvT5WtPo7hC1zwsI64NXHSeRZrs2D5hwIPS/RcOZciX
         5lxu14My8MEeASEkN8CRWWc0EkI2wszRA4S3VXkfddQb2Uoz+aFOyTvGTXUVu4cuuEFV
         n5Gw==
X-Received: by 10.182.224.162 with SMTP id rd2mr6494436obc.95.1368181117147;
        Fri, 10 May 2013 03:18:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm2280024oeb.0.2013.05.10.03.18.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 03:18:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.555.gd13b5a0
In-Reply-To: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223828>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 5647ed5..85b9319 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -357,6 +357,9 @@ def get_repo(url, alias):
                 die('Repository error')
             repo.pull(peer, heads=None, force=True)
 
+        rb = peer.listkeys('bookmarks')
+        bookmarks.updatefromremote(myui, repo, rb, url)
+
     return repo
 
 def rev_to_mark(rev):
-- 
1.8.3.rc1.555.gd13b5a0
