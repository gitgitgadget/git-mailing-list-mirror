From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Thu, 4 Dec 2014 05:26:58 -0500
Message-ID: <20141204102657.GA27739@peff.net>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com>
 <20140919093910.GA15891@peff.net>
 <CALKQrgc4nZdaXM-Ooh1pP4x4nZRLexJzLyaBmrgn+qVaQGCg+g@mail.gmail.com>
 <xmqqoaubmpvh.fsf@gitster.dls.corp.google.com>
 <6b21dd7a53200ab413c67bb4667e8bc@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Scott Chacon <schacon@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 11:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwTcu-00079d-8o
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 11:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbaLDK1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 05:27:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:48293 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753500AbaLDK1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 05:27:00 -0500
Received: (qmail 26055 invoked by uid 102); 4 Dec 2014 10:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 04:27:00 -0600
Received: (qmail 5215 invoked by uid 107); 4 Dec 2014 10:27:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 05:27:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 05:26:58 -0500
Content-Disposition: inline
In-Reply-To: <6b21dd7a53200ab413c67bb4667e8bc@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260753>

On Sat, Nov 22, 2014 at 10:04:57AM -0800, Kyle J. McKay wrote:

> > By "stealth enabler" I mean the removal of refs/notes/ restriction
> > that was originally done as a safety measure to avoid mistakes of
> > storing notes outside.  The refs/remote-notes/ future direction
> > declares that it is no longer a mistake to store notes outside
> > refs/notes/, but that does not necessarily have to mean that
> > anywhere under refs/ is fine.  It may make more sense to be explicit
> > with the code touched here to allow traditional refs/notes/ and the
> > new hierarchy only.  That way, we will still keep the "avoid
> > mistakes" safety and enable the new layout at the same time.
> 
> This is the part where I want to lobby for inclusion of this change.   
> I do not believe it is consistent with existing Git practice to  
> enforce restrictions like this (you can only display/edit/etc. notes  
> under refs/notes/*).

Yeah, this is the compelling part to me. There is literally no way to
utilize the notes codes for any ref outside of refs/notes currently. We
don't know if refs/remote-notes is the future, or refs/remotes/origin/notes,
or something else. But we can't even experiment with it in a meaningful way
because the plumbing layer is so restrictive.

The notes feature has stagnated. Not many people use it because it requires
so much magic to set up and share notes. I think it makes sense to remove a
safety feature that is making it harder to experiment with. If the worst
case is that people start actually _using_ notes and we get proliferation of
places that people are sticking them in the refs hierarchy, that is vastly
preferable IMHO to the current state, in which few people use them and there
is little support for sharing them at all.

The original patch discussion sort of fizzled, and your response here
largely slipped through the cracks. I am not sure everyone even
remembers the exact patch under discussion. Maybe a better way to
re-kickstart the discussion is to repost the patch along with a synopsis
of the previous discussion and your arguments about moving it forward.

-Peff
