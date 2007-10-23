From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Tue, 23 Oct 2007 09:24:40 +0200
Message-ID: <471DA1B8.4030400@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>	 <Pine.LNX.4.64.0710210031130.25221@racer.site>	 <471AFD07.4040606@op5.se>	 <Pine.LNX.4.64.0710212308540.25221@racer.site>	 <471C586A.9030900@op5.se>	 <Pine.LNX.4.64.0710221156540.25221@racer.site>	 <471C9B13.9080603@op5.se>	 <Pine.LNX.4.64.0710221445170.25221@racer.site>	 <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 09:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkE8H-0006k8-SL
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 09:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbXJWHYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 03:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbXJWHYq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 03:24:46 -0400
Received: from mail.op5.se ([193.201.96.20]:47754 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbXJWHYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 03:24:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AF35D17306B8;
	Tue, 23 Oct 2007 09:24:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vv0lc58svVeJ; Tue, 23 Oct 2007 09:24:42 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C1F9C17306B3;
	Tue, 23 Oct 2007 09:24:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62118>

Jakub Narebski wrote:
> On 10/22/07, Andreas Ericsson <ae@op5.se> wrote:
>> Johannes Schindelin wrote:
>>> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
>>>
>>>> If I were to suggest any improvements, it'd be to change the semantics of
>>>> git-pull to always update the local branches set up to be merged with the
>>>> remote tracking branches when they, prior to fetching, pointed to the same
>>>> commit, such that when
>>>>
>>>> $ git show-ref master
>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
>>>>
>>>> refs/heads/master gets set to refs/remotes/origin/master post-fetch.
>>> In general, this should fail.  Because you are expected to have local
>>> changes in the local branches.
>>
>> BS argument. Git knows when I haven't got any changes on my local
>> branches, and it can be fairly safely assumed that when I feel like
>> making any, I'd like to make them off as fresh a tip as possible unless
>> I explicitly tell git otherwise.
> [cut]
> 
> It would be I think possible to make git behave as you want, although I'd rather
> (at least at first) have behaviour described above turned on by some option
> or config variable. I guess that it would be not that hard to make script to do
> what you ant (and probably it would be best if you tried your idea that way).
> 
> There are the following caveats.
> 1. For each local branch that is to be updated on pull, this branch
> must be marked as tracking some branch of some repository. This has to
> be explicitely done; for example by creating those branches using
> --track option.
> 2. Git can do a merge with conflicts _only_ if that branch is checked
> out. So for all local branches which you want to get updated using
> "git pull --update-all <repo>" (or something like that), the merge
> with remote branch should be either fast-forward, trivial merge, or
> merge without conflicts. "git pull --update-all <repo>" would return
> then list of updated branches and list of branches which cannot be
> updated.
> 
> So... are you going to try to implement that?

Yes, but only for fast-forward cases. When there *are* local changes, 
the user must decide when to merge those, since he/she may not be done 
with them. It doesn't make sense to merge local canges on a not checked 
out branch automagically, because then we end up in the very unclear 
semantics that Dscho (and myself) fear.

Also, as Steffen pointed out in his mail, this will make "git pull" 
largely symmetrical with "git push", which *does* update all the remote 
branches, but only if the update results in a fast-forward.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
