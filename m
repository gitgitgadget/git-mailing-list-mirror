From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] remove vim syntax highlighting in favor of upstream
Date: Mon, 29 Sep 2008 22:08:14 +0200
Message-ID: <20080929200814.GA19840@neumann>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de>
	<20080924155745.GA3908@coredump.intra.peff.net>
	<20080924170154.GA6816@neumann>
	<20080924175315.GA10337@coredump.intra.peff.net>
	<20080924195658.GB6816@neumann>
	<20080929145542.GA18340@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vim@tpope.info, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 29 22:09:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkP3p-0004Lk-Dz
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 22:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYI2UI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Sep 2008 16:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbYI2UI0
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 16:08:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:61979 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbYI2UIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 16:08:25 -0400
Received: from [127.0.1.1] (p5B133359.dip0.t-ipconnect.de [91.19.51.89])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1KkP2U0Tqf-0000iF; Mon, 29 Sep 2008 22:08:16 +0200
Content-Disposition: inline
In-Reply-To: <20080929145542.GA18340@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+fmpk9QAjZkdn/EdKpPLZD3EUqqOJ5teruk95
 VVng2UYY+2B/c9APjxTmuIvevMn2PMeB23RzBy2Ef9A8AXGDUD
 z6p+cRja7s3Thi+Q9zZ9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97048>

As of version 7.2, vim ships with its own syntax
highlighting for git commit messages, which is:

  1. more comprehensive in splitting up the various
     components of the file

  2. in accordance with the usual vim behavior for syntax
     highlighting (e.g., respecting b:current_syntax)

  3. presumably better maintained (I have not been using
     what's in git's contrib/ directory for some time in
     favor of the upstream version)

=46urthermore, vim upsream also provides syntax highlighting
for other git filetypes (gitconfig, rebase, send-email).

This patch gets rid of our local version and just points
interested parties to the upstream version.

The code for auto-detecting filetypes is taken from vim's
runtime/filetype.vim.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Mon, Sep 29, 2008 at 07:55:42AM -0700, Shawn O. Pearce wrote:
> Missing SBO line?
Here it is.  Since significant parts of the patch and the commit
message are from Jeff, maybe he should sign off, too?

Note, that this patch is slightly different from the previous one, as
it proposes writing the auto-detect commands into ~/.vim/filetype.vim
instead of ~/.vimrc.  It's not quite clear to me why, but it seems to
resolve the filetype confusion I mentioned in my previous email.


 contrib/vim/README               |   38 ++++++++++++++++++++++++++++++=
--------
 contrib/vim/syntax/gitcommit.vim |   18 ------------------
 2 files changed, 30 insertions(+), 26 deletions(-)
 delete mode 100644 contrib/vim/syntax/gitcommit.vim

diff --git a/contrib/vim/README b/contrib/vim/README
index 9e7881f..c487346 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -1,8 +1,30 @@
-To syntax highlight git's commit messages, you need to:
-  1. Copy syntax/gitcommit.vim to vim's syntax directory:
-     $ mkdir -p $HOME/.vim/syntax
-     $ cp syntax/gitcommit.vim $HOME/.vim/syntax
-  2. Auto-detect the editing of git commit files:
-     $ cat >>$HOME/.vimrc <<'EOF'
-     autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=3Dgitcommi=
t
-     EOF
+Syntax highlighting for git commit messages, config files, etc. is
+included with the vim distribution as of vim 7.2, and should work
+automatically.
+
+If you have an older version of vim, you can get the latest syntax
+files from the vim project:
+
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git.v=
im
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitco=
mmit.vim
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitco=
nfig.vim
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitre=
base.vim
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitse=
ndemail.vim
+
+To install:
+
+  1. Copy these files to vim's syntax directory $HOME/.vim/syntax
+  2. To auto-detect the editing of various git-related filetypes:
+	$ cat >>$HOME/.vim/filetype.vim <<'EOF'
+	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
+	autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
+	autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
+	autocmd BufNewFile,BufRead .msg.[0-9]*
+		\ if getline(1) =3D~ '^From.*# This line is ignored.$' |
+		\   setf gitsendemail |
+		\ endif
+	autocmd BufNewFile,BufRead *.git/**
+		\ if getline(1) =3D~ '^\x\{40\}\>\|^ref: ' |
+		\   setf git |
+		\ endif
+	EOF
diff --git a/contrib/vim/syntax/gitcommit.vim b/contrib/vim/syntax/gitc=
ommit.vim
deleted file mode 100644
index 332121b..0000000
--- a/contrib/vim/syntax/gitcommit.vim
+++ /dev/null
@@ -1,18 +0,0 @@
-syn region gitLine start=3D/^#/ end=3D/$/
-syn region gitCommit start=3D/^# Changes to be committed:$/ end=3D/^#$=
/ contains=3DgitHead,gitCommitFile
-syn region gitHead contained start=3D/^#   (.*)/ end=3D/^#$/
-syn region gitChanged start=3D/^# Changed but not updated:/ end=3D/^#$=
/ contains=3DgitHead,gitChangedFile
-syn region gitUntracked start=3D/^# Untracked files:/ end=3D/^#$/ cont=
ains=3DgitHead,gitUntrackedFile
-
-syn match gitCommitFile contained /^#\t.*/hs=3Ds+2
-syn match gitChangedFile contained /^#\t.*/hs=3Ds+2
-syn match gitUntrackedFile contained /^#\t.*/hs=3Ds+2
-
-hi def link gitLine Comment
-hi def link gitCommit Comment
-hi def link gitChanged Comment
-hi def link gitHead Comment
-hi def link gitUntracked Comment
-hi def link gitCommitFile Type
-hi def link gitChangedFile Constant
-hi def link gitUntrackedFile Constant
--=20
1.6.0.2.330.gcef5c
