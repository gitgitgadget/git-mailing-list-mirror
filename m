From: Steven Scott <steven@codemettle.com>
Subject: Re: [BUG] git-svn fails to rename files with %20 in filename
Date: Wed, 2 Mar 2011 10:27:29 -0500
Message-ID: <AANLkTimQTwSPnyNBBNnSYLStZqQvBjWk0ydOpcw1UiwO@mail.gmail.com>
References: <1298283144.2772.7.camel@wpalmer.simply-domain>
 <20110221123115.GB23033@sigill.intra.peff.net> <1298393415.2286.18.camel@wpalmer.simply-domain>
 <20110223100431.GD9222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Will Palmer <wmpalmer@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 16:27:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Punxz-0003ld-Je
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 16:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab1CBP1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 10:27:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43470 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1CBP1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 10:27:49 -0500
Received: by iyb26 with SMTP id 26so19363iyb.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 07:27:49 -0800 (PST)
Received: by 10.231.206.1 with SMTP id fs1mr7457932ibb.193.1299079669068; Wed,
 02 Mar 2011 07:27:49 -0800 (PST)
Received: by 10.231.12.73 with HTTP; Wed, 2 Mar 2011 07:27:29 -0800 (PST)
X-Originating-IP: [50.10.67.132]
In-Reply-To: <20110223100431.GD9222@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168312>

On Wed, Feb 23, 2011 at 5:04 AM, Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 22, 2011 at 04:50:15PM +0000, Will Palmer wrote:
>
> > > IOW, it looks like the path we hand to svn needs url-encoding even for
> > > the local case (which make sense, as it is a file:// url). But I know
> > > nothing about svn, so probably I am breaking some other weird non-url
> > > local case. :)
> > >
> >
> > Unless I've got my line-numbers mixed up, the commit which introduced
> > the https-specific encoding behaviour,
> > 29633bb91c git-svn: fix commiting renames over DAV with funky file names
> >
> > seems to be of the opinion that the bug did not effect file:// and
> > svn:// URLs. Has something changed?
>
> Yeah, what we are seeing definitely contradicts that commit. It's been
> 3.5 years; maybe something was tweaked in the subversion library? I
> tried reading the code, but I got lost amidst all of the nasty perl
> bindings. I couldn't find anything relevant in svn's changelog or in
> google, either.
>


In my case, I *was* using http://, and applying that patch (to remove
the HTTP check) didn't work. Same error as earlier in the thread. I
thought it worked once, but I eventually saw it fail again. git-svn is
definitely broken if the URL has a %20 in it, and it's quite useless
when you never know when you'll be unable to dcommit and manually have
to generate patches and apply them to a svn repository.

Thankfully I got my team to switch to git, so best of luck to the rest
of you trying to use git-svn when a doofus put a space in the URL :)

--
Steven Scott
