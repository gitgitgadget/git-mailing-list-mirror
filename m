From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 31 May 2007 20:57:50 -0700
Message-ID: <7vvee8z5q9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705301333410.4011@racer.site>
	<20070531002030.GA15714@spearce.org>
	<7vk5uo1rpr.fsf@assigned-by-dhcp.cox.net>
	<20070601030959.GY7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 05:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtyGz-0005gl-ME
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 05:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbXFAD5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 23:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbXFAD5w
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 23:57:52 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45043 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbXFAD5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 23:57:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601035750.VMBF5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 31 May 2007 23:57:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 63xq1X00R1kojtg0000000; Thu, 31 May 2007 23:57:51 -0400
In-Reply-To: <20070601030959.GY7044@spearce.org> (Shawn O. Pearce's message of
	"Thu, 31 May 2007 23:09:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48842>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Why cat?  Tcl is so horribly broken that to get data for both stdout
> and stderr through a pipe I have to do something sick like:
>
> 	git fetch 2>&1 | cat
>
> because in Tcl its actually:
>
> 	set rdr [open "| git fetch |& cat" r]
>
> The |& means 2>&1| in normal shell.  But that means I have to have
> a process after it to receive the data.  Normally that's cat.
> But MinGW doesn't have cat.  (Nor do they have dog, but neither
> does Linux...).  So I need a way to redirect output.

Wait a minute.  Who interprets |& in the above?  Isn't it a
shell?

That's why I asked if you are writing for shell-less
environment.  If you are _not_, can't you do something like this
instead?

	set rdr [open "| sh -c 'git fetch 2>&1'" r]

that is, instead of running a command called "git", you invoke a
command called "sh" with two parameters, the second parameter
being a tad long string that happens to have three letter
sequence '2>&1' in it.
