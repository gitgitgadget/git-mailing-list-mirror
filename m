From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Sat, 03 Feb 2007 18:10:59 -0800
Message-ID: <7vzm7uy8ng.fsf@assigned-by-dhcp.cox.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
	<20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
	<b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
	<20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com>
	<b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com>
	<20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net>
	<20070204014945.GA18357@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 03:11:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDWqR-0007EX-HL
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 03:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbXBDCLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 21:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbXBDCLD
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 21:11:03 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:39537 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751652AbXBDCLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 21:11:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204021100.RGDN1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 21:11:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KEAz1W00N1kojtg0000000; Sat, 03 Feb 2007 21:11:00 -0500
In-Reply-To: <20070204014945.GA18357@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 3 Feb 2007 20:49:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38636>

Jeff King <peff@peff.net> writes:

> I was one of the major pushers of this feature in December; however, I
> think it actually can create some confusing results. See:
>   http://article.gmane.org/gmane.comp.version-control.git/35789

I actually was re-reading that exact post (and more importantly,
messages 35810 and 36374 in the thread) before I sent the
message you are replying to.

While I think branch.*.merge, which was invented for the use of
git-pull -> git-merge callchain, should consistently use the
remote branch name, after re-reading your messages, especially
36374, I see why you wanted a mechanism to talk about
relationships between two (or more) local branches.

I do not think it is wrong to have a separate mechanism (and it
might end up being called as "mergelocal" which you said might
be a terrible name) for that.  I just think it is probably a
wrong thing to do to use branch.*.merge for that. As you said,
operations you are interested in like format-patch (and perhaps
rebase) of a local branch relative to another locally available
ref (be it another branch or a tracking branch) do not involve
fetching (hence pulling) necessarily.
