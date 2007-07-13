From: Theodore Tso <tytso@mit.edu>
Subject: Re: mtimes of working files
Date: Thu, 12 Jul 2007 20:37:01 -0400
Message-ID: <20070713003700.GA21304@thunk.org>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070711202615.GE3069@efreet.light.src> <200707120857.53090.andyparkins@gmail.com> <1184261246.31598.139.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 05:23:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9BkB-000286-QN
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 05:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757659AbXGMDW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 23:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756416AbXGMDW4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 23:22:56 -0400
Received: from THUNK.ORG ([69.25.196.29]:56889 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756236AbXGMDW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 23:22:56 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I9Brz-0006ta-SC; Thu, 12 Jul 2007 23:31:04 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I999Z-0006I2-Bx; Thu, 12 Jul 2007 20:37:01 -0400
Content-Disposition: inline
In-Reply-To: <1184261246.31598.139.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52357>

On Thu, Jul 12, 2007 at 06:27:26PM +0100, David Woodhouse wrote:
> On Thu, 2007-07-12 at 08:57 +0100, Andy Parkins wrote:
> > The only time you get an unnecessary rebuild is if you do
> > 
> >  git checkout branch1
> >  git checkout branch2
> >  git checkout branch1
> > 
> > But we can hardly expect git to be responsible for that. 
> 
> Indeed. That's a user error. Git makes it cheap and easy to have
> separate _trees_. Just use them -- branches are just another mental
> hangover from CVS which we should try to cure ourselves of :)

Personally, I just use branches a huge amount, and I will often do

git checkout branch1
<hack hack hack>
git commit --amend
<build, test>
git checkout branch2
<hack hack hack>
git commit
<build, test>
git checkout branch1
<build>

Rebuilding isn't a problem, because I use ccache.  :-)

I could use separate trees, I suppose, but then I have to keep
multiple copies of the .o files around in all of those separate trees,
and it's cheaper and more efficient to keep them in the ccache cache
IMHO.  And with 7200 RPM laptop drives and dual core processors
combined with ccache, I hardly notice the rebuild/relink time.

	     	       	      	     - Ted
