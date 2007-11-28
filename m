From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 14:26:05 +0100
Message-ID: <20071128132605.GB15953@diana.vm.bytemark.co.uk>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <20071128101718.GA13940@diana.vm.bytemark.co.uk> <474D5482.5020609@op5.se> <20071128121905.GA15953@diana.vm.bytemark.co.uk> <474D69A7.6020404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMw2-0005D1-47
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 14:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbXK1N0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 08:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbXK1N0N
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 08:26:13 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1142 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbXK1N0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 08:26:12 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxMvW-0004RG-00; Wed, 28 Nov 2007 13:26:06 +0000
Content-Disposition: inline
In-Reply-To: <474D69A7.6020404@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66329>

On 2007-11-28 14:14:15 +0100, Andreas Ericsson wrote:

> Karl Hasselstr=F6m wrote:
>
> > On 2007-11-28 12:44:02 +0100, Andreas Ericsson wrote:
> >
> > > Karl Hasselstr=F6m wrote:
> > >
> > > > Also, if StGit is to set up hooks automatically (commit hooks,
> > > > pre-rebase hooks, whatever), it'd be nice to not have to worry
> > > > about overwriting any existing hooks the user might have. But
> > > > git currently allows only one hook script per hook, right?
> > >
> > > Yes, but you can obviously call any number of scripts and
> > > programs from within the hook that git executes.
> >
> > That doesn't help here, however, since the user and not StGit
> > "owns" the "top-level" hook. StGit would have to rely on the user
> > having installed a specific kind of multiplexer as a hook script
> > (e.g. one that executes everything under .git/hooks/$hook.d/). Or
> > it would have to install it itself, and hope that moving any
> > existing hook to the subdirectory where the multiplexer looks for
> > hooks doesn't break anything. Both solutions are problematic.
>
> The user-defined hook can be kept in the hooks directory too. It
> just needs to be named in such a way that git will never have a hook
> named like that. For that reason, I think it would be easiest to
> just agree for the git core to never call any hooks prefixed with
> "stgit" or some such. I think the odds for it happening by chance
> are remote, to say the least.

You've lost me. :-/

Take the pre-commit hook as an example. git will call
".git/hooks/pre-commit" when interesting stuff happens. Now StGit
wants to install its pre-commit hook in an existing repository, and
finds that there already is a file called ".git/hooks/pre-commit".
What should it do?

It could move ".git/hooks/pre-commit" to
".git/hooks/pre-commit.d/user_hook", install its own hook in
".git/hooks/pre-commit.d/stgit_hook", and install a multiplexer at
".git/hooks/pre-commit". But that makes some assumptions, e.g. that
the user's hook can handle being moved, and that the user is fine with
this.

I don't see a good way around this other than having git mandate the
multiplexing scheme.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
