From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.2.4
Date: Wed, 01 Mar 2006 22:24:30 -0800
Message-ID: <7vslq19xep.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 07:24:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEhEv-0002Rp-BG
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 07:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWCBGYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 01:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWCBGYe
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 01:24:34 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49899 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751398AbWCBGYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 01:24:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060302062115.HPJW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Mar 2006 01:21:15 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17056>

The latest maintenance release GIT 1.2.4 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.4.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.4-1.$arch.rpm	(RPM)

Among some fixes, there is one feature item: war on whitespace.

This was done in response to Andrew Morten's request, and
backported from the primary development track.

When you apply an e-mailed patch with git-am (or git-applymbox),
if the patch introduces new trailing whitespaces, you will get
warning messages by default.  This behaviour can be tweaked by
setting the configuration item "apply.whitespace" to various
values.

For kernel subsystem maintainers, the earlier Andrew's requests
translate to setting it to either "error" or "strip".

E.g.

	$ git repo-config apply.whitespace error

What are the available choices, and which one is for you?

 * If you are a busy top echelon person who cares about tree
   cleanliness, apply.whitespace=error is a good choice.  This
   stops after giving a handful error messages, and refuses to
   apply a patch that introduces trailing whitespaces.  After
   the failed patch, you should return the patch to the
   submitter; your tree remains clean.

 * apply.whitespace=error-all is a better choice for you, if you
   are willing to clean up other peoples' mess.  You will get
   all errors, and the patch is not applied.  You can go through
   with your editor (e.g. Emacs users can use C-x `; I hope vim
   users have similar macros) and fix things in .dotest/patch.
   After fixing them up, "git am" without flags (or "-i" for
   "interactive" if you want) to apply it.  Do not forget to
   tell the person who wasted your time doing this to be more
   careful next time.

 * If you do not care much about new trailing whitespaces, there
   is apply.whitespace=warn, which is the default.  This shows
   warning messages and applies the patch.  Make a mental note
   to scold the patch submitter to be careful the next time.

 * If you care about cleanliness, want to be nice to the
   submitters by not forcing them to resubmit solely on
   whitespace basis, but not nice enough to educate them,
   apply.whitespace=strip is for you.  This applies the patch
   after stripping the trailing whitespaces it introduces.

 * If you do not care about whitespace errors at all,
   apply.whitespace=nowarn is for you.  No warnings, no errors.

----------------------------------------------------------------

Changes since v1.2.3 are as follows:

Alex Riesen:
      fix t5600-clone-fail-cleanup.sh on windows

Josef Weidendorfer:
      git-mv: Allow -h without repo & fix error message
      git-mv: fixes for path handling

Junio C Hamano:
      checkout - eye candy.
      Give no terminating LF to error() function.
      diffcore-rename: plug memory leak.
      git-am: do not allow empty commits by mistake.
      sample hooks template.
      apply --whitespace fixes and enhancements.
      apply: squelch excessive errors and --whitespace=error-all
      apply --whitespace: configuration option.
      git-apply --whitespace=nowarn
      git-apply: war on whitespace -- finishing touches.
      git-am: --whitespace=x option.
      diffcore-break: micro-optimize by avoiding delta between identical files.
      Allow git-mv to accept ./ in paths.

Linus Torvalds:
      The war on trailing whitespace

Mark Wooding:
      combine-diff: Honour --full-index.
      combine-diff: Honour -z option correctly.
