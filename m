From: Jeff King <peff@peff.net>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 11:43:19 -0500
Message-ID: <20091123164319.GA23011@sigill.intra.peff.net>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <20091123155043.GA28963@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: bill lam <cbill.lam@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 23 17:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCc0g-0001br-KA
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 17:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbZKWQnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 11:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbZKWQnP
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 11:43:15 -0500
Received: from peff.net ([208.65.91.99]:54053 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009AbZKWQnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 11:43:14 -0500
Received: (qmail 3384 invoked by uid 107); 23 Nov 2009 16:47:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 23 Nov 2009 11:47:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2009 11:43:19 -0500
Content-Disposition: inline
In-Reply-To: <20091123155043.GA28963@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133508>

On Mon, Nov 23, 2009 at 04:50:43PM +0100, Petr Baudis wrote:

> On Mon, Nov 23, 2009 at 10:00:00AM -0500, Jeff King wrote:
> > The patch for (1) would look something like what's below.  It's simpler,
> > but it does change the semantics; anyone who was relying on
> > --all-progress to turn on progress unconditionally would need to now
> > also use --progress. However, turning on progress unconditionally is
> > usually an error (the except is if you are piping output in real-time to
> > the user and need to overcome the isatty check).
> 
> I'm actually doing exactly that in the mirrorproj.cgi of Girocco, so I
> would be unhappy if I would have to go through creating ptys or whatever
> now. Maybe conditioning this by an environment variable?

You wouldn't need to do anything that drastic. You would just need to
pass "--progress --all-progress" instead of only --all-progress. But you
have provided the data point that such a change would break at least one
user.

We could also leave --all-progress as-is and add new option to mean "if
you are already doing progress, do all progress".

-Peff
