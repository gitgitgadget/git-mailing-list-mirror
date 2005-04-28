From: Junio C Hamano <junkio@cox.net>
Subject: Re: I'm missing isofs.h
Date: Thu, 28 Apr 2005 09:11:37 -0700
Message-ID: <7vvf6698zq.fsf@assigned-by-dhcp.cox.net>
References: <20050426214338.32e9ac27.akpm@osdl.org>
	<20050427235115.GN22956@pasky.ji.cz>
	<Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org>
	<20050428003246.GV22956@pasky.ji.cz>
	<7vhdhra2sg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504280740450.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 18:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRBWw-0002A3-5a
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 18:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVD1QLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 12:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVD1QLq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 12:11:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:18882 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262117AbVD1QLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 12:11:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428161138.CANI7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 12:11:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504280740450.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 28 Apr 2005 07:42:36 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Wed, 27 Apr 2005, Junio C Hamano wrote:
>> 
>> Linus & Andrew, is the above (second) format acceptable for the
>> kernel work?

LT> The only thing my stuff needs is that it's "-p1" format, ...

Is /dev/null convention OK with you?  I know it is OK for patch
and cg-patch, both of which have built-in knowledge of the
convention, but other tools may get confused.  Here is an
example of diffstat getting confused:

    $ jit-snap -v linus-mirror:0 Makefile comm-z.c
    # - [PATCH] diff-tree -p implies diff-tree -p -r
    # + JIT: indent help text from jit-snap.
    --- k/Makefile  (mode:100644)
    +++ l/Makefile  (mode:100644)
    @@ -7,7 +7,8 @@
     # BREAK YOUR LOCAL DIFFS! show-diff and anything us.....
     # break unless your underlying filesystem supports .....
    ...
    --- /dev/null
    +++ l/comm-z.c  (mode:100644)
    @@ -0,0 +1,101 @@
    +#include <stdio.h>
    +#include <string.h>
    ...

    $ jit-snap -v linus-mirror:0 Makefile comm-z.c | diffstat
    Makefile   |   15 +++++++--
    l/comm-z.c |  101 ++++++++++++++++++++++++++++++++++.....
     2 files changed, 114 insertions(+), 2 deletions(-)

LT> ... but I don't care 
LT> if the prefix is the sha1 tree-name, or "a/" and "b/" or anything else (I 
LT> think the current thing that the built-in stuff defaults to is a bit 
LT> strange. "k/" and "l/"? I understand "a/" and "b/", and I'd even get "x/" 
LT> and "y/" or "old/" and "new/", but starting counting at "l" is strange ;)

I am _very_ glad somebody finally has noticed and voiced the
puzzlement.  It is meant to be a gentle reminder that the tool's
primary purpose is to support development of l-k ;-).

I do not mind if you told me to change them to a/ or b/ (or do
it yourself---it is a single character change in the source) if
you want.

