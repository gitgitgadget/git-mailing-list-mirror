From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool: export variables for use by custom mergetools
Date: Sat, 17 May 2008 13:39:26 -0700
Message-ID: <8b4e944ac849029f31f403ab75198ed6fb4197c1.1211056369.git.davvid@gmail.com>
Cc: git@vger.kernel.org, evgeny.zislis@gmail.com,
	David Aguilar <davvid@gmail.com>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Sat May 17 22:45:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxTH8-0001cx-3F
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 22:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198AbYEQUoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 16:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbYEQUoQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 16:44:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:28029 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbYEQUoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 16:44:15 -0400
Received: by rv-out-0506.google.com with SMTP id l9so738883rvb.1
        for <git@vger.kernel.org>; Sat, 17 May 2008 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=UKpMtlI6+T9up0VqYX6UeGYZiZpwPW7NutbD+rMmKfA=;
        b=l8/9g1Xj79hdvwDioFVYcTT5TH6vzUFGrr7Ol/N6SP+HezusotEERDWM0m8vqxBJbsMfwD3apnO54IHrDM0O+NPeSHtqkyfTyb95onxV8KfCi+5FnBK2KuMFkAtj6xWl82WreavP2GuhhIMfCfZ8tHvD013HWvp02QqyRAljbAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Fm3ycoPDnnRL+3tijF+PaYRx+OSJ5vZIWOl9Hg6EvE14dWQfMziKNXB36aHRcMA92Vg9D3vmQX8uhnrLQncevsMMPWdAH/qcDHi6UnT4gM1nuuyF/Eh/VLI1weXjEh8x3AYWJHaDbNXUmG6Y9Cx0yyTOje5Yxufl+nLAlEhZPIw=
Received: by 10.141.163.12 with SMTP id q12mr2626113rvo.265.1211057052796;
        Sat, 17 May 2008 13:44:12 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id c20sm8646415rvf.1.2008.05.17.13.44.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 May 2008 13:44:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82362>

The MERGED, BACKUP, LOCAL, REMOTE and BASE variables were not being
exported from the git-mergetool.sh script.  This prevented custom
mergetools from being able to use them.

We now export them so that arbitrary mergetools can easily interact
with git mergetool.

This problem was Reported-By: Evgeny <evgeny.zislis@gmail.com>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index fcdec4a..c4f31ee 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -146,6 +146,12 @@ merge_file () {
     REMOTE="$MERGED.REMOTE.$ext"
     BASE="$MERGED.BASE.$ext"
 
+    export MERGED
+    export BACKUP
+    export LOCAL
+    export REMOTE
+    export BASE
+
     mv -- "$MERGED" "$BACKUP"
     cp -- "$BACKUP" "$MERGED"
 
-- 
1.5.5.1
