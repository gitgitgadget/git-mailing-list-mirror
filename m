From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt
	restriction.
Date: Mon, 17 Dec 2007 15:31:43 -0500
Message-ID: <20071217203143.GA2105@coredump.intra.peff.net>
References: <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:32:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MdI-0002ly-JS
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059AbXLQUbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756854AbXLQUbq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:31:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2170 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757428AbXLQUbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:31:46 -0500
Received: (qmail 12972 invoked by uid 111); 17 Dec 2007 20:31:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 15:31:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 15:31:43 -0500
Content-Disposition: inline
In-Reply-To: <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68613>

On Mon, Dec 17, 2007 at 11:52:29AM -0800, Junio C Hamano wrote:

> So in short, for an option that takes optional option-argument:

I agree with everything you said, except...

>    - if it is given as "--long-name", and there is a next word, see if
>      that is plausible as its argument.  Get it and signal the caller
>      you consumed it, if it is.  Ignore it and signal the caller you
>      didn't, if it isn't.

This "plausible" makes me a little nervous, and I wonder why we want to
support this at all. Is it

  1. We have traditionally supported "--abbrev 10"? I don't think this
     is the case.
  2. Consistency with "--non-optional-arg foo"? Do we have any such
     non-optional long arguments? I didn't see any; I think we stick
     with --non-optional-arg=foo everywhere.
  3. More convenience to the user? I don't see how " " is easier than
     "=".

>    - if it is given as "-s", and there is a next word, and if the option
>      has long format counterpart as well, then see if the next word is
>      plausible as its argument.  Get it and signal the caller you
>      consumed it, if it is.  Ignore it and signal the caller you didn't,
>      if it isn't.

Similarly, what is the goal here?

  1. Have we ever supported "-s foo"? Not for -B/-M/-C, nor for
     shortlog's -w.
  2. This would add consistency to non-optional arguments.
  3. It's longer to type.

So I see a slight case for "-s foo", but none at all for "--long foo".

-Peff
