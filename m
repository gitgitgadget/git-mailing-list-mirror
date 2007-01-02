From: =?ISO-8859-1?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>
Subject: [RFC] git-svn: make git-svn commit-diff able to work without explicit
 arguments
Date: Tue, 02 Jan 2007 19:23:26 +0100
Message-ID: <459AA31E.5070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 02 19:23:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1oIR-0005uk-HD
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 19:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbXABSXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 13:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbXABSXc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 13:23:32 -0500
Received: from mailfe04.swip.net ([212.247.154.97]:56051 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754893AbXABSXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 13:23:31 -0500
X-Cloudmark-Score: 0.000000 []
Received: from [83.182.28.216] (HELO [10.0.0.13])
  by mailfe04.swip.net (CommuniGate Pro SMTP 5.0.12)
  with ESMTP id 371374835 for git@vger.kernel.org; Tue, 02 Jan 2007 19:23:28 +0100
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35794>

Hello,

When using git-svn to access a SVN repo, the commit policy may vary. 
While git makes you commit small patches often, svn users tend to prefer 
bigger patches that implement a functionnality at once.

So at the end you have a SVN commit which corresponds to several git ones.

What you can do in this case is :

   git-svn commit-diff --edit -r$REV remotes/git-svn HEAD

Which effect is that it commits (at once) all the commits between the 
latest svn fetch and HEAD.

What I'm proposing here is this:

  - use the latest fetched rev the default for the -r argument.
  - use remotes/git-svn and HEAD the defaults for the treeish objects.

A smarter way to take these defaults would be to take the last revision 
in the current branch (which can be something else than git-svn if it 
wasn't rebased/merged recently) and the relevant commit in the current 
branch.

Additionnaly, --edit could be enabled by default if -m is not set and it 
is used interactively, eventually using an option in repo-config.

Any comment ?
