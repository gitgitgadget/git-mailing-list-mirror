From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 19:57:42 +0100
Message-ID: <20050417195742.D13233@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEuT-00084x-Bp
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVDQS6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVDQS6K
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:58:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41482 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261413AbVDQS5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 14:57:46 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNExj-0008Ml-HG; Sun, 17 Apr 2005 19:57:44 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNExi-0006Aa-AM; Sun, 17 Apr 2005 19:57:42 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Apr 17, 2005 at 09:36:09AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 09:36:09AM -0700, Linus Torvalds wrote:
> On Sun, 17 Apr 2005, Russell King wrote:
> > On Sat, Apr 16, 2005 at 04:01:45PM -0700, Linus Torvalds wrote:
> > > So I re-created the dang thing (hey, it takes just a few minutes), and
> > > pushed it out, and there's now an archive on kernel.org in my public
> > > "personal" directory called "linux-2.6.git". I'll continue the tradition
> > > of naming git-archive directories as "*.git", since that really ends up
> > > being the ".git" directory for the checked-out thing.
> > 
> > We need to work out how we're going to manage to get our git changes to
> > you.  At the moment, I've very little idea how to do that.  Ideas?
> 
> To me, merging is my highest priority. I suspect that once I have a tree 
> from you (or anybody else) that I actually _test_ merging with, I'll be 
> motivated as hell to make sure that my plumbing actually works. 

Ok, I'll throw this tree onto master.kernel.org - how about
master.kernel.org:/home/rmk/linux-2.6-rmk.git ?  I think it's in the
same format as your trees:

linux-2.6-rmk.git
|-- HEAD
`-- objects

where HEAD was copied from my .git/heads/master, and objects from
.git/objects.

> > However, I've made a start to generate the necessary emails.  How about
> > this format?
> > 
> > I'm not keen on the tree, parent, author and committer objects appearing
> > in this - they appear to clutter it up.  What're your thoughts?
> 
> Indeed. I'd almost drop the whole header except for the "author" line. 

Done.

> Oh, and you need a separator between commits, right now your 
> "Signed-off-by:" line ends up butting up with the header of the next 
> commit ;)

Done.

> > I'd rather not have the FQDN of the machine where the commit happened
> > appearing in the logs.
> 
> That's fine. Out short-logs have always tried to have just the real name 
> in them, and I do want an email-like thing for tracking the developer, but 
> yes, if you remove the email, that's fine. It should be easy enough to do 
> with a simple
> 
> 	sed 's/<.*>//'
> 
> or similar.

Done.

> And if you replace "author" with "From:" and do the date conversion, it
> might look more natural.

Also done. 8)

I still need to work out how to make my noddy script follow different
branches which may be present though.  However, for my common work
flow, it fits what I require.

Ok, how about this format:

Linus,

Please incorporate the latest ARM changes.

This will update the following files:

 arch/arm/kernel/process.c                  |   15 +++++++++++----
 arch/arm/kernel/traps.c                    |    8 ++------
 arch/arm/lib/changebit.S                   |   11 ++---------
 arch/arm/lib/clearbit.S                    |   13 ++-----------
 arch/arm/lib/setbit.S                      |   11 ++---------
 arch/arm/lib/testchangebit.S               |   15 ++-------------
 arch/arm/lib/testclearbit.S                |   15 ++-------------
 arch/arm/lib/testsetbit.S                  |   15 ++-------------
 arch/arm/mach-footbridge/dc21285-timer.c   |    4 ++--
 arch/arm/mach-sa1100/h3600.c               |    2 +-
 include/asm-arm/arch-ebsa285/debug-macro.S |    7 +++++--
 include/asm-arm/arch-rpc/debug-macro.S     |    5 ++++-
 include/asm-arm/ptrace.h                   |    5 +----
 include/asm-arm/system.h                   |    3 +++
 14 files changed, 41 insertions(+), 88 deletions(-)

through these ChangeSets:

Author: Russell King: Sun Apr 17 16:28:31 BST 2005

	[PATCH] ARM: fix debug macros
	
	Fix debug EBSA285 and RiscPC debugging macros to detect whether the
	MMU is enabled.
	
	Signed-off-by: Russell King

Author: Russell King: Sun Apr 17 15:51:02 BST 2005

	[PATCH] ARM: bitops
	
	Convert ARM bitop assembly to a macro.  All bitops follow the same
	format, so it's silly duplicating the code when only one or two
	instructions are different.
	
	Signed-off-by: Russell King

Author: Russell King: Sun Apr 17 15:50:36 BST 2005

	[PATCH] ARM: showregs
	
	Fix show_regs() to provide a backtrace.  Provide a new __show_regs()
	function which implements the common subset of show_regs() and die().
	Add prototypes to asm-arm/system.h
	
	Signed-off-by: Russell King

Author: Russell King: Sun Apr 17 15:40:46 BST 2005

	[PATCH] ARM: h3600_irda_set_speed arguments
	
	h3600_irda_set_speed() had the wrong type for the "speed" argument.
	Fix this.
	
	Signed-off-by: Russell King

Author: Russell King: Sun Apr 17 15:36:55 BST 2005

	[PATCH] ARM: footbridge rtc init
	
	The footbridge ISA RTC was being initialised before we had setup the
	kernel timer.  This caused a divide by zero error when the current
	time of day is set.  Resolve this by initialising the RTC after
	the kernel timer has been initialised.
	
	Signed-off-by: Russell King



-- 
Russell King

