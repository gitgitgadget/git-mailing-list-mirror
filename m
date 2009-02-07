From: Jeff King <peff@peff.net>
Subject: Re: How to find out which gitignore blocks my git-add
Date: Sat, 7 Feb 2009 01:42:21 -0500
Message-ID: <20090207064221.GA14856@coredump.intra.peff.net>
References: <498C0525.5040100@gonsolo.de> <20090206193359.GF19494@coredump.intra.peff.net> <slrngopp7n.his.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 07:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVguy-0002iS-FN
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 07:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZBGGm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 01:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbZBGGmZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 01:42:25 -0500
Received: from peff.net ([208.65.91.99]:57587 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbZBGGmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 01:42:24 -0500
Received: (qmail 18951 invoked by uid 107); 7 Feb 2009 06:42:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 01:42:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 01:42:21 -0500
Content-Disposition: inline
In-Reply-To: <slrngopp7n.his.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108814>

On Sat, Feb 07, 2009 at 01:33:43AM +0000, Sitaram Chamarty wrote:

> > I think it might be useful to be able to get this information. However,
> > rather than coupling it with "git add", it might make more sense to have
> > a separate way to query "is this being ignored, and if so, by what
> > pattern". Then you could use that tool to generally debug your
> > .gitignore patterns.
> 
> maybe GIT_TRACE could print that as well, in some way?

It could, but I think reusing GIT_TRACE isn't a good idea. Currently it
traces _just_ exec information, so I wouldn't want to pollute that with
this information. But yes, you could trigger it through an environment
variable, which would let us dump at the lowest level.

I spent a few minutes checking this out, and it looks to be a little
more complex than I had hoped, just because we don't have all of the
information in the same place at the same time.

A toy patch series follows; see 2/2 for a description of why it doesn't
work like you might hope. I'm not too interested in trying to deal with
the refactoring that would be required to do it right. But maybe
somebody else is.

-Peff
