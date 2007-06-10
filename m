From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 00:00:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706102333050.4059@racer.site>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
 <7v4plf7948.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWRa-0001Yl-S3
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287AbXFJXD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760205AbXFJXD2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:03:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:36505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759287AbXFJXD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:03:28 -0400
Received: (qmail invoked by alias); 10 Jun 2007 23:03:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 11 Jun 2007 01:03:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kN0pCtXpkNzUypd9Aq/GQVF56/563NhPzMJTlFL
	JO74wYaJNVpf2J
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4plf7948.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49786>

Hi,

On Sun, 10 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > With the provided script, edit-commit-annotations, you can add
> > after-the-fact annotations to commits, which will be shown by
> > the log if the config variable core.showannotations is set.
> >
> > The annotations are tracked in a new ref, refs/annotations/commits,
> > in the same fan-out style as .git/objects/??/*, only that they only
> > exist in the object database now.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	I have the hunch that this will be relatively fast and scalable,
> > 	since the tree objects are sorted by name (the name being the
> > 	object name of the to-be-annotated commit).
> 
> The entries of tree are sorted but not necessarily of uniform
> length so you end up needing linear search anyway.  The fan-out
> would help with the current tree objects.

I do not understand... the entries of a tree object are sorted 
alphabetically, right? Including the convention that if one is a prefix of 
another, it is "smaller".

While I think that the length would not be any problem, the entries' names 
of refs/annotations/commit^{tree} are _all_ of length two, and point to 
other tree objects. _Those_ tree objects contain _only_ entries whose 
names contain exactly 38 characters.

> It will hurt _if_ we introduce a new tree object format that would give 
> you a quick random-access at an entry, but it is premature to worry 
> about that now.

I do not see that. Care to enlighten me?

Ciao,
Dscho
