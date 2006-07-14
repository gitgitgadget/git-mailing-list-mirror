From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Avoid using the git wrapper in git-rebase.sh.
Date: Fri, 14 Jul 2006 09:26:34 -0700
Message-ID: <7vpsg8qhj9.fsf@assigned-by-dhcp.cox.net>
References: <20060714044655.GA1982@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 18:26:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1QUx-0002Tk-3N
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 18:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWGNQ0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 12:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWGNQ0g
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 12:26:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41140 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161217AbWGNQ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 12:26:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714162635.JXCN6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 12:26:35 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23897>

Shawn Pearce <spearce@spearce.org> writes:

> Ideally 'shipped' commands (e.g. git-rebase) should avoid calling
> the git wrapper when executing other commands to prevent the user
> from shadowing those commands with aliases and causing the shipped
> command behavior to differ unexpectedly.

In order to avoid confusion, we made aliases not to shadow real
commands, so this is not an argument to support this patch.

On distros that package git with gitexecdir set to somewhere not
on normal user $PATH, users are expected to use "git" wrapper to
invoke any commands (including git-rebase, so the user would say
"git rebase"), and "git" wrapper sets up the PATH to contain the
gitexecdir while it runs the subcommands, so spelling them
either way, be it "git am" or "git-am", is just fine.

>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  git-rebase.sh |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 1b9e986..6d06665 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -131,7 +131,7 @@ do
>  			finish_rb_merge
>  			exit
>  		fi
> -		git am --resolved --3way --resolvemsg="$RESOLVEMSG"
> +		git-am --resolved --3way --resolvemsg="$RESOLVEMSG"
>  		exit
>  		;;
>  	--skip)
