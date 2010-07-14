From: Brock Peabody <brock.peabody@gmail.com>
Subject: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 16:33:30 +0000 (UTC)
Message-ID: <loom.20100714T180615-173@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 18:40:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ50I-0002gf-Vy
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab0GNQkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 12:40:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:40143 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471Ab0GNQkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 12:40:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OZ507-0002aM-Ul
	for git@vger.kernel.org; Wed, 14 Jul 2010 18:40:04 +0200
Received: from proxy-nj2.bloomberg.com ([69.191.241.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 18:40:03 +0200
Received: from brock.peabody by proxy-nj2.bloomberg.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 18:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.191.241.48 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151007>

Hi,
I'm new to the list and have a question about signoffs, and the details of how
distributed workflows work in the wild.

We are looking at converting a large group of developers from using svn to git.
 Our current svn workflow relies on external tools and commit hooks to present
(poorly) a somewhat distributed model that would be natural with git. 
Unfortunately, we have not been able to connect a few of the dots that we need
for our git based workflow.  We have a basic idea, loosely based on workflows
presented in online sources and the "Pro Git" book:

  Developer -> GateKeeper -> Master Repository

Developers wishing to contribute code would push revisions to the gatekeepers'
repos, who after reviewing the revisions would push them to the Master
repository, from which developers would have only pull access.  The GateKeeper
repositories would be well known, and observers could easily see which
GateKeepers had which revisions in their review queues.

This works fine, except for the fact that there is no trail in the master
repository indicating which GateKeeper approved which revision.

We've scoured the internet for solutions.  One idea we have tried and abandoned
is using 'git commit -s --amend'. This does create a new revision with the
signoff information we want, but the problem is that it creates a new revision.
Eventually, the developers (and the GateKeeper repository) will end up with both
the revision containing the signoff and one without it.

I've seen evidence of what we're after - by browsing the repository of git
itself.  Each revision in it contains an "Author" field and a (frequently
different) "Committer" field.  Furthermore, there are often multiple
"Signed-off-by" and "Acked by" logs.  How are these fields populated?  Are new
revisions created each time the sign-off information is added? If so, how do the
contributors deal with these new revisions when synchronizing with the master
later?  How are the pre-signoff revisions purged from the bare GateKeeper
repositories?

I would greatly welcome and advice on how these workflows are implemented.

Thanks in advance,
Brock Peabody
