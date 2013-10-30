From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap
 format
Date: Wed, 30 Oct 2013 03:50:40 -0400
Message-ID: <20131030075040.GJ11317@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180347.GI24180@sigill.intra.peff.net>
 <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com>
 <20131025032144.GB26283@sigill.intra.peff.net>
 <CAJo=hJvmL0=MN7W-NW4bACK0m+Y39+LBVZ+ufXTEh8KzyjFbKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Colby Ranger <cranger@google.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQYC-0003D3-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab3J3Huo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 03:50:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:58280 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752078Ab3J3Hun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:50:43 -0400
Received: (qmail 16797 invoked by uid 102); 30 Oct 2013 07:50:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 02:50:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 03:50:40 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvmL0=MN7W-NW4bACK0m+Y39+LBVZ+ufXTEh8KzyjFbKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236997>

On Fri, Oct 25, 2013 at 01:47:06PM +0000, Shawn O. Pearce wrote:

> I think Colby and I talked about having additional optional sections
> in this file, but Colby didn't want to overcomplicate the format early
> on. So v1 is probably not very extensible and we may have to go to v2
> to safely create an extension with the name hash cache used in this
> series.
> 
> Given that the JGit v1 bitmap format has been shipping since JGit 3.0
> and in Gerrit Code Review 2.6, its in use in the wild. So we aren't
> going to go back and redefine v1.

I don't think either course of action affects how JGit in the wild will
react. If we add a new flag to v1, existing JGit barfs. If we move to
v2, existing JGit barfs.  In either case, the simplest fix for JGit is
to ignore the new section.

If we want to define a v2 format and make it clear how to add optional
sections, that's fine. But what I really want to avoid is a big v2
bikeshedding discussion where other features get added because it's a
version bump. This feature has been a long-time coming, and I'd like to
at least get us on par with JGit's v1 bitmaps. It's a big series, and I
fear that v2 discussions would end up as a distraction.

If that means dropping the name-hash cache from the series, so be it
(that's part of why I pulled it out into its own patch at the end). We
could also make it optional with a documentation warning that existing
JGit will not like the resulting bitmap files. In practice, I do not
expect it to be a big deal, as most sites will not mix-and-match serving
from the two implementations (though you might repack with C git and
serve with JGit, which means "off" would be the sane default for the
feature).

-Peff
