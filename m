From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disallow empty GIT_AUTHOR_NAME or GIT_COMMITTER_NAME
Date: Fri, 06 Jul 2007 22:45:07 -0700
Message-ID: <7vlkdsdaxo.fsf@assigned-by-dhcp.cox.net>
References: <468E80D3.5060706@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jul 07 07:45:31 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I736o-0007Z8-VK
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 07:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbXGGFpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 01:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbXGGFpK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 01:45:10 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:56606 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbXGGFpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 01:45:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707054509.NCUC1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 01:45:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LVl71X0061kojtg0000000; Sat, 07 Jul 2007 01:45:07 -0400
In-Reply-To: <468E80D3.5060706@nrlssc.navy.mil> (Brandon Casey's message of
	"Fri, 06 Jul 2007 12:50:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51803>

Brandon Casey <casey@nrlssc.navy.mil> writes:

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Attempt normal methods for determining user name if
> GIT_AUTHOR_NAME or GIT_COMMITTER_NAME is set to the empty
> string. Then fall back to using the user login name.
>
> Previously, if these environment variables were set to the
> empty string, a message would be printed complaining about
> missing gecos information. In this case the gecos information
> was never checked.
>
> This still allows an empty GIT_AUTHOR_EMAIL or GIT_COMMITTER_EMAIL.
> Possibly someone would want to use these variables to disable
> the respective email address string?
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Thanks.  But this makes me wonder why you do not do the same
check for !*email

> Then I send the patch to myself using git-format-patch and then
> git-send-email. These two format the patch appropriately for
> submission and allow me to set the message-id.
>
> Then I select the message, right-click and choose "Edit As New...",
> edit, select the recipients, and send. I also now have a record of
> the sent message which I would not have if I used only git-send-email.

I would just add myself to --bcc when running send-email; much
simpler ;-). 

>  ident.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 3d49608..6932ccf 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -193,7 +193,7 @@ const char *fmt_ident(const char *name, const char *email,
>  	int i;
>  
>  	setup_ident();
> -	if (!name)
> +	if (!name || !*name)
>  		name = git_default_name;
>  	if (!email)
>  		email = git_default_email;
> -- 
> 1.5.3.rc0.30.g114f-dirty
