From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 14:28:55 -0400
Message-ID: <20120620182855.GA26948@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
 <20120620163714.GB12856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:29:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPeS-0002Zx-0K
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab2FTS3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:29:02 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:38979
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407Ab2FTS27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:28:59 -0400
Received: (qmail 26668 invoked by uid 107); 20 Jun 2012 18:28:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 14:28:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 14:28:55 -0400
Content-Disposition: inline
In-Reply-To: <20120620163714.GB12856@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200316>

On Wed, Jun 20, 2012 at 12:37:14PM -0400, Jeff King wrote:

> > But suggesting that we are supposed to ignore the FORCE just leaves
> > the reader wondering why the same patch does not also urgently need
> > to make additional changes such as the following, no?
> > 
> > 	builtin/branch.o builtin/checkout.o builtin/clone.o \
> > 	builtin/reset.o branch.o transport.o: branch.h
> > 
> > to
> > 
> > 	builtin/branch.sp builtin/branch.o builtin/branch.s \
> > [...]
> 
> Those lines were not updated because I did not notice them, as I was
> keeping the scope of the updates to generated headers and files like
> GIT-CFLAGS. IOW, my patch is a step in what I think is the right
> direction, but it does not remove all issues, only one class of them.
> 
> As a side note, I have to wonder if those lines are really worthwhile.
> [...]

Here's an updated series that drops these lines and I hope will address
the commit message issues you brought up:

  [01/11]: Makefile: sort LIB_H list
  [02/11]: Makefile: fold MISC_H into LIB_H

New in this iteration to get rid of these largely pointless manual
dependencies.

  [03/11]: Makefile: do not have git.o depend on common-cmds.h

New in this iteration.  I noticed while double-checking that this
dependency is pointless.

  [04/11]: Makefile: apply dependencies consistently to sparse/asm targets

Updated based on earlier patches, and with a new commit message
explaining a little more of what's going on.

  [05/11]: Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
  [06/11]: Makefile: split GIT_USER_AGENT from GIT-CFLAGS
  [07/11]: Makefile: split prefix flags from GIT-CFLAGS
  [08/11]: Makefile: do not replace @@GIT_VERSION@@ in shell scripts
  [09/11]: Makefile: update scripts when build-time parameters change
  [10/11]: Makefile: build instaweb similar to other scripts
  [11/11]: Makefile: move GIT-VERSION-FILE dependencies closer to use

The rest are largely the same, but with a few minor textual updates to
accomodate the earlier changes.

-Peff
