From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 8/8] Fix t1500 for sane work-tree behavior
Date: Sat, 28 Jul 2007 01:46:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280140161.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271958590.14781@racer.site> <7v8x91y3h7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEaRw-0007bU-RX
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938237AbXG1Aq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938070AbXG1Aq0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:46:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:54153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764266AbXG1AqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:46:25 -0400
Received: (qmail invoked by alias); 28 Jul 2007 00:46:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 28 Jul 2007 02:46:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dSy0lP8sdG8iClKn38G7xsbbdLHhjF/6K9Zs2b/
	9dZCjSyQHd3t5N
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x91y3h7.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53980>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When GIT_DIR=../.git, and no worktree is specified, it is reasonable
> > to assume that the repository is not bare, that the work tree is ".."
> > and that the prefix is the basename of the current directory.
> >
> > This is the sane behavior.
> 
> That is a bit too strong blanket statement, while being weak on
> exact conditions, giving only one example.

Okay, let me defend it.

> It makes me wonder...
> 
>   * When GIT_DIR=../../.git, and no worktree is specified, the
>     same holds true, with worktree is "../.."? (probably yes)

You meant with "GIT_DIR=../.."? No.  In that case, I'd assume a bare 
repository, and we're inside the git directory, and unless the user 
specified a working tree, assume that we have none.

>   * "GIT_DIR=../../foo/.git"? (I dunno)

Unless ../../foo == .. no.  When we're outside, we're outside.

>   * "GIT_DIR=../foo.git"? (probably not)

Unless "$(basename "$(pwd)")" == foo.git, no.

> I am assuming that you meant something like this:
> 
>     When no worktree is specified, and GIT_DIR (or --git-dir=) is
>     zero or more "../" followed by ".git" after stripping trailing
>     and/or redundant slashes, it is reasonable to assume that the
>     repository is not bare, and the work tree is the parent
>     directory of the GIT_DIR directory.
> 
> but that requires guesswork if you give only one example and let
> the readers to guess.

Your explanation is really much more coherent than mine.  Please replace 
mine.

Ciao,
Dscho
