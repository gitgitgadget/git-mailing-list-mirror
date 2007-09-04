From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 16:52:13 +0200
Message-ID: <46DD711D.2080209@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com> <46DD473A.8010602@trolltech.com> <46DD63F5.5050002@trolltech.com> <46DD6694.6030701@eudaptics.com> <Pine.LNX.4.64.0709041530560.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:52:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZlN-0002ak-WC
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbXIDOwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbXIDOwR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:52:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49547 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbXIDOwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:52:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISZlF-0005KK-Nu; Tue, 04 Sep 2007 16:52:14 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C45D56B7; Tue,  4 Sep 2007 16:52:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709041530560.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.365, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57588>

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 4 Sep 2007, Johannes Sixt wrote:
> 
>> Marius Storm-Olsen schrieb:
>>> Marius Storm-Olsen said the following on 04.09.2007 13:53:
>>>> In the meantime, I've pushed out a new patch
>>>> http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=683775c00d9fb95bcbe4632f95b67a96b902fa59 
>>>>
>>>> /me starts another test run, to see how our tests are doing now..
>>> Neat, with the custom stat() changes cherry-picked on top of 4msysgit.git
>>> 'devel' branch, I only have one failing testcase
>>>     t6024-recursive-merge.sh
>>> when running
>>>     $ NO_SYMLINKS=1 make -k
>>>
>>> The rest are passing with flying colors!
>> And that one will eventually pass if only you try it often enough. See
>> 71ee4210c in mingw.git.
> 
> Do you have Linus' patch applied?  The one where the config is read at the 
> start of write-tree?
> 
> The problem only occurred since we have core.crlf = input unilaterally 
> now.

Yes, I have that patch, but I don't have core.crlf set.

There are a lot of tests that do a series of commits in a row, with file 
changes such that the file size does _not_ change, aka "racy git" problem. 
This problem is obviously not 100% fixed on MSys: We do not correctly detect 
that there are files that might be modified ("racily clean" files). Some 
tests are prone to trigger the bug, others not.

-- Hannes
