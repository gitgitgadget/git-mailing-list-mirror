From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: [PATCH 0/5] ignore SIGINT while editor runs
Date: Sun, 11 Nov 2012 13:27:03 -0500
Message-ID: <20121111182703.167E92E8B6A@grass.foxharp.boston.ma.us>
References: <20121109192336.GA9401@sigill.intra.peff.net> <87a9uq5tql.fsf@Niukka.kon.iki.fi> <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us> <871ug15k5c.fsf@Niukka.kon.iki.fi> <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us> <87wqxs4o6f.fsf@Niukka.kon.iki.fi> <20121111154846.GA13188@sigill.intra.peff.net> <20121111163100.GB13188@sigill.intra.peff.net> (sfid-20121111_113110_428099_D97EAB15)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Kalle Olavi Niemitalo <kon@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXcFc-0008KD-DZ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab2KKS1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:27:05 -0500
Received: from colo.foxharp.net ([166.84.7.52]:44617 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535Ab2KKS1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:27:04 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id D708E540E4;
	Sun, 11 Nov 2012 13:24:09 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 406)
	id 167E92E8B6A; Sun, 11 Nov 2012 13:27:03 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 135252E8008;
	Sun, 11 Nov 2012 13:27:03 -0500 (EST)
In-reply-to: <20121111163100.GB13188@sigill.intra.peff.net> (sfid-20121111_113110_428099_D97EAB15)
Content-ID: <25276.1352658422.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209436>

jeff wrote:
 > On Sun, Nov 11, 2012 at 10:48:46AM -0500, Jeff King wrote:
 > 
 > > Silly me. When I thought through the impact of Paul's patch, I knew that
 > > we would notice signal death of the editor. But I totally forgot to
 > > consider that the blocked signal is inherited by the child process. I
 > > think we just need to move the signal() call to after we've forked. Like
 > > this (on top of Paul's patch):
 > > [...]
 > > Note that this will give you a slightly verbose message from git.
 > > Potentially we could notice editor death due to SIGINT and suppress the
 > > message, under the assumption that the user hit ^C and does not need to
 > > be told.
 > 
 > Here's a series that I think should resolve the situation for everybody.

thanks!  i've tested -- this certainly scratches my initial itch.

ack,
paul

 > 
 >   [1/5]: launch_editor: refactor to use start/finish_command
 > 
 > The cleanup I sent out a few minutes ago.
 > 
 >   [2/5]: launch_editor: ignore SIGINT while the editor has control
 > 
 > Paul's patch rebased on my 1/5.
 > 
 >   [3/5]: run-command: drop silent_exec_failure arg from wait_or_whine
 >   [4/5]: run-command: do not warn about child death by SIGINT
 >   [5/5]: launch_editor: propagate SIGINT from editor to git
 > 
 > Act more like current git when the editor dies from SIGINT.
 > 
 > -Peff
 > --
 > To unsubscribe from this list: send the line "unsubscribe git" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html

=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 56.3 degrees)
