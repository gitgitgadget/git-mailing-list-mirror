From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle - bundle objects and references for
 disconnected transfer.
Date: Wed, 14 Feb 2007 18:19:21 -0500
Message-ID: <45D398F9.6070205@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 00:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHTPW-00023j-9g
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 00:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbXBNXTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 18:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXBNXTd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 18:19:33 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:64490 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXBNXTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 18:19:33 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDH00K3Y7G9IDN1@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 17:19:22 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39772>

Johannes Schindelin wrote:
> This is not necessary. You should do this instead:
>
> 	. git-sh-setup
>   
I debated that, it seemed a wash but can do.
> Throughout git, we seem to do both "--output=<bla>" _and_ "--output <bla>" 
> forms, or just the latter.
>   
Patches gratefully accepted for that. This exceeds my skills in bash: I 
can do that in python, C, or other languages, but in bash I am working 
through a list that is a part of $* an arg at a time with no ability to 
look at the next, which is what this needs. Unless of course bash arrays 
are part of portable shell (not sure on that).
>> +git-show-ref $refs > .gitBundleReferences
>>     
>
> Would it not be better to say explicitely which refs are expected to be 
> present already (they start with "^" in the output of `git-rev-parse`, but 
> you would need to do a bit more work, since you cannot just take the 
> symbolic names).
>
> Some general remarks:
>
> It would be so much nicer if you worked without temporary files (you could 
> do that by starting the file with the refs, then have an empty line, and 
> then just pipe the pack after that).
>   
Originally, this was in python with zip file built in memory (no 
temporaries). Sticking to portable shell makes many easy things really 
hard. I'll think about this.
> IMHO reliance on $(git fsck | grep ^missing) is not good. The file check 
> might take very, very long, or use much memory. And you _can_ do better 
> [*1*].
>   
Good idea, but I think it is simpler to just keep the ^... output from 
git-rev-parse and check that those exist. What you suggest below seems 
to presume all bases are themselves references, which is not the case 
when doing, for example, master~10..master.
> Also, your use of shallow is incorrect. If the boundary commits are 
> present, you might just leave them as-are, but if they are not present, 
> you have to mark them as shallow. Otherwise, you end up with a corrupt 
> (not shallow) repository.
>   
I have to say I do not understand what "mark them as shallow" means: can 
you please enlighten me further?


Thanks,
Mark
