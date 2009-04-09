From: Jim Babka <babka@bestmail.us>
Subject: Re: git svn hangs
Date: Thu, 9 Apr 2009 21:15:55 +0000 (UTC)
Message-ID: <loom.20090409T210418-347@post.gmane.org>
References: <loom.20090409T195916-937@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 23:17:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls1d8-00050d-Ur
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 23:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbZDIVQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 17:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbZDIVQP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 17:16:15 -0400
Received: from main.gmane.org ([80.91.229.2]:47169 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139AbZDIVQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 17:16:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ls1bV-0004uV-4d
	for git@vger.kernel.org; Thu, 09 Apr 2009 21:16:09 +0000
Received: from 32.97.110.53 ([32.97.110.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 21:16:09 +0000
Received: from babka by 32.97.110.53 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 21:16:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 32.97.110.53 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.20) Gecko/20081217 (CK-IBM) Firefox/2.0.0.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116209>

Jim Babka <babka <at> bestmail.us> writes:

> 
> So I found that the problem is apparently the -s option. When I removed it, 
it
> started copying everything. This shouldn't have been a problem, though, 
because
> the SVN repository has a standard structure (trunk, branches and tags
> directories). Anyone have any idea why this would fail?
> 
> Jim Babka
> 
> 

Actually, I spoke too soon. It never actually copied out any files before I had
to kill it because it was going to take too long for our entire SVN repository.
So I tried to scope it down to a particular directory tree, and saw this:

------------
$ git svn clone --username babka@us.ibm.com
http://wbsfsvn.austin.ibm.com/svn/wbsf/branches/mediterranean/core
branches/mediterranean/core
Initialized empty Git repository in c:/GIT/branches/mediterranean/core/.git/
W: Ignoring error from SVN, path probably does not exist: (175007): HTTP Path
Not Found: REPORT request failed on
'/svn/wbsf/!svn/bc/100/branches/mediterranean/core':
'/svn/wbsf/!svn/bc/100/branches/mediterranean/core' path not found
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories
Path '' was probably deleted:
HTTP Path Not Found: REPORT request failed on
'/svn/wbsf/!svn/bc/18770/branches/mediterranean/core':
'/svn/wbsf/!svn/bc/18770/branches/mediterranean/core' path not found
Will attempt to follow revisions r18701 .. r18770 committed before the 
deletion

babka@CUBEARS /c/GIT
-------------
There is nothing but a .git directory. Revision 18770 does not yet exist - the
last revision is 18769, so I'm not sure why it is complaining about that. Is
there something else I need to do in order to get the git svn integration
working? Is there a problem with git-svn when the SVN repository is version 
1.5.5?

Jim Babka.
