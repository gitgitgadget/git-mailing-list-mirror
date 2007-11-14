From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Wed, 14 Nov 2007 02:02:52 +0100
Message-ID: <473A493C.4070902@op5.se>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>	<87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>	<A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>	<473A027E.5000107@op5.se> <473A262B.4010205@op5.se> <7vr6itr96h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6eu-00021L-FG
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763191AbXKNBC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761155AbXKNBC6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:02:58 -0500
Received: from mail.op5.se ([193.201.96.20]:46219 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762978AbXKNBC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:02:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A1FEF1F08710;
	Wed, 14 Nov 2007 02:02:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tsj3GpvYa603; Wed, 14 Nov 2007 02:02:54 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id CCDEC1F0870D;
	Wed, 14 Nov 2007 02:02:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vr6itr96h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64933>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> I've got half a patch ready to change all occurrences of anything but
>> "remote-tracking branch" to that self-same description. This is what
>> I've got in Documentation/glossary.txt so far:
>>
>> [[def_remote_tracking_branch]]remote-tracking branch:
>>    A "remote-tracking branch" is a branch set up to track the
>>    state of a branch in a remote repository which the user has named.
>> These branches follow exactly the same rules as the branches which
>>    reside in the remote repository, except that they are manipulated
>>    by `git fetch` instead of `git push`. That is, they can only be
>>    updated if the update would result in a  <<def_fastforward,fast
>> forward>>, or if the user supplies the  '--force' option.  They cannot
>> be checked out or committed to by users, but serve
>>    solely as local reference-pointers to their corresponding branches
>>    in the remote repository.
>>    The most common example of a remote-tracking branch is origin/master.
> 
> Please try to read it as if it were an entry in a glossary.
> The sentence "... follow exactly the same rules as ..." was
> "Huh?" to me.  "rules?  what rules?  the set of valid characters
> in their names?"
> 
> When branch 'foo' from remote is tracked with the standard layout
> (post 1.3.0) it is copied to refs/remotes/origin/foo and people
> often fork their local branch refs/heads/foo to build on top.
> The use of the word "corresonding" feels a bit confusing,
> because you can arguably say refs/heads/foo at remote
> corresopnds to refs/heads/foo in your repository.
> 
> I'd drop "These branches follow ... the '--force' option.  "
> from the above.  The rules on how they are updated are
> irrelevant, before the reader understands what they are for.
> How about this?
> 
>     A "remote tracking branch" remembers which commit a branch
>     in the remote repository was pointing at last time you
>     checked.  It cannot be checked out or committed because its
>     purpose is to serve as a local reference point after you
>     built your own changes on top of it in your local branch
>     forked from it.  The most common example of a remote
>     tracking branch is "origin/master", which tracks the
>     "master" branch of the "origin" remote.
> 

I'd skip "after you built your own changes ..." and let it go at
that. Will amend. Thanks.

> BTW, when you have this data-flow (probably typical in a shared
> repository workflow):
> 
>     Remote repository               Your repository
> 
>     refs/heads/foo -------(A)------> refs/remotes/origin/foo
>          ^                                |
>          |                               (B)
>          |                                |
>          |                                V
>          `-------------(C)---------- refs/heads/foo
> 
>          (A) "git fetch" with remote.origin.fetch configuration
>              set to +refs/heads/*:refs/remotes/origin/* keeps
>              your refs/remotes/origin/foo up-to-date with their
>              refs/heads/foo
> 
>          (B) "git merge origin/foo" while on "foo" branch (there
>              are few shorthands like "git pull origin foo" while
>              on "foo" branch.  If you say "git branch --track
>              foo origin/foo", then running "git pull" without
>              parameter while on "foo" branch).
> 
>          (C) "git push origin foo".
> 
>  * Everybody seems to agree that "refs/remotes/origin/foo" is
>    called a "remote tracking branch";
> 

I'd like to insert the significant dash there. remote-tracking vs
remote tracking. It solves the one ambiguity with it, and would
finally make it clear and consistent almost however it's used.

>  * Your refs/heads/foo follows and builds on top of 'foo' branch
>    at the remote.  Some people errorneously call it "tracking"
>    but that is because we do not have a good term for it;
> 

"private tracking branch"? Nah...

>  * There is no good name for "refs/heads/foo at the remote".  We
>    always say "the remote branch you follow" (or "track"). 
> 

"remote-repo branch" perhaps? The universe doesn't exactly toll its
bells in approval at that, but at least it's not ambiguous.

I've seen it written as "remote tracking branch" on irc a few times.
It causes 10 minutes of confusion where no-one's sure what anyone
else means. With the dash in there, there's no room for ambiguity.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
