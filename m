From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Documentation/branch: briefly explain what a branch is
Date: Sun, 30 Jan 2011 15:35:10 -0600
Message-ID: <20110130213510.GC10039@burratino>
References: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
 <20110130160556.GI5713@localhost.localdomain>
 <20110130213258.GA10039@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Sm/Do28=?= Paulo Melo de Sampaio <jpmelos@gmail.com>,
	GIT Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Jan 30 22:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjevf-0007WL-2p
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 22:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab1A3VfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 16:35:22 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46027 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab1A3VfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 16:35:21 -0500
Received: by ywe10 with SMTP id 10so1730857ywe.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l+vrpjI3L2tupIrHVYEP/lXZyp6Pb8/tXCXCh+FXdxA=;
        b=nMIZogxfvZBAD+8Vv/tLDWMgV7EQEt1Qek507Fvr6o9Rw0fisnqRm5lUV894TfCIIh
         obudiPLiH3QoEQh6rNlzo+xZmgxcgIICwjEl74wBbMO1g+uIx8YD5Ne/SeyhX4u+JY3W
         psWzchbiHdb01yw/zsvuws4PUBYojiT+dR3PA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pXY+2gUsxU+trCA0YWMB/XETrceXpYMKt2oMnCyEJrLob0wfbcHH5eXV6UkB+L03+/
         g2Df74aed46Rod0Yisbl8QRRO/MxjaPL6tg0mhWxHsb84ORVLaBzYJgUwvfXaZHUbNlb
         YQkFi2SBcEb2DD6rVaQGv6YZlCbKuq0a8Mxxs=
Received: by 10.236.108.43 with SMTP id p31mr10929786yhg.69.1296423320847;
        Sun, 30 Jan 2011 13:35:20 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id i18sm4027049yhd.22.2011.01.30.13.35.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 13:35:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110130213258.GA10039@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165703>

The new reader might not know what git refs are, that history is a
graph, the distinction between local, remote-tracking, and remote
branches, or how to visualize what is going on.  After this change,
those things are still probably not evident but at least there is an
early reminder of some of it.

Also explain how to create a branch before explaining how to list
them.  Based roughly on the description of v0.99.1~53 (Add "git
branch" script, 2005-07-11).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-branch.txt |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d3eeb94..abad7ba 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -18,6 +18,26 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
+Branches are references to commit objects, representing the tip of a
+line of history.  The branch you are working on is referred to
+by HEAD and the corresponding reference is updated each time
+linkgit:git-commit[1] or linkgit:git-merge[1] makes a new commit.
+
+'git branch' <branchname> [<start-point>]::
+	Creates a new branch named `<branchname>`.
+	If a starting point is specified, that will be where the branch
+	is created; otherwise, the new branch points to the `HEAD` commit.
++
+This will create a new branch, but it does not switch the working tree
+to it.  Use "git checkout <newbranch>" to start working on the new branch.
+
+When a local branch is started off a remote-tracking branch, git sets up the
+branch so that 'git pull' will appropriately merge from
+the remote-tracking branch. This behavior may be changed via the global
+`branch.autosetupmerge` configuration flag. That setting can be
+overridden by using the `--track` and `--no-track` options, and
+changed later using `git branch --set-upstream`.
+
 'git branch' [-r | -a]::
 	With no arguments, existing branches are listed and the current
 	branch will be highlighted with an asterisk.
@@ -34,21 +54,6 @@ DESCRIPTION
 	commit will be listed.  If the <commit> argument is missing it
 	defaults to 'HEAD' (i.e.  the tip of the current branch).
 
-'git branch' <branchname> [<start-point>]::
-	The command's second form creates a new branch head named <branchname>
-	which points to the current 'HEAD', or <start-point> if given.
-+
-Note that this will create the new branch, but it will not switch the
-working tree to it; use "git checkout <newbranch>" to switch to the
-new branch.
-+
-When a local branch is started off a remote-tracking branch, git sets up the
-branch so that 'git pull' will appropriately merge from
-the remote-tracking branch. This behavior may be changed via the global
-`branch.autosetupmerge` configuration flag. That setting can be
-overridden by using the `--track` and `--no-track` options, and
-changed later using `git branch --set-upstream`.
-
 'git branch' (-m | -M) <oldbranch> <newbranch>::
 	With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 	If <oldbranch> had a corresponding reflog, it is renamed to match
-- 
1.7.4.rc3
