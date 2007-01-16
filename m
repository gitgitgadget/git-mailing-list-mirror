From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Mon, 15 Jan 2007 18:46:46 -0800
Message-ID: <7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>
References: <17437.1168911089@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 03:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6eLb-0000oZ-GB
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 03:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbXAPCqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 21:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXAPCqs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 21:46:48 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35500 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbXAPCqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 21:46:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070116024647.RXTN9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 15 Jan 2007 21:46:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Belt1W00p1kojtg0000000; Mon, 15 Jan 2007 21:45:54 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <17437.1168911089@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Mon, 15 Jan 2007 17:31:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36912>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> Not all echos know -n.  This was causing a test failure in
> t5401-update-hooks.sh, but not t3800-mktag.sh for some reason.

We have done this already so it might be too late to raise this
question, but does everybody have printf?

> diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
> index 25901e2..b996996 100644
> --- a/contrib/remotes2config.sh
> +++ b/contrib/remotes2config.sh
> @@ -11,7 +11,7 @@ if [ -d "$GIT_DIR"/remotes ]; then
>  	{
>  		cd "$GIT_DIR"/remotes
>  		ls | while read f; do
> -			name=$(echo -n "$f" | tr -c "A-Za-z0-9" ".")
> +			name=$(printf "$f" | tr -c "A-Za-z0-9" ".")

This should almost be safe as no sane person would have a remote
whose name is 'foo%s'...
