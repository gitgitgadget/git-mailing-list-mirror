From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Mon, 22 Oct 2007 16:31:31 +0200
Message-ID: <471CB443.9070606@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>  <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjyJo-0004gn-6T
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbXJVObg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 10:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbXJVObg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:31:36 -0400
Received: from mail.op5.se ([193.201.96.20]:54308 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbXJVObf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:31:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 590F817305A3;
	Mon, 22 Oct 2007 16:31:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.476
X-Spam-Level: 
X-Spam-Status: No, score=-2.476 tagged_above=-10 required=6.6
	tests=[AWL=0.023, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ocgxcfKcqC2s; Mon, 22 Oct 2007 16:31:33 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B0E011730598;
	Mon, 22 Oct 2007 16:31:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710221445170.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62014>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
> 
>> If I were to suggest any improvements, it'd be to change the semantics of
>> git-pull to always update the local branches set up to be merged with the
>> remote tracking branches when they, prior to fetching, pointed to the same
>> commit, such that when
>>
>> $ git show-ref master
>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
>>
>> refs/heads/master gets set to refs/remotes/origin/master post-fetch.
> 
> In general, this should fail.  Because you are expected to have local 
> changes in the local branches.


BS argument. Git knows when I haven't got any changes on my local 
branches, and it can be fairly safely assumed that when I feel like 
making any, I'd like to make them off as fresh a tip as possible unless 
I explicitly tell git otherwise.

Nice hint though. I'm working on a patch for it now but I've only looked 
at it 15 minutes over lunch today, so it'll probably be a few days.


>  What you describe suggests that you should 
> not use the branch name "master" at all, but "origin/master".
> 

No. I want the ability to commit locally without it affecting my 
upstream tracking branches, but I also want to make sure that when I 
want to work on some branch I don't frequently touch, git will make sure 
it's kept up-to-speed with the branch I explicitly have told it to merge 
with, without me having to remember if I was on that branch when I last 
did git-pull (I might not have a network connection), and without having 
to remember what I decided to call my locally-modifiable branch.


> That said, there is a pretty simple way to achieve what you want (even if 
> it does not help the confusion you create between local and remote 
> branches):
> 
> 	git config --add remote.origin.fetch master:master
> 
> Of course, when you checkout "master" and pull then, you'll get even more 
> problems, _exactly_ because you muddled up the clear distinction between 
> local and remote branches.
> 

That's not what I want at all. I must have been unclear in my original 
post. I'm talking about git doing automatically what every single user 
I've ever talked to wants it to do, which is to maintain the state of 
sync that the "local-and-modifiable" branches had with the 
"local-non-modifiable-aka-remote-tracking" branches. Note that the state 
of sync is more important to users than git never ever touching the 
branches that they *could* have (but don't have) changes on.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
