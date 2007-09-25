From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't use "<unknown>" for unknown values of placeholders
 and suppress printing of empty user formats.
Date: Tue, 25 Sep 2007 15:47:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251543561.28395@racer.site>
References: <20070925143846.GQ22869@mageo.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBiJ-00046u-QV
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbXIYOsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbXIYOsW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:48:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:49702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753630AbXIYOsV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:48:21 -0400
Received: (qmail invoked by alias); 25 Sep 2007 14:48:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 25 Sep 2007 16:48:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WhtlybgXWwimYtH56A+hgzUZBC9kwlKGMqwDUqx
	5wQaqSrYHC7NYD
X-X-Sender: gene099@racer.site
In-Reply-To: <20070925143846.GQ22869@mageo.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59130>

Hi,

On Tue, 25 Sep 2007, Michal Vitecek wrote:

> ---
> 
>  Sending the patch again in correct form (hopefully) as instructed by
>  Johannes Schindelin. Sorry for the hassle.

Thanks.

> diff --git a/commit.c b/commit.c
> index 99f65ce..c9a1818 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -917,9 +917,6 @@ long format_commit_message(const struct commit *commit, const void *format,
>  	}
>  	if (msg[i])
>  		table[IBODY].value = xstrdup(msg + i);
> -	for (i = 0; i < ARRAY_SIZE(table); i++)
> -		if (!table[i].value)
> -			interp_set_entry(table, i, "<unknown>");

This may have warranted a description in the commit message a la

	Instead of setting unknown entries to "<unknown>" in the 
	interp_table, we teach interpolate() to replace entries with 
	NULL values by the empty string.

> diff --git a/log-tree.c b/log-tree.c
> index a642371..79502f4 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -175,14 +175,15 @@ void show_log(struct rev_info *opt, const char *sep)
>  	 *  - The pretty-printed commit lacks a newline at the end
>  	 *    of the buffer, but we do want to make sure that we
>  	 *    have a newline there. If the separator isn't already
> -	 *    a newline, add an extra one.
> +         *    a newline, add an extra one and do the same for the
> +         *    user format as well.

Here are still spaces instead of tabs.

These are only minor details; I don't know if Junio wants to fix them 
himself.

Ciao,
Dscho
