From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 5/5] git-send-email: use git credential to obtain
 password
Date: Mon, 11 Feb 2013 12:31:35 -0500
Message-ID: <20130211173135.GI16402@sigill.intra.peff.net>
References: <cover.1360599057.git.mina86@mina86.com>
 <fd7997960cad569d57f5330f2416f702db414169.1360599712.git.mina86@mina86.com>
 <20130211170134.GE16402@sigill.intra.peff.net>
 <xa1tmwvag47s.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mina86@mina86.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4xEY-0005vV-B8
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222Ab3BKRbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:31:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44403 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758191Ab3BKRbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:31:38 -0500
Received: (qmail 24282 invoked by uid 107); 11 Feb 2013 17:33:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 12:33:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 12:31:35 -0500
Content-Disposition: inline
In-Reply-To: <xa1tmwvag47s.fsf@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216066>

On Mon, Feb 11, 2013 at 06:17:27PM +0100, Michal Nazarewicz wrote:

> > I am happy to put it off until it becomes a problem, but I wonder if the
> > Git::credential() interface is sufficient to express what we would want.
> > It only allows two return values: true for approve, false for reject.
> > But we would want a tri-state: approve, reject, indeterminate.
> 
> Being it tri-state is not a problem.  The last can be easily represented
> by undef.

Yeah, I think undef makes sense there.

> > Reading the Net::SMTP code, it doesn't look like the information is even
> > available to us (it really just passes out success or failure), so I
> > don't think we can even make it work now. But it may be better to
> > prepare the public Git::credential interface for it now, so we do not
> > have to deal with breaking compatibility later.
> 
> I guess.  I left it as is since git-send-email won't make use of the
> indeterminate values, but I can add it in this patchset as well.

Yeah, I am more worried about third-party uses outside of the Git tree,
which we may then break if we change the meaning of "undef" later.
Thanks.

-Peff
