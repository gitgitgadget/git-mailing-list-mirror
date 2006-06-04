From: Junio C Hamano <junkio@cox.net>
Subject: Re: git daemon directory munging?
Date: Sat, 03 Jun 2006 23:27:32 -0700
Message-ID: <7vverhcu5n.fsf@assigned-by-dhcp.cox.net>
References: <E1FmgFV-0001i6-Kc@jdl.com>
	<Pine.LNX.4.64.0606031722340.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 08:27:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmm5J-0002N0-2h
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 08:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWFDG1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 02:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWFDG1e
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 02:27:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:61158 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932074AbWFDG1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 02:27:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604062733.VHG24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 02:27:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21247>

Linus Torvalds <torvalds@osdl.org> writes:

> diff --git a/connect.c b/connect.c
> index 54f7bf7..36c5d04 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -374,7 +374,7 @@ static int git_tcp_connect(int fd[2], co
>  
>  	fd[0] = sockfd;
>  	fd[1] = sockfd;
> -	packet_write(sockfd, "%s %s\n", prog, path);
> +	packet_write(sockfd, "%s %s%c%s%c%s\n", prog, path, 0, host, 0, port);
>  	return 0;
>  }

Adding host like HTTP does with Host: header makes sense but I
think the accept side can usually tell what the port it accepted
the connection to is.
