From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Support for SSL client cert
Date: Mon, 26 Sep 2005 13:43:39 -0700
Message-ID: <7v3bnrh85g.fsf@assigned-by-dhcp.cox.net>
References: <20050926175156.GB9410@reactrix.com>
	<20050926182341.GA26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 22:46:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzpJ-0007gX-06
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVIZUnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVIZUnm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:43:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12476 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750731AbVIZUnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 16:43:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926204341.KSXO9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 16:43:41 -0400
To: Petr Baudis <pasky@suse.cz>, Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050926182341.GA26340@pasky.or.cz> (Petr Baudis's message of
	"Mon, 26 Sep 2005 20:23:41 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9332>

Petr Baudis <pasky@suse.cz> writes:

> Could we please have at least --sslkey, if not having 'ssl' prepended to
> all of them? You never know when you'll want to call something else like
> that in the future... ;-)

That is a valid concern.

Anoter possibility is to read them from the environment, since
we already do SSL_NO_VERIFY from there.

If we go that route, it might make sense to have something like
the following in .git/remotes/that-site file:

    URL: https://some.company.site.xz
    ENV: GIT_SSL_KEY='/home/user/.ssl/'My ssl key'
    ENV: GIT_SSL_CERT='/home/user/.ssl/certs/My Certificate'
    ENV: GIT_SSL_CAPATH='/home/user/.ssl/My CA'
    ...

then at the beginning of git-fetch, we could eval these ENV
lines.
