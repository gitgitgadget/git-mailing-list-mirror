From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Simplify crud() in ident.c
Date: Mon, 3 Dec 2007 20:47:09 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712032046480.27959@racer.site>
References: <20071203191143.GB17671@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 21:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzICq-0006p5-9t
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 21:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbXLCUrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 15:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbXLCUrf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 15:47:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:53929 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750885AbXLCUre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 15:47:34 -0500
Received: (qmail invoked by alias); 03 Dec 2007 20:47:32 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp019) with SMTP; 03 Dec 2007 21:47:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19leC0wk4VlhABSVsUegqMOuSxRPO8tcrjjhxi6wT
	WzYFxqayTxrRpk
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203191143.GB17671@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66953>

Hi,

On Mon, 3 Dec 2007, Alex Riesen wrote:

> diff --git a/ident.c b/ident.c
> index 9b2a852..dbd0f52 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -113,25 +113,15 @@ static int add_raw(char *buf, size_t size, int offset, const char *str)
>  
>  static int crud(unsigned char c)
>  {
> -	static char crud_array[256];
> -	static int crud_array_initialized = 0;
> -
> -	if (!crud_array_initialized) {
> -		int k;
> -
> -		for (k = 0; k <= 31; ++k) crud_array[k] = 1;
> -		crud_array[' '] = 1;
> -		crud_array['.'] = 1;
> -		crud_array[','] = 1;
> -		crud_array[':'] = 1;
> -		crud_array[';'] = 1;
> -		crud_array['<'] = 1;
> -		crud_array['>'] = 1;
> -		crud_array['"'] = 1;
> -		crud_array['\''] = 1;
> -		crud_array_initialized = 1;
> -	}
> -	return crud_array[c];
> +	return  c <= 32  ||
> +		c == '.' ||
> +		c == ',' ||
> +		c == ':' ||
> +		c == ';' ||
> +		c == '<' ||
> +		c == '>' ||
> +		c == '"' ||
> +		c == '\'';

Or enhance ctype.c.

Ciao,
Dscho
