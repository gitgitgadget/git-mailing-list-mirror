From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add date format --local-zone
Date: Wed, 25 Apr 2007 14:40:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704251438000.6954@racer.site>
References: <1177482982542-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 14:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HggnO-0005FR-2X
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 14:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161855AbXDYMk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 08:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965573AbXDYMk0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 08:40:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:34835 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965552AbXDYMk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 08:40:26 -0400
Received: (qmail invoked by alias); 25 Apr 2007 12:40:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 25 Apr 2007 14:40:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GMcJqdyvGOY8a3SwJEM/IzbHLqzWi4zaaZmkS7K
	+bktqPIAijJi5s
X-X-Sender: gene099@racer.site
In-Reply-To: <1177482982542-git-send-email-junkio@cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45520>

Hi,

On Tue, 24 Apr 2007, Junio C Hamano wrote:

> --- a/revision.c
> +++ b/revision.c
> @@ -1111,7 +1111,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  				continue;
>  			}
>  			if (!strcmp(arg, "--relative-date")) {
> -				revs->relative_date = 1;
> +				revs->date_mode = DATE_RELATIVE;
> +				continue;
> +			}
> +			if (!strcmp(arg, "--local-zone")) {
> +				revs->date_mode = DATE_LOCAL;
>  				continue;
>  			}
>  

I think that it will become more convenient at some stage to add 
"--date=local", and have a common option parser in date.c.

> diff --git a/revision.h b/revision.h
> index 5b41e2d..8f8720a 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -64,7 +64,7 @@ struct rev_info {
>  	/* Format info */
>  	unsigned int	shown_one:1,
>  			abbrev_commit:1,
> -			relative_date:1;
> +			date_mode:2;

Why not go the full nine yards, and make this a full int? It's not like 
rev_info is allocated a million times...

Ciao,
Dscho
