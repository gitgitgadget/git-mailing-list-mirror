From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Windows: set gitexecdir = $(bindir)
Date: Sat, 19 Jul 2008 19:10:40 +0200
Message-ID: <9B346ED9-DAD8-4CC7-A1B5-0230ACA358BA@zib.de>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at> <1216366485-12201-5-git-send-email-johannes.sixt@telecom.at> <7vej5q67dq.fsf@gitster.siamese.dyndns.org> <200807191052.20057.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jul 19 19:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKG0D-0005SO-PV
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 19:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYGSRKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 13:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbYGSRKb
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 13:10:31 -0400
Received: from mailer.zib.de ([130.73.108.11]:57933 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbYGSRKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 13:10:31 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6JHAHK3016693;
	Sat, 19 Jul 2008 19:10:22 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db95020.pool.einsundeins.de [77.185.80.32])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6JHAGH3009783
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 19 Jul 2008 19:10:16 +0200 (MEST)
In-Reply-To: <200807191052.20057.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89114>


On Jul 19, 2008, at 10:52 AM, Johannes Sixt wrote:

> On Samstag, 19. Juli 2008, Junio C Hamano wrote:
>> Sorry, I am not sure if I understand what you are trying to solve.   
>> If you
>> have ../libexec/git-core/ in GIT_EXEC_PATH (or have  
>> builtin_exec_path()
>> use it), then your installation would look like this:
>>
>> 	[[some random place]]
>>        	bin/git
>>                libexec/git-core/git-add
>>                libexec/git-core/git-del
>>                libexec/git-core/git-dir
>>                ...
>>
>> and if "git" can figure out it is "[[some random place]]/bin/git",
>> it can find its subcommands from neighbouring directory, that is  
>> still
>> inside the random place the user told the installer to use, can't it?
>
> Yes, but...
>
> Take as an example 'git pull'.
>
> - The first call to git will derive the exec-path
> $prefix/bin/../libexec/git-core and prepend it to $PATH.
>
> - Calls to builtin git commands from inside 'git pull' will then  
> derive the
> exec-path $prefix/bin/../libexec/git-core/../libexec/git-core, that is
> $prefix/libexec/libexec/git-core, and prepend it to $PATH as well.  
> That
> directory does not exist - usually - and it does not hurt. But it  
> feels dirty
> and potentially dangerous.

Maybe we can avoid this based on the name of the executable?
We would add libexec only if the executable is named "git",
but not if it is one of the dashed forms "git-*".

	Steffen
