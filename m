From: Jeff King <peff@peff.net>
Subject: Re: Merge conflicts are reported relative to root not cwd
Date: Wed, 13 Apr 2016 18:41:29 -0400
Message-ID: <20160413224129.GC10011@sigill.intra.peff.net>
References: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com>
 <xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZSyLZxMXSSv=uDpuA0zTUy6nU4vwEF5f7WLhoRp1hXig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:41:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTTc-000722-N6
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbcDMWld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:41:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:49139 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942AbcDMWlc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:41:32 -0400
Received: (qmail 8425 invoked by uid 102); 13 Apr 2016 22:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:41:32 -0400
Received: (qmail 23515 invoked by uid 107); 13 Apr 2016 22:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:41:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Apr 2016 18:41:29 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZSyLZxMXSSv=uDpuA0zTUy6nU4vwEF5f7WLhoRp1hXig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291506>

On Wed, Apr 13, 2016 at 03:18:24PM -0700, Stefan Beller wrote:

> * This is your preference for whole-tree operations. What are
>    whole-tree operations? (Is there a concise definition?
>    Are submodules whole tree operations?)
>    These questions are motivated by origin/sb/submodule-path-misc-bugs
>    which a) fixes bugs and b) makes submodule handling consistent to the
>    relative-to-cwd philosophy. As most submodule commands touch all
>    submodules in the tree, we could argue it is a whole-tree operation, and
>    you'd like to see submodule paths from the root level, too.
> 
> I'd like to avoid adding confusion here. So is there a an easy way to tell apart
> which commands you would expect to use relative-to-cwd and which use
> relative-to-root?

I think some operations are fundamentally whole-tree. You do not merge a
subtree, but create a new top-level commit. Similarly, even in:

  cd Documentation
  git log -p .

the diffs we see still show the whole path. We are traversing the whole
tree.

If you are touching all submodules with an operation, I'd expect it to
show full paths, not relative ones. But then I set status.relativePaths
to "false", so maybe I am in the minority.

-Peff
