From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/6] A bit better dumb server support
Date: Sat, 23 Jul 2005 17:53:49 -0700
Message-ID: <7vsly5korm.fsf@assigned-by-dhcp.cox.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
	<20050723081549.GC3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 02:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwUkg-0004LY-2W
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 02:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGXAxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 20:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVGXAxw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 20:53:52 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:15009 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261670AbVGXAxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 20:53:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724005345.FWYS16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 20:53:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Several days ago there was a discussion on discovering remote
tags and branches.  This was somewhat related to supporting
packed repositories on a dumb server I have been toying with, so
here is my current status.

The first three patches deal with the discovery of remote tags
and heads:

  [PATCH 1/6] git-peek-remote: show tags and heads from a remote repository.
  [PATCH 2/6] Documentation: git-peek-remote.
  [PATCH 3/6] git-ls-remote: show and optionally store remote refs.

The discovery over http transport against a dumb server needs to
have a couple of files to support it, which is prepared with the
next two patches.

  [PATCH 4/6] Add update-server-info.
  [PATCH 5/6] Document update-server-info.

The git-update-server-info command introduced by these two
patches prepare not just the list of tags and heads, but the
list of packs and commit ancestry information.  Using that,
cloning a packed repository over http transport from a dumb
server becomes trivial.

  [PATCH 6/6] Support cloning packed repo from dumb http servers.

The next task would be to add support of the same to git-fetch.
