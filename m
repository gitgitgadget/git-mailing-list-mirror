X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb TODO
Date: Fri, 17 Nov 2006 13:08:07 -0800
Message-ID: <7vu00xixxk.fsf@assigned-by-dhcp.cox.net>
References: <200611171901.40839.jnareb@gmail.com>
	<7vwt5tlvy5.fsf@assigned-by-dhcp.cox.net>
	<200611172130.11631.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 21:08:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611172130.11631.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 17 Nov 2006 21:30:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31730>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlAxD-0006Gr-KJ for gcvg-git@gmane.org; Fri, 17 Nov
 2006 22:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755901AbWKQVIL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 16:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755917AbWKQVIL
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 16:08:11 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43745 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1755901AbWKQVII
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 16:08:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117210807.RIPB27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 16:08:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nx8E1V00K1kojtg0000000; Fri, 17 Nov 2006
 16:08:14 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> What about the fact that git-diff -M is _not_ patch-compatibile;

What about it?  I've never said patch compatibility is an issue.
We have something patch cannot represent or understand and you
should admit it.  The point is to make it easier to massage by
hand, when the recipient does not have git handy.

With -M, the recipient can read and understand the patch text
better than "remove this oldfile and create this newfile that
the diff output does not tell you is related" diff.  And we say
"rename" in plain language so the recipient _can_ do "mv A B"
then "patch -p1".  Similarly, with -T that changes a symlink
into a real file, if we do not do the current "remove the old
and then create the new" and did instead "show the textual diff
that can be applied", a non-git tool that does not understand
the typechange can mistakenly muck with the target of the
symlink, which is a disaster.  "Remove the target and then
create this" at least would have lesser damage -- the object
left as the result is incorrect nevertheless, but reading the
contents and creating a symlink that has that contents by hand
is easily done in a pinch.

> We should have whatchanged part corresponding to the patchset
> part at least in "commitdiff" view, which means '-c' (and for
> the time being perhaps mean '-c' also in patchset part). '--cc'
> which uses '-c' for the raw part would be nice...

I am not sure what you mean by patchset part, but if you are
talking about the multiway diff text, I think most of the time
output from "-c -p" is much less interesting than "--cc".


