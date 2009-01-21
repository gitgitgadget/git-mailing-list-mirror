From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 14:50:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901211443140.19665@iabervon.org>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <49773240.7090605@drmicha.warpmail.net> <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com> <49773E48.90302@drmicha.warpmail.net> <20090121161940.GA20702@coredump.intra.peff.net>
 <alpine.LNX.1.00.0901211237530.19665@iabervon.org> <20090121191219.GD21686@coredump.intra.peff.net> <20090121191408.GA22958@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPj7O-0003AL-33
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbZAUTun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZAUTum
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:50:42 -0500
Received: from iabervon.org ([66.92.72.58]:55021 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbZAUTum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:50:42 -0500
Received: (qmail 27273 invoked by uid 1000); 21 Jan 2009 19:50:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2009 19:50:40 -0000
In-Reply-To: <20090121191408.GA22958@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106656>

On Wed, 21 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 02:12:19PM -0500, Jeff King wrote:
> 
> > > I think it might be more appropriate to just care less about a broken 
> > > symref, explain what's wrong if the user actually tries to use it, and 
> > > otherwise mostly ignore it.
> > 
> > I thought about that, but I still wonder if deleting it when the
> > pointed-to ref is deleted might be more convenient. Remember that
> > "refs/remotes/$foo/HEAD" can be accessed by a shorthand "$foo". So that
> > means it can impact ref ambiguity lookup. I guess the chance of that
> > happening is fairly unlikely, though.
> 
> Not to mention that even without others refs with matching names, it is
> probably nicer to the user who does try to access it via "$foo" to
> simply say "there is no $foo" rather than a confusing error message
> about a deleted branch that they have to manually fix. And that is
> easily accomplished by deleting such a bogus symref.

I think the ideal thing is to keep the symref as a reminder and just give 
a non-confusing error message instead of a confusing one. E.g.:

"""
$foo is set to mean the tracking branch $foo/bar, which does not exist. 
Use:

  git remote set-default $foo <name>

to set a new default branch for $foo.
"""

(And, of course, add that subcommand to remote)
	-Daniel
*This .sig left intentionally blank*
