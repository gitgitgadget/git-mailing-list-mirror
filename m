From: Gareth Adams <gareth.adams@gmail.com>
Subject: default behaviour for =?utf-8?b?YGdpdA==?= =?utf-8?b?bWVyZ2Vg?= (no arguments)
Date: Mon, 11 Jan 2010 18:49:38 +0000 (UTC)
Message-ID: <loom.20100111T185144-655@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 19:50:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUPLB-00056Q-JY
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 19:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab0AKSuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 13:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527Ab0AKSuI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 13:50:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:47362 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460Ab0AKSuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 13:50:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NUPKy-0004zn-QU
	for git@vger.kernel.org; Mon, 11 Jan 2010 19:50:00 +0100
Received: from 94-193-106-231.zone7.bethere.co.uk ([94.193.106.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 19:50:00 +0100
Received: from gareth.adams by 94-193-106-231.zone7.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 19:50:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.193.106.231 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.7) Gecko/20091221 Firefox/3.5.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136652>

Hi there, long time user; first time caller here.

I wanted to suggest an improvement to git-merge which will either save some
typing or save some network resources. It won't save huge amounts of either but
every little helps!

Currently, some of my colleagues frequently end up typing:

    git pull; ...; git checkout otherbranch; git pull

Now, we have quite a low commit rate, it's unlikely (albeit vaguely possible)
that two people are working on the branch at the same time. This means the
second pull is doing a fetch which it effectively pointless.

Now of course this is a tiny amount of wastage, and while I could argue that it
would be an issue under poor network conditions that's not my point. As a coder
I'd want to get rid of the redundant fetch if I know it's redundant.

Unfortunately my other option is:

    git pull; ...; git checkout otherbranch; git merge myremote/otherbranch

which is annoying extra typing. Even with tab completion, it's redundant extra
typing because in these cases I'm trying to merge with the branch being tracked.

My suggestion is that `git merge` defaults to the same merge that a `git pull`
would perform, and there are 2 extra factors that make me think it's a workable
idea:

1) At the moment, `git merge` does nothing. Except mock me for not giving it a
command in a format it recognises. This change wouldn't have any effect that
would cause anyone a problem

2) When I checkout a branch which has unmerged changes in the tracking branch,
git *tells me* what branch I will be taking action with "Your branch is behind
the tracked remote branch '...' by 4 commits, and can be fast-forwarded" - but
then makes me type it out explicitly anyway!

I appreciate that there are many workflows where there is an advantage in
performing a second pull in case there are additional changes since the first
pull, but I still think there is a string case for git merge having a more
sensible default, as git pull does.

What do you think?

Thanks,
Gareth
