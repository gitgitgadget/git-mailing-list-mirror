From: Joel Dice <dicej@mailsnare.net>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 16:30:05 -0600 (MDT)
Message-ID: <Pine.LNX.4.62.0609191625000.9752@joeldicepc.ecovate.com>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <eeppkl$rm9$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:30:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPo6a-0006uQ-I9
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWISWaM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWISWaM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:30:12 -0400
Received: from v187.mailsnare.net ([206.246.200.187]:23441 "EHLO
	mail.mailsnare.net") by vger.kernel.org with ESMTP id S1751247AbWISWaL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:30:11 -0400
Received: from joeldicepc.ecovate.com (unknown [208.50.222.162])
	by mail.mailsnare.net (Postfix) with ESMTP id 607432C089;
	Tue, 19 Sep 2006 22:30:05 +0000 (UTC)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eeppkl$rm9$2@sea.gmane.org>
X-Virus-Scanned: by ClamAV at mailsnare.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27304>

On Wed, 20 Sep 2006, Jakub Narebski wrote:

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

In practice, this is not a problem.  The branch referred to is usually 
understood from the context (ex. a Bugzilla bug for a particular version 
of a product implies a particular branch).  Otherwise, yes, you must also 
explictly state which branch the fix was applied to.

> Unfortunately, one cannot (as of now) use result of git-describe as
> <commit-ish>. I'd rather have it fixed, than port idea from _centralized_
> SCM do distributed SCM.
>
>> Proposal:
>>
>> As with Subversion, the IRN state in Git would be specific to a given
>> repository and have no significance beyond that repository.  Also like
>> Subversion, IRN state would be global across a repository, so that a
>> commit to any branch would increment the current IRN value.  Every Git
>> command taking a revision parameter would accept an IRN using a syntax
>> such as "r$IRN".  Every commit would report the IRN to the user as well as
>> the SHA ID.  The IRN feature could be enabled or disabled via a
>> configuration option.
>
> This of course limits IRN much. Tags are valid across repositories.
> I'm not sure if many repositories are managed using shared repositories
> (centralized approach).

I would suggest that most repositories are centralized.  They're just not 
using Git yet :)

  - Joel
