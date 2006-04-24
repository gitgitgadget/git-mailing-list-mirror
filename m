From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-stash to stash the working tree to a new tagged name
Date: Mon, 24 Apr 2006 13:54:39 -0700
Message-ID: <7vfyk27kz4.fsf@assigned-by-dhcp.cox.net>
References: <8764kyzrwq.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 22:54:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY84x-00013d-Oc
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 22:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDXUyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWDXUyl
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 16:54:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:46523 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751264AbWDXUyk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 16:54:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424205440.IUKR17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Apr 2006 16:54:40 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <8764kyzrwq.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	24 Apr 2006 12:37:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19109>

Carl Worth <cworth@cworth.org> writes:

> Stashing (on branch 'feature'):
>
> 	git commit -a -m 'snapshot WIP'
>
> Recovering:
>
> 	git checkout feature
> 	git reset --soft HEAD^
> 	git reset

If I were doing this today, I would probably do this:

	git commit -a -m 'WIP'

        git checkout elsewhere ;# interrupted
        ... hack hack hack ...

        git checkout feature ;# come back
        ... hack hack hack ...
        git commit --amend

But I wonder why the originally suggested sequence is reset soft
to the state we want and then another reset.  Without
experimenting myself or thinking hard about it, I would expect
"git reset HEAD^" should do what we want, in which case:

Stashing (on branch 'feature'):

	git commit -a -m 'snapshot WIP'

Recovering:

	git checkout feature
	git reset HEAD^
