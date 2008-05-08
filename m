From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: git gc & deleted branches
Date: Thu, 8 May 2008 19:45:31 +0200 (CEST)
Message-ID: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 20:06:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuAVV-0006at-AM
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbYEHSF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761500AbYEHSF1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:05:27 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50571 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751001AbYEHSF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 14:05:26 -0400
X-Greylist: delayed 1189 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 14:05:26 EDT
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 99244105EF6
	for <git@vger.kernel.org>; Thu,  8 May 2008 13:45:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 08 May 2008 13:45:36 -0400
X-Sasl-enc: thyc2rmwzZ61tDDltNO5XFPecYxb6dyT8EHpruhNUjpS 1210268736
Received: from [192.168.2.100] (p549A6B5C.dip.t-dialin.net [84.154.107.92])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DEFEE18202
	for <git@vger.kernel.org>; Thu,  8 May 2008 13:45:35 -0400 (EDT)
User-Agent: Alpine 1.10 (LSU 1032 2008-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81546>

Hello,

I'm trying to reclaim space from an abandoned branch (never involved in 
any merge) using 'git gc', but it doesn't appear to work:

   mkdir testrepo
   cd testrepo
   git init
   dd if=/dev/urandom bs=1024k count=10 of=file
   git add file
   git commit -a -m 'initial checkin'
   git checkout -b test
   dd if=/dev/urandom bs=1024k count=10 of=file
   git commit -a -m 'branch checkin'
   git checkout master
   du -s .    # returns 30960
   git branch -D test
   git gc
   du -s .    # returns 30916

Here I had expected ~20000 since the branch uses ~10000.

My config is

[gc]
         reflogExpire = 0
         reflogExpireUnreachable = 0
         rerereresolved = 0
         rerereunresolved = 0
         packrefs = 1

I also tried 'git-pack-refs --all' or 'git-pack-refs --prune' but to no 
avail.

What am I doing wrong?

Thanks for any hints.

Regards

Guido
