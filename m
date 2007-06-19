From: Sergio <sergio.callegari@gmail.com>
Subject: Re: The --no-commit blues
Date: Tue, 19 Jun 2007 08:52:03 +0000 (UTC)
Message-ID: <loom.20070619T102934-84@post.gmane.org>
References: <200706180806.26255.goofyheadedpunk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 10:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0ZRq-0001rV-US
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 10:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbXFSIwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 04:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbXFSIwZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 04:52:25 -0400
Received: from main.gmane.org ([80.91.229.2]:55344 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbXFSIwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 04:52:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0ZRl-0002bh-Qr
	for git@vger.kernel.org; Tue, 19 Jun 2007 10:52:22 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 10:52:21 +0200
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 10:52:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20060601 Firefox/2.0.0.4 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50459>

Brian L. Troutwine <goofyheadedpunk <at> gmail.com> writes:

> 
> I've got two branches, one which I commit to quite frequently and another only 
> periodically, call them inward and outward. Inward is where I do my work, 
> outward tracks an SVN repository. I'd like to merge inward to outward without 
> committing the merge so that I may provide a commit message appropriate for 
> checking in to the SVN repo. 
> 
> `git merge --no-commit inward' from branch outward, I thought, should do it. 
> Performing a `git status' and a `git log' directly afterward seem to indicate 
> that the merge was committed. `git commit' insists the branch is now up to 
> date.
> 

If you want the "whole" set of changes from inward to appear in outward as a
/single/ commit with an appropriate commit message, probably you want to use
also the --squash option of git merge.

Otherwise, git will preserve the "structuring" of the history in many commits.
This means that:

- if outward does not need any real merge (because it only needs to be advanced
to a newer status and not to join some changes of its own with changes from
inward), git merge will make a "fast-forward". In other words, you will see
outward becoming up to date without the need of any merge-commit at all. BTW
that is why --no-commit appears to have no effect in this case: there wouldn't
be any merge commit in any case. 

- if outward needs a real merge, then git merge will set up everything up to the
point of making the merge commit.  Then, depending on the presence of the
--no-commit option it will or will not make the actual commit.  

> Am I going about this the wrong way? What does --no-commit mean, if I am?
> 
> (Also, I asked this on #git earlier. If anyone happens to idle there, pardon 
> me for re-posting this so quickly. I've got terrible lag this morning, enough 
> to time out frequently.)
