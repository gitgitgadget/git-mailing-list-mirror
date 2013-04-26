From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 7/9] remote-bzr: tell bazaar to be quiet
Date: Fri, 26 Apr 2013 16:12:37 -0500
Message-ID: <1367010759-17928-8-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpyR-0007W3-UB
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516Ab3DZVOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:19 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36878 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab3DZVOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:17 -0400
Received: by mail-ob0-f180.google.com with SMTP id uk5so3994812obc.11
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+bVXvgEo2TRvoyFcFlDiuYuAmLUgaz/lZsSBussYw9A=;
        b=h+Q63M2of0Xc/dZlH6bkF9PcmSkfakuSFLF0ah36z87LSFCHa/sPM7GIrpQavN55co
         cc/Bqq2giKHQ/0+SIx6mGV9eHjyGPZTeLhHg9oCZ1RBIsNzakFb+/24UFL/2PyYukX0C
         ssPUQgB779LtDKCiff04yFgR8EfRMl9K+C3L78UQLxLEP9qKSv3Tb+LhIf01/GrEsFvm
         qG2hgH8CcboUMlva2CaDHzbHaZdbJC4ZnCHxI2UfgNpXT3iIb1YklPn15SkIMsIiFRJ3
         mlMeX8uNRcOconIKoCoU43BdMk9i5MqAJNMTjhrIvx958+fxpXMKM+iZfCvOGf2zuLmK
         h8oA==
X-Received: by 10.182.105.227 with SMTP id gp3mr22905574obb.81.1367010855919;
        Fri, 26 Apr 2013 14:14:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm9738124oep.1.2013.04.26.14.14.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:14:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222589>

Otherwise we get notification, progress bars, and what not.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index dda2932..8617e25 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -26,6 +26,7 @@ bzrlib.plugin.load_plugins()
 import bzrlib.generate_ids
 import bzrlib.transport
 import bzrlib.errors
+import bzrlib.ui
 
 import sys
 import os
@@ -755,6 +756,8 @@ def main(args):
     if not os.path.exists(dirname):
         os.makedirs(dirname)
 
+    bzrlib.ui.ui_factory.be_quiet(True)
+
     repo = get_repo(url, alias)
 
     marks_path = os.path.join(dirname, 'marks-int')
-- 
1.8.2.1.1031.g2ee5873
