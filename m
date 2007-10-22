From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-format-patch: Don't number patches when there's only
 one
Date: Mon, 22 Oct 2007 13:13:05 +0200
Message-ID: <471C85C1.3020308@op5.se>
References: <20071021144637.762085BB92@nox.op5.se> <Pine.LNX.4.64.0710221044080.25221@racer.site> <471C77F0.5050701@op5.se> <Pine.LNX.4.64.0710221119300.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjvDm-0001sR-JD
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbXJVLNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbXJVLNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:13:09 -0400
Received: from mail.op5.se ([193.201.96.20]:35817 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbXJVLNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:13:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 87B7D173067A;
	Mon, 22 Oct 2007 13:13:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.453
X-Spam-Level: 
X-Spam-Status: No, score=-2.453 tagged_above=-10 required=6.6
	tests=[AWL=0.046, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KRBvUeHSDp+Y; Mon, 22 Oct 2007 13:13:05 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B2665173064F;
	Mon, 22 Oct 2007 13:13:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710221119300.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61987>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Sun, 21 Oct 2007, Andreas Ericsson wrote:
>>>
>>>> [PATCH 1/1] looks a bit silly, and automagically handling this in 
>>>> git-format-patch makes some scripting around it a lot more pleasant.
>>> I think you should not use "-n" if you do not want to have the 
>>> numbers.
>> This stems from creating scripts around it where I only want to see the 
>> numbers if there is more than a single patch. Currently I can't do that 
>> without running git-format-patch twice or re-implementing the revision 
>> parsing machinery to count revisions prior to passing arguments to 
>> format-patch.
> 
> Why not have something as simple as
> 
> 	numbered=
> 	test $(git rev-list $options | wc -l) -gt 1 && numbered=-n
> 

Because 23498~12 != 23498~12..HEAD to git rev-list, but it is to
git-format-patch, meaning I'll have to duplicate the logic in every 
script that's supposed to use it or risk introducing a third way of 
specifying a list of revisions.

> 	[...]
> 
> 	git format-patch $numbered $options
> 
> At the moment, the semantics of "--numbered" is really clear and precise.  
> And I really like that.  It makes for less surprises.
> 

Semantics could be equally clear for --numbered-if-multiple.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
