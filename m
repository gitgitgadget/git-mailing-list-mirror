From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ewah/bitmap: silence warning about MASK macro
 redefinition
Date: Wed, 3 Jun 2015 02:38:13 -0400
Message-ID: <20150603063812.GA21319@peff.net>
References: <1433281675-24893-1-git-send-email-sunshine@sunshineco.com>
 <xmqqegltzriq.fsf@gitster.dls.corp.google.com>
 <20150603045117.GC15989@peff.net>
 <CAPig+cR3Xt5FNSYbDPhW=m5aEOMq8mCLRSe+mjYfVvdS0R382A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Jp-0004AC-Dc
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbbFCGiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:38:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:40195 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbbFCGiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:38:16 -0400
Received: (qmail 7197 invoked by uid 102); 3 Jun 2015 06:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 01:38:15 -0500
Received: (qmail 16672 invoked by uid 107); 3 Jun 2015 06:38:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 02:38:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 02:38:13 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cR3Xt5FNSYbDPhW=m5aEOMq8mCLRSe+mjYfVvdS0R382A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270632>

On Wed, Jun 03, 2015 at 02:28:10AM -0400, Eric Sunshine wrote:

> On Wed, Jun 3, 2015 at 12:51 AM, Jeff King <peff@peff.net> wrote:
> > Subject: [PATCH] ewah: use less generic macro names
> >
> > The ewah/ewok.h header pollutes the global namespace with
> > "BITS_IN_WORD", without any specific notion that we are
> > talking about the bits in an eword_t. We can give this the
> > more specific name "BITS_IN_EWORD".
> >
> > Likewise, ewah/bitmap.c uses the generic MASK and BLOCK
> > macro names. These are local to the .c file, but we have the
> > opposite problem: on PowerPC Mac OS X (10.5.8 "Leopard" with
> > Xcode 3.1), system header /usr/include/ppc/param.h[1]
> 
> The [1] has no meaning anymore, so: s/\[1\]//

Oops, I meant to include your footnote.

> > I'm also happy to split it into two patches, and make Eric the author on
> > the MASK part.
> 
> I don't mind being an author of a patch, so splitting works for me,
> however, I'm also fine with whatever you and Junio prefer. (And, in
> retrospect, I agree that renaming the macros here is preferable over
> the #undef approach.)

After reflecting, I think splitting it into two patches makes more
sense. I mostly noticed that we were touching the same lines, but of
course it is not a problem to have two related patches in order. :)

So here is what I propose:

  [1/2]: ewah/bitmap: silence warning about MASK macro redefinition
  [2/2]: ewah: use less generic macro name

I put yours first, because it solves an actual problem. We can drop 2/2
if we decide it's just churn.

-Peff
