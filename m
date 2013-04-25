From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/9] remote-hg: use hashlib instead of hg sha1 util
Date: Thu, 25 Apr 2013 06:20:45 -0500
Message-ID: <1366888849-19607-6-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:22:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKGL-0004fJ-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053Ab3DYLWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:40 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60959 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab3DYLWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:38 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so2343296obc.23
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bI7KMypGDFjQj+r5qCEGEOQS/4r6VUkSKgYRB+qouuQ=;
        b=JGiZqVbJHOJJHJnA4BuoVI6kfn+N0OFV0Wjf9FS2x6Y3XtUno/7AQTw5oV6TAXIOnq
         o44QM5pn7E+eYaRN10Pl9Xb6Np6rR4xBnAXD7M3LuPfjEwuOVWesyF/pUFDSnAkq2tBq
         +oV4ZDx8gR7LXMRrBFlYvmBvqyrDRHKnS6d7mNw85dcT1H9pWnQNMrJKUtDTdkYY+w/e
         41YZLUwVwZ2cYK24bTer5DIT8elm5Zt2rdsTah4OSw+3gmOhuXBxwCaKWXtVW/e4dT9Q
         i8TZpMn3VheY2YaZPQ6f7HYbt80mOuUX20v7+MsYckWryBI+Pb8RcVZ7ZFSB74TJm3c6
         ExGA==
X-Received: by 10.182.112.202 with SMTP id is10mr19257856obb.8.1366888958270;
        Thu, 25 Apr 2013 04:22:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qt5sm3191373oeb.4.2013.04.25.04.22.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222373>

To be in sync with remote-bzr.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0b7c81f..99abda4 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -22,6 +22,7 @@ import shutil
 import subprocess
 import urllib
 import atexit
+import hashlib
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -830,7 +831,7 @@ def main(args):
 
     if alias[4:] == url:
         is_tmp = True
-        alias = util.sha1(alias).hexdigest()
+        alias = hashlib.sha1(alias).hexdigest()
     else:
         is_tmp = False
 
-- 
1.8.2.1
