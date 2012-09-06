From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Prefix shell test output messages with test id
Date: Thu, 6 Sep 2012 11:10:08 -0400
Message-ID: <20120906151008.GA7407@sigill.intra.peff.net>
References: <1346931921-5901-1-git-send-email-glogow@fbihome.de>
 <20120906123400.GA25467@tommy-fedora.scientificnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
To: Jan-Marek Glogowski <glogow@fbihome.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:10:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dim-0007fC-I9
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 17:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab2IFPKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 11:10:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59870 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756813Ab2IFPKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 11:10:11 -0400
Received: (qmail 22086 invoked by uid 107); 6 Sep 2012 15:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Sep 2012 11:10:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2012 11:10:08 -0400
Content-Disposition: inline
In-Reply-To: <20120906123400.GA25467@tommy-fedora.scientificnet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204895>

On Thu, Sep 06, 2012 at 02:34:00PM +0200, Thomas Gummerer wrote:

> On 09/06, Jan-Marek Glogowski wrote:
> > This adds the test ID (tXXXX) prefix to the test result message of
> > all shell tests.  This is especially useful when doing a parallel
> > check run, where it's currently quite hard to identify the actual
> > failing test case.
> > 
> > Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> 
> This breaks the TAP output format of the tests, which is needed to run
> them with prove.  To identify the failing tests more easily when running
> the tests in parallel, you may want to add GIT_TEST_TARGET = prove to
> your config.mak.

Yeah, I would second the suggestion to just use "prove". However, if for
some reason that isn't an option, note that the stock harness stores
results in test-results/. You can just grep it like this:

  grep 'failed [^0]' test-results/*

to find out which scripts had failures, which is usually sufficient (if
you're running the tests in parallel, you won't have any sensible output
anyway, so your first step is going to be to rerun the failed script
with "-v" anyway).

But really, "prove" is much nicer, and I recommend it unless you don't
have perl on your system.

-Peff
