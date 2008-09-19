From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to remove a commit object?
Date: Fri, 19 Sep 2008 11:16:36 +0200
Message-ID: <48D36DF4.3030607@drmicha.warpmail.net>
References: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Users List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 11:17:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgc7i-0002FA-9T
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 11:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbYISJQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 05:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbYISJQs
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 05:16:48 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49840 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161AbYISJQr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 05:16:47 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 81691165AD2;
	Fri, 19 Sep 2008 05:16:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 19 Sep 2008 05:16:46 -0400
X-Sasl-enc: T1kBva5RIrPOKxD2oVOvsWCbJkRUyJ3CtwNdCP+KNUeD 1221815806
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0ED612A715;
	Fri, 19 Sep 2008 05:16:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96269>

Steven Grimm venit, vidit, dixit 19.09.2008 01:41:
> I maintain a shared repository a bunch of my coworkers push to for  
> code reviews. It has accumulated a lot of packfiles, so I want to  
> shrink it down a bit, but there's a problem:
> 
> % git repack -A -d
> Counting objects: ...
> error: Could not read 125bf191b65189aaec7a6aa24ff26460d141d587
> fatal: bad tree object 125bf191b65189aaec7a6aa24ff26460d141d587
> 
> "git fsck" confirms that the tree object is missing:
> 
> % git fsck
> broken link from  commit 1b2f0595bb4a6c2e17ca43a9cc41feec88c72a47
>                to    tree 125bf191b65189aaec7a6aa24ff26460d141d587
> ...
> missing tree 125bf191b65189aaec7a6aa24ff26460d141d587
> 
> This is a dangling commit, but that's fine; for this particular  
> repository we actually *want* lots of dangling commits since they  
> represent the history of people's code review requests. (Hence me  
> running git-repack with -A instead of -a.)
> 
> Given that it's dangling, it seems like it'd be safe to just remove  
> entirely (we lose that little bit of code-review history but we've  
> lost it already anyway with the tree object missing). But I'm not sure  
> how to do it. Is it possible to delete a commit object, and if so, how?
> 
> I don't know how the corruption happened in the first place. There was  
> a short time at one point where the permissions on the object  
> directories were inconsistent, so it's possible someone pushed during  
> that period and managed to create the commit object file in .git/ 
> objects but didn't have permission to create the tree object. That's  
> just speculation on my part, though. This is the only corrupt object  
> in the repository according to git-fsck, so at this point I just want  
> to know how to get rid of it so I can do the repack.

git prune should delete dangling commits. Is that commit already in a
pack? Then the -f option to repack may help.

Michael
