From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix compilation on newer NetBSD systems
Date: Sun, 14 May 2006 22:31:10 -0700
Message-ID: <7vu07rx3a9.fsf@assigned-by-dhcp.cox.net>
References: <20060511173531.G18d4553c@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 07:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfVfn-00077u-CY
	for gcvg-git@gmane.org; Mon, 15 May 2006 07:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWEOFbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 01:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWEOFbM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 01:31:12 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12538 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932230AbWEOFbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 01:31:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515053111.PPWC17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 01:31:11 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060511173531.G18d4553c@leonov.stosberg.net> (Dennis Stosberg's
	message of "Thu, 11 May 2006 19:35:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20019>

Dennis Stosberg <dennis@stosberg.net> writes:

> NetBSD >=2.0 has iconv() in libc.  A libiconv is not required and
> does not exist.

I do not doubt that, but...

> +	ifeq ($(shell test `uname -r | sed -e 's/^\([0-9]\).*/\1/'` -lt 2 && echo y),y)
> +		NEEDS_LIBICONV = YesPlease
> +	endif

This looks rather ugly.  I do not know if NetBSD has 0.xx
versions, but perhaps something like this?

	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
