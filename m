From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH] setup.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 17:34:24 +0100
Message-ID: <200802081734.24967.barra_cuda@katamail.com>
References: <20080208142702.GY25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 17:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNW44-0005XG-Q9
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYBHQZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbYBHQZ6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:25:58 -0500
Received: from smtp.katamail.com ([62.149.157.154]:57221 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753494AbYBHQZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:25:57 -0500
Received: (qmail 30170 invoked by uid 89); 8 Feb 2008 16:25:29 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host116-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.116)
  by smtp1-pc with SMTP; 8 Feb 2008 16:25:28 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <20080208142702.GY25954@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73107>

On Friday 08 February 2008, Miklos Vajna wrote:
> diff --git a/setup.c b/setup.c
> index adede16..361825f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -346,13 +346,13 @@ int git_config_perm(const char *var, const char *value)
>  {
>  	if (value) {
            ^^^^^
value is already checked here. No need to check further.

>  		int i;
> -		if (!strcmp(value, "umask"))
> +		if (value && !strcmp(value, "umask"))
>  			return PERM_UMASK;
> -		if (!strcmp(value, "group"))
> +		if (value && !strcmp(value, "group"))
>  			return PERM_GROUP;
> -		if (!strcmp(value, "all") ||
> +		if (value && (!strcmp(value, "all") ||
>  		    !strcmp(value, "world") ||
> -		    !strcmp(value, "everybody"))
> +		    !strcmp(value, "everybody")))
>  			return PERM_EVERYBODY;
>  		i = atoi(value);
>  		if (i > 1)
