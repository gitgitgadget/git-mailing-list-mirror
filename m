From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Undo last commit?
Date: Tue, 28 Jun 2011 15:57:02 +0200
Message-ID: <4E09DDAE.30801@ira.uka.de>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com> <m31uyrutx7.fsf@localhost.localdomain> <20110619003718.GA5628@elie> <201106191237.55825.jnareb@gmail.com> <4DFF382A.5030206@micronengineering.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike <xandrani@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?UTF-8?B?Tmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Massimo Manca <massimo.manca@micronengineering.it>
X-From: git-owner@vger.kernel.org Tue Jun 28 15:59:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbYpE-0004ua-4z
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 15:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530Ab1F1N5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 09:57:17 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:41426 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758097Ab1F1N4W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 09:56:22 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1QbYlx-0001Ul-41; Tue, 28 Jun 2011 15:56:19 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1QbYlw-0003LE-TM; Tue, 28 Jun 2011 15:56:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <4DFF382A.5030206@micronengineering.it>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1309269379.105186000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176400>

Let me play devils advocate:
Wouldn't it be nice to have a command 'git uncommit' (in core git) that 
would be an alias to "git reset --keep HEAD^" ? And if not already done, 
it should hint at "git reset --soft HEAD^" in case of failure because of 
conflicts.

It would be a nice companion to the not-yet-realized "git unadd" ;-)

Holger.


On 20.06.2011 14:08, Massimo Manca wrote:
> Hello,
> I several times made the mistake of a wrong commit also if generally the
> error born for a wrong add expecially:
>
> git add . in a directory with some files that haven't to be managed by git.
>
> So, as wrote in some emails here, if I wrote something like:
> git commit -m "Added file.c" -a
>
> I tryed to solve with:
> git commit --amend -m "Added file.c" -a
>
> hoping to have a status like before the commit and then sending:
> git reset .
>
> hoping to have a status like that before the wrong add.
> But this is not what git status say so, my solution to solve commi
> problems is ALWAYS:
>
> git reset --soft HEAD^
>
> that for my point of view works better then all others permitting to
> redo last add and commit to solve not only a -m problem but also a wrong
> git add command.
>
> Il 19/06/2011 12.37, Jakub Narebski ha scritto:
>> On Sun, 19 Jun 2011, Jonathan Nieder wrote:
>>> Jakub Narebski wrote:
>>>> Mike<xandrani@gmail.com>  writes:
>>>>> % git reset --hard HEAD~1
>>>> Errr... here you screwed up.  This reset state of you working area to
>>>> the state at last commit, removing all your changes to tracked files.
>>> Or rather, here we screwed up.  Jakub and others gave some useful
>>> advice about how to recover, so let's consider how the UI or
>>> documentation could be improved to prevent it from happening again.
>>>
>>> * In this example if I understand correctly then the index contained
>>>    some useful information, perhaps about a larger commit intended for
>>>    later.  To preserve that, you could have used
>>>
>>> 	git reset --soft HEAD~1
>>>
>>>    which would _just_ undo the effect of "git commit", leaving the index
>>>    and worktree alone.
>> Another issue is that Mike haven't realized that `--amend' option can be
>> used *in combination* with other "git commit" options, which means that
>> the solution to his problem was using "git commit" as it should have
>> been done, but with '--amend' added.
>>
>> I'm not sure if git documentation talks about 'git reset --soft HEAD^',
>> and when to use it; from what I remember it encourages use of
>> 'git commit --amend' instead (which was I guess most often used reason
>> of using soft reset before there was '--amend').
>>
>>> * Another situation that comes up from time to time is making a change
>>>    that just turned out to be a bad idea.  After commiting it, you might
>>>    want to discard the erroneous change, like so:
>>>
>>> 	git reset --keep HEAD~1
>>>
>>>    The "--keep" option uses some safeguards to make sure that only the
>>>    committed change gets discarded, instead of clobbering local changes
>>>    at the same time.
>>>
>>> * In the early days of git, the "--keep" option did not exist.  So a lot
>>>    of old documentation recommends to do
>>>
>>> 	git reset --hard HEAD~1
>>>
>>>    which is the same if you don't have any local changes.
>> Yes, it would be good idea to examine git documentation (tutorials,
>> user's manual, manpages, perhaps "Git Community Book" and "Pro Git"
>> too) to encourage use of new safer options of hard reset, namely
>> '--keep' and '--merge' instead of '--hard'.
>>
>
