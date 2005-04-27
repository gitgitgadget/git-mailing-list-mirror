From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/6] External diff interface for diff-cache and friends.
Date: Tue, 26 Apr 2005 23:19:48 -0700
Message-ID: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:14:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQfoz-00087l-PK
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVD0GT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVD0GT5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:19:57 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8176 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261620AbVD0GTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 02:19:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427061948.IZBM550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 02:19:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As discussed earlier, I am sending a series of patches to take
advantage of the simplified external diff interface you have
already merged.  This series consists of the following:

[PATCH 1/6] Reworked external diff interface.

    This patch introduces three public functions for diff-cache
    and friends can use to call out to the GIT_EXTERNAL_DIFF
    program when they wish to.  A normal "add/remove/change"
    entry is turned into 7-parameter process invocation of
    GIT_EXTERNAL_DIFF program as before.  In addition, the
    program can now be called with a single parameter when
    diff-cache and friends want to report an unmerged path.

[PATCH 2/6] Reactivate show-diff patch generation

    This patch uses the reworked diff interface to generate
    patches directly out of show-diff when -p is specified.

[PATCH 3/6] Add -p (patch) to diff-tree.

    This patch uses the reworked diff interface to generate
    patches directly out of diff-tree when -p is specified.

[PATCH 4/6] Add -p (patch) to diff-cache.

    This patch uses the reworked diff interface to generate
    patches directly out of diff-cache when -p is specified.

[PATCH 5/6] Teach diff-tree-helper to handle unmerged paths.

    This patch teaches diff-tree-helper to call diff_unmreged()
    so that it can report unmerged paths to GIT_EXTERNAL_DIFF.

[PATCH 6/6] Alternative patch to diff-cache.c

    This is a replacement of PATCH 4, in case you have already
    applied the "non-cached still looks only at cache" fix I
    sent you earlier.  If you took it, PATCH 4 may not apply
    cleanly, in which case this should be easier to work with.

