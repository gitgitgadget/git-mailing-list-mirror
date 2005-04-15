From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Plug memory leak in update-cache.c
Date: Sat, 16 Apr 2005 01:48:07 +0200
Message-ID: <20050415234807.GS7417@pasky.ji.cz>
References: <1113468830.23299.85.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 16 01:44:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMaUO-0000mi-TJ
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 01:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVDOXsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 19:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVDOXsQ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 19:48:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63715 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262365AbVDOXsM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 19:48:12 -0400
Received: (qmail 5351 invoked by uid 2001); 15 Apr 2005 23:48:07 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113468830.23299.85.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 10:53:50AM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Hi,
> 
> Might not be that an big an issue as it should be freed on exit, but
> might cause problems with big trees.
> 
> ----
> 
> Plug memory leak in update-cache.c.
> 
> Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> 
> update-cache.c:  22f3ccd47db4f0888901109a8cbf883d272d1cba
> --- 22f3ccd47db4f0888901109a8cbf883d272d1cba/update-cache.c
> +++ uncommitted/update-cache.c
> @@ -202,6 +202,7 @@
>                         printf("%s: needs update\n", ce->name);
>                         continue;
>                 }
> +               free(active_cache[i]);
>                 active_cache[i] = new;
>         }
>  }

FYI, new could've contained active_cache[i] at that time, so you needed
to check for that. Fixed though, thanks for pointing it out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
