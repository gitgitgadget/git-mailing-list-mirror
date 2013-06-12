From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add--interactive: respect diff.algorithm
Date: Wed, 12 Jun 2013 15:18:17 -0400
Message-ID: <20130612191817.GA4898@sigill.intra.peff.net>
References: <20130610142825.GI22905@serenity.lan>
 <7v38sphiiw.fsf@alter.siamese.dyndns.org>
 <20130610211140.GD13333@sigill.intra.peff.net>
 <20130610214638.GK22905@serenity.lan>
 <20130610215656.GA28345@sigill.intra.peff.net>
 <20130612184410.GB23890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 12 21:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmqYs-0002bQ-G9
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 21:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224Ab3FLTSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 15:18:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:39217 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3FLTSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 15:18:22 -0400
Received: (qmail 7373 invoked by uid 102); 12 Jun 2013 19:19:14 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 14:19:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 15:18:17 -0400
Content-Disposition: inline
In-Reply-To: <20130612184410.GB23890@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227666>

On Wed, Jun 12, 2013 at 07:44:10PM +0100, John Keeping wrote:

> When staging hunks interactively it is sometimes useful to use an
> alternative diff algorithm which splits the changes into hunks in a more
> logical manner.  This is not possible because the plumbing commands
> called by add--interactive ignore the "diff.algorithm" configuration
> option (as they should).
> 
> Since add--interactive is a porcelain command it should respect this
> configuration variable.  To do this, make it read diff.algorithm and
> pass its value to the underlying diff-index and diff-files invocations.
> 
> At this point, do not add options to "git add", "git reset" or "git
> checkout" (all of which can call git-add--interactive).  If a user want

s/want/wants/

> >   if (defined $diff_algorithm) {
> >           push @diff_cmd, "--diff-algorithm=$diff_algorithm";
> >   }
> 
> OK.  The "default" is actually "the value that is equivalent to 'myers'
> for diff.algorithm" and I was originally going to add --diff-algorithm
> to the command line unconditionally.

Yeah, that might have made sense, too, but the in-between (we know that
"default" is a special token and don't pass it) does not to me.

Patch looks obviously correct to me. Thanks.

-Peff
