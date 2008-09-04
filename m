From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Peculiar behavior of git 1.5.6
Date: Thu, 04 Sep 2008 10:09:23 +0200
Message-ID: <48BF97B3.5060309@viscovery.net>
References: <48BF759B.9090309@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
X-From: git-owner@vger.kernel.org Thu Sep 04 10:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb9vd-0000wd-0O
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 10:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbYIDIJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 04:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbYIDIJp
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 04:09:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60044 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbYIDIJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 04:09:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kb9u8-0001in-E4; Thu, 04 Sep 2008 10:09:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0010A6D9; Thu,  4 Sep 2008 10:09:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48BF759B.9090309@lwfinger.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94903>

Larry Finger schrieb:
> On one of my systems, I found strange behavior for git-1.5.6.GIT. On the
> first pull of the linux-2.6 tree, I got a message that one file was not
> uptodate. When I investigated any possible differences with git-diff,
> there were none. A subsequent git-pull worked fine. I lost the console
> output for linux-2.6, but the same thing happened for Linville's
> wireless-testing, as shown below:
> 
> finger@sonylap:~/wireless-testing> git --version
> git version 1.5.6.GIT
> finger@sonylap:~/wireless-testing> git pull
> error: Entry 'drivers/bluetooth/bt3c_cs.c' not uptodate. Cannot merge.
> fatal: merging of trees 294e21019bac11cb782e8d1893d02ce98ed816a4 and
> 810d24221c9c532475af90d1b7ba9ca381dc3696 failed
> Merge with strategy recursive failed.
> finger@sonylap:~/wireless-testing> git diff > tmp
> finger@sonylap:~/wireless-testing> cat tmp
> finger@sonylap:~/wireless-testing> git pull
> Removed Documentation/usb/auerswald.txt
> Auto-merged MAINTAINERS
> ...
> 
> Is this a bug in git, an incompatibility between my version and that of
> the server at kernel.org, or something else?

I guess you had touched the timestamp of drivers/bluetooth/bt3c_cs.c in
some way without modifying its contents, which made 'git pull' think it is
modified.

The 'git diff' that you did next corrected this behind your back, so that
the subsequent 'git pull' did not see any modification anymore. (BTW, if
you had used 'git status' instead of 'git diff' you would have observed
the same behavior.)

-- Hannes
