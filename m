From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/4] Tutorial: Cover "stg mail"
Date: Sun, 12 Oct 2008 17:11:45 +0200
Message-ID: <20081012151145.17648.59668.stgit@yoghurt>
References: <20081012150825.17648.3315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:13:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp2d0-0004du-NT
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYJLPLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 11:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbYJLPLt
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:11:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1054 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbYJLPLs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:11:48 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Kp2bg-0006Wm-00; Sun, 12 Oct 2008 16:11:44 +0100
In-Reply-To: <20081012150825.17648.3315.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98027>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/tutorial.txt |  100 ++++++++++++++++++++++++++++++++++++=
++++++--
 1 files changed, 96 insertions(+), 4 deletions(-)


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index e9d8b22..46c78cf 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -431,17 +431,109 @@ patches as patches.
 Workflow: Tracking branch
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
+In the 'Development branch' workflow described above, we didn't have
+to worry about other people; we're working on our branch, they are
+presumably working on theirs, and when the time comes and we're ready
+to publish our branch, we'll probably end up merging our branch with
+those other peoples'. That's how Git is designed to work.
=20
-Rebasing a patch series
------------------------
+Or rather, one of the ways Git is designed to work. An alternative,
+popular in e.g. the Linux kernel community (for which Git was
+originally created), is that contributors send their patches by e-mail
+to a mailing list. Others read the patches, try them out, and provide
+feedback; often, the patch author is asked to send a new and improved
+version of the patches. Once the project maintainer is satisfied that
+the patches are good, she'll 'apply' them to a branch and publish it.
=20
-TODO:: rebase, ...
+StGit is ideally suited for the process of creating patches, mailing
+them out for review, revising them, mailing them off again, and
+eventually getting them accepted.
=20
=20
 Getting patches upstream
 ------------------------
=20
-TODO:: export, mail, ...
+We've already covered how to clone a Git repository and start writing
+patches. As for the next step, there are two commands you might use to
+get patches out of StGit: stglink:mail[] and stglink:export[].
+stglink:export[] will export your patches to a filesystem directory as
+one text file per patch, which can be useful if you are going to send
+the patches by something other than e-mail. Most of the time, though,
+stglink:mail[] is what you want.
+
+NOTE: Git comes with tools for sending commits via e-mail. Since StGit
+patches are Git commits, you can use the Git tools if you like them
+better for some reason.
+
+NOTE: For exporting single patches -- as opposed to a whole bunch of
+them -- you could also use stglink:show[] or stglink:diff[].
+
+Mailing a patch is as easy as this:
+
+  $ stg mail --to recipient@example.com <patches>
+
+You can list one or more patches, or ranges of patches. Each patch
+will be sent as a separate mail, with the first line of the commit
+message as subject line. Try mailing patches to yourself to see what
+the result looks like.
+
+NOTE: stglink:mail[] uses +sendmail+ on your computer to send the
+mails. If you don't have +sendmail+ properly set up, you can instruct
+it to use any SMTP server with the +$$--smtp-server$$+ flag.
+
+There are many command-line options to control exactly how mails are
+sent, as well as a message template you can modify if you want. The
+man page has all the details; I'll just mention two more here.
+
++$$--edit-cover$$+ will open an editor and let you write an
+introductory message; all the patch mails will then be sent as replies
+to this 'cover message'. This is usually a good idea if you send more
+than one patch, so that reviewers can get a quick overview of the
+patches you sent.
+
++$$--edit-patches$$+ will let you edit each patch before it is sent.
+You can change anything, but note that you are only editing the
+outgoing mail, not the patch itself; if you want to make changes to
+the patch, you probably want to use the regular StGit commands to do
+so. What this 'is' useful for, though, is to add notes for the patch
+recipients:
+
+----------------------------------------------------------------------
+From: Audrey U. Thor <author@example.com>
+Subject: [PATCH] First line of the commit message
+
+The rest of the commit message
+
+---
+
+Everything after the line with the three dashes and before the diff is
+just a comment, and not part of the commit message. If there's
+anything you want the patch recipients to see, but that shouldn't be
+recorded in the history if the patch is accepted, write it here.
+
+ stgit/main.py |    1 +
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+
+
+diff --git a/stgit/main.py b/stgit/main.py
+index e324179..6398958 100644
+--- a/stgit/main.py
++++ b/stgit/main.py
+@@ -171,6 +171,7 @@ def _main():
+     sys.exit(ret or utils.STGIT_SUCCESS)
+
+ def main():
++    print 'My first patch!'
+     try:
+         _main()
+     finally:
+----------------------------------------------------------------------
+
+
+Rebasing a patch series
+-----------------------
+
+TODO:: rebase, ...
=20
=20
 Importing patches
