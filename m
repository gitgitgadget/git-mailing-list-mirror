From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sat, 02 Jun 2007 14:09:30 -0700
Message-ID: <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 23:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huar6-00069R-T8
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 23:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956AbXFBVJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 17:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756671AbXFBVJj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 17:09:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37281 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbXFBVJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 17:09:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602210938.FNOB9600.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Jun 2007 17:09:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6l9W1X00B1kojtg0000000; Sat, 02 Jun 2007 17:09:36 -0400
X-master-at: 4bc708347e2b94564d9ec5e0e3a2ab0e3d6b2fd9
X-next-at: 27ad4ce59774f6cd0099b5248e9d762ed2971070
In-Reply-To: <7virac547s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 29 May 2007 03:11:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48953>

Again, 'next' is getting quite lightweight compared to 'master'.
Good time to do "war on whitespace" Marco suggested myself.

'pu' has Shawn's 'pu' from git-gui, to help people experiment
with the proposed blame viewer improvements more easily.  I
personally like it quite a bit.

----------------------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* lh/submodules (Sat Jun 2 03:27:42 2007 +0200) 2 commits
 + Add basic test-script for git-submodule
 + Add git-submodule command

I find this a 'master' material already.  Will merge soon.

* gb/idx (Fri Jun 1 15:18:05 2007 -0400) 1 commit
 + Unify write_index_file functions

Should graduate to 'master' by mid next week.

* pb/am (Thu May 24 19:25:25 2007 -0700) 2 commits
 + Remove git-applypatch
 + git-applymbox: Remove command

Will push out to 'master' soon to see if anybody screams.

* dh/repack (Fri May 25 14:40:24 2007 -0700) 1 commit
 - Enhance unpack-objects for live repo and large objects

I saw nobody other than Dana jump up and down and say we must
have this, so I still parked this in 'pu' without merging it to
'next'.  Maybe a time for a quick poll?

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Backburnered.  Further work on the latter, or something like
that, or something based on (disused) git-merge-tree, is needed
to exonerate Linus from having lied in the following part of his
talk (there is a transcript at http://git.or.cz/gitwiki of his
talk by the way):

    The source code may sometimes look complicated because we
    are very performance centric, I am.  I really care, and
    sometimes to make things go really fast, you have to use
    more complicated algorithms than just checking one file at a
    time.  When you are doing 22,000 file merges, you do not
    want to check one file at a time, you want to check the
    whole tree in one go and say, "Ah they are the same, I do
    not have to do anything".

as we _DO_ currently merge one path at a time.

You _could_ interpret "merge" in his message as applying
millions of patches from Andrew, in which case it is true ---
the cache-tree optimization in the index does help us skipping
the unchanged tree recomputation.  But that does not apply to a
true merge, even when it is a trivial tree-level merge.
