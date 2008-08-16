From: Jim Meyering <meyering@gmail.com>
Subject: Re: [PATCH] add boolean diff.suppress-blank-empty config option
Date: Sat, 16 Aug 2008 11:07:40 +0000 (UTC)
Message-ID: <loom.20080816T105522-117@post.gmane.org>
References: <87k5eiphro.fsf@rho.meyering.net> <7v4p5mb0a1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 13:16:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUJlk-00070O-7D
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 13:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbYHPLPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 07:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbYHPLPK
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 07:15:10 -0400
Received: from main.gmane.org ([80.91.229.2]:33075 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbYHPLPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 07:15:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KUJkM-0004JE-G2
	for git@vger.kernel.org; Sat, 16 Aug 2008 11:15:02 +0000
Received: from 88-137-136-47.adslgp.cegetel.net ([88.137.136.47])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 11:15:02 +0000
Received: from meyering by 88-137-136-47.adslgp.cegetel.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 11:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.137.136.47 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008072820 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92542>

Junio C Hamano <gitster <at> pobox.com> writes:
> Jim Meyering <jim <at> meyering.net> writes:
> > GNU diff's --suppress-blank-empty option makes it so that diff does not
> > add a space or tab before each empty output line of context.  With this
> > option, empty context lines are empty also in "git diff" output.
>
> AFAIK, ERN 103/120 inspired by your comment merely says an empty context
> is either an empty line or a line with a single space on it and does not
> deprecate the latter, more traditional, form (I do not know the current

This is not a POSIX compliance issue.
Either format may be emitted.

> status of the update to the POSIX --- what's the recommended way to find
> it out by outsiders?)

Here's one copy of what's being added to the latest version of POSIX:
http://www.opengroup.org/austin/aardvark/latest/xcubug2.txt
Anyone can register (see Q2: http://www.opengroup.org/austin/faq.html)
and then get the lastest draft, but it should be final (and hence public)
pretty soon.

> We've hacked the patch application side to accomodate this special case to
> grok output from recent GNU diff already.  Can't we just stop at that,
> without having to do the same for generation side?  What's the downside of
> not doing so?

No pressure to add it to git.  I deliberately did not propose that,
based on the reception an earlier proposal received in this forum.
I tried to make that clear in the header comments.

However, here's why I use this patch:
  - there are many contexts where I try to avoid trailing blanks, and
    eliminating spurious ones makes it easier to spot possibly-problematic ones.
  - I version-control some diff output, and having diff-generating programs
    handle the elimination of unnecessary trailing blanks is slightly safer
    than doing it from each context.
  - some tools systematically remove or highlight trailing blanks.  If I can
    make my diff output less susceptible with such an option, I'll use it.

Bottom line, it doesn't really matter.
I posted the patch in case someone else would find it useful.
