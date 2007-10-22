From: Federico Mena Quintero <federico@novell.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summarycontinued
Date: Mon, 22 Oct 2007 10:24:20 -0500
Message-ID: <1193066660.4522.166.camel@cacharro.xalalinux.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org> <4719B655.90204@op5.se>
	 <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.07102 10031130.25221@racer.site> <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 17:22:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijz6t-0007dD-Oe
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 17:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbXJVPWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 11:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbXJVPWP
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 11:22:15 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:40890 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbXJVPWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 11:22:13 -0400
Received: from [164.99.195.83] ([164.99.195.83])
	by jericho.provo.novell.com with ESMTP; Mon, 22 Oct 2007 09:22:07 -0600
In-Reply-To: <Pine.LNX.4.64.0710221156540.25221@racer.site>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62021>

On Mon, 2007-10-22 at 12:04 +0100, Johannes Schindelin wrote:

> <rationale>There is a good chance that git is not optimised for most 
> people's daily workflows, as project maintainers seemed to be much more 
> forthcoming with patches, and therefore maintainers' tasks are much more 
> optimised than in other SCMs.</rationale>

The following are workflows that would be very useful for my cow-orkers
and project peers.

End-user workflows:

* Clone from another SCM (mostly svn).  Make a local branch to implement
something in various commits.  Rebase to the "latest upstream sources"
when you are done, and then do the equivalent to "svn dcommit" to upload
your final changes to the other SCM.  The use case for this is to fix a
complicated bug in GNOME, which uses SVN.

* While you are doing that, produce a patchset that you can send to the
maintainers for review.  I love "git-format-patch -n --thread --stdout >
foo", but it's pretty painful to have to 1. look up git-format-patch's
options in the man page (if you use --stdout, shouldn't -n and --thread
be turned on by default?); 2. import "foo" into Evolution to then be
able to edit the zeroth mail, and then be able to use Evo's SMTP
configuration to send out the mails while preserving the threading.

* Clone a git repository which has several interesting branches.  Figure
out which branch you are interested in.  Create a local branch based on
that; do your changes there.  Keep your code up to date (rebase?  when
to fetch / pull / etc?).

* You have a personal branch with a bunch of commits:  a mess of "real
work", "remove debugging printf", "fix typo", etc.  Reformat / reorder
those patches into something suitable for submission.  [I just found out
about git rebase --interactive and it's *FANTASTIC* for this!]

Maintainer workflows:

* Start a personal project in git and publish it for others to clone.
Assume several possible setups:  dumb web server with no git installed,
git installed but no git-daemon, git installed with git-daemon running.
I've found that publishing is not trivial at all; it's a rather
cumbersome multi-step process.

* Several of your contributors publish their own git repositories.
Integrate changes from them, or review them.  This interesting because
you'll have to do a lot of navigation in repos with which you aren't
familiar, you'll have to use the merging and conflict resolution tools,
you'll have to maintain the signoffs, etc.

* Set up a public repository to which other people can push.

* Publish just some of your branches.  Do that often, say, because you
have new work to show in each of those branches.

  Federico
