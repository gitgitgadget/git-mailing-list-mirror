From: Jeff King <peff@peff.net>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 06:42:33 -0400
Message-ID: <20080703104233.GA26162@sigill.intra.peff.net>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com> <237967ef0807021812r3ccbfbacg2cb6b12358d2ee2e@mail.gmail.com> <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEO2s-0007XG-HM
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759227AbYGCM3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759219AbYGCM3L
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:29:11 -0400
Received: from peff.net ([208.65.91.99]:1818 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759211AbYGCM3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:29:10 -0400
Received: (qmail 2383 invoked by uid 111); 3 Jul 2008 10:42:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 03 Jul 2008 06:42:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2008 06:42:33 -0400
Content-Disposition: inline
In-Reply-To: <93c3eada0807021945la3e565csc50eed4b14feb9c3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87278>

On Thu, Jul 03, 2008 at 12:15:37PM +0930, Geoff Russell wrote:

> >> Is there something that says "since repository creation", ie., go back as far
> >> as possible, but no further? Is there a symbolic name for the initial commit?
> >
> > There's no symbolic name for it, since there might not be only one initial
> > commit. git.git for example has at least three root commits. You will
> > probably get what you want with $(git rev-list HEAD|tail -1). If your
> > history is very large, $(git rev-list --reverse HEAD|head -1) is slightly
> > faster, but usually not enough to offset typing --reverse :).
> 
> Thanks for this, but I'm a little confused.
> 
> If I do a "git init", there must be a first commit after this? Isn't
> this the first commit, how
> can there be more than one first commit?

The confusing part is that you two are talking about two slightly
different things. If you define "initial commit" as "the commit which
has no parents" then there can be many (you get a new one anytime you
merge in a project with unrelated history).

However, what Geoff originally mentioned was HEAD{'7 days ago'}, which
actually looks in the reflog. So if you define "initial commit" as "the
first commit value that this ref ever had" then there is only one
(though of course, your reflog will eventually expire, so it won't be
"the oldest value this ref ever had" but rather "the oldest one the
reflog ever remembers it having").

-Peff
