From: Junio C Hamano <junkio@cox.net>
Subject: Re: When to run git-update-server-info
Date: Mon, 12 Feb 2007 21:20:52 -0800
Message-ID: <7vps8e3a6j.fsf@assigned-by-dhcp.cox.net>
References: <1171342189.2326.68.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 06:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGq65-0007C0-5F
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 06:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbXBMFUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 00:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbXBMFUy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 00:20:54 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39219 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161070AbXBMFUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 00:20:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213052053.CDDL21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Feb 2007 00:20:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NtLs1W00o1kojtg0000000; Tue, 13 Feb 2007 00:20:53 -0500
In-Reply-To: <1171342189.2326.68.camel@dv> (Pavel Roskin's message of "Mon, 12
	Feb 2007 23:49:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39493>

Pavel Roskin <proski@gnu.org> writes:

> Hello!
>
> It looks like that either the documentation is misleading or git is not
> working as promised.
>
> Documentation/repository-layout.txt says:
>
> info/refs::
>         This file is to help dumb transports to discover what
>         refs are available in this repository.  Whenever you
>         create/delete a new branch or a new tag, `git
>         update-server-info` should be run to keep this file
>         up-to-date if the repository is published for dumb
>         transports.  The `git-receive-pack` command, which is
>         run on a remote repository when you `git push` into it,
>         runs `hooks/update` hook to help you achieve this.
>
> My understanding of the above text is that git-update-server-info only
> needs to be run if a new branch or tag is created, not on every
> git-push.  Just because hooks/update is run on every push, it doesn't
> mean that it needs to be done every time.

I agree the above can be interpreted as such, and documentation
updates is needed.  The information in info/refs are used in
full, not just the list of ref names on the far right of each
line but also the object name at the beginning of each line.

> I understand that accessing one file could be faster over http, so I
> tend to think that it's the documentation needs to be fixed.  If that's
> the case, maybe hooks/update should be created executable by default?

The repository that serve things over http are _minorities_, so
I do not think that is a good idea.
