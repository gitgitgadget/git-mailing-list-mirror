From: imyousuf@gmail.com
Subject: [JGit Patch 5/6] Add script for adding second pack for test purpose
Date: Thu, 21 Aug 2008 08:47:27 +0600
Message-ID: <1219286848-22758-5-git-send-email-imyousuf@gmail.com>
References: <1219286848-22758-1-git-send-email-imyousuf@gmail.com>
 <1219286848-22758-2-git-send-email-imyousuf@gmail.com>
 <1219286848-22758-3-git-send-email-imyousuf@gmail.com>
 <1219286848-22758-4-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 04:50:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0FT-0002Sv-3e
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbYHUCsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 22:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYHUCsw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:48:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63077 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbYHUCsu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 22:48:50 -0400
Received: by nf-out-0910.google.com with SMTP id d3so366908nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Cy4ISoX+RK8xLVBr2EmWUwUG8pYAAGzxJ4M+rH/civY=;
        b=A/IyShe3ziY9R5APIs7ddU1lZXXy1vx8IfEMCVQI8AMKeJ4BDipmrUNJ9Rst/1bSnm
         cqOZUgvILIBswQd1Yc8AtsYrbxcVCg0OC8TBsjHt9g72SkFVmfsV0Vq8Ps59HJo1NdDy
         oeSnjHAoIOMrmWE+Gyqxhd4ltsXr+gqEUvlN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=shgSqYMGoWkuinUcqEL9YOI9zGz0+QOxtrhxoHv+a9vaGSfwP/LBTQddUZYse9h1Dl
         LeHL/MSZ48gbrVRraXN1bkCKQFFpVTqgP7JpiU6xWM4vYogRLO/Ix3M3DckzOUCeDmAz
         /paLQYybU2bEyV6jkTiViK7qGiTh9/wyMGp1I=
Received: by 10.210.61.8 with SMTP id j8mr1121131eba.94.1219286929662;
        Wed, 20 Aug 2008 19:48:49 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id k5sm2516627nfh.0.2008.08.20.19.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 19:48:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1219286848-22758-4-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93095>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Forgot to add it last time and thus adding it before removing duplicate
resources.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../spearce/jgit/test/resources/create-second-pack |  136 ++++++++++++++++++++
 1 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100755 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
new file mode 100755
index 0000000..03f83dc
--- /dev/null
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
@@ -0,0 +1,136 @@
+#!/bin/bash -ex
+
+export GIT_COMMITTER_NAME="A U Thor"
+export GIT_AUTHOR_NAME="A U Thor"
+export GIT_COMMITTER_EMAIL="a.u.thor@example.com"
+export GIT_AUTHOR_EMAIL="a.u.thor@example.com"
+
+test_tick () {
+	# from git/t/test-lib.sh
+	if test -z "${test_tick+set}"
+        then
+                test_tick=1112911993
+        else
+                test_tick=$(($test_tick + 60))
+        fi
+        GIT_COMMITTER_DATE="$test_tick -0700"
+        GIT_AUTHOR_DATE="$test_tick -0700"
+        export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+}
+
+git_commit () {
+	test_tick
+	git commit "$@"
+}
+
+git_merge () {
+	test_tick
+	git merge "$@"
+
+}
+
+test_tick
+rm -rf .git *.txt ?
+git init
+echo "On master" >>master.txt
+git add master.txt
+git_commit -a -m "On master"
+
+echo "On master" >>master.txt
+git_commit -a -m "On master again"
+
+git checkout -b a 6c8b137b1c652731597c89668f417b8695f28dd7
+mkdir a
+
+echo a1 >>a/a1.txt
+git add a/a1.txt
+git_commit -a -m "First a/a1"
+
+echo a2 >>a/a2.txt
+git add a/a2.txt
+git_commit -a -m "First a/a2"
+
+git merge master
+
+echo a1 >>a/a1.txt
+git add a/a1.txt
+git_commit -a -m "Second a/a1"
+git branch pa
+
+echo a2 >>a/a2.txt
+git add a/a2.txt
+git_commit -a -m "Second a/a2"
+
+git checkout -b b 58be4659bb571194ed4562d04b359d26216f526e
+
+mkdir b
+echo b1 >>b/b1.txt
+git add b/b1.txt
+git_commit -a -m "First b/b1"
+
+echo b2 >>b/b2.txt
+git add b/b2.txt
+git_commit -a -m "First b/b2"
+
+git merge a
+
+echo b1 >>b/b1.txt
+git add b/b1.txt
+git_commit -a -m "Second b/b1"
+
+echo b2 >>b/b2.txt
+git add b/b2.txt
+git_commit -a -m "Second b/b2"
+
+rm -rf a b c master.txt
+mkdir c
+rm -f ./git/index
+echo ref: refs/heads/c >.git/HEAD
+
+echo c1 >>c/c1.txt
+git add c/c1.txt
+git_commit -a -m "First c/c1, no parent"
+
+echo c2 >>c/c2.txt
+git add c/c2.txt
+git_commit -a -m "First c/c2"
+
+git_merge a
+
+echo c1 >>c/c1.txt
+git add c/c2.txt
+git_commit -a -m "Second c/c1"
+
+echo c2 >>c/c2.txt
+git add c/c2.txt
+git_commit -a -m "Second c/c2"
+
+git_merge b
+
+git checkout -b d a
+
+echo "a1" >>a/a1
+git add a/a1
+git_commit -a -m "Third a/a1"
+
+git checkout -b e a
+
+echo "a1" >>a/a1
+git add a/a1
+git_commit -a -m "Fourth a/a1"
+
+git checkout master
+
+git_merge c d e
+
+git repack -d
+
+git tag A a
+git tag -a -m "An annotated tag" B a^
+
+git repack -d
+
+git pack-refs --all
+
+
+qgit --all master
-- 
1.5.6
