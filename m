From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Wed, 4 Nov 2009 02:27:09 -0500
Message-ID: <20091104072709.GC24263@coredump.intra.peff.net>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
 <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
 <1257295737457-3942366.post@n2.nabble.com>
 <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
 <1257315478920-3943388.post@n2.nabble.com>
 <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Mazid <timmazid@hotmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:27:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aH1-0007IK-H1
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbZKDH1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbZKDH1I
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:27:08 -0500
Received: from peff.net ([208.65.91.99]:39059 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbZKDH1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:27:07 -0500
Received: (qmail 8430 invoked by uid 107); 4 Nov 2009 07:30:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Nov 2009 02:30:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2009 02:27:09 -0500
Content-Disposition: inline
In-Reply-To: <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132053>

On Wed, Nov 04, 2009 at 07:41:28AM +0100, Sverre Rabbelier wrote:

> On Wed, Nov 4, 2009 at 07:17, Tim Mazid <timmazid@hotmail.com> wrote:
> > So instead of invoking 'git checkout REMOTE/BRANCH', do 'git checkout -b
> > BRANCH REMOTE/BRANCH'.
> 
> Automagically doing 'git checkout -t remote/branch' when asked to do
> 'git checkout remote/branch' was suggested earlier on the list and I
> think there was even a patch that implemented it, not sure what the
> outcome of the series was. I do remember that Peff was annoyed by it
> at the GitTogether though so it might be a bad idea.

It's in 'next' now. And for the record, my complaint about its behavior
turned out to be partially because I was an idiot. I am still not
convinced that we won't later regret leaving the stale local branch
sitting around, or that users won't find it confusing to see:

  $ git checkout foo
  Branch foo set up to track remote branch foo from origin.
  Switched to a new branch 'foo'

  ... time passes ...

  $ git checkout foo
  Switched to branch 'foo'
  Your branch is behind 'origin/foo' by 1 commit, and can be fast-forwarded.

(i.e., you do the same thing, but get two very different results, and
you have to know how to do the fast-forward. Trivial if you are used to
working with branches, but perhaps not if you are just sightseeing).

But I am no longer planning on writing a long-winded rant about the
feature. ;)

-Peff
