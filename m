From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] Use remote functions in git-push
Date: Sat, 28 Apr 2007 22:45:39 -0700
Message-ID: <7vzm4rg2d8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304190.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 07:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi2EU-0000fp-HT
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 07:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbXD2Fpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 01:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192AbXD2Fpl
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 01:45:41 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39217 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbXD2Fpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 01:45:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429054542.OQLD13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 01:45:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id stlf1W00X1kojtg0000000; Sun, 29 Apr 2007 01:45:40 -0400
In-Reply-To: <Pine.LNX.4.64.0704281304190.28708@iabervon.org> (Daniel
	Barkalow's message of "Sat, 28 Apr 2007 13:05:14 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45810>

Daniel Barkalow <barkalow@iabervon.org> writes:

> diff --git a/builtin-push.c b/builtin-push.c
> index cb78401..2e944cd 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -5,6 +5,7 @@
>  #include "refs.h"
>  #include "run-command.h"
>  #include "builtin.h"
> +#include "remote.h"

As I am rejecting the initial round of [PATCH 2/5], I only gave
a cursory look at this one, but it seems straightforward code
shuffling and nothing controversial.

I however would have liked a patch that moves bulk of remote
parsing code from builtin-push.c to remote.c without adding
anything that builtin-push.c did not have (i.e. fetch refspecs
handling).  That is, half of [PATCH 2/5] and this patch should
have been a single patch that says "this moves code from
builtin-push.c to remote.c, while abstracting out the static
variables into struct remote, without doing anything else".

Then later you enhance the remote.c interface to deal with fetch
refspecs and stuff in separate patches.

>  
>  #define MAX_URI (16)

I do not think you need this anymore...
