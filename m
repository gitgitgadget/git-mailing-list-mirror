From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle - bundle objects and references for
 disconnected transfer.
Date: Wed, 14 Feb 2007 18:55:58 -0500
Message-ID: <45D3A18E.40309@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 00:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHTyw-0003eL-Cj
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 00:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbXBNX4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 18:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbXBNX4L
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 18:56:11 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:31111 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXBNX4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 18:56:11 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDH00EMW95AZPE2@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 17:56:00 -0600 (CST)
In-reply-to: <45D398F9.6070205@verizon.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39775>

Mark Levedahl wrote:
> Johannes Schindelin wrote:
>
>>
>> Would it not be better to say explicitely which refs are expected to 
>> be present already (they start with "^" in the output of 
>> `git-rev-parse`, but you would need to do a bit more work, since you 
>> cannot just take the symbolic names).
>>
>> IMHO reliance on $(git fsck | grep ^missing) is not good. The file 
>> check might take very, very long, or use much memory. And you _can_ 
>> do better [*1*].
>>   
> Good idea, but I think it is simpler to just keep the ^... output from 
> git-rev-parse and check that those exist. What you suggest below seems 
> to presume all bases are themselves references, which is not the case 
> when doing, for example, master~10..master.
Examining further, I just don't know how to do this in shell. Basically, 
what I want is the list of parents of all bases, but those bases might 
not be explicitly mentioned, e.g., master --since=10.days.ago and I 
don't understand any direct plumbing call that will give me the list of 
parents in the general case. At the expense of extreme slowness I can do 
some of this invoking sort and uniq with long lists of objects. The pain 
in doing that on the sender side is definitely worth the potential gain 
on the receiver side (I now remember I tried that a while back, was able 
to do something reasonable in Python using sets, it died in bash).

Mark
