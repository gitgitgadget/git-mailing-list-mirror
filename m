From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git diff --added (Re: Command-line interface thoughts)
Date: Mon, 13 Jun 2011 03:06:18 -0500
Message-ID: <20110613080617.GC4570@elie>
References: <201106051311.00951.jnareb@gmail.com>
 <201106101844.16146.jnareb@gmail.com>
 <4DF25D50.5020107@ira.uka.de>
 <201106102035.42525.jnareb@gmail.com>
 <4DF29EA5.60502@ira.uka.de>
 <20110613034347.GA4222@elie>
 <buotybu2wx7.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 10:06:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW2AJ-0004CD-3i
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 10:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab1FMIG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 04:06:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43806 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab1FMIGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 04:06:23 -0400
Received: by iwn34 with SMTP id 34so3616683iwn.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JlPwApJNMELA/Ae31gkLPFBNRx2zxNOjXeytHbmaFcc=;
        b=JB/R5l13LWi52AWY9DsGV0JJ3v7tzrlJnpJPMuB98zK6euBNimiOLnz/MJXP58hEL9
         fYzduqAkRz0vAzK/Thxq5rfxz82vXaP7JPm5ogyT2xl2RbdqsLzqw6TLSBbOae+2BmvW
         L0rkrto5iqMmn4XKZ1VCtc5srmYhQ3ddm2V68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cGN/oFidwu/Pfs2V1U4PjN4r/MKq+7sdi/HVCS/ZTQCxbfYhxj94vTLWrmqkFX5GRg
         p8lVBBQzs23Asu5chpktUOC0xb4xkhdCB+nH7iywl/YgoiwZLKLOpaUjhAw1SE+m4jtm
         OywWYabFz5l+67wXVAtMlM/hp0vrGu3cOPmlc=
Received: by 10.42.156.195 with SMTP id a3mr7041000icx.460.1307952382017;
        Mon, 13 Jun 2011 01:06:22 -0700 (PDT)
Received: from elie (adsl-68-255-110-0.dsl.chcgil.sbcglobal.net [68.255.110.0])
        by mx.google.com with ESMTPS id r1sm3692165icz.14.2011.06.13.01.06.19
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 01:06:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <buotybu2wx7.fsf@dhlpc061.dev.necel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175691>

Miles Bader wrote:

> "--added" sounds very awkward though; "--staged" is much more natural.

You make a strong case.  How about something like this?

-- >8 --
Subject: Documentation: explain diff --cached in terms of non --cached form

"git diff" is a somewhat odd command, since it has two fairly
different roles:

 - on one hand, it is the command to explain the worktree or index in
   terms of something else;
 - on the other hand, it is the command to compare two blobs, trees,
   or on-disk files.

To a new user, that second role might seem to be the most basic and
most natural, since it is most closely analagous to the ordinary
non-git "diff" command, but in practice the first one is the one that
gets used most often and it is somewhat different.  Avoid surprises
by treating this first role separately in the introductory paragraph
and calling it "primary".

The motivation is that it is hard enough to remember the various 0-
and 1-tree forms of "git diff"; hopefully fending off the distraction
of a false analogy with 2-tree "git diff" will help with that.  This
patch also tries to clarify those mnemonics (especially: "--cached"
mean to use the index in place of the worktree) by rearranging the
material slightly.  The most obvious mechanical changes involved are
listing 0- and 1-tree "git diff" separately in the synopsis and
reordering the text to put "git diff HEAD" before "git diff --cached
HEAD".

Some small wording improvements snuck in while at it, including
mentioning the --staged synonym for --cached a little more often.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-diff.txt |   61 +++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index f8d0819..7a66017 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -9,59 +9,64 @@ git-diff - Show changes between commits, commit and working tree, etc
 SYNOPSIS
 --------
 [verse]
-'git diff' [options] [<commit>] [--] [<path>...]
+'git diff' [options] [--] [<path>...]
+'git diff' [options] <commit> [--] [<path>...]
 'git diff' [options] --cached [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] [--no-index] [--] <path> <path>
 
 DESCRIPTION
 -----------
-Show changes between the working tree and the index or a tree, changes
-between the index and a tree, changes between two trees, or changes
-between two files on disk.
+The primary purpose of 'git diff' is to compare files in the working
+tree to stored versions in the repository.  It can also be used to
+show changes between the index and a tree, changes between two trees,
+or changes between two files on disk.
 
-'git diff' [--options] [--] [<path>...]::
+'git diff' [options] [--] [<path>...]::
 
 	This form is to view the changes you made relative to
-	the index (staging area for the next commit).  In other
-	words, the differences are what you _could_ tell git to
-	further add to the index but you still haven't.  You can
-	stage these changes by using linkgit:git-add[1].
+	the index (staging area for the next commit).  It is
+	the most common use of 'git diff'; the differences are
+	what you _could_ tell git to further add to the index
+	but you still haven't.  You can stage these changes by
+	using linkgit:git-add[1] (aka linkgit:git-stage[1]).
 +
-If exactly two paths are given and at least one points outside
-the current repository, 'git diff' will compare the two files /
-directories. This behavior can be forced by --no-index.
+If exactly two paths are given and one points outside the current
+repository, 'git diff' will compare the two files or directories.
+This behavior can be forced with the `--no-index` option.
 
-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
-
-	This form is to view the changes you staged for the next
-	commit relative to the named <commit>.  Typically you
-	would want comparison with the latest commit, so if you
-	do not give <commit>, it defaults to HEAD.
-	If HEAD does not exist (e.g. unborned branches) and
-	<commit> is not given, it shows all staged changes.
-	--staged is a synonym of --cached.
-
-'git diff' [--options] <commit> [--] [<path>...]::
+'git diff' [options] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
-	use HEAD to compare it with the latest commit, or a
+	use HEAD to compare with the latest commit, or a
 	branch name to compare with the tip of a different
 	branch.
 
-'git diff' [--options] <commit> <commit> [--] [<path>...]::
+'git diff' [options] --cached [<commit>] [--] [<path>...]::
+'git diff' [options] --staged [<commit>] [--] [<path>...]::
+
+	If passed --cached or its synonym --staged,
+	'git diff' will view the changes you have staged for
+	the next commit instead of examining the working tree.
+	Typically you would want a comparison with the latest
+	commit, so if you do not give <commit>, it defaults
+	to HEAD.
+	If HEAD does not exist (e.g. unborn branches) and
+	<commit> is not given, it shows all staged changes.
+
+'git diff' [options] <commit> <commit> [--] [<path>...]::
 
 	This is to view the changes between two arbitrary
-	<commit>.
+	commits.
 
-'git diff' [--options] <commit>..<commit> [--] [<path>...]::
+'git diff' [options] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the previous form.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
-'git diff' [--options] <commit>\...<commit> [--] [<path>...]::
+'git diff' [options] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
-- 
1.7.6.rc1
