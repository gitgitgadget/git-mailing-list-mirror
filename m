From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] send-email: die if CA path doesn't exist
Date: Wed, 25 Nov 2015 05:23:35 -0500
Message-ID: <20151125102335.GA2844@sigill.intra.peff.net>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <554d29f019f52d18cf1d6c5835df0a3a098a1df4.1448407832.git.john@keeping.me.uk>
 <20151124233536.GB13872@sigill.intra.peff.net>
 <20151125101909.GF18913@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1XEp-0003lg-9D
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbbKYKXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:23:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:33807 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752041AbbKYKXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:23:38 -0500
Received: (qmail 32345 invoked by uid 102); 25 Nov 2015 10:23:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 04:23:38 -0600
Received: (qmail 25024 invoked by uid 107); 25 Nov 2015 10:23:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 05:23:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 05:23:35 -0500
Content-Disposition: inline
In-Reply-To: <20151125101909.GF18913@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281696>

On Wed, Nov 25, 2015 at 10:19:09AM +0000, John Keeping wrote:

> > > Changes since v1:
> > > - add missing path to error message
> > > - remove trailing '.' on error message since die appends "at
> > >   /path/to/git-send-email line ..."
> > 
> > It won't if the error message ends with a newline. We seem to be wildly
> > inconsistent about that in send-email, though.
> 
> Interesting.  I think in this case it would definitely be better to add
> the newline and avoid printing the location in the script, but it may
> make more sense to have a separate pass over git-send-email.perl and fix
> all of the die() calls.
> 
> I suspect that everything except the equivalent of BUG() should be
> suppressing the location in a user-facing script like this.

Yeah, I think I'd agree. Your patch is merged to next, so we'd want a
separate patch to fix. And I agree that a whole pass over the script
probably makes sense.

In past projects I have also used a $SIG{__DIE__} handler to massage
errors into a nicer format, but it unfortunately gets pretty deep into
Perl voodoo.

-Peff
