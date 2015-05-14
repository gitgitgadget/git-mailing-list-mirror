From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rerere: exit silently on "forget" when rerere is disabled
Date: Thu, 14 May 2015 16:22:07 -0400
Message-ID: <20150514202207.GA13541@peff.net>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
 <xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
 <20150514191637.GA9329@peff.net>
 <xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
 <20150514192052.GB9329@peff.net>
 <xmqqmw17j6oh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Coppens <alex@nativetouch.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:22:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysze5-0000vI-Ef
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbbENUWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:22:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:58799 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964879AbbENUWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:22:11 -0400
Received: (qmail 24209 invoked by uid 102); 14 May 2015 20:22:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 15:22:11 -0500
Received: (qmail 27309 invoked by uid 107); 14 May 2015 20:22:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 16:22:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 16:22:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw17j6oh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269084>

On Thu, May 14, 2015 at 12:33:02PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, May 14, 2015 at 12:19:25PM -0700, Junio C Hamano wrote:
> >
> >> > It looks like we need to pay more attention to the return value of
> >> > setup_rerere, which is what is supposed to take the lock.
> >> 
> >> Good spotting.  The normal rerere does check, but rerere-forget
> >> codepath seems to forget it.
> >
> > Here's a patch.
> 
> Thanks.  This is obviously correct to fix your "init -q" one.
> 
> I am still puzzled by the original, though.  I assumed that rerere
> was enabled and working correctly (in the sense that it correctly
> replayed a mistaken resolution recorded earlier, which Alex wanted
> to correct by forgetting).

Yeah, agreed. I don't see any other code paths that could end up trying
to commit a lock we haven't taken, though.

Alex, can you tell us more about your repository? And possibly show us
the output of:

  ls -d .git/rr-cache
  git config rerere.enabled

in the repository?

-Peff
