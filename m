From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 28 Jul 2007 01:47:20 -0700
Message-ID: <7vtzrosynb.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	<7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
	<7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
	<7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
	<7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
	<7vd4zb3bid.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 10:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEhxP-0002Gl-ND
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbXG1IrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 04:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbXG1IrY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:47:24 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51590 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbXG1IrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 04:47:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728084721.PRHB8237.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 04:47:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UwnM1X0041kojtg0000000; Sat, 28 Jul 2007 04:47:21 -0400
X-master-at: 83b3df7d582429d9036f34d2c95abfff7bf0ab24
X-next-at: 25b4fc9576cd8a73fb666e466ad54d0ae91137c1
In-Reply-To: <7vd4zb3bid.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 01 Jul 2007 17:16:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54011>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* bs/lock (Thu Jul 26 22:13:12 2007 -0700) 3 commits
 + Add test for symlinked configuration file updates.
 + use lockfile.c routines in git_commit_set_multivar()
 + fully resolve symlinks when creating lockfiles

I would like to have this in 1.5.3, as it appears to be
obviously and trivially correct, and resolves real issues we saw
reported on the list and #git channel.

* js/worktree (Thu Jul 26 07:32:49 2007 +0100) 5 commits
 . With work-trees possibly inside git-dir, be more generous
 . Add test for sanitized work-tree behaviour
 . Clean up work-tree handling
 . Add functions get_relative_cwd() and is_inside_dir()
 . Add is_absolute_path(), make_absolute_path() and normalize_path()

Dscho is dead set fixing broken WORK_TREE series that is already
in 'master'.  The series so far unfortunately has still been
untestable state, but the basic approach of cleaning up seems
sound, and knowing him I am reasonably confident that this will
be at least 'next' quality soon enough.

* cr/tag (Mon Jul 23 12:58:27 2007 +0100) 5 commits
 + Teach "git stripspace" the --strip-comments option
 + Make verify-tag a builtin.
 + builtin-tag.c: Fix two memory leaks and minor notation changes.
 + launch_editor(): Heed GIT_EDITOR and core.editor settings
 + Make git tag a builtin.

Carlos did a good job at very carefully crafting this series,
under Dscho's supervision.  Judging from the quality of the
series, I would personally love to have this in 1.5.3.  But as a
matter of principle, replacing an implementation with a totally
different one post -rc is not something I'd want to make a
precedent of.  This will be merged early after 1.5.3.

* mc/logsize (Fri Jul 20 20:15:13 2007 +0200) 1 commit
 - Add --log-size to git log to print message size

This adds a new option --log-size that is to primarily help
loading "git log --pretty=raw" output by qgit.  It is probably
not useful with any other combination of options, with "-p",
"--stat", "--pretty={email,oneline}", etc., as the "length
indicator" is at the wrong place (it should be the first line of
each record, not on the second line), but it is good enough for
helping qgit.  This (or improvement of it if one comes up) will
most likely to be in 'master' after 1.5.3.

* js/recursive-fix (Tue Jul 17 18:14:48 2007 +0100) 2 commits
 . Add tests for cherry-pick d/f conflict which should be none
 . merge-recursive: sometimes, d/f conflict is not an issue

This is to paper over a design bug in merge-recursive d/f
conflict checking code.  I'd expect we would want to rethink the
whole merge datapath after 1.5.3 and prefer to leave this series
out of 1.5.3.

* jc/blame (Thu Jul 12 10:49:08 2007 -0700) 4 commits
 - git-log --follow?
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up

The tip of this is Linus's "follow single file".  I will
cherry-pick and put it in 'next' after 1.5.3.

* db/fetch-pack (Tue Jul 10 00:38:42 2007 -0400) 1 commit
 . Make fetch-pack a builtin with an internal API

Daniel has a few more patches in this series we have already
seen on the list; I'll ask him to rebase/repost after 1.5.3.

* jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 . rebase: allow starting from a dirty tree.
 . stash: implement "stash create"

I did this just for fun, but come to think of it, the user can
run git-stash himself when git-rebase complains the working tree
is dirty anyway, so this may probably not so useful.

* dh/repack (Fri May 25 14:40:24 2007 -0700) 1 commit
 . Enhance unpack-objects for live repo and large objects

This is to deliberately avoid placing large blob to packfile.
Nico had objections on this type of special purpose hacks, and I
agree with him.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
