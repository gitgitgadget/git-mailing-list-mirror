From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/9] Fix oversimplified optimization for add_cache_entry().
Date: Sat, 25 Jun 2005 02:16:23 -0700
Message-ID: <7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 11:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6gF-0000mn-FE
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 11:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbVFYJQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVFYJQ6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:16:58 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:18940 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S263368AbVFYJQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:16:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625091624.FGLV17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 05:16:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vaclf6tw7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 24 Jun 2005 19:40:40 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
LT> I really don't want to do this. 
LT> Can you fix the "optimized" one instead?

JCH> Will do.

I have this list which logically consists of three sets.  I am
using the new "git rebase" to maintain it and your not taking my
patch stream gave me a good opportunity to test it ;-).

  [PATCH 1/9] [RFC] fix date parsing for GIT raw commit timestamp format.
  [PATCH 2/9] git-commit-script: get commit message from an existing one.
  [PATCH 3/9] git-cherry: find commits not merged upstream.
  [PATCH 4/9] git-rebase-script: rebase local commits to new upstream head.

These four are updated "git rebase" I've written while on-road
without knowing about your git-patch-id; the updated one uses
git-patch-id to identify which are merged and which are not.

To carry earlier commit datetime forward, date.c needs to be
fixed (PATCH 1/9, which I sent you separately Friday), and
enhancing git-commit-script to be able to specify an existing
commit to slurp the commit message (and author & date
information) was necessary (well, not strictly necessary, but
that is the way I am used to, which is stolen from JIT), which
is PATCH 2/9.  PATCH 3/9 and PATCH 4/9 use git-patch-id to
implement the cherrypick/rebase.

  [PATCH 5/9] Add more tests for read-tree --emu23.
  [PATCH 6/9] git-merge-one-file-script: do not misinterpret rm failure
  [PATCH 7/9] Fix oversimplified optimization for add_cache_entry().

These three are reworked D/F conflict fix.  PATCH 5/9 is the
same demonstration of what is broken in the current code.  The
problem fixed by PATCH 6/9 was discovered while I was trying out
the fixes.  PATCH 7/9 teaches your "optimized" has_file/has_dir
implementation to honor stages while they operate.

  [PATCH 8/9] http-pull: documentation updates.
  [PATCH 9/9] Add a bit of developer documentation to pull.h

These are resend.

