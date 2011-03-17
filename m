From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: highlight: replace tabs with spaces
Date: Thu, 17 Mar 2011 03:04:15 -0700 (PDT)
Message-ID: <m3pqpq5aiv.fsf@localhost.localdomain>
References: <6ac7d48cfdf4192c3240c1ecbd4e5522@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:04:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0A48-0005lg-0S
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 11:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab1CQKET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 06:04:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65020 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab1CQKES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 06:04:18 -0400
Received: by bwz15 with SMTP id 15so2302196bwz.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=UnXaOyKSPNn2L9QOAlQPK8jj7EHwsf48QJe+84y7NIk=;
        b=IowHoaNP9b3OkDTlsg1+uJfkRlKaqVla+bAlYs4oYYM2AkIwLzNSjm9Kd4E/eVJExQ
         jtYiT+78XWjQHanF0mDfh1R/H+S1fVygCGD4G0Kt9W8wm8JK3VldTl2hgU1TZEq7xeZW
         yrnkE7jKkRrt4xJAy8p4oHnd0ofxKL/ROVchQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=uyS1PAeaUD4+mvf4Eg54u9vbb1KaJSqARTnkWmELn7BMq3dc1loa+23Qert7/OGTDl
         9dq6wGknym9W5LY5ajK8kTDB1n6s73dbH83icRGhrEYle8JG3xGMZJ+/TkomHxoDN+bk
         FTcghHDqE4zXjBDU2U0Z6yK7EaB3ECFJndo5o=
Received: by 10.204.19.14 with SMTP id y14mr940496bka.187.1300356256962;
        Thu, 17 Mar 2011 03:04:16 -0700 (PDT)
Received: from localhost.localdomain (abvc119.neoplus.adsl.tpnet.pl [83.8.200.119])
        by mx.google.com with ESMTPS id v21sm1237979bkt.11.2011.03.17.03.04.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 03:04:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2HA3lHg007689;
	Thu, 17 Mar 2011 11:03:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2HA3bl9007686;
	Thu, 17 Mar 2011 11:03:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <6ac7d48cfdf4192c3240c1ecbd4e5522@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169229>

Kevin Cernekee <cernekee@gmail.com> writes:

> Consider the following code fragment:
> 
>         /*
>          * test
>          */
> 
> vim ":set list" mode shows that the first character on each line is a
> tab:
> 
> ^I/*$
> ^I * test$
> ^I */$
> 
> By default, the "highlight" program will retain the tabs in the HTML
> output:
> 
> $ highlight --fragment --syntax c test.c
>         <span class="hl com">/*</span>
> <span class="hl com">    * test</span>
> <span class="hl com">    */</span>
> 
> vim list mode:
> 
> ^I<span class="hl com">/*</span>$
> <span class="hl com">^I * test</span>$
> <span class="hl com">^I */</span>$
> 
> In gitweb, this winds up looking something like:
> 
>    1         /*
>    2     * test
>    3     */
> 
> I tried both Firefox and Opera and saw the same behavior.
> 
> The desired output is:
> 
>    1         /*
>    2          * test
>    3          */
> 
> This can be accomplished by specifying "--replace-tabs=8" on the
> highlight command line.

Very well written commit message.

> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

I was wondering if ancient highlight (2.4.5) that I use supports
--replace-tabs option... but it does.

So for what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d171ad5..649e10a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3485,7 +3485,7 @@ sub run_highlighter {
>  	close $fd;
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>  	          quote_command($highlight_bin).
> -	          " --fragment --syntax $syntax |"
> +	          " --replace-tabs=8 --fragment --syntax $syntax |"
>  		or die_error(500, "Couldn't open file or run syntax highlighter");
>  	return $fd;
>  }

I wonder if we should synchronize this value with '8' in untabify(),
but I think it is out of scope of this patch.

BTW., weren't there patch that made tab width customizable?  What
happened to it?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
