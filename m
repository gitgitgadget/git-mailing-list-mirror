From: "Neal Kreitzinger" <neal@rsss.com>
Subject: interactive rebase editor pathname variable
Date: Thu, 13 May 2010 13:32:35 -0500
Message-ID: <hshglg$p2q$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 20:33:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCdEB-00051Y-QW
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 20:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268Ab0EMSdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 14:33:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:42682 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759259Ab0EMSdi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 14:33:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OCdDy-0004uQ-9B
	for git@vger.kernel.org; Thu, 13 May 2010 20:33:34 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 May 2010 20:33:34 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 May 2010 20:33:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147019>

Hi,

It appears that git-commit and git-tag pass a partial pathname to the 
core.editor, e.g. ".git/COMMIT_EDITMSG" that is relative to the working tree 
directory.  However, git-rebase -i passes an absolute pathname to the 
core.editor, e.g. 
"home/someuser/someworkingtree/.git/rebase-merge/git-rebase-todo".  This 
causes problems in our shop because our proprietary editor cannot handle 
pathnames beginning with a period (it translates the period to a slash) and 
therefore our entry for core.editor is 'someeditor "$PWD/$1"'.  This breaks 
on git rebase -i when the $1 contains the full pathname.  Can this be added 
to the bugfix list for git to make the $1 value passed to core.editor by all 
git commands to always be relative pathnames (or absolute pathnames).  FWIW, 
I prefer absolute pathnames because a config entry of 'someeditor $1' is 
more straightforward than 'someeditor "$PWD/$1"'.  (Note:  the reason I must 
pass $1 is because the editor runs on top of a runtime and is actually 
called as 'someruntime someeditor "$1"')

v/r,
Neal 
