From: Junio C Hamano <gitster@pobox.com>
Subject: Re: If NEEDS_LIBICONV is set for Solaris 8, it does not build git for me
Date: Sun, 22 Jul 2007 15:59:11 -0700
Message-ID: <7v8x98qc3k.fsf@assigned-by-dhcp.cox.net>
References: <20070722104045.GF4760@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>, Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Paul Jakma <paul@clubi.ie>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICkOU-00016G-2K
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762238AbXGVW7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762051AbXGVW7P
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:59:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64365 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760280AbXGVW7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:59:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722225914.JVDY1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 18:59:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SmzC1X0091kojtg0000000; Sun, 22 Jul 2007 18:59:13 -0400
In-Reply-To: <20070722104045.GF4760@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Sun, 22 Jul 2007 12:40:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53361>

Thomas Glanzmann <thomas@glanzmann.de> writes:

>      [ Paul and Jason CCed because they touched that section last ]
>
> Patch is appended at the very bottom of the E-Mail. I have a fully
> patched Solaris 8 with Forte 11. In order to get git compile I had to
> delete the
>
> 	NEEDS_LIBICONV = YesPlease
>
> line from the Makefile in the Solaris 8 section.

In a distant past when I built git on an otherwise unused Sol8
at work I recall I needed that.  I do not think that machine
used Forte compiler, though.

Regarding 5.8 vs 5.9 (dis)similarity, I suspect that other three
are there in the version specific section only because people
who needed them had access to only that version, and everybody
played safe.  I would be for example very surprised if NO_SETENV
were unneeded on Solaris 5.7, given that both 5.8 and 5.9 need
it (if it is unneeded on 5.7 that would mean Sun dropped setenv
when they went to 5.8).

We currently handle only three cases for Solaris in the
Makefile, meaning that we consider that Solaris world is
fragmented in three factions: just "SunOS", 5.8 or 5.9.

I suspect that a blanket statement "Solaris 8 needs (or does not
need) NEEDS_LIBICONV" would not hold true.  It probably depends
on many other things (perhaps OS patchlevel, extra packages, C
compiler suite).  The best course of action is for interested
Solaris users to get together, list combinations of possible
variations that are available to them and they care about, and
see which make variable is needed where, and refine the current
"three-faction fragmentation", which apparently does not reflect
reality.

Unfortunately I am not in a position to best judge how Solaris
world is fragmented.
