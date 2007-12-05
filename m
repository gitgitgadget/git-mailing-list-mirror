From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to jump between two repositories ...
Date: Wed, 05 Dec 2007 09:45:26 +0100
Message-ID: <47566526.9010900@op5.se>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com> <20071205061425.GE11098@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: g2 <gerald.gutierrez@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 09:45:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzptD-0001aR-6p
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 09:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbXLEIpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 03:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbXLEIpe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 03:45:34 -0500
Received: from mail.op5.se ([193.201.96.20]:37305 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbXLEIpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 03:45:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9EA721F08083;
	Wed,  5 Dec 2007 09:45:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fkVOhSr45XyO; Wed,  5 Dec 2007 09:45:32 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id C8FF21F08024;
	Wed,  5 Dec 2007 09:45:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071205061425.GE11098@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67125>

J. Bruce Fields wrote:
> On Tue, Dec 04, 2007 at 09:59:57PM -0800, g2 wrote:
>> Hello all,
>>
>> I am currently working on some code at the office that I also want to work 
>> with at home. Seems like a good candidate for git. So I created a 
>> repository at work and did a "git clone" at home. I've run into some 
>> strange behaviour that I don't understand and would appreciate if someone 
>> can clarify for me.
>>
>> Imagine this scenario. At work:
>> git init
>> edit test.c
>> git add test.c
>> git commit
>>
>> Then at home:
>> git clone <work git url>
>> edit test.c
>> git commit -a
>> git push
> 
> You'll be much happier at this point if you ssh into work and then git
> pull from home....
> 
>> At this point, I wanted to push my changes back to my work repository so I 
>> can continue work the next day. So at home, I did a git push. I expect that 
>> my work repository has the newest material, but I find that when I do "git 
>> status" at work the next day, it tells me that my test.c is "modified" and 
>> has already staged it for commit. I need to do a "git reset" followed by 
>> "git checkout" to update my work folder to the latest stuff.
>>
>> Totally different from my expectation of the repository knowing that it is 
>> out of date and then kindly suggesting that I should do a "git update" of 
>> some sort. What piece of understanding am I missing to properly "get" what 
>> is going on here, and how am I supposed to properly work with this setup?
> 
> Git doesn't support pushing to any branch that's checked out somewhere.
> 

Yes it does. It just supports it badly. If there is a work-tree connected to
the receiving repository and that work-tree is pristine, it would be safe and
sane to write the newly pushed changes to the connected working tree.

We do all our integration fixups by pushing to repositories with work-trees,
simply because it's ridiculously inconvenient to add the infrastructure to
pull to those repos from each individual developer. In that scenario, pushing
to a checked out branch is highly useful and perfectly safe.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
