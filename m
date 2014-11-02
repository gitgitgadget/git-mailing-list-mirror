From: Chris Packham <judge.packham@gmail.com>
Subject: [gitk PATCH] gitk: Default wrcomcmd to use --pretty=email
Date: Sun,  2 Nov 2014 21:40:10 +1300
Message-ID: <1414917610-13508-1-git-send-email-judge.packham@gmail.com>
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Nov 02 09:43:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkqlO-00028b-5o
	for gcvg-git-2@plane.gmane.org; Sun, 02 Nov 2014 09:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbaKBIkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2014 03:40:25 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:58445 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaKBIkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2014 03:40:24 -0500
Received: by mail-pd0-f176.google.com with SMTP id ft15so9777312pdb.21
        for <git@vger.kernel.org>; Sun, 02 Nov 2014 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Pf5HHHkjPuBMjJ+32o+StMeR6oWH6a5RCgUdltDYwLk=;
        b=QgcaLnGVHgXIZ70YPx9rvC9MeZactiTaBFG5WHfOCGmgyzr2qN5j9FKeQv3cu7avIt
         xIX8nfO/fqpBaRx7sDZyG+EYIJ3VdEzGwJIFAAfn1uS8x2fvANNHR8IOQrWmtBhQa3Yy
         ROdj2pahk7j2Ob/bDRs2UeLEBfbXdpgDagxbgr23K8v09/iGueVFtbTi4nOclvcUorIV
         yXtJnF4HdfDY2FhpXWZ0Vv2UqoA8PLnojaGDnvraajxrFLzP8FnA7Bo4gQuZ7nQ68Lnb
         IobV+eVA76iWe6DLwEiIXGfUBT+eM+QaRojO5v5YEsFxh4169o6G5I84TordO7aDkHsW
         hh5g==
X-Received: by 10.70.127.169 with SMTP id nh9mr1402492pdb.115.1414917624152;
        Sun, 02 Nov 2014 01:40:24 -0700 (PDT)
Received: from chrisp-ll.ws.atlnz.lc (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id v15sm1331082pdj.96.2014.11.02.01.40.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Nov 2014 01:40:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the "Write commit to file" context menu option generate a file that
is consumable by 'git am'.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Hi Paul,

This is the other side of a git patch I was looking at a while ago[1]. The basic
problem was people were using gitk's "Write commit to file" functionality to
generate patches for me to apply. It was hard to convince git am to consume these.

Eventually after some pointers from Junio I realised that if gitk just used
 --pretty=email then it would generate files that were consumable by git am.
Just adding =email is the minimal change to make things work but it might be a
good idea to add --stat to make it more patch-like (or just switch to using
format-patch).
--
[1] - http://article.gmane.org/gmane.comp.version-control.git/256424
[2] - http://article.gmane.org/gmane.comp.version-control.git/256543

 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 78358a7..462f966 100755
--- a/gitk
+++ b/gitk
@@ -11936,7 +11936,7 @@ if { [info exists ::env(GIT_TRACE)] } {
 }
 
 # defaults...
-set wrcomcmd "git diff-tree --stdin -p --pretty"
+set wrcomcmd "git diff-tree --stdin -p --pretty=email"
 
 set gitencoding {}
 catch {
-- 
2.0.4
