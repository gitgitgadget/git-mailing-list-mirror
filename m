From: John Ellson <ellson@research.att.com>
Subject: Re: [PATCH] Make GIT-VERSION-GEN tolerate missing git describe command
Date: Fri, 30 Dec 2005 14:12:52 -0500
Message-ID: <43B586B4.5030001@research.att.com>
References: <dp3mtp$rfm$1@sea.gmane.org> <Pine.LNX.4.64.0512301046230.3249@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 20:13:03 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsPgT-0006Md-RM
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 20:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVL3TM7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 14:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVL3TM7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 14:12:59 -0500
Received: from [192.20.225.110] ([192.20.225.110]:27808 "EHLO
	mail-white.research.att.com") by vger.kernel.org with ESMTP
	id S1751283AbVL3TM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2005 14:12:58 -0500
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id jBUJHfge019451;
	Fri, 30 Dec 2005 14:17:41 -0500 (EST)
User-Agent: Mail/News 1.5 (X11/20051129)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512301046230.3249@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14116>

Linus Torvalds wrote:
> On Fri, 30 Dec 2005, John Ellson wrote:
>   
>> I think it is probably a bug that "git non_existent_command"
>> returns its error message to stdout without an error, where
>> "git-non_existent_command" behaves differently and does return an
>> error.
>>
>> Older versions of git did not implement "git describe"  and
>> GIT-VERSION-GEN produces an empty version string if run on
>> a system with such a git installed.  The consequence
>> is that "make rpm" fails.
>>
>> This patch fixes GIT-VERSION-GEN so that it works in the
>> absence of a working "git describe"
>>     
>
> Shouldn't you make "git.c" return an error too, so that "git-describe" and 
> "git describe" both fail properly?
>
> I realize that you'd want to do your patch _too_ (in case somebody has an 
> old version of "git" installed), but I just think it would be sensible to 
> fix the problem that causes this in the first place..
>
> Continuing to output to stdout rather than stderr is probably a good idea 
> (so that it's easy to do "git help | less" or something), but yeah, I 
> think an unrecognized command should at least return an error.
>
> 		Linus
>   

I checked and that bug has been fixed since the older version of git that
was causing me problems. "git non_existent_command" now returns 1.
However, the error message was also changed to
goto stderr, which it sounds like you disagree with?   Personally
I don't have a problem with it, although a real "git-help" command
might be a good idea too.

John
