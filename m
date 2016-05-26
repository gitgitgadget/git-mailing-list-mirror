From: Jeff King <peff@peff.net>
Subject: Re: t7610-mergetool.sh test failure
Date: Wed, 25 May 2016 20:51:14 -0500
Message-ID: <20160526015114.GA12851@sigill.intra.peff.net>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 03:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5kSK-0007Et-SC
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 03:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbcEZBvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 21:51:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:44404 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752349AbcEZBvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 21:51:19 -0400
Received: (qmail 31006 invoked by uid 102); 26 May 2016 01:51:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 21:51:18 -0400
Received: (qmail 15825 invoked by uid 107); 26 May 2016 01:51:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 21:51:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 20:51:14 -0500
Content-Disposition: inline
In-Reply-To: <20160525231615.GC2634@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295626>

On Wed, May 25, 2016 at 06:16:15PM -0500, Jeff King wrote:

> On Tue, May 24, 2016 at 09:45:25AM -0700, Junio C Hamano wrote:
> 
> > On Tue, May 24, 2016 at 9:44 AM, Armin Kunaschik
> > <megabreit@googlemail.com> wrote:
> > > t7610-mergetool.sh fails on systems without mktemp.
> > >
> > > mktemp is used in git-mergetool.sh and throws an error when it's not available.
> > > error: mktemp is needed when 'mergetool.writeToTemp' is true
> > >
> > > I see 2 options:
> > > 1. code around it, write an own mktemp, maybe use the test-mktemp as a basis.
> > > 2. disable the test when mktemp is not available
> > 
> > 3. find and install mktemp?
> 
> I'd agree more with (3) if it was some critical part of git-mergetool.
> But it seems to be a completely optional feature that we use in only one
> place, and git-mergetool even detects this case and complains.
> 
> So another alternative would be for the test to detect either that
> mergetool worked, or that we got the "mktemp is needed" error.

BTW, one thing I happened to note while looking at this: running the
test script will write into /tmp (or wherever your $TMPDIR points).
Probably not a big deal, but I wonder if we should be setting $TMPDIR in
our test harness.

-Peff
