From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 17:41:40 -0500
Message-ID: <20120220224140.GA7116@sigill.intra.peff.net>
References: <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
 <20120220143952.GA8387@sigill.intra.peff.net>
 <20120220151134.GA13135@sigill.intra.peff.net>
 <87d3991gyg.fsf@thomas.inf.ethz.ch>
 <20120220203540.GA5966@sigill.intra.peff.net>
 <7v1uppkvpx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbvZ-0007lP-3p
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 23:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab2BTWlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 17:41:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44258
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632Ab2BTWln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 17:41:43 -0500
Received: (qmail 8129 invoked by uid 107); 20 Feb 2012 22:41:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 17:41:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 17:41:40 -0500
Content-Disposition: inline
In-Reply-To: <7v1uppkvpx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191122>

On Mon, Feb 20, 2012 at 02:04:26PM -0800, Junio C Hamano wrote:

> > ... Things may have changed since then, of course, but I at
> > least know that they were sufficient in 34110cd^.
> 
> Looking at where cache_tree_free() is called, I think back then the
> two-way merge was deemed OK, but we did not trust three-way merge or
> merge-recursive at all.

Thanks, I'll take a look more closely at those cases.

> It is OK to check that we do not over-invalidate for performance, but it
> is a lot more important to make sure we do not under-invalidate for
> correctness.  I am a bit worried that you seem to be putting more stress
> on the former.

I think it is just selection bias of the specific parts of his tests
that I was responding to. I completely agree that correctness is way
more important, and I'm also trying to come up with tests to validate
correctness. I just wasn't talking about them there.

I still think replaying real-world test cases is going to be more likely
to find issues in invalidation. I can come up with lots of simple
test-cases, but they're not likely to find anything we wouldn't find in
the code with trivial inspection. I think a combination of careful
analysis and real-world validation is going to be more helpful in the
long run than the kind of simplistic tests that are in t0090.

-Peff
