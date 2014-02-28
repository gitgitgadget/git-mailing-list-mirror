From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: add archive.restrictRemote option
Date: Fri, 28 Feb 2014 04:07:09 -0500
Message-ID: <20140228090709.GB11709@sigill.intra.peff.net>
References: <20140227040504.GA2242@sigill.intra.peff.net>
 <xmqqtxbkz9jp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Scott J. Goldman" <scottjg@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJPk-0001Ih-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaB1JHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:07:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:58592 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751732AbaB1JHL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:07:11 -0500
Received: (qmail 20117 invoked by uid 102); 28 Feb 2014 09:07:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 03:07:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 04:07:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtxbkz9jp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242911>

On Thu, Feb 27, 2014 at 10:37:30AM -0800, Junio C Hamano wrote:

> > Signed-off-by: Jeff King <peff@peff.net>
> 
> Thanks.
> 
> Do GitHub people have general aversion against signing off (or
> sending out, for that matter) their own patches, unless they were
> already active here before they joined GitHub, by the way?

Mostly it is that I clean up the patches and commit messages before
sending them out. Michael sends out his own patches because they are
already perfect by the time I see them. :)

I can certainly get S-O-B from GitHubbers, but my impression of the DCO
is that it does not matter; as the first link in the signoff chain, I am
certifying that the patch meets the licensing requirements. Of course, I
know that because of my relationship to the author and our employer,
which is something that isn't encoded in the headers. A S-O-B from the
author would perhaps make it more obvious what happened.

> I like the general idea and this escape hatch would be a good thing
> to have.
> 
> A few comments:
> 
>  - Seeing the word combination "restrict"+"remote" before reading
>    the explanation made me think "hmph, only allow remote archive
>    from certain hosts but not from others?"  We are restricting the
>    objects and only on the remote usage, not restricting remotes, so
>    somebody else may be able to come up with a less misleading name.
>
>  - It might be better to call the escape hatch "allow something"
>    that defaults to "false".  It is merely the issue of perception,
>    but having a knob to be limiting that defaults to true gives a
>    wrong impression that in an ideal world remote archive ought to
>    be loose and we are artificially limiting it by default.

After reading your first point, I came up with
"archive.allowRemoteUnreachable", which also satisfies the second. I do
not have a strong opinion.

> > +archive.restrictRemote::
> > +	If true, archives can only be requested by refnames. If false,
> 
> As this does not affect local use of "git archive", "requested by
> refnames" may need to be clarified further.  Perhaps "remote
> archives can be requested only for published refnames" or something.

I was hoping to be vague. If we really want to get into specifics, we
should probably document the current rules (refnames, and sub-trees of
refnames). It might be a good thing to document that anyway, though. And
by doing so, it would become obvious why one would want to set this
option. I'll see what I can come up with.

-Peff
