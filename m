From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix t3701 if core.filemode disabled
Date: Thu, 22 May 2008 13:55:52 -0400
Message-ID: <20080522175552.GA14391@sigill.intra.peff.net>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net> <20080518200121.GA5789@steel.home> <20080519202342.GA9694@steel.home> <20080519205550.GA24246@sigill.intra.peff.net> <20080520215932.GB10437@steel.home> <20080521143607.GA3575@sigill.intra.peff.net> <20080522132042.GF3206@steel.home> <7vzlqiut4a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzF28-0007ow-Iv
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbYEVRz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 13:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbYEVRz5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 13:55:57 -0400
Received: from peff.net ([208.65.91.99]:4911 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423AbYEVRz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 13:55:56 -0400
Received: (qmail 10603 invoked by uid 111); 22 May 2008 17:55:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 May 2008 13:55:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2008 13:55:52 -0400
Content-Disposition: inline
In-Reply-To: <7vzlqiut4a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82643>

On Thu, May 22, 2008 at 10:49:09AM -0700, Junio C Hamano wrote:

> > But a nice one. I like the idea but Junio already did your other
> > suggestions in master, so I just keep it in mind for the next one
> 
> If you like that, I think you would like the way t0050 does even better
> ;-).  It is Steffen Prohaska's invention, IIRC.

Well, you can't test_expect_failure with it. :)

Though I think it is actually nice to mention which tests are being
skipped (something I asked for in point 3 of my other message, but which
contradicts the example I gave in point 2 of the same message :) ).

So something like:

have_foo=
test_foo() {
  case "$have_foo" in
    t) test_expect_success "$@"
    *) say "skipping test $1 (don't have foo)"
  esac
}

test_expect_success 'see if we have foo' '
  if magic_foo_test; then
    have_foo=t
  fi || true
'
test_foo 'use foo' '...'

-Peff
