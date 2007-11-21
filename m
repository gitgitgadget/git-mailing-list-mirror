From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 16:36:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211632090.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> 
 <Pine.LNX.4.64.0711211554370.27959@racer.site>
 <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IusZJ-0002vh-SP
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbXKUQgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 11:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbXKUQgg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:36:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:48615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751958AbXKUQgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:36:35 -0500
Received: (qmail invoked by alias); 21 Nov 2007 16:36:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 21 Nov 2007 17:36:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aMCYhZICa7Kx7nOfLAcQ9gwuJA0YG6jLm8S7WUw
	zAuvnA1oN6QZx7
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65676>

Hi,

On Wed, 21 Nov 2007, Santi B?jar wrote:

> On Nov 21, 2007 4:59 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 21 Nov 2007, Santi B?jar wrote:
> >
> > > 1) git-clone does not accept a bundle file, even if git-fetch does. 
> > > I've made a patch to use git-fetch in git-clone for this.
> >
> > This, along with rewriting git-clone as a very thin wrapper over 
> > git-init, -remote and -fetch, is a really low hanging fruit.
> 
> For the basic/normal mode it can be a very thin wrapper but you have to 
> support --local, --shared, --reference...

That is not all that difficult.

> > > 2) The bundles created with "git bundle" does not record the HEAD, 
> > > they resolve the symbolic name to a branch name.
> >
> > It imitates ls-remote output.
> 
> No, it does not.
> 
> With a newly created project with one commit:
> 
> $ git ls-remote git.git
> b71992713c17c3a29f9566e1b50e8cf402375faf        HEAD
> b71992713c17c3a29f9566e1b50e8cf402375faf        refs/heads/master
> 
> $ git bundle create git.bdl HEAD master
> 
> $ git bundle list-heads git.bdl
> b71992713c17c3a29f9566e1b50e8cf402375faf refs/heads/master
> b71992713c17c3a29f9566e1b50e8cf402375faf refs/heads/master

Ah, I misunderstood.  I thought you were expecting that the first line 
would read

	refs/heads/master	HEAD

Alas, this behaviour stems from dwim_ref() returning "refs/heads/master" 
as real ref.

I am not quite sure how to solve this, though.  Let me see what I can come 
up with.

Ciao,
Dscho
 
