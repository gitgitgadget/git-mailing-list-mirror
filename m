From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-checkout sometimes silently fails
Date: Tue, 6 May 2008 23:50:49 +0200
Message-ID: <20080506215049.GC4647@steel.home>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 06 23:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtV4h-0005kl-3x
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 23:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbYEFVuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 17:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbYEFVuy
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 17:50:54 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:54373 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbYEFVux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 17:50:53 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMna1oX+2lO0Q==
Received: from tigra.home (Fa9c9.f.strato-dslnet.de [195.4.169.201])
	by post.webmailer.de (klopstock mo4) (RZmta 16.34)
	with ESMTP id h0367ek46JIEYI ; Tue, 6 May 2008 23:50:50 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 12398277BD;
	Tue,  6 May 2008 23:50:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E629C56D28; Tue,  6 May 2008 23:50:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080506122256.04ca7d77.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81381>

Andrew Morton, Tue, May 06, 2008 21:22:56 +0200:
> 
> I've had this happen before and I don't know what to do to make it stop. 
> Usually sufficient fiddling will prevent it from happening.
> 
> 
> y:/usr/src/git26> cat .git/branches/linux-next 
> git+ssh://master.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
> 
> y:/usr/src/git26> git-checkout master
> Switched to branch "master"
> y:/usr/src/git26> cat kernel/*.c|sum
> 34439  2057
> y:/usr/src/git26> git-checkout linux-next
> Switched to branch "linux-next"
> y:/usr/src/git26> cat kernel/*.c|sum     
> 34439  2057

This is not a good indication of a failed checkout (they could point
to the same commit, for one). Try "gitk master...linux-next" (or "git
log master..linux-next", "git diff master linux-next")

> y:/usr/src/git26> git-checkout origin 
> Note: moving to "origin" which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>   git checkout -b <new_branch_name>
> HEAD is now at 5717922... Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb

This is not an error. The commit was checked out (and HEAD was
"detached").

> y:/usr/src/git26> cat kernel/*.c|sum          
> 34439  2057

Again, it is no indication nothing happened. "gitk HEAD...linux-next"

> y:/usr/src/git26> git --version
> git version 1.5.5.rc1
> 
> help?

Look at "git branch -av" (it shows both local and remote branches and
commits they point to). Maybe it will give you a hint. "gitk --all" is
interesting too, seldom though (it becomes very confusing very fast if
you have many branches with complicated history each).
