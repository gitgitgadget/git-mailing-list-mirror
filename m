From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle - bundle objects and references for
 disconnected   transfer.
Date: Wed, 14 Feb 2007 21:13:47 -0500
Message-ID: <45D3C1DB.9020009@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net> <45D3A18E.40309@verizon.net>
 <Pine.LNX.4.63.0702150114230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 03:14:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHW8C-00081x-W9
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 03:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbXBOCNw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 21:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbXBOCNw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 21:13:52 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:9591 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964840AbXBOCNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 21:13:50 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDH00A12FJ1PB93@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 20:13:50 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702150114230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39790>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 14 Feb 2007, Mark Levedahl wrote:
> 
>> Mark Levedahl wrote:
>>> Johannes Schindelin wrote:
>>>
> 
> I don't think you need the bases. If you say "master~10..master" on the 
> sender side, you want to update master on the receiving side, _after_ you 
> verified that receiver already has "master~10".
> 
> Ciao,
> Dscho
> 
git>git-rev-parse master~10..master
dc0f74905bd94b88d3b1d477e79faef7e0308fbf
^602598fd5d8f64028f84d2772725c5e3414a112f

Which shows the new head and the commit that the destination needs. That 
is fine. But:

git>git-rev-parse master --since=10.days.ago
dc0f74905bd94b88d3b1d477e79faef7e0308fbf
--max-age=1170641182

is not helpful: it does not tell what is expected to be on the other 
end. And I find both forms absolutely useful in the ways I use 
git-bundle. The latter one does not tell me what is needed. The only way 
I solved that was to walk all the commits from git-rev-list, one at a 
time, to find the parents, and keep the results not otherwise in the 
list. I found that so terribly slow in bash I gave up on it as 
unworkable: I have found in practice my current solution of git-fsck to 
be much faster.

Mark
