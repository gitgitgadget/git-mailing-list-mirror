From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Wed, 03 Aug 2005 10:37:12 -0700
Message-ID: <7virymdirb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508021942500.3341@g5.osdl.org>
	<7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030808530.3341@g5.osdl.org>
	<7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030913060.3341@g5.osdl.org>
	<7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<7voe8fdkd7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031014070.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 19:39:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0NBF-00019F-FN
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVHCRhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVHCRhR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:37:17 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63220 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262367AbVHCRhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 13:37:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803173713.FYRU17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 13:37:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508031014070.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 10:23:14 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I started out to make the "-f" flag to send-file work around it, but I
> never finished that, partly because it really ends up being the same thing
> as "git-fetch-pack" in reverse, which was against the whole point of
> git-send-pack. Send-pack is meant to be an "update remote tree" thing, 
> with the assumption that the remote tree is a subset - and exactly that 
> assumption is what makes send-pack much cheaper than fetch-pack.

I think in addition to the existing ref_newer() check, which
makes sure you are advancing the remote head, not just replacing
with something unrelated, making sure that we have objects
referenced by ref->old_sha1 we obtained from the remote on our
end for all branches involved would be the only thing needed.
The latter the users should not even be able to override with
the --force flag, of course, but we would remind them to pull
from the other end first.
