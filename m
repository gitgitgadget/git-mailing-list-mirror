From: Junio C Hamano <junkio@cox.net>
Subject: Re: Makefile checks for DarwinPorts / Fink
Date: Sat, 22 Jul 2006 07:43:01 -0700
Message-ID: <7vhd19itu2.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0607210758m4410cddfw16329ce473404fd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, merlyn@stonehenge.com
X-From: git-owner@vger.kernel.org Sat Jul 22 16:43:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4IhH-0004mY-7U
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 16:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWGVOnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Jul 2006 10:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWGVOnE
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 10:43:04 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24790 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750791AbWGVOnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jul 2006 10:43:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060722144303.VTOX27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Jul 2006 10:43:03 -0400
To: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
In-Reply-To: <f3d7535d0607210758m4410cddfw16329ce473404fd8@mail.gmail.com>
	(Stefan Pfetzing's message of "Fri, 21 Jul 2006 16:58:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24072>

"Stefan Pfetzing" <stefan.pfetzing@gmail.com> writes:

> while I was updating the DarwinPorts Portfile for git, I saw some
> really suspicious lines in the Makefile of Git for DarwinPorts/Fink.
>
> --- snip ---
>        ## fink
>        ifeq ($(shell test -d /sw/lib && echo y),y)
>                ALL_CFLAGS += -I/sw/include
>                ALL_LDFLAGS += -L/sw/lib
>        endif
>        ## darwinports
>        ifeq ($(shell test -d /opt/local/lib && echo y),y)
>                ALL_CFLAGS += -I/opt/local/include
>                ALL_LDFLAGS += -L/opt/local/lib
>        endif
> --- snap ---
>
> IMHO, Git should definetely not include /sw/include and /sw/lib, just
> if it *exists*.

Could you make a concrete suggestion (I am not on Darwin)?  

If I am reading you correctly, your suggestion is that
DarwinPorts and/or Fink build procedure, which drive our
Makefile from outside, should set up CFLAGS and LDFLAGS to have
the correct paths for local libraries and headers.  It is not
clear to me if having these defaults there makes it hard (or
cumbersome) to override them in such a setup and you are
proposing to remove them (or commenting them out), or if you can
live with them being there.

These were made as "quick relatively sane defaults for help
people with simple configuration when people build git
themselves" initially and it may be the case that they now could
use improvements.  I dunno (I am not on Darwin).

But I suspect that the "official" portfile (or whatever it is
called in the Darwin world) should be able to override whatever
is done in there --- otherwise we would need to remove them or
comment them out, but I am hoping it does not have to come to
that; I think they serve as good hint to help people who are
building from the source.
