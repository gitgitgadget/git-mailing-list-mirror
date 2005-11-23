From: Junio C Hamano <junkio@cox.net>
Subject: Re: Allow editing of a revert-message
Date: Wed, 23 Nov 2005 11:29:32 -0800
Message-ID: <7v7jaz5fj7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511230954440.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 23 20:30:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef0JG-0005D1-Pq
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 20:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVKWT3f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 14:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKWT3f
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 14:29:35 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16269 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932120AbVKWT3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 14:29:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123192827.VPTH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 14:28:27 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511230954440.13959@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 23 Nov 2005 09:57:54 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12643>

Linus Torvalds <torvalds@osdl.org> writes:

> ..., although I 
> actually suspect it should be on by default (and we should have a 
> "--no-edit" flag to disable it, probably together with an automatic 
> disable if stdin isn't a terminal).

Thanks, and I agree.  It is very very unlikely that somebody has
git-revert in her script and relies on git-revert to be
non-interactive, so we might not even need --no-edit.

> +[ "$edit" ] && ${EDITOR:-${VISUAL:-vi}} .msg
>  case "$no_commit" in
>  '')
>  	git-commit -n -F .msg

I think we can do

	-e)
		edit="-e" ;;
        ..

	git-commit -n -F .msg $edit

to lose the ${EDITOR-${VISUAL-vi}} part..
