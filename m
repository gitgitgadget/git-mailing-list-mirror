From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 07:55:45 -0400
Message-ID: <20130321115545.GB21319@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <514AF2E1.7020409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 12:56:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIe6W-0001fs-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 12:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723Ab3CULzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 07:55:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33712 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254Ab3CULzw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 07:55:52 -0400
Received: (qmail 21553 invoked by uid 107); 21 Mar 2013 11:57:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 07:57:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 07:55:45 -0400
Content-Disposition: inline
In-Reply-To: <514AF2E1.7020409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218713>

On Thu, Mar 21, 2013 at 12:45:37PM +0100, Johannes Sixt wrote:

> Am 3/21/2013 12:03, schrieb Jeff King:
> > I was fooling around with clang and noticed that it complains about the
> > "int x = x" construct under -Wall. That is IMHO a deficiency in clang,
> > since the idiom has a well-defined use in silencing -Wuninitialized
> > warnings.
> 
> IMO, that's a myth. The construct invokes undefined behavior at least
> since C99, and the compilers are right to complain about it.

While undefined behavior does leave the compiler free to do anything,
including nasal demons, it would be a very poor implementation that did
anything except leave random bytes in the value. And it also means that
gcc is free to take it as a hint to silence the warning; given that
clang tries to be compatible with gcc, I'd think it would want to do the
same. But I may be wrong that the behavior from gcc is intentional or
common (see below).

> But you might just say that standards are not worth the paper they are
> printed on, and you may possibly be right for practical reasons. But I
> still consider it a myth that "int x = x" is an idiom. I'm in the C
> business since more than 25 years, and the first time I saw the "idiom"
> was in git code. Is there any evidence that the construct is used
> elsewhere? Have I been in the wrong corner of the C world for such a long
> time?

Git code was my introduction to it, too, and I was led to believe it was
idiomatic, so I can't speak further on that. I think it was Junio who
introduced me to it, so maybe he can shed more light on the history.

-Peff
