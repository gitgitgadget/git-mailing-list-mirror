From: Jeff King <peff@peff.net>
Subject: Re: Imports without Tariffs
Date: Sat, 13 Oct 2007 03:57:23 -0400
Message-ID: <20071013075723.GA27533@coredump.intra.peff.net>
References: <30817A88-4313-4D38-95B0-FEC47C651CB0@mit.edu> <20071013040712.GA27227@coredump.intra.peff.net> <1240801C-F4CC-4290-8C3D-2038F1957DF3@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Oct 13 09:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgbsO-0005TI-FJ
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 09:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbXJMH51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 03:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbXJMH51
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 03:57:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4011 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbXJMH50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 03:57:26 -0400
Received: (qmail 22557 invoked by uid 111); 13 Oct 2007 07:57:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Oct 2007 03:57:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Oct 2007 03:57:23 -0400
Content-Disposition: inline
In-Reply-To: <1240801C-F4CC-4290-8C3D-2038F1957DF3@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60726>

On Sat, Oct 13, 2007 at 12:30:09AM -0400, Michael Witten wrote:

>> except that git-rebase is smart enough to realize that C == C' and skip
>> it (so it's a "safe" way of moving forward).
>
> This is good to know! The documentation should mention this case!

Yes, it probably should. Can you submit a patch describing the behavior
where you think it ought to go?

> Basically, the imported cvs history should be treated like
> a remote that's being tracked. It seems like the solution
> I proposed kind of does this and would work for other SCM
> imports too.

I think it's an interesting avenue to pursue, though I would worry a
little about robustness. I like the fact that after rebasing, the
commits have done a complete git->cvs->git loop and look identical, so I
am sure everything made it through intact. But perhaps I'm just being
paranoid.

As an alternate idea, why not try to have the CVS commit contain all
information necessary to create a particular git commit. IOW, describe
all of the data that goes into the commit hash as textual comments in
the CVS commit (committer name/time, author name/time). And then
theoretically git-cvsimport can reconstruct the exact same commits
again, and your git->cvs->git merge really _will_ be a fastforward.

> Unfortunately, they are the ones running the servers; I have to do my
> git work behind the scenes.

I've been in the same boat, and just used the rebase trick I described.
Of course it was a very tiny project, so I didn't mind losing some of
the full power of git.

-Peff
