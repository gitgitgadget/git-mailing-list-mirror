From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] parse-options: Allow abbreviated options when unambiguous
Date: Sun, 14 Oct 2007 23:12:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710142309010.25221@racer.site>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp>
 <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site>
 <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 00:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhBht-0004Ez-4f
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbXJNWM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbXJNWM7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:12:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:60340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754262AbXJNWM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 18:12:58 -0400
Received: (qmail invoked by alias); 14 Oct 2007 22:12:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 15 Oct 2007 00:12:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19p03BlHDJpg6ICDCQx8HAkdsy8Ysph4wh5yG4cnb
	zsJu19erlT7hMX
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014210130.GA17675@soma>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60915>

Hi,

On Sun, 14 Oct 2007, Eric Wong wrote:

> Pierre Habouzit <madcoder@debian.org> wrote:
> > On Sun, Oct 14, 2007 at 06:02:33PM +0000, Johannes Schindelin wrote:
> > > Hi,
> > > 
> > > On Sun, 14 Oct 2007, Johannes Schindelin wrote:
> > > 
> > > > When there is an option "--amend", the option parser now recognizes 
> > > > "--am" for that option, provided that there is no other option beginning 
> > > > with "--am".
> > > 
> > > And an amend for ultra-abbreviated options (as you noticed on IRC):
> > > 
> > > diff --git a/parse-options.c b/parse-options.c
> > > index afc6c89..acabb98 100644
> > > --- a/parse-options.c
> > > +++ b/parse-options.c
> > > @@ -137,6 +137,11 @@ is_abbreviated:
> > >  				abbrev_flags = flags;
> > >  				continue;
> > >  			}
> > > +			/* negated and abbreviated very much? */
> > > +			if (!prefixcmp("no-", arg)) {
> > > +				flags |= OPT_UNSET;
> > > +				goto is_abbreviated;
> > > +			}
> > >  			/* negated? */
> > >  			if (strncmp(arg, "no-", 3))
> > >  				continue;
> > 
> >   squashed on top on the previous, and pushed to my ph/parseopt branch.
> 
> Awesome.  Thanks to both of you.

Hehe, you're welcome.  Pierre even realised that my patch was not complete 
(it did not catch overly short abbreviations "--n" and "--no"), and that 
has been fixed, too.

While I have your attention: last weekend, I spoke to a guy from the 
ffmpeg project, and he said that the only thing preventing them from 
switching to git was the lack of svn:external support...

(Of course I know that it is more difficult than that: ffmpeg itself is an 
svn:external of MPlayer, but maybe we can get both of them to switch ;-)

Do you have any idea when/if you're coming around to add that to git-svn?

Ciao,
Dscho
