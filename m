From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/20] remote-hg: update remote bookmarks
Date: Mon,  8 Apr 2013 12:13:24 -0500
Message-ID: <1365441214-21096-11-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFfp-0005gW-Kr
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761383Ab3DHRPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:20 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:47661 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3DHRPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:16 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so6530640oag.32
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=v1zdC7hlmuzUXNHAHyCYW7Os5ufCxMxfzvY5AnKnBwA=;
        b=GLK0Q4xcokDCCHvgY5H73tH8p7ftd9i/T+uoIa1mYAHehWwJgIfeL/SQOlYffY2PJW
         8CjhXI5ZqvdEt/RLmyVFgDq17fPbP06C1bDSR3iYG8OM/4GADXkvB6epEmr5guKEGodj
         YTtJ9dQNCy8aGA3slfv3zjyXDANcc6k7lC57ma3AAO7cwuxaQkjyn/OH95TyPoYMInVq
         QtJ9BnnaQ6tooBH9g8VBTmmGJ7JoUyQ0o34WTAm4iJdZXuD7gP7yON/HZEsPy1XtXdVM
         UXHII+K1CKMH7YXVi29Zy/Su1iV2/LN9aczRkQXQVKhkvpee5222Q7hgm3fNU1lQ/wSk
         Ppyg==
X-Received: by 10.60.83.113 with SMTP id p17mr1777628oey.31.1365441315426;
        Mon, 08 Apr 2013 10:15:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id d10sm26134074oeh.7.2013.04.08.10.15.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220451>

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
