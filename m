From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Mon, 26 Mar 2007 01:25:04 -0700
Message-ID: <7v648oza1r.fsf@assigned-by-dhcp.cox.net>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org>
	<20070321051406.GW96806@codelabs.ru>
	<Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321115004.GB14837@codelabs.ru>
	<Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321144008.GE14837@codelabs.ru>
	<Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070321160126.GH14837@codelabs.ru>
	<7v1wji371q.fsf@assigned-by-dhcp.cox.net>
	<20070326073143.GB44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:25:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVkVt-0002uV-CM
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727AbXCZIZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933736AbXCZIZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:25:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35818 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933727AbXCZIZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:25:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326082505.CWOV321.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 04:25:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fLR41W0041kojtg0000000; Mon, 26 Mar 2007 04:25:05 -0400
In-Reply-To: <20070326073143.GB44578@codelabs.ru> (Eygene Ryabinkin's message
	of "Mon, 26 Mar 2007 11:31:43 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43127>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

>> Maybe later you might even want to view the graphical history
>> from the server displaying on remote X, who knows?
>
> Not sure: I don't like X on the servers ;)) But others can...

Did you know that you can have only minimum X clients on your
server machine, and display on remote X terminals?  But that is
besides the point.

>> We have NO_CURL and such because lack of the necessary libraries
>> and headers prevent your build from completing, but in the case
>> of git-gui and gitk, they are just scripts and you would not
>> have any trouble in building.  I do not know if adding more
>> conditional to Makefile in order to skip them is worth it.
>
> OK, I reworked the patch following the suggestion of Jakub and Johannes:
> now configure has the built-in detection of the Tcl/Tk binary and has
> the --with-tcltk/--without-tcltk options.

That is exactly what I am quite against.  I often find other
people's packages silly when they disable tk support only
because the build procedure does not find tcl/tk installed on
the system it is built on, even when the tk component of the
package is pure wish script and does not have any C native stuff
(which requires libtcl development component on the build
system, which in turn justifies such disabling).

> And regarding the building troubles and the additional knob in the
> Makefile: the trouble is in the packaging process. For example, RPM
> or FreeBSD ports are looking at what is really installed, so if
> user do not want the Tcl/Tk part, then no package parts that depend
> on it should be installed.

I think the simple RPM spec file we ship with git.git takes care
of that nicely by splitting gitk into a separate package (As it
was Chris Wright's work, I cannot take credit for that part at
all). I would imagine both modern distro's packaging system and
people who actually maintain packages for distros are capable
enough to handle this situation just fine.  I still do not think
the "packaging difficulty" is not a strong enough reason.  

But I could be persuaded otherwise...
