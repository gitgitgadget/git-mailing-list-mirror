From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 16:29:30 -0400
Message-ID: <20120524202930.GB18936@sigill.intra.peff.net>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
 <7v62blxx2m.fsf@alter.siamese.dyndns.org>
 <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 22:29:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXefB-0002VN-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab2EXU3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:29:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54194
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab2EXU3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:29:33 -0400
Received: (qmail 32081 invoked by uid 107); 24 May 2012 20:29:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 16:29:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 16:29:30 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198417>

On Thu, May 24, 2012 at 12:33:08PM -0700, Shawn O. Pearce wrote:

> $ (for i in {1..5}; do time git ls-remote
> persistent-https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
> >/dev/null;done) 2>&1 | grep real
> real	0m0.208s
> real	0m0.085s
> real	0m0.079s
> real	0m0.067s
> real	0m0.059s

Nice numbers. And as clever as I find this helper-wrapping-a-helper
solution, I wonder if the right layer for a fix isn't inside curl. It
already keeps an ssl session-id cache in memory; how hard would it be to
turn that into an on-disk cache?

I don't think that is grounds for rejecting this patch; obviously it is
working for you guys, and it is available right now, and it is only
going into contrib/ anyway. But a curl solution seems like a cleaner
long-term fix, and would benefit all curl users. It is even mentioned in
curl's doc/TODO file. :)

-Peff
