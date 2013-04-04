From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/13] remote-hg: update remote bookmarks
Date: Thu,  4 Apr 2013 09:30:19 -0600
Message-ID: <1365089422-8250-11-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9i-0004ZS-OQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762399Ab3DDPby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57025 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762598Ab3DDPbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:51 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm15so78021obc.19
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=v1zdC7hlmuzUXNHAHyCYW7Os5ufCxMxfzvY5AnKnBwA=;
        b=JoSrOkuT4KWkEWBjAvBX8zoIQWToNOPfAdJLw97P8AyNt8o1tp0FAElcY/oarPQND8
         87iXOuvgAGx+opqzZXX/O4SXrfBoJ+CcCRo5bgOZlSIQ1QzWeEnV9OdKolqI17DL17nG
         uB1shQKbF+7jHFGq4IcI7EDvOSGHXAZ2COCaeIBmoEkauIURWy954rlHXp/dBSrXeZZl
         dMaVHdaU37xFd7a5Jl9r1OPCRVbzPnILyG6eCexnokb9wUkVhY+gPpS86zP6Ad+am/lU
         DzZpLKEjOO4vnYmh9XCgo7Q6oJhXPQjJE3OWYAtCBYJrUaJpdFE5ZGD7h3VqnYUb66Xf
         8j6g==
X-Received: by 10.60.7.97 with SMTP id i1mr4693669oea.89.1365089511117;
        Thu, 04 Apr 2013 08:31:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id qk4sm6788319obc.5.2013.04.04.08.31.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220014>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c741f13..b54de1e 100755
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
1.8.2
