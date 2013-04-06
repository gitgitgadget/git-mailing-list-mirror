From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/7] remote-bzr: only update workingtree on local repos
Date: Fri,  5 Apr 2013 21:49:20 -0600
Message-ID: <1365220163-13581-5-git-send-email-felipe.contreras@gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 20:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSE-0001b9-H1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163200Ab3DFDvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 23:51:55 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46788 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162359Ab3DFDvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:51:54 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so2147957obc.29
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=gxEH7GG3JgEX9nswbS8/l/E+pDph8NJ8ZizVqnRtqy0=;
        b=zB5w+hrV4jyJnh70mlV1Z/TgooME/Qg2DI7OGKgyEj3/oU0jek0si/GS078xljd9e/
         4kLcHVV/tEKpt7qWCou4rlpmYn2VgiIQxnoTS+aIWhkWmO5IWuXtMgnmRkkFG1pKuGlD
         Z+CoVyru8DSL5kfgy3e+4+VoCl8MmAwBRl4W/wLU6Q2JAn2CoPhaEotQbr4aIh+Opg5N
         OMJpHidFQHEKe15SmKMT1ytSknjbASlDwbIi1CKMyNfqp1zHlGuNHderZA9mLcn4IsB1
         0u54WHxrQDrxYisHJxSJN74tYysLXYXhpbrPqv5Fwjd44fkkoQ0fEkOdorb8d349A/Z2
         ofHg==
X-Received: by 10.182.188.69 with SMTP id fy5mr10144950obc.14.1365220314388;
        Fri, 05 Apr 2013 20:51:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id zc8sm14673064obc.8.2013.04.05.20.51.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:51:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220256>

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
