From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 11:26:25 +0200
Message-ID: <09A90525-8B0B-4249-904C-722BCC544B4E@zib.de>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de> <20070928065823.GB19299@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 11:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbCD4-0003r7-Kh
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 11:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757629AbXI1Jc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 05:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758239AbXI1Jc1
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 05:32:27 -0400
Received: from mailer.zib.de ([130.73.108.11]:42916 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757046AbXI1Jc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 05:32:27 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8S9Ooed017081;
	Fri, 28 Sep 2007 11:24:50 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8S9OngY014307
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 28 Sep 2007 11:24:49 +0200 (MEST)
In-Reply-To: <20070928065823.GB19299@artemis.corp>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59382>


On Sep 28, 2007, at 8:58 AM, Pierre Habouzit wrote:

> On Fri, Sep 28, 2007 at 06:52:47AM +0000, Steffen Prohaska wrote:
>>
>> On Sep 27, 2007, at 9:22 PM, Junio C Hamano wrote:
>>
>>>
>>> So what's the desired semantics?
>>>
>>> The current semantics is:
>>>
>>>   "git push" says "you do not say to which repository?" and
>>>   consults "branch.<current>.remote" but defaults to 'origin'
>>>   if unconfigured.
>>>
>>>   "git push <name>" (or using the <name> determined as above)
>>>   says "you do not say which branches?" and consults
>>>   "remote.<name>.push" to find branches to push out, but
>>>   defaults to 'matching branches' if unconfigured.
>>>
>>> What you would want to change is the fallback behaviour for
>>> unconfigured "remote.<name>.push".  I think it is sensible to
>>> have an option to make it push only the current branch.
>>
>> I'm not sure that changing the fallback behaviour for unconfigured
>> "remote.<name>.push" is sufficient.
>>
>> When "remote.<name>.push" is set I'd expect "git push" to
>> choose only the 'right' remote.<name>.push lines, that is
>> the lines that have the current branch as the local ref.
>> "git push" would only push the current branch, which could be pushed
>> to 0 or more branches on the remote side. If no "remote.<name>.push"
>> contains the current branch as a local ref nothing would happen
>> (maybe a warning?). If several "remote.<name>.push" have the current
>> branch as the local ref the branch would be pushed to several
>> remote branches. But other branches than the current branch
>> would _never_ be pushed if no argument is given to 'git push'.
>
>   I'm not really sure that it makes sense, as by default, git push  
> won't
> create a new remote ref. So unless you have a branch that matches some
> remote ref, but that you never want to push, even when on it and  
> typing
> git push... there is nothing that could happen by mistake.
>
>   So if you don't want to push such a branch, ever, then you should  
> IMHO
> not name it in a way that it matches a refspec in the first place, and
> be safe.

I could have a couple of local branches typically pushed to a couple of
remote branches. "git push origin" would update all remote refs.

But I may also be interested to push only the current branch I'm working
on. I may also have some pending fixes on another branch that should not
be pushed now. Currently I need to do "git push origin  
<current>:<someremote>".

Let me put it as a question: How can I push changes from the current
branch to all remote refs it is configured to push to via  
"remote.<name>.push"
without pushing anything else at the same time?

	Steffen
