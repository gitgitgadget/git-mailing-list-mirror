From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict
 subset of remote ref
Date: Thu, 01 Nov 2007 10:29:11 +0100
Message-ID: <47299C67.1090309@op5.se>
References: <1193593581312-git-send-email-prohaska@zib.de>	<1193593581114-git-send-email-prohaska@zib.de>	<1193593581486-git-send-email-prohaska@zib.de>	<11935935812185-git-send-email-prohaska@zib.de>	<11935935822846-git-send-email-prohaska@zib.de>	<11935935821136-git-send-email-prohaska@zib.de>	<11935935823045-git-send-email-prohaska@zib.de>	<11935935821800-git-send-email-prohaska@zib.de>	<11935935823496-git-send-email-prohaska@zib.de>	<11935935821192-git-send-email-prohaska@zib.de>	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>	<B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de>	<7vve8nglrt.fsf@gitster.siamese.dyndns.o
 rg>	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <47298BD7.2000902@op5.se> <0A8A6A99-4C8B-4056-9068-DA54B69B08B5@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 01 10:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InWNE-00084b-FD
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 10:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbXKAJ3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 05:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbXKAJ3W
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 05:29:22 -0400
Received: from mail.op5.se ([193.201.96.20]:47965 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754625AbXKAJ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 05:29:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4500117305A4;
	Thu,  1 Nov 2007 10:28:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXGBUK8sTmGm; Thu,  1 Nov 2007 10:28:23 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 87392173058C;
	Thu,  1 Nov 2007 10:28:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <0A8A6A99-4C8B-4056-9068-DA54B69B08B5@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62932>

Steffen Prohaska wrote:
> 
> On Nov 1, 2007, at 9:18 AM, Andreas Ericsson wrote:
> 
>> Junio C Hamano wrote:
>>
>>> (actually, shared repository people seem to
>>> prefer "fetch + rebase" over "pull" which is "fetch + merge").
>>
>> That's definitely true. The number of useless merge-commits we
>> have in our repos is annoying, and has twice made bisect a bit
>> troublesome for no good reason.
> 
> Can you describe a bit more what's "annoying" about them?
> Is it the visualization? Or are there more problems; like
> the trouble with bisect?
> 

Visualization is a small nuissance. git-bisect troubles are more
worrisome. I've been in the seat where useless merges means git
bisect needs constant babysitting and constant manual handling.
It's no fun at all, so we're sticking with the fetch+rebase flow.

> I'm trying to estimate if it's worth teaching _all_
> developers rebase or if we should just live with the "useless"
> merge-commits.
> 

I'd say that depends on how valuable you find gitk, qgit and
git-bisect are. To me, I'd happily use any scm in the world,
so long as it has git-bisect. Otoh, I'm a lazy bastard and
love bisect so much that all our automated tests are focused
around "git bisect run". This means bugs in software released
to customers are few and far apart. When we get one reported,
we just create a new test that exposes it, fire up git-bisect
and then go to lunch. Quality costs, however. We pay that bill
by using a workflow that's perhaps more convoluted than
necessary.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
