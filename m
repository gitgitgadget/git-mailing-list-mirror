From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 17:19:26 +0100
Message-ID: <4BA1010E.8030908@viscovery.net>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock> <4BA07DC7.9070502@viscovery.net> <4BA0FD5B.5090408@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrvzY-0003Q7-8W
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab0CQQUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 12:20:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10357 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754320Ab0CQQT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 12:19:28 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nrvxu-0005Zt-Nx; Wed, 17 Mar 2010 17:19:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7860F1660F;
	Wed, 17 Mar 2010 17:19:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4BA0FD5B.5090408@xiplink.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142409>

Marc Branchaud schrieb:
> Johannes Sixt wrote:
>> If I were to re-merge topic into master a second time after this
>> situation, I would install a temporary graft that removes the second
>> parent of M and repeat the merge. After the graft is removed, the history
>> would look like this:
>>
>>      B --- C --- D --------------.   [topic]
>>    /              \               \
>>   A ---  ...   --- M ... --- U ... N [master]
>>
>> Are there any downsides? I don't know - I haven't thought it through.
> 
> I'm not sure I follow how to create that graft.

  $ echo $(git rev-parse M M^) >> .git/info/grafts

> But the original point (which I hadn't made clear) is that at least one of
> the topic's commits needs to change in some substantial way.  So it's not
> just a straight re-merge but a new take on the topic.
> 
> Consider that if the topic's first commit (B) needed to be rewritten then the
> repaired topic would contain only new commits and it could be merged into
> master without reverting the first merge's reversion.

You don't need --ff nor --no-ff in this case.

> What "rebase -i --no-ff" does is allow you to ensure that this will always be
> the case, even if you don't actually need to change the topic's first commit.

But why do you base the reworked topic on A instead of U or later?

Or why don't you just mark the first commit as r(eword) and just exit the
editor; it would rewrite the commit and all subsequent ones will be
rewritten as well. Never in my life would I have searched for a *option*
that achieves the goal. It is such a rare situation that we don't need an
option, do we?

-- Hannes
