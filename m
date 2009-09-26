From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove various dead assignments and dead increments
 found by the clang static analyzer
Date: Sat, 26 Sep 2009 17:58:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
References: <87ab0hepcn.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 17:57:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrZdy-00018V-K0
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 17:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbZIZP4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZIZP4f
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 11:56:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:37402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752927AbZIZP4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 11:56:35 -0400
Received: (qmail invoked by alias); 26 Sep 2009 15:56:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 26 Sep 2009 17:56:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EixR52OBE30J5Zgw/z9XV1g+p2QekcNoLE5/I/S
	qwM3lI9ndOYWOX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ab0hepcn.fsf@master.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129158>

Hi,

On Sat, 26 Sep 2009, Giuseppe Scrivano wrote:

> I tried the clang static analyzer on the git source code, this patch
> fixes the found dead assignments/increments.
> 
> diff --git a/archive.c b/archive.c
> index 73b8e8a..88feed7 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -357,7 +357,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
>  	const struct archiver *ar = NULL;
>  	struct archiver_args args;
>  
> -	argc = parse_archive_args(argc, argv, &ar, &args);
> +	parse_archive_args(argc, argv, &ar, &args);
>  	if (setup_prefix && prefix == NULL)
>  		prefix = setup_git_directory();

I understand that clang complains when argc is not really used afterwards, 
but do we really want to do this?  I mean, if somebody decides it'd be a 
good idea to check the number of arguments after parsing the arguments, 
they might be bitten by the fact that it is now actively wrong.

Ciao,
Dscho
