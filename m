From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Thu, 17 Dec 2015 23:02:10 -0500
Message-ID: <20151218040210.GA9585@sigill.intra.peff.net>
References: <20151216032639.GA1901@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Fri Dec 18 05:02:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9mFP-0003IX-S2
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 05:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbbLRECN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 23:02:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:44111 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753121AbbLRECN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 23:02:13 -0500
Received: (qmail 14766 invoked by uid 102); 18 Dec 2015 04:02:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 22:02:13 -0600
Received: (qmail 21012 invoked by uid 107); 18 Dec 2015 04:02:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 23:02:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 23:02:10 -0500
Content-Disposition: inline
In-Reply-To: <20151216032639.GA1901@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282698>

On Tue, Dec 15, 2015 at 10:26:39PM -0500, Santiago Torres wrote:

> An example of a malicious commit merge follows:
> 
> 1) The attacker controlling or acting as the upstream server identifies
> two branches: one in which the unsuspecting developer is working on, and
> another in which a vulnerable piece of code is located.

One thing to make clear here: the side branch with the vulnerable code
must be a _new_ vulnerability that was not already part of the "main"
branch the developer is working on. That is, I do not immediately see a
way to resurrect an old vulnerability, because a merge of the old,
broken commit would not result in reintroducing it.

This is more about "there was experimental junk on branch X, and you
tricked some developer into pulling X onto Y, and now Y unexpectedly has
the junk on it". And I agree with Stefan that push-certs are the
intended defense against this.

Of course, in the real world things are much easier. Most projects do
not sign commits at all, let alone use push certs. If developers are
pulling from a compromised server, then you can simply make up whatever
broken commits you want, and there's no way to tell the difference
between them and the real commits.

-Peff
