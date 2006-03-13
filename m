From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] http-push updates
Date: Sun, 12 Mar 2006 21:21:45 -0800
Message-ID: <7vek16udg6.fsf@assigned-by-dhcp.cox.net>
References: <20060311041749.GB3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 06:22:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIfVa-0005V1-6I
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 06:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCMFVt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 00:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWCMFVs
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 00:21:48 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58560 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751430AbWCMFVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 00:21:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313051756.JVUX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 00:17:56 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060311041749.GB3997@reactrix.com> (Nick Hengeveld's message of
	"Fri, 10 Mar 2006 20:17:49 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17549>

Nick Hengeveld <nickh@reactrix.com> writes:

> I'm considering future support for initializing a remote repo if the
> remote url points to an empty directory and the --force arg is present.
> Any thoughts?

Repository maintenance tasks:

 - create a new repository
 - create new branch (and new tag) -- I think you can already do this
 - remove an unneeded branch and tag
 - (perhaps) running update-server-info
 - running repack

> I'm also planning to add support for using packs to send updates, and
> for updating remote server objects/info/packs.  I'm not sure whether it
> makes sense to always send packs or to only do so when enough objects
> need to be pushed.

If you have repack support somehow, always sending packs
(especially the thin kind) would make sense, but otherwise you
probably would want some arrangements to make sure many small
packs are periodically consolidated into larger smaller number
of packs, so that they would not fragment the vma of git
programs that run on the server side by mmap()ing them into
their address spaces.
