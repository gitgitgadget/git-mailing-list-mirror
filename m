From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-checkout sometimes silently fails
Date: Wed, 07 May 2008 10:51:57 +0200
Message-ID: <48216DAD.50902@viscovery.net>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org>	<20080506215049.GC4647@steel.home> <20080506171052.340d643e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 07 10:53:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtfON-0001xt-6d
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYEGIwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbYEGIwB
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:52:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3645 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYEGIwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 04:52:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JtfNV-0000PB-I5; Wed, 07 May 2008 10:51:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 69D1869F; Wed,  7 May 2008 10:51:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080506171052.340d643e.akpm@linux-foundation.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81418>

Andrew Morton schrieb:
> y:/usr/src/git26> git-branch -av | grep '^\*'
> * master               5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
> y:/usr/src/git26> git-checkout linux-next    
> Switched to branch "linux-next"
> y:/usr/src/git26> git-branch -av | grep '^\*'
> * linux-next           5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb

You did not show us the output of 'git branch -av'. Do you happen to see
something like this in the output:

* master               5717922 Merge branch 'for_linus'
  linux-next           5717922 Merge branch 'for_linus'
  linux-next/HEAD      1234567 Something completely different
  linux-next/master    1234567 Something completely different

In this case, your local branch 'linux-next' is probably a left-over from
earlier experiments. The last two branches are actually what you want to
refer to. Normally, the 'linux-next/HEAD' part allows you to refer to
'linux-next/master' by saying simply 'linux-next'. But unfortunately, your
local branch name 'linux-next' takes precedence.

'git fetch' never updates your local branch, but only 'linux-next/master'
(and its alias 'linux-next/HEAD' aka 'linux-next').

To return to a sane state, do 'git branch -D linux-next'.

-- Hannes
