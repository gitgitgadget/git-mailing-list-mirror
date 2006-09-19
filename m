From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 00:07:08 +0200
Organization: At home
Message-ID: <eeppkl$rm9$2@sea.gmane.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 20 00:07:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPnjz-0002U5-LJ
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWISWGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWISWGy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:06:54 -0400
Received: from main.gmane.org ([80.91.229.2]:972 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751108AbWISWGw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:06:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPnjf-0002PT-VH
	for git@vger.kernel.org; Wed, 20 Sep 2006 00:06:35 +0200
Received: from host-81-190-31-133.torun.mm.pl ([81.190.31.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 00:06:35 +0200
Received: from jnareb by host-81-190-31-133.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 00:06:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-133.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27295>

Joel Dice wrote:

> I'm considering adopting Git for a medium-sized project which is currently 
> managed using Subversion.  I've used Git for a few smaller projects 
> already, and the thing I've missed most from Subversion is the convenience 
> of incrementing revision numbers.  The following is a proposal to add this 
> feature to Git.
> 
> 
> Rationale:
> 
> Incrementing revision numbers (IRNs - an acronym I just made up) are 
> useful in that they can be treated as auto-generated tags which are easier 
> to remember and communicate than SHA hashes, yet do not require extra 
> effort to create like real tags.  Also, they have the advantage of being 
> chronologically ordered, so if I assert that a bug was fixed in revision 
> 42 of a shared repository, everyone may assume that revision 45 has that 
> fix as well.

That is true _only_ if you have linear history. If you have multiple
concurrent branches, revision 42 can be in branch 'next', revision '45' in
topic branch 'xx/topic' which forked before revision 42, and do not have
the fix.

Unfortunately, one cannot (as of now) use result of git-describe as
<commit-ish>. I'd rather have it fixed, than port idea from _centralized_
SCM do distributed SCM.

> Proposal:
> 
> As with Subversion, the IRN state in Git would be specific to a given 
> repository and have no significance beyond that repository.  Also like 
> Subversion, IRN state would be global across a repository, so that a 
> commit to any branch would increment the current IRN value.  Every Git 
> command taking a revision parameter would accept an IRN using a syntax 
> such as "r$IRN".  Every commit would report the IRN to the user as well as 
> the SHA ID.  The IRN feature could be enabled or disabled via a 
> configuration option.

This of course limits IRN much. Tags are valid across repositories.
I'm not sure if many repositories are managed using shared repositories
(centralized approach).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
