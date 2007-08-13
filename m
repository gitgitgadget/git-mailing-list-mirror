From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 08:50:36 +0200
Message-ID: <5BA0164D-8327-4B01-84CD-595D8573BEEF@zib.de>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net> <46BFFB1A.4070704@trolltech.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brian Downing <bdowning@lavos.net>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:51:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKTlZ-0007LG-Cu
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 08:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763088AbXHMGuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967913AbXHMGuM
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 02:50:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:58464 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968100AbXHMGuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 02:50:09 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7D6npPi011271;
	Mon, 13 Aug 2007 08:49:51 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10789.pool.einsundeins.de [77.177.7.137])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7D6nnCx028862
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 08:49:50 +0200 (MEST)
In-Reply-To: <46BFFB1A.4070704@trolltech.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55748>


On Aug 13, 2007, at 8:32 AM, Marius Storm-Olsen wrote:

> Junio C Hamano said the following on 13.08.2007 08:14:
>> Ok, let's step back a bit and I'll suggest an alternative
>> approach to your 1/2.  This would hopefully solve 2/2 without
>> any code change your patch 2/2 has.
> (..snip..)
>> I think this approach is very much in line with how the git
>> plumbing works, but you would need to know how the world is
>> designed to work in order to appreciate it fully.  Let's have a
>> few paragraphs to give the readers some background.
> (..snip..)
>> Currently, the attr_stack code reads only from the work tree
>> and work tree alone.  We could change it to:
>>  - If the directory on the work tree has .gitattributes, use it
>>    (this is what the current code does);
>>  - Otherwise if the index has .gitattributes at the
>>    corresponding path, use that instead.
>> This essentially treats not having .gitattributes files checked
>> out as equivalent to having these files checked out unmodified,
>> which is very much in line with how the world is designed to
>> work.
>
> ACK! We really need this! :-)
>
> In msysgit.git/etc/.gitattributes we have 'termcap -crlf', to avoid  
> the termcaps being checked out with Windows EOL, if the user  
> happens to have 'autocrlf = true'. However, when you checkout the  
> working dir the first time it still has Windows EOL due to exactly  
> this problem.

And exactly this is where I recognized the issue.

msysgit devs,
We should really make autocrlf = true the default for us and fix all
problems that we'll encounter. There may be more tricky stuff ahead,
like merges, cherry-picks, ...

	Steffen
