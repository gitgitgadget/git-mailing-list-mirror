From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 15:59:34 -0500
Message-ID: <20110207205934.GD13461@sigill.intra.peff.net>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:59:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYBU-0007pO-8U
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab1BGU7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:59:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35439 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab1BGU7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:59:38 -0500
Received: (qmail 30576 invoked by uid 111); 7 Feb 2011 20:59:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 20:59:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 15:59:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1102062234010.3788@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166292>

On Mon, Feb 07, 2011 at 06:01:51AM -0500, Martin von Zweigbergk wrote:

> 'git checkout refs/heads/foo' (or 'git checkout heads/foo' for that
> matter) does not check out the branch, but instead detaches HEAD at
> foo. This is quite counter-intuitive (at least to me) and the same
> functionality can be achieved by using e.g. foo~0. Change the behavior
> so that the branch is actually checked out. This also applies to
> e.g. 'git rebase master refs/heads/topic', which currently rebases a
> detached HEAD. There are probably other examples as well that I'm not
> aware of.

I have seen that behavior claimed as intentional, but I agree it is
unintuitive. In most other places referring to a ref by a short name or
a fully qualified name is equivalent (except with respect to
disambiguating short names, of course).

> Existing scripts may depend on the current behavior. It seems unlikely
> that many users depend on it. Most likely, they use foo~0 or foo^0
> instead.

As cool and clever as the foo^0 behavior is once you understand it, I
think it is a horribly confusing thing for non-experts. As part of this
proposal, should we perhaps offer "git checkout --detach" as the
easy-on-the-eyes way of intentionally detaching?

-Peff
