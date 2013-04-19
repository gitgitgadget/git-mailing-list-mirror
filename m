From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Fri, 19 Apr 2013 00:14:24 -0400
Message-ID: <20130419041424.GA377@sigill.intra.peff.net>
References: <20130417201056.GA2914@sigill.intra.peff.net>
 <7va9owd3d1.fsf@alter.siamese.dyndns.org>
 <20130418172714.GA24690@sigill.intra.peff.net>
 <7vd2tr6833.fsf@alter.siamese.dyndns.org>
 <20130418180017.GA5714@sigill.intra.peff.net>
 <7v61zj66wu.fsf@alter.siamese.dyndns.org>
 <20130418203035.GB24690@sigill.intra.peff.net>
 <7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
 <20130418214427.GA10119@sigill.intra.peff.net>
 <7vobdb4hii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 06:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT2ih-0008TE-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 06:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab3DSEO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 00:14:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:43758 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab3DSEO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 00:14:28 -0400
Received: (qmail 4889 invoked by uid 102); 19 Apr 2013 04:14:33 -0000
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (75.15.5.89)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Apr 2013 23:14:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2013 00:14:24 -0400
Content-Disposition: inline
In-Reply-To: <7vobdb4hii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221726>

On Thu, Apr 18, 2013 at 03:10:29PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I am expecting a reaction more like "Hmm, I never thought about it
> > before. Does that make sense to me or not? Let me think about which
> > paths it pertains to and decide".
> 
> Let's step back and re-review the main text.

Good idea. I was very caught up in the existing message and what it made
me expect, and not in what we are trying to accomplish overall.

> It currently says:
> 
>     In Git 2.0, 'git add <pathspec>...' will also update the
>     index for paths removed from the working tree that match
>     the given pathspec. If you want to 'add' only changed
>     or newly created paths, say 'git add --no-all <pathspec>...'
>     instead.
> 
> This was written for the old "we may want to warn" logic that did
> not even check if we would be omitting a removal.  The new logic
> will show the text _only_ when the difference matters, we have an
> opportunity to tighten it a lot, for example:
> 
>     You ran 'git add' with neither '-A (--all)' or '--no-all', whose
>     behaviour will change in Git 2.0 with respect to paths you
>     removed from your working tree.
> 
>     * 'git add --no-all <pathspec>', which is the current default,
>       ignores paths you removed from your working tree.
> 
>     * 'git add --all <pathspec>' will let you also record the
>       removals.
> 
>     The removed paths (e.g. '%s') are ignored with this version of Git.
>     Run 'git status' to remind yourself what paths you have removed
>     from your working tree.
> 
> or something?

Yes, I like that much better. It reads more clearly than the original,
and it is more obvious why we are mentioning the path at all.

And I think the hint of "git status" is good. I had considered before
that the user would simply run "git status" after the message to get
more data, but I didn't want to rely on them knowing to do that.
Actually mentioning it is a good solution. :)

Thanks for pointing us in the right direction.

-Peff
