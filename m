From: Jeff King <peff@peff.net>
Subject: Re: [BUG] --bare is ignored before command word
Date: Wed, 18 Nov 2015 23:46:46 -0500
Message-ID: <20151119044646.GA8059@sigill.intra.peff.net>
References: <loom.20151118T181639-5@post.gmane.org>
 <CA+P7+xoD2-eDZQt29KBqZF2g4i+K7XhJG0mhUgqf5iDURBPntg@mail.gmail.com>
 <vpqa8qbov2n.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Ronny Borchert <mister_rs@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 19 05:46:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzH7Z-0007r2-DL
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 05:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933893AbbKSEqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 23:46:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:59543 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932734AbbKSEqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 23:46:49 -0500
Received: (qmail 25872 invoked by uid 102); 19 Nov 2015 04:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Nov 2015 22:46:49 -0600
Received: (qmail 12567 invoked by uid 107); 19 Nov 2015 04:47:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Nov 2015 23:47:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2015 23:46:46 -0500
Content-Disposition: inline
In-Reply-To: <vpqa8qbov2n.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281465>

On Wed, Nov 18, 2015 at 10:29:20PM +0100, Matthieu Moy wrote:

> But as you say, options before the command word apply to "git", not to
> the particular command. The case of --bare is a bit unfortunate: both
> "git" and "git clone" accept a --bare option, with a different meaning
> (read "man git" to find what the first does).
> 
> So, I wouldn't call the current behavior a really good one, but it's the
> documented behavior.
> 
> It would be nice to warn in this case though: I don't see any use for
> "git --bare clone".

We have a similar situation for "git init". Once upon a time there was
just "git --bare init", and then 74d3b23 (git-init: accept --bare
option, 2008-05-28) let us do it either way.

I'm tempted to say that "git --bare clone" should work the same way.
Both init and clone are special in that they are always about creating a
new repository, not working in an existing one.  That's technically a
non-compatible behavior change, but AFAICT with the current code the
option is silently ignored, which just seems buggy.

But perhaps I am missing some useful effect it does have.

I'd also be OK with simply flagging it as useless and issuing a warning
or error.

-Peff
