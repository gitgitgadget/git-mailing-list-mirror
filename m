X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 03:08:06 -0800
Message-ID: <7vmz5kqh2h.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
	<20061218140813.GA32446@spearce.org>
	<7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
	<7v64c8thr4.fsf@assigned-by-dhcp.cox.net>
	<20061219090851.GH2511@spearce.org>
	<7vhcvsry2c.fsf@assigned-by-dhcp.cox.net>
	<20061219104032.GB21324@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 11:08:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219104032.GB21324@spearce.org> (Shawn Pearce's message of
	"Tue, 19 Dec 2006 05:40:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34822>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcpY-0000g5-Ix for gcvg-git@gmane.org; Tue, 19 Dec
 2006 12:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751813AbWLSLIK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 06:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbWLSLIK
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 06:08:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39511 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752282AbWLSLII (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 06:08:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219110807.JQUH25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 06:08:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0b8K1W00H1kojtg0000000; Tue, 19 Dec 2006
 06:08:19 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

>> The best I came up with is still my "show-branch --reflog" so
>> far.  You really need to show not just the commit title but how
>> they topologically relate to the commits on the surviving
>> branch, and I think having something graphical or semi-graphical
>> is a must.
>
> Probably right.  But I can't make heads or tails out of that
> output for just one topic branch...

Here is what my private 'pu' look like:

! [pu@{0}] Merge branch 'jc/fsck-reflog' into pu
 ! [pu@{1}] Merge branch 'jc/pickaxe' into pu
  ! [pu@{2}] Merge branches 'jn/web', 'jc/explain', 'jc/web' and
   ! [pu@{3}] Merge branch 'jc/leftright' into next
    ! [pu@{4}] Merge branch 'jc/fsck-reflog' into pu
     ! [pu@{5}] Merge branch 'jc/pickaxe' into pu
      ! [pu@{6}] Merge branches 'jc/fsck-reflog', 'jc/clone', 'j
       ! [pu@{7}] Merge branch 'jc/blame' into next
--------
-        [pu@{0}] Merge branch 'jc/fsck-reflog' into pu
+        [pu@{0}^2] git reflog expire
+        [pu@{0}^2^] Move in_merge_bases() to commit.c
+        [pu@{0}^2~2] reflog: fix warning message.
--       [pu@{1}] Merge branch 'jc/pickaxe' into pu
---      [pu@{2}] Merge branches 'jn/web', 'jc/explain', 'jc/web
----     [pu@{3}] Merge branch 'jc/leftright' into next
++++     [pu@{3}^2] Revert "Make left-right automatic."
      ...
++++     [pu@{3}~2^2~3^2^] Revert "fix testsuite: make sure they
    -    [pu@{4}] Merge branch 'jc/fsck-reflog' into pu
+   +    [pu@{0}^2~3] Teach git-repack to preserve objects refer
    --   [pu@{5}] Merge branch 'jc/pickaxe' into pu
    ---  [pu@{6}] Merge branches 'jc/fsck-reflog', 'jc/clone', '
+++ +++  [pu@{2}^5] para-walk: walk n trees, index and working t
      ...
+   +++  [pu@{0}^2~5] add for_each_reflog_ent() iterator
-------- [pu@{7}] Merge branch 'jc/blame' into next

What matters most is the leftmost column.  Most of the time when
you are looking at reflog, you are looking for what's rewound
and lost.  Stretches of lines with symbols (e.g. pu@{3}^2 to
pu@{3}~2^2~3^2^, and pu@{0}^2 to pu@{0}^2~2) are not so
interesting [*1*].

The entry whose column have whitespace there are the lost ones
(rewound or amended).  pu@{4} used to be the tip of 'pu', but
after I whipped 'next' into a reasonable shape, I did "git
branch -f pu next" to bundle the tips of topics that are not
ready for 'next' into it (and all the rest pu@{3}, pu@{2},
pu@{1} and pu@{0} are sequence of merges into 'pu').


[Footnote]

*1* We might want to add an output filter that lets the command
omit such lines with the same set of reachable tips when showing
the reflog entries.


