From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix tracing when GIT_TRACE is set to an empty string.
Date: Sat, 14 Oct 2006 11:11:05 -0700
Message-ID: <7vodseahty.fsf@assigned-by-dhcp.cox.net>
References: <20061014160525.c013e6d2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 20:11:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYnyj-0007ya-4b
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 20:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWJNSLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 14:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWJNSLI
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 14:11:08 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:15759 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422739AbWJNSLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 14:11:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061014181106.QLJ12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Oct 2006 14:11:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aJB81V00f1kojtg0000000
	Sat, 14 Oct 2006 14:11:09 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20061014160525.c013e6d2.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 14 Oct 2006 16:05:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28885>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  trace.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/trace.c b/trace.c
> index f9efc91..495e5ed 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -55,7 +55,8 @@ static int get_trace_fd(int *need_close)
>  {
>  	char *trace = getenv("GIT_TRACE");
>  
> -	if (!trace || !strcmp(trace, "0") || !strcasecmp(trace, "false"))
> +	if (!trace || !strcmp(trace, "") ||
> +	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
>  		return 0;
>  	if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
>  		return STDERR_FILENO;
> -- 
> 1.4.3.rc2.gadba

This means that

	GIT_TRACE= git-foo
and
	unset GIT_TRACE ; git-foo

should behave the same way, right?

If so that sounds sensible.
