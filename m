From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-commit --amend: respect grafted parents.
Date: Wed, 26 Sep 2007 14:52:20 +0200
Message-ID: <46FA5604.101@viscovery.net>
References: <11908086961933-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0709261322150.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 14:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaWNX-0001L2-Vb
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 14:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbXIZMw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 08:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbXIZMw2
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 08:52:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43204 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbXIZMw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 08:52:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaWNM-00058x-RW; Wed, 26 Sep 2007 14:52:25 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AF3F354D; Wed, 26 Sep 2007 14:52:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709261322150.28395@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59228>

Johannes Schindelin schrieb:
> Hi,
> 
> On Wed, 26 Sep 2007, Johannes Sixt wrote:
> 
>> This allows a poor-mans-filter-branch of the top-most commit.
>>
>> Specifically, I had this history:
>>
>>    --o--o--A'    <-- amended version of A
>>          \
>>           A
>>            \
>>     --o--B--M
>>
>> I now wanted to "amend" M to pull in A' instead of A as its second 
>> parent. For various reasons I didn't want to redo the merge M again, in 
>> particular, it already contained the changes that were amended into A'. 
>> So I figured I would just install a graft that lists B and A' as parents 
>> of M and then do a simple git commit --amend. Alas, git commit looks at 
>> the real parents instead of the grafted ones, so the amended M' would 
>> still have A as its second parent. Here is the fix that picks the 
>> grafted parents instead.
> 
> I do not think that this is a "fix".
> 
> I'd really suggest that you fix it up (before the amend!) by installing 
> the graft, and running git-filter-branch -1 <branch>.  (Note: I did not 
> test this, but it _should_ work.  If it does not, please let me know.)

The problem with filter-branch is that it leaves a committer date in M that 
is before A', and for this reason is not the right tool for this task. So I 
do think that this fix is necessary.

-- Hannes
