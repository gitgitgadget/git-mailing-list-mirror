From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] copy_fd: close ifd on error
Date: Tue, 27 Dec 2005 01:02:41 -0800
Message-ID: <7vpsnic3pq.fsf@assigned-by-dhcp.cox.net>
References: <20051227081905.GA9946@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 10:02:48 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErAjH-0007RD-D7
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 10:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVL0JCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 04:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVL0JCn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 04:02:43 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:15058 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932255AbVL0JCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 04:02:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051227090149.TJBE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 04:01:49 -0500
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20051227081905.GA9946@mars.ravnborg.org> (Sam Ravnborg's message
	of "Tue, 27 Dec 2005 09:19:05 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14073>

Sam Ravnborg <sam@ravnborg.org> writes:

> In copy_fd when write fails we ought to close input file descriptor.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>
> Found while looking at the source for inspiration for something else.
> I did not see any error related to this.

Thanks.  I think the only place this matters is git-local-fetch
which nobody uses these days where it can leak handful ifd.
All other users immediately exit upon seeing failure return from
the function.

Of course this would matter much when we do libification.
