From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Wed, 12 Mar 2014 16:47:24 +0100
Message-ID: <5320818C.8070200@web.de>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 16:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNlNZ-0005ma-KY
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 16:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbaCLPrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 11:47:32 -0400
Received: from mout.web.de ([212.227.15.3]:61722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776AbaCLPra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 11:47:30 -0400
Received: from [192.168.178.41] ([84.132.147.182]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MLPRu-1WOJbm2aIc-000YSE; Wed, 12 Mar 2014 16:47:28
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:kgfJmgLPrrhgrr6HsGX+pDwQdAlmfVxXTwL/AGk0JP6qyYSrZvK
 IwQ91vW9M84uJATjQJ5ibJu6p2NqaAgIImIXyitAu+hbXEWgmXStwoaibKCq2+J1JhMjQRk
 f2L5gV8vGMyLSm1e7FmLPt9nPQssN9yrOsGInQtBAAF0BHsOhWXjORXGao/aKtIV70sLBQK
 Dn8RRE50CguRbJikgPR0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243941>

Am 12.03.2014 14:44, schrieb Quint Guvernator:
> memcmp() is replaced with starts_with() when comparing strings from the
> beginning. starts_with() looks nicer and it saves the extra argument of
> the length of the comparing string.
> 
> Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
> ---

...

> diff --git a/submodule.c b/submodule.c
> index b80ecac..1edebc1 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -203,7 +203,7 @@ void gitmodules_config(void)
>  			if (active_nr > pos) {  /* there is a .gitmodules */
>  				const struct cache_entry *ce = active_cache[pos];
>  				if (ce_namelen(ce) == 11 &&
> -				    !memcmp(ce->name, ".gitmodules", 11))
> +				    !starts_with(ce->name, ".gitmodules"))
>  					gitmodules_is_unmerged = 1;
>  			}
>  		} else if (pos < active_nr) {

I think this hunk should be dropped as the memcmp() here doesn't mean
"starts with" but "is identical" (due to the "ce_namelen(ce) == 11" in
the line above).
