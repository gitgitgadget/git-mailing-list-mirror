From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/11] Fix build failure at VC because function declare
 use old style at regex.c
Date: Mon, 17 Aug 2009 18:26:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171822130.4991@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, kusmabite@gmail.com, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:26:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md52k-0000TO-IT
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbZHQQ0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbZHQQ0i
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:26:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:44545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751051AbZHQQ0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:26:38 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:26:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 17 Aug 2009 18:26:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AZDE/NYqAKCccjI8P5JTE6niQeYHRaRLjIfNsN+
	xjaHpqeTAfR/iu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126218>

Hi,

reading "X-Mailer: git-send-email 1.6.4.msysgit.0" gave me a buzz... well 
done, Erik!

On Tue, 18 Aug 2009, Frank Li wrote:

> regerror declare function argument type after function define.
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>

How about

	Avoid a K&R style function definition in regex.c

	Microsoft Visual C++ does not understand K&R notation; use C89 
	style instead.

?

> diff --git a/compat/regex/regex.c b/compat/regex/regex.c
> index 5ea0075..5728de1 100644
> --- a/compat/regex/regex.c
> +++ b/compat/regex/regex.c
> @@ -4852,11 +4852,7 @@ regexec (preg, string, nmatch, pmatch, eflags)
>     from either regcomp or regexec.   We don't use PREG here.  */
>  
>  size_t
> -regerror (errcode, preg, errbuf, errbuf_size)
> -    int errcode;
> -    const regex_t *preg;
> -    char *errbuf;
> -    size_t errbuf_size;
> +regerror (int errcode, const regex_t * preg, char * errbuf,size_t errbuf_size)

A cursory look over regex.c gives me the impression that

- it tries to stick to maximally 80 characters per line,
- there is no space after a * indicating a pointer,
- there are spaces after all commas,
- there are a lot more functions with K&R style function definitions than 
  just regerror().

Ciao,
Dscho
