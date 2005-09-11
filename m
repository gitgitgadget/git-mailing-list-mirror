From: Junio C Hamano <junkio@cox.net>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 10:34:13 -0700
Message-ID: <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net>
References: <deofnh$jl0$1@sea.gmane.org>
	<7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 19:35:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEVih-0005J0-3J
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 19:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVIKReT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 13:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVIKReT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 13:34:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62185 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964974AbVIKReT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 13:34:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911173415.NKKE24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 13:34:15 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 11 Sep 2005 12:07:58 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8302>

Patrick and Jason CC:'ed because they also have portability
issues and seem to have good ideas about how they should be
solved.  Linus CC:'ed because he once expressed rather strongly
his dislike about autoconf.

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I have three fixes in my personal tree without which git refuses to 
> compile:
>
> - daemon.c needs a define or typedef for socklen_t.

I still keep that patch around (the patch was end of July), but
have not touched it only because I did not hear from you asking
about its inclusion.

> - mailinfo.c needs to have a simple strcasestr implementation, because 
>   10.2.8 (at least in my setup) is lacking it!

Yes, I've used it knowing that it is marked as a GNU extension,
hoping if somebody else can supply a patch to work it around ;-).

I am slightly reluctant to do autoconf [*1*], but I might be
tempted to take patches if it is done cleanly.

As a workaround until I am convinced otherwise and we go fully
autoconf, I am inclined to introduce a new subdirectory in the
source tree, compat/, which would house compat/linux.h,
compat/darwin.h, compat/solaris.h and friends, and have compat.h
symlink which points at one of those files.

[Footnote]
*1* ...although I admit that I once used to be an autoconf freak
and even had a few lines of my own code in the official autoconf
distribution.  It was an ancient history, most likely before
libtool and automake came along.  The last time I checked my
changes were all superseded.
