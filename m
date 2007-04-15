From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH] entry.c: Use strerror() to print error info when
 possible
Date: Sun, 15 Apr 2007 20:57:09 -0300
Organization: Mandriva
Message-ID: <20070415205709.27d7e475@gnut>
References: <20070415185619.3fa90f3a@gnut>
	<20070415230020.GC4417@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEaz-0003e6-93
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbXDOX5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbXDOX5R
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:57:17 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:49254 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbXDOX5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:57:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 7785318B6B;
	Sun, 15 Apr 2007 20:57:15 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id br87INzTxDSd; Sun, 15 Apr 2007 20:57:13 -0300 (BRT)
Received: from gnut (unknown [201.21.180.171])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 8982918B67;
	Sun, 15 Apr 2007 20:57:12 -0300 (BRT)
In-Reply-To: <20070415230020.GC4417@steel.home>
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44552>

Em Mon, 16 Apr 2007 01:00:20 +0200
Alex Riesen <raa.lkml@gmail.com> escreveu:

| Luiz Fernando N. Capitulino, Sun, Apr 15, 2007 23:56:19 +0200:
| > 
| > Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
| > ---
| >  entry.c |   11 ++++++-----
| >  1 files changed, 6 insertions(+), 5 deletions(-)
| > 
| > diff --git a/entry.c b/entry.c
| > index d72f811..c36c09d 100644
| > --- a/entry.c
| > +++ b/entry.c
| > @@ -19,7 +19,8 @@ static void create_directories(const char *path, struct checkout *state)
| >  				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
| >  					continue; /* ok */
| >  			}
| > -			die("cannot create directory at %s", buf);
| > +			die("cannot create directory at %s (%s)", buf,
| > +			    strerror(errno));
| 
| This errno is not very useful, as it may come from the stat above, and
| you provided no way to figure out what was the syscall (the mkdir or
| the stat) which failed. Also, the errnos of unlink or mkdir just above
| the stat are just lost.
| 
| It is not worse than before, but not very much better either, and
| probably confusing. I suggest you just leave this one as it is.

 Will do, thanks for reviewing Alex.
