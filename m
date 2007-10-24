From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Wed, 24 Oct 2007 21:41:05 +0200
Message-ID: <471F9FD1.6080002@op5.se>
References: <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikm6W-0000ht-Rc
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 21:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbXJXTlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 15:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbXJXTlL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 15:41:11 -0400
Received: from mail.op5.se ([193.201.96.20]:34352 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbXJXTlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 15:41:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7057C1730676;
	Wed, 24 Oct 2007 21:39:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mYdYlYK8uvLo; Wed, 24 Oct 2007 21:39:50 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id C75D51730657;
	Wed, 24 Oct 2007 21:39:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071024192058.GF29830@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62229>

J. Bruce Fields wrote:
> On Wed, Oct 24, 2007 at 08:48:54PM +0200, Steffen Prohaska wrote:
>> The central shared repo is called project-shared.git and contains,
>> for example, the following branches:
>>    master
>>    next
>>    work/topicA
>>    work/topicB
>>    ...
>>
>>
>> Developers clone the repo and check out the branches they are
>> interested in. For example a developer may want to track next
>> and work on topicB:
>>
>>    git clone ssh://central.example.com/project-shared.git project
>>    cd project
>>    git checkout -b next origin/next
>>    git checkout -b work/topicB origin/work/topicB
>>
>> This is sufficient. No adding of remotes is needed. Neither
>> is a private repository on a server required. After cloning,
>> developers have all they need.
>>
>> Later work/topicB has new commits and should be pushed:
>>
>>    git push origin
>>
>> The default behaviour of push is fine. Only matching branches
>> are pushed.
>>
>> _But_, origin is a shared repository. Therefore branches may
>> have advanced and git push may report
>>
>> error: remote 'refs/heads/next' is not a strict subset of local ref 
>> 'refs/heads/next'. maybe you are not up-to-date and need to pull first?
>>
>> So here's the problem. The developer didn't do anything wrong.
>> But git complaints with an error. Git also recommends to run
>> pull, so the developer runs "git pull". But this doesn't help,
>> because it's only updating work/topicB and "git push" will
>> complain with the very same error.
>>
>> What you need to do is
>>
>>    git checkout <local-branch>
>>    git pull
>>    git checkout <local-branch2>
>>    git pull
>>    ...
>>
>> for every local branch.
> 
> Or just
> 
> 	git push origin work/topicB
> 
> since that's all you really wanted to push anyway.
> 

git pull. Not git push. git pull operates on one working branch
at a time (by default), whereas git push uploads and fast-forwards
all the common branches (by default). I want git pull to work like
git push.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
