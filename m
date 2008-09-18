From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] avoid gitweb uninitialized value warning
Date: Thu, 18 Sep 2008 08:13:35 -0700 (PDT)
Message-ID: <m3abe5mqs8.fsf@localhost.localdomain>
References: <20080905182629.GA22030@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:14:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLDW-0002mi-TX
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbYIRPNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbYIRPNk
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:13:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:13752 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbYIRPNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:13:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so249522fgg.17
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=XtaprQvTzpHR0VBRHboK7phchK0Tl/zgfVBfZN3xBP4=;
        b=RNEJX0g6M10IVgb06eMSzPtmqqTKiJOUJhB4at9ZExAfKh/nYknkqABnKFGFC6/FFC
         E9YRHuIE8rih00lt9NUMeaHXOeGUWwsUBCLhTKmGvh2+KcFSepKS9wHRYSG1ovK1YaMO
         ejatU9y+fOFzvxBF+6olGtUjAfOqtZvig+Vfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=NVg72ee3JGAqoPrt2nOmxsiqVVZtZTdXioL6DsFKwvVFAy5bYwQ02QTcrglsAnUwBS
         lyt+emiQLI/LaLTYBDULCEciHcrdsOQBvCf8tFnk7fL7dzLlnlzSPzAz1KdqAJNG2Kn6
         JYlNng95wYJA47iQpYOFrvTcPvdVjdeL9XY3g=
Received: by 10.181.14.2 with SMTP id r2mr1976150bki.74.1221750817049;
        Thu, 18 Sep 2008 08:13:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.202.248])
        by mx.google.com with ESMTPS id 28sm20274480fkx.1.2008.09.18.08.13.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 08:13:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8IFD18f014223;
	Thu, 18 Sep 2008 17:13:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8IFCivp014219;
	Thu, 18 Sep 2008 17:12:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080905182629.GA22030@kodama.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96198>

Joey Hess <joey@kitenet.net> writes:
> Subject: [PATCH] avoid gitweb uninitialized value warning

I would say _where_ this uninitialized value warning was, e.g.

Subject: [PATCH] gitweb: avoid warnings for commits with no body

>
> In the ususual case when there is no commit message, gitweb would
> output an uninitialized value warning.

Typo: s/ususual/unusual/

> 
> Signed-off-by: Joey Hess <joey@kitenet.net>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 29e2156..da474d0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2123,7 +2123,7 @@ sub parse_commit_text {
>  			last;
>  		}
>  	}
> -	if ($co{'title'} eq "") {
> +	if (! defined $co{'title'} || $co{'title'} eq "") {

I would avoid space between logical negation operator '!' and
its operand, i.e. I would write:

+	if (!defined $co{'title'} || $co{'title'} eq "") {

>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>  	}
>  	# remove added spaces
> -- 
> 1.5.6.5
> 
> -- 
> see shy jo

-- 
Jakub Narebski
Poland
ShadeHawk on #git
