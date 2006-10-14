From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn and u-boot broken.
Date: Sat, 14 Oct 2006 11:51:55 +0200
Message-ID: <00f301c6ef76$62172060$1267a8c0@Jocke>
References: <20061014062812.GC29149@localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Randal L. Schwartz'" <merlyn@stonehenge.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 14 11:54:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYgDt-00062J-TP
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 11:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWJNJyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 05:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWJNJyF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 05:54:05 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:1494
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1161100AbWJNJyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 05:54:03 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 14 Oct 2006 11:54:00 +0200
To: "'Eric Wong'" <normalperson@yhbt.net>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbvWfivBqbYme0pTJKSKDrjbad7VwAGQIJA
In-Reply-To: <20061014062812.GC29149@localdomain>
X-OriginalArrivalTime: 14 Oct 2006 09:54:00.0870 (UTC) FILETIME=[ACAAEC60:01C6EF76]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28871>

 

> -----Original Message-----
> From: Eric Wong [mailto:normalperson@yhbt.net] 
> Sent: den 14 oktober 2006 08:28
> To: Joakim Tjernlund
> Cc: 'Randal L. Schwartz'; git@vger.kernel.org
> Subject: Re: git-svn and u-boot broken.
> 
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >  
> > 
> > > -----Original Message-----
> > > From: Randal L. Schwartz [mailto:merlyn@stonehenge.com] 
> > > Sent: den 13 oktober 2006 21:40
> > > To: Joakim Tjernlund
> > > Cc: git@vger.kernel.org
> > > Subject: Re: git-svn and u-boot broken.
> > > 
> > > >>>>> "Joakim" == Joakim Tjernlund 
> > > <joakim.tjernlund@transmode.se> writes:
> > > 
> > > Joakim> First, I had to change this (from memory) in git-svn:
> > > Joakim>   my $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > > $self->{pool});
> > > Joakim> to
> > > Joakim>   my $got;
> > > Joakim>   if ( $got ) {
> > > Joakim>     $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > > $self->{pool});
> > > Joakim>   } else {
> > > Joakim>     $got = $exp
> > > Joakim>   }
> > > Joakim> I am no perl programmer so please change as you se fit.
> 
> With your correction following merlyn's comments, it could 
> work[1].  I'm
> curious as to what change git-svn printed right before 
> hitting an error

from memory:
Usage: svn_txdelta_send_stream(x,y,z,m)

> here, and would like to see the files (before and after) that were
> printed by git-svn.

Sorry, don't have that hande ATM

> 
> I'm not sure what change would show up in git but cause 
> apply_textdelta
> to return undef...
> 
> [1] - I am tempted to apply a change based on yours, but this 
> could just
> be working around another bug somewhere else (either in git-svn or
> subversion).
> 
> > > That doesn't make any sense.  You'll never run the if-true 
> > > branch there.
> > > The value of $got immediately following "my $got;" is 
> always undef.
> > 
> > git-pull --squash seems to do what I want but know I get this when
> > committing to svn: 
> > git-svn commit remotes/git-svn..svn-branch
> > ...
> >         A       cpu/mpc824x/drivers/i2c_export.h
> >         A       cpu/mpc824x/drivers/i2o.h
> >         A       cpu/mpc824x/drivers/i2o/Makefile
> >         A       cpu/mpc824x/drivers/i2o/Makefile_pc
> > Cannot allocate memory at /usr/bin/git-svn line 1462
> > 3072 at /usr/bin/git-svn line 547
> >         
> main::commit_lib('2ff9bcb7908d2752f643695ab3a28f9ababfafab') 
> called at /usr/bin/git-svn line 457
> >         main::commit('remotes/git-svn..svn-branch') called 
> at /usr/bin/git-svn line 149
> 
> How large is the changeset you're committing?
> (git show --stat 2ff9bcb7908d2752f643695ab3a28f9ababfafab)

That gives me a huge listing that ends in:
 4306 files changed, 1194819 insertions(+), 0 deletions(-)

got some entries that look like this:
 board/MAI/bios_emulator/scitech/makedefs/qnxnto.mk |  157
 .../bios_emulator/scitech/makedefs/rules/bc16.mk   |   69
 .../bios_emulator/scitech/makedefs/rules/bc3.mk 

whats the ... for?
> 
> I actually have a fair amount of fork() hacks in git-svn to workaround
> leaks in the SVN:: libraries (hard to avoid otherwise in Perl).
> I haven't noticed (or looked for) file-descriptor leakage very heard,
> though.
> 
> Also, which version of git-svn are you running?  Also, which 
> version of
> Subversion (client library, and server (if possible) are you running?

git 1.4.2.3
subversion 1.3.2-r1

I will try upgrading to newer subverison.

distribution: Gentoo
