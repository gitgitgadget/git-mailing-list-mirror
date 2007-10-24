From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Wed, 24 Oct 2007 23:47:13 +0200
Message-ID: <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 23:47:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iko3z-0008J0-3d
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 23:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbXJXVqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 17:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbXJXVqA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 17:46:00 -0400
Received: from mailer.zib.de ([130.73.108.11]:48434 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759715AbXJXVp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 17:45:58 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9OLjlOi009362;
	Wed, 24 Oct 2007 23:45:47 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1097b.pool.einsundeins.de [77.177.9.123])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9OLjkOW025217
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 24 Oct 2007 23:45:46 +0200 (MEST)
In-Reply-To: <20071024212854.GB6069@xp.machine.xx>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62244>


On Oct 24, 2007, at 11:28 PM, Peter Baumann wrote:

> On Wed, Oct 24, 2007 at 11:06:24PM +0200, Andreas Ericsson wrote:
>> J. Bruce Fields wrote:
>>> On Wed, Oct 24, 2007 at 10:12:29PM +0200, Steffen Prohaska wrote:
>>>> On Oct 24, 2007, at 9:48 PM, J. Bruce Fields wrote:
>>>>
>>>>>> I want git pull to work like git push.
>>>>> That strikes me as a less complete solution, since it only  
>>>>> helps in the
>>>>> case where the other branches all happen to be unmodified  
>>>>> locally (hence
>>>>> can be fast-forwarded).  In other cases the "git push" will  
>>>>> still emit a
>>>>> spurious error.
>>>> Well, but then there's something you should really think
>>>> about.
>>> Perhaps, but not necessarily; you may have some branches with local
>>> changes that you're content to leave unpushed (and un-updated).
>>
>> Sure, but that won't change. The only thing I'm proposing is that
>> local copies of remote branches are automatically fast-forwarded
>> on every pull, but only if
>>
>> * the branch has no modifications what so ever
>> * the branch is set up to auto-merge with the particular branch
>> fetched from the particular remote
>>
>> I really don't see any downsides what so ever with this. Those
>> of you who do, please enlighten me.
>>
>
> You can't check what got added in your pull, e.g you can't review  
> the new
> code with something like
>
> 	gitk next..origin/next

You're not forced to pull. Just use "git fetch" if you
want to do this. Or is something missing if you'd be
limited to "git fetch"?


> I often do something like this, just to see what got changed. So at  
> least
> in my opinion you have to add a third point:
>
>   * the branch has no modifications what so ever
>   * the branch is set up to auto-merge with the particular branch
>     fetched from the particular remote
> 				AND
>   * the user set a config option to always autofastfoward if the above
>     conditions are true! This could be implemented as a global  
> option with
>     a per branch overwrite.

I (and, as I understood, Andreas, too) want to change the
default. Because we believe that git would be easier to use
in workflows based on a shared repository.

But if we fail to convince the list, maybe a global
configuration variable that configures "git pull" to autoforward
branches as propose would be a nearly equally good solution.

However, I think it is dangerous to introduce many of such
configuration options. Explaining the behaviour of git will
become harder. The behaviour will become dependent on the
local configuration and eventually the first question before
answering a question will be "send me the output of 'git config
--list'. I need to see how your git is configured."

	Steffen
