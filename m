From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk (was Re: Linux v2.6.12-rc6)
Date: Fri, 10 Jun 2005 20:57:45 +1000
Message-ID: <17065.29225.943521.738481@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
	<20050607130535.GD16602@harddisk-recovery.com>
	<Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
	<17062.21286.601768.751853@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081608450.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 12:54:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgh8v-00061W-Ly
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 12:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVFJK5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 06:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVFJK5q
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 06:57:46 -0400
Received: from ozlabs.org ([203.10.76.45]:54680 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262379AbVFJK5n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 06:57:43 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 09D6467B65; Fri, 10 Jun 2005 20:57:42 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081608450.2286@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> and it would be cool if the "filename list" panel on the right side 
> colorized the names by these things (only three cases - leave the "not 
> touched" files off entirely, of course).

Hmmm.  How about this: each parent is given a color, and the file
names are colored according to which parent they differ in.  If a file
differs in more than one parent it gets listed more than once in the
colors for the parents in which it differs, with those entries being
consecutive in the list.

If instead I list the file once in yet another color, I don't see how
to make it intuitively obvious that that's what the color means, and I
get a combinatorial explosion in the number of colors required as the
number of parents grows (I would potentially need 2^n - 1 colors for n
parents).

> Also, it should actually possible to do a diff for these things with just
> doing a "diff3" on the two parents and on the merge result (diff3 normally
> expects the "original", but hey, the "original" might as well be the
> result), and thus color a merge file by whether the lines came from one
> side or the other or both (or neither, which would be a manual merge
> fixup).

I already have code in dirdiff to display n-way diffs in a single
window, so it's certainly doable.  I think I will do it a little
differently in this case, though, because the final result has a
special status.  If I color lines according to which parent(s) they
are present in and then have some other way to show which version was
chosen (maybe a black box around those lines? or a little tick (check
mark) or cross icon at the left hand edge of the line?) I think that
should be pretty clear.  (I'll need another color for the cases where
the result is different to all of the parents, of course.)

Sounds interesting.  I'll have a look at it.

Paul.
