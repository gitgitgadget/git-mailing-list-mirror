From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH RFC] rebase--interactive: if preserving merges, use
 first-parent to limit what is shown.
Date: Mon, 6 Oct 2008 21:20:21 -0500
Organization: Exigence
Message-ID: <20081006212021.04ba9214.stephen@exigencecorp.com>
References: <48E8DD7E.9040706@redhat.com>
	<20081006102118.3e817a0f.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 04:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn2FC-0004MN-Qx
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 04:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYJGCUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 22:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbYJGCUX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 22:20:23 -0400
Received: from smtp172.sat.emailsrvr.com ([66.216.121.172]:48828 "EHLO
	smtp172.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYJGCUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 22:20:22 -0400
Received: from relay7.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 7534011B0DE6;
	Mon,  6 Oct 2008 22:20:22 -0400 (EDT)
Received: by relay7.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 112C811B0DE1;
	Mon,  6 Oct 2008 22:20:21 -0400 (EDT)
In-Reply-To: <20081006102118.3e817a0f.stephen@exigencecorp.com>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97656>


> I agree with Avi on what the rebase -i -p behavior should be for his
> scenario. This patch makes it so. However, the bane of my existence,
> t3404 is failing ~12 tests in, which is a real PITA to debug, so
> please let me know if this is a worthwhile tangent to continue on.

Ah, good old t3404--it caught me on an aspect I had considered but
wanted to avoid--Avi's (and my) preferred "--first-parent" way of
listing merges works great if the right hand side of the merge commits
are outside of the branch getting rebased.

E.g. my use case is when I merge in a stable release with ~100 commits
or so and could potentially want to move it around, perhaps squash
around it as Avi pointed it, I don't want all 100 commits that are in
the stable branch to be listed in my todo file.

However, t3404 makes a good point that if the right hand of the merge
has parents that are going to get rebased, the right hand side does
need to be included/shown/rewritten.

I also went and looked at the git-sequencer rewrite of rebase-i and it
looks slick. I don't fully understand it yet, but I'm much more
inclined now to just let Stephan (& sponors/list) ably handle the
problem. Especially since its moving to builtin, it moves the required
technical ability to contribute above my current skillset--perhaps that
is the intent. :-)

So, unless I think of something else, I'm done hacking on this and
am withdrawing the patch.

Though I am curious--with the sequencer, is the Avi/my request of not
listing out-of-band commits in the todo file going to be handled?

Some sort of "--first-parent-unless-included-in-rebase" flag.

Thanks,
Stephen
