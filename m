From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 16:50:01 -0800
Message-ID: <7vhcujzxza.fsf@assigned-by-dhcp.cox.net>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<ep00nl$mop$1@sea.gmane.org>
	<Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
	<17843.55730.456139.247155@lisa.zopyra.com>
	<Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
	<Pine.LNX.4.64.0701211554450.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 01:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8nNx-0000gz-IH
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 01:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbXAVAuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 19:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXAVAuE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 19:50:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53745 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbXAVAuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 19:50:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122005002.VKCZ7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 19:50:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E0qK1W00w1kojtg0000000; Sun, 21 Jan 2007 19:50:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211554450.14248@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 21 Jan 2007 16:17:20 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37371>

Linus Torvalds <torvalds@osdl.org> writes:

> So Junio, I'd suggest adding this whether you then want to add the trivial 
> code to allow pushing over git:// too or not. One less special case to 
> worry about.
>
> 		Linus
>
> ---
> diff --git a/connect.c b/connect.c
> index 66daa11..7844888 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -529,7 +529,7 @@ static void git_tcp_connect(int fd[2], char *host)
>  	int sockfd = git_tcp_connect_sock(host);
>  
>  	fd[0] = sockfd;
> -	fd[1] = sockfd;
> +	fd[1] = dup(sockfd);
>  }

Yeah, I think this is very sensible thing to do.
