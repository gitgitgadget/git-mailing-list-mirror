From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] rebase: check for errors from git-commit
Date: Wed, 28 Jun 2006 02:25:29 -0700
Message-ID: <7v1wt94oom.fsf@assigned-by-dhcp.cox.net>
References: <11514858662929-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 11:25:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvWIh-0004aT-Kb
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWF1JZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWF1JZc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:25:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39054 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030360AbWF1JZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 05:25:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628092530.SPZA6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 05:25:30 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11514858662929-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Wed, 28 Jun 2006 02:11:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22790>

Eric Wong <normalperson@yhbt.net> writes:

>  I've grown used to having 'set -e' at the beginning of my shell
>  scripts.  IMHO it'd be a good idea to start moving towards this
>  eventually (even though shell scripts seem to be getting phased-out
>  somewhat).
>
>  git-rebase.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 9ad1c44..47c8e8f 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -59,8 +59,8 @@ continue_merge () {
>  
>  	if test -n "`git-diff-index HEAD`"
>  	then
> +		git-commit -C "`cat $dotest/current`" || die 'Commit failed'
>  		printf "Committed: %0${prec}d" $msgnum
> -		git-commit -C "`cat $dotest/current`"

Anticipating failure from "git-commit" is the right thing to do,
but this is a "Now what?" situation.  What is the expected
course of action to recover from this for the end user, and how
can we phrase the error message to help that process?
