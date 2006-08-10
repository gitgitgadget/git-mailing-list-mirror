From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 10:27:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101022350.13885@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608100957050.13885@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk65hvw92.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 10:27:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5sp-0004NQ-GI
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 10:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWHJI1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWHJI1K
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 04:27:10 -0400
Received: from mail.gmx.de ([213.165.64.20]:24270 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751333AbWHJI1I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 04:27:08 -0400
Received: (qmail invoked by alias); 10 Aug 2006 08:27:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 10 Aug 2006 10:27:06 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk65hvw92.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25171>

Hi,

On Thu, 10 Aug 2006, Junio C Hamano wrote:

> I tried it [--color-words] on this:
> 
> diff --git a/builtin-apply.c b/builtin-apply.c
> index c159873..be2c715 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1700,10 +1700,8 @@ static int apply_data(struct patch *patc
>  		return -1;
>  
>  	/* NUL terminate the result */
> -	if (desc.alloc <= desc.size) {
> +	if (desc.alloc <= desc.size)
>  		desc.buffer = xrealloc(desc.buffer, desc.size + 1);
> -		desc.alloc++;
> -	}
>  	desc.buffer[desc.size] = 0;
>  
>  	patch->result = desc.buffer;
> 
> which shows something like:
> 
> diff --git a/builtin-apply.c b/builtin-apply.c
> index c159873..be2c715 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1700,10 +1700,8 @@ static int apply_data(struct patch *patc
>                 return -1;
> 
>         /* NUL terminate the result */
>         if (desc.alloc <= desc.size)
> {
>                 desc.buffer = xrealloc(desc.buffer, desc.size + 1);
>                 desc.alloc++;
>         }
>         desc.buffer[desc.size] = 0;
> 
>         patch->result = desc.buffer;
> 
> where "desc.alloc++;" and next lines and the opening brace after
> if() are red.  Why does that red opening brace have to come at
> the beginning of line, I wonder...

It is an implementation detail: to determine the differing words, I turn 
all whitespace into newlines in that particular hunk, and then run another 
diff (nested diff run!). So, the space in --- and the newline in +++ 
compare equal. Since wI am mostly interested in the _new_ (gree) version, 
the newline is printed, not the space.

Hmmm. I have to think about it.

Ciao,
Dscho
