From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 14:35:35 -0800
Message-ID: <20060221223535.GC18085@hand.yhbt.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home> <Pine.LNX.4.63.0602212315400.12634@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Sam Vilain <sam@vilain.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:35:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBg6d-0000ne-9a
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWBUWfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBUWfg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:35:36 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35531 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964882AbWBUWfg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 17:35:36 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 89C8F2DC01A; Tue, 21 Feb 2006 14:35:35 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0602212315400.12634@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16566>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Tue, 21 Feb 2006, Alex Riesen wrote:
> 
> > Sam Vilain, Tue, Feb 21, 2006 21:36:50 +0100:
> > > >
> > > >>* Eric, thanks for the hint.  I have this four-patch series.
> > > >>  Could people with perl 5.6 please check them?
> > > >
> > > >
> > > >Does not work here (ActiveState Build 811, Perl 5.8.6):
> > > >
> > > >$ perl -e 'open(F, "-|")'
> > > >'-' is not recognized as an internal or external command,
> > > >operable program or batch file.
> > > 
> > > Portability, Ease of Coding, Few CPAN Module Dependencies.  Pick any two.
> > > 
> > 
> > Sometimes an upgrade is just out of question. Besides, that'd mean an
> > upgrade to another operating system, because very important scripts
> > over here a just not portable to anything else but
> >     "ActiveState Perl on Windows (TM)"
> > I just have no choice.
> 
> Maybe I am stating the obvious, but it seems that
> 
> 	open (F, "git-blabla -option |");
> 
> would be more portable.
> 
> Alex, would this work on ActiveState?
> 
> Perl gurus, is the latter way to open a pipe considered awful or what?

It's OK as long as all arguments are are shell-safe (quoted/escaped
properly).  Shouldn't be a problem with constant strings at all.

> P.S.: Eric, we rely on fork() anyway. Most of git's programs just don't 
> work without a fork().

Yes, apparently there's some fork() emulation in some *doze places and
not others.

-- 
Eric Wong
