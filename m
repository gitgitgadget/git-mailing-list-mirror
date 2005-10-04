From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] commit object name in git-diff-tree output header?
Date: Tue, 04 Oct 2005 00:28:20 -0700
Message-ID: <7virwdeo6j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 04 09:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMhDu-0000EX-0u
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 09:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVJDH2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 03:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVJDH2W
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 03:28:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:57574 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932464AbVJDH2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 03:28:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004072811.TDCQ29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 03:28:11 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9668>

This is a request for help from your clueless/forgetful
maintainer.

With a single commit as its parameter, 'git-diff-tree' outputs
the name of the commit object when run without the -v flag as
its first line, like this:

    $ git-diff-tree -p HEAD
    22a27042603fc9068ca562a8b5c46b3417f99777
    diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
    --- a/Documentation/git-apply.txt
    +++ b/Documentation/git-apply.txt
    @@ -9,7 +9,7 @@ git-apply - Apply patch on a GIT index f

     SYNOPSIS
     --------
     ...

I have a vague recollection to have seen some code that detects
this ^[0-9a-f]{40}$ pattern and uses it as a separator between
logical patchset, but I seem to be unable to find it now.

Does anybody have scripts that depend on this behaviour?  This
commit object name is carried over to format-patch output, and I
would like to change it now.  So if your own patch acceptance
script relies on this behaviour, please speak up before I break
it.

This has been the format since Jun 23, change made by Linus.
Before that change, we used to say two commit object ID, like
this:

    $ git-diff-tree -p HEAD
    aefa4a5... (from 5fca669...)
    diff --git a/apply.c b/apply.c
    --- a/apply.c
    +++ b/apply.c
    @@ -860,7 +860,6 @@ static int find_offset(const char *buf,
    ...
