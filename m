From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 17:03:24 +0200
Message-ID: <48D11C3C.5070707@op5.se>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com> <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vmiklos@frugalware.org,
	Johannes.Schindelin@gmx.de
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Wed Sep 17 17:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfyaC-0006PJ-S9
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 17:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYIQPDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 11:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYIQPDg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 11:03:36 -0400
Received: from mail.op5.se ([193.201.96.20]:58749 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbYIQPDf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 11:03:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 24A191B800AE;
	Wed, 17 Sep 2008 16:53:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yxyHqKqhkHLq; Wed, 17 Sep 2008 16:53:25 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 946F71B8008F;
	Wed, 17 Sep 2008 16:53:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96119>

Jonathan del Strother wrote:
> Add support for recognition of Objective-C class & instance methods, C functions, and class implementation/interfaces.
> 
> Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
> ---
> This version anchors the negated match to the beginning of the line, and shuffles the comments around to avoid the excessively long lines.  Better?
> 

Why do you insist on touching surrounding patterns? I've left them in
from your patch below so you can see where you're going wrong. Those
changes provide no value and make your patch harder to read. If you
want to make that cleanup, submit it separately, as it has nothing
to do with teaching git diff about objective C methods.


> diff --git a/diff.c b/diff.c
> index 998dcaa..e5ec503 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1398,17 +1398,31 @@ static struct builtin_funcname_pattern {
>  } builtin_funcname_pattern[] = {
>  	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
>  	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$" },
> -	{ "java", "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
> +
> +	{ "java", "!^[ \t]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
>  			"new\\|return\\|switch\\|throw\\|while\\)\n"
> -			"^[ 	]*\\(\\([ 	]*"
> +			"^[ \t]*\\(\\([ \t]*"
>  			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
> -			"[ 	]*([^;]*\\)$" },
> +			"[ \t]*([^;]*\\)$" },
> +

The above should be in a separate patch.

>  	{ "pascal", "^\\(\\(procedure\\|function\\|constructor\\|"
>  			"destructor\\|interface\\|implementation\\|"
>  			"initialization\\|finalization\\)[ \t]*.*\\)$"
>  			"\\|"
> -			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"
> -			},
> +			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"},
> +

This last change is just pure nonsense. Please remove it altogether.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
