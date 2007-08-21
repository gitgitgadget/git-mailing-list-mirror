From: David Kastrup <dak@gnu.org>
Subject: Re: Multiple branches and git-svn
Date: Tue, 21 Aug 2007 14:35:52 +0200
Message-ID: <86wsvpf4k7.fsf@lola.quinscape.zz>
References: <864pj16r10.fsf@lola.quinscape.zz> <9FD13095-36B5-4663-B658-082981B1ACD9@lrde.epita.fr> <861wdxgncz.fsf@lola.quinscape.zz> <20070821115611.GA21410@mimvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 14:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INSyO-0005c9-Sb
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 14:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbXHUMgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 08:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbXHUMgQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 08:36:16 -0400
Received: from main.gmane.org ([80.91.229.2]:40433 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbXHUMgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 08:36:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INSxr-0001Ie-Gr
	for git@vger.kernel.org; Tue, 21 Aug 2007 14:36:07 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 14:36:07 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 14:36:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:te8FEY7Lgc1Md8K+A4YIjoUq4tM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56291>

David Watson <dwatson@mimvista.com> writes:

> Yes, that's quite true. It took me quite a while to figure that out
> when I first started using git-svn, and its non-sensicalness nearly
> put me off using git entirely. My workflow at this point is to use
> git-cherry-pick -e to pull in any changes from other branches, then
> delete the git-svn-id line.
>
> Essentially, merging using git-svn is almost entirely broken, since
> an inconsistent tool is worthless - you spend more time figuring out
> if it's going to break, and working around the breakage, than you
> save using it.

Full agreement.

> Now, I'm not sure this is 100% the fault of git-svn. Perhaps keeping
> its metadata about which SVN branch it's connected to isn't the best
> thing, but git-merge is doing exactly what you ask for.  Perhaps we
> need a merge command in git-svn that does the right thing?

Git svn needs to recognize a merge for what it is, and has to ignore
the branch which has been merged, looking further for git-svn-id lines
or whatever.  Cherrypicking is harder to contain.  Basically, I think
it is a mistake to use something as fragile as the git-svn-id line in
the log for determining the branch to use for committing.  Instead, a
fixed association of git branches with git-svn should be established.
Even if one needs to write this manually into some configuration file.
Before git-svn does not have reliable information, it should refuse to
commit.  One could specify this on the command line, too: that is a
small price to pay for being sure that one commits where one wants to.

> Although what that right thing would be, I'm not quite sure.  Either
> way, there needs to be a BIG GIGANTIC WARNING in the git-svn manual
> that if you actually use git for what it claims to be great at
> (i.e., merging) you may be in for a world of pain, with your
> coworkers and boss coming at you with pitchforks and
> torches. Especially because there are so many git users who need to
> interoperate with SVN.

Yes.

-- 
David Kastrup
