From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-submodule: add support for --rebase.
Date: Wed, 8 Apr 2009 12:44:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904081241460.9157@intel-tinevez-2-302>
References: <20090407111445.GA11344@dingo> <alpine.DEB.1.00.0904071428350.6897@intel-tinevez-2-302> <20090408042212.GA4702@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 12:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrVIe-0001MN-SO
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbZDHKo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 06:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756691AbZDHKo4
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:44:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:37829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755706AbZDHKoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:44:55 -0400
Received: (qmail invoked by alias); 08 Apr 2009 10:44:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 08 Apr 2009 12:44:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Zq1wcUzGZX1uKcZmyK/SzYLjEqvkVUahTD9B2zT
	7xrpLsaKmhnfuU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090408042212.GA4702@dingo.bne.redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116076>

Hi,

On Wed, 8 Apr 2009, Peter Hutterer wrote:

> On Tue, Apr 07, 2009 at 02:38:37PM +0200, Johannes Schindelin wrote:
>
> > Peter wrote originally:
> >
> > > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> > > index 3b8df44..117ad3d 100644
> > > --- a/Documentation/git-submodule.txt
> > > +++ b/Documentation/git-submodule.txt
> > > @@ -177,6 +178,12 @@ OPTIONS
> > >  	This option is only valid for the update command.
> > >  	Don't fetch new objects from the remote site.
> > >  
> > > +--rebase::
> > > +	This option is only valid for the update command.
> > 
> > This is unnecessary, it was mentioned in the synopsis.
> 
> Correct, but in the same file the options --cached, --no-fetch, and 
> --summary-limit do state that they are only valid for the 
> update/status/summary commands, respectively. For consistency, we should 
> either add this sentence to --rebase, or remove them from the others. I 
> personally prefer having it there, just to make it more obvious.

Fair enough!

> > > +	Forward-port local commits to the index of the containing repository.
> > 
> > This is a bit misleading/unclear.  I'd rather have it read like this:
> > 
> > 	Instead of detaching the HEAD to the revision committed in the 
> > 	superproject, rebase the current branch onto that revision.
> 
> Hehe. I had something like this before and then decided to copy/paste 
> the line from the git-rebase man page :)
> 
> Changed to: "Rebase the current branch onto the index of the containing 
> repository instead of detaching the HEAD." (I vaguely remember the rule 
> that sentences are easier to understand if you have "blah instead of 
> foo" rather than "instead of foo, blah")

> The phrase "index of the containing repository" is commonly used in this 
> man page, so I think it's best to stick with it. That better now?

Hmm.

You can really rebase only onto a commit.  And the index is not a commit, 
so I do not like the wording (not even in the rebase man page).

But let's see what other reviewers say... :-)

> > > +	If a a merge failure prevents this process, you will have to resolve
> > > +	these failures with linkgit:git-rebase[1].
> > > +
> > >  <path>...::
> > >  	Paths to submodule(s). When specified this will restrict the command
> > >  	to only operate on the submodules found at the specified paths.
> > > diff --git a/git-submodule.sh b/git-submodule.sh
> > > index 7c2e060..6180bf4 100755
> > > --- a/git-submodule.sh
> > > +++ b/git-submodule.sh
> > 
> > You might want to error out when --rebase was passed with another 
> > command than "update".
> 
> cmd_init(), cmd_summary(), etc. have catch-all rules for unknown options 
> to display the usage, so this is covered. (e.g. line 439, 
> git-submodule.sh)

Oh, okay!

Other than the wording, I am completely happy with this patch.

Ciao,
Dscho
