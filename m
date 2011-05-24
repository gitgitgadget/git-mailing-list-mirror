From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow built-ins to also use -c var=val via alias
Date: Tue, 24 May 2011 18:49:03 -0400
Message-ID: <20110524224903.GA16265@sigill.intra.peff.net>
References: <7vsjs37qcp.fsf@alter.siamese.dyndns.org>
 <7vmxib7q79.fsf@alter.siamese.dyndns.org>
 <20110524214618.GA17727@sigill.intra.peff.net>
 <20110524215202.GA22243@sigill.intra.peff.net>
 <20110524215759.GA24298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:49:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0PY-0003yI-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 00:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab1EXWtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 18:49:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36204
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab1EXWtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 18:49:06 -0400
Received: (qmail 22664 invoked by uid 107); 24 May 2011 22:49:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 18:49:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 18:49:03 -0400
Content-Disposition: inline
In-Reply-To: <20110524215759.GA24298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174354>

On Tue, May 24, 2011 at 05:57:59PM -0400, Jeff King wrote:

> On Tue, May 24, 2011 at 05:52:02PM -0400, Jeff King wrote:
> 
> > On Tue, May 24, 2011 at 05:46:18PM -0400, Jeff King wrote:
> > 
> > > I think the right fix is simply to drop the "don't re-check the
> > > environment after the first time" logic. It's not expensive to parse
> > > compared to parsing config files, which is when we would do it. We can
> > > just drop the existing list and reparse. You can even get rid of the
> > > whole list and drop a bunch of code, I think, like:
> > 
> > Ack, wrong patch. That one doesn't even come close to compiling.
> > 
> > Try this (still not well tested, though).
> 
> Ugh, broken. That will teach me to just paste any random junk into my
> MUA. Hopefully you got the gist of what I was trying to say, but let me
> come up with a more readable and tested series.

OK, for real this time. This is how I would do the whole fix on top of
master, including your 1/2. I'll let you handle the
apply-to-maint-and-merge as you would have with your original series.

The first two are refactoring to make 3/4 a little easier to read. The
third one is my fix, and the fourth is your original patch (together
with my 3/4 it passes the test; btw, I ended up writing a slightly
simpler test. Feel free to throw it out if you prefer yours).

  [1/4]: config: make environment parsing routines static
  [2/4]: git_config: don't peek at global config_parameters
  [3/4]: config: always parse GIT_CONFIG_PARAMETERS during git_config
  [4/4]: handle_options(): do not miscount how many arguments were used

-Peff
