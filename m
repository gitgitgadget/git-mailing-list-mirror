From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] usage: try harder to format very long error messages
Date: Tue, 11 Aug 2015 14:05:25 -0400
Message-ID: <20150811180524.GB15521@sigill.intra.peff.net>
References: <20150811161752.GA14829@sigill.intra.peff.net>
 <xmqqtws5ss14.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:05:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPDva-0005Vf-QS
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbHKSFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:05:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:43740 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751841AbbHKSF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:05:29 -0400
Received: (qmail 26833 invoked by uid 102); 11 Aug 2015 18:05:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 13:05:29 -0500
Received: (qmail 17540 invoked by uid 107); 11 Aug 2015 18:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 14:05:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 14:05:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtws5ss14.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275703>

On Tue, Aug 11, 2015 at 09:34:31AM -0700, Junio C Hamano wrote:

> > As for vwritef, it exists solely to work over write(), _and_ it doesn't
> > get the "one-shot" thing right (which is probably OK, as we use it only
> > when exec fails). But we could probably teach run-command to fdopen(),
> > and get rid of it entirely (in favor of teaching vreportf to take a
> > FILE* handle instead of assuming stderr).
> 
> Sounds like a plan ;-)

So here's an alternative series that does this, along with the
single-fprintf thing I mentioned. The first patch is actually orthogonal
to the second; we would probably want it whichever path we choose to fix
vreportf's truncation (I'd just have to rebase the earlier patch on top
of it if we go that route).

  [1/2]: vreportf: report to arbitrary filehandles
  [2/2]: vreportf: avoid intermediate buffer

-Peff
