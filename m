From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: [PATCH 0/3] Somebody updated my branch tip underneath me.
Date: Thu, 29 Mar 2007 11:55:36 +0000 (UTC)
Message-ID: <loom.20070329T133700-713@post.gmane.org>
References: <7vslbo4fwx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 13:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWtEY-0006IG-7x
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 13:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbXC2Lz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 07:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbXC2Lz7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 07:55:59 -0400
Received: from main.gmane.org ([80.91.229.2]:43448 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbXC2Lz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 07:55:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HWtEJ-0003uA-Ng
	for git@vger.kernel.org; Thu, 29 Mar 2007 13:55:48 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 13:55:47 +0200
Received: from scallegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 13:55:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20060601 Firefox/2.0.0.3 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43429>

Junio C Hamano <junkio <at> cox.net> writes:

> 
> With this series, I am taking hints from Linus and trying to
> illustrate a problem, show an approach to its solution and code
> minimally to get others interested enough to follow through.
> 
> [PATCH 1/3] Add BASE index extension.
> [PATCH 2/3] update-index --{set,get}-base
> [PATCH 3/3] Use BASE index extension in git-commit and git-merge.
> 
> The problem description and the strategy to solve it are in the
> commit log message of [PATCH 3/3].  There I only talk about
> git-push from elsewhere while we are looking the other way, but
> the same situation can also happen when you use a lightweight
> shared working tree (i.e. Julian phillips's git-new-workdir) and
> make a commit on a branch in one working tree while the other
> working tree has a checkout of the same branch.
> 
> Let's see who are motivated enough to bite.
> 
> 

This seems very nice, not just because of under-the-hood pushes, but also wrt
the contrib/workdir thing: good to solve two slightly different problems in a
single consistent way.

Just a minor question:

From, your comments to patch 3/3 it looks like when a "commit" or "status" (or
whatever command) catches the mismatch in the head from the index-commit, it
only exits with a notice.  And you also mention that recovery then happens via
head detaching (that in your example is done manually)...

If (as I am guessing) head detaching is the /only/ possible path to recovery,
wouldn't it make sense to do it automatically, storing somewhere the latest
branch one was on (e.g. to be used for subsequent merge)?

Also, in general: whenever head gets detached (e.g. by a checkout) would it make
sense to "by default" store somewhere the previous branch name? (e.g. to gain a
shorthand command to get back to the former branch)?

Thanks,

Sergio
