From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: keeping remote branches in sync
Date: Thu, 9 Oct 2008 10:14:18 -0400
Message-ID: <20081009141418.GF18241@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 16:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnwQH-0006Zj-JJ
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 16:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759205AbYJIOVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 10:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbYJIOVr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 10:21:47 -0400
Received: from pimtaint02.ms.com ([199.89.103.69]:49734 "EHLO
	pimtaint02.ms.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbYJIOVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 10:21:47 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 10:21:46 EDT
Received: from pimtaint02 (localhost.ms.com [127.0.0.1])
	by pimtaint02.ms.com (output Postfix) with ESMTP id CB7CA9045CD
	for <git@vger.kernel.org>; Thu,  9 Oct 2008 10:14:18 -0400 (EDT)
Received: from ny0032as02 (unknown [170.74.93.69])
	by pimtaint02.ms.com (internal Postfix) with ESMTP id B198292C030
	for <git@vger.kernel.org>; Thu,  9 Oct 2008 10:14:18 -0400 (EDT)
Received: from np315c1n5 (localhost [127.0.0.1])
	by ny0032as02 (msa-out Postfix) with ESMTP id A3FB0D3C15E;
	Thu,  9 Oct 2008 10:14:18 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	(Authenticated sender: yes)
	by ny0032as02 (msa-in Postfix) with ESMTP id 85B69FBC02B;
	Thu,  9 Oct 2008 10:14:18 -0400 (EDT)
Received: by menevado.ms.com (Postfix, from userid 49008)
	id 5CB495300F5; Thu,  9 Oct 2008 10:14:18 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.35/RELEASE, bases: 09102008 #1162421, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97853>


Hi,

We've been using git for our development for a few months now.  We've got two
developers and each push up to a shared bare repository.  Our workflow is pretty
simple and goes something like this:

We do development in local topic branches.  Occasionally, when we want the
other to take a look we might push them up to our shared repo.

Once we're happy with local testing and code review, we rename the topic
branch to prefix it with "$user/for_next/".  This lets us know that the developer
feels the code is ready for more further integration testing.  We use a branch
called 'next' which merges all the for_next branches together.  One of us
merges all the for_next branches locally and pushes it up to the shared repo.
We then have some jobs that release that branch as an alpha nightly build for
further testing by more users.

After topic branches are merged to master, we do some cleanup by deleting them
from the shared repo.

One of the issues we have is that _my_ local repos remote branches aren't kept
in sync with the shared repo.  So, if the other developer deletes all his
topic branches and I do a git-pull, the topic branches still show as remotes
in my branch and vice versa for him.  This is exactly what we expect, but it's
not desirable for us.

I'd like some comment on whether our workflow could use some improvement.
Specifically, if there's a straightforward way to handle the issue above, that
would be great.  I've been looking through the manual on git-fetch and
git-pull and not seeing any options to do this. 

I was thinking of writing a little utility that does a 'git-cherry master $topic'
and doing a 'git-branch -d -r $topic' on any topic branch that is already in master, 
but I'd rather use something already there, if possible.

What are others doing to handle this situation?


Thanks!


--Kevin
