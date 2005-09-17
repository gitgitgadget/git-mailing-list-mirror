From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix fetch completeness assumptions
Date: Sat, 17 Sep 2005 01:32:06 -0700
Message-ID: <7vacicccxl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
	<7vhdckceas.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Sep 17 10:33:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGY7T-0005mM-Cp
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 10:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVIQIcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 04:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVIQIcI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 04:32:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37024 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751010AbVIQIcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 04:32:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917083206.DHLX23945.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Sep 2005 04:32:06 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vhdckceas.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 17 Sep 2005 01:02:35 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8760>

Junio C Hamano <junkio@cox.net> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> Don't assume that any commit we have is complete; assume that any ref
>> we have is complete.
>
> Have you tested this idea with cloning into an empty repository?
> It seems to break my tests.

Sorry, I spoke too fast.  This is not _broken_ per se, but is
just slow.

I tried to clone http://kernel.org/pub/scm/git.git/; bulk of the
objects are packed there but the new code is _too_ cautious,
since it did not have any refs to begin with, it ended up
walking the commits in the already downloaded packs to the root.
