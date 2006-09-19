From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 00:17:15 +0200
Organization: At home
Message-ID: <eepq7l$dc$1@sea.gmane.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <eeppkl$rm9$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 20 00:17:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPntl-0004PM-0j
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWISWQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWISWQ5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:16:57 -0400
Received: from main.gmane.org ([80.91.229.2]:51344 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751222AbWISWQ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:16:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPntH-0004JR-D1
	for git@vger.kernel.org; Wed, 20 Sep 2006 00:16:34 +0200
Received: from host-81-190-31-133.torun.mm.pl ([81.190.31.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 00:16:31 +0200
Received: from jnareb by host-81-190-31-133.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 00:16:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-133.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27299>

Jakub Narebski wrote:

> Joel Dice wrote:
> 
>> I'm considering adopting Git for a medium-sized project which is currently 
>> managed using Subversion.  I've used Git for a few smaller projects 
>> already, and the thing I've missed most from Subversion is the convenience 
>> of incrementing revision numbers.  The following is a proposal to add this 
>> feature to Git.
>> 
>> 
>> Rationale:
>> 
>> Incrementing revision numbers (IRNs - an acronym I just made up) are 
>> useful in that they can be treated as auto-generated tags which are easier 
>> to remember and communicate than SHA hashes, yet do not require extra 
>> effort to create like real tags.  Also, they have the advantage of being 
>> chronologically ordered, so if I assert that a bug was fixed in revision 
>> 42 of a shared repository, everyone may assume that revision 45 has that 
>> fix as well.
> 
> That is true _only_ if you have linear history. If you have multiple
> concurrent branches, revision 42 can be in branch 'next', revision '45' in
> topic branch 'xx/topic' which forked before revision 42, and do not have
> the fix.

Additionally, what does _chronological_ mean? Time the commit is recorded?
Remember that in distributed development commits can be fetched from other
repository, or arrive via email and applied using git-am. In git you can
also rebase branch. Git records merges, and said merges are sometimes
just fast-forward. All those difficulties have to be solved for IRNs.

By the way, there was similar proposal to add either hidden field ('note'
like) to commit object denoting _generation_ of commit, or add cache of
commits' generation numbers. Generation number of root (parentless) commit
is 0, generation number of a commit is maximum of generation numbers of its
parents plus 1. But this proposal was for easier and faster generation of
topological order.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
