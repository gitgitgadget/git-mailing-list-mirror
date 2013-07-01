From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] Leftover bits
Date: Mon, 01 Jul 2013 15:16:39 -0700
Message-ID: <7vehbi9b94.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 00:16:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmOs-0000UV-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771Ab3GAWQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:16:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512Ab3GAWQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:16:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA7702D5B0;
	Mon,  1 Jul 2013 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	QE1eNJqfckbixg9+eiswJ+ei5M=; b=EtNj3ZrIF8O6nu2i+Smhao4Gp5zc5UrrT
	en6UGlVqn2vXbdvGk9ZREz/rAzJR0QyAnLuig+xCPaXrG+hjKCMUKD45oZgr3Jgb
	2+ZoQ0EuFnoWPrSqtHHaHpSJKA1CF+t1eyMy+mMYyN079zOLOPUgz6tT0w55vF+z
	d9AnSPwij4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=sj1
	z1a8yIkfwoMKyU2Skd8q5A99vb6LNEnnQgym2zMlUO5lwqebvAIYQw/6IlmUP8fv
	z6Loe6MGFIR4B9hv+RmilHz3tIxUahZq9kkn6lufN6u7M9pdUAnPCMtT39V23VqY
	5LlE00bwbRFJnW6xs0KKZ6+kI4wWel4DPt2ynzwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A11E62D5AF;
	Mon,  1 Jul 2013 22:16:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA1BC2D5AE;
	Mon,  1 Jul 2013 22:16:40 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7B6EE92-E29B-11E2-A6FD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229341>

It is now in the middle of 5th week of this release cycle [*1*], and
due to the season being summer and with US holidays, I expect that
things will be more quiet than other weeks.  It was a good time to
review the recent issues of whats-cooking, and that is what I just
did.

Here is a list of topics, that I thought may be of merit, but
seem to be stalled for extensive timeperiod.

I am mostly worried about the ones that (superficially at least)
looked good to me but haven't got any reviews.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jl/submodule-mv (2013-04-23) 5 commits
 - submodule.c: duplicate real_path's return value
 - rm: delete .gitmodules entry of submodules removed from the work tree
 - Teach mv to update the path entry in .gitmodules for moved submodules
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Waiting for a reroll.
 $gmane/226294


* hv/config-from-blob (2013-05-12) 5 commits
 - do not die when error in config parsing of buf occurs
 - teach config --blob option to parse config from database
 - config: make parsing stack struct independent from actual data source
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management

 Waiting for a reroll.
 $gmane/223964


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jk/fast-import-empty-ls (2013-06-23) 4 commits
 - fast-import: allow moving the root tree
 - fast-import: allow ls or filecopy of the root tree
 - fast-import: set valid mode on root tree in "ls"
 - t9300: document fast-import empty path issues

 Waiting for reviews.
 $gmane/228741


* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for the initial history to pull from.
 $gmane/223564


[Footnote]

*1* The release calendar is at http://tinyurl.com/gitCal
    The 8th week is also expected to be slow due to OSCON.
