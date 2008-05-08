From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git gc & deleted branches
Date: Thu, 08 May 2008 15:07:53 -0500
Message-ID: <48235D99.2040407@nrlssc.navy.mil>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu May 08 22:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuCQH-0006Ir-Qp
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYEHUIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYEHUIN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:08:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37416 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbYEHUIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 16:08:07 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m48K7sc1025699;
	Thu, 8 May 2008 15:07:54 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 May 2008 15:07:54 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de>
X-OriginalArrivalTime: 08 May 2008 20:07:54.0348 (UTC) FILETIME=[336AA2C0:01C8B147]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81556>

Guido Ostkamp wrote:
> On Thu, 8 May 2008, Jeff King wrote:
>> On Thu, May 08, 2008 at 07:45:31PM +0200, Guido Ostkamp wrote:
>>
>>> [gc]
>>>         reflogExpire = 0
>>>         reflogExpireUnreachable = 0
>>>         rerereresolved = 0
>>>         rerereunresolved = 0
>>>         packrefs = 1
>>
>> git-gc uses a "safe" pruning mode, where it only prunes unreferenced
>> objects that are older than a certain period (this makes it safe to run
>> git-gc, even if other processes are creating objects at the same time).
>>
>> So try
>>
>> [gc]
>>        pruneExpire = now
>>
>> Alternatively, you can just run 'git prune' manually instead of 'git
>> gc'.
> 
> Jeff, I tried it, but it has no effect (see below). There is only the
> master branch left, and only one commit therein, still it uses the space
> former occupied by the branch. I'm using git version 1.5.5.1.147.g867f.
> 
> Any further ideas?


Possibly that object got packed? git-prune only removes loose objects.
Try 'git gc --prune' which will call git-repack with the -a option.

btw, this is _really_ a non-issue. It seems to keep coming up on the list.

Just know that each one of the config options that you set to zero, including
the one Jeff suggested setting to "now", is a safety mechanism that is there
to ensure that you never ever lose data and that mistakes are recoverable.

And be assured that the objects referenced by a deleted branch will be removed
from the repository eventually as long as 'git gc --prune' is run periodically.

-brandon
