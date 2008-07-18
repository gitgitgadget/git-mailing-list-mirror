From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Teach git submodule update to use distributed
	repositories
Date: Fri, 18 Jul 2008 12:00:48 +0200
Message-ID: <20080718100048.GN10151@machine.or.cz>
References: <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com> <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com> <alpine.DEB.1.00.0807171351380.8986@racer> <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com> <alpine.DEB.1.00.0807171513560.8986@racer> <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com> <20080717182253.GZ32184@machine.or.cz> <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com> <20080718091608.GL10151@machine.or.cz> <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 12:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJmmb-00057K-9j
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 12:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbYGRKAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 06:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbYGRKAu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 06:00:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56274 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbYGRKAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 06:00:50 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A2D3C2C4C02A; Fri, 18 Jul 2008 12:00:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89025>

On Fri, Jul 18, 2008 at 10:36:51AM +0100, Nigel Magnay wrote:
> On Fri, Jul 18, 2008 at 10:16 AM, Petr Baudis <pasky@suse.cz> wrote:
> > snip
> >
> >        "How do we mass-supply custom submodule URLs when publishing the
> >        customized main repository at a custom location too?"
> >
> Yes - that is an additional problem.

Wait, I'm lost again - _additional_ problem? How does it differ from the
_original_ problem, how does it differ from what you're explaining below
and how does what you're explaining below differ from the original
problem?

Or are we talking exclusively about what I summed up above now?

> If I may expand the usecase just so it's clear (and to check we're
> talkiing the same language)
> 
> I do something like
> $ git remote add fred git://fredcomputer/superproject/.git
> $ git fetch --submodules fred

I think you mean git pull --submodules fred. Well, actually, you want to
pull the main repository, then submodule update (_not_ pull in the
submodules). See? This is part of the "semantic swamp" I mentioned
before.

I think it should be somehow part of the _main_ project's fred branch
that in this branch, the subprojects should be fetched from a different
location; thus, you would still do

	$ git remote add fred git://fredcomputer/superproject/.git
	$ git pull fred
	$ git submodule update

where either the submodule update takes the info from fred's adjusted
.gitmodules, or it is an implicit part of the branch as in fred tells
you to run the update command with some extra arguments.

However, I still believe the information should primarily stem from the
main repository; consider e.g. if you do not have some of the submodules
checked out when you switch to fred, then figure out that in fred's
branch, you really do want them checked out.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
