From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Sun, 4 Dec 2005 20:03:35 -0500
Message-ID: <20051205010335.GA4073@pe.Belkin>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org> <20051028023833.GA19939@pe.Belkin> <20051101233035.GB1431@pasky.or.cz> <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com> <20051102001206.GA21671@pe.Belkin> <20051205000442.GB22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 02:03:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej4lj-000233-SQ
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 02:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVLEBDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 20:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVLEBDh
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 20:03:37 -0500
Received: from eastrmmtao06.cox.net ([68.230.240.33]:19125 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750702AbVLEBDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 20:03:36 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205010151.FRDN9108.eastrmmtao06.cox.net@localhost>;
          Sun, 4 Dec 2005 20:01:51 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1Ej4lT-0001fa-Af; Sun, 04 Dec 2005 20:03:35 -0500
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051205000442.GB22159@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13208>

On Mon, Dec 05, 2005 at 01:04:42AM +0100, Petr Baudis wrote:
> Dear diary, on Wed, Nov 02, 2005 at 01:12:06AM CET, I got a letter
> where Chris Shoemaker <c.shoemaker@cox.net> said that...
> > On Wed, Nov 02, 2005 at 12:33:38PM +1300, Martin Langhoff wrote:
> > > On 11/2/05, Petr Baudis <pasky@suse.cz> wrote:
> > > > What about having the color indicate the number of affected files (let's
> > > > say on a blue..red scale) and the width the size of patch?
> > > 
> > > I'm a /little bit/ colour blind on the red scale -- so I vote for 2
> > > bars, each half the heigth of the current bar.  ;-)
> > 
> > I was going to use two bars for add vs. delete, but this could work,
> > too.  I'm intending on getting back to this ASAP, but for now my
> > cvsimport problems are higher priority (see other post).
> 
> Is there any progress, by the way?

A little.  I decided to follow Junio's suggestion of caching the
result of "git-diff-tree -r -p $commit | git-apply --numstat" in a
BerkeleyDB.  (I liked the idea of reusing the cached results on the
commit page, too.)  I got a script to populate the cache, then I
suspect could be easily adapting into a commit-hook.  Then I started
working on the gitweb part and tried to follow another suggestion
(Kay's, I think.) to use CSS instead of (yet another) embedded .png.

This is where I got hung up: I discovered something strange (to me, at
least) about CSS/html: I'm using the <td></td> in the fifth column of
the shortlog.  I tried to use an anchor tag for the added count and
one for the deleted count.  Setting "display:block" and the different
background-colors works (produces stacked horizontal bars), as does
setting various widths (an essential point), but *ONLY* using "width"
in the CSS.  Using width anchor attribute simply doesn't work.

Honestly, html/css is not my strong suit and neither is perl, although
the BerkeleyDB perl API seemed simple enough.

> If you didn't manage to finish it, no big deal - but it would be great
> to have at least the last version you screenshotted, since IIRC I
> couldn't find that one either, and I would like to play with it a bit.

I'm happy for anyone to take this over.  Since my excursion into css
didn't really work, I'd suggest starting with the gitweb-difftreeP.cgi
version.  I will send you (and anyone else who asks) that file and the
cache population script.

-chris
