From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC v3] git add -i: Answer questions with a single
	keypress
Date: Fri, 7 Nov 2008 14:19:10 -0500
Message-ID: <20081107191910.GA15218@coredump.intra.peff.net>
References: <200811042215.31147.sunaku@gmail.com> <200811050959.25824.sunaku@gmail.com> <20081106084230.GA4407@sigill.intra.peff.net> <200811060815.16797.sunaku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Suraj N. Kurapati" <sunaku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:20:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyWsh-0006eg-I5
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 20:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYKGTTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 14:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbYKGTTO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 14:19:14 -0500
Received: from peff.net ([208.65.91.99]:4665 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbYKGTTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 14:19:13 -0500
Received: (qmail 1826 invoked by uid 111); 7 Nov 2008 19:19:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 14:19:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 14:19:10 -0500
Content-Disposition: inline
In-Reply-To: <200811060815.16797.sunaku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100323>

On Thu, Nov 06, 2008 at 08:15:16AM -0800, Suraj N. Kurapati wrote:

> v1 and v2 make the mistake of setting raw mode, which prevent the user from 
> pressing Control-C to exit the program.  v3 fixes this by using cbreak mode.

OK, makes sense.

> The git-svn.perl script also uses Term::ReadKey.  Since it is already in the 
> git source repository, I thought it was okay to use Term::ReadKey.

We are not always consistent with such things, and git-add--interactive
is a little "more core" than git-svn, I think. Still, maybe I am being
overly cautious. We can always try it and see who complains. ;)

I think considering this improvement:

> >  - This only enhances one particular input, the patch loop. It is
> >    probably worth being consistent and allowing these behavior for other
> >    menus (though the numeric inputs are a bit trickier).
> 
> Understood.

it makes sense to factor the ReadKey procedure into a separate function
anyway. At which point it should be easy enough to substitute in the
original behavior if there is no ReadKey.

Side note: I don't know if such people exist, but I suppose it is
possible that somebody would _prefer_ the old behavior. In which case
factoring it out will also make it easier to predicate the behavior on a
config variable, if people want that.

-Peff
