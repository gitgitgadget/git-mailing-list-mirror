From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and u-boot broken.
Date: Sat, 14 Oct 2006 15:46:36 -0700
Message-ID: <20061014224636.GA12565@soma>
References: <00f701c6ef92$88b84840$1267a8c0@Jocke> <00f301c6ef76$62172060$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 00:46:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYsHN-0004Yh-Co
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 00:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbWJNWqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 18:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbWJNWqj
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 18:46:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50582 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752225AbWJNWqj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 18:46:39 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 625217DC08D;
	Sat, 14 Oct 2006 15:46:37 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 14 Oct 2006 15:46:36 -0700
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Disposition: inline
In-Reply-To: <00f301c6ef76$62172060$1267a8c0@Jocke>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28891>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> 
> > -----Original Message-----
> > From: Eric Wong [mailto:normalperson@yhbt.net] 
> > Sent: den 14 oktober 2006 08:28
> > To: Joakim Tjernlund
> > Cc: 'Randal L. Schwartz'; git@vger.kernel.org
> > Subject: Re: git-svn and u-boot broken.
> > 
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > >  
> > > 
> > > > -----Original Message-----
> > > > From: Randal L. Schwartz [mailto:merlyn@stonehenge.com] 
> > > > Sent: den 13 oktober 2006 21:40
> > > > To: Joakim Tjernlund
> > > > Cc: git@vger.kernel.org
> > > > Subject: Re: git-svn and u-boot broken.
> > > > 
> > > > >>>>> "Joakim" == Joakim Tjernlund 
> > > > <joakim.tjernlund@transmode.se> writes:
> > > > 
> > > > Joakim> First, I had to change this (from memory) in git-svn:
> > > > Joakim>   my $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > > > $self->{pool});
> > > > Joakim> to
> > > > Joakim>   my $got;
> > > > Joakim>   if ( $got ) {
> > > > Joakim>     $got = SVN::TxDelta::send_stream($fh, @$atd, 
> > > > $self->{pool});
> > > > Joakim>   } else {
> > > > Joakim>     $got = $exp
> > > > Joakim>   }
> > > > Joakim> I am no perl programmer so please change as you se fit.
> > 
> > With your correction following merlyn's comments, it could 
> > work[1].  I'm
> > curious as to what change git-svn printed right before 
> > hitting an error
> 
> from memory:
> Usage: svn_txdelta_send_stream(x,y,z,m)
 
> > here, and would like to see the files (before and after) that were
> > printed by git-svn.
> 
> Sorry, don't have that hande ATM

Could you publish your git repository for u-boot and also the
exact commands (if you have them) you used to attempt the import
into SVN?  Thanks.

> > I'm not sure what change would show up in git but cause 
> > apply_textdelta
> > to return undef...
> > 
> > [1] - I am tempted to apply a change based on yours, but this 
> > could just
> > be working around another bug somewhere else (either in git-svn or
> > subversion).
> > 
> > > > That doesn't make any sense.  You'll never run the if-true 
> > > > branch there.
> > > > The value of $got immediately following "my $got;" is 
> > always undef.
> > > 
> > > git-pull --squash seems to do what I want but know I get this when
> > > committing to svn: 
> > > git-svn commit remotes/git-svn..svn-branch
> > > ...
> > >         A       cpu/mpc824x/drivers/i2c_export.h
> > >         A       cpu/mpc824x/drivers/i2o.h
> > >         A       cpu/mpc824x/drivers/i2o/Makefile
> > >         A       cpu/mpc824x/drivers/i2o/Makefile_pc
> > > Cannot allocate memory at /usr/bin/git-svn line 1462
> > > 3072 at /usr/bin/git-svn line 547
> > >         
> > main::commit_lib('2ff9bcb7908d2752f643695ab3a28f9ababfafab') 
> > called at /usr/bin/git-svn line 457
> > >         main::commit('remotes/git-svn..svn-branch') called 
> > at /usr/bin/git-svn line 149
> > 
> > How large is the changeset you're committing?
> > (git show --stat 2ff9bcb7908d2752f643695ab3a28f9ababfafab)
> 
> That gives me a huge listing that ends in:
>  4306 files changed, 1194819 insertions(+), 0 deletions(-)

Yikes, that's a huge commit.  git-svn memory usage was bounded
for the size of each changeset, so yes, this could get nasty.
Patch coming in a reply to this message.

> got some entries that look like this:
>  board/MAI/bios_emulator/scitech/makedefs/qnxnto.mk |  157
>  .../bios_emulator/scitech/makedefs/rules/bc16.mk   |   69
>  .../bios_emulator/scitech/makedefs/rules/bc3.mk 
> 
> whats the ... for?

Long filename that couldn't fit on the (80 char width?) diffstat prints
out.

-- 
Eric Wong
