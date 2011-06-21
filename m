From: Jeff King <peff@peff.net>
Subject: Re: POSIX woes in t7810.87: dash bash or bash dash?
Date: Mon, 20 Jun 2011 20:21:14 -0400
Message-ID: <20110621002114.GA2050@sigill.intra.peff.net>
References: <4DFF19C4.5070003@drmicha.warpmail.net>
 <7voc1sb2hr.fsf@alter.siamese.dyndns.org>
 <20110620232425.GA617@sigill.intra.peff.net>
 <7vwrgg9j1n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 02:21:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYoiY-0000EQ-Go
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 02:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab1FUAVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 20:21:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756492Ab1FUAVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 20:21:16 -0400
Received: (qmail 29683 invoked by uid 107); 21 Jun 2011 00:21:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 20:21:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 20:21:14 -0400
Content-Disposition: inline
In-Reply-To: <7vwrgg9j1n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176114>

On Mon, Jun 20, 2011 at 04:31:32PM -0700, Junio C Hamano wrote:

> >> +	cat >expected <<-EOF &&
> >> +	hello.c:	printf("Hello world.\n");
> >> +	EOF
> >
> > Do you need to quote EOF to suppress expansion in the here document?
> > Both bash and dash seem to pass unknown backslash-escapes like "\n"
> > through unharmed, but I don't know if that is portable (they do both
> > munge known escapes like "\\", of course).
> 
> I do not think that is strictly necessary, as we are not in the corner of
> non-portable echo behaviour anymore, but I guess it wouldn't hurt.

I think my brain is fried from using too many almost-shell-compatible
quoting languages. For example, unknown escape sequences in C get their
backslash removed and the sequence used literally (at least by gcc; I
couldn't find anything definite in C99 on this).

But actually, POSIX is quite clear that a backslash before anything
besides:

  $   `   "   \   <newline>

is just a backslash, and gets included literally.

-Peff
