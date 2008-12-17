From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to work in hirarchical git model?
Date: Wed, 17 Dec 2008 09:48:36 +0100
Message-ID: <4948BCE4.7030605@viscovery.net>
References: <703400.93370.qm@web112210.mail.gq1.yahoo.com> <4948AB14.8030004@viscovery.net> <753177.33978.qm@web112212.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gili Pearl <gili.pearl@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCs6Q-0003fR-QQ
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYLQIsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbYLQIsk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:48:40 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15075 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYLQIsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:48:39 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LCs57-0007YL-7O; Wed, 17 Dec 2008 09:48:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DF82854D; Wed, 17 Dec 2008 09:48:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <753177.33978.qm@web112212.mail.gq1.yahoo.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103321>

Gili Pearl schrieb:
> ----- Original Message ----
>> From: Johannes Sixt <j.sixt@viscovery.net>
>>
>> Gili Pearl schrieb:
>>> Here is one problem I saw when trying to work in the three-level model.
>>> At some point, I had the following setup:
>>>
>>> top-level : A----B----C----D
>>>                   \
>>>                     \
>>> mid-level1:        K----L----M
>>>                           \
>>>                             \
>>> low-level1:                X----Y
>>>
>>> The maintainer of mid-level1 has decided that commits K L M are ready to be 
>>> merged into the top-level repo. So he rebased on top-level before asking 'please 
>>> pull', but after that the low-level was not able to rebase on the mid-level 
>>> any more. 
>> In this model, the mid-level1 maintainer should *not* rebase against
>> top-level. Rather, he should ask the top-level maintainer to *merge* K-L-M.
>>
> 
> 
> But what if K-L-M conflict with C-D? The one who should take care about it is 
> the mid-level1 maintainer (or possibly one of the low-level1 maintainers).

Ideally, mid-level1 maintainer will have done the merge in a throw-away
branch and will know about the difficulties of the merge and has to tell
top-level maintainer about it. Then top-level maintainer decides whether
he can redo the merge himself (because it's trivial enough), or whether he
prefers to pull the throw-away merge, which then obviously is
not-so-throw-away anymore.

> I still don't see clearly what happens next in the example above when the low 
> level developr wants to push X-Y upstream? On which branch should he rebase? 
> Need he rebase on mid-level (where K-L-M were already merged upstream), or 
> maybe direclty on the top-level?? 

The question is perhaps: How do the mid-level and low-level developers get
the changes made by the other teams?

The answer is: When mid-level has completed a feature (i.e. the branch was
integrated into top-level), then he is allowed to pull from top-level.
This must result in a fast-forward merge. Low-level developers always
rebase against mid-level.

-- Hannes
