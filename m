From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 20:55:50 +0200 (CEST)
Message-ID: <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 20:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuBIR-0001Az-83
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589AbYEHS4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYEHS4A
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:56:00 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50066 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757498AbYEHSz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 14:55:58 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 11D9010639A;
	Thu,  8 May 2008 14:55:58 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 08 May 2008 14:55:58 -0400
X-Sasl-enc: DRz44ewvCzVtTVpn54kOtyImsmJP8nfxFO+6herdZ6H7 1210272954
Received: from [192.168.2.100] (p549A6B5C.dip.t-dialin.net [84.154.107.92])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 781791FB8F;
	Thu,  8 May 2008 14:55:54 -0400 (EDT)
In-Reply-To: <20080508183926.GA30613@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LSU 1032 2008-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81553>

On Thu, 8 May 2008, Jeff King wrote:
> On Thu, May 08, 2008 at 07:45:31PM +0200, Guido Ostkamp wrote:
>
>> [gc]
>>         reflogExpire = 0
>>         reflogExpireUnreachable = 0
>>         rerereresolved = 0
>>         rerereunresolved = 0
>>         packrefs = 1
>
> git-gc uses a "safe" pruning mode, where it only prunes unreferenced
> objects that are older than a certain period (this makes it safe to run
> git-gc, even if other processes are creating objects at the same time).
>
> So try
>
> [gc]
>        pruneExpire = now
>
> Alternatively, you can just run 'git prune' manually instead of 'git
> gc'.

Jeff, I tried it, but it has no effect (see below). There is only the 
master branch left, and only one commit therein, still it uses the space 
former occupied by the branch. I'm using git version 1.5.5.1.147.g867f.

Any further ideas?


$ git config -l
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
gc.reflogexpire=0
gc.reflogexpireunreachable=0
gc.rerereresolved=0
gc.rerereunresolved=0
gc.packrefs=1
gc.pruneexpire=now

$ git gc
Counting objects: 6, done.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (6/6), done.
Total 6 (delta 0), reused 6 (delta 0)

$ git prune

$ git branch
* master

$ du -s .
30820   .

$ git log
commit 9717437cdcb2a4457f28f41db5f6fad9ca55b54e
Author: Testuser <testuser@bianca.dialin.t-online.de>
Date:   Thu May 8 19:40:06 2008 +0200

     initial checkin

$ ls -l
total 10240
-rw-r--r-- 1 testuser users 10485760 May  8 19:40 file

Regards

Guido
