From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 15:59:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211554370.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ius03-0002rR-Ru
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583AbXKUP7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755572AbXKUP7y
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:59:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:36782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754648AbXKUP7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:59:53 -0500
Received: (qmail invoked by alias); 21 Nov 2007 15:59:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 21 Nov 2007 16:59:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Rn0tlglMRszwcGP78AFasdSed2y/dm/OHaH8cEM
	7+14buA059o6cM
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65670>

Hi,

On Wed, 21 Nov 2007, Santi B?jar wrote:

> 1) git-clone does not accept a bundle file, even if git-fetch does. I've 
> made a patch to use git-fetch in git-clone for this.

This, along with rewriting git-clone as a very thin wrapper over git-init, 
-remote and -fetch, is a really low hanging fruit.

Or maybe go the full nine yards and build it in.  Should be a breeze now, 
given parse_options() and run_command().

> 2) The bundles created with "git bundle" does not record the HEAD, they 
> resolve the symbolic name to a branch name.

It imitates ls-remote output.

> 3) I can "git fetch" a bundle but I cannot "git push" a bundle, so if I have:
> 
> [remote "bundle"]
>   url = /file/to/bundle
>   fetch = "+refs/heads/*:refs/remotes/bundle/*"
> 
> $ git push bundle
> 
> would create a bundle in /file/to/bundle with the same branches as a
> normal git push, but considering the remote branches as the local
> remotes/bundle/*

Does not seem to be too complicated to add it to transport.c IMHO.  
Something similar to rsync_transport_push().  And I'd definitely refuse to 
overwrite any existing file.

Ciao,
Dscho
