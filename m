From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon --base-path
Date: Thu, 22 Dec 2005 20:19:55 -0800
Message-ID: <7vlkycfnro.fsf@assigned-by-dhcp.cox.net>
References: <20051223012739.29168.55858.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 05:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpePd-0006tJ-6g
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 05:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbVLWET6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 23:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVLWET6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 23:19:58 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39111 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030408AbVLWET5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 23:19:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051223041756.YJQK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 23:17:56 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13982>

Petr Baudis <pasky@suse.cz> writes:

> Tommi Virtanen expressed a wish on #git to be able to use short and elegant
> git URLs by making git-daemon 'root' in a given directory. This patch
> implements this, causing git-daemon to interpret all paths relative to
> the given base path if any is given.

This is much nicer than chrooting or having a symlink hanging
under /.  Another possibility would be to have ~git/ a symlink
to such directory and make it a whitelist -- then you do not
need this patch.  The URL would be "git://ho.st/~git/xxx" which
is short-and-sweet.

> +		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
> +		dir = rpath;
> +	}

We probably would want to verify base_path exists and is without
excess trailing slash when parsing arguments, if we are going to
do this.
