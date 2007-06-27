From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] rebase -i: several cleanups
Date: Wed, 27 Jun 2007 02:17:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706270216070.4438@racer.site>
References: <Pine.LNX.4.64.0706251856300.4059@racer.site>
 <7vk5tqurrw.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 03:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MFW-0002SP-2V
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbXF0BXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbXF0BXD
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:23:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:36980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752495AbXF0BXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:23:01 -0400
Received: (qmail invoked by alias); 27 Jun 2007 01:22:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 27 Jun 2007 03:22:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19roD9Xrn5rDHC8UFltsx3p3zBTuth9TJzfn8ofVX
	qIy5i3khFQ98ts
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5tqurrw.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50996>

Hi,

On Tue, 26 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Support "--verbose" in addition to "-v", show short names in the list
> > comment, clean up if there is nothing to do, and add several "test_ticks"
> > in the test script.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git-rebase--interactive.sh    |   19 +++++++++++++++----
> >  t/t3404-rebase-interactive.sh |    2 ++
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index ab36572..b95fe86 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -60,6 +60,11 @@ die_with_patch () {
> >  	die "$2"
> >  }
> >  
> > +die_abort () {
> > +	rm -rf "$DOTEST" 2> /dev/null
> > +	die "$1"
> > +}
> 
> Why "2>/dev/null" here?

Just to be sure. If it does not exist, it's no error. No sense alarming 
the user.

> > @@ -264,8 +269,11 @@ do
> >  		echo $ONTO > "$DOTEST"/onto
> >  		test t = "$VERBOSE" && : > "$DOTEST"/verbose
> >  
> > +		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
> > +		SHORTHEAD=$(git rev-parse --short $HEAD)
> > +		SHORTONTO=$(git rev-parse --short $ONTO)
> >  		cat > "$TODO" << EOF
> > -# Rebasing $UPSTREAM..$HEAD onto $ONTO
> > +# Rebasing $SHORTUPSTREAM)..$SHORTHEAD onto $SHORTONTO
> 
> What is this close-paren about?  Is it a typo?

Darn. It _is_ a typo. I overlooked it _both_ when typing _and_ when 
looking at the result.

Sorry.

Ciao,
Dscho
