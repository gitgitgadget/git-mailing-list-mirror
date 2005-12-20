From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix unconditional early exit in cg-fetch
Date: Mon, 19 Dec 2005 17:15:19 -0800
Message-ID: <7vpsnso9g8.fsf@assigned-by-dhcp.cox.net>
References: <20051219161736.18245.98591.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 02:17:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoW6Z-0008T4-AY
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 02:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLTBPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 20:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVLTBPW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 20:15:22 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23244 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750724AbVLTBPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 20:15:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051220011431.JSMS20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 20:14:31 -0500
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20051219161736.18245.98591.stgit@zion.home.lan> (Paolo
	Giarrusso's message of "Mon, 19 Dec 2005 17:17:36 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13842>

Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:

>  	if [ "$get" = "get_rsync" ]; then
>  		$get -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" ||
> -			echo "unable to get tags list (non-fatal)" >&2
> -		exit $?
> +			(echo "unable to get tags list (non-fatal)" >&2;
> +			exit $?)
>  	fi

Why would you want a subshell that exits with a non-zero status
when nobody is checking that status anyway?

I suspect removing "exit $?" would suffice, if that condition is
non-fatal as the message says...
