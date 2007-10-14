From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] parse-options: Allow abbreviated options when unambiguous
Date: Sun, 14 Oct 2007 15:49:59 -0700
Message-ID: <20071014224959.GA17828@untitled>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 00:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhCHj-0001Fr-8Q
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896AbXJNWuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbXJNWuB
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:50:01 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45229 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185AbXJNWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 18:50:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 033F87DC0FE;
	Sun, 14 Oct 2007 15:49:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710142309010.25221@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60924>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Sun, 14 Oct 2007, Eric Wong wrote:
> 
> > Pierre Habouzit <madcoder@debian.org> wrote:
> > > On Sun, Oct 14, 2007 at 06:02:33PM +0000, Johannes Schindelin wrote:
> > > > Hi,
> > > > 
> > > > On Sun, 14 Oct 2007, Johannes Schindelin wrote:
> > > > 
> > > > > When there is an option "--amend", the option parser now recognizes 
> > > > > "--am" for that option, provided that there is no other option beginning 
> > > > > with "--am".
> > > > 
> > > > And an amend for ultra-abbreviated options (as you noticed on IRC):
> > > > 
> > > > diff --git a/parse-options.c b/parse-options.c
> > > > index afc6c89..acabb98 100644
> > > > --- a/parse-options.c
> > > > +++ b/parse-options.c
> > > > @@ -137,6 +137,11 @@ is_abbreviated:
> > > >  				abbrev_flags = flags;
> > > >  				continue;
> > > >  			}
> > > > +			/* negated and abbreviated very much? */
> > > > +			if (!prefixcmp("no-", arg)) {
> > > > +				flags |= OPT_UNSET;
> > > > +				goto is_abbreviated;
> > > > +			}
> > > >  			/* negated? */
> > > >  			if (strncmp(arg, "no-", 3))
> > > >  				continue;
> > > 
> > >   squashed on top on the previous, and pushed to my ph/parseopt branch.
> > 
> > Awesome.  Thanks to both of you.
> 
> Hehe, you're welcome.  Pierre even realised that my patch was not complete 
> (it did not catch overly short abbreviations "--n" and "--no"), and that 
> has been fixed, too.
 
> While I have your attention: last weekend, I spoke to a guy from the 
> ffmpeg project, and he said that the only thing preventing them from 
> switching to git was the lack of svn:external support...
> 
> (Of course I know that it is more difficult than that: ffmpeg itself is an 
> svn:external of MPlayer, but maybe we can get both of them to switch ;-)
> 
> Do you have any idea when/if you're coming around to add that to git-svn?

Soonish, possibly within a next week, even.  I have actually have
started a project (using git) that wants to use SVN-hosted repositories
directly submodules; so the fact that I'll actually need something like
it bodes well for getting it implemented :)

-- 
Eric Wong
