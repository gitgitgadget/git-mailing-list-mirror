From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/6] remote-hg: update bookmarks when pulling
Date: Fri, 10 May 2013 15:59:23 -0500
Message-ID: <1368219566-1399-4-git-send-email-felipe.contreras@gmail.com>
References: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 23:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauRF-0000pF-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab3EJVBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:01:08 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:44104 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab3EJVBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:01:02 -0400
Received: by mail-ob0-f176.google.com with SMTP id wc20so4571954obb.7
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Hb17egCOKzvin8FNGRGbVViEVX3DpxDHh5givbwvp7g=;
        b=yRdcEfv/fP4WGOKubtku9LIk1uZJgUZZ+OgolV2FJxoO+VsirqROSnLo0+hnnxbA+H
         6GJiVD+tDFNpvlJ/bwIL+zxLe3aZ2Mp5c8nLtdv7AhUBHvSCYF/g/oOS6mNXiFgOZToH
         NJSkn4qSUa20LOJ5YVGBjAsdAzXtZPKCd+ytaYUAtojpGMIwGoHn+cJFaAyM/4MZCFFK
         MjzokDiLAz9ITMkzXr8dFeiRS1CKC9lP7esbNp2JEfnZmgWErEmDo6W06e+i38Svyunw
         2bVfKZJH+gbVaVhFYqaXKY02eZQvGTShuHOu7b6pJ84QyiuOVsT4PUSMP9gfMBIrzp9h
         TXZQ==
X-Received: by 10.60.101.225 with SMTP id fj1mr7709861oeb.64.1368219661545;
        Fri, 10 May 2013 14:01:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n6sm4691389oel.8.2013.05.10.14.00.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 14:01:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223909>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 14e7395..c84a7b4 100755
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
1.8.3.rc1.579.g184e698
