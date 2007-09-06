From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Thu, 06 Sep 2007 18:18:38 +0200
Message-ID: <46E0285E.1000603@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITK4D-0007nL-B3
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387AbXIFQSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757316AbXIFQSs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:18:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47187 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757300AbXIFQSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:18:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ITK42-00025H-J6; Thu, 06 Sep 2007 18:18:45 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 793894E4; Thu,  6 Sep 2007 18:18:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46DD0C16.70101@eudaptics.com>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.357, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57896>

Johannes Sixt schrieb:
> Marius Storm-Olsen schrieb:
>> Johannes Schindelin wrote:
>>> To make it easier on others, I just uploaded it into the "teststat"
>>> branch on 4msysgit.git (subject to removal in a few days).
>>
>> Ok, I've updated the patch in the 4msysgit.git repo, 'teststat' branch.
>> RFC, and please test.
> 
> Thanks a lot! I've pushed it out in mingw.git's master.
> 
> The reason that t4200-rerere.sh fails is that we now store UTC in 
> st_mtime. However, for the garbage-collection we compare this entry to a 
> local time stamp.

This analysis is incorrect, I think. The reason we fail seems to be that 
t4200 uses test-chmtime, which uses utime(). Likely, we need a wrapper for 
that one?

-- Hannes
