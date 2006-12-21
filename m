From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Attempt to make git-checkout man page a bit more clear.
Date: Wed, 20 Dec 2006 23:47:42 -0800
Message-ID: <7vbqlx1yht.fsf@assigned-by-dhcp.cox.net>
References: <20061221015350.245cc964.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 08:47:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxIeb-0006OF-GF
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 08:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWLUHro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 02:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWLUHro
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 02:47:44 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47828 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422809AbWLUHrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 02:47:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221074742.OCFB2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 02:47:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Kn01W00F1kojtg0000000; Thu, 21 Dec 2006 02:47:01 -0500
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <20061221015350.245cc964.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Thu, 21 Dec 2006 01:53:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35023>

Sean <seanlkml@sympatico.ca> writes:

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index fbdbadc..97c3afe 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -8,23 +8,29 @@ git-checkout - Checkout and switch to a branch
>  SYNOPSIS
>  --------
>  [verse]
> +'git-checkout' [-f] [-m] <branch>
> +'git-checkout' [-f] [-b <new_branch> [-l]] [-m] [<commit-ish>]
>  'git-checkout' [-m] [<branch>] <paths>...
>  
>  DESCRIPTION
>  -----------
> ...
> +With the third form, this command does *not* switch branches.
> +Instead, it replaces the contents of the named paths in your
> +working tree from the index.  Here, the <branch> argument can be
>  used to specify a specific tree-ish to update the index for the
>  given paths before updating the working tree.

The 'restore from arbitrary tree-ish' form does not take -m as
far as I know.

Although it might be interesting to do a single-file three-way
merge, I do not think the command is _checkout_ anymore once it
starts doing that.

That is:

	$ git checkout -f master
	$ edit file.c
        $ git that-funny-command next file.c

would steal the version of file.c from 'next', and merge the
change your locally did on top of 'master', and put it in your
working tree and in the index.  Technically I can explain how
that work (and how it could be implemented -- which is trivial),
but I cannot explain what that operation _means_.
