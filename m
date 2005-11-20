From: Junio C Hamano <junkio@cox.net>
Subject: What's in master tonight.
Date: Sun, 20 Nov 2005 00:40:21 -0800
Message-ID: <7v7jb31zm2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 20 09:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edkkv-0006Qz-2y
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 09:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVKTIkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 03:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVKTIkX
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 03:40:23 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:647 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751164AbVKTIkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 03:40:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051120083901.XFLG20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Nov 2005 03:39:01 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12375>

I've merged http updates (mostly code refactoring and cleanups)
from Nick Hengeveld, config-set from Johannes Schindelin, and
most of user-relative paths series from Andreas Ericsson.
Cooking in proposed updates are the final part of user-relative
paths series that changes git-daemon, git:// proxy support from
Paul Collins, and repository format futureproofing from Martin
Atukunda.

I'd like to do the next 1.0rc when at least the repository
format futureproofing is ready.  I personally can live without
user-relative paths or git:// proxy, although both are probably
nice to have.  Here are the current status of these three
topics.

repository format futureproofing::

	I think the current code can copy template/config that
	was prepared for wrong version of repository format
	without complaining.  It should barf and fail.

        I am unsure if the check in setup_git_repository() is
        the right thing to do.  It doesn't check when $GIT_DIR
        environment is set, which is wrong; receive-pack and
        upload-pack are run with this environment set to ".".

	Although majority of important core programs do check
	the repository format before doing any harmful
	operations, some higher level scripts should be told to
	do the checking upfront.  The config-set command by
	Johannes is probably handy for this purpose.

user relative paths::

	What's left from the master is the part that touches the
	git-daemon.  We need to be careful about being strict
	while validating the path against whitelist _after_
	DWIM, so the version in the proposed updates need to be
	checked to make sure it is safe.

proxy for git:// transport:

	I do not have any pending issues on this patch, and I
	think it is ready to go in when somebody, preferably
	other than the original author, says it is useful and
	does not break things.

The master branch is fairly ahead of the last 1.0rc as of this
writing, and I'll be attending a wedding of a coworker, so there
will not be maint updates this weekend.
