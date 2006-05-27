From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] Do not call 'cmp' with non-existant -q flag.
Date: Sat, 27 May 2006 18:39:31 +0200
Message-ID: <20060527163931.474.19611.stgit@gandelf.nowhere.earth>
References: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 18:35:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk1l8-0000Rf-FT
	for gcvg-git@gmane.org; Sat, 27 May 2006 18:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWE0QfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWE0QfO
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 12:35:14 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:33423 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S964904AbWE0QfN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 12:35:13 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 4E5AC225D6;
	Sat, 27 May 2006 18:35:12 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fk1ws-0006uY-Ua; Sat, 27 May 2006 18:47:34 +0200
To: junkio@cox.net
In-Reply-To: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20863>


I cannot find when that flag was removed if it ever existed, I can find
nothing about it in the ChangeLog and NEWS file of GNU diff.  The current
flag is -s aka --quiet aka --silent, so let's use -s, assuming it is a
portable flag.  Feel free to lart me with a POSIX bible if needed.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 git-cvsexportcommit.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index f994443..ed87dc9 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -151,7 +151,7 @@ foreach my $f (@bfiles) {
     my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
     chomp $blob;
     `git-cat-file blob $blob > $tmpdir/blob`;
-    if (system('cmp', '-q', $f, "$tmpdir/blob")) {
+    if (system('cmp', '-s', $f, "$tmpdir/blob")) {
 	warn "Binary file $f in CVS does not match parent.\n";
 	$dirty = 1;
 	next;
