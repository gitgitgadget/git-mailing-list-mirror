From: Jeff King <peff@peff.net>
Subject: [PATCH] contrib/vim: add syntax highlighting file for commits
Date: Mon, 11 Sep 2006 19:22:49 -0400
Message-ID: <20060911232249.GB29736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 01:26:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMvAC-0003uY-Os
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 01:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWIKXXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 19:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWIKXXF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 19:23:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:6882 "HELO
	peff.net") by vger.kernel.org with SMTP id S965110AbWIKXWv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 19:22:51 -0400
Received: (qmail 16661 invoked from network); 11 Sep 2006 19:22:01 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Sep 2006 19:22:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Sep 2006 19:22:49 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26865>


Signed-off-by: Jeff King <peff@peff.net>
---
There were at least a few positive comments on this, and hey, we have to
balance the contrib/emacs directory!

 contrib/vim/README            |    7 +++++++
 contrib/vim/commit-syntax.vim |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/contrib/vim/README b/contrib/vim/README
new file mode 100644
index 0000000..bad0a05
--- /dev/null
+++ b/contrib/vim/README
@@ -0,0 +1,7 @@
+To syntax highlight git's commit messages, you need to:
+  1. Copy commit-syntax.vim to vim's syntax directory:
+     $ cp commit-syntax.vim $HOME/.vim/syntax/gitcommit.vim
+  2. Auto-detect the editing of git commit files:
+     $ cat >>$HOME/.vimrc <<'EOF'
+     autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
+     EOF
diff --git a/contrib/vim/commit-syntax.vim b/contrib/vim/commit-syntax.vim
new file mode 100644
index 0000000..a9de09f
--- /dev/null
+++ b/contrib/vim/commit-syntax.vim
@@ -0,0 +1,18 @@
+syn region gitLine start=/^#/ end=/$/
+syn region gitCommit start=/^# Updated but not checked in:$/ end=/^#$/ contains=gitHead,gitCommitFile
+syn region gitHead contained start=/^#   (.*)/ end=/^#$/
+syn region gitChanged start=/^# Changed but not updated:/ end=/^#$/ contains=gitHead,gitChangedFile
+syn region gitUntracked start=/^# Untracked files:/ end=/^#$/ contains=gitHead,gitUntrackedFile
+
+syn match gitCommitFile contained /^#\t.*/hs=s+2
+syn match gitChangedFile contained /^#\t.*/hs=s+2
+syn match gitUntrackedFile contained /^#\t.*/hs=s+2
+
+hi def link gitLine Comment
+hi def link gitCommit Comment
+hi def link gitChanged Comment
+hi def link gitHead Comment
+hi def link gitUntracked Comment
+hi def link gitCommitFile Type
+hi def link gitChangedFile Constant
+hi def link gitUntrackedFile Constant
-- 
1.4.2.g39f1
