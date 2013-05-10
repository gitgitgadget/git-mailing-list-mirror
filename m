From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/6] remote-hg: don't push fake 'master' bookmark
Date: Fri, 10 May 2013 15:59:22 -0500
Message-ID: <1368219566-1399-3-git-send-email-felipe.contreras@gmail.com>
References: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 23:01:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauRF-0000pF-5R
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab3EJVBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:01:03 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:55083 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab3EJVA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:00:59 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so5375766oah.7
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=c0bpGhExSiZbZ5vHonYl2FAFkrmsfYwbt6ZSRFFqPgk=;
        b=jTtgXbgosA9tuxPtKOlvbi6FR/3FaqCfOIaSRWzB7AYEiPNDoMp8RC2JYUoHPtjzB9
         Y8k8q0kJ51m1vykEqK93qkVNN13Ifdme4lvdncDJtSQ5whK5Iv1G3ZLhmHAHZv7B1G93
         tKO1sNDu4tRH+o5BK9juiWM2iR5gg3GBwaeE0VNXFCif4bMOv8lr8x+Eu7qdS04+oxPl
         6K4Ae6NqMXapQD7IFl2cH5y7MRiBY9EOJhufaF1MA2Lo2H+7tR0q0+hHkoNdDFvKDpjH
         bmX2MCo9TonE3Y/ahQPVB7fLfwb6zSN3Mtg//1KPjqsqn3zsfknPly5dcT2bv1SAfFXq
         1DnQ==
X-Received: by 10.60.62.198 with SMTP id a6mr8101494oes.22.1368219658856;
        Fri, 10 May 2013 14:00:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm4710349oes.6.2013.05.10.14.00.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 14:00:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223910>

We skip it locally, but not for the remote, so let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 84901e9..14e7395 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -867,7 +867,8 @@ def do_export(parser):
 
         if bmark == 'master' and 'master' not in parser.repo._bookmarks:
             # fake bookmark
-            pass
+            print "ok %s" % ref
+            continue
         elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
             # updated locally
             pass
-- 
1.8.3.rc1.579.g184e698
