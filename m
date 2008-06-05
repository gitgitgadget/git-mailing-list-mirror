From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 05 Jun 2008 15:36:03 +0200
Message-ID: <4847EBC3.8060509@viscovery.net>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:37:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4FeJ-0007SY-1c
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbYFENgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbYFENgJ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:36:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13108 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbYFENgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:36:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K4FdL-00033M-KY; Thu, 05 Jun 2008 15:36:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 66D496B7; Thu,  5 Jun 2008 15:36:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0806051403370.21190@racer>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83929>

Johannes Schindelin schrieb:
> Hi,
> 
> On Thu, 5 Jun 2008, Johannes Sixt wrote:
> 
>> Johannes Schindelin schrieb:
>>> +--fixup-line-counts::
>>> +	Fix up the line counts (e.g. after editing the patch without
>>> +	adjusting the hunk headers appropriately).
>> This sort of implies that there is some kind of output that tells the
>> correct line counts. But that isn't the case (if I read the patch
>> correctly). So I suggest to name the option --ignore-line-counts.
> 
> But there is some kind of output: the hunks themselves.

Is there? I did this (it rewrites all line counts to 1):

$ git diff ..HEAD~1 |
	sed -e '/^@@/s/,[0-9]+ /,1 /g' |
	./git-apply --fixup-line-counts

and there was no output. Instead, the patch was applied.

>  And the line 
> counts are not ignored, but they are actively rewritten.

Of course, internally there is some sort of "output" from the fixup
routine, and the line counts are rewritten and then are not ignored. But
the user doesn't care about this internal procedure. From the user's
perspective, the line counts of the input patch are ignored.

Apart from this color of the bikeshed I like your patch.

-- Hannes
