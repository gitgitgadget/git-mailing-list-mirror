From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: take the first populated line of the
 description
Date: Wed, 5 Mar 2008 15:48:00 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803051544160.15786@racer.site>
References: <1204727050.0@pinky>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuvB-0004Z4-FP
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbYCEOsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 09:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYCEOsD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:48:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:34233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752047AbYCEOsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 09:48:00 -0500
Received: (qmail invoked by alias); 05 Mar 2008 14:47:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 05 Mar 2008 15:47:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196SiwalXl6bl8TcwdJ+4cV5KIK+1Gh8gT/02oCpW
	h/uFnLSG8nC8cp
X-X-Sender: gene099@racer.site
In-Reply-To: <1204727050.0@pinky>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76224>

Hi,

On Wed, 5 Mar 2008, Andy Whitcroft wrote:

> diff --git a/builtin-shortlog.c b/builtin-shortlog.c
> index af31aba..b22b0ed 100644
> --- a/builtin-shortlog.c
> +++ b/builtin-shortlog.c
> @@ -70,11 +70,12 @@ static void insert_one_record(struct shortlog *log,
>  	else
>  		free(buffer);
>  
> +	/* Skip any leading whitespace, including any blank lines. */
> +	while (*oneline && isspace(*oneline))
> +		oneline++;
>  	eol = strchr(oneline, '\n');
>  	if (!eol)
>  		eol = oneline + strlen(oneline);
> -	while (*oneline && isspace(*oneline) && *oneline != '\n')
> -		oneline++;
>  	if (!prefixcmp(oneline, "[PATCH")) {
>  		char *eob = strchr(oneline, ']');
>  		if (eob && (!eol || eob < eol))

Why do you move the code around?  Makes it harder to read your patch.  
Besides, you now strip empty lines at the beginning of the commit 
messages, right?  Who produces such a thing?

Ciao,
Dscho

