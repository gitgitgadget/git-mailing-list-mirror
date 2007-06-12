From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn set-tree bug
Date: Tue, 12 Jun 2007 00:34:24 -0700
Message-ID: <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com>
References: <466C8B35.3020207@midwinter.com>
	<003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
	<7vir9vox5l.fsf@assigned-by-dhcp.cox.net>
	<20070612072035.GA29385@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 09:34:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy0tc-0000t2-8D
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 09:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbXFLHe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 03:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXFLHe0
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 03:34:26 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56180 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbXFLHeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 03:34:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612073425.YWOY6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 03:34:25 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AXaQ1X0021kojtg0000000; Tue, 12 Jun 2007 03:34:24 -0400
In-Reply-To: <20070612072035.GA29385@muzzle> (Eric Wong's message of "Tue, 12
	Jun 2007 00:20:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49932>

Eric Wong <normalperson@yhbt.net> writes:

> If dcommit detects a merge commit when doing rev-list When looking at
> commit objects, is it safe to assume that the first parent is always the
> "mainline" and that parents after it are the ones to merge from?
>
> So if I saw:
>
> commit $X
> parent $A
> parent $B
>
> I'd basically do:
>   reset --hard $A
>   merge --squash $B
>
> And resulting in $C which would have the same tree as $X,
> then, when dcommit-ting, $D would be created with two parents:
>   $D~1 (svn), $B (git), but not $A

I am not sure what you mean by "mainline", but I assume that you
mean "SVN is the main and we are tracking it while taking
advantage of more efficient and merge-capable git in guerrilla
fashion".  Because the tip of the current branch is what the
user is pushing back to SVN via dcommit, I would say it is safe
to assume that the first parent of such a merge is the line that
corresponds to the SVN branch you are keeping track.
