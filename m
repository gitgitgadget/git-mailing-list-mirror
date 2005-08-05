From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as well.
Date: Thu, 04 Aug 2005 17:20:25 -0700
Message-ID: <7vll3hqlo6.fsf@assigned-by-dhcp.cox.net>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.62.0508041804120.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: barkalow@iabervon.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 05 02:21:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0px0-0008ED-Pg
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVHEAU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 20:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVHEAU3
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 20:20:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29350 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262794AbVHEAU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 20:20:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050805002026.LSKT1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 20:20:26 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

barkalow@iabervon.org writes:

> ... I seem to recall a patch to create subdirectories of
> .git/refs on demand (needed for tags/v99/1). I'd say just
> .git/objects/(everything), .git/refs, and .git/info.

Having thought about this a bit more, I am inclined to drop
this.  I see the template mechanism to be something that lets
site and project policy makers set up the repositories to suit
their taste, by having their users point their own template
directory via the GIT_TEMPLATE_DIRECTORY environment variable.
How $GIT_DIR/refs/heads/ and $GIT_DIR/refs/tags/ are used are
quite deeply ingrained in the core tools, and there is no point
pretending as if they can be overridden; they are not.

As Daniel says, refs/*/ are created mostly on-demand [*1*], so
it is not strictly necessary to create "heads" and "tags"
upfront, but they are so basic that I'd feel comfortable to keep
them part of what are done by git-init-db.


[Footnote]

*1* I fixed one in receive-pack recently, but please fix things
if you find any of the core tools assume that the leading paths
already exist.
