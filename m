From: Jeff King <peff@peff.net>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 16:33:09 -0500
Message-ID: <20110118213309.GA933@sigill.intra.peff.net>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
 <201101181744.18139.trast@student.ethz.ch>
 <20110118185027.GA10562@sigill.intra.peff.net>
 <201101182139.28808.trast@student.ethz.ch>
 <20110118205040.GA20970@sigill.intra.peff.net>
 <7vsjwpkio8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Sebastian Hahn <mail@sebastianhahn.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 22:33:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJAz-0005FS-OB
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1ARVdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 16:33:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37489 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406Ab1ARVdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:33:12 -0500
Received: (qmail 32467 invoked by uid 111); 18 Jan 2011 21:33:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 18 Jan 2011 21:33:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jan 2011 16:33:09 -0500
Content-Disposition: inline
In-Reply-To: <7vsjwpkio8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165222>

On Tue, Jan 18, 2011 at 01:26:15PM -0800, Junio C Hamano wrote:

> Honestly, my guess is that the interaction of -S with a merge commit is
> "whatever the code happens to do", as I didn't think nor design how they
> should interact with each other when I wrote -c/--cc nor when I wrote -S.

That's kind of what I figured.

> Having said that, I tend to agree with your latter expectation ("what I
> want").

I'll take a look and see how painful it will be to do that. I'm not even
sure how the merge filepairs are represented by the diff code (since
they are not even pairs, but rather one child with many parents).

> By the way, you guys should really not be looking at the disused
> plumbing-helper -S but instead be advocating its newer and more human
> friendly cousin -G.  1.7.4 is coming ;-).

It's _way_ slower for simple things:

  $ time git log -Sfoo >/dev/null
  real    0m11.550s
  user    0m11.409s
  sys     0m0.116s

  $ time git log -Gfoo >/dev/null
  real    0m25.722s
  user    0m25.442s
  sys     0m0.220s

I for one really like the -S behavior, anyway, but I expect I am in the
minority.

-Peff
