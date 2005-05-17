From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] improved delta support for git
Date: Tue, 17 May 2005 20:22:32 +0200
Message-ID: <20050517182232.GM13508@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R+My9LyyhiUvIEro"
X-From: git-owner@vger.kernel.org Tue May 17 20:25:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY6i2-0007GV-PG
	for gcvg-git@gmane.org; Tue, 17 May 2005 20:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVEQSWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 14:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEQSWu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 14:22:50 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:42646 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261265AbVEQSWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 14:22:33 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4HIMWS8002061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 17 May 2005 18:22:32 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4HIMW0D002057
	for git@vger.kernel.org; Tue, 17 May 2005 20:22:32 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Nicolas,
I just tried it against Linus git-HEAD. It worked like a charm so far. I
imported mutt-1.5 CVS branch using cvsps (1103 patches).

(medion) [/scratch/mutt/mutt-cvs] git-rev-tree HEAD | wc -l
1103
(medion) [/scratch/mutt/mutt-cvs] du -sh .git/objects/
63M     .git/objects/
(medion) [/scratch/mutt/mutt-cvs] git-deltafy-script -d 2000
...
(medion) [/scratch/mutt/mutt-cvs] du -sh .git/objects/
35M     .git/objects/

Maybe you should add git-deltafy-script and git-mkdelta to the installation
targets (patch attached).

And I wonder why the mutt CVS Repository is still smaller than the
zdelta compressed mutt git repository. And with mutt CVS Repository I
mean every commit since mutt-0.9x not only mutt-1.5 branch?

(faui03) [~] du -sh work/mutt/cvsrepository
34M     work/mutt/cvsrepository

Greetings,
	Thomas

--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

[PATCH] Install git-mkdelta and git-deltafy-script

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,7 @@
 INSTALL=install
 
 SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
-	git-pull-script git-tag-script git-resolve-script
+	git-pull-script git-tag-script git-resolve-script git-deltafy-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
@@ -28,7 +28,7 @@
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
-	git-get-tar-commit-id
+	git-get-tar-commit-id git-mkdelta
 
 all: $(PROG)
 

--R+My9LyyhiUvIEro--
