From: Jeff King <peff@peff.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 16:23:56 -0400
Message-ID: <20110414202356.GB6525@sigill.intra.peff.net>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:24:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAT5B-0006yZ-Nt
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab1DNUX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:23:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42308
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308Ab1DNUX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:23:59 -0400
Received: (qmail 3115 invoked by uid 107); 14 Apr 2011 20:24:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 16:24:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 16:23:56 -0400
Content-Disposition: inline
In-Reply-To: <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171546>

On Thu, Apr 14, 2011 at 01:06:19PM -0700, Junio C Hamano wrote:

> Instead, I think we should just use "Binary blob $SHA-1\n" as if that is
> the textconv of a binary file without textconv filter.  That would
> certainly make the code much simpler, and more importantly, the output
> would become more pleasant. We would show something like:
> 
>     - Binary blob bc3c57058faba66f6a7a947e1e9642f47053b5bb
>      -Binary blob 536e55524db72bd2acf175208aef4f3dfc148d42
>     ++Binary blob 67cfeb2016b24df1cb406c18145efd399f6a1792
> 
> if we did so.

Yeah, I think that is pretty readable. But it gives me a funny feeling
to encode magic strings inside actual diff output. That is, the output
is indistinguishable from a file which contained the "Binary blob..."
strings.

I can't think of a case where it matters, though, so maybe it is just
paranoia.

We do something similar for textconv, of course, but we always knew that
was a human-only thing, and it isn't enabled for plumbing commands. This
would be.

-Peff
