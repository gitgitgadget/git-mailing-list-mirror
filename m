From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Mon, 9 Jun 2008 08:29:38 -0400
Message-ID: <20080609122938.GA12210@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806090032.27516.trast@student.ethz.ch> <alpine.DEB.1.00.0806090018350.1783@racer> <200806090746.22512.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 14:31:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5gWc-0004sd-6L
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 14:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbYFIM3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 08:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbYFIM3l
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 08:29:41 -0400
Received: from peff.net ([208.65.91.99]:1908 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbYFIM3l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 08:29:41 -0400
Received: (qmail 9752 invoked by uid 111); 9 Jun 2008 12:29:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 09 Jun 2008 08:29:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2008 08:29:38 -0400
Content-Disposition: inline
In-Reply-To: <200806090746.22512.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84379>

On Mon, Jun 09, 2008 at 07:46:22AM +0200, Johan Herland wrote:

> Is there a good reason against having *both*?
> 
> AFAICS, there's nothing stopping us from having both a "-e"-option to 
> git-add, and an "e"-command inside git-add--interactive.

I agree (and I tried to make that point in an earlier mail).

And I was hoping the right way to do it was to simply build the
interactive "e" command on top of Johannes' git-apply work. But I don't
think that quite makes sense. His work is about fixing up the hunk
header as we apply the patch, but a working "e" command in the hunk
selection should probably not actually apply, but simply split into two
hunks for the loop.

> ("git-add -e" would open the entire diff in an editor, as would "e" from the 
> *main* menu of git-add--interactive. However, "e" from the *single hunk* 
> menu would of course open only that single hunk within the editor. We could 
> even have an "E" command to open all remaining/undecided hunks in an 
> editor.)

I agree with all of this, though I think the big question is what
happens to the edited portion. In the interactive command, I think it
becomes a new hunk that can be staged or not. In "git add -e" it makes
sense to simply stage the result.

-Peff
