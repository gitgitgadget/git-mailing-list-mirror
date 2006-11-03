X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Rename remote_only to display_mode
Date: Fri, 03 Nov 2006 03:51:54 -0800
Message-ID: <7v4ptgagth.fsf@assigned-by-dhcp.cox.net>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
	<200611021111.09434.andyparkins@gmail.com>
	<7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
	<200611030841.05888.andyparkins@gmail.com> <454B1F3B.1020603@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 11:52:53 +0000 (UTC)
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454B1F3B.1020603@op5.se> (Andreas Ericsson's message of "Fri, 03
	Nov 2006 11:51:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30830>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfxaa-0004i5-0J for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753244AbWKCLv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 06:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbWKCLv4
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:51:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20212 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1753244AbWKCLvz
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 06:51:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103115155.OINX6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 06:51:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id iBrz1V00J1kojtg0000000 Fri, 03 Nov 2006
 06:52:00 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> Andy Parkins wrote:
>> Digressing a little: what is the polite form of patches for git?  My
>> strategy with this set was to make each patch as small as possible
>> to reach my end point.  If those patches were okayed on the list, I
>> could then do a "make more beautiful" patch, which is really nothing
>> to do with the original changes to functionality but would make the
>> code prettier.
>
> I believe the order of preferrence goes: tested, concise, short.
>
> Linus has a nasty habit of ending his mails with "totally untested
> ofcourse", which is not a good strategy to adopt if you want your
> patches included.

I've picked it up as well.  Consider it a privilege for being
the toplevel maintainer ;-).

Seriously, it is perfectly Ok to send "for discussion" feelers
that are untested or messy, but marking them clearly as "for
discussion only -- will clean-up after discussion" would be very
much appreciated.

The organization of our four series was almost perfect, except
you went a bit too far with [2/4].  I said "taken alone this is
regression in readability", with the full knowledge that the
real reason of the change was that it would not make any sense
to call the variable "remote_only" in [3/4].  IOW, I would have
rolled 2 and 3 into a single change.

> If you *need* to change something, change it. If you *want* to change
> something just because it's not written the way you would write it,
> back away. If you think some interface you're using needs clearing up
> (codewise or with extra comments), send a separate patch for that so
> the actual feature/bugfix you're sending in doesn't drown in cosmetic
> changes to the interfaces the patch uses/touches.

This is a very good advice.  I fully agree with Andreas.

When I was an active contributor, somebody (I do not remember
who) asked me privately: "you seem to be getting along pretty
well with Linus; I have these changes I want to send in, but can
you suggest a good strategy to get patches accepted?"  I recall
saying something along this line:

 - Make sure the patches apply cleanly to upstream (rebase if
   necessary).

 - When making a series, make clean-ups and obviously correct
   ones early, then follow them with bigger and potentially more
   controversial ones.  Doing it the other way around takes the
   "obviously correct" ones hostage to the latter; IOW, you
   would be effectively saying "if you swallow this big change,
   you would get these clean-ups and obviously correct
   bugfixes", which is not nice to the maintainer.

 - When some of your changes are accepted but others were not,
   do not give up, if you believe in the cause, try to come up
   with convincing examples to explain why your change helps
   certain workflows.

 - When doing so, make sure the patches apply cleanly to the
   updated upstream that now has some of your changes.  It might
   have been applied with fix-ups, and other people may have
   made clean-ups in neighbouring area.  You may need to re-roll
   the patch.

 - Linus is not doing this full-time and is a busy person.
   Although "not giving up" is important, do not push him too
   hard.  Try to guess how busy he is and what area his
   attention currently is.  The latter is important for two
   reasons.  (1) If you have to touch the same part of code but
   for a different reason, that would add more work on him.  It
   is better wait until the upstream code settles in the part of
   the code and base your patch on that.  (2) If your change
   needs a deep thinking to swallow, it is likely to be dropped
   when Linus's attention is in completely different area.

