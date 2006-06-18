From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 02:40:58 -0700
Message-ID: <7v8xnu3iol.fsf@assigned-by-dhcp.cox.net>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz>
	<e72j53$1m1$1@sea.gmane.org>
	<46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com>
	<e731ai$su1$1@sea.gmane.org>
	<20060618113052.660e1017.tihirvon@gmail.com>
	<e735d7$6dq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 18 11:41:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrtmD-0007nf-Fz
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 11:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWFRJlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 05:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFRJlA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 05:41:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7061 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750752AbWFRJk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 05:40:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618094059.QEXX554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 05:40:59 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e735d7$6dq$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	18 Jun 2006 11:12:21 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22066>

Jakub Narebski <jnareb@gmail.com> writes:

> Timo Hirvonen wrote:
>
>> Just use "git command" and you don't have to know $gitexecdir.
>
> First, 'git' might be not in PATH for the webserver user which runs
> gitweb.cgi.

For that we would have a chicken-and-egg problem if we make
configuration mechanism based on git-repo-config, so I would say
per-site customization is needed somehow.

Hardcoding the path into gitweb.cgi could be one way.
Hardcoding the path to gitweb per-site configuration file and
implement the logic to parse the configuration file without
using git-repo-config would be another.  Even if you wanted to
use "git --exec-path" to bootstrap, not having "git" in the path
would make it, eh, cumbersome.

My gut feeling is that it is sensible to assume git is on
everybody's path -- after all the site is running gitweb and
majority would be using binary packaged distribution, so git
would be installed somewhere sensible and accessible.

So I am with Timo on this one, except that in some cases munging
gitweb.cgi script itself might be needed if the installation
chose to hide git somewhere inaccessible from ordinary users.
