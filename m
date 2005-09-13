From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 5/5] Use the 'die' function where it is appropriate.
Date: Tue, 13 Sep 2005 23:41:39 +0200
Message-ID: <20050913214139.GF10953@c165.ib.student.liu.se>
References: <20050913213730.GA10953@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Sep 13 23:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFIX9-0006cS-M9
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVIMVll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVIMVll
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:41:41 -0400
Received: from [85.8.31.11] ([85.8.31.11]:16007 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751012AbVIMVlk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 17:41:40 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 9CA02411B; Tue, 13 Sep 2005 23:46:44 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EFIX5-0002uv-00; Tue, 13 Sep 2005 23:41:39 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050913213730.GA10953@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8494>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 gitMergeCommon.py |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

bd535d629be12d94648a40c2feb89cf14482f772
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
--- a/gitMergeCommon.py
+++ b/gitMergeCommon.py
@@ -1,19 +1,24 @@
 import sys, re, os, traceback
 from sets import Set
 
+def die(*args):
+    printList(args, sys.stderr)
+    sys.exit(2)
+
+def printList(list, file=sys.stdout):
+    for x in list:
+        file.write(str(x))
+        file.write(' ')
+    file.write('\n')
+
 if sys.version_info[0] < 2 or \
        (sys.version_info[0] == 2 and sys.version_info[1] < 4):
-    print 'Python version 2.4 required, found', \
-          str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+ \
-          str(sys.version_info[2])
-    sys.exit(1)
+    die('Python version 2.4 required, found', \
+        str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+ \
+        str(sys.version_info[2]))
 
 import subprocess
 
-def die(*args):
-    printList(args, sys.stderr)
-    sys.exit(2)
-
 # Debugging machinery
 # -------------------
 
@@ -32,12 +37,6 @@ def debug(*args):
         if funcName in functionsToDebug:
             printList(args)
 
-def printList(list, file=sys.stdout):
-    for x in list:
-        file.write(str(x))
-        file.write(' ')
-    file.write('\n')
-
 # Program execution
 # -----------------
 
