From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn rebase issues (the commiter gets changed)
Date: Wed, 28 Nov 2007 23:52:05 -0800
Message-ID: <20071129075205.GB32277@soma>
References: <94ccbe710711220815j663d22e0v3c744244d0a87b66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kelvie Wong <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxeCW-0002wV-7X
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 08:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbXK2HwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 02:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbXK2HwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 02:52:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42613 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbXK2HwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 02:52:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 34AEC7DC109;
	Wed, 28 Nov 2007 23:52:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <94ccbe710711220815j663d22e0v3c744244d0a87b66@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66512>

Kelvie Wong <kelvie@ieee.org> wrote:
> When using git-svn rebase (I'm not sure if this happens with a regular
> rebase as well, I use use git-svn primarily at work), the following
> oddity happens:
> 
> kelvie@mudd (working) qt $ git-cat-file commit
> c27e6207c9078d4225288d55454d6577f0135c16
> tree 13d9ef9cc67f5e6381d7697e5794c0ab5f72c729
> parent b9eb187d3029c5f9a816cb8f5473d9b239952d53
> author kwong <kwong@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195596864 +0000
> committer cscrimgeour
> <cscrimgeour@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195691944 +0000

This is strange.  Does this commit end below? or did you truncate
the git-svn-id: line from this message?

> 
> Qt/FME Extensions: QFMEDialog/QFMEWizard -> Windows only, for now
> 
> This is also a reapplication of r39657, which got rolled back.
> 
> These have dependencies on QWinWidget (which is a part of the MFC/Qt Migration
> Solution), and thus, it does not build without it.
> <kw>
> kelvie@mudd (working) qt $ git-cat-file commit
> 7075991c67c6d409ec2315dfeef6f45dd328485b
> tree 13d9ef9cc67f5e6381d7697e5794c0ab5f72c729
> parent b9eb187d3029c5f9a816cb8f5473d9b239952d53
> author kwong <kwong@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195596864 +0000
> committer Kelvie Wong <Kelvie.Wong@safe.com> 1195747291 +0000

This commit hasn't made it into SVN, yet, right?  If so, then that's
alright.

> 
> Qt/FME Extensions: QFMEDialog/QFMEWizard -> Windows only, for now
> 
> This is also a reapplication of r39657, which got rolled back.
> 
> These have dependencies on QWinWidget (which is a part of the MFC/Qt Migration
> Solution), and thus, it does not build without it.
> <kw>
> 
> 
> These are both the exact same commit (the tree, parent, and author are
> equivalent).
> 
> Sometimes (not always), the committer in a commit changes to be the
> committer of the parent (svn) commit.  This only happens to the
> commits whose parent is the SVN commit.  In the above example,
> cscrimgeour is a SVN user, who obviously could not have changed my
> code; the proper commit is the one at the bottom.
> 
> Both of these are the first local commit that I have rebased onto SVN.

Did you get these commits by cherry-picking (or format-patch + am)
from another SVN branch?  Have these commits been made to SVN already?

`gitk --reflog --all' may reveal some answers or clarify
things for you (assuming you have reflogs enabled in .git/config).

Rebase (all forms of it) *does* rewrite committer info, but how you got
cscrimgeour in there is very strange to me.

-- 
Eric Wong
