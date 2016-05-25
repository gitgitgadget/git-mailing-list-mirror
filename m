From: Jeff King <peff@peff.net>
Subject: Re: t7610-mergetool.sh test failure
Date: Wed, 25 May 2016 18:16:15 -0500
Message-ID: <20160525231615.GC2634@sigill.intra.peff.net>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 01:16:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5i2J-00005E-Fg
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 01:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcEYXQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 19:16:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:44355 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751931AbcEYXQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 19:16:18 -0400
Received: (qmail 24278 invoked by uid 102); 25 May 2016 23:16:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 19:16:18 -0400
Received: (qmail 15217 invoked by uid 107); 25 May 2016 23:16:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 19:16:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 18:16:15 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295617>

On Tue, May 24, 2016 at 09:45:25AM -0700, Junio C Hamano wrote:

> On Tue, May 24, 2016 at 9:44 AM, Armin Kunaschik
> <megabreit@googlemail.com> wrote:
> > t7610-mergetool.sh fails on systems without mktemp.
> >
> > mktemp is used in git-mergetool.sh and throws an error when it's not available.
> > error: mktemp is needed when 'mergetool.writeToTemp' is true
> >
> > I see 2 options:
> > 1. code around it, write an own mktemp, maybe use the test-mktemp as a basis.
> > 2. disable the test when mktemp is not available
> 
> 3. find and install mktemp?

I'd agree more with (3) if it was some critical part of git-mergetool.
But it seems to be a completely optional feature that we use in only one
place, and git-mergetool even detects this case and complains.

So another alternative would be for the test to detect either that
mergetool worked, or that we got the "mktemp is needed" error.

-Peff
