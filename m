From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Wed, 29 Apr 2015 21:02:56 -0400
Message-ID: <20150430010256.GA5089@peff.net>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
 <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:03:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yncsd-0000D9-AO
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbbD3BC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:02:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:51973 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750883AbbD3BC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:02:59 -0400
Received: (qmail 31575 invoked by uid 102); 30 Apr 2015 01:02:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 20:02:59 -0500
Received: (qmail 476 invoked by uid 107); 30 Apr 2015 01:03:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 21:03:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 21:02:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268040>

On Wed, Apr 29, 2015 at 03:42:57PM -0700, Junio C Hamano wrote:

> > * jk/at-push-sha1 (2015-03-31) 6 commits
> >  - sha1_name: implement @{push} shorthand
> >  - sha1_name: refactor upstream_mark
> >  - remote.c: provide per-branch pushremote name
> >  - remote.c: hoist branch.*.remote lookup out of remote_get_1
> >  - remote.c: drop "remote" pointer from "struct branch"
> >  - remote.c: drop default_remote_name variable
> >
> >  Introduce <branch>@{push} short-hand to denote the remote-tracking
> >  branch that tracks the branch at the remote the <branch> would be
> >  pushed to.
> >
> >  Waiting for a reroll ($gmane/266573).

I re-rolled this and _almost_ sent it out last week. But I noticed that
it gives us only "git rev-parse foo@{push}" and not "git for-each-ref
--format=%(push)" (whereas we have "upstream" for both versions). For
"upstream", computing the answer is simple enough that the tiny bit of
logic is largely duplicated in the two spots. For @{push}, that would be
a bad idea. So I started refactoring the final patch to use the same
logic in both spots, but didn't finish.

I can send the intermediate version (i.e., the re-roll with a few minor
fixups based on list comments), and we can build the other on top, but I
don't think there's any rush, and it can wait for the refactor (which
shouldn't be _too_ bad, I don't think).

-Peff
