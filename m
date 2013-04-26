From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/9] remote-hg: use hashlib instead of hg sha1 util
Date: Thu, 25 Apr 2013 19:08:18 -0500
Message-ID: <1366934902-18704-6-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:10:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEk-0003nL-2C
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258Ab3DZAJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:09:55 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40280 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab3DZAJx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:53 -0400
Received: by mail-ob0-f174.google.com with SMTP id wc20so3067814obb.33
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pz2bHdiFo4kpwfh3q1wLJlRtE+FyiwzPKXHojjkdKe0=;
        b=Y24X3+/FTDuGpDMMws2FdiYureJMgCh5SRLrJu++BAeEYWdhtLq/ndoj/rO8GsjTF6
         B5FqJtrcw9hxFhaIwy2yfTC1f+kpzNEtm9hMbixtiVSDiflKPZ2GM9CzUIExRcHa46c8
         Pd1bzJ04zzhtLI+pKf1SXzqGeIJyggVHwA9E6uI0wbQ6rqi66jf744Z0rdNobNVy8jrA
         jFqdLhhhVmd5hVxgPR1qYlPZBL/GaMGwhr4NMs2S8fNf+VagrFDBwzJrbYBWZjFAeQ9s
         HOiI26EVPqEJGtYHn5Lo7vaFiJNo7ymMv2CMrCnpQwlQO7uGlDyXGvWjBRHBvabyVuPq
         RhWQ==
X-Received: by 10.182.156.20 with SMTP id wa20mr16579212obb.59.1366934992986;
        Thu, 25 Apr 2013 17:09:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm5892456oep.1.2013.04.25.17.09.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222474>

To be in sync with remote-bzr.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 80b3606..06920f2 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -22,7 +22,7 @@ import shutil
 import subprocess
 import urllib
 import atexit
-import urlparse
+import urlparse, hashlib
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -933,7 +933,7 @@ def main(args):
 
     if alias[4:] == url:
         is_tmp = True
-        alias = util.sha1(alias).hexdigest()
+        alias = hashlib.sha1(alias).hexdigest()
     else:
         is_tmp = False
 
-- 
1.8.2.1.884.g3532a8d
