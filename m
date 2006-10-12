From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-revert with conflicts to behave as git-merge with conflicts
Date: Thu, 12 Oct 2006 15:27:30 -0700
Message-ID: <7vejtdkw4t.fsf@assigned-by-dhcp.cox.net>
References: <20061012215242.16419.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:38:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY91b-0004gN-0I
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWJLW1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWJLW1c
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:27:32 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38836 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751214AbWJLW1c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:27:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061012222731.VTDQ2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 18:27:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZaTL1V00M1kojtg0000000
	Thu, 12 Oct 2006 18:27:21 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061012215242.16419.qmail@web31810.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 12 Oct 2006 14:52:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28810>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -441,7 +441,7 @@ then
>  elif test "$use_commit" != ""
>  then
>  	git-cat-file commit "$use_commit" | sed -e '1,/^$/d'
> -elif test -f "$GIT_DIR/MERGE_HEAD" && test -f "$GIT_DIR/MERGE_MSG"
> +elif test -f "$GIT_DIR/MERGE_MSG"
>  then
>  	cat "$GIT_DIR/MERGE_MSG"
>  elif test -f "$GIT_DIR/SQUASH_MSG"

If you rely on MERGE_MSG then you would need to clean it after
commit is done.  Currently it does not and checks MERGE_HEAD,
and cleans up MERGE_HEAD when it is done.  MERGE_MSG is not
cleaned.
