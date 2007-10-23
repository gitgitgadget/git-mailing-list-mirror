From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Dissociating a repository from its alternates
Date: Tue, 23 Oct 2007 01:13:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710230112131.25221@racer.site>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702151638130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xex50aa.fsf@assigned-by-dhcp.cox.net> <20071022180424.GA17429@ginosko.local>
 <Pine.LNX.4.64.0710221957360.25221@racer.site> <20071022233050.GA18430@ginosko.ndrix.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 02:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik7PS-0005X0-4l
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 02:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXJWAN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 20:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXJWAN5
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 20:13:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:51503 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751310AbXJWAN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 20:13:56 -0400
Received: (qmail invoked by alias); 23 Oct 2007 00:13:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 23 Oct 2007 02:13:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IqiAACZUIEmU8Tk1pA6WMl2P89LWnEWYxuUcFbL
	ShfEo/Xc4QhUm5
X-X-Sender: gene099@racer.site
In-Reply-To: <20071022233050.GA18430@ginosko.ndrix.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62062>

Hi,

On Mon, 22 Oct 2007, Michael Hendricks wrote:

> On Mon, Oct 22, 2007 at 08:05:58PM +0100, Johannes Schindelin wrote:
> > On Mon, 22 Oct 2007, Michael Hendricks wrote:
> > > Was such a script ever incorporated into Git?
> > 
> > Not that I know of, but "git repack -a && rm
> > .git/objects/info/alternates" should do what you want.  You can even
> > make a script of it, add some documentation and a test case, and earn
> > git fame by posting a patch ;-)
> 
> With 1.5.3.4, it doesn't appear to work:
> 
>  $ git clone -s git git2
>  Initialized empty Git repository in /Users/michael/src/git2/.git/
> 
>  $ cd git2
> 
>  $ git repack -a && rm .git/objects/info/alternates
>  Generating pack...
>  Done counting 0 objects.
>  Nothing new to pack.
> 
>  $ git status
>  # On branch master
>  fatal: bad object HEAD

Indeed.  Seems that somewhere along the line, repack learnt to imply "-l" 
by "-a" or something.  Try this instead of "git repack -a":

	git rev-parse --all |
		git pack-objects --revs .git/objects/pack/pack

(And make sure you read the relevant parts of the documentation to 
understand what you're doing ;-)

Hth,
Dscho
