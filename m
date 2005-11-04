From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tags not transferred with git pull?
Date: Fri, 04 Nov 2005 11:26:20 -0800
Message-ID: <7vll04tdsz.fsf@assigned-by-dhcp.cox.net>
References: <20051104155314.GB23790@harddisk-recovery.nl>
	<20051104155914.GA9567@ferdyx.org>
	<20051104160503.GC23790@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 20:28:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY7Cj-0003M0-R9
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 20:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVKDT0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKDT0W
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 14:26:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41374 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750783AbVKDT0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 14:26:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104192527.NGRD2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 14:25:27 -0500
To: Erik Mouw <erik@harddisk-recovery.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11154>

Erik Mouw <erik@harddisk-recovery.com> writes:

> Ah, right. I got the impression that the latest git was supposed to do
> that automatically with a git pull.

Sorry for the confusion.  The barebone Porcelainish shipped with
git-core does not fetch and store tags unconditionally under the
same name as the remote has without being told; you need to
explicitly tell it to 'git fetch --tags'.

What was added recently was a low level support for Cogito to
implement the automatic tracking.  This is supposed to (I do not
offhand know if the Cogito side has been updated to do so
already) work a bit differently.  Instead of grabbing all tags
and all objects reachable from them, as you fetch commits from
the remote, the automatic tracking fetches tags that point at
them.  What this means is that the tags on the remote branch you
are tracking would be fetched automatically but tags on a remote
branch you are not interested in are not.
