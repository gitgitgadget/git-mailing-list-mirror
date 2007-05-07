From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Mon, 07 May 2007 01:05:05 -0700
Message-ID: <7vk5vl6oum.fsf@assigned-by-dhcp.cox.net>
References: <200705012346.14997.jnareb@gmail.com>
	<Pine.LNX.4.64.0705020143460.4010@racer.site>
	<8fe92b430705020433v7ae5c117qdefccc791cd07fff@mail.gmail.com>
	<alpine.LFD.0.98.0705042049330.3819@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, dev@tools.openoffice.org,
	Jan Holesovsky <kendy@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 07 10:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkyDb-0008F2-0m
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbXEGIFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbXEGIFI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:05:08 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46461 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbXEGIFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:05:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070507080505.PRKN1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 7 May 2007 04:05:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id w8551W00B1kojtg0000000; Mon, 07 May 2007 04:05:06 -0400
In-Reply-To: <alpine.LFD.0.98.0705042049330.3819@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 4 May 2007 20:56:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46429>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> A trivial patch is to just do
>
> 	git pack-refs --all --prune
>
> in the "git-clone.sh" script rather than force people to do it themselves, 
> but we really probably shouldn't have ever even unpacked them in the first 
> place. That is kind of stupid, but especially since that thing is written 
> in shell, it's hard to do anything smarter.

It is not just being in shell.

Although I do agree that the initial clone is special, I would
rather make clone just a thin wrapper to fetch that also happens
to perform necessary initial setup.

Keeping fetched and updated refs in core and write a packed refs
out in one go in git-fetch--tool (and later, git-fetch all in C)
would be much simpler if we do not have to worry about existing
refs (aka "git clone" special case); I am not sure if packing
refs is desirable in general for incremental "git-fetch".
