From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Fri, 22 Jun 2012 23:02:32 +0100
Message-ID: <20120622220231.GG25478@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
 <20120622205026.GI32205@arachsys.com>
 <7vobobm3mi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:02:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiBw9-0003oN-LB
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab2FVWCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:02:37 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:60324 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab2FVWCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:02:36 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SiBw2-0002wT-IE; Fri, 22 Jun 2012 23:02:34 +0100
Content-Disposition: inline
In-Reply-To: <7vobobm3mi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200475>

Junio C Hamano <gitster@pobox.com> writes:

[detached unborn HEAD]
> No thanks.  It will be too big a change to the fundamental invariant
> for what a git directory is (and isn't).  It is simply unacceptable
> to suddenly start treating a random directory that does not even
> have HEAD as a git directory.

No problem. I imagine you wouldn't be keen on other representations of the
same state either, e.g. a null sha1 in HEAD, and would prefer to disallow
it altogether?

In that case, would you like me to do a test and a fix for the '(null)'
branch behaviour of

  git checkout --orphan dummy && git checkout --detach

? I assume that can't be intentional: looks from the code like it was
intended to tell me I'm on an unborn branch and can't do that.

> It would be a lot more palatable approach to teach "rebase -i" defer
> its "detaching HEAD to the onto commit" step before starting to read
> the insn sheet.  Would such a change be too involved for it to be
> worth supporting "rebase --root -i"?

I'm not sure as I don't really know the rebase shell scripts well at all,
but I'm happy to take a look and see. I imagine we wouldn't want to make
rebase -i much more complicated (and consequently harder to work on) just to
cover this rarely needed variant, but if it's relatively self-contained
(e.g. detect we're supposed to be making an orphan commit and do it by hand
instead of with git commit, maybe?) it would presumably be worthwhile?

Cheers,

Chris.
