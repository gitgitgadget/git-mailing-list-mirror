From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 10:51:48 +0200
Message-ID: <DD0F51D8-390E-41DB-BD80-0BB440418D01@zib.de>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net> <46BFFB1A.4070704@trolltech.com> <5BA0164D-8327-4B01-84CD-595D8573BEEF@zib.de> <46C00515.5050308@trolltech.com> <521D9D91-2422-4378-BD68-37550731E06A@zib.de> <46C018DA.1020309@trolltech.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brian Downing <bdowning@lavos.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 10:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKVf7-0003yy-E1
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 10:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969641AbXHMIv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 04:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969583AbXHMIvz
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 04:51:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:35925 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969528AbXHMIvx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 04:51:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7D8p1BK020191;
	Mon, 13 Aug 2007 10:51:01 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7D8p1Yv024389
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 10:51:01 +0200 (MEST)
In-Reply-To: <46C018DA.1020309@trolltech.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55753>


On Aug 13, 2007, at 10:39 AM, Marius Storm-Olsen wrote:

> Steffen Prohaska said the following on 13.08.2007 09:32:
>> On Aug 13, 2007, at 9:15 AM, Marius Storm-Olsen wrote:
>>> Steffen Prohaska said the following on 13.08.2007 08:50:
>>>> We should really make autocrlf = true the default for us and
>>>> fix all problems that we'll encounter. There may be more tricky
>>>> stuff ahead, like merges, cherry-picks, ...
>>> I'm more leaning towards having the installer give you the option
>>>  to choose what kind of line-endings you want Git to work with;
>>> just like the Cygwin installer.
>> Which is the root of much trouble with Cygwin. People now say, git
>> works perfectly in Cygwin but forget to mention that they mean
>> Cygwin A (in binmode) but not Cygwin B (in textmode).
>> Better choose the right default and work hard to make the default
>> choice work perfectly. I am strongly against an option in the
>> installer. An option _will_ cause confusion. Better give people a
>> hint how they can override the default for a single user, or for a
>> single repo. Then they recognize that they move to a non-default
>> configuration and hopefully think twice. And we never need to talk
>> about msysgit A vs. msysgit B, but only about msysgit with repo
>> specific or user specific options.
>> For me, the question comes down to the following: What would the  
>> average Windows user (real Windows user, not Linux user who was  
>> forced to work in Cygwin!) expect git to do with line endings? The
>> answer to this question should be the default.
>
> If we were talking about a huge amount (real) Windows users I would  
> agree with you. However, currently most of the users using Git on  
> Windows are Unix users which for some reason have to work on  
> Windows every now and then. And changing the default option to  
> autocrlf=true would be stepping on their toes, which we probably  
> don't want to do :-)

My target audience of Git on Windows are Windows users and, frankly,
that is the only reasonable way to think about Windows. Why else should
I boot Windows, if I don't have real Windows users in mind? I mean,
Windows is not the superior platform to build Unix on top. The reason
to boot Windows is Windows itself, including its real users.


> I'm a Windows developer myself, so I naturally have autocrlf=true  
> in my global settings. I don't think having the option in the  
> installer (together with other things, like setting the global  
> username, and email for example) would be such a bad thing. The  
> problem with the way the Cygwin installer presents it is that it  
> doesn't explain the pros and cons of the two options; it just  
> recommends Linux EOL, which leads to confusion with some Windows  
> developers.

The problem is that Cygwin doesn't really support textmode. It
offers a choice, where there is no choice. After selecting textmode,
I still can install git. But git doesn't work.


> If we properly explain the issue in the installer, and say we  
> recommend Windows EOL for Windows developers, I think it's OK. It  
> would in any case be better than the current state where you have  
> no option, or stepping on all the current msysgit/mingw-git  
> maintainers toes.

Maybe I don't fully understand what msysgit is about. I thought it would
be about real Windows support, which I think requires to accept what
Windows users expect to be the right thing: Windows EOL.

In the long run it will also be easier for us, because other Windows
tools expect Windows EOL. I'm pretty sure that git plays better on
Windows if it has Window EOL on by default.

	Steffen
