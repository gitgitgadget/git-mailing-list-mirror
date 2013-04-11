From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/21] remote-hg: update remote bookmarks
Date: Thu, 11 Apr 2013 07:23:06 -0500
Message-ID: <1365682997-11329-11-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYl-0007U0-GX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349Ab3DKMY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:56 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:41341 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMYz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:55 -0400
Received: by mail-qe0-f50.google.com with SMTP id a11so851627qen.9
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=A5N/OLdNQCmE02KXvoz3oXy5Gt3YI1eD6E5N12pqZGM=;
        b=uZO+fp88AzJEmCshT/94EDo3tZtWRBYIF8/I4gOFdvSFtkbtHxX0ofq7XkLF56bCL3
         CiTdaBxoTUsTlB3If6pmhJM550tZKAAV71U35ELClS9Li0HRxG/dpMvVlOX3iAzqrt9V
         VIWGiyuVYcIYWxzN6ysF26j8SjdAwWhQFV3g0eKiqRkZlnEHzqG+moRayJmYFe2UykRz
         myWx8jx7vS4GXDakUoNU62L7sFndPKUWsT4QSSBJ5DKBZaVLwc5lorcPsRQgyOZPjFvT
         WgA5mWpxATCQBZH1PFyD1Zg0GZscGgQWSKmHJmZLppF16J/0rYDNPmRvefKzQcwMz9Wy
         KbjA==
X-Received: by 10.229.206.131 with SMTP id fu3mr2464061qcb.7.1365683095201;
        Thu, 11 Apr 2013 05:24:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id e2sm6304528qey.3.2013.04.11.05.24.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220861>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3ceec85..46cddc9 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -744,6 +744,11 @@ def do_export(parser):
             print "error %s" % ref
             continue
 
+        if peer:
+            if not peer.pushkey('bookmarks', bmark, old, new):
+                print "error %s" % ref
+                continue
+
         print "ok %s" % ref
 
     print
-- 
1.8.2.1
