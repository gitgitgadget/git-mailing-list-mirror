From: Jeff King <peff@peff.net>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Fri, 3 Jun 2011 01:09:01 -0400
Message-ID: <20110603050901.GA883@sigill.intra.peff.net>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <20110601220518.GA32681@sigill.intra.peff.net>
 <7vipspfazy.fsf@alter.siamese.dyndns.org>
 <20110601224754.GA16820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 07:09:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSMdG-0007Rk-E8
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 07:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab1FCFJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 01:09:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35892
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab1FCFJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 01:09:06 -0400
Received: (qmail 4242 invoked by uid 107); 3 Jun 2011 05:09:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 01:09:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 01:09:01 -0400
Content-Disposition: inline
In-Reply-To: <20110601224754.GA16820@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174996>

On Wed, Jun 01, 2011 at 06:47:54PM -0400, Jeff King wrote:

> I wrote some tests that document what I think _should_ happen. In
> addition to this bug, there's one other (the second in my list below).
> 
> I'm done for the day, but may take a look at actually fixing these
> tomorrow.
> 
> -- >8 --
> Subject: [PATCH] t: add tests for cloning remotes with detached HEAD

So this turned out to be a tiny amount of code, which is nice. And all
of the "clone should fetch HEAD" bits stay inside builtin/clone.c, which
gives me warm fuzzies that my change will not accidentally break regular
fetches.

Unfortunately, there's a test failure in t5800; apparently our
git-remote-testgit helper does not like us fetching HEAD. I haven't
figured out if it's a bug in the helper, or if this will be a problem in
general with remote helpers. More details in 3/3.

  [1/3]: t: add tests for cloning remotes with detached HEAD
  [2/3]: consider only branches in guess_remote_head
  [3/3]: clone: always fetch remote HEAD

-Peff
