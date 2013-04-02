From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/13] remote-hg: properly report errors on bookmark pushes
Date: Tue,  2 Apr 2013 13:02:52 -0600
Message-ID: <1364929382-1399-4-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Vb-0006r2-9R
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888Ab3DBTEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:08 -0400
Received: from mail-gg0-f170.google.com ([209.85.161.170]:59224 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3DBTEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:07 -0400
Received: by mail-gg0-f170.google.com with SMTP id k4so112240ggn.29
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6RnqPkOzcSu/6IgaZeg8/+MHi2o/J089wvX3sg7PyhQ=;
        b=0kSAeR1pkwagml9ZolbLr0NB+NN2Cd38WGweeF1RTTVU3CJUSk0dTDH/d0it7CTOr/
         U2rMj9Q5AMrMAu2XeQuXsaJ7Kw6s5E/hY/5834UqKgVYhWYVrV5Nta5CgSVuYZOGBDdv
         LRbNFEx7cMzVTDQrAZjJG2zicOsg19wlKdSwKWE52j4OcDosjIGZz6m74n+gKLRp0HX2
         Gm80lpNbETNzPsd/nT1xBrdFC7NtKwi0ENoY9ph8mAIHJ+JcMk3kJRmHvd59b1lK8oO2
         D54atIvj2UeifDhwa51PpZvrlnmtthfubHk5yAdIkjul2bfEaxsWrLCs7DqbrDxwwUJ8
         /uHQ==
X-Received: by 10.236.123.142 with SMTP id v14mr16093547yhh.83.1364929446645;
        Tue, 02 Apr 2013 12:04:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 30sm4897635yhb.6.2013.04.02.12.04.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219834>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 844ec50..19eb4db 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -710,6 +710,7 @@ def do_export(parser):
             else:
                 old = ''
             if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+                print "error %s" % ref
                 continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
-- 
1.8.2
