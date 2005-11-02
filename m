From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Server-side support for user-relative paths.
Date: Tue, 01 Nov 2005 16:14:44 -0800
Message-ID: <7vek5z6h3f.fsf@assigned-by-dhcp.cox.net>
References: <20051101225921.3835C5BF73@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:15:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6HB-0007ld-P0
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVKBAOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVKBAOq
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:14:46 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47352 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751471AbVKBAOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:14:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102001422.VTJP9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 19:14:22 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10977>

Andreas Ericsson <ae@op5.se> writes:

> Remove the redundant code from {receive,upload}-pack.c in favour of the
> library code in path.c (previous patch) with documentation of the changes
> to the affected programs.

I like the simplification of these two calling sites, but it
makes me feel uneasy to see the workhorse named is_git_repo().

The name implies a check to see if the given path is a git repo
or not (i.e. side-effect free predicate), while what it actually
does are three things: (1) resolve and check, (2) chdir to it,
(3) set up GIT_DIR environment.  Not that I have a better name
in mind...

> +	SSH Is the default transport protocol and also supports an

Just a typo ("Is")?
