From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 20:05:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510302000310.27915@g5.osdl.org>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org> <7v4q6yl6wv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 05:06:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWQvV-00056Q-Pa
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 05:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVJaEFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 23:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVJaEFj
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 23:05:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751209AbVJaEFi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2005 23:05:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9V47KFR021189
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Oct 2005 20:07:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9V45WB1020879;
	Sun, 30 Oct 2005 20:05:33 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6yl6wv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10850>



On Sun, 30 Oct 2005, Junio C Hamano wrote:
> 
> I've somewhat updated git-rev-list documentation and tried to
> categorize the options into commit selectors and presentation
> modifiers.  The documentation for commands you mentioned in your
> message all talk about them describing only frequently used
> options, and refer the user to rev-list documentation.  I am not
> sure this would be enough.

I don't think people really follow the links or think very abstractly at 
all in the first place.

So I was thinking more of some explicit examples. I actually think every 
command should have an example in the man-page, and hey, here's a patch to 
start things off.

Of course, I'm not exactly "Mr Documentation", and I don't know that this 
is the prettiest way to do this, but I checked that the resulting html and 
man-page seems at least reasonable.

And hey, if the examples look like each other, that's just because I'm 
also not "Mr Imagination".

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I think most people understand a lot better from practice than from 
theory, and that an example of real usage is much more likely to make 
people udnerstand a command than just listing what it can do.

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 13a3998..9cac088 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -30,6 +30,24 @@ OPTIONS
 	Show only commits between the named two commits.
 
 
+Examples
+--------
+git log --no-merges::
+
+	Show the whole commit history, but skip any merges
+
+git log v2.6.12.. include/scsi drivers/scsi::
+
+	Show all commits since version 'v2.6.12' that changed any file
+	in the include/scsi or drivers/scsi subdirectories
+
+git log --since="2 weeks ago" -- gitk::
+
+	Show the changes during the last two weeks to the file 'gitk'.
+	The "--" is necessary to avoid confusion with the *branch* named
+	'gitk'
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index e6f57d9..6c150b0 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -51,6 +51,20 @@ OPTIONS
 	However, it is not very useful in general, although it
 	*is* useful on a file-by-file basis.
 
+Examples
+--------
+git-whatchanged -p v2.6.12.. include/scsi drivers/scsi::
+
+	Show as patches the commits since version 'v2.6.12' that changed
+	any file in the include/scsi or drivers/scsi subdirectories
+
+git-whatchanged --since="2 weeks ago" -- gitk::
+
+	Show the changes during the last two weeks to the file 'gitk'.
+	The "--" is necessary to avoid confusion with the *branch* named
+	'gitk'
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index e5ef6d6..eb126d7 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -24,6 +24,19 @@ OPTIONS
 	Some argument not yet documented.
 
 
+Examples
+--------
+gitk v2.6.12.. include/scsi drivers/scsi::
+
+	Show as the changes since version 'v2.6.12' that changed any
+	file in the include/scsi or drivers/scsi subdirectories
+
+gitk --since="2 weeks ago" -- gitk::
+
+	Show the changes during the last two weeks to the file 'gitk'.
+	The "--" is necessary to avoid confusion with the *branch* named
+	'gitk'
+
 Author
 ------
 Written by Paul Mackerras <paulus@samba.org>
