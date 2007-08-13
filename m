From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 09:32:28 +0200
Message-ID: <521D9D91-2422-4378-BD68-37550731E06A@zib.de>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net> <46BFFB1A.4070704@trolltech.com> <5BA0164D-8327-4B01-84CD-595D8573BEEF@zib.de> <46C00515.5050308@trolltech.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brian Downing <bdowning@lavos.net>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 09:35:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKUSj-0001MX-BL
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 09:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939844AbXHMHfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 03:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S942125AbXHMHfe
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 03:35:34 -0400
Received: from mailer.zib.de ([130.73.108.11]:61781 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S940134AbXHMHfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 03:35:32 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7D7W116014174;
	Mon, 13 Aug 2007 09:34:43 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10789.pool.einsundeins.de [77.177.7.137])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7D7VugV008130
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 09:31:56 +0200 (MEST)
In-Reply-To: <46C00515.5050308@trolltech.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55751>


On Aug 13, 2007, at 9:15 AM, Marius Storm-Olsen wrote:

> Steffen Prohaska said the following on 13.08.2007 08:50:
>> On Aug 13, 2007, at 8:32 AM, Marius Storm-Olsen wrote:
>>> In msysgit.git/etc/.gitattributes we have 'termcap -crlf', to  
>>> avoid  the termcaps being checked out with Windows EOL, if the  
>>> user  happens to have 'autocrlf = true'. However, when you  
>>> checkout the  working dir the first time it still has Windows EOL  
>>> due to exactly  this problem.
>> And exactly this is where I recognized the issue.
>> msysgit devs,
>> We should really make autocrlf = true the default for us and fix
>> all problems that we'll encounter. There may be more tricky stuff
>> ahead, like merges, cherry-picks, ...
>
> I'm more leaning towards having the installer give you the option  
> to choose what kind of line-endings you want Git to work with; just  
> like the Cygwin installer.

Which is the root of much trouble with Cygwin. People now say,
git works perfectly in Cygwin but forget to mention that they
mean Cygwin A (in binmode) but not Cygwin B (in textmode).

Better choose the right default and work hard to make the
default choice work perfectly. I am strongly against an option
in the installer. An option _will_ cause confusion. Better give
people a hint how they can override the default for a single
user, or for a single repo. Then they recognize that they move
to a non-default configuration and hopefully think twice. And we
never need to talk about msysgit A vs. msysgit B, but only about
msysgit with repo specific or user specific options.

For me, the question comes down to the following: What would the
average Windows user (real Windows user, not Linux user who was
forced to work in Cygwin!) expect git to do with line endings?
The answer to this question should be the default.

	Steffen
